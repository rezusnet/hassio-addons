#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

bashio::log.info "Starting PairDrop add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if [[ "${LOCATION}" = "null" || -z "${LOCATION}" ]]; then
    LOCATION=/config
fi

mkdir -p "${LOCATION}"

bashio::log.info "PairDrop initialization complete"
