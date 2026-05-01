#!/usr/bin/env bashio
set -e

bashio::log.info "Starting Ubooquity add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}"

bashio::log.info "Data location: ${LOCATION}"

if bashio::config.has_value 'MAXMEM'; then
    MAXMEM_VAL="$(bashio::config 'MAXMEM')"
    if [ -n "${MAXMEM_VAL}" ] && [ "${MAXMEM_VAL}" != "null" ]; then
        export MAXMEM="${MAXMEM_VAL}"
        bashio::log.info "Max memory set to ${MAXMEM}MB"
    fi
fi

if bashio::config.has_value 'DOCKER_MODS'; then
    MODS="$(bashio::config 'DOCKER_MODS' | jq -r 'if type == "array" then join("|") else . end')"
    if [ -n "${MODS}" ] && [ "${MODS}" != "null" ]; then
        export DOCKER_MODS="${MODS}"
        bashio::log.info "Docker mods enabled: ${MODS}"
    fi
fi

bashio::log.info "Ubooquity initialization complete"
