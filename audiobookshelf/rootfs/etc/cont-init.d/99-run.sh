#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

bashio::log.info "Configuring Audiobookshelf..."

mkdir -p /data/config /data/metadata

export CONFIG_PATH="/data/config"
export METADATA_PATH="/data/metadata"
export PORT="8133"
export SOURCE="docker"
export ALLOW_IFRAME="1"
export ROUTER_BASE_PATH="/"

if bashio::config.has_value 'backup_path'; then
    BACKUP_PATH=$(bashio::config 'backup_path')
    mkdir -p "$BACKUP_PATH"
    export BACKUP_PATH
    bashio::log.info "Backup path set to ${BACKUP_PATH}"
fi

PODCAST_DOWNLOAD_TIMEOUT=$(bashio::config 'podcast_download_timeout')
export PODCAST_DOWNLOAD_TIMEOUT

if bashio::config.true 'allow_cors'; then
    export ALLOW_CORS="1"
    bashio::log.info "CORS enabled"
fi

if bashio::config.true 'disable_ssrf_filter'; then
    export DISABLE_SSRF_REQUEST_FILTER="1"
    bashio::log.info "SSRF request filter disabled"
fi

if bashio::config.has_value 'ssrf_whitelist'; then
    SSRF_REQUEST_FILTER_WHITELIST=$(bashio::config 'ssrf_whitelist')
    export SSRF_REQUEST_FILTER_WHITELIST
fi

RATE_LIMIT_AUTH_WINDOW=$(bashio::config 'rate_limit_auth_window')
export RATE_LIMIT_AUTH_WINDOW
RATE_LIMIT_AUTH_MAX=$(bashio::config 'rate_limit_auth_max')
export RATE_LIMIT_AUTH_MAX

if bashio::config.has_value 'env_vars'; then
    bashio::log.info "Setting custom environment variables"
    ENV_VARS=$(bashio::config 'env_vars')
    for env_var in $ENV_VARS; do
        VAR_NAME=$(echo "$env_var" | jq -r '.name')
        VAR_VALUE=$(echo "$env_var" | jq -r '.value // empty')
        if [ -n "$VAR_NAME" ] && [ -n "$VAR_VALUE" ]; then
            export "${VAR_NAME}=${VAR_VALUE}"
            bashio::log.info "Set env var: ${VAR_NAME}"
        fi
    done
fi

for folders in /etc/services.d /etc/s6-overlay; do
    [[ -d "$folders" ]] && rm -r "$folders"
done

AUDIOBOOKS_PATH=$(bashio::config 'audiobooks_path')
PODCASTS_PATH=$(bashio::config 'podcasts_path')

mkdir -p "$AUDIOBOOKS_PATH" "$PODCASTS_PATH"

bashio::log.info "Audiobooks path: ${AUDIOBOOKS_PATH} (configure as library in web UI)"
bashio::log.info "Podcasts path: ${PODCASTS_PATH} (configure as library in web UI)"
bashio::log.info "Config path: ${CONFIG_PATH}"
bashio::log.info "Metadata path: ${METADATA_PATH}"
bashio::log.info "Starting Audiobookshelf..."

exec /sbin/tini -s -- node /app/index.js
