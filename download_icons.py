#!/usr/bin/env python3
"""
Smart icon downloader for addons with fallback strategies.
Attempts multiple sources for each addon before giving up.
"""

import os
import subprocess
import sys
import time
from pathlib import Path

# Addons with known icon URLs or sources
ICON_URLS = {
    # Servarr apps - use official logos
    "sonarr": ["https://raw.githubusercontent.com/Servarr/Sonarr/develop/Logo.png"],
    "radarr": ["https://raw.githubusercontent.com/Servarr/Radarr/develop/Logo.png"],
    "lidarr": ["https://raw.githubusercontent.com/Servarr/Lidarr/develop/Logo.png"],
    "readarr": ["https://raw.githubusercontent.com/Servarr/Readarr/develop/Logo.png"],
    "prowlarr": ["https://raw.githubusercontent.com/Servarr/Prowlarr/develop/Logo.png"],
    
    # Major projects
    "jellyfin": ["https://raw.githubusercontent.com/jellyfin/jellyfin/master/Logo.png"],
    "nextcloud": ["https://raw.githubusercontent.com/nextcloud/server/master/core/img/logos/logo.png"],
    "nginx": ["https://nginx.org/nginx.png"],
    "fail2ban": ["https://raw.githubusercontent.com/fail2ban/fail2ban/master/logo.svg"],
    "code-server": ["https://raw.githubusercontent.com/coder/code-server/main/src/branding/logo.png"],
    "openvscode-server": ["https://raw.githubusercontent.com/eclipse-openvscode-server/openvscode-server/main/resources/linux/code.png"],
    "qbittorrent": ["https://raw.githubusercontent.com/qbittorrent/qBittorrent/master/src/icons/qbittorrent.png"],
    "transmission": ["https://raw.githubusercontent.com/transmission/transmission/main/web/images/favicon.png"],
    "deluge": ["https://raw.githubusercontent.com/deluge-torrent/deluge/master/deluge/ui/data/pixmaps/deluge.png"],
    "sabnzbd": ["https://raw.githubusercontent.com/sabnzbd/sabnzbd/develop/icons/sabnzbd.png"],
    "calibre": ["https://raw.githubusercontent.com/kovidgoyal/calibre/master/resources/images/logo.png"],
    "calibre-web": ["https://raw.githubusercontent.com/janeczku/calibre-web/master/cps/static/img/calibre-web.png"],
    "mariadb": ["https://raw.githubusercontent.com/MariaDB/mariadb-docker/master/logo.png"],
    "homeassistant": ["https://raw.githubusercontent.com/home-assistant/home-assistant.io/master/source/images/logos/home-assistant-logo.png"],
}

# Generic fallback URL patterns to try for each addon (using linuxserver docker repos)
FALLBACK_PATTERNS = [
    "https://raw.githubusercontent.com/linuxserver/docker-{slug}/master/logo.png",
    "https://raw.githubusercontent.com/linuxserver/docker-{slug}/master/Logo.png",
    "https://raw.githubusercontent.com/linuxserver/docker-{slug}/main/logo.png",
    "https://raw.githubusercontent.com/linuxserver/docker-{slug}/develop/logo.png",
]

def download_icon(addon_name, icon_path):
    """Attempt to download icon from multiple sources"""
    
    # Get list of URLs to try
    urls_to_try = []
    
    # First, try known URLs
    if addon_name in ICON_URLS:
        urls_to_try.extend(ICON_URLS[addon_name])
    
    # Then try generic fallback patterns
    for pattern in FALLBACK_PATTERNS:
        urls_to_try.append(pattern.format(slug=addon_name))
    
    # Try each URL
    for i, url in enumerate(urls_to_try):
        try:
            # Download with curl
            result = subprocess.run(
                ['curl', '-sL', '-f', '--max-time', '5', '--user-agent', 
                 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', 
                 url, '-o', str(icon_path)],
                capture_output=True,
                timeout=10
            )
            
            if result.returncode != 0:
                continue
            
            # Verify it's a valid image file
            result = subprocess.run(
                ['file', str(icon_path)],
                capture_output=True,
                text=True
            )
            
            if 'image' in result.stdout.lower():
                print(f"  ✓ Downloaded from attempt {i+1}")
                return True
            else:
                # Not a valid image, try next URL
                continue
        except:
            continue
    
    return False

def main():
    repo_root = Path(".")
    
    # List of 74 addons that need icon fixes
    problematic_addons = [
        "adguardhome-sync", "airsonic-advanced", "apprise-api", "babybuddy",
        "bookstack", "calibre", "calibre-web", "changedetection", "davos",
        "ddclient", "diskover", "dokuwiki", "doplarr", "duckdns", "duplicati",
        "emby", "faster-whisper", "ferdium", "flexget", "freshrss", "grav",
        "grocy", "habridge", "haproxy", "healthchecks", "hedgedoc", "heimdall",
        "htpcmanager", "jackett", "kavita", "kometa", "ldap-auth", "librespeed",
        "lightrag", "lychee", "manyfold", "mastodon", "medusa", "minisatip",
        "monica", "mstream", "mylar3", "netbox", "nginx", "nzbget", "nzbhydra2",
        "obsidian", "ombi", "opencode", "openssh-server", "overseerr", "pairdrop",
        "piwigo", "planka", "plex", "projectsend", "pwndrop", "pydio-cells",
        "pyload-ng", "raneto", "resilio-sync", "rsnapshot", "sealskin", "sickgear",
        "smokeping", "speedtest-tracker", "spotube", "swag", "syncthing", "tautulli",
        "tvheadend", "ubooquity", "webgrabplus", "wikijs", "wireguard", "xbackbone"
    ]
    
    print(f"🎯 Attempting to download correct icons for {len(problematic_addons)} addons...\n")
    
    success = 0
    failed = 0
    
    for i, addon in enumerate(problematic_addons, 1):
        addon_path = repo_root / addon
        icon_path = addon_path / "icon.png"
        
        if not addon_path.exists():
            print(f"[{i:2d}/{len(problematic_addons)}] {addon:35} ✗ (dir not found)")
            failed += 1
            continue
        
        print(f"[{i:2d}/{len(problematic_addons)}] {addon:35} ", end="", flush=True)
        
        if download_icon(addon, icon_path):
            success += 1
        else:
            print(f"✗ (all sources failed)")
            failed += 1
        
        # Rate limit to avoid overwhelming servers
        time.sleep(0.5)
    
    print(f"\n{'='*60}")
    print(f"✓ ICON DOWNLOAD ATTEMPT COMPLETE")
    print(f"{'='*60}")
    print(f"Successfully updated: {success}")
    print(f"Failed to find icons: {failed}")
    print(f"\nNext: Review icon changes with 'git diff' and commit")

if __name__ == "__main__":
    main()
