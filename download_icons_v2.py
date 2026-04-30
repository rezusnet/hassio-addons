#!/usr/bin/env python3
import os
import sys
import subprocess
import json
import hashlib
import re
from pathlib import Path
from urllib.parse import urljoin
import time

REPO_ROOT = Path('/home/tib/source/repos/github/rezusnet/hassio-addons')
TIMEOUT = 30

# Icon source mappings with web fallbacks
ICON_SOURCES = {
    'adguardhome-sync': {
        'repo': 'https://github.com/AdguardTeam/AdGuardHome-sync',
        'web': 'https://adguard.com',
        'search_paths': ['logo', 'icon', 'assets/logo', 'client/public'],
        'backup_url': 'https://adguard.com/en/adguard-home/overview.html'
    },
    'airsonic-advanced': {
        'repo': 'https://github.com/airsonic/airsonic-advanced',
        'web': 'https://www.airsonic.org',
        'search_paths': ['logo', 'icon', 'airsonic-ui/ui-common/public/assets'],
    },
    'apprise-api': {
        'repo': 'https://github.com/caronc/apprise-api',
        'web': 'https://github.com/caronc/apprise',
        'search_paths': ['logo', 'assets', 'apprise/assets'],
    },
    'audiobookshelf': {
        'repo': 'https://github.com/advplyr/audiobookshelf',
        'web': 'https://www.audiobookshelf.org',
        'search_paths': ['client/public', 'public', 'logo', 'assets'],
    },
    'babybuddy': {
        'repo': 'https://github.com/babybuddy/babybuddy',
        'web': 'https://babybuddy.io',
        'search_paths': ['core/static', 'static', 'logo'],
    },
    'beets': {
        'repo': 'https://github.com/beetbox/beets',
        'web': 'https://beets.io',
        'search_paths': ['docs/_static', 'logo', 'assets'],
    },
    'bookstack': {
        'repo': 'https://github.com/BookStackApp/BookStack',
        'web': 'https://www.bookstackapp.com',
        'search_paths': ['resources/images', 'public/images', 'logo'],
    },
    'code-server': {
        'repo': 'https://github.com/coder/code-server',
        'web': 'https://coder.com/products/code-server',
        'search_paths': ['resources', 'assets', 'logo'],
    },
    'copilot': {
        'repo': 'https://github.com/copilot',
        'web': 'https://github.com/features/copilot',
        'search_paths': ['logo', 'assets', 'icon'],
    },
    'cops': {
        'repo': 'https://github.com/seblucas/cops',
        'web': 'https://github.com/seblucas/cops',
        'search_paths': ['res', 'resources', 'logo'],
    },
    'darktable': {
        'repo': 'https://github.com/darktable-org/darktable',
        'web': 'https://www.darktable.org',
        'search_paths': ['src/external', 'resources', 'logo'],
    },
    'davos': {
        'repo': 'https://github.com/MrCryptic/Davos',
        'web': 'https://github.com/MrCryptic/Davos',
        'search_paths': ['public', 'assets', 'logo'],
    },
    'ddclient': {
        'repo': 'https://github.com/ddclient/ddclient',
        'web': 'https://ddclient.sourceforge.io',
        'search_paths': ['docs', 'resources', 'logo'],
    },
    'deluge': {
        'repo': 'https://github.com/deluge-torrent/deluge',
        'web': 'https://deluge-torrent.org',
        'search_paths': ['deluge/ui/web/images', 'deluge/ui/images', 'resources'],
    },
    'diskover': {
        'repo': 'https://github.com/shirosaidev/diskover',
        'web': 'https://diskoverdata.com',
        'search_paths': ['docs', 'assets', 'logo'],
    },
    'dokuwiki': {
        'repo': 'https://github.com/dokuwiki/dokuwiki',
        'web': 'https://www.dokuwiki.org',
        'search_paths': ['images', 'lib/images', 'logo'],
    },
    'doplarr': {
        'repo': 'https://github.com/MrSir/doplarr',
        'web': 'https://github.com/MrSir/doplarr',
        'search_paths': ['assets', 'public', 'logo'],
    },
    'duckdns': {
        'repo': 'https://github.com/MrRaph84/ddclient',
        'web': 'https://www.duckdns.org',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'duplicati': {
        'repo': 'https://github.com/duplicati/duplicati',
        'web': 'https://www.duplicati.com',
        'search_paths': ['Duplicati/GUI', 'logo', 'resources'],
    },
    'fail2ban': {
        'repo': 'https://github.com/fail2ban/fail2ban',
        'web': 'https://www.fail2ban.org',
        'search_paths': ['doc', 'logo', 'assets'],
    },
    'faster-whisper': {
        'repo': 'https://github.com/SYSTRAN/faster-whisper',
        'web': 'https://github.com/SYSTRAN/faster-whisper',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'ferdium': {
        'repo': 'https://github.com/ferdium/ferdium-app',
        'web': 'https://ferdium.org',
        'search_paths': ['resources', 'assets', 'public'],
    },
    'freshrss': {
        'repo': 'https://github.com/FreshRSS/FreshRSS',
        'web': 'https://freshrss.org',
        'search_paths': ['p/themes/Swanson/img', 'resources', 'logo'],
    },
    'grocy': {
        'repo': 'https://github.com/grocy/grocy',
        'web': 'https://grocy.info',
        'search_paths': ['public/img', 'resources', 'logo'],
    },
    'habridge': {
        'repo': 'https://github.com/bwssytems/ha-bridge',
        'web': 'https://github.com/bwssytems/ha-bridge',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'haproxy': {
        'repo': 'https://github.com/haproxy/haproxy',
        'web': 'https://www.haproxy.org',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'healthchecks': {
        'repo': 'https://github.com/healthchecks/healthchecks',
        'web': 'https://healthchecks.io',
        'search_paths': ['static/img', 'static', 'logo'],
    },
    'hedgedoc': {
        'repo': 'https://github.com/hedgedoc/hedgedoc',
        'web': 'https://hedgedoc.org',
        'search_paths': ['public/logos', 'public', 'logo'],
    },
    'heimdall': {
        'repo': 'https://github.com/linuxserver/Heimdall',
        'web': 'https://heimdall.site',
        'search_paths': ['resources', 'public', 'logo'],
    },
    'hisshtory-server': {
        'repo': 'https://github.com/pomdtr/hisshtory',
        'web': 'https://github.com/pomdtr/hisshtory',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'homeassistant': {
        'repo': 'https://github.com/home-assistant/core',
        'web': 'https://www.home-assistant.io',
        'search_paths': ['homeassistant/components/demo', 'logo', 'resources'],
    },
    'htpcmanager': {
        'repo': 'https://github.com/Ysatir/HTPC-Manager',
        'web': 'https://github.com/Ysatir/HTPC-Manager',
        'search_paths': ['logo', 'assets', 'public'],
    },
    'kavita': {
        'repo': 'https://github.com/Kareadita/Kavita',
        'web': 'https://www.kavitareader.com',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'kimai': {
        'repo': 'https://github.com/kevinpapst/kimai2',
        'web': 'https://www.kimai.org',
        'search_paths': ['public', 'logo', 'assets'],
    },
    'lazylibrarian': {
        'repo': 'https://github.com/LazyLibrarian/LazyLibrarian',
        'web': 'https://github.com/LazyLibrarian/LazyLibrarian',
        'search_paths': ['icon', 'logo', 'resources'],
    },
    'ldap-auth': {
        'repo': 'https://github.com/linuxserver/docker-ldap-auth',
        'web': 'https://github.com/linuxserver/docker-ldap-auth',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'lightrag': {
        'repo': 'https://github.com/PCJWC/LightRAG',
        'web': 'https://github.com/PCJWC/LightRAG',
        'search_paths': ['assets', 'logo', 'resources'],
    },
    'lychee': {
        'repo': 'https://github.com/LycheeOrg/Lychee',
        'web': 'https://lychee.electerious.com',
        'search_paths': ['resources', 'public', 'logo'],
    },
    'mariadb': {
        'repo': 'https://github.com/MariaDB/mariadb-docker',
        'web': 'https://mariadb.org',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'mastodon': {
        'repo': 'https://github.com/mastodon/mastodon',
        'web': 'https://mastodon.social',
        'search_paths': ['public/assets/images', 'public', 'logo'],
    },
    'medusa': {
        'repo': 'https://github.com/pymedusa/Medusa',
        'web': 'https://pymedusa.com',
        'search_paths': ['medusa/gui/slick/images', 'logo', 'resources'],
    },
    'minisatip': {
        'repo': 'https://github.com/catalinii/minisatip',
        'web': 'https://github.com/catalinii/minisatip',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'mstream': {
        'repo': 'https://github.com/IrosTheBeggar/mstream',
        'web': 'https://www.mstream.io',
        'search_paths': ['logo', 'public', 'assets'],
    },
    'netbox': {
        'repo': 'https://github.com/netbox-community/netbox',
        'web': 'https://netbox.dev',
        'search_paths': ['docs', 'logo', 'resources'],
    },
    'nginx': {
        'repo': 'https://github.com/nginx/nginx',
        'web': 'https://nginx.org',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'ngircd': {
        'repo': 'https://github.com/ngircd/ngircd',
        'web': 'https://ngircd.barton.de',
        'search_paths': ['doc/images', 'logo', 'resources'],
    },
    'nzbhydra2': {
        'repo': 'https://github.com/theotherp/nzbhydra2',
        'web': 'https://github.com/theotherp/nzbhydra2',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'obsidian': {
        'repo': 'https://github.com/obsidianmd/obsidian-releases',
        'web': 'https://obsidian.md',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'ombi': {
        'repo': 'https://github.com/Ombi-app/Ombi',
        'web': 'https://www.ombi.io',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'opencode': {
        'repo': 'https://github.com/michidk/opencode',
        'web': 'https://github.com/michidk/opencode',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'openssh-server': {
        'repo': 'https://github.com/openssh/openssh-portable',
        'web': 'https://www.openssh.com',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'openvscode-server': {
        'repo': 'https://github.com/gitpod-io/openvscode-server',
        'web': 'https://github.com/gitpod-io/openvscode-server',
        'search_paths': ['icon', 'logo', 'resources'],
    },
    'oscam': {
        'repo': 'https://github.com/E2OpenPlugins/oscam-oe-alliance',
        'web': 'https://github.com/E2OpenPlugins/oscam-oe-alliance',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'pairdrop': {
        'repo': 'https://github.com/schlagmichdoch/PairDrop',
        'web': 'https://www.pairdrop.in',
        'search_paths': ['logo', 'public', 'assets'],
    },
    'phpmyadmin': {
        'repo': 'https://github.com/phpmyadmin/phpmyadmin',
        'web': 'https://www.phpmyadmin.net',
        'search_paths': ['themes/pmahomme/img', 'themes', 'logo'],
    },
    'piper': {
        'repo': 'https://github.com/rhasspy/piper',
        'web': 'https://github.com/rhasspy/piper',
        'search_paths': ['docs/images', 'logo', 'resources'],
    },
    'planka': {
        'repo': 'https://github.com/plankanban/planka',
        'web': 'https://planka.app',
        'search_paths': ['logo', 'public', 'assets'],
    },
    'projectsend': {
        'repo': 'https://github.com/projectsend/projectsend',
        'web': 'https://www.projectsend.org',
        'search_paths': ['img', 'logo', 'resources'],
    },
    'pwndrop': {
        'repo': 'https://github.com/kd8bny/pwndrop',
        'web': 'https://github.com/kd8bny/pwndrop',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'pydio-cells': {
        'repo': 'https://github.com/pydio/cells',
        'web': 'https://pydio.com',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'pyload-ng': {
        'repo': 'https://github.com/pyload/pyload',
        'web': 'https://pyload.net',
        'search_paths': ['docs', 'logo', 'resources'],
    },
    'raneto': {
        'repo': 'https://github.com/gilbitron/Raneto',
        'web': 'https://raneto.com',
        'search_paths': ['public', 'logo', 'assets'],
    },
    'rsnapshot': {
        'repo': 'https://github.com/rsnapshot/rsnapshot',
        'web': 'https://rsnapshot.org',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'sealskin': {
        'repo': 'https://github.com/linuxserver/sealskin',
        'web': 'https://github.com/linuxserver/sealskin',
        'search_paths': ['logo', 'assets', 'resources'],
    },
    'sickgear': {
        'repo': 'https://github.com/SickGear/SickGear',
        'web': 'https://github.com/SickGear/SickGear',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'smokeping': {
        'repo': 'https://github.com/oetiker/SmokePing',
        'web': 'https://oss.oetiker.ch/smokeping',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'speedtest-tracker': {
        'repo': 'https://github.com/alexjustesen/speedtest-tracker',
        'web': 'https://speedtest-tracker.dev',
        'search_paths': ['logo', 'public', 'resources'],
    },
    'spotube': {
        'repo': 'https://github.com/KRTirtho/spotube',
        'web': 'https://github.com/KRTirtho/spotube',
        'search_paths': ['assets', 'logo', 'resources'],
    },
    'swag': {
        'repo': 'https://github.com/linuxserver/docker-swag',
        'web': 'https://github.com/linuxserver/docker-swag',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'syncthing': {
        'repo': 'https://github.com/syncthing/syncthing',
        'web': 'https://syncthing.net',
        'search_paths': ['assets', 'logo', 'resources'],
    },
    'syslog-ng': {
        'repo': 'https://github.com/syslog-ng/syslog-ng',
        'web': 'https://www.syslog-ng.com',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'tautulli': {
        'repo': 'https://github.com/Tautulli/Tautulli',
        'web': 'https://tautulli.com',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'telegram': {
        'repo': 'https://github.com/tdlib/td',
        'web': 'https://telegram.org',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'thelounge': {
        'repo': 'https://github.com/thelounge/thelounge',
        'web': 'https://thelounge.chat',
        'search_paths': ['public', 'logo', 'resources'],
    },
    'tvheadend': {
        'repo': 'https://github.com/tvheadend/tvheadend',
        'web': 'https://tvheadend.org',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'unifi-network-application': {
        'repo': 'https://github.com/ubiquiti/UnifiStadium',
        'web': 'https://unifi.ubiquiti.com',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'webgrabplus': {
        'repo': 'https://github.com/mhubbard/webgrabplus',
        'web': 'https://github.com/mhubbard/webgrabplus',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'wikijs': {
        'repo': 'https://github.com/requarks/wiki',
        'web': 'https://js.wiki',
        'search_paths': ['logo', 'public', 'assets'],
    },
    'wireguard': {
        'repo': 'https://github.com/WireGuard/wireguard-linux-compat',
        'web': 'https://www.wireguard.com',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'wireshark': {
        'repo': 'https://github.com/wireshark/wireshark',
        'web': 'https://www.wireshark.org',
        'search_paths': ['resources/icons', 'logo', 'resources'],
    },
    'xbackbone': {
        'repo': 'https://github.com/SergiX44/XBackBone',
        'web': 'https://xbackbone.app',
        'search_paths': ['logo', 'resources', 'assets'],
    },
    'your-spotify': {
        'repo': 'https://github.com/Yooooomi/your_spotify',
        'web': 'https://www.your-spotify.com',
        'search_paths': ['web/public', 'logo', 'public'],
    },
}

def download_file(url):
    """Download file from URL"""
    try:
        result = subprocess.run(
            ['curl', '-sS', '-L', '--max-time', str(TIMEOUT), url],
            capture_output=True,
            timeout=TIMEOUT+5
        )
        if result.returncode == 0 and len(result.stdout) > 100:
            # Check if it's actually a valid file
            if result.stdout.startswith(b'\x89PNG') or result.stdout.startswith(b'<?xml') or result.stdout.startswith(b'<svg'):
                return result.stdout
        return None
    except Exception as e:
        return None

def try_download_icon(addon_name, info):
    """Try multiple approaches to download icon for addon"""
    addon_dir = REPO_ROOT / addon_name
    icon_file = addon_dir / 'icon.png'
    
    if not addon_dir.exists():
        return False, "addon dir missing"
    
    repo_url = info.get('repo', '')
    web_url = info.get('web', '')
    search_paths = info.get('search_paths', [])
    
    # Construct raw.githubusercontent URL
    gh_raw = repo_url.replace('github.com/', 'raw.githubusercontent.com/').replace('.git', '')
    
    # Try main and master branches with each search path
    branches = ['main', 'master', 'develop']
    for branch in branches:
        for path in search_paths:
            for ext in ['png', 'svg', 'ico', 'jpg']:
                url = f"{gh_raw}/{branch}/{path}/logo.{ext}"
                data = download_file(url)
                if data:
                    return process_downloaded_icon(addon_name, data, ext, icon_file)
                
                url = f"{gh_raw}/{branch}/{path}/icon.{ext}"
                data = download_file(url)
                if data:
                    return process_downloaded_icon(addon_name, data, ext, icon_file)
    
    return False, "all attempts failed"

def process_downloaded_icon(addon_name, data, file_type, icon_file):
    """Process downloaded icon"""
    temp_file = icon_file.parent / f'temp.{file_type}'
    try:
        with open(temp_file, 'wb') as f:
            f.write(data)
        
        if file_type in ['svg', 'ico']:
            # Convert to PNG
            convert_to_png_result = subprocess.run(
                ['rsvg-convert', '-w', '128', '-h', '128', '-o', str(icon_file), str(temp_file)],
                timeout=30
            )
            if convert_to_png_result.returncode == 0:
                temp_file.unlink()
                return True, "downloaded and converted"
            temp_file.unlink()
            return False, "convert failed"
        else:
            # Resize PNG
            resize_result = subprocess.run(
                ['convert', str(temp_file),
                 '-resize', '128x128',
                 '-background', 'transparent',
                 '-gravity', 'center',
                 '-extent', '128x128',
                 str(icon_file)],
                timeout=30
            )
            temp_file.unlink()
            if resize_result.returncode == 0:
                return True, "downloaded and resized"
            return False, "resize failed"
    except Exception as e:
        if temp_file.exists():
            temp_file.unlink()
        return False, f"exception: {str(e)}"

def main():
    print("=" * 70)
    print("DOWNLOADING REAL ADDON ICONS - V2")
    print("=" * 70)
    
    successful = []
    failed = []
    
    addons = sorted([a for a in ICON_SOURCES.keys() if not a.startswith('phase')])
    
    for i, addon_name in enumerate(addons, 1):
        info = ICON_SOURCES[addon_name]
        success, msg = try_download_icon(addon_name, info)
        
        if success:
            successful.append(addon_name)
            print(f"✓ [{i:2d}/{len(addons)}] {addon_name:30s} {msg}")
        else:
            failed.append(addon_name)
            print(f"✗ [{i:2d}/{len(addons)}] {addon_name:30s} {msg}")
        
        # Progress report every 20
        if i % 20 == 0:
            print(f"\n📊 Progress: {len(successful)} success, {len(failed)} failed\n")
    
    print("\n" + "=" * 70)
    print(f"FINAL: {len(successful)} successful, {len(failed)} failed")
    print("=" * 70)
    
    if failed:
        print("\nFailed addons:")
        for addon in failed[:10]:
            print(f"  - {addon}")
        if len(failed) > 10:
            print(f"  ... and {len(failed)-10} more")

if __name__ == '__main__':
    main()
