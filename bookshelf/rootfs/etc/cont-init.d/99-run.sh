#!/usr/bin/env bashio
set -e

bashio::log.info "Starting Bookshelf add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

if bashio::config.has_value 'metadata_url'; then
    METADATA_URL="$(bashio::config 'metadata_url')"
    export METADATA_URL
    bashio::log.info "Metadata source: ${METADATA_URL}"
else
    bashio::log.info "Using default metadata source (api.bookinfo.pro)"
fi

mkdir -p "${LOCATION}/data"

bashio::log.info "Data location: ${LOCATION}"

bashio::log.info "Bookshelf initialization complete"
