#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

bashio::log.info "Generating HAProxy configuration..."

DEFAULT_HTTP=$(bashio::config 'default_http_backend')
DEFAULT_HTTPS=$(bashio::config 'default_https_backend')

mkdir -p /etc/haproxy

cat > /etc/haproxy/haproxy.cfg <<EOF
global
    log stdout format raw local0
    maxconn 4096

defaults
    log     global
    mode    tcp
    option  tcplog
    timeout connect 5s
    timeout client  300s
    timeout server  300s

frontend https_in
    bind *:443
    mode tcp
    tcp-request inspect-delay 5s
    tcp-request content accept if { req_ssl_hello_type 1 }
EOF

ROUTE_COUNT=$(bashio::config 'routes | length')
for i in $(seq 0 $((ROUTE_COUNT - 1))); do
    DOMAIN=$(bashio::config "routes[${i}].domain_suffix")
    BACKEND_HOST=$(bashio::config "routes[${i}].backend_host")
    BACKEND_PORT=$(bashio::config "routes[${i}].backend_https_port")
    BACKEND_NAME="route_${i}_https"

    bashio::log.info "HTTPS route: *${DOMAIN} -> ${BACKEND_HOST}:${BACKEND_PORT}"

    cat >> /etc/haproxy/haproxy.cfg <<EOF
    use_backend ${BACKEND_NAME} if { req_ssl_sni -m end ${DOMAIN} }
EOF
done

cat >> /etc/haproxy/haproxy.cfg <<EOF
    default_backend default_https

backend default_https
    mode tcp
    server default ${DEFAULT_HTTPS}

frontend http_in
    bind *:80
    mode http
EOF

for i in $(seq 0 $((ROUTE_COUNT - 1))); do
    DOMAIN=$(bashio::config "routes[${i}].domain_suffix")
    BACKEND_HOST=$(bashio::config "routes[${i}].backend_host")
    BACKEND_PORT=$(bashio::config "routes[${i}].backend_http_port")
    BACKEND_NAME="route_${i}_http"

    bashio::log.info "HTTP route: *${DOMAIN} -> ${BACKEND_HOST}:${BACKEND_PORT}"

    cat >> /etc/haproxy/haproxy.cfg <<EOF
    use_backend ${BACKEND_NAME} if { hdr_end(host) ${DOMAIN} }
EOF
done

cat >> /etc/haproxy/haproxy.cfg <<EOF
    default_backend default_http

backend default_http
    mode http
    server default ${DEFAULT_HTTP}
EOF

for i in $(seq 0 $((ROUTE_COUNT - 1))); do
    BACKEND_HOST=$(bashio::config "routes[${i}].backend_host")
    HTTPS_PORT=$(bashio::config "routes[${i}].backend_https_port")
    HTTP_PORT=$(bashio::config "routes[${i}].backend_http_port")

    cat >> /etc/haproxy/haproxy.cfg <<EOF

backend route_${i}_https
    mode tcp
    server backend ${BACKEND_HOST}:${HTTPS_PORT}

backend route_${i}_http
    mode http
    server backend ${BACKEND_HOST}:${HTTP_PORT}
EOF
done

for folders in /etc/services.d /etc/s6-overlay; do
    [[ -d "$folders" ]] && rm -r "$folders"
done

bashio::log.info "Starting HAProxy..."
bashio::log.info "Default HTTPS backend: ${DEFAULT_HTTPS}"
bashio::log.info "Default HTTP backend: ${DEFAULT_HTTP}"

exec haproxy -f /etc/haproxy/haproxy.cfg -db
