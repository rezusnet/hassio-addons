#!/usr/bin/env bashio
set -e

BAO_HOME="/data/openbao"
CONFIG_DIR="${BAO_HOME}/config"
CONFIG_FILE="${CONFIG_DIR}/openbao.json"
INIT_FILE="${BAO_HOME}/init.json"
AUDIT_LOG_FILE="${BAO_HOME}/logs/audit.log"
API_ADDR="http://127.0.0.1:8200"

# The bao CLI defaults to https://127.0.0.1:8200 — point it at our plain
# HTTP listener before any operator command runs.
export BAO_ADDR="${API_ADDR}"
export VAULT_ADDR="${API_ADDR}" # compat for older tooling
export HOME="${HOME:-/tmp}"     # token helper must be able to write $HOME

bashio::log.info "Starting OpenBao add-on initialization"

mkdir -p "${BAO_HOME}/data" "${CONFIG_DIR}" "${BAO_HOME}/logs"

# -----------------------------------------------------------------------------
# Options
# -----------------------------------------------------------------------------
LOG_LEVEL="$(bashio::config 'log_level')"
LOG_FORMAT="$(bashio::config 'log_format')"
UI="$(bashio::config 'ui')"
AUTO_UNSEAL="$(bashio::config 'auto_unseal')"
DEV_MODE="$(bashio::config 'dev_mode')"
DEV_ROOT_TOKEN="$(bashio::config 'dev_root_token' '')"
DISABLE_MLOCK="$(bashio::config 'disable_mlock')"
DEFAULT_LEASE_TTL="$(bashio::config 'default_lease_ttl' '')"
MAX_LEASE_TTL="$(bashio::config 'max_lease_ttl' '')"
TELEMETRY_RETENTION="$(bashio::config 'telemetry_prometheus_retention' '')"
SSL="$(bashio::config 'ssl')"
AUDIT_STDOUT="$(bashio::config 'audit_stdout')"
AUDIT_FILE="$(bashio::config 'audit_file')"
TRUSTED_PROXIES="$(bashio::config 'trusted_proxies' '')"
EXTRA_CONFIG="$(bashio::config 'extra_config' '')"

# Some bashio implementations return an empty string for a boolean `false`
# option value; normalize so jq --argjson always sees valid JSON.
UI="${UI:-false}"
AUTO_UNSEAL="${AUTO_UNSEAL:-false}"
DEV_MODE="${DEV_MODE:-false}"
DISABLE_MLOCK="${DISABLE_MLOCK:-false}"
SSL="${SSL:-false}"
AUDIT_STDOUT="${AUDIT_STDOUT:-false}"
AUDIT_FILE="${AUDIT_FILE:-false}"

# Custom environment variables (list of {name, value}) — forwarded to the
# server process. This is the add-on equivalent of the chart's
# server.extraEnvironmentVars (e.g. KMS credentials for auto-unseal).
while IFS=$'\t' read -r env_name env_value; do
    [ -n "${env_name}" ] || continue
    export "${env_name}=${env_value}"
    bashio::log.info "Custom env var set: ${env_name}"
done < <(jq -r '(.env_vars // []) | .[] | [(.name // ""), (.value // "")] | @tsv' /data/options.json)

# server.extraArgs equivalent — raw CLI arguments appended to the server.
EXTRA_ARGS=()
while IFS= read -r arg; do
    [ -n "${arg}" ] || continue
    EXTRA_ARGS+=("${arg}")
done < <(jq -r '(.extra_args // []) | .[]' /data/options.json)

# -----------------------------------------------------------------------------
# server.standalone.config / extraConfig equivalent: a user-provided JSON
# object written as an additional config file (bao merges all files passed
# via -config=<dir>). This is where seal stanzas for auto-unseal belong.
# -----------------------------------------------------------------------------
if [ -n "${EXTRA_CONFIG}" ]; then
    if jq -e 'type == "object"' > /dev/null 2>&1 <<< "${EXTRA_CONFIG}"; then
        printf '%s\n' "${EXTRA_CONFIG}" > "${CONFIG_DIR}/extra_config.json"
        bashio::log.info "extra_config written to ${CONFIG_DIR}/extra_config.json"
    else
        bashio::log.error "extra_config is not a valid JSON object."
        exit 1
    fi
fi

if [ "${DEV_MODE}" = "true" ]; then
    # ---------------------------------------------------------------------------
    # Dev mode (chart: server.dev.enabled) — in-memory storage, no init/unseal,
    # pre-mounted secret/ KV-v2, token = dev_root_token. All data is lost on
    # every restart; the Raft data directory is not touched.
    # ---------------------------------------------------------------------------
    bashio::log.warning "dev_mode is enabled: in-memory storage, ALL data is lost on every restart."
    [ -n "${EXTRA_CONFIG}" ] \
        && bashio::log.warning "extra_config is ignored in dev mode."

    DEV_ARGS=(-dev -dev-listen-address=0.0.0.0:8200)
    if [ -n "${DEV_ROOT_TOKEN}" ]; then
        DEV_ARGS+=(-dev-root-token-id="${DEV_ROOT_TOKEN}")
    fi

    cd /tmp # dev server writes vault.db / .vault-token to the working directory
    su-exec openbao bao server "${DEV_ARGS[@]}" "${EXTRA_ARGS[@]}" &
    BAO_PID=$!
