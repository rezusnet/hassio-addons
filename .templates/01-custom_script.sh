#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

CONFIGSOURCE="/config"
if [ -f "$CONFIGSOURCE"/script.sh ]; then
    bashio::log.info "Running custom script"
    "$CONFIGSOURCE"/script.sh
fi
