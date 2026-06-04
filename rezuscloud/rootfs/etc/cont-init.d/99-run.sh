#!/usr/bin/env bashio
# shellcheck shell=bash disable=SC2034
set -e

bashio::log.info "Starting RezusCloud add-on initialization"

export REZUSCLOUD_DATA_DIR="/data/rezuscloud"
export REZUSCLOUD_ADDR=":3000"
export REZUSCLOUD_MACHINELINK_ADDR=":50180"
export REZUSCLOUD_PROVIDER_ADDR=":50190"
export REZUSCLOUD_MODE="standalone"

if bashio::config.has_value 'join_token'; then
    export REZUSCLOUD_JOIN_TOKEN="$(bashio::config 'join_token')"
    bashio::log.info "Join token configured"
fi

if bashio::config.true 'backup_enabled'; then
    export REZUSCLOUD_BACKUP_ENABLED="true"
    if bashio::config.has_value 'backup_s3_endpoint'; then
        export REZUSCLOUD_BACKUP_S3_ENDPOINT="$(bashio::config 'backup_s3_endpoint')"
    fi
    if bashio::config.has_value 'backup_s3_bucket'; then
        export REZUSCLOUD_BACKUP_S3_BUCKET="$(bashio::config 'backup_s3_bucket')"
    fi
    bashio::log.info "Backup enabled"
fi

mkdir -p "${REZUSCLOUD_DATA_DIR}"

bashio::log.info "RezusCloud management plane starting"
bashio::log.info "  WebUI:       http://localhost:3000"
bashio::log.info "  MachineLink: :50180"
bashio::log.info "  Provider:    :50190"

if bashio::config.true 'auto_start'; then
    bashio::log.info "Auto-start enabled, booting management cluster..."
    rezuscloud boot --platform docker --management || bashio::log.warning "Boot command returned non-zero (may already be initialized)"
fi

bashio::log.info "Starting RezusCloud server..."
exec rezuscloud