else
    # ---------------------------------------------------------------------------
    # Normal mode: integrated Raft storage, declarative audit, init + unseal.
    # ---------------------------------------------------------------------------
    if [ "${SSL}" = "true" ]; then
        for f in /ssl/fullchain.pem /ssl/privkey.pem; do
            if [ ! -f "${f}" ]; then
                bashio::log.error "ssl is enabled but ${f} was not found."
                exit 1
            fi
        done
        # The server runs as the unprivileged `openbao` user while /ssl is
        # root-owned — copy the material into the data dir with sane modes.
        # The private key ends up on the same disk as init.json (0600), so
        # this does not weaken the security posture.
        mkdir -p "${BAO_HOME}/tls"
        cp /ssl/fullchain.pem /ssl/privkey.pem "${BAO_HOME}/tls/"
        chown openbao:openbao "${BAO_HOME}/tls"/*
        chmod 644 "${BAO_HOME}/tls/fullchain.pem"
        chmod 600 "${BAO_HOME}/tls/privkey.pem"
        API_ADDR="https://127.0.0.1:8200"
        export BAO_ADDR="${API_ADDR}"
        export VAULT_ADDR="${API_ADDR}"
        export BAO_CACERT="/ssl/fullchain.pem"
        export VAULT_CACERT="/ssl/fullchain.pem"
    fi

    # Audit devices are declarative since OpenBao 2.x: runtime enablement via
    # `bao audit enable` is rejected by the server, devices are instead defined
    # in the config stanza below (created/removed on restarts from this file).
    AUDIT_DEVICES="$(jq -cn \
        --argjson stdout "${AUDIT_STDOUT}" --argjson file "${AUDIT_FILE}" \
        --arg path "${AUDIT_LOG_FILE}" '
        [
            (select($stdout) | {file: {
                stdout: {type: "file", description: "Audit to container stdout",
                         options: {file_path: "stdout"}}}}),
            (select($file) | {file: {
                logfile: {type: "file", description: "Audit to persistent log file",
                          options: {file_path: $path}}}})
        ]')"

    jq -n \
        --arg log_level "${LOG_LEVEL}" \
        --arg log_format "${LOG_FORMAT}" \
        --arg default_lease_ttl "${DEFAULT_LEASE_TTL}" \
        --arg max_lease_ttl "${MAX_LEASE_TTL}" \
        --arg telemetry "${TELEMETRY_RETENTION}" \
        --arg trusted_proxies "${TRUSTED_PROXIES}" \
        --arg api_addr "${API_ADDR}" \
        --argjson ui "${UI}" \
        --argjson disable_mlock "${DISABLE_MLOCK}" \
        --argjson ssl "${SSL}" \
        '({
            ui: $ui,
            disable_mlock: $disable_mlock,
            log_level: $log_level,
            log_format: $log_format,
            api_addr: $api_addr,
            cluster_addr: "http://127.0.0.1:8201",
            storage: {raft: {path: "/data/openbao/data"}},
            listener: {tcp: (
                {address: "0.0.0.0:8200", cluster_address: "127.0.0.1:8201",
                 tls_disable: (if $ssl then false else true end)}
                + (if $ssl then
                    {tls_cert_file: "/data/openbao/tls/fullchain.pem",
                     tls_key_file: "/data/openbao/tls/privkey.pem"}
                   else {} end)
                + (if $trusted_proxies != "" then
                    {x_forwarded_for_authorized_addrs: $trusted_proxies}
                   else {} end)
                + (if $telemetry != "" then
                    {telemetry: {unauthenticated_metrics_access: "true"}}
                   else {} end)
            )}
        })
        + (if $default_lease_ttl != "" then
            {default_lease_ttl: $default_lease_ttl} else {} end)
        + (if $max_lease_ttl != "" then
            {max_lease_ttl: $max_lease_ttl} else {} end)
        + (if $telemetry != "" then
            {telemetry: {prometheus_retention_time: $telemetry,
                         disable_hostname: true}} else {} end)
    ' > "${CONFIG_FILE}"

    if [ "${AUDIT_DEVICES}" != "[]" ]; then
        jq --argjson audit "${AUDIT_DEVICES}" '.audit = $audit' \
            "${CONFIG_FILE}" > "${CONFIG_FILE}.tmp" \
            && mv "${CONFIG_FILE}.tmp" "${CONFIG_FILE}"
    fi

    bashio::log.info "Server configuration written to ${CONFIG_FILE}"

    chown -R openbao:openbao "${BAO_HOME}"

    su-exec openbao bao server -config="${CONFIG_DIR}" "${EXTRA_ARGS[@]}" &
    BAO_PID=$!

    trap 'kill -TERM "${BAO_PID}" 2>/dev/null || true' INT TERM
    trap 'kill -TERM "${BAO_PID}" 2>/dev/null || true' INT TERM
fi

if [ "${SSL}" = "true" ]; then
    CURL_CMD=(curl -sf --cacert /ssl/fullchain.pem)
else
    CURL_CMD=(curl -sf)
fi
bashio::log.info "Waiting for OpenBao to become ready..."
READY=0
for _ in $(seq 1 60); do
    if SEAL_STATUS=$("${CURL_CMD[@]}" "${API_ADDR}/v1/sys/seal-status" 2> /dev/null); then
        READY=1
        break
    fi
    sleep 1
done
if [ "${READY}" -ne 1 ]; then
    bashio::log.error "OpenBao API did not become ready within 60s."
    kill "${BAO_PID}" 2> /dev/null || true
    exit 1
fi

# -----------------------------------------------------------------------------
# First run: initialize with a single key share (single-node deployment).
# Dev mode initializes itself and needs none of this.
# -----------------------------------------------------------------------------
if [ "${DEV_MODE}" != "true" ]; then
    INITIALIZED="$(jq -r '.initialized' <<< "${SEAL_STATUS}")"
    if [ "${INITIALIZED}" = "false" ]; then
        bashio::log.info "First run: initializing OpenBao with a single key share..."
        bao operator init -key-shares=1 -key-threshold=1 -format=json > "${INIT_FILE}"
        chmod 600 "${INIT_FILE}"
        bashio::log.warning "IMPORTANT: ${INIT_FILE} now holds the root token and"
        bashio::log.warning "unseal key. Back it up OFF this device (e.g. Bitwarden) —"
        bashio::log.warning "losing it means the vault data can NEVER be decrypted again."
        SEAL_STATUS="$("${CURL_CMD[@]}" "${API_ADDR}/v1/sys/seal-status")"
    fi

    if [ ! -s "${INIT_FILE}" ]; then
        bashio::log.error "${INIT_FILE} is missing — cannot unseal. Restore it from"
        bashio::log.error "your off-device backup, or wipe ${BAO_HOME}/data to re-init (data loss!)."
        kill "${BAO_PID}" 2> /dev/null || true
        exit 1
    fi

    SEALED="$(jq -r '.sealed' <<< "${SEAL_STATUS}")"
    if [ "${SEALED}" = "true" ]; then
        if [ "${AUTO_UNSEAL}" = "true" ]; then
            UNSEAL_KEY="$(jq -r '.unseal_keys_b64[0]' "${INIT_FILE}")"
            bao operator unseal "${UNSEAL_KEY}" > /dev/null
            bashio::log.info "OpenBao auto-unsealed."
        else
            bashio::log.warning "auto_unseal is disabled and the vault is sealed."
            bashio::log.warning "Unseal manually: bao operator unseal <key> (key: ${INIT_FILE})"
        fi
    else
        bashio::log.info "OpenBao is already unsealed."
    fi

    # -------------------------------------------------------------------------
    # Post-unseal bootstrap
    # -------------------------------------------------------------------------
    SEALED="$("${CURL_CMD[@]}" "${API_ADDR}/v1/sys/seal-status" | jq -r '.sealed')"
    if [ "${SEALED}" = "false" ]; then
        BAO_TOKEN="$(jq -r '.root_token' "${INIT_FILE}")"
        export BAO_TOKEN

        # OpenBao 2.x no longer creates the conventional secret/ KV-v2 mount on
        # init — bootstrap it once so `bao kv put secret/...` works out of the box.
        MOUNTS="$(bao secrets list -format=json 2> /dev/null || echo '{}')"
        if ! jq -e 'has("secret/")' > /dev/null 2>&1 <<< "${MOUNTS}"; then
            bao secrets enable -path=secret kv-v2 > /dev/null \
                || bashio::log.warning "Could not enable the secret/ KV-v2 mount."
            bashio::log.info "Enabled KV-v2 secrets engine at secret/."
        fi

        unset BAO_TOKEN
    fi
fi

if [ "${DEV_MODE}" = "true" ]; then
    bashio::log.info "OpenBao dev server is ready on :8200 (in-memory storage)."
else
    bashio::log.info "OpenBao is ready — API/UI on :8200 (Raft storage in ${BAO_HOME}/data)"
fi

# Foreground supervision: forward the container lifetime to the server process.
wait "${BAO_PID}"
