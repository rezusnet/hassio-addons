#!/usr/bin/env bashio
set +u

bashio::log.info "Starting PairDrop add-on initialization"

LOCATION="$(bashio::config 'data_location')"
if [[ "$LOCATION" = "null" || -z "$LOCATION" ]]; then LOCATION=/config; fi
DEBUG_MODE="$(bashio::config 'debug_mode')"
export DEBUG_MODE

mkdir -p "$LOCATION"

bashio::log.info "Data location: ${LOCATION}"
bashio::log.info "PairDrop initialization complete"
