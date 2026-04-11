#!/bin/sh
# shellcheck disable=SC2015
set -e

PACKAGES="$1"
echo "To install : $PACKAGES"

if ! command -v bash > /dev/null 2> /dev/null; then
    (apt-get update && apt-get install -yqq --no-install-recommends bash || apk add --no-cache bash) > /dev/null
fi

if ! command -v curl > /dev/null 2> /dev/null; then
    (apt-get update && apt-get install -yqq --no-install-recommends curl || apk add --no-cache curl) > /dev/null
fi

curl -f -L -S "https://raw.githubusercontent.com/rezusnet/hassio-addons/master/.templates/ha_automatic_packages.sh" --output /ha_automatic_packages.sh
chmod 755 /ha_automatic_packages.sh
eval /./ha_automatic_packages.sh "${PACKAGES:-}"

rm /ha_automatic_packages.sh
