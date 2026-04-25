#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail

REPOSITORY="${GITHUB_REPOSITORY:-rezusnet/hassio-addons}"
GITUSER="${GITUSER:-github-actions[bot]}"
GITMAIL="${GITMAIL:-${GITUSER}@users.noreply.github.com}"
DRY_RUN="${DRY_RUN:-false}"
VERBOSE="${VERBOSE:-true}"
GH_TOKEN="${GH_TOKEN:-}"

WORKDIR="/tmp/updater-repo"

log() {
    if [ "$VERBOSE" = "true" ]; then
        echo "$*"
    fi
}

warn() {
    echo "WARNING: $*" >&2
}

github_api() {
    local endpoint="$1"
    local url="https://api.github.com/${endpoint}"
    if [ -n "$GH_TOKEN" ]; then
        curl -sfH "Authorization: token ${GH_TOKEN}" -H "Accept: application/vnd.github+json" "$url" 2>/dev/null
    else
        curl -sfH "Accept: application/vnd.github+json" "$url" 2>/dev/null
    fi
}

fetch_github_release_version() {
    local repo="$1"
    local include_prerelease="$2"
    local endpoint

    if [ "$include_prerelease" = "true" ]; then
        endpoint="repos/${repo}/releases?per_page=1"
    else
        endpoint="repos/${repo}/releases?per_page=100"
    fi

    local response
    response=$(github_api "$endpoint") || return 1
    [ -z "$response" ] && return 1

    local releases
    releases=$(echo "$response" | jq -r '.[].tag_name' 2>/dev/null) || return 1
    [ -z "$releases" ] && return 1

    if [ "$include_prerelease" != "true" ]; then
        while IFS= read -r tag; do
            [ -z "$tag" ] && continue
            [[ "$tag" =~ -(rc|beta|alpha|dev|pre) ]] && continue
            echo "$tag"
            return 0
        done <<< "$releases"
    else
        echo "$releases" | head -1
        return 0
    fi

    return 1
}

fetch_github_tags_version() {
    local repo="$1"

    local response
    response=$(github_api "repos/${repo}/tags?per_page=100") || return 1
    [ -z "$response" ] && return 1

    local tags
    tags=$(echo "$response" | jq -r '.[].name' 2>/dev/null) || return 1
    [ -z "$tags" ] && return 1

    while IFS= read -r tag; do
        [ -z "$tag" ] && continue
        [[ "$tag" =~ -(rc|beta|alpha|dev|pre) ]] && continue
        echo "$tag"
        return 0
    done <<< "$tags"

    return 1
}

fetch_dockerhub_version() {
    local repo="$1"
    local tag_filter="$2"

    local api_url="https://hub.docker.com/v2/repositories/${repo}/tags?page_size=100&ordering=last_updated"
    local response
    response=$(curl -sf "$api_url" 2>/dev/null) || return 1

    local full_tag
    full_tag=$(echo "$response" | python3 -c "
import json, sys, re
data = json.load(sys.stdin)
tag_filter = '${tag_filter}'
for tag in data.get('results', []):
    name = tag['name']
    if not name:
        continue
    if re.search(r'dev|rc|beta|alpha|lts', name, re.IGNORECASE):
        continue
    if tag_filter and tag_filter not in name:
        continue
    base = name.split(tag_filter)[0] if tag_filter else name
    if not re.match(r'^\d+\.\d+\.\d+', base):
        continue
    print(name)
    break
" 2>/dev/null) || return 1

    [ -z "$full_tag" ] && return 1

    local version="$full_tag"
    if [ -n "$tag_filter" ]; then
        version="${full_tag%%${tag_filter}*}"
    fi
    version="${version#v}"

    echo "v${version}"
}

trigger_workflow() {
    local workflow="$1"
    if [ -n "$GH_TOKEN" ]; then
        local http_code
        http_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
            -H "Authorization: token ${GH_TOKEN}" \
            -H "Accept: application/vnd.github+json" \
            "https://api.github.com/repos/${REPOSITORY}/actions/workflows/${workflow}/dispatches" \
            -d '{"ref":"master"}' 2>/dev/null) || true
        if [ "$http_code" = "204" ]; then
            log "  Builder workflow triggered successfully"
        else
            warn "Could not trigger builder workflow (HTTP $http_code)"
        fi
    fi
}

git config --global user.name "$GITUSER"
git config --global user.email "$GITMAIL"

rm -rf "$WORKDIR"
log "Cloning ${REPOSITORY}..."
if [ -n "$GH_TOKEN" ]; then
    git clone "https://x-access-token:${GH_TOKEN}@github.com/${REPOSITORY}.git" "$WORKDIR" 2>&1 | tail -1
else
    git clone "https://github.com/${REPOSITORY}.git" "$WORKDIR" 2>&1 | tail -1
fi
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

    log "Checking $SLUG ($UPSTREAM_REPO, source=$SOURCE) — current: ${CURRENT_VERSION:-none}"

    NEW_VERSION=""

    case "$SOURCE" in
        github)
            GITHUB_BETA=$(jq -r '.github_beta // false' "$UPDATER_FILE")
            NEW_VERSION=$(fetch_github_release_version "$UPSTREAM_REPO" "$GITHUB_BETA") || {
                warn "  Failed to fetch GitHub releases for $UPSTREAM_REPO"
                NEW_VERSION=""
            }
            ;;
        github_tags)
            NEW_VERSION=$(fetch_github_tags_version "$UPSTREAM_REPO") || {
                warn "  Failed to fetch GitHub tags for $UPSTREAM_REPO"
                NEW_VERSION=""
            }
            ;;
        dockerhub)
            DOCKERHUB_FILTER=$(jq -r '.dockerhub_tag_filter // ""' "$UPDATER_FILE")
            NEW_VERSION=$(fetch_dockerhub_version "$UPSTREAM_REPO" "$DOCKERHUB_FILTER") || {
                warn "  Failed to fetch Docker Hub tags for $UPSTREAM_REPO"
                NEW_VERSION=""
            }
            ;;
        *)
            warn "  Unknown source '$SOURCE' for $SLUG"
            ;;
    esac

    [ -z "$NEW_VERSION" ] && { log "  No new version found"; continue; }

    CURRENT_VERSION_CLEAN="${CURRENT_VERSION#v}"
    NEW_VERSION_CLEAN="${NEW_VERSION#v}"

    [ "$NEW_VERSION_CLEAN" = "$CURRENT_VERSION_CLEAN" ] && { log "  Already up to date"; continue; }

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
    trigger_workflow "onpush_builder.yaml" || warn "Could not trigger builder workflow"
fi

rm -rf "$WORKDIR"
log "Done."
