#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

if ! bashio::supervisor.ping 2> /dev/null; then
    exit 0
fi

if bashio::config.has_value 'localdisks'; then
    bashio::log.info "Mounting local disks"
    MOREDISKS=$(bashio::config 'localdisks')
    for disk in ${MOREDISKS//,/ }; do
        disk=$(echo "$disk" | sed "s|/dev/||g")
        if [ -z "$disk" ]; then continue; fi
        mountpoint="/mnt/$disk"
        mkdir -p "$mountpoint"
        if mountpoint -q "$mountpoint"; then
            bashio::log.info "$disk already mounted"
            continue
        fi
        if [ -b "/dev/$disk" ]; then
            mount "/dev/$disk" "$mountpoint" 2> /dev/null \
                || mount -t exfat "/dev/$disk" "$mountpoint" 2> /dev/null \
                || mount -t ntfs-3g "/dev/$disk" "$mountpoint" 2> /dev/null \
                || bashio::log.warning "Failed to mount $disk"
        else
            bashio::log.warning "/dev/$disk not found, trying label"
            mount -L "$disk" "$mountpoint" 2> /dev/null \
                || bashio::log.warning "Failed to mount by label $disk"
        fi
    done
fi
