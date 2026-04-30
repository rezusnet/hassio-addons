#!/usr/bin/env bashio
set -e

bashio::log.info "Starting COPS add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}"

bashio::log.info "Data location: ${LOCATION}"

bashio::log.info "COPS initialization complete"
