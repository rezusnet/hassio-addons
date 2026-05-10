#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail

REPOSITORY="${GITHUB_REPOSITORY:-rezusnet/hassio-addons}"
DRY_RUN="${DRY_RUN:-false}"
VERBOSE="${VERBOSE:-true}"
GH_TOKEN="${GH_TOKEN:-}"
GITHUB_OUTPUT="${GITHUB_OUTPUT:-/dev/null}"
GITHUB_WORKSPACE="${GITHUB_WORKSPACE:-.}"

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
    local major_version="${3:-}"
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
            [[ "$tag" =~ ^nightly ]] && continue
            matches_major_version "$tag" "$major_version" || continue
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
    local major_version="${2:-}"

    local response
    response=$(github_api "repos/${repo}/tags?per_page=100") || return 1
    [ -z "$response" ] && return 1

    local tags
    tags=$(echo "$response" | jq -r '.[].name' 2>/dev/null) || return 1
    [ -z "$tags" ] && return 1

    while IFS= read -r tag; do
        [ -z "$tag" ] && continue
        [[ "$tag" =~ -(rc|beta|alpha|dev|pre) ]] && continue
        [[ "$tag" =~ ^nightly ]] && continue
        matches_major_version "$tag" "$major_version" || continue
        echo "$tag"
        return 0
    done <<< "$tags"

    return 1
}

fetch_dockerhub_version() {
    local repo="$1"
    local tag_filter="$2"
    local major_version="${3:-}"

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
    major_version = '${major_version}'
    if major_version:
        m = re.match(r'v?(\d+)', name)
        if m and m.group(1) != major_version:
            continue
    print(name)
    break
" 2>/dev/null) || return 1

    [ -z "$full_tag" ] && return 1

    local version="$full_tag"
    if [ -n "$tag_filter" ]; then
        version="${full_tag%%"${tag_filter}"*}"
    fi
    version="${version#v}"

    echo "v${version}"
}

matches_major_version() {
    local tag="$1"
    local major="$2"
    [ -z "$major" ] && return 0
    local ver="${tag#v}"
    local tag_major="${ver%%.*}"
    [ "$tag_major" = "$major" ]
}

compute_config_version() {
    local upstream_version="$1"
    local config_extract="$2"

    local ver="${upstream_version#v}"

    if [ "$config_extract" = "semver" ]; then
        ver=$(echo "$ver" | grep -oP '^\d+\.\d+\.\d+' || echo "$ver")
    fi

    echo "$ver"
}

compute_tag_version() {
    local upstream_version="$1"
    local tag_keep_v="$2"

    if [ "$tag_keep_v" = "true" ]; then
        echo "$upstream_version"
    else
        echo "${upstream_version#v}"
    fi
}

verify_tag_exists() {
    local image_tag="$1"

    if command -v skopeo >/dev/null 2>&1; then
        skopeo inspect "docker://${image_tag}" >/dev/null 2>&1
        return $?
    fi

    local repo="${image_tag%%:*}"
    local tag="${image_tag##*:}"
    local domain="${repo%%/*}"

    if [[ "$domain" == *"ghcr.io"* ]]; then
        local path="${repo#ghcr.io/}"
        local token
        token=$(curl -sf "https://ghcr.io/token?scope=repository:${path}:pull" 2>/dev/null | jq -r '.token' 2>/dev/null) || return 1
        [ -z "$token" ] && return 1
        local http_code
        http_code=$(curl -s -o /dev/null -w "%{http_code}" \
            -H "Authorization: Bearer ${token}" \
            -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
            "https://ghcr.io/v2/${path}/manifests/${tag}" 2>/dev/null) || return 1
        [ "$http_code" = "200" ]
        return $?
    fi

    if [[ "$domain" != *"ghcr.io"* ]]; then
        local normalized_repo="${repo}"
        [[ "$normalized_repo" != *"/"* ]] && normalized_repo="library/${normalized_repo}"
        local http_code
        http_code=$(curl -s -o /dev/null -w "%{http_code}" \
            "https://hub.docker.com/v2/repositories/${normalized_repo}/tags/${tag}" 2>/dev/null) || return 1
        [ "$http_code" = "200" ]
        return $?
    fi

    curl -sf -o /dev/null "https://registry-1.docker.io/v2/${repo}/manifests/${tag}" 2>/dev/null
    return $?
}

