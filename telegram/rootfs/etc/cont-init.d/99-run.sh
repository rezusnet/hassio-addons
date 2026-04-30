#!/usr/bin/env bash
set -e

echo "[INFO] Starting Telegram Bot API add-on"

API_PORT="${BASHIO_CONFIG_API_PORT:-8081}"
DATA_LOCATION="${BASHIO_CONFIG_DATA_LOCATION:-/share/telegram}"
API_ID="${BASHIO_CONFIG_API_ID:-}"
API_HASH="${BASHIO_CONFIG_API_HASH:-}"

# Create data directory
mkdir -p "${DATA_LOCATION}/data" "${DATA_LOCATION}/tmp"

echo "[INFO] Data location: ${DATA_LOCATION}"
echo "[INFO] API port: ${API_PORT}"

# Start Telegram Bot API server
# The telegram/bot-api image uses /telegram-bot-api binary
exec /telegram-bot-api \
    --api-id="${API_ID}" \
    --api-hash="${API_HASH}" \
    --local \
    --port="${API_PORT}" \
    --dir="${DATA_LOCATION}/data" \
    --temp-dir="${DATA_LOCATION}/tmp"
