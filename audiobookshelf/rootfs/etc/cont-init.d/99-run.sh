#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

bashio::log.info "Configuring Audiobookshelf..."

mkdir -p /data/config /data/metadata

export CONFIG_PATH="/data/config"
export METADATA_PATH="/data/metadata"
export PORT="8133"
export SOURCE="docker"

ROUTER_BASE_PATH=$(bashio::config 'router_base_path')
export ROUTER_BASE_PATH

if bashio::config.true 'allow_iframe'; then
    export ALLOW_IFRAME="1"
fi

if bashio::config.has_value 'backup_path'; then
    BACKUP_PATH=$(bashio::config 'backup_path')
    mkdir -p "$BACKUP_PATH"
    export BACKUP_PATH
    bashio::log.info "Backup path set to ${BACKUP_PATH}"
fi

PODCAST_DOWNLOAD_TIMEOUT=$(bashio::config 'podcast_download_timeout')
export PODCAST_DOWNLOAD_TIMEOUT

if bashio::config.has_value 'max_failed_episode_checks'; then
    MAX_FAILED_EPISODE_CHECKS=$(bashio::config 'max_failed_episode_checks')
    export MAX_FAILED_EPISODE_CHECKS
fi

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

if bashio::config.has_value 'access_token_expiry'; then
    ACCESS_TOKEN_EXPIRY=$(bashio::config 'access_token_expiry')
    export ACCESS_TOKEN_EXPIRY
fi

if bashio::config.has_value 'refresh_token_expiry'; then
    REFRESH_TOKEN_EXPIRY=$(bashio::config 'refresh_token_expiry')
    export REFRESH_TOKEN_EXPIRY
fi

if bashio::config.true 'exp_proxy_support'; then
    export EXP_PROXY_SUPPORT="1"
    bashio::log.info "Experimental proxy support enabled"
fi

if bashio::config.true 'use_x_accel'; then
    export USE_X_ACCEL="1"
fi

if bashio::config.true 'skip_binaries_check'; then
    export SKIP_BINARIES_CHECK="1"
fi

if bashio::config.has_value 'query_logging'; then
    QUERY_LOGGING=$(bashio::config 'query_logging')
    export QUERY_LOGGING
fi

if bashio::config.has_value 'sqlite_cache_size'; then
    SQLITE_CACHE_SIZE=$(bashio::config 'sqlite_cache_size')
    export SQLITE_CACHE_SIZE
fi

if bashio::config.has_value 'sqlite_mmap_size'; then
    SQLITE_MMAP_SIZE=$(bashio::config 'sqlite_mmap_size')
    export SQLITE_MMAP_SIZE
fi

if bashio::config.has_value 'sqlite_temp_store'; then
    SQLITE_TEMP_STORE=$(bashio::config 'sqlite_temp_store')
    export SQLITE_TEMP_STORE
fi

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
bashio::log.info "Router base path: ${ROUTER_BASE_PATH}"
bashio::log.info "Starting Audiobookshelf on port ${PORT}..."

exec /sbin/tini -s -- node /app/index.js
