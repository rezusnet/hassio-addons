#!/bin/bash

# Function to generate a branded icon
generate_icon() {
    local addon="$1"
    local dir="${addon%/}"
    local label="$2"
    
    # Skip if already has decent icon
    if [ -f "$dir/icon.png" ]; then
        size=$(stat -c%s "$dir/icon.png" 2>/dev/null)
        [ "$size" -gt 1000 ] && return 0
    fi
    
    echo -n "$dir ... "
    
    # Generate a simple 128x128 PNG with the addon name
    # Using a gradient background and white text
    if convert -size 128x128 xc:'#0066cc' \
        -font DejaVu-Sans-Bold -pointsize 14 \
        -fill white -gravity center \
        -annotate +0+0 "$label" \
        "$dir/icon.png" 2>/dev/null; then
        echo "✓"
        return 0
    else
        echo "✗"
        return 1
    fi
}

echo "Generating branded icons for missing addons..."
echo ""

# Generate icons for all missing addons
# Using first 1-3 words of addon name, uppercase
generate_icon "adguardhome-sync/" "ADGUARD"
generate_icon "airsonic-advanced/" "AIRSONIC"
generate_icon "apprise-api/" "APPRISE"
generate_icon "bookstack/" "BOOKSTACK"
generate_icon "code-server/" "CODE"
generate_icon "davos/" "DAVOS"
generate_icon "ddclient/" "DDCLIENT"
generate_icon "deluge/" "DELUGE"
generate_icon "diskover/" "DISKOVER"
generate_icon "dokuwiki/" "DOKUWIKI"
generate_icon "doplarr/" "DOPLARR"
generate_icon "duckdns/" "DUCKDNS"
generate_icon "duplicati/" "DUPLICATI"
generate_icon "faster-whisper/" "WHISPER"
generate_icon "ferdium/" "FERDIUM"
generate_icon "freshrss/" "FRESHRSS"
generate_icon "habridge/" "HABRIDGE"
generate_icon "healthchecks/" "HEALTH"
generate_icon "hedgedoc/" "HEDGEDOC"
generate_icon "heimdall/" "HEIMDALL"
generate_icon "homeassistant/" "HOME"
generate_icon "htpcmanager/" "HTPC"
generate_icon "kavita/" "KAVITA"
generate_icon "lazylibrarian/" "LAZY"
generate_icon "lightrag/" "LIGHTRAG"
generate_icon "lychee/" "LYCHEE"
generate_icon "mariadb/" "MARIA"
generate_icon "mastodon/" "MASTODON"
generate_icon "medusa/" "MEDUSA"
generate_icon "minisatip/" "SATIP"
generate_icon "mstream/" "MSTREAM"
generate_icon "netbox/" "NETBOX"
generate_icon "nzbhydra2/" "NZBHYDRA"
generate_icon "obsidian/" "OBSIDIAN"
generate_icon "openssh-server/" "SSH"
generate_icon "openvscode-server/" "CODE"
generate_icon "pairdrop/" "PAIRDROP"
generate_icon "planka/" "PLANKA"
generate_icon "projectsend/" "PROJECT"
generate_icon "pydio-cells/" "PYDIO"
generate_icon "raneto/" "RANETO"
generate_icon "rsnapshot/" "RSNAPSHOT"
generate_icon "sealskin/" "SEALSKIN"
generate_icon "sickgear/" "SICKGEAR"
generate_icon "smokeping/" "SMOKEPING"
generate_icon "speedtest-tracker/" "SPEEDTEST"
generate_icon "spotube/" "SPOTUBE"
generate_icon "swag/" "SWAG"
generate_icon "tautulli/" "TAUTULLI"
generate_icon "tvheadend/" "TVHEADEND"
generate_icon "unifi-network-application/" "UNIFI"
generate_icon "webgrabplus/" "WEBGRAB"
generate_icon "wikijs/" "WIKIJS"
generate_icon "wireguard/" "WIREGUARD"

echo ""
echo "Icon generation complete!"
