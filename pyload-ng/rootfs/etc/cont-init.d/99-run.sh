#!/usr/bin/env bashio
set -e

bashio::log.info "Starting pyLoad-ng add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}/config" \
    "${LOCATION}/downloads"

bashio::log.info "Data location: ${LOCATION}"

bashio::log.info "pyLoad-ng initialization complete"
