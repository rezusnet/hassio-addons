#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

if bashio::config.has_value 'TZ'; then
	TIMEZONE=$(bashio::config 'TZ')
	bashio::log.info "Setting timezone to $TIMEZONE"
	if [ -f /usr/share/zoneinfo/"$TIMEZONE" ]; then
		ln -snf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime
		echo "$TIMEZONE" >/etc/timezone
	fi
fi

WORKSPACE=$(bashio::config 'workspace')
if [ -z "$WORKSPACE" ]; then
	WORKSPACE="/homeassistant"
fi

if [ ! -d "$WORKSPACE" ]; then
	bashio::log.warning "Workspace directory $WORKSPACE does not exist, creating it"
	mkdir -p "$WORKSPACE"
fi

bashio::log.info "Workspace set to $WORKSPACE"

CONFIG_DIR="/config"
mkdir -p "$CONFIG_DIR"

OPENCODE_CONFIG="${CONFIG_DIR}/opencode.json"

cat >"$OPENCODE_CONFIG" <<'JSONEOF'
{
  "$schema": "https://opencode.ai/config.json",
  "autoupdate": false,
  "server": {
    "port": 8080,
    "hostname": "0.0.0.0"
  }
}
JSONEOF

bashio::log.info "Generated opencode config at $OPENCODE_CONFIG"

export OPENCODE_CONFIG_DIR="${CONFIG_DIR}"

if bashio::config.has_value 'server_password'; then
	export OPENCODE_SERVER_PASSWORD=$(bashio::config 'server_password')
	bashio::log.info "Server password protection enabled"
else
	bashio::log.warning "No server password set - OpenCode web UI is unsecured"
fi

if bashio::config.has_value 'env_vars'; then
	bashio::log.info "Setting custom environment variables"
	ENV_VARS=$(bashio::config 'env_vars')
	for env_var in $ENV_VARS; do
		VAR_NAME=$(echo "$env_var" | jq -r '.name')
		VAR_VALUE=$(echo "$env_var" | jq -r '.value // empty')
		if [ -n "$VAR_NAME" ] && [ -n "$VAR_VALUE" ]; then
			export "${VAR_NAME}=${VAR_VALUE}"
			bashio::log.info "Set environment variable: $VAR_NAME"
		fi
	done
fi

declare ADDON_PROTOCOL=http
if bashio::config.true 'ssl'; then
	ADDON_PROTOCOL=https
fi

ingress_port=$(bashio::addon.ingress_port)
ingress_interface=$(bashio::addon.ip_address)
sed -i "s|%%protocol%%|${ADDON_PROTOCOL}|g" /etc/nginx/servers/ingress.conf
sed -i "s|%%port%%|${ingress_port}|g" /etc/nginx/servers/ingress.conf
sed -i "s|%%interface%%|${ingress_interface}|g" /etc/nginx/servers/ingress.conf
mkdir -p /var/log/nginx && touch /var/log/nginx/error.log

for folders in /etc/services.d /etc/s6-overlay; do
	[[ -d "$folders" ]] && rm -r "$folders"
done

bashio::log.info "Starting OpenCode web server..."

cd "$WORKSPACE" || {
	bashio::log.fatal "Cannot change to workspace directory: $WORKSPACE"
	exit 1
}

opencode web --hostname 0.0.0.0 --port 8080 &
bashio::net.wait_for 8080 localhost 900 || true
bashio::log.info "OpenCode web server started!"
nginx || bashio::log.fatal "Nginx failed"
