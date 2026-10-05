#!/usr/bin/env bash
# shellcheck shell=bash disable=SC2154,SC1091
set -e

# bashio functions: always source the standalone shim directly — it is a
# compatibility layer meant to be sourced, not a script interpreter.
# shellcheck source=/dev/null
source /usr/local/lib/bashio-standalone.sh
# ==============================================================================
# Authentik add-on — bootstrap & supervision
#   authentik 2026.x needs only PostgreSQL (task queue = dramatiq with a
#   PG-backed broker; no Redis — see the image's own reference compose).
#   1. database: embedded PostgreSQL cluster in /data (default) or an
#      external server when the postgres_host option is set (e.g. the
#      alexbelgium postgres_17 add-on) — the database is auto-created if
#      missing
#   2. bootstrap: akadmin credentials are applied only when the target
#      schema is empty (authentik_user table absent), so pointing the
#      add-on at an already-initialized database can never reset akadmin
#   3. supervise `ak server` + `ak worker` as user 1000 (the ak wrapper
#      skips its chown/chpst dance when not run as root)
# ==============================================================================

PG_BIN="/usr/lib/postgresql/17/bin"
PG_DATA="/data/postgresql"
PG_LOG="/data/postgresql.log"
AK_DATA="/data/authentik"
SECRET_KEY_FILE="${AK_DATA}/secret_key"
CREDS_FILE="${AK_DATA}/admin_credentials.txt"
BOOTSTRAP_MARK="${AK_DATA}/.bootstrapped"

if bashio::config.has_value 'postgres_host'; then
    EXTERNAL_DB=true
else
    EXTERNAL_DB=false
fi

mkdir -p "${AK_DATA}"
# /data must be writable by the authentik user (upstream writes state
# directly under /data).
chown 1000:0 /data
chown -R 1000:0 "${AK_DATA}"

if [ "${EXTERNAL_DB}" != "true" ]; then
    mkdir -p "${PG_DATA}"
    chown postgres:postgres "${PG_DATA}"
    chmod 700 "${PG_DATA}"
    touch "${PG_LOG}"
    chown postgres:postgres "${PG_LOG}"
    if [ ! -f "${PG_DATA}/PG_VERSION" ]; then
        bashio::log.info "Initializing embedded PostgreSQL cluster in ${PG_DATA}"
        # Local-only trust auth: PostgreSQL listens on 127.0.0.1 inside this
        # container only; the role owns the instance from the start.
        runuser -u postgres -- "${PG_BIN}/initdb" -D "${PG_DATA}" -U authentik \
            -E UTF8 --locale=C.UTF-8 -A trust > /dev/null
    fi
fi

if [ ! -f "${SECRET_KEY_FILE}" ]; then
    # authentik requires a secret key of at least 50 characters.
    head -c 64 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 60 > "${SECRET_KEY_FILE}"
    chown 1000:0 "${SECRET_KEY_FILE}"
    chmod 600 "${SECRET_KEY_FILE}"
    bashio::log.info "Generated authentik secret key"
fi

# ---------------------------------------------------------------- #
# Database up + database present
# ---------------------------------------------------------------- #
PSQL="${PG_BIN}/psql"
if [ "${EXTERNAL_DB}" = "true" ]; then
    DB_HOST="$(bashio::config 'postgres_host')"
    DB_PORT="$(bashio::config 'postgres_port')"
    DB_USER="$(bashio::config 'postgres_user')"
    DB_PASS="$(bashio::config 'postgres_password')"
    DB_NAME="$(bashio::config 'postgres_db')"
    export PGPASSWORD="${DB_PASS}"
    PSQL_ARGS=(-h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}")

    bashio::log.info "Using external PostgreSQL at ${DB_HOST}:${DB_PORT} (db: ${DB_NAME})"
    for _ in $(seq 1 30); do
        if "${PG_BIN}/pg_isready" "${PSQL_ARGS[@]}" -d postgres > /dev/null 2>&1; then
            break
        fi
        sleep 2
    done
    if ! "${PG_BIN}/pg_isready" "${PSQL_ARGS[@]}" -d postgres > /dev/null 2>&1; then
        bashio::exit.nok "external PostgreSQL at ${DB_HOST}:${DB_PORT} is not reachable"
    fi

    if ! "${PSQL}" "${PSQL_ARGS[@]}" -d postgres -tAc \
        "SELECT 1 FROM pg_database WHERE datname='${DB_NAME}'" | grep -q 1; then
        bashio::log.info "Creating database ${DB_NAME} on the external server"
        "${PSQL}" "${PSQL_ARGS[@]}" -d postgres -qc "CREATE DATABASE ${DB_NAME}"
    fi

    export AUTHENTIK_POSTGRESQL__HOST="${DB_HOST}"
    export AUTHENTIK_POSTGRESQL__PORT="${DB_PORT}"
    export AUTHENTIK_POSTGRESQL__NAME="${DB_NAME}"
    export AUTHENTIK_POSTGRESQL__USER="${DB_USER}"
    export AUTHENTIK_POSTGRESQL__PASSWORD="${DB_PASS}"
