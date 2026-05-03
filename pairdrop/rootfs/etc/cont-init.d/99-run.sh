#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

bashio::log.info "Starting PairDrop add-on initialization"

LOCATION="$(bashio::config 'data_location')"
if [[ "${LOCATION}" = "null" || -z "${LOCATION}" ]]; then
    LOCATION=/config
fi

mkdir -p "${LOCATION}"

export HOME="${LOCATION}"
export NODE_ENV="production"

if bashio::config.has_value 'TZ'; then
    export TZ="$(bashio::config 'TZ')"
fi

if bashio::config.true 'rate_limit'; then
    export RATE_LIMIT="true"
else
    export RATE_LIMIT="false"
fi

if bashio::config.true 'ws_fallback'; then
    export WS_FALLBACK="true"
else
    export WS_FALLBACK="false"
fi

if bashio::config.true 'debug_mode'; then
    export DEBUG_MODE="true"
else
    export DEBUG_MODE="false"
fi

cd /app/pairdrop || bashio::exit.nok "Cannot find /app/pairdrop"

bashio::log.info "Starting PairDrop on port 3000..."

exec /sbin/tini -s -- node server/index.js
