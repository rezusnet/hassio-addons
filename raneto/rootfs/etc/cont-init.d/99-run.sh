#!/usr/bin/env bashio

set -e

# Get configuration values
LOCATION=$(bashio::config 'data_location')
TZ=$(bashio::config 'TZ')
PUID=$(bashio::config 'PUID')
PGID=$(bashio::config 'PGID')

# Set defaults
if [[ "$LOCATION" = "null" || -z "$LOCATION" ]]; then
    LOCATION=/config/raneto
fi

if [[ "$TZ" = "null" || -z "$TZ" ]]; then
    TZ="UTC"
fi

# Create data directory if it doesn't exist
mkdir -p "$LOCATION"

# Export to environment
export LOCATION
export TZ
export PUID
export PGID

bashio::log.info "Raneto data location: $LOCATION"
bashio::log.info "Timezone: $TZ"
