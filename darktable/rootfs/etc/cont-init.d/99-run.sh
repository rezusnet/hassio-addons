#!/usr/bin/env bashio
set -e

bashio::log.info "Starting Darktable add-on initialization"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

bashio::log.info "=== Platform Diagnostics ==="

if [ -f /proc/device-tree/model ]; then
    PI_MODEL=$(tr -d '\0' < /proc/device-tree/model)
    bashio::log.info "Platform: ${PI_MODEL}"
elif [ -f /etc/rpi-issue ]; then
    bashio::log.info "Platform: Raspberry Pi (detected via /etc/rpi-issue)"
else
    bashio::log.info "Platform: Generic (non-Pi)"
fi

if [ -f /proc/meminfo ]; then
    TOTAL_MEM=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    AVAIL_MEM=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    bashio::log.info "Memory: ${TOTAL_MEM} kB total, ${AVAIL_MEM} kB available"
fi

bashio::log.info "=== End Diagnostics ==="

bashio::log.info "Darktable initialization complete"
