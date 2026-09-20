#!/usr/bin/env bashio
# shellcheck shell=bash disable=SC2034,SC2086
set -e

bashio::log.info "Starting Rreading Glasses add-on initialization"

PGDATA="/data/postgres"
PGUSER="postgres"
PGRUN="/var/run/postgresql"

SOURCE="$(bashio::config 'source')"
PORT="$(bashio::config 'port')"

EXTERNAL_PG=false
if bashio::config.has_value 'postgres_host'; then
    EXTERNAL_PG=true
    PG_HOST="$(bashio::config 'postgres_host')"
    PG_PORT="$(bashio::config 'postgres_port')"
    PG_USER="$(bashio::config 'postgres_user')"
    PG_PASS="$(bashio::config 'postgres_password')"
    PG_DB="$(bashio::config 'postgres_database')"
    bashio::log.info "Using external PostgreSQL at ${PG_HOST}:${PG_PORT}"
else
    bashio::log.info "Using bundled PostgreSQL"

    mkdir -p "${PGDATA}" "${PGRUN}"
    chown -R "${PGUSER}:${PGUSER}" "${PGDATA}" "${PGRUN}"

    if [ ! -f "${PGDATA}/PG_VERSION" ]; then
        bashio::log.info "Initializing PostgreSQL database..."
        su-exec "${PGUSER}" initdb -D "${PGDATA}" --auth=trust --encoding=UTF8 2>&1 || true
    fi

    PG_HOST="localhost"
    PG_PORT=5432
    PG_USER="rreading-glasses"
    PG_PASS=""
    PG_DB="rreading-glasses"

    bashio::log.info "Starting PostgreSQL..."
    su-exec "${PGUSER}" pg_ctl start -D "${PGDATA}" -l "${PGDATA}/pg.log" -o "-p ${PG_PORT}" -w 2>&1

    if ! su-exec "${PGUSER}" psql -p "${PG_PORT}" -lqt 2> /dev/null | cut -d '|' -f 1 | grep -qw "${PG_DB}"; then
        bashio::log.info "Creating database and user..."
        su-exec "${PGUSER}" psql -p "${PG_PORT}" -c "CREATE USER \"${PG_USER}\";" 2> /dev/null || true
        su-exec "${PGUSER}" psql -p "${PG_PORT}" -c "CREATE DATABASE \"${PG_DB}\" OWNER \"${PG_USER}\";" 2> /dev/null || true
    fi
fi

ARGS="serve --port ${PORT}"

if [ "${SOURCE}" = "goodreads" ]; then
    ARGS="${ARGS} --upstream=www.goodreads.com"
    bashio::log.info "Metadata source: GoodReads"
else
    ARGS="${ARGS} --upstream=hardcover.bookinfo.pro"
    bashio::log.info "Metadata source: Hardcover"
fi

if bashio::config.true 'verbose'; then
    ARGS="${ARGS} --verbose"
fi

export POSTGRES_HOST="${PG_HOST}"
export POSTGRES_PORT="${PG_PORT}"
export POSTGRES_USER="${PG_USER}"
export POSTGRES_PASSWORD="${PG_PASS}"
export POSTGRES_DATABASE="${PG_DB}"

if bashio::config.has_value 'hardcover_auth' && [ "${SOURCE}" = "hardcover" ]; then
    HARDCOVER_AUTH="$(bashio::config 'hardcover_auth')"
    export HARDCOVER_AUTH
    bashio::log.info "Hardcover auth token configured"
fi

if bashio::config.has_value 'env_vars'; then
    bashio::log.info "Setting custom environment variables"
    ENV_VARS="$(bashio::config 'env_vars')"
    for env_var in ${ENV_VARS}; do
        VAR_NAME="$(echo "${env_var}" | jq -r '.name')"
        VAR_VALUE="$(echo "${env_var}" | jq -r '.value // empty')"
        if [ -n "${VAR_NAME}" ] && [ -n "${VAR_VALUE}" ]; then
            export "${VAR_NAME}=${VAR_VALUE}"
            bashio::log.info "Set env var: ${VAR_NAME}"
        fi
    done
fi

bashio::log.info "Starting Rreading Glasses on port ${PORT}..."
exec /usr/bin/rreading-glasses ${ARGS}
