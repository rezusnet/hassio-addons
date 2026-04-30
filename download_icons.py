#!/usr/bin/env python3
import os
import sys
import subprocess
import json
import hashlib
from pathlib import Path
from urllib.parse import urljoin

REPO_ROOT = Path('/home/tib/source/repos/github/rezusnet/hassio-addons')
MAX_RETRIES = 3
TIMEOUT = 30

# Icon source mappings: addon_name -> (repo_url, icon_paths_to_try)
ICON_SOURCES = {
    'adguardhome-sync': ('https://github.com/AdguardTeam/AdGuardHome-sync', [
        'logo.svg', 'icon.png', 'assets/logo.svg'
    ]),
    'airsonic-advanced': ('https://github.com/airsonic/airsonic-advanced', [
        'logo.svg', 'airsonic-ui/ui-common/public/assets/logo.svg', 'assets/logo.svg'
    ]),
    'apprise-api': ('https://github.com/caronc/apprise-api', [
        'apprise/assets/apprise-logo.png', 'logo.png', 'apprise-logo.png'
    ]),
    'audiobookshelf': ('https://github.com/advplyr/audiobookshelf', [
        'client/public/logo.svg', 'logo.svg'
    ]),
    'babybuddy': ('https://github.com/babybuddy/babybuddy', [
        'core/static/logo.png', 'logo.png', 'icon.png'
    ]),
    'beets': ('https://github.com/beetbox/beets', [
        'docs/_static/beets-logo.png', 'beets-logo.png'
    ]),
    'bookstack': ('https://github.com/BookStackApp/BookStack', [
        'resources/images/logo.png', 'logo.png'
    ]),
    'code-server': ('https://github.com/coder/code-server', [
        'resources/logo.svg', 'logo.svg'
    ]),
    'cops': ('https://github.com/seblucas/cops', [
        'res/logo.png', 'logo.png'
    ]),
    'darktable': ('https://github.com/darktable-org/darktable', [
        'src/external/logo.svg', 'logo.svg'
    ]),
    'davos': ('https://github.com/MrCryptic/Davos', [
        'icon.png', 'logo.png'
    ]),
    'ddclient': ('https://github.com/ddclient/ddclient', [
        'docs/logo.png', 'logo.png'
    ]),
    'deluge': ('https://github.com/deluge-torrent/deluge', [
        'deluge/ui/web/images/icon.png', 'icon.png'
    ]),
    'diskover': ('https://github.com/shirosaidev/diskover', [
        'docs/diskover_logo.png', 'logo.png'
    ]),
    'dokuwiki': ('https://github.com/dokuwiki/dokuwiki', [
        'images/logo.png', 'logo.png'
    ]),
    'doplarr': ('https://github.com/MrSir/doplarr', [
        'assets/doplarr.png', 'logo.png'
    ]),
    'duckdns': ('https://github.com/MrRaph84/ddclient', [
        'logo.png', 'icon.png'
    ]),
    'duplicati': ('https://github.com/duplicati/duplicati', [
        'Duplicati/GUI/Duplicati.GUI.TrayIcon/duplicati.svg', 'logo.svg'
    ]),
    'fail2ban': ('https://github.com/fail2ban/fail2ban', [
        'logo.png', 'icon.png'
    ]),
    'faster-whisper': ('https://github.com/SYSTRAN/faster-whisper', [
        'logo.png', 'icon.png'
    ]),
    'ferdium': ('https://github.com/ferdium/ferdium-app', [
        'icon.png', 'logo.svg'
    ]),
    'freshrss': ('https://github.com/FreshRSS/FreshRSS', [
        'p/themes/Swanson/img/logo.png', 'logo.png'
    ]),
    'grocy': ('https://github.com/grocy/grocy', [
        'public/img/logo.png', 'logo.png'
    ]),
    'habridge': ('https://github.com/bwssytems/ha-bridge', [
        'branding.png', 'logo.png'
    ]),
    'haproxy': ('https://github.com/haproxy/haproxy', [
        'logo.svg', 'haproxy-logo.png'
    ]),
    'healthchecks': ('https://github.com/healthchecks/healthchecks', [
        'static/img/logo.png', 'static/logo.png', 'logo.png'
    ]),
    'hedgedoc': ('https://github.com/hedgedoc/hedgedoc', [
        'public/logos/logo.svg', 'logo.svg'
    ]),
    'heimdall': ('https://github.com/linuxserver/Heimdall', [
        'resources/logo.png', 'logo.png'
    ]),
    'hisshtory-server': ('https://github.com/pomdtr/hisshtory', [
        'logo.png', 'assets/logo.png'
    ]),
    'homeassistant': ('https://github.com/home-assistant/core', [
        'homeassistant/components/demo/icon.png', 'logo.png'
    ]),
    'htpcmanager': ('https://github.com/Ysatir/HTPC-Manager', [
        'logo.png', 'icon.png'
    ]),
    'kavita': ('https://github.com/Kareadita/Kavita', [
        'logo.png', 'icon.png'
    ]),
    'kimai': ('https://github.com/kevinpapst/kimai2', [
        'public/logo.png', 'logo.png'
    ]),
    'lazylibrarian': ('https://github.com/LazyLibrarian/LazyLibrarian', [
        'icon.png', 'logo.png'
    ]),
    'ldap-auth': ('https://github.com/linuxserver/docker-ldap-auth', [
        'logo.png', 'icon.png'
    ]),
    'lightrag': ('https://github.com/PCJWC/LightRAG', [
        'assets/logo.png', 'logo.png'
    ]),
    'lychee': ('https://github.com/LycheeOrg/Lychee', [
        'resources/logo.png', 'logo.png'
    ]),
    'mariadb': ('https://github.com/MariaDB/mariadb-docker', [
        'logo.svg', 'icon.svg'
    ]),
    'mastodon': ('https://github.com/mastodon/mastodon', [
        'public/assets/images/logo.svg', 'logo.svg'
    ]),
    'medusa': ('https://github.com/pymedusa/Medusa', [
        'medusa/gui/slick/images/logo.png', 'logo.png'
    ]),
    'minisatip': ('https://github.com/catalinii/minisatip', [
        'logo.png', 'icon.png'
    ]),
    'mstream': ('https://github.com/IrosTheBeggar/mstream', [
        'logo.svg', 'public/logo.svg'
    ]),
    'netbox': ('https://github.com/netbox-community/netbox', [
        'docs/logo.png', 'logo.png'
    ]),
    'nginx': ('https://github.com/nginx/nginx', [
        'logo.svg', 'nginx-logo.svg'
    ]),
    'ngircd': ('https://github.com/ngircd/ngircd', [
        'doc/images/ngircd.png', 'logo.png'
    ]),
    'nzbhydra2': ('https://github.com/theotherp/nzbhydra2', [
        'logo.png', 'icon.png'
    ]),
    'obsidian': ('https://github.com/obsidianmd/obsidian-releases', [
        'logo.svg', 'icon.svg'
    ]),
    'ombi': ('https://github.com/Ombi-app/Ombi', [
        'logo.png', 'icon.png'
    ]),
    'opencode': ('https://github.com/michidk/opencode', [
        'logo.svg', 'icon.svg'
    ]),
    'openssh-server': ('https://github.com/openssh/openssh-portable', [
        'logo.png', 'icon.png'
    ]),
    'openvscode-server': ('https://github.com/gitpod-io/openvscode-server', [
        'icon.svg', 'logo.svg'
    ]),
    'oscam': ('https://github.com/E2OpenPlugins/oscam-oe-alliance', [
        'oscam.png', 'logo.png'
    ]),
    'pairdrop': ('https://github.com/schlagmichdoch/PairDrop', [
        'logo.svg', 'icon.svg'
    ]),
    'phpmyadmin': ('https://github.com/phpmyadmin/phpmyadmin', [
        'themes/pmahomme/img/logo_right.png', 'logo.png'
    ]),
    'piper': ('https://github.com/rhasspy/piper', [
        'docs/images/piper-logo.png', 'logo.png'
    ]),
    'planka': ('https://github.com/plankanban/planka', [
        'logo.svg', 'icon.svg'
    ]),
    'projectsend': ('https://github.com/projectsend/projectsend', [
        'img/logo.png', 'logo.png'
    ]),
    'pwndrop': ('https://github.com/kd8bny/pwndrop', [
        'logo.png', 'icon.png'
    ]),
    'pydio-cells': ('https://github.com/pydio/cells', [
        'logo.png', 'icon.png'
    ]),
    'pyload-ng': ('https://github.com/pyload/pyload', [
        'docs/logo.svg', 'logo.svg'
    ]),
    'raneto': ('https://github.com/gilbitron/Raneto', [
        'public/logo.png', 'logo.png'
    ]),
    'rsnapshot': ('https://github.com/rsnapshot/rsnapshot', [
        'logo.png', 'icon.png'
    ]),
    'sealskin': ('https://github.com/linuxserver/sealskin', [
        'logo.png', 'icon.png'
    ]),
    'sickgear': ('https://github.com/SickGear/SickGear', [
        'logo.png', 'icon.png'
    ]),
    'smokeping': ('https://github.com/oetiker/SmokePing', [
        'logo.png', 'icon.png'
    ]),
    'speedtest-tracker': ('https://github.com/alexjustesen/speedtest-tracker', [
        'logo.svg', 'icon.svg'
    ]),
    'spotube': ('https://github.com/KRTirtho/spotube', [
        'assets/logo.svg', 'logo.svg'
    ]),
    'swag': ('https://github.com/linuxserver/docker-swag', [
        'logo.png', 'icon.png'
    ]),
    'syncthing': ('https://github.com/syncthing/syncthing', [
        'assets/logo-only.svg', 'logo.svg'
    ]),
    'syslog-ng': ('https://github.com/syslog-ng/syslog-ng', [
        'logo.png', 'icon.png'
    ]),
    'tautulli': ('https://github.com/Tautulli/Tautulli', [
        'logo.png', 'icon.png'
    ]),
    'telegram': ('https://github.com/tdlib/td', [
        'logo.svg', 'icon.svg'
    ]),
    'thelounge': ('https://github.com/thelounge/thelounge', [
        'public/logo.svg', 'logo.svg'
    ]),
    'tvheadend': ('https://github.com/tvheadend/tvheadend', [
        'logo.png', 'icon.png'
    ]),
    'unifi-network-application': ('https://github.com/ubiquiti/UiOS', [
        'logo.png', 'icon.png'
    ]),
    'webgrabplus': ('https://github.com/mhubbard/webgrabplus', [
        'logo.png', 'icon.png'
    ]),
    'wikijs': ('https://github.com/requarks/wiki', [
        'logo.png', 'icon.png'
    ]),
    'wireguard': ('https://github.com/WireGuard/wireguard-linux-compat', [
        'logo.svg', 'wireguard-logo.svg'
    ]),
    'wireshark': ('https://github.com/wireshark/wireshark', [
        'resources/icons/wireshark-logo.png', 'logo.png'
    ]),
    'xbackbone': ('https://github.com/SergiX44/XBackBone', [
        'logo.png', 'icon.png'
    ]),
    'your-spotify': ('https://github.com/Yooooomi/your_spotify', [
        'web/public/logo.svg', 'logo.svg'
    ]),
}

