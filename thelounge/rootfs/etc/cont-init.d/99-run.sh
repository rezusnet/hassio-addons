#!/usr/bin/env bashio

set -e

# Get configuration
PUID=$(bashio::config 'puid')
PGID=$(bashio::config 'pgid')
TZ=$(bashio::config 'tz')
LOCATION=$(bashio::config 'data_location')

bashio::log.info "Setting up TheLounge..."

# Export environment variables
export PUID=${PUID}
export PGID=${PGID}
export TZ=${TZ}
export LOCATION=${LOCATION}

# Create data directory if it doesn't exist
if [ ! -d "${LOCATION}" ]; then
    bashio::log.info "Creating data directory: ${LOCATION}"
    mkdir -p "${LOCATION}"
fi

# Set permissions
chown -R ${PUID}:${PGID} "${LOCATION}"
chmod -R 755 "${LOCATION}"

# Set any additional environment variables from config
if bashio::config.has_value 'env_vars'; then
    bashio::log.info "Setting additional environment variables..."
    while read -r env_var; do
        VAR_NAME=$(bashio::jq "${env_var}" '.name')
        VAR_VALUE=$(bashio::jq "${env_var}" '.value')
        export "${VAR_NAME}=${VAR_VALUE}"
        bashio::log.info "Set ${VAR_NAME}=${VAR_VALUE}"
    done < <(bashio::config 'env_vars | .[]')
fi

bashio::log.info "TheLounge initialization complete."
