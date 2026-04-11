#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

if ! bashio::supervisor.ping 2>/dev/null; then
    echo "Running in standalone mode"
fi

REPOSITORY="$(bashio::config 'repository')"
GITUSER="$(bashio::config 'gituser')"
GITAPI="$(bashio::config 'gitapi')"
DRY_RUN="$(bashio::config 'dry_run')"
VERBOSE="$(bashio::config 'verbose')"

git config --global user.name "$GITUSER"
git config --global user.email "${GITUSER}@users.noreply.github.com"

WORKDIR="/tmp/repo"
rm -rf "$WORKDIR"
git clone "https://${GITUSER}:${GITAPI}@github.com/${REPOSITORY}.git" "$WORKDIR" 2>/dev/null
cd "$WORKDIR" || exit 1

for addon_dir in */; do
    [ -f "$addon_dir/updater.json" ] || continue
    
    UPDATER_FILE="$addon_dir/updater.json"
    PAUSED=$(jq -r '.paused // false' "$UPDATER_FILE")
    [ "$PAUSED" = "true" ] && continue
    
    SLUG=$(jq -r '.slug // ""' "$UPDATER_FILE")
    UPSTREAM_REPO=$(jq -r '.upstream_repo // ""' "$UPDATER_FILE")
    SOURCE=$(jq -r '.source // "github"' "$UPDATER_FILE")
    CURRENT_VERSION=$(jq -r '.upstream_version // ""' "$UPDATER_FILE")
    
    [ -z "$UPSTREAM_REPO" ] && continue
    
    NEW_VERSION=""
    
    if [ "$SOURCE" = "github" ]; then
        GITHUB_BETA=$(jq -r '.github_beta // false' "$UPDATER_FILE")
        if [ "$GITHUB_BETA" = "true" ]; then
            NEW_VERSION=$(lastversion "$UPSTREAM_REPO" --format tag 2>/dev/null || true)
        else
            NEW_VERSION=$(lastversion "$UPSTREAM_REPO" --format tag --stable 2>/dev/null || true)
        fi
    elif [ "$SOURCE" = "dockerhub" ]; then
        NEW_VERSION=$(lastversion "$UPSTREAM_REPO" --source dockerhub --format tag 2>/dev/null || true)
    fi
    
    [ -z "$NEW_VERSION" ] && continue
    [ "$NEW_VERSION" = "$CURRENT_VERSION" ] && continue
    
    echo "Updating $SLUG from $CURRENT_VERSION to $NEW_VERSION"
    
    if [ -z "$DRY_RUN" ] || [ "$DRY_RUN" != "true" ]; then
        NEW_VERSION_CLEAN="${NEW_VERSION#v}"
        
        if [ -f "$addon_dir/config.yaml" ]; then
            sed -i "s/^version:.*/version: \"${NEW_VERSION_CLEAN}\"/" "$addon_dir/config.yaml"
        elif [ -f "$addon_dir/config.json" ]; then
            jq --arg v "$NEW_VERSION_CLEAN" '.version = $v' "$addon_dir/config.json" > tmp.json && mv tmp.json "$addon_dir/config.json"
        fi
        
        DATE=$(date '+%Y-%m-%d')
        jq --arg d "$DATE" --arg v "$NEW_VERSION" '.last_update = $d | .upstream_version = $v' "$UPDATER_FILE" > tmp.json && mv tmp.json "$UPDATER_FILE"
        
        if [ -f "$addon_dir/CHANGELOG.md" ]; then
            sed -i "1i\## ${NEW_VERSION_CLEAN} (${DATE})\n- Update to latest version from ${UPSTREAM_REPO}\n" "$addon_dir/CHANGELOG.md"
        fi
        
        git add -A
        git commit -m "Update ${SLUG} to ${NEW_VERSION_CLEAN}" || true
        git push origin HEAD:master 2>/dev/null || true
    fi
done

rm -rf "$WORKDIR"
