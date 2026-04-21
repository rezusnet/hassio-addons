# HAProxy SNI Router

Lightweight SNI and Host-header based routing proxy that sits in front of Nginx
Proxy Manager. Routes specific domains to external backends (e.g. Traefik on
another machine) while forwarding everything else to NPM.

## Features

- SNI-based TLS routing on port 443 (raw TCP passthrough)
- Host-header based HTTP routing on port 80
- Configurable domain-to-backend routes
- Zero maintenance: no NPM modifications required
- Supports unlimited dynamic subdomains via suffix matching

## Setup

1. Change NPM host ports: Settings → Add-ons → NPM → Configuration → Network
   - `80/tcp`: change to `8080`
   - `443/tcp`: change to `4433` (or `8443`)
   - Restart NPM
2. Install and start this add-on
3. Configure routes in the add-on options

## Configuration

| Option | Description |
|--------|-------------|
| `routes` | List of domain-to-backend mappings |
| `routes[].domain_suffix` | Domain suffix to match (e.g. `.rezus.net`) |
| `routes[].backend_host` | Backend server IP or hostname |
| `routes[].backend_http_port` | Backend HTTP port |
| `routes[].backend_https_port` | Backend HTTPS port |
| `default_http_backend` | Default HTTP backend (`host:port`) |
| `default_https_backend` | Default HTTPS backend (`host:port`) |
