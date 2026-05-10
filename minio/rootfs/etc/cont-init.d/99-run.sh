#!/usr/bin/env bashio
set -e

bashio::log.info "Starting MinIO add-on initialization"

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

ACCESS_KEY="$(bashio::config 'access_key')"
SECRET_KEY="$(bashio::config 'secret_key')"
DATA_LOCATION="$(bashio::config 'data_location')"
API_PORT="$(bashio::config 'api_port')"
CONSOLE_PORT="$(bashio::config 'console_port')"

export MINIO_ROOT_USER="${ACCESS_KEY}"
export MINIO_ROOT_PASSWORD="${SECRET_KEY}"

mkdir -p "${DATA_LOCATION}"

CONSOLE_INTERNAL=$((CONSOLE_PORT + 1))

sed -i "s|proxy_pass http://127.0.0.1:[0-9]*|proxy_pass http://127.0.0.1:${CONSOLE_INTERNAL}|" /etc/nginx/nginx.conf

if [ "${CONSOLE_PORT}" = "9001" ]; then
    sed -i "s/listen [0-9]*/listen 9001/" /etc/nginx/nginx.conf
    nginx -c /etc/nginx/nginx.conf &
    bashio::log.info "nginx reverse proxy on :9001 -> :${CONSOLE_INTERNAL} (ingress enabled)"
else
    sed -i "s/listen [0-9]*/listen ${CONSOLE_PORT}/" /etc/nginx/nginx.conf
    nginx -c /etc/nginx/nginx.conf &
    bashio::log.info "nginx reverse proxy on :${CONSOLE_PORT} -> :${CONSOLE_INTERNAL} (ingress disabled, use direct port)"
fi

bashio::log.info "Data location: ${DATA_LOCATION}"
bashio::log.info "API port: ${API_PORT}, Console port: ${CONSOLE_PORT}"
bashio::log.info "MinIO initialization complete"

exec minio server "${DATA_LOCATION}" \
    --console-address ":${CONSOLE_INTERNAL}" \
    --address ":${API_PORT}"
