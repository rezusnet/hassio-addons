#!/usr/bin/env bash
# shellcheck shell=bash disable=SC2154,SC1091
set -e

# bashio functions: always source the standalone shim directly — it is a
# compatibility layer meant to be sourced, not a script interpreter.
# shellcheck source=/dev/null
source /usr/local/lib/bashio-standalone.sh
# ==============================================================================
# Authelia add-on — first-run generation & startup
#   Authelia is a single static binary: SQLite storage, in-memory sessions
#   (no Redis) and a filesystem notifier are enough for a HAOS-scale
#   instance. Config space is far larger than any option schema, so the
#   add-on generates /data/configuration.yml and /data/users_database.yml
#   ONCE from the options (plus generated secrets) and then leaves them to
#   the user — edit files, not options, after first boot.
# ==============================================================================

DATA_DIR="/data"
SECRETS_DIR="${DATA_DIR}/secrets"
CONFIG_FILE="${DATA_DIR}/configuration.yml"
USERS_FILE="${DATA_DIR}/users_database.yml"

mkdir -p "${SECRETS_DIR}"
chown -R 1000:0 "${DATA_DIR}"

# ---------------------------------------------------------------- #
# Secrets (generated once, injected via AUTHELIA_*_FILE env vars)
# ---------------------------------------------------------------- #
gen_secret() {
    head -c 80 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 60
}
for secret_name in session_secret storage_encryption_key jwt_secret; do
    secret_file="${SECRETS_DIR}/${secret_name}"
    if [ ! -f "${secret_file}" ]; then
        gen_secret > "${secret_file}"
        bashio::log.info "Generated ${secret_name}"
    fi
    chown 1000:0 "${secret_file}"
    chmod 600 "${secret_file}"
done

# ---------------------------------------------------------------- #
# Users database (generated once from the users option)
# ---------------------------------------------------------------- #
if [ ! -f "${USERS_FILE}" ]; then
    SESSION_DOMAIN="$(bashio::config 'session_domain')"
    USERS_COUNT="$(jq '(.users // []) | length' /data/options.json)"
    if [ "${USERS_COUNT}" -gt 0 ]; then
        bashio::log.info "Generating users database (${USERS_COUNT} user(s))"
        : > "${USERS_FILE}"
        echo "users:" >> "${USERS_FILE}"
        while IFS=$'\t' read -r user_name user_pass user_email user_groups; do
            [ -n "${user_name}" ] || continue
            user_hash="$(/app/authelia crypto hash generate --password "${user_pass}" argon2 2> /dev/null | sed -n 's/^Digest: //p')"
            [ -n "${user_hash}" ] || bashio::exit.nok "argon2 hash generation failed for user ${user_name}"
            {
                echo "  ${user_name}:"
                echo "    disabled: false"
                echo "    displayname: '${user_name}'"
                echo "    password: '${user_hash}'"
                echo "    email: '${user_email}'"
                if [ -n "${user_groups}" ]; then
                    echo "    groups:"
                    IFS=',' read -ra _grp <<< "${user_groups}"
                    for g in "${_grp[@]}"; do
                        [ -n "${g}" ] && echo "      - '${g}'"
                    done
                fi
            } >> "${USERS_FILE}"
            bashio::log.info "User added: ${user_name}"
        done < <(jq -r --arg domain "${SESSION_DOMAIN}" '(.users // [])[] | [(.username // ""), (.password // ""), (.email // "\(.username)@\($domain)"), ((.groups // []) | join(","))] | @tsv' /data/options.json)
    else
        bashio::log.warning "no users configured — writing a template users database; edit ${USERS_FILE} (password hashes: 'authelia crypto hash generate --password <pw> argon2')"
        # An empty users map fails authelia's startup schema check
        # ("users: non zero value required") — seed a disabled placeholder
        # with a random password so the instance boots; replace it with real
        # users.
        placeholder_hash="$(/app/authelia crypto hash generate --password "$(gen_secret)" argon2 2> /dev/null | sed -n 's/^Digest: //p')"
        cat > "${USERS_FILE}" << EOF
users:
  placeholder:
    disabled: true
    displayname: 'Placeholder (disabled)'
    password: '${placeholder_hash}'
    email: 'placeholder@${SESSION_DOMAIN}'
  # authelia:
  #   disabled: false
  #   displayname: 'Authelia User'
  #   password: '\$argon2id\$...'   # docker run --rm ghcr.io/authelia/authelia:4.39.28 crypto hash generate --password 'secret' argon2
  #   email: 'authelia@${SESSION_DOMAIN}'
  #   groups:
  #     - 'admins'
