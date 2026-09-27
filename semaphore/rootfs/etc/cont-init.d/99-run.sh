#!/usr/bin/env bash
# shellcheck shell=bash disable=SC2154,SC1091
set -e

# bashio functions: always source the standalone shim directly. It is a
# compatibility layer meant to be sourced — using it as a script
# interpreter (shebang) only worked accidentally without a Supervisor.
# shellcheck source=/dev/null
source /usr/local/lib/bashio-standalone.sh
# ==============================================================================
# Semaphore UI add-on — bootstrap & supervision
#   1. first run: generate config.json directly + deterministic CLI bootstrap
#      (`semaphore migrate`, `semaphore users add`) — deliberately NOT the
#      interactive `setup` wizard, whose stdin flow changed between upstream
#      releases (v2.19.12 vs develop already differ)
#   2. every run: idempotently manage config.json fields from add-on options
#   3. exec the official server-wrapper as unprivileged user 1001 under tini
#      (wrapper skips its own setup because config.json exists, installs
#      additional pip requirements, then starts the server)
# ==============================================================================

DATA_DIR="/data/semaphore"
CONFIG_DIR="${DATA_DIR}"
CONFIG_FILE="${CONFIG_DIR}/config.json"
TMP_DIR="/data/tmp"
CRED_FILE="${DATA_DIR}/admin_credentials.txt"

# HAOS convention: the container listen port is fixed (supervisor maps the
# host side); users change the host port in the add-on network settings.
PORT="3000"
ADMIN_USERNAME="$(bashio::config 'admin_username')"
ADMIN_NAME="$(bashio::config 'admin_name')"
ADMIN_EMAIL="$(bashio::config 'admin_email')"
ADMIN_PASSWORD="$(bashio::config 'admin_password')"

mkdir -p "${CONFIG_DIR}" "${TMP_DIR}"
# The semaphore process runs as user 1001 — it must own its data tree.
chown -R 1001:0 /data 2> /dev/null || true

# ---------------------------------------------------------------- #
# First-run bootstrap: generate config.json + admin account
# ---------------------------------------------------------------- #
if [ ! -f "${CONFIG_FILE}" ]; then
    bashio::log.info "No config found — initializing new instance"

    # Session/credential keys: same format the wizard generates (base64 of
    # 32 random bytes), persisted in config.json so sessions and stored
    # credentials survive restarts. (No openssl in the runner image —
    # /dev/urandom + base64 it is.)
    rand_key() { head -c 32 /dev/urandom | base64; }
    COOKIE_HASH="$(rand_key)"
    COOKIE_ENCRYPTION="$(rand_key)"
    ACCESS_KEY_ENCRYPTION="$(rand_key)"

    jq -n \
        --arg dialect "sqlite" \
        --arg db_path "${DATA_DIR}/database.sqlite" \
        --arg tmp_path "${TMP_DIR}" \
        --arg cookie_hash "${COOKIE_HASH}" \
        --arg cookie_encryption "${COOKIE_ENCRYPTION}" \
        --arg access_key_encryption "${ACCESS_KEY_ENCRYPTION}" \
        '{dialect: $dialect,
          sqlite: {host: $db_path},
          tmp_path: $tmp_path,
          cookie_hash: $cookie_hash,
          cookie_encryption: $cookie_encryption,
          access_key_encryption: $access_key_encryption}' > "${CONFIG_FILE}"

    chown 1001:0 "${CONFIG_FILE}"
    bashio::log.info "Creating database schema"
    su-exec semaphore /usr/local/bin/semaphore migrate --config "${CONFIG_FILE}" > /dev/null \
        || bashio::exit.nok "semaphore migrate failed"

    GENERATED="false"
    if ! bashio::config.has_value 'admin_password'; then
        ADMIN_PASSWORD="$(head -c 24 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 24)"
        GENERATED="true"
        bashio::log.warning "admin_password option is empty — generated a random password"
    fi

    bashio::log.info "Creating admin user '${ADMIN_USERNAME}'"
    su-exec semaphore /usr/local/bin/semaphore users add \
        --config "${CONFIG_FILE}" \
        --admin \
        --login "${ADMIN_USERNAME}" \
        --name "${ADMIN_NAME}" \
        --email "${ADMIN_EMAIL}" \
        --password "${ADMIN_PASSWORD}" > /dev/null \
        || bashio::exit.nok "failed to create admin user"

    if [ "${GENERATED}" = "true" ]; then
        {
            echo "Semaphore UI — auto-generated first-run admin credentials"
            echo "user: ${ADMIN_USERNAME}"
            echo "password: ${ADMIN_PASSWORD}"
            echo
            echo "Log in, change the password in the UI, then delete this file."
        } > "${CRED_FILE}"
        chmod 600 "${CRED_FILE}"
        bashio::log.warning "credentials written to ${CRED_FILE} (data/semaphore/admin_credentials.txt)"
    fi
    unset ADMIN_PASSWORD
