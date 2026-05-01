#!/usr/bin/env bashio
set -e

bashio::log.info "Starting Ubooquity add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}/cache" \
    "${LOCATION}/log"

bashio::log.info "Data location: ${LOCATION}"

if bashio::config.has_value 'MAXMEM'; then
    MAXMEM_VAL="$(bashio::config 'MAXMEM')"
    if [ -n "${MAXMEM_VAL}" ] && [ "${MAXMEM_VAL}" != "null" ]; then
        export MAXMEM="${MAXMEM_VAL}"
        bashio::log.info "Max memory set to ${MAXMEM}MB"
    fi
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

if [ -d "${LOCATION}" ]; then
    DISK_AVAIL=$(df -h "${LOCATION}" | awk 'NR==2 {print $4}')
    DISK_TOTAL=$(df -h "${LOCATION}" | awk 'NR==2 {print $2}')
    bashio::log.info "Storage (${LOCATION}): ${DISK_AVAIL} available of ${DISK_TOTAL}"
fi

bashio::log.info "=== End Diagnostics ==="

bashio::log.info "Ubooquity initialization complete"
