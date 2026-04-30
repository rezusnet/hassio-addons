#!/usr/bin/env bashio

set -e

bashio::log.info "Initializing Beets addon..."

# Get configuration
PUID="$(bashio::config 'PUID')"
PGID="$(bashio::config 'PGID')"
TZ="$(bashio::config 'TZ')"
DATA_LOCATION="$(bashio::config 'data_location')"

# Set timezone
export TZ="${TZ}"

# Set user/group IDs in environment
export PUID="${PUID}"
export PGID="${PGID}"

# Ensure data directory exists
if [ ! -d "${DATA_LOCATION}" ]; then
    bashio::log.info "Creating data directory at ${DATA_LOCATION}..."
    mkdir -p "${DATA_LOCATION}"
fi

# Set proper permissions on data directory
bashio::log.info "Setting permissions on ${DATA_LOCATION}..."
chown -R "${PUID}:${PGID}" "${DATA_LOCATION}"
chmod 755 "${DATA_LOCATION}"

# Export variables for the service
export HOME="/nonexistent"
export LANG="C.UTF-8"
export LC_ALL="C.UTF-8"

bashio::log.info "Beets addon initialization complete"
