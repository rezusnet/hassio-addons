#!/usr/bin/env bashio
set -e

echo "[INFO] Starting Oscam add-on"

LOCATION="$(bashio::config 'data_location')"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    echo "[INFO] Timezone set to ${TZ}"
fi

# Create required directories
mkdir -p "${LOCATION}/config" \
    "${LOCATION}/cache" \
    "${LOCATION}/logs"

echo "[INFO] Data location: ${LOCATION}"
echo "[INFO] Oscam configuration directory: ${LOCATION}/config"

# Create default config if not exists
if [ ! -f "${LOCATION}/config/oscam.conf" ]; then
    echo "[INFO] Creating default oscam.conf"
    cat > "${LOCATION}/config/oscam.conf" << 'OSCAMCONF'
[main]
port = 9000
addr = 0.0.0.0

[dvbapi]
enabled = 1
port = 9000
OSCAMCONF
fi

# Start oscam
if [ -f /app/oscam ]; then
    echo "[INFO] Starting Oscam server..."
    exec /app/oscam -c "${LOCATION}/config"
else
    echo "[ERROR] Oscam binary not found"
    echo "[WARNING] Please ensure compilation succeeded or provide prebuilt binary"
    echo "[INFO] Keeping container running for debugging..."
    sleep infinity
fi
