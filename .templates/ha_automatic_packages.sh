#!/bin/bash
set -e

VERBOSE=false
set +u 2> /dev/null || true
PACKAGES="${*:-}"
(echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections) &> /dev/null || true

[ "$VERBOSE" = true ] && echo "ENV : $PACKAGES"

if command -v "apk" &> /dev/null; then
    PACKMANAGER="apk"
elif command -v "apt" &> /dev/null; then
    PACKMANAGER="apt"
elif command -v "pacman" &> /dev/null; then
    PACKMANAGER="pacman"
fi

PACKAGES="$PACKAGES jq curl sed ca-certificates micro"

for files in "/etc/cont-init.d" "/etc/services.d"; do
    if ! ls $files 1> /dev/null 2>&1; then continue; fi

    COMMAND="nginx"
    if grep -q -rnw "$files/" -e "$COMMAND" && ! command -v $COMMAND &> /dev/null; then
        [ "$PACKMANAGER" = "apk" ] && PACKAGES="$PACKAGES nginx"
        [ "$PACKMANAGER" = "apt" ] && PACKAGES="$PACKAGES nginx"
        [ "$PACKMANAGER" = "pacman" ] && PACKAGES="$PACKAGES nginx"
        if ls /etc/nginx 1> /dev/null 2>&1; then mv /etc/nginx /etc/nginx2; fi
    fi

    COMMAND="mount"
    if grep -q -rnw "$files/" -e "$COMMAND"; then
        [ "$PACKMANAGER" = "apk" ] && PACKAGES="$PACKAGES exfatprogs ntfs-3g ntfs-3g-progs squashfs-tools fuse lsblk"
        [ "$PACKMANAGER" = "apt" ] && PACKAGES="$PACKAGES exfat* ntfs* squashfs-tools util-linux"
    fi

    COMMAND="ping"
    if grep -q -rnw "$files/" -e "$COMMAND" && ! command -v $COMMAND &> /dev/null; then
        [ "$PACKMANAGER" = "apk" ] && PACKAGES="$PACKAGES iputils"
        [ "$PACKMANAGER" = "apt" ] && PACKAGES="$PACKAGES iputils-ping"
    fi

    COMMAND="cifs"
    if grep -q -rnw "$files/" -e "$COMMAND"; then
        [ "$PACKMANAGER" = "apk" ] && PACKAGES="$PACKAGES cifs-utils keyutils"
        [ "$PACKMANAGER" = "apt" ] && PACKAGES="$PACKAGES cifs-utils keyutils"
        [ "$PACKMANAGER" = "pacman" ] && PACKAGES="$PACKAGES cifs-utils keyutils"
    fi

    COMMAND="nfs"
    if grep -q -rnw "$files/" -e "$COMMAND"; then
        [ "$PACKMANAGER" = "apk" ] && PACKAGES="$PACKAGES nfs-utils"
        [ "$PACKMANAGER" = "apt" ] && PACKAGES="$PACKAGES nfs-common"
    fi

    COMMAND="smbclient"
    if grep -q -rnw "$files/" -e "$COMMAND" && ! command -v $COMMAND &> /dev/null; then
        [ "$PACKMANAGER" = "apk" ] && PACKAGES="$PACKAGES samba samba-client ntfs-3g"
        [ "$PACKMANAGER" = "apt" ] && PACKAGES="$PACKAGES samba smbclient ntfs-3g"
    fi

    COMMAND="git"
    if grep -q -rnw "$files/" -e "$COMMAND" && ! command -v $COMMAND &> /dev/null; then
        PACKAGES="$PACKAGES git"
    fi

    COMMAND="wget"
    if grep -q -rnw "$files/" -e "$COMMAND" && ! command -v $COMMAND &> /dev/null; then
        PACKAGES="$PACKAGES wget"
    fi
done

if [ "$PACKMANAGER" = "apt" ]; then apt-get update > /dev/null; fi
if [ "$PACKMANAGER" = "apk" ] && [ -f /etc/apk/repositories ] && ! grep -q "community" /etc/apk/repositories; then
    ALPINE_VER=$(cat /etc/alpine-release 2> /dev/null | cut -d. -f1,2)
    if [ -n "$ALPINE_VER" ]; then
        echo "https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VER}/community" >> /etc/apk/repositories
        apk update > /dev/null
    fi
fi

for packagestoinstall in $PACKAGES; do
    if [ "$PACKMANAGER" = "apk" ]; then
        apk add --no-cache "$packagestoinstall" &> /dev/null || (echo "Error : $packagestoinstall not found" && touch /ERROR)
    elif [ "$PACKMANAGER" = "apt" ]; then
        apt-get install -yqq --no-install-recommends "$packagestoinstall" &> /dev/null || (echo "Error : $packagestoinstall not found" && touch /ERROR)
    elif [ "$PACKMANAGER" = "pacman" ]; then
        pacman --noconfirm -S "$packagestoinstall" &> /dev/null || (echo "Error : $packagestoinstall not found" && touch /ERROR)
    fi
done

if [ "$PACKMANAGER" = "apt" ]; then apt-get clean > /dev/null; fi

if ls /etc/nginx2 1> /dev/null 2>&1; then
    rm -r /etc/nginx
    mv /etc/nginx2 /etc/nginx
    mkdir -p /var/log/nginx
    touch /var/log/nginx/error.log
fi

for files in "/etc/services.d" "/etc/cont-init.d"; do
    if ! ls $files 1> /dev/null 2>&1; then continue; fi

    if grep -q -rnw "$files/" -e 'bashio' && [ ! -f "/usr/bin/bashio" ]; then
        BASHIO_VERSION="latest"
        mkdir -p /tmp/bashio
        BASHIO_TAG="$(curl -f -L -s -S "https://api.github.com/repos/hassio-addons/bashio/releases/${BASHIO_VERSION}" | awk -F '"' '/tag_name/{print $4; exit}')"
        curl -f -L -s -S "https://github.com/hassio-addons/bashio/archive/${BASHIO_TAG}.tar.gz" | tar -xzf - --strip 1 -C /tmp/bashio
        mv /tmp/bashio/lib /usr/lib/bashio
        ln -s /usr/lib/bashio/bashio /usr/bin/bashio
        rm -rf /tmp/bashio
    fi
done

if [ -f /ERROR ]; then
    exit 1
fi
