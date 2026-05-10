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

export MINIO_ROOT_USER="${ACCESS_KEY}"
export MINIO_ROOT_PASSWORD="${SECRET_KEY}"

mkdir -p "${DATA_LOCATION}"

bashio::log.info "Data location: ${DATA_LOCATION}"
bashio::log.info "MinIO initialization complete"

exec minio server "${DATA_LOCATION}" \
    --console-address ":9001" \
    --address ":9000"
