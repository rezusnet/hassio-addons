#!/usr/bin/env bashio
set -e

bashio::log.info "Starting LDAP Auth add-on initialization"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

bashio::log.info "LDAP Auth initialization complete"