elif bashio::config.has_value 'admin_password' && [ ! -f "${CRED_FILE}" ]; then
    bashio::log.warning "admin_password is only used on first run — instance already initialized, ignoring"
fi

# ---------------------------------------------------------------- #
# Managed config: apply add-on options on every start (idempotent)
# ---------------------------------------------------------------- #
MANAGED_FIELDS=$(
    jq -n \
        --arg port ":${PORT}" \
        --arg max_parallel_tasks "$(bashio::config 'max_parallel_tasks')" \
        --arg non_admin_create "$(bashio::config 'non_admin_can_create_project')" \
        --arg password_login_disable "$(bashio::config 'password_login_disable')" \
        --arg email_alert "$(bashio::config 'email_alert')" \
        --arg email_sender "$(bashio::config 'email_sender')" \
        --arg email_host "$(bashio::config 'email_host')" \
        --arg email_port "$(bashio::config 'email_port')" \
        --arg email_username "$(bashio::config 'email_username')" \
        --arg email_password "$(bashio::config 'email_password')" \
        --arg email_secure "$(bashio::config 'email_secure')" \
        '{port: $port,
          max_parallel_tasks: ($max_parallel_tasks | tonumber),
          non_admin_can_create_project: ($non_admin_create == "true"),
          password_login_disable: ($password_login_disable == "true"),
          email_alert: ($email_alert == "true"),
          email_sender: $email_sender,
          email_host: $email_host,
          email_port: (if $email_port == "" then "587" else $email_port end),
          email_username: $email_username,
          email_password: $email_password,
          email_secure: ($email_secure == "true")}'
)

if jq --argjson managed "${MANAGED_FIELDS}" '. * $managed' "${CONFIG_FILE}" > "${CONFIG_FILE}.tmp"; then
    mv "${CONFIG_FILE}.tmp" "${CONFIG_FILE}"
else
    rm -f "${CONFIG_FILE}.tmp"
    bashio::exit.nok "failed to apply managed config fields"
fi

# Additional python requirements for playbooks (installed by the
# server-wrapper on every start).
if bashio::config.has_value 'additional_requirements'; then
    printf '%s\n' "$(bashio::config 'additional_requirements')" > "${CONFIG_DIR}/requirements.txt"
else
    rm -f "${CONFIG_DIR}/requirements.txt"
fi

chown -R 1001:0 /data 2> /dev/null || true

# Custom environment variables (list of {name, value}) — forwarded to the
# server process (e.g. provider credentials for playbooks).
while IFS=$'\t' read -r env_name env_value; do
    [ -n "${env_name}" ] || continue
    export "${env_name}=${env_value}"
    bashio::log.info "Custom env var set: ${env_name}"
done < <(jq -r '(.env_vars // []) | .[] | [(.name // ""), (.value // "")] | @tsv' /data/options.json)

export SEMAPHORE_CONFIG_PATH="${CONFIG_DIR}"
export SEMAPHORE_DB_PATH="${DATA_DIR}"
export SEMAPHORE_DB_DIALECT=sqlite
export SEMAPHORE_TMP_PATH="${TMP_DIR}"

bashio::log.info "Starting Semaphore UI on port ${PORT}"

# Hand over to the official wrapper as user 1001; tini keeps reaping
# ansible zombie processes.
exec su-exec semaphore /sbin/tini -- /usr/local/bin/server-wrapper