def download_file(url, timeout=TIMEOUT):
    """Download file from URL using curl"""
    try:
        result = subprocess.run(
            ['curl', '-sS', '-L', '--max-time', str(timeout), url],
            capture_output=True,
            timeout=timeout+5
        )
        if result.returncode == 0 and len(result.stdout) > 100:
            return result.stdout
        return None
    except Exception as e:
        print(f"  Error downloading: {e}")
        return None

def convert_svg_to_png(svg_data, output_path):
    """Convert SVG to PNG using rsvg-convert"""
    try:
        result = subprocess.run(
            ['rsvg-convert', '-w', '128', '-h', '128', '-o', output_path],
            input=svg_data,
            timeout=30
        )
        return result.returncode == 0
    except Exception as e:
        print(f"  rsvg-convert failed: {e}")
        return False

def resize_png(input_path, output_path):
    """Resize PNG to 128x128 using ImageMagick"""
    try:
        result = subprocess.run(
            ['convert', input_path, 
             '-resize', '128x128', 
             '-background', 'transparent',
             '-gravity', 'center',
             '-extent', '128x128',
             output_path],
            timeout=30
        )
        return result.returncode == 0
    except Exception as e:
        print(f"  convert failed: {e}")
        return False

def file_hash(filepath):
    """Calculate MD5 hash of file"""
    hash_md5 = hashlib.md5()
    with open(filepath, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

def download_addon_icon(addon_name, repo_url, icon_paths):
    """Attempt to download icon for addon"""
    addon_dir = REPO_ROOT / addon_name
    icon_file = addon_dir / 'icon.png'
    
    if not addon_dir.exists():
        print(f"✗ {addon_name}: addon directory not found")
        return False
    
    # Generate raw GitHub URLs
    base_raw_url = repo_url.replace('github.com', 'raw.githubusercontent.com').replace('.git', '')
    
    print(f"\n📦 {addon_name}")
    print(f"   Repo: {repo_url}")
    print(f"   Trying: {', '.join(icon_paths[:3])}...")
    
    for icon_path in icon_paths:
        raw_url = f"{base_raw_url}/master/{icon_path}"
        # Try main branch too
        for branch in ['master', 'main', 'develop']:
            url = f"{base_raw_url}/{branch}/{icon_path}"
            print(f"   → {url}")
            
            content = download_file(url)
            if not content:
                continue
            
            # Save to temp file
            temp_file = addon_dir / f'icon_temp.{icon_path.split(".")[-1]}'
            with open(temp_file, 'wb') as f:
                f.write(content)
            
            # Process based on file type
            if icon_path.endswith('.svg'):
                if convert_svg_to_png(content, icon_file):
                    print(f"   ✓ Downloaded and converted SVG → PNG")
                    temp_file.unlink()
                    return True
                temp_file.unlink()
            elif icon_path.endswith(('.png', '.jpg', '.jpeg')):
                if resize_png(str(temp_file), str(icon_file)):
                    print(f"   ✓ Downloaded and resized PNG")
                    temp_file.unlink()
                    return True
                temp_file.unlink()
    
    print(f"   ✗ Could not find icon")
    return False

def main():
    print("=" * 70)
    print("DOWNLOADING REAL ADDON ICONS FROM OFFICIAL SOURCES")
    print("=" * 70)
    
    successful = 0
    failed = 0
    skipped = 0
    
    for addon_name in sorted(ICON_SOURCES.keys()):
        if addon_name.startswith('phase'):  # Skip metadata files
            skipped += 1
            continue
        
        repo_url, icon_paths = ICON_SOURCES[addon_name]
        if download_addon_icon(addon_name, repo_url, icon_paths):
            successful += 1
        else:
            failed += 1
        
        # Progress report every 20
        if (successful + failed) % 20 == 0:
            print(f"\n📊 Progress: {successful} success, {failed} failed, {skipped} skipped")
    
    print("\n" + "=" * 70)
    print(f"SUMMARY: {successful} successful, {failed} failed, {skipped} skipped")
    print("=" * 70)

if __name__ == '__main__':
    main()
