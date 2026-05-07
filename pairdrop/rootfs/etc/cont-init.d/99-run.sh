#!/usr/bin/env bashio
set +u

bashio::log.info "Starting PairDrop add-on"

LOCATION="$(bashio::config 'data_location')"
if [[ "$LOCATION" = "null" || -z "$LOCATION" ]]; then LOCATION=/config; fi
RATE_LIMIT="$(bashio::config 'rate_limit')"
WS_FALLBACK="$(bashio::config 'ws_fallback')"
DEBUG_MODE="$(bashio::config 'debug_mode')"
export DEBUG_MODE

mkdir -p "$LOCATION"

ARGS=()
if [[ ${RATE_LIMIT,,} = "true" ]]; then
    ARGS+=("--rate-limit")
fi
if [[ ${WS_FALLBACK,,} = "true" ]]; then
    ARGS+=("--include-ws-fallback")
fi

bashio::log.info "Data location: ${LOCATION}"
bashio::log.info "Starting PairDrop server on port 3000..."

cd /app/pairdrop
exec node server/index.js "${ARGS[@]}"
