#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -e

if bashio::config.has_value 'DNS_server'; then
    DNSSERVER=$(bashio::config 'DNS_server')
    DNS=""
    DNSLIST=""
    for server in ${DNSSERVER//,/ }; do
        if ping -c 1 "$server" &> /dev/null; then
            DNS="${DNS}nameserver $server\n"
            DNSLIST="$server $DNSLIST"
        else
            bashio::log.warning "DNS $server can't be pinged"
        fi
    done
    if [[ -n "${DNS:-}" ]]; then
        printf "${DNS}" > /etc/resolv.conf
        chmod 644 /etc/resolv.conf
        bashio::log.info "DNS SERVERS set to $DNSLIST"
    fi
fi
