#!/usr/bin/env bash
set -e

echo "[INFO] Starting Hishtory Server add-on"

SERVER_PORT="${BASHIO_CONFIG_SERVER_PORT:-8000}"
DATA_LOCATION="${BASHIO_CONFIG_DATA_LOCATION:-/share/hisshtory}"
DB_HOST="${BASHIO_CONFIG_DB_HOST:-}"
DB_PORT="${BASHIO_CONFIG_DB_PORT:-5432}"
DB_NAME="${BASHIO_CONFIG_DB_NAME:-hishtory}"
DB_USER="${BASHIO_CONFIG_DB_USER:-hishtory}"
DB_PASSWORD="${BASHIO_CONFIG_DB_PASSWORD:-}"

# Create data directory
mkdir -p "${DATA_LOCATION}/data" "${DATA_LOCATION}/config"

echo "[INFO] Data location: ${DATA_LOCATION}"
echo "[INFO] Server port: ${SERVER_PORT}"

# Build database connection string if provided
if [ -n "${DB_HOST}" ]; then
    export DATABASE_URL="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
    echo "[INFO] Database configured: ${DB_HOST}:${DB_PORT}/${DB_NAME}"
else
    echo "[WARNING] No database configured. Hishtory requires PostgreSQL for persistence."
    echo "[INFO] Set db_host, db_user, and db_password in configuration."
fi

# Set other environment variables
export HISHTORY_PORT="${SERVER_PORT}"
export HISHTORY_DATA_DIR="${DATA_LOCATION}/data"

# Start hishtory server
echo "[INFO] Starting Hishtory server..."
exec /app/hishtory-server
