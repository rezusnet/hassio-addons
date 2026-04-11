#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

if ! bashio::supervisor.ping 2>/dev/null; then
    exit 0
fi

CONFIGSOURCE="/data/options.json"

if [ -f /config/config.yaml ]; then
    bashio::log.info "Custom config.yaml found, creating options"
    cp /config/config.yaml /config/config.yaml.bak 2>/dev/null || true
fi
