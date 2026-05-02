#!/usr/bin/env bashio
set -e

bashio::log.info "Starting Valkey add-on initialization"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

PORT="$(bashio::config 'port')"
DATABASES="$(bashio::config 'databases')"
SAVE_ENABLED="$(bashio::config 'save_enabled')"
MAXMEMORY="$(bashio::config 'maxmemory')"
MAXMEMORY_POLICY="$(bashio::config 'maxmemory_policy')"

CONF_FILE="/data/valkey.conf"

mkdir -p /data

{
    echo "port ${PORT}"
    echo "bind 0.0.0.0"
    echo "protected-mode no"
    echo "databases ${DATABASES}"
    echo "daemonize no"
    echo "logfile ''"
    echo "loglevel notice"
    echo "dir /data"

    if bashio::config.has_value 'password'; then
        PASSWORD="$(bashio::config 'password')"
        echo "requirepass ${PASSWORD}"
        bashio::log.info "Password authentication enabled"
    fi

    if [ "${SAVE_ENABLED}" = "true" ]; then
        echo "save 3600 1"
        echo "save 300 100"
        echo "save 60 10000"
        echo "dbfilename dump.rdb"
        bashio::log.info "RDB persistence enabled"
    else
        echo "save ''"
        bashio::log.info "RDB persistence disabled"
    fi

    if bashio::config.has_value 'maxmemory'; then
        echo "maxmemory ${MAXMEMORY}"
        echo "maxmemory-policy ${MAXMEMORY_POLICY}"
        bashio::log.info "Memory limit: ${MAXMEMORY}, policy: ${MAXMEMORY_POLICY}"
    fi
} > "${CONF_FILE}"

bashio::log.info "Configuration written to ${CONF_FILE}"
bashio::log.info "Valkey will listen on port ${PORT}"
bashio::log.info "Valkey initialization complete"

exec valkey-server "${CONF_FILE}"