else
    bashio::log.info "Starting embedded PostgreSQL"
    runuser -u postgres -- "${PG_BIN}/pg_ctl" -D "${PG_DATA}" -l "${PG_LOG}" \
        -o "-c listen_addresses=127.0.0.1" -w start > /dev/null

    if ! "${PSQL}" -h 127.0.0.1 -U authentik -d postgres -tAc \
        "SELECT 1 FROM pg_database WHERE datname='authentik'" | grep -q 1; then
        bashio::log.info "Creating authentik database"
        "${PSQL}" -h 127.0.0.1 -U authentik -d postgres -qc 'CREATE DATABASE authentik'
    fi

    export AUTHENTIK_POSTGRESQL__HOST=127.0.0.1
    export AUTHENTIK_POSTGRESQL__PORT=5432
    export AUTHENTIK_POSTGRESQL__NAME=authentik
    export AUTHENTIK_POSTGRESQL__USER=authentik
    export AUTHENTIK_POSTGRESQL__PASSWORD=""
fi

# ---------------------------------------------------------------- #
# Bootstrap: apply akadmin credentials ONLY on an empty schema
# ---------------------------------------------------------------- #
# The authentik_core_user table is created by the very first migration
# run, so its absence means this database has never seen authentik. This
# keeps a fresh database bootstrap-able while making it impossible to
# reset akadmin on an existing one (AUTHENTIK_BOOTSTRAP_* resets the
# password on every start where it is set).
TABLE_COUNT_SQL="SELECT count(*) FROM information_schema.tables WHERE table_schema='public' AND table_name='authentik_core_user'"
if [ "${EXTERNAL_DB}" = "true" ]; then
    TABLE_COUNT="$("${PSQL}" "${PSQL_ARGS[@]}" -d "${AUTHENTIK_POSTGRESQL__NAME}" -tAc "${TABLE_COUNT_SQL}" | tr -d '[:space:]')"
else
    TABLE_COUNT="$("${PSQL}" -h 127.0.0.1 -U authentik -d authentik -tAc "${TABLE_COUNT_SQL}" | tr -d '[:space:]')"
fi
FRESH=$([ "${TABLE_COUNT}" = "0" ] && echo true || echo false)

BOOTSTRAP_EMAIL=""
BOOTSTRAP_PASSWORD=""
if [ "${FRESH}" = "true" ]; then
    BOOTSTRAP_EMAIL="$(bashio::config 'admin_email')"
    if ! bashio::config.has_value 'admin_password'; then
        BOOTSTRAP_PASSWORD="$(head -c 32 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 24)"
        bashio::log.warning "admin_password option is empty — generated a random akadmin password"
    else
        BOOTSTRAP_PASSWORD="$(bashio::config 'admin_password')"
    fi
    {
        echo "Authentik — auto-generated first-run akadmin credentials"
        echo "user: akadmin"
        echo "email: ${BOOTSTRAP_EMAIL}"
        echo "password: ${BOOTSTRAP_PASSWORD}"
        echo
        echo "Log in, change the password in the UI, then delete this file."
    } > "${CREDS_FILE}"
    chown 1000:0 "${CREDS_FILE}"
    chmod 600 "${CREDS_FILE}"
    bashio::log.warning "empty database detected — bootstrap will create akadmin; credentials written to ${CREDS_FILE} (data/authentik/admin_credentials.txt)"
    # The marker exists only until the first successful boot; it is
    # removed below once the web tier reports ready.
    echo "pending" > "${BOOTSTRAP_MARK}"
    chown 1000:0 "${BOOTSTRAP_MARK}"
else
    bashio::log.info "Existing database detected — bootstrap skipped (admin_password/admin_email ignored)"
fi

if [ -f "${BOOTSTRAP_MARK}" ] && [ -n "${BOOTSTRAP_EMAIL}" ]; then
    export AUTHENTIK_BOOTSTRAP_EMAIL="${BOOTSTRAP_EMAIL}"
    export AUTHENTIK_BOOTSTRAP_PASSWORD="${BOOTSTRAP_PASSWORD}"
fi

# ---------------------------------------------------------------- #
# Authentik environment (options → AUTHENTIK_* env)
# ---------------------------------------------------------------- #
# Read an option that is guaranteed boolean-typed as a literal true/false
# string — bashio::config cannot return `false` (jq `// empty` swallows
# it) and authentik's Rust config parser rejects empty strings for booleans.
option_bool() {
    jq -rn --arg k "$1" '$k as $k | input | if (.[$k] == true) then "true" else "false" end' /data/options.json
}

AUTHENTIK_SECRET_KEY="$(cat "${SECRET_KEY_FILE}")"
export AUTHENTIK_SECRET_KEY
AUTHENTIK_ERROR_REPORTING__ENABLED="$(option_bool error_reporting)"
export AUTHENTIK_ERROR_REPORTING__ENABLED
export AUTHENTIK_DISABLE_UPDATE_CHECK=true
export AUTHENTIK_DISABLE_STARTUP_ANALYTICS=true

