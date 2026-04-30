#!/bin/bash
# Smart icon finder - uses GitHub API and web searches

REPO_ROOT="/home/tib/source/repos/github/rezusnet/hassio-addons"

# Common icon file patterns
ICON_PATTERNS=(
    "logo.png" "logo.svg" "icon.png" "icon.svg" "favicon.ico"
    "app-icon.png" "app-icon.svg" "brand.png" "brand.svg"
    "logo.jpg" "icon.jpg" "thumbnail.png"
)

find_icon_in_repo() {
    local addon=$1
    local repo=$2
    
    echo "Checking $addon from $repo"
    
    # Try GitHub API to list files
    local repo_owner_name=$(echo $repo | sed 's|https://github.com/||')
    
    for pattern in "${ICON_PATTERNS[@]}"; do
        # Try direct URLs for common paths
        for path in "." "assets" "public" "resources" "docs" "images"; do
            url="https://raw.githubusercontent.com/${repo_owner_name}/main/${path}/${pattern}"
            local response=$(curl -sS -I -w "%{http_code}" -o /dev/null --connect-timeout 5 "$url" 2>/dev/null)
            if [ "$response" = "200" ]; then
                echo "✓ Found: $url"
                return 0
            fi
            
            url="https://raw.githubusercontent.com/${repo_owner_name}/master/${path}/${pattern}"
            response=$(curl -sS -I -w "%{http_code}" -o /dev/null --connect-timeout 5 "$url" 2>/dev/null)
            if [ "$response" = "200" ]; then
                echo "✓ Found: $url"
                return 0
            fi
        done
    done
    
    echo "✗ Not found"
    return 1
}

# Test with a few addons
for addon in airsonic-advanced beets mastodon; do
    find_icon_in_repo "$addon" "https://github.com/airsonic/airsonic-advanced"
done
