#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

if bashio::config.true 'silent'; then
    APPEND=' > /dev/null'
    sed -i '$s|$|'"$APPEND"'|' /etc/services.d/*/run &> /dev/null || true
    sed -i '$s|$|'"$APPEND"'|' /etc/cont-init.d/*/*run* &> /dev/null || true
    bashio::log.info 'Silent mode activated'
fi
