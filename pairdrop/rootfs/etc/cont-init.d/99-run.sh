#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

bashio::log.info "Starting PairDrop add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if [[ "${LOCATION}" = "null" || -z "${LOCATION}" ]]; then
    LOCATION=/config
fi

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}"

if bashio::config.true 'rate_limit'; then
    export RATE_LIMIT="true"
    bashio::log.info "Rate limiting enabled"
else
    export RATE_LIMIT="false"
fi

if bashio::config.true 'ws_fallback'; then
    export WS_FALLBACK="true"
    bashio::log.info "WebSocket fallback enabled"
else
    export WS_FALLBACK="false"
fi

if bashio::config.true 'debug_mode'; then
    export DEBUG_MODE="true"
    bashio::log.warning "Debug mode enabled - client IPs will be logged"
else
    export DEBUG_MODE="false"
fi

bashio::log.info "PairDrop initialization complete"
