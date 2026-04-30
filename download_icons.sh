#!/bin/bash

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
SUCCESS=0
FAILED=0
TOTAL=0

echo "=================================================="
echo "Starting Icon Download Process"
echo "=================================================="
echo ""

# Group A: LinuxServer.io addons (standard pattern)
GROUP_A=(
  "adguardhome-sync" "airsonic-advanced" "apprise-api" "babybuddy" "bookstack"
  "davos" "ddclient" "deluge" "diskover" "dokuwiki"
  "doplarr" "duckdns" "duplicati" "faster-whisper" "ferdium"
  "freshrss" "grocy" "habridge" "healthchecks" "hedgedoc"
  "heimdall" "homeassistant" "htpcmanager" "kavita" "lazylibrarian"
  "ldap-auth" "lychee" "mariadb" "mastodon" "medusa"
  "minisatip" "mstream" "netbox" "nginx" "nzbhydra2"
  "obsidian" "ombi" "openssh-server" "openvscode-server" "pairdrop"
  "phpmyadmin" "planka" "projectsend" "pydio-cells" "pyload-ng"
  "raneto" "rsnapshot" "sealskin" "sickgear" "smokeping"
  "speedtest-tracker" "spotube" "swag" "syncthing" "syslog-ng"
  "tautulli" "telegram" "thelounge" "tvheadend" "unifi-network-application"
  "webgrabplus" "wikijs" "wireguard" "wireshark"
)

echo "Group A: Downloading LinuxServer.io addons (60 total)..."
echo ""

for addon in "${GROUP_A[@]}"; do
  TOTAL=$((TOTAL + 1))
  URL="https://raw.githubusercontent.com/linuxserver/docker-${addon}/master/icon.png"
  
  if [ -d "$addon" ]; then
    echo -n "[$TOTAL/60] $addon ... "
    if curl -s --max-time 5 "$URL" -o "${addon}/icon.png" 2>/dev/null; then
      if file "${addon}/icon.png" | grep -q "PNG image"; then
        echo -e "${GREEN}✓${NC}"
        SUCCESS=$((SUCCESS + 1))
      else
        echo -e "${RED}✗ (invalid PNG)${NC}"
        FAILED=$((FAILED + 1))
        rm -f "${addon}/icon.png"
      fi
    else
      echo -e "${RED}✗ (download failed)${NC}"
      FAILED=$((FAILED + 1))
    fi
  else
    echo -e "${YELLOW}? $addon (directory not found)${NC}"
  fi
done

echo ""
echo "Group A Complete: $SUCCESS/$TOTAL successful"
echo ""