EOF
    fi
    chown 1000:0 "${USERS_FILE}"
    chmod 600 "${USERS_FILE}"
fi

# ---------------------------------------------------------------- #
# configuration.yml (generated once from options)
# ---------------------------------------------------------------- #
if [ ! -f "${CONFIG_FILE}" ]; then
    SESSION_DOMAIN="$(bashio::config 'session_domain')"
    AUTH_URL="$(bashio::config 'authelia_url')"
    THEME="$(bashio::config 'theme')"
    LOG_LEVEL="$(bashio::config 'log_level')"
    DEFAULT_POLICY="$(bashio::config 'default_policy')"
    if bashio::config.has_value 'default_redirection_url'; then
        REDIRECT_LINE="      default_redirection_url: '$(bashio::config 'default_redirection_url')'"
    else
        REDIRECT_LINE=""
    fi
    bashio::log.info "Generating initial configuration.yml (this file is yours afterwards — the add-on will not overwrite it)"
    cat > "${CONFIG_FILE}" << EOF
---
###############################################################
#             Authelia configuration (generated)             #
#   Generated once by the add-on from its options — edit     #
#   freely, changes survive restarts and updates.            #
#   Reference: https://www.authelia.com/configuration/       #
###############################################################

theme: '${THEME}'

server:
  address: 'tcp://0.0.0.0:9091'

log:
  level: '${LOG_LEVEL}'

totp:
  issuer: 'Authelia'

authentication_backend:
  file:
    path: '${USERS_FILE}'

access_control:
  default_policy: '${DEFAULT_POLICY}'
  rules: []
  # rules:
  #   - domain: 'public.${SESSION_DOMAIN}'
  #     policy: 'bypass'
  #   - domain: 'secure.${SESSION_DOMAIN}'
  #     policy: 'two_factor'

session:
  cookies:
    - name: 'authelia_session'
      domain: '${SESSION_DOMAIN}'
      authelia_url: '${AUTH_URL}'
${REDIRECT_LINE}
      expiration: '1 hour'
      inactivity: '5 minutes'

regulation:
  max_retries: 3
  find_time: '2 minutes'
  ban_time: '5 minutes'

storage:
  local:
    path: '${DATA_DIR}/db.sqlite3'

notifier:
  filesystem:
    filename: '${DATA_DIR}/notifications.txt'
EOF
    chown 1000:0 "${CONFIG_FILE}"
    chmod 600 "${CONFIG_FILE}"
else
    bashio::log.info "Existing configuration.yml found — leaving untouched"
fi

# ---------------------------------------------------------------- #
# Environment: secrets via *_FILE, custom env passthrough
# ---------------------------------------------------------------- #
export AUTHELIA_SESSION_SECRET_FILE="${SECRETS_DIR}/session_secret"
export AUTHELIA_STORAGE_ENCRYPTION_KEY_FILE="${SECRETS_DIR}/storage_encryption_key"
export AUTHELIA_IDENTITY_VALIDATION_RESET_PASSWORD_JWT_SECRET_FILE="${SECRETS_DIR}/jwt_secret"

# Custom environment variables (list of {name, value}) — forwarded to
# authelia (any AUTHELIA_* config key can be set this way).
while IFS=$'\t' read -r env_name env_value; do
    [ -n "${env_name}" ] || continue
    export "${env_name}=${env_value}"
    bashio::log.info "Custom env var set: ${env_name}"
done < <(jq -r '(.env_vars // []) | .[] | [(.name // ""), (.value // "")] | @tsv' /data/options.json)

# ---------------------------------------------------------------- #
# Validate & run (uid 1000, direct signals via exec)
# ---------------------------------------------------------------- #
bashio::log.info "Validating configuration"
if ! setpriv --reuid=1000 --regid=1000 --clear-groups /app/authelia validate-config --config "${CONFIG_FILE}"; then
    bashio::exit.nok "configuration invalid — fix ${CONFIG_FILE} (see errors above)"
fi

bashio::log.info "Starting Authelia (web on port 9091)"
exec setpriv --reuid=1000 --regid=1000 --clear-groups /app/authelia --config "${CONFIG_FILE}"
