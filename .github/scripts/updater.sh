#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail

REPOSITORY="${GITHUB_REPOSITORY:-rezusnet/hassio-addons}"
GITUSER="${GITUSER:-$(gh api user --jq .login 2>/dev/null || echo "github-actions[bot]")}"
GITMAIL="${GITMAIL:-${GITUSER}@users.noreply.github.com}"
DRY_RUN="${DRY_RUN:-false}"
VERBOSE="${VERBOSE:-true}"

WORKDIR="/tmp/updater-repo"

log() {
    if [ "$VERBOSE" = "true" ]; then
        echo "$*"
    fi
}

git config --global user.name "$GITUSER"
git config --global user.email "$GITMAIL"
git config --global credential.helper '!gh auth git-credential'

rm -rf "$WORKDIR"
log "Cloning ${REPOSITORY}..."
git clone "https://github.com/${REPOSITORY}.git" "$WORKDIR" 2>&1 | tail -1
cd "$WORKDIR"

CHANGES_PUSHED=false

for addon_dir in */; do
    [ -f "$addon_dir/updater.json" ] || continue

    UPDATER_FILE="$addon_dir/updater.json"
    PAUSED=$(jq -r '.paused // false' "$UPDATER_FILE")
    [ "$PAUSED" = "true" ] && { log "Skipping $addon_dir (paused)"; continue; }

    SLUG=$(jq -r '.slug // ""' "$UPDATER_FILE")
    UPSTREAM_REPO=$(jq -r '.upstream_repo // ""' "$UPDATER_FILE")
    SOURCE=$(jq -r '.source // "github"' "$UPDATER_FILE")
    CURRENT_VERSION=$(jq -r '.upstream_version // ""' "$UPDATER_FILE")

    [ -z "$UPSTREAM_REPO" ] && { log "Skipping $addon_dir (no upstream_repo)"; continue; }

    log "Checking $SLUG ($UPSTREAM_REPO) — current: ${CURRENT_VERSION:-none}"

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

    [ -z "$NEW_VERSION" ] && { log "  No new version found"; continue; }
    [ "$NEW_VERSION" = "$CURRENT_VERSION" ] && { log "  Already up to date"; continue; }

    NEW_VERSION_CLEAN="${NEW_VERSION#v}"
    echo "Updating $SLUG from ${CURRENT_VERSION:-none} to $NEW_VERSION"

    if [ "$DRY_RUN" != "true" ]; then
        if [ -f "$addon_dir/config.yaml" ]; then
            sed -i "s/^version:.*/version: \"${NEW_VERSION_CLEAN}\"/" "$addon_dir/config.yaml"
        elif [ -f "$addon_dir/config.json" ]; then
            jq --arg v "$NEW_VERSION_CLEAN" '.version = $v' "$addon_dir/config.json" > tmp.json && mv tmp.json "$addon_dir/config.json"
        fi

        DATE=$(date '+%Y-%m-%d')
        jq --arg d "$DATE" --arg v "$NEW_VERSION" '.last_update = $d | .upstream_version = $v' "$UPDATER_FILE" > tmp.json && mv tmp.json "$UPDATER_FILE"

        if [ -f "$addon_dir/CHANGELOG.md" ]; then
            sed -i "1i\\## ${NEW_VERSION_CLEAN} (${DATE})\n- Update to latest version from ${UPSTREAM_REPO}\n" "$addon_dir/CHANGELOG.md"
        fi

        git add -A
        git commit -m "Update ${SLUG} to ${NEW_VERSION_CLEAN}" || true
    fi
done

if [ "$DRY_RUN" != "true" ] && [ "$(git log --oneline origin/master..HEAD 2>/dev/null | wc -l)" -gt 0 ]; then
    log "Pushing updates to master..."
    git push origin HEAD:master
    CHANGES_PUSHED=true
fi

if [ "$CHANGES_PUSHED" = "true" ]; then
    log "Triggering builder workflow..."
    gh workflow run onpush_builder.yaml --ref master || log "WARNING: Could not trigger builder workflow"
fi

rm -rf "$WORKDIR"
log "Done."
