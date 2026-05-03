#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

# --- Timezone ---
if bashio::config.has_value 'TZ'; then
    TIMEZONE=$(bashio::config 'TZ')
    bashio::log.info "Setting timezone to $TIMEZONE"
    if [ -f /usr/share/zoneinfo/"$TIMEZONE" ]; then
        ln -snf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime
        echo "$TIMEZONE" > /etc/timezone
    fi
fi

# --- Git SSH key setup ---
if bashio::config.has_value 'git_ssh_key'; then
    bashio::log.info "Configuring SSH key for git authentication"
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    bashio::config 'git_ssh_key' > /root/.ssh/id_ed25519
    chmod 600 /root/.ssh/id_ed25519
    ssh-keyscan -t ed25519 github.com gitlab.com bitbucket.org 2> /dev/null > /root/.ssh/known_hosts
    chmod 644 /root/.ssh/known_hosts
    bashio::log.info "SSH key configured successfully"
else
    bashio::log.info "No SSH key configured (public repos only, or use git_token)"
fi

# --- Git token setup ---
GIT_TOKEN=""
if bashio::config.has_value 'git_token'; then
    GIT_TOKEN=$(bashio::config 'git_token')
    bashio::log.info "Git token configured for HTTPS authentication"
fi

# --- Clone repositories ---
REPOS=$(bashio::config 'repositories')
if [ -n "$REPOS" ] && [ "$REPOS" != "[]" ]; then
    bashio::log.info "Processing repositories..."
    REPO_COUNT=$(echo "$REPOS" | jq 'length')
    for i in $(seq 0 $((REPO_COUNT - 1))); do
        REPO_URL=$(echo "$REPOS" | jq -r ".[$i].url")
        REPO_BRANCH=$(echo "$REPOS" | jq -r ".[$i].branch // empty")
        REPO_PATH=$(echo "$REPOS" | jq -r ".[$i].path")

        if [ -z "$REPO_PATH" ]; then
            bashio::log.warning "Repository entry $i has no path, skipping"
            continue
        fi

        CLONE_URL="$REPO_URL"
        if [ -n "$GIT_TOKEN" ] && [[ "$REPO_URL" == https://github.com* ]]; then
            CLONE_URL=$(echo "$REPO_URL" | sed "s|https://|https://x-access-token:${GIT_TOKEN}@|")
        fi

        if [ -d "$REPO_PATH/.git" ]; then
            bashio::log.info "Updating existing repository: $REPO_PATH"
            cd "$REPO_PATH" || {
                bashio::log.warning "Cannot cd to $REPO_PATH, skipping"
                continue
            }
            git fetch --all --prune 2>&1 || bashio::log.warning "git fetch failed for $REPO_PATH"
            if [ -n "$REPO_BRANCH" ]; then
                git checkout "$REPO_BRANCH" 2>&1 || bashio::log.warning "git checkout $REPO_BRANCH failed"
                git pull origin "$REPO_BRANCH" 2>&1 || bashio::log.warning "git pull failed for $REPO_PATH"
            else
                git pull 2>&1 || bashio::log.warning "git pull failed for $REPO_PATH"
            fi
        else
            bashio::log.info "Cloning repository: $REPO_URL -> $REPO_PATH"
            mkdir -p "$(dirname "$REPO_PATH")"
            CLONE_ARGS=""
            if [ -n "$REPO_BRANCH" ]; then
                CLONE_ARGS="-b $REPO_BRANCH"
            fi
            git clone $CLONE_ARGS "$CLONE_URL" "$REPO_PATH" 2>&1 || {
                bashio::log.fatal "Failed to clone $REPO_URL"
                continue
            }
            bashio::log.info "Successfully cloned $REPO_URL"
        fi
    done
    cd / || true
else
    bashio::log.info "No repositories configured"
fi

# --- Dev profile ---
DEV_PROFILE=$(bashio::config 'dev_profile')
PROFILE_PACKAGES=""

if echo "$DEV_PROFILE" | jq -e 'index("python")' > /dev/null 2>&1; then
    PROFILE_PACKAGES="$PROFILE_PACKAGES python3 python3-pip python3-venv"
    bashio::log.info "Python profile selected: installing python3, pip, venv"
fi

if echo "$DEV_PROFILE" | jq -e 'index("node")' > /dev/null 2>&1; then
    PROFILE_PACKAGES="$PROFILE_PACKAGES nodejs npm"
    bashio::log.info "Node profile selected: installing nodejs, npm"
fi

if echo "$DEV_PROFILE" | jq -e 'index("full")' > /dev/null 2>&1; then
    PROFILE_PACKAGES="$PROFILE_PACKAGES python3 python3-pip python3-venv nodejs npm build-essential pkg-config libffi-dev libssl-dev"
    bashio::log.info "Full profile selected: installing all dev tools"
fi

if [ -n "$PROFILE_PACKAGES" ]; then
    bashio::log.info "Installing profile packages: $PROFILE_PACKAGES"
    apt-get update -qq \
        && apt-get install -y --no-install-recommends $PROFILE_PACKAGES 2>&1 | tail -5 \
        && rm -rf /var/lib/apt/lists/*
    bashio::log.info "Profile packages installed"
fi

# --- Custom packages ---
if bashio::config.has_value 'custom_packages'; then
    CUSTOM_PKGS=$(bashio::config 'custom_packages')
    bashio::log.info "Installing custom packages: $CUSTOM_PKGS"
    apt-get update -qq \
        && apt-get install -y --no-install-recommends $CUSTOM_PKGS 2>&1 | tail -5 \
        && rm -rf /var/lib/apt/lists/*
    bashio::log.info "Custom packages installed"
fi

# --- Workspace ---
WORKSPACE=$(bashio::config 'workspace')
if [ -z "$WORKSPACE" ]; then
    WORKSPACE="/homeassistant"
fi

if [ ! -d "$WORKSPACE" ]; then
    bashio::log.warning "Workspace directory $WORKSPACE does not exist, creating it"
    mkdir -p "$WORKSPACE"
fi

bashio::log.info "Workspace set to $WORKSPACE"

# --- OpenCode config ---
CONFIG_DIR="/config"
mkdir -p "$CONFIG_DIR"

OPENCODE_CONFIG="${CONFIG_DIR}/opencode.json"

cat > "$OPENCODE_CONFIG" << 'JSONEOF'
{
  "$schema": "https://opencode.ai/config.json",
  "autoupdate": false,
  "server": {
    "port": 8081,
    "hostname": "0.0.0.0"
  }
}
JSONEOF

bashio::log.info "Generated opencode config at $OPENCODE_CONFIG"

export OPENCODE_CONFIG_DIR="${CONFIG_DIR}"

# --- Server password ---
if bashio::config.has_value 'server_password'; then
    export OPENCODE_SERVER_PASSWORD=$(bashio::config 'server_password')
    bashio::log.info "Server password protection enabled"
else
    bashio::log.warning "No server password set - OpenCode web UI is unsecured"
fi

# --- Custom env vars ---
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

# --- Cleanup S6 ---
for folders in /etc/services.d /etc/s6-overlay; do
    [[ -d "$folders" ]] && rm -r "$folders"
done

# --- Configure git defaults ---
git config --global user.email "opencode@homeassistant" 2> /dev/null || true
git config --global user.name "OpenCode" 2> /dev/null || true
git config --global init.defaultBranch main 2> /dev/null || true
bashio::log.info "Git configured (user: OpenCode, email: opencode@homeassistant)"

# --- Start servers ---
cd "$WORKSPACE" || {
    bashio::log.fatal "Cannot change to workspace directory: $WORKSPACE"
    exit 1
}

bashio::log.info "Starting ingress landing page on port 8080..."
cd /var/www && python3 -m http.server 8080 --bind 0.0.0.0 &
cd "$WORKSPACE"

bashio::log.info "Starting OpenCode on port 8081 (mapped to host port 8230)..."
exec opencode web --hostname 0.0.0.0 --port 8081
