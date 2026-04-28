#!/usr/bin/env bashio
set -e

bashio::log.info "Starting Jellyfin add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}/cache" \
    "${LOCATION}/log" \
    "${LOCATION}/transcode" \
    "${LOCATION}/data"

bashio::log.info "Data location: ${LOCATION}"

if bashio::config.has_value 'DOCKER_MODS'; then
    MODS="$(bashio::config 'DOCKER_MODS' | jq -r 'if type == "array" then join("|") else . end')"
    if [ -n "${MODS}" ] && [ "${MODS}" != "null" ]; then
        export DOCKER_MODS="${MODS}"
        bashio::log.info "Docker mods enabled: ${MODS}"
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

video_devices=(/dev/video*)
if [ -e "${video_devices[0]}" ]; then
    bashio::log.info "Video devices: ${video_devices[*]}"
else
    bashio::log.info "No /dev/video* devices found"
fi

media_devices=(/dev/media*)
if [ -e "${media_devices[0]}" ]; then
    bashio::log.info "Media devices: ${media_devices[*]}"
else
    bashio::log.info "No /dev/media* devices found"
fi

if [ -d /dev/dri ]; then
    dri_devices=(/dev/dri/*)
    if [ -e "${dri_devices[0]}" ]; then
        bashio::log.info "DRI devices: ${dri_devices[*]}"
    else
        bashio::log.info "DRI devices: none"
    fi
else
    bashio::log.info "No /dev/dri found"
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

if [ -f /proc/device-tree/model ] && tr -d '\0' < /proc/device-tree/model | grep -q "Pi 5" 2> /dev/null; then
    bashio::log.warning "Pi 5 detected: Hardware acceleration is NOT supported by jellyfin-ffmpeg."
    bashio::log.warning "Use software transcoding only. For best performance:"
    bashio::log.warning "  - Use Direct Play on clients whenever possible"
    bashio::log.warning "  - Disable hardware acceleration in Jellyfin Dashboard > Playback"
    bashio::log.warning "  - Set transcoding thread count to 4"
    bashio::log.warning "  - Put data_location on fast storage (USB SSD, not SD card)"
fi

bashio::log.info "=== End Diagnostics ==="

bashio::log.info "Jellyfin initialization complete"
