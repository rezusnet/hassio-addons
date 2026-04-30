#!/usr/bin/env bashio

set -e

LOCATION=$(bashio::config 'data_location')

# Create required directories
mkdir -p "${LOCATION}"
chmod 755 "${LOCATION}"

# Export timezone
export TZ=$(bashio::config 'TZ // "UTC"')

# NGircd server configuration
SERVER_NAME=$(bashio::config 'server_name // "ngircd.localdomain"')
SERVER_INFO=$(bashio::config 'server_info // "NGircd IRC Server"')
MAX_CONNECTIONS=$(bashio::config 'max_connections // 100')
MAX_CLIENTS_PER_HOST=$(bashio::config 'max_clients_per_host // 10')
LOG_LEVEL=$(bashio::config 'log_level // 2')
MOTD=$(bashio::config 'motd // ""')

export SERVER_NAME
export SERVER_INFO
export MAX_CONNECTIONS
export MAX_CLIENTS_PER_HOST
export LOG_LEVEL

# Create MOTD file if provided
if [ -n "${MOTD}" ]; then
    echo "${MOTD}" > "${LOCATION}/ircd.motd"
fi

bashio::log.info "NGircd IRC daemon initialized"
bashio::log.info "Server: ${SERVER_NAME}"
bashio::log.info "Max connections: ${MAX_CONNECTIONS}"
bashio::log.info "Data location: ${LOCATION}"
