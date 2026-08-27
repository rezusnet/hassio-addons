#!/usr/bin/env bashio
set -e

bashio::log.info "Starting Code Server add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}"

bashio::log.info "Data location: ${LOCATION}"

if bashio::config.has_value 'DOCKER_MODS'; then
    MODS="$(bashio::config 'DOCKER_MODS' | jq -r 'if type == "array" then join("|") else . end')"
    if [ -n "${MODS}" ] && [ "${MODS}" != "null" ]; then
        export DOCKER_MODS="${MODS}"
        bashio::log.info "Docker mods enabled: ${MODS}"
    fi
fi

if bashio::config.has_value 'PASSWORD'; then
    PASSWORD_VAL="$(bashio::config 'PASSWORD')"
    if [ -n "${PASSWORD_VAL}" ] && [ "${PASSWORD_VAL}" != "null" ]; then
        export PASSWORD="${PASSWORD_VAL}"
        bashio::log.info "Password authentication enabled"
    fi
fi

if bashio::config.has_value 'HASHED_PASSWORD'; then
    HASHED_PASSWORD_VAL="$(bashio::config 'HASHED_PASSWORD')"
    if [ -n "${HASHED_PASSWORD_VAL}" ] && [ "${HASHED_PASSWORD_VAL}" != "null" ]; then
        export HASHED_PASSWORD="${HASHED_PASSWORD_VAL}"
        bashio::log.info "Hashed password set"
    fi
fi

if bashio::config.has_value 'SUDO_PASSWORD'; then
    SUDO_PASSWORD_VAL="$(bashio::config 'SUDO_PASSWORD')"
    if [ -n "${SUDO_PASSWORD_VAL}" ] && [ "${SUDO_PASSWORD_VAL}" != "null" ]; then
        export SUDO_PASSWORD="${SUDO_PASSWORD_VAL}"
        bashio::log.info "Sudo password set"
    fi
fi

if bashio::config.has_value 'SUDO_PASSWORD_HASH'; then
    SUDO_PASSWORD_HASH_VAL="$(bashio::config 'SUDO_PASSWORD_HASH')"
    if [ -n "${SUDO_PASSWORD_HASH_VAL}" ] && [ "${SUDO_PASSWORD_HASH_VAL}" != "null" ]; then
        export SUDO_PASSWORD_HASH="${SUDO_PASSWORD_HASH_VAL}"
        bashio::log.info "Sudo password hash set"
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

bashio::log.info "Code Server initialization complete"
