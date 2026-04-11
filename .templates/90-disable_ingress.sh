#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

if bashio::config.true "ingress_disabled"; then
    bashio::log.warning "Ingress is disabled. Connect using ip:port"
    sed -i "/root/d" /etc/nginx/servers/ingress.conf
    sed -i "/proxy_pass/iroot /etc;" /etc/nginx/servers/ingress.conf
    sed -i "/proxy_pass/itry_files '' /ingress.html =404;" /etc/nginx/servers/ingress.conf
    sed -i "/proxy_pass/d" /etc/nginx/servers/ingress.conf
    cat > /etc/ingress.html << EOF
<!DOCTYPE html>
<html>
  <head><title>Ingress disabled</title></head>
  <body><p style="background-color:black;color:yellow">Ingress was disabled. Connect using ip:port.</p></body>
</html>
EOF
fi
