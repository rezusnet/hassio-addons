#!/bin/sh
# shellcheck disable=SC2013,SC2016,SC2236
set -e

CONFIGLOCATION="${1:-/config}"
echo "Setting config to $CONFIGLOCATION"

for file in $(grep -sril 'Potential tampering with custom' /etc/cont-init.d /etc/services.d /etc/s6-overlay/s6-rc.d 2> /dev/null); do
    rm -f "$file"
done

if [ "$CONFIGLOCATION" != "/config" ]; then
    for file in $(grep -srl "PUID" /etc/cont-init.d /etc/s6-overlay/s6-rc.d 2> /dev/null); do
        sed -i "1a mkdir -p $CONFIGLOCATION" "$file"
    done
    for file in $(grep -Esril "/config[ '\"/]|/config\$" /etc /defaults 2> /dev/null); do
        sed -Ei "s=(/config)+(/| |$|\"|\')=$CONFIGLOCATION\2=g" "$file"
    done
fi

for file in $(grep -srl "PUID" /etc/cont-init.d /etc/s6-overlay/s6-rc.d 2> /dev/null); do
    sed -i 's/bash/bashio/g' "$file" && sed -i '1a PUID="$(if bashio::config.has_value "PUID"; then bashio::config "PUID"; else echo "0"; fi)"' "$file"
    sed -i '1a PGID="$(if bashio::config.has_value "PGID"; then bashio::config "PGID"; else echo "0"; fi)"' "$file"
done

if [ -f /config/configuration.yaml ] || [ -f /config/configuration.json ]; then
    for file in /etc/services.d/*/* /etc/cont-init.d/* /etc/s6-overlay/s6-rc.d/*/*; do
        if [ -f "$file" ] && [ -n "$(awk '/chown.*abc:abc.*\\/,/.*\/config( |$)/{print FILENAME}' "$file")" ]; then
            sed -i "s|/config$|/data|g" "$file"
        fi
    done
fi

if [ -f /etc/s6-overlay/s6-rc.d/svc-cron/run ]; then
    sed -i "/exec busybox crond/c exec busybox crond -f -S -L /proc/1/fd/1" /etc/s6-overlay/s6-rc.d/svc-cron/run
    sed -i "/exec \/usr\/sbin\/cron/c exec /usr/sbin/cron -f &>/proc/1/fd/1" /etc/s6-overlay/s6-rc.d/svc-cron/run
fi

for file in $(grep -srl "/usr/bin" /etc/cont-init.d /etc/s6-overlay/s6-rc.d 2> /dev/null); do
    sed -i "1a set +u" "$file"
done

if [ -f /etc/s6-overlay/s6-rc.d/init-adduser/run ]; then
    sed -i '/usermod/ s/$/ 2>\/dev\/null || true/' /etc/s6-overlay/s6-rc.d/init-adduser/run
    sed -i '/groupmod/ s/$/ 2>\/dev\/null || true/' /etc/s6-overlay/s6-rc.d/init-adduser/run
fi

if [ ! -f /usr/bin/lsiown ]; then
    for file in $(grep -sril "lsiown" /etc 2> /dev/null); do
        sed -i "s|lsiown|chown|g" "$file"
    done
fi
