#!/usr/bin/env bashio
set -e

bashio::log.info "Starting Mastodon add-on initialization"

LOCATION="$(bashio::config 'data_location')"

if [[ "${LOCATION}" = "null" || -z "${LOCATION}" ]]; then
    LOCATION=/config
fi

if bashio::config.has_value 'TZ'; then
    TZ_VAL="$(bashio::config 'TZ')"
    export TZ="${TZ_VAL}"
    bashio::log.info "Timezone set to ${TZ}"
fi

mkdir -p "${LOCATION}/mastodon" \
    "${LOCATION}/nginx" \
    "${LOCATION}/secrets"

bashio::log.info "Data location: ${LOCATION}"

bashio::log.info "Validating required configuration"

if ! bashio::config.has_value 'LOCAL_DOMAIN'; then
    bashio::exit.nok "LOCAL_DOMAIN is required. Set it to your Mastodon server domain (e.g., social.example.com)"
fi

if ! bashio::config.has_value 'DB_HOST'; then
    bashio::exit.nok "DB_HOST is required. You must provide an external PostgreSQL database."
fi

if ! bashio::config.has_value 'REDIS_HOST'; then
    bashio::exit.nok "REDIS_HOST is required. You must provide an external Redis instance."
fi

bashio::log.info "Setting environment variables from add-on config"

LOCAL_DOMAIN="$(bashio::config 'LOCAL_DOMAIN')"
DB_HOST="$(bashio::config 'DB_HOST')"
DB_PORT="$(bashio::config 'DB_PORT')"
DB_USER="$(bashio::config 'DB_USER')"
DB_NAME="$(bashio::config 'DB_NAME')"
DB_PASS="$(bashio::config 'DB_PASS')"
REDIS_HOST="$(bashio::config 'REDIS_HOST')"
REDIS_PORT="$(bashio::config 'REDIS_PORT')"
export LOCAL_DOMAIN DB_HOST DB_PORT DB_USER DB_NAME DB_PASS REDIS_HOST REDIS_PORT

if bashio::config.has_value 'SMTP_SERVER'; then
    SMTP_SERVER="$(bashio::config 'SMTP_SERVER')"
    SMTP_PORT="$(bashio::config 'SMTP_PORT')"
    SMTP_LOGIN="$(bashio::config 'SMTP_LOGIN')"
    SMTP_PASSWORD="$(bashio::config 'SMTP_PASSWORD')"
    SMTP_FROM_ADDRESS="$(bashio::config 'SMTP_FROM_ADDRESS')"
    export SMTP_SERVER SMTP_PORT SMTP_LOGIN SMTP_PASSWORD SMTP_FROM_ADDRESS
fi

ES_ENABLED="$(bashio::config 'ES_ENABLED')"
if [[ "${ES_ENABLED}" = "true" ]]; then
    export ES_ENABLED="true"
else
    export ES_ENABLED="false"
fi

generate_secret() {
    local secret_name="$1"
    local secret_file="${LOCATION}/secrets/${secret_name}"
    local secret_value

    if bashio::config.has_value "${secret_name}"; then
        secret_value="$(bashio::config "${secret_name}")"
        bashio::log.info "Using provided ${secret_name}"
    elif [ -f "${secret_file}" ]; then
        secret_value="$(cat "${secret_file}")"
        bashio::log.info "Using persisted ${secret_name}"
    else
        secret_value="$(openssl rand -hex 64)"
        echo -n "${secret_value}" > "${secret_file}"
        bashio::log.info "Generated and persisted ${secret_name}"
    fi

    export "${secret_name}=${secret_value}"
}

generate_vapid_keys() {
    local vapid_private_file="${LOCATION}/secrets/VAPID_PRIVATE_KEY"
    local vapid_public_file="${LOCATION}/secrets/VAPID_PUBLIC_KEY"

    if bashio::config.has_value 'VAPID_PRIVATE_KEY' && bashio::config.has_value 'VAPID_PUBLIC_KEY'; then
        VAPID_PRIVATE_KEY="$(bashio::config 'VAPID_PRIVATE_KEY')"
        VAPID_PUBLIC_KEY="$(bashio::config 'VAPID_PUBLIC_KEY')"
        export VAPID_PRIVATE_KEY VAPID_PUBLIC_KEY
        bashio::log.info "Using provided VAPID keys"
    elif [ -f "${vapid_private_file}" ] && [ -f "${vapid_public_file}" ]; then
        VAPID_PRIVATE_KEY="$(cat "${vapid_private_file}")"
        VAPID_PUBLIC_KEY="$(cat "${vapid_public_file}")"
        export VAPID_PRIVATE_KEY VAPID_PUBLIC_KEY
        bashio::log.info "Using persisted VAPID keys"
    else
        bashio::log.info "Generating VAPID keys..."
        if command -v ruby > /dev/null 2>&1; then
            local vapid_output
            vapid_output="$(ruby -e "require 'webpush'; vapid_key = Webpush.generate_key; puts vapid_key.private_key; puts vapid_key.public_key" 2>/dev/null || true)"
            if [ -n "${vapid_output}" ]; then
                VAPID_PRIVATE_KEY="$(echo "${vapid_output}" | head -1)"
                VAPID_PUBLIC_KEY="$(echo "${vapid_output}" | tail -1)"
                export VAPID_PRIVATE_KEY VAPID_PUBLIC_KEY
            fi
        fi
        if [ -z "${VAPID_PRIVATE_KEY:-}" ] || [ -z "${VAPID_PUBLIC_KEY:-}" ]; then
            VAPID_PRIVATE_KEY="$(openssl rand -base64 32 | tr -d '\n')"
            VAPID_PUBLIC_KEY="$(openssl rand -base64 32 | tr -d '\n')"
            export VAPID_PRIVATE_KEY VAPID_PUBLIC_KEY
            bashio::log.warning "Generated basic VAPID keys. For production, generate proper VAPID keys using: RAILS_ENV=production bundle exec rake mastodon:webpush"
        fi
        echo -n "${VAPID_PRIVATE_KEY}" > "${vapid_private_file}"
        echo -n "${VAPID_PUBLIC_KEY}" > "${vapid_public_file}"
        bashio::log.info "Generated and persisted VAPID keys"
    fi
}

bashio::log.info "Generating secrets"
generate_secret "SECRET_KEY_BASE"
generate_secret "OTP_SECRET"
generate_vapid_keys
generate_secret "ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY"
generate_secret "ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY"
generate_secret "ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT"

bashio::log.info "Nginx serves both HTTP (port 80) and HTTPS (port 443) for ingress compatibility"

bashio::log.info "Mastodon initialization complete"
bashio::log.info "LOCAL_DOMAIN: ${LOCAL_DOMAIN}"
bashio::log.info "DB_HOST: ${DB_HOST}:${DB_PORT}"
bashio::log.info "REDIS_HOST: ${REDIS_HOST}:${REDIS_PORT}"
