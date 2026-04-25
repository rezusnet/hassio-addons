#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

if bashio::config.has_value 'TZ'; then
    TIMEZONE=$(bashio::config 'TZ')
    bashio::log.info "Setting timezone to $TIMEZONE"
    if [ -f /usr/share/zoneinfo/"$TIMEZONE" ]; then
        ln -snf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime
        echo "$TIMEZONE" > /etc/timezone
    fi
fi

bashio::config.require.ssl
if bashio::config.true 'ssl'; then
    bashio::log.info "ssl enabled"
    CERTFILE="-t /ssl/$(bashio::config 'certfile')"
    KEYFILE="-k /ssl/$(bashio::config 'keyfile')"
else
    CERTFILE=""
    KEYFILE=""
fi

FB_BASE_URL=$(bashio::addon.ingress_entry)
export FB_BASE_URL

declare ADDON_PROTOCOL=http
if bashio::config.true 'ssl'; then
    ADDON_PROTOCOL=https
fi

ingress_port=$(bashio::addon.ingress_port)
ingress_interface=$(bashio::addon.ip_address)
sed -i "s|%%protocol%%|${ADDON_PROTOCOL}|g" /etc/nginx/servers/ingress.conf
sed -i "s|%%port%%|${ingress_port}|g" /etc/nginx/servers/ingress.conf
sed -i "s|%%interface%%|${ingress_interface}|g" /etc/nginx/servers/ingress.conf
sed -i "s|%%subpath%%|${FB_BASE_URL}/|g" /etc/nginx/servers/ingress.conf
mkdir -p /var/log/nginx && touch /var/log/nginx/error.log

NOAUTH=""

for folders in /etc/services.d /etc/s6-overlay; do
    [[ -d "$folders" ]] && rm -r "$folders"
done

if bashio::config.true 'NoAuth'; then
    if ! bashio::fs.file_exists "/data/noauth"; then
        rm /data/auth &> /dev/null || true
        rm /config/filebrowser.dB &> /dev/null || true
        touch /data/noauth
        NOAUTH="--noauth"
    fi
else
    if ! bashio::fs.file_exists "/data/auth"; then
        rm /data/noauth &> /dev/null || true
        rm /config/filebrowser.dB &> /dev/null || true
        touch /data/auth
    fi
fi

if bashio::config.has_value 'base_folder'; then
    BASE_FOLDER=$(bashio::config 'base_folder')
else
    BASE_FOLDER=/
fi

if bashio::config.true 'disable_thumbnails'; then
    DISABLE_THUMBNAILS="--disableThumbnails"
else
    DISABLE_THUMBNAILS=""
fi

if [ -f /.filebrowser.json ]; then
    rm /.filebrowser.json
fi

bashio::log.info "Starting..."

/./bin/filebrowser --disablePreviewResize --disableTypeDetectionByHeader --cacheDir="/cache" $CERTFILE $KEYFILE --root="$BASE_FOLDER" --address=0.0.0.0 --port=8080 --database=/config/filebrowser.dB "$NOAUTH" "$DISABLE_THUMBNAILS" &
bashio::net.wait_for 8080 localhost 900 || true
bashio::log.info "Started!"
nginx || bashio::log.fatal "Nginx failed"
