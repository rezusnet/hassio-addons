#!/usr/bin/env bashio
set -e

bashio::log.info "Starting Syslog-ng add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}/config" \
    "${LOCATION}/logs" \
    "${LOCATION}/data"

bashio::log.info "Data location: ${LOCATION}"
bashio::log.info "Syslog-ng listening on UDP 514, TCP 514, and TLS 601"
bashio::log.info "Syslog-ng initialization complete"
