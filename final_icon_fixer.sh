#!/bin/bash

# Function to download and convert icon
download_icon() {
    local addon="$1"
    local url="$2"
    local dir="${addon%/}"
    
    # Skip if already has good icon
    if [ -f "$dir/icon.png" ]; then
        size=$(stat -c%s "$dir/icon.png" 2>/dev/null)
        [ "$size" -gt 500 ] && return 0
    fi
    
    echo -n "$dir ... "
    
    # Download
    if curl -s -L --max-time 8 "$url" -o "$dir/.tmp_icon" 2>/dev/null; then
        # Check size
        if [ -f "$dir/.tmp_icon" ]; then
            size=$(stat -c%s "$dir/.tmp_icon" 2>/dev/null)
            if [ "$size" -gt 100 ]; then
                # Try to convert to PNG 128x128
                if convert "$dir/.tmp_icon" -resize 128x128 -background white -flatten "$dir/icon.png" 2>/dev/null; then
                    echo "✓"
                    rm -f "$dir/.tmp_icon"
                    return 0
                fi
            fi
            rm -f "$dir/.tmp_icon"
        fi
    fi
    
    echo "✗"
    return 1
}

echo "Downloading missing addon icons..."
echo ""

# LinuxServer.io based - they use upstream project logos
download_icon "adguardhome-sync/" "https://cdn.adguard.com/public/Adguard/Common/Logos/adguard_logo.svg"
download_icon "airsonic-advanced/" "https://airsonic.github.io/logo.png"
download_icon "apprise-api/" "https://raw.githubusercontent.com/caronc/apprise/master/apprise/assets/apprise-logo.png"
download_icon "bookstack/" "https://raw.githubusercontent.com/BookStackApp/BookStack/master/public/images/logo.png"
download_icon "davos/" "https://raw.githubusercontent.com/linuxserver/davos/master/README.md"
download_icon "ddclient/" "https://raw.githubusercontent.com/ddclient/ddclient/master/README.md"
download_icon "deluge/" "https://raw.githubusercontent.com/deluge-torrent/deluge/develop/deluge/ui/web/images/logo.png"
download_icon "diskover/" "https://raw.githubusercontent.com/MrRobotjs/diskover/master/README.md"
download_icon "dokuwiki/" "https://raw.githubusercontent.com/dokuwiki/dokuwiki/master/README.md"
download_icon "doplarr/" "https://raw.githubusercontent.com/MauriceNino/doplarr/master/README.md"
download_icon "duckdns/" "https://duckdns.org/install.svg"
download_icon "duplicati/" "https://raw.githubusercontent.com/duplicati/duplicati/master/README.md"
download_icon "faster-whisper/" "https://raw.githubusercontent.com/SYSTRAN/faster-whisper/master/README.md"
download_icon "ferdium/" "https://raw.githubusercontent.com/ferdium/ferdium-app/master/src/assets/logo.svg"
download_icon "freshrss/" "https://raw.githubusercontent.com/FreshRSS/FreshRSS/master/README.md"
download_icon "habridge/" "https://raw.githubusercontent.com/bwssytems/ha-bridge/master/README.md"
download_icon "healthchecks/" "https://raw.githubusercontent.com/healthchecks/healthchecks/master/README.md"
download_icon "hedgedoc/" "https://raw.githubusercontent.com/hedgedoc/hedgedoc/master/public/logo.png"
download_icon "heimdall/" "https://raw.githubusercontent.com/linuxserver/Heimdall/master/README.md"
download_icon "homeassistant/" "https://raw.githubusercontent.com/home-assistant/core/dev/homeassistant/components/http/static/icons/favicon-192x192.png"
download_icon "htpcmanager/" "https://raw.githubusercontent.com/styxit/HTPC-Manager/master/README.md"
download_icon "kavita/" "https://raw.githubusercontent.com/Kareadita/Kavita/master/README.md"
download_icon "lazylibrarian/" "https://raw.githubusercontent.com/lazylibrarian/LazyLibrarian/master/README.md"
download_icon "lychee/" "https://raw.githubusercontent.com/LycheeOrg/Lychee/master/README.md"
download_icon "mariadb/" "https://mariadb.com/kb/static/images/logo-2x.png"
download_icon "mastodon/" "https://raw.githubusercontent.com/mastodon/mastodon/main/public/images/logo.svg"
download_icon "medusa/" "https://raw.githubusercontent.com/pymedusa/Medusa/master/README.md"
download_icon "minisatip/" "https://raw.githubusercontent.com/catalinii/minisatip/master/README.md"
download_icon "mstream/" "https://raw.githubusercontent.com/IrosTheBeggar/mStream/master/README.md"
download_icon "netbox/" "https://raw.githubusercontent.com/netbox-community/netbox/master/README.md"
download_icon "nzbhydra2/" "https://raw.githubusercontent.com/theotherp/nzbhydra2/master/README.md"
download_icon "obsidian/" "https://obsidian.md/favicon.ico"
download_icon "openssh-server/" "https://upload.wikimedia.org/wikipedia/commons/3/3b/OpenSSH_logo.png"
download_icon "openvscode-server/" "https://raw.githubusercontent.com/gitpod-io/openvscode-server/main/README.md"
download_icon "pairdrop/" "https://raw.githubusercontent.com/schlagmichdoch/PairDrop/master/README.md"
download_icon "planka/" "https://raw.githubusercontent.com/plankanban/planka/master/README.md"
download_icon "projectsend/" "https://raw.githubusercontent.com/projectsend/projectsend/master/README.md"
download_icon "pydio-cells/" "https://pydio.com/en/cms/favicon.ico"
download_icon "raneto/" "https://raw.githubusercontent.com/gilbitron/Raneto/master/README.md"
download_icon "rsnapshot/" "https://raw.githubusercontent.com/rsnapshot/rsnapshot/master/README.md"
download_icon "sealskin/" "https://raw.githubusercontent.com/linuxserver/sealskin/master/README.md"
download_icon "sickgear/" "https://raw.githubusercontent.com/SickGear/SickGear/master/README.md"
download_icon "smokeping/" "https://raw.githubusercontent.com/oetiker/SmokePing/master/README.md"
download_icon "speedtest-tracker/" "https://raw.githubusercontent.com/alexjustesen/speedtest-tracker/master/README.md"
download_icon "spotube/" "https://raw.githubusercontent.com/KRTirtho/spotube/master/README.md"
download_icon "swag/" "https://raw.githubusercontent.com/linuxserver/docker-swag/master/README.md"
download_icon "tautulli/" "https://raw.githubusercontent.com/Tautulli/Tautulli/master/README.md"
download_icon "tvheadend/" "https://raw.githubusercontent.com/tvheadend/tvheadend/master/README.md"
download_icon "unifi-network-application/" "https://raw.githubusercontent.com/ubiquiti/ubiquiti-linux-release/master/README.md"
download_icon "webgrabplus/" "https://raw.githubusercontent.com/SuperSandro2000/WebGrabPlus/master/README.md"
download_icon "wikijs/" "https://raw.githubusercontent.com/Requarks/wiki/main/README.md"
download_icon "wireguard/" "https://www.wireguard.com/img/icons/wireguard-icon.svg"
download_icon "code-server/" "https://raw.githubusercontent.com/coder/code-server/main/README.md"
download_icon "lightrag/" "https://raw.githubusercontent.com/HKUDS/LightRAG/main/lightrag.png"

echo ""
echo "Done!"
