#!/usr/bin/env bashio
set -e

BAO_HOME="/data/openbao"
CONFIG_FILE="${BAO_HOME}/config/openbao.json"
INIT_FILE="${BAO_HOME}/init.json"
AUDIT_LOG_FILE="${BAO_HOME}/logs/audit.log"
API_ADDR="http://127.0.0.1:8200"

# The bao CLI defaults to https://127.0.0.1:8200 — point it at our plain
# HTTP listener before any operator command runs.
export BAO_ADDR="${API_ADDR}"
export VAULT_ADDR="${API_ADDR}" # compat for older tooling
export HOME="${HOME:-/tmp}"     # token helper must be able to write $HOME

bashio::log.info "Starting OpenBao add-on initialization"

mkdir -p "${BAO_HOME}/data" "${BAO_HOME}/config" "${BAO_HOME}/logs"

# -----------------------------------------------------------------------------
# Options
# -----------------------------------------------------------------------------
LOG_LEVEL="$(bashio::config 'log_level')"
AUTO_UNSEAL="$(bashio::config 'auto_unseal')"
AUDIT_STDOUT="$(bashio::config 'audit_stdout')"
AUDIT_FILE="$(bashio::config 'audit_file')"
# Some bashio implementations return an empty string for a boolean `false`
# option value; normalize so the jq --argjson consumers always see valid JSON.
AUDIT_STDOUT="${AUDIT_STDOUT:-false}"
AUDIT_FILE="${AUDIT_FILE:-false}"
TRUSTED_PROXIES="$(bashio::config 'trusted_proxies' '')"

# Custom environment variables (list of {name, value}) — forwarded to the
# server process. Useful for BAO_* settings such as future auto-unseal
# mechanisms (e.g. BAO_ADDR_AWSKMS...). Unknown names are the user's
# responsibility; only [A-Za-z0-9_] names pass the schema.
while IFS=$'\t' read -r env_name env_value; do
    [ -n "${env_name}" ] || continue
    export "${env_name}=${env_value}"
    bashio::log.info "Custom env var set: ${env_name}"
done < <(jq -r '(.env_vars // []) | .[] | [(.name // ""), (.value // "")] | @tsv' /data/options.json)

# -----------------------------------------------------------------------------
# Server configuration (integrated Raft storage, single node)
#
# Audit devices are declarative since OpenBao 2.x: runtime enablement via
# `bao audit enable` is rejected by the server, devices are instead defined
# in the config stanza below (created/removed on restarts from this file).
# -----------------------------------------------------------------------------
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
    --arg trusted_proxies "${TRUSTED_PROXIES}" \
    '{
        ui: true,
        disable_mlock: true,
        log_level: $log_level,
        api_addr: "http://127.0.0.1:8200",
        cluster_addr: "http://127.0.0.1:8201",
        storage: {raft: {path: "/data/openbao/data"}},
        listener: {tcp: (
            {address: "0.0.0.0:8200", tls_disable: true}
            + (if $trusted_proxies != "" then
                {x_forwarded_for_authorized_addrs: $trusted_proxies}
               else {} end)
        )}
    }' > "${CONFIG_FILE}"

if [ "${AUDIT_DEVICES}" != "[]" ]; then
    jq --argjson audit "${AUDIT_DEVICES}" '.audit = $audit' \
        "${CONFIG_FILE}" > "${CONFIG_FILE}.tmp" \
        && mv "${CONFIG_FILE}.tmp" "${CONFIG_FILE}"
fi

bashio::log.info "Server configuration written to ${CONFIG_FILE}"

# -----------------------------------------------------------------------------
# Start the server as the dedicated `openbao` user
# -----------------------------------------------------------------------------
chown -R openbao:openbao "${BAO_HOME}"

su-exec openbao bao server -config="${CONFIG_FILE}" &
BAO_PID=$!

trap 'kill -TERM "${BAO_PID}" 2>/dev/null || true' INT TERM

bashio::log.info "Waiting for OpenBao to become ready..."
READY=0
for _ in $(seq 1 60); do
    if SEAL_STATUS=$(curl -sf "${API_ADDR}/v1/sys/seal-status" 2> /dev/null); then
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
# First run: initialize with a single key share (single-node deployment)
# -----------------------------------------------------------------------------
INITIALIZED="$(jq -r '.initialized' <<< "${SEAL_STATUS}")"
if [ "${INITIALIZED}" = "false" ]; then
    bashio::log.info "First run: initializing OpenBao with a single key share..."
    bao operator init -key-shares=1 -key-threshold=1 -format=json > "${INIT_FILE}"
    chmod 600 "${INIT_FILE}"
    bashio::log.warning "IMPORTANT: ${INIT_FILE} now holds the root token and"
    bashio::log.warning "unseal key. Back it up OFF this device (e.g. Bitwarden) —"
    bashio::log.warning "losing it means the vault data can NEVER be decrypted again."
    SEAL_STATUS="$(curl -sf "${API_ADDR}/v1/sys/seal-status")"
fi

# -----------------------------------------------------------------------------
# Unseal (auto on start, or manual when auto_unseal is disabled)
# -----------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------
# Post-unseal bootstrap (runs only when the vault is unsealed)
# -----------------------------------------------------------------------------
SEALED="$(curl -sf "${API_ADDR}/v1/sys/seal-status" | jq -r '.sealed')"
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

bashio::log.info "OpenBao is ready — API/UI on :8200 (Raft storage in ${BAO_HOME}/data)"

# Foreground supervision: forward the container lifetime to the server process.
wait "${BAO_PID}"