update_build_json() {
    local addon_dir="$1"
    local strategy="$2"
    local image_prefix="$3"
    local tag_ver="$4"
    local tag_suffix="$5"

    local build_file="${addon_dir}/build.json"
    [ -f "$build_file" ] || return 0

    case "$strategy" in
        lsio-latest | dockerfile)
            return 0
            ;;
        lsio-pinned)
            local new_json
            new_json=$(jq -n \
                --arg aarch64 "${image_prefix}:arm64v8-${tag_ver}" \
                --arg amd64 "${image_prefix}:amd64-${tag_ver}" \
                '{"build_from":{"aarch64":$aarch64,"amd64":$amd64}}')
            echo "$new_json" > "$build_file"
            ;;
        direct)
            local new_json
            new_json=$(jq -n \
                --arg tag "${image_prefix}:${tag_ver}" \
                '{"build_from":{"aarch64":$tag,"amd64":$tag}}')
            echo "$new_json" > "$build_file"
            ;;
        suffix)
            local new_json
            new_json=$(jq -n \
                --arg tag "${image_prefix}:${tag_ver}${tag_suffix}" \
                '{"build_from":{"aarch64":$tag,"amd64":$tag}}')
            echo "$new_json" > "$build_file"
            ;;
        *)
            warn "  Unknown tag_strategy '$strategy' for build.json update"
            ;;
    esac
}

get_image_prefix() {
    local addon_dir="$1"
    local strategy="$2"

    local build_file="${addon_dir}/build.json"
    if [ -f "$build_file" ]; then
        local first_tag
        first_tag=$(jq -r '.build_from | to_entries | .[0].value' "$build_file" 2>/dev/null || echo "")
        if [ -n "$first_tag" ]; then
            echo "${first_tag%%:*}"
            return 0
        fi
    fi

    echo ""
}

update_config_version() {
    local addon_dir="$1"
    local new_version="$2"

    local config_file=""
    for f in config.yaml config.yml config.json; do
        if [ -f "${addon_dir}/${f}" ]; then
            config_file="${addon_dir}/${f}"
            break
        fi
    done
    [ -z "$config_file" ] && return 1

    case "$config_file" in
        *.yaml | *.yml)
            sed -i "s|^version:.*|version: \"${new_version}\"|" "$config_file"
            ;;
        *.json)
            local tmp
            tmp=$(jq --arg v "$new_version" '.version = $v' "$config_file") && echo "$tmp" > "$config_file"
            ;;
    esac
}

get_sample_tag() {
    local strategy="$1"
    local image_prefix="$2"
    local tag_ver="$3"
    local tag_suffix="$4"

    case "$strategy" in
        lsio-latest | dockerfile)
            echo ""
            ;;
        lsio-pinned)
            echo "${image_prefix}:amd64-${tag_ver}"
            ;;
        direct)
            echo "${image_prefix}:${tag_ver}"
            ;;
        suffix)
            echo "${image_prefix}:${tag_ver}${tag_suffix}"
            ;;
        *)
            echo ""
            ;;
    esac
}

CHANGES=""
CHANGES_COUNT=0

cd "$GITHUB_WORKSPACE"

