#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

JSONTOCHECK='/config/transmission/settings.json'
JSONSOURCE='/defaults/settings.json'

if [ -f "${JSONTOCHECK}" ]; then
    echo "Checking settings.json format"
    jq . -S "${JSONTOCHECK}" &> /dev/null && ERROR=false || ERROR=true
    if [ "$ERROR" = true ]; then
        bashio::log.fatal "Settings.json structure is abnormal, restoring from defaults"
        mv "${JSONSOURCE}" "${JSONSOURCE}"_old
        cp "${JSONSOURCE}" "${JSONTOCHECK}"
        exit 0
    fi
    bashio::log.info "Settings.json checked OK"
fi