if bashio::config.has_value 'email_host'; then
    AUTHENTIK_EMAIL__HOST="$(bashio::config 'email_host')"
    export AUTHENTIK_EMAIL__HOST
    AUTHENTIK_EMAIL__PORT="$(bashio::config 'email_port')"
    export AUTHENTIK_EMAIL__PORT
    AUTHENTIK_EMAIL__USERNAME="$(bashio::config 'email_username')"
    export AUTHENTIK_EMAIL__USERNAME
    AUTHENTIK_EMAIL__PASSWORD="$(bashio::config 'email_password')"
    export AUTHENTIK_EMAIL__PASSWORD
    AUTHENTIK_EMAIL__FROM="$(bashio::config 'email_from')"
    export AUTHENTIK_EMAIL__FROM
    AUTHENTIK_EMAIL__USE_TLS="$(option_bool email_use_tls)"
    export AUTHENTIK_EMAIL__USE_TLS
    AUTHENTIK_EMAIL__USE_SSL="$(option_bool email_use_ssl)"
    export AUTHENTIK_EMAIL__USE_SSL
fi

# Custom environment variables (list of {name, value}) — forwarded to the
# authentik processes (any AUTHENTIK_* config key can be set this way).
while IFS=$'\t' read -r env_name env_value; do
    [ -n "${env_name}" ] || continue
    export "${env_name}=${env_value}"
    bashio::log.info "Custom env var set: ${env_name}"
done < <(jq -r '(.env_vars // []) | .[] | [(.name // ""), (.value // "")] | @tsv' /data/options.json)

# ---------------------------------------------------------------- #
# Supervision: ak server + ak worker, PostgreSQL shutdown on exit
# ---------------------------------------------------------------- #
shutdown() {
    bashio::log.info "Shutting down authentik"
    kill -TERM "${SERVER_PID}" "${WORKER_PID:-}" 2> /dev/null || true
    for _ in $(seq 1 10); do
        if ! kill -0 "${SERVER_PID}" 2> /dev/null && ! kill -0 "${WORKER_PID}" 2> /dev/null; then
            break
        fi
        sleep 1
    done
    kill -KILL "${SERVER_PID}" "${WORKER_PID:-}" 2> /dev/null || true
    if [ "${EXTERNAL_DB}" != "true" ]; then
        runuser -u postgres -- "${PG_BIN}/pg_ctl" -D "${PG_DATA}" -m fast -w stop > /dev/null 2>&1 || true
    fi
    exit "${1:-0}"
}
trap 'shutdown 0' TERM INT

bashio::log.info "Starting authentik server (web on port 9000)"
setpriv --reuid=authentik --regid=authentik --init-groups env HOME=/authentik /lifecycle/ak server &
SERVER_PID=$!

# Boot ordering: the server runs all migrations (system + Django) during
# startup. Starting the worker concurrently lets both race on the
# migration lock and one of them dies (observed with the upstream 2026.5.3
# binaries) — so the worker starts only after the server reports ready.
bashio::log.info "Waiting for server to become ready (first boot runs all migrations)"
READY=false
for _ in $(seq 1 120); do
    if ! kill -0 "${SERVER_PID}" 2> /dev/null; then
        bashio::log.error "authentik server exited during startup"
        shutdown 1
    fi
    if curl -sf -o /dev/null http://127.0.0.1:9000/-/health/ready/; then
        READY=true
        break
    fi
    sleep 5
done
if [ "${READY}" != "true" ]; then
    bashio::log.error "server did not become ready within 600s"
    shutdown 1
fi
if [ -f "${BOOTSTRAP_MARK}" ]; then
    rm -f "${BOOTSTRAP_MARK}"
    bashio::log.info "Bootstrap complete — admin_password option will be ignored from now on"
fi

bashio::log.info "Starting authentik worker"
setpriv --reuid=authentik --regid=authentik --init-groups env HOME=/authentik /lifecycle/ak worker &
WORKER_PID=$!

# Parent liveness: ha_entrypoint runs this script as a foreground child and
# does not forward signals — when it is gone (docker stop path) our PPID
# becomes 1, which is the shutdown trigger. /proc is used because the
# upstream image ships no procps. A dead server/worker restarts the whole
# container via the add-on watchdog instead of half-running.
while :; do
    sleep 2
    if ! kill -0 "${SERVER_PID}" 2> /dev/null; then
        bashio::log.error "authentik server exited unexpectedly"
        shutdown 1
    fi
    if ! kill -0 "${WORKER_PID}" 2> /dev/null; then
        bashio::log.error "authentik worker exited unexpectedly"
        shutdown 1
    fi
    if [ "$(awk '{print $4}' /proc/self/stat)" = "1" ]; then
        bashio::log.info "Container stop detected"
        shutdown 0
    fi
done