for addon_dir in */; do
    [ -f "$addon_dir/updater.json" ] || continue

    UPDATER_FILE="$addon_dir/updater.json"
    PAUSED=$(jq -r '.paused // false' "$UPDATER_FILE")
    [ "$PAUSED" = "true" ] && { log "Skipping $addon_dir (paused)"; continue; }

    SLUG=$(jq -r '.slug // ""' "$UPDATER_FILE")
    UPSTREAM_REPO=$(jq -r '.upstream_repo // ""' "$UPDATER_FILE")
    SOURCE=$(jq -r '.source // "github"' "$UPDATER_FILE")
    CURRENT_VERSION=$(jq -r '.upstream_version // ""' "$UPDATER_FILE")
    TAG_STRATEGY=$(jq -r '.tag_strategy // ""' "$UPDATER_FILE")
    TAG_SUFFIX=$(jq -r '.tag_suffix // ""' "$UPDATER_FILE")
    TAG_KEEP_V=$(jq -r '.tag_keep_v // false' "$UPDATER_FILE")
    CONFIG_EXTRACT=$(jq -r '.config_extract // ""' "$UPDATER_FILE")
    MAJOR_VERSION=$(jq -r '.major_version // ""' "$UPDATER_FILE")

    [ -z "$UPSTREAM_REPO" ] && { log "Skipping $addon_dir (no upstream_repo)"; continue; }
    [ -z "$TAG_STRATEGY" ] && { log "Skipping $addon_dir (no tag_strategy)"; continue; }

    log "Checking $SLUG ($UPSTREAM_REPO, source=$SOURCE, strategy=$TAG_STRATEGY) — current: ${CURRENT_VERSION:-none}"

    NEW_VERSION=""

    case "$SOURCE" in
        github)
            GITHUB_BETA=$(jq -r '.github_beta // false' "$UPDATER_FILE")
            NEW_VERSION=$(fetch_github_release_version "$UPSTREAM_REPO" "$GITHUB_BETA" "$MAJOR_VERSION") || {
                warn "  Failed to fetch GitHub releases for $UPSTREAM_REPO"
                NEW_VERSION=""
            }
            ;;
        github_tags)
            NEW_VERSION=$(fetch_github_tags_version "$UPSTREAM_REPO" "$MAJOR_VERSION") || {
                warn "  Failed to fetch GitHub tags for $UPSTREAM_REPO"
                NEW_VERSION=""
            }
            ;;
        dockerhub)
            DOCKERHUB_FILTER=$(jq -r '.dockerhub_tag_filter // ""' "$UPDATER_FILE")
            NEW_VERSION=$(fetch_dockerhub_version "$UPSTREAM_REPO" "$DOCKERHUB_FILTER" "$MAJOR_VERSION") || {
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

    CONFIG_VERSION=$(compute_config_version "$NEW_VERSION" "$CONFIG_EXTRACT")
    TAG_VERSION=$(compute_tag_version "$NEW_VERSION" "$TAG_KEEP_V")

    IMAGE_PREFIX=$(get_image_prefix "$addon_dir" "$TAG_STRATEGY")

    SAMPLE_TAG=$(get_sample_tag "$TAG_STRATEGY" "$IMAGE_PREFIX" "$TAG_VERSION" "$TAG_SUFFIX")
    if [ -n "$SAMPLE_TAG" ]; then
        log "  Verifying tag: $SAMPLE_TAG"
        if ! verify_tag_exists "$SAMPLE_TAG"; then
            warn "  Tag $SAMPLE_TAG does not exist on registry, skipping $SLUG"
            continue
        fi
        log "  Tag verified"
    fi

    echo "Updating $SLUG: ${CURRENT_VERSION:-none} → $NEW_VERSION (config: $CONFIG_VERSION)"

    if [ "$DRY_RUN" != "true" ]; then
        DATE=$(date '+%Y-%m-%d')
        jq --arg d "$DATE" --arg v "$NEW_VERSION" '.last_update = $d | .upstream_version = $v' "$UPDATER_FILE" > tmp.json && mv tmp.json "$UPDATER_FILE"

        update_build_json "$addon_dir" "$TAG_STRATEGY" "$IMAGE_PREFIX" "$TAG_VERSION" "$TAG_SUFFIX"

        update_config_version "$addon_dir" "$CONFIG_VERSION"

        if [ -f "$addon_dir/CHANGELOG.md" ]; then
            sed -i "1i\\## ${CONFIG_VERSION} (${DATE})\n- Update to upstream ${NEW_VERSION}\n" "$addon_dir/CHANGELOG.md"
        fi
    fi

    CHANGES="${CHANGES}- **${SLUG}**: \`${CURRENT_VERSION:-none}\` → \`${NEW_VERSION}\`\n"
    CHANGES_COUNT=$((CHANGES_COUNT + 1))
done

if [ "$GITHUB_OUTPUT" != "/dev/null" ]; then
    DATE_STAMP=$(date '+%Y-%m-%d')
    DATE_STAMP_COMPACT=$(date '+%Y%m%d')
    echo "date_stamp=${DATE_STAMP}" >> "$GITHUB_OUTPUT"
    echo "date_stamp_compact=${DATE_STAMP_COMPACT}" >> "$GITHUB_OUTPUT"
    echo "has_updates=${CHANGES_COUNT}" >> "$GITHUB_OUTPUT"
fi

if [ -n "$CHANGES" ]; then
    echo ""
    echo "=== Summary: ${CHANGES_COUNT} addon(s) updated ==="
    echo -e "$CHANGES"
else
    log "No updates found"
fi

if [ "$GITHUB_OUTPUT" != "/dev/null" ]; then
    {
        echo "changes<<__UPDATER_EOF__"
        echo -e "$CHANGES"
        echo "__UPDATER_EOF__"
    } >> "$GITHUB_OUTPUT"
fi
