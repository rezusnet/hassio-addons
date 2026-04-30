#!/usr/bin/env bashio

set -e

LOCATION=$(bashio::config 'data_location')

# Create required directories
mkdir -p "${LOCATION}"
chmod 755 "${LOCATION}"

# Export timezone
export TZ=$(bashio::config 'TZ // "UTC"')

# Export Spotify credentials
SPOTIFY_CLIENT_ID=$(bashio::config 'spotify_client_id')
SPOTIFY_CLIENT_SECRET=$(bashio::config 'spotify_client_secret')
JWT_SECRET=$(bashio::config 'jwt_secret')
MONGO_DB_URI=$(bashio::config 'mongo_db_uri')
LOG_LEVEL=$(bashio::config 'log_level // "info"')

if [ -n "${SPOTIFY_CLIENT_ID}" ]; then
    export SPOTIFY_CLIENT_ID
fi

if [ -n "${SPOTIFY_CLIENT_SECRET}" ]; then
    export SPOTIFY_CLIENT_SECRET
fi

if [ -n "${JWT_SECRET}" ]; then
    export JWT_SECRET
fi

if [ -n "${MONGO_DB_URI}" ]; then
    export MONGO_DB_URI
fi

export LOG_LEVEL

bashio::log.info "Your-Spotify initialized with data location: ${LOCATION}"
