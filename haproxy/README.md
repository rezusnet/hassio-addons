# HAProxy SNI Router

Lightweight SNI and Host-header based routing proxy that sits in front of Nginx
Proxy Manager. Routes specific domains to external backends (e.g. Traefik on
another machine) while forwarding everything else to NPM.

## Features

- SNI-based TLS routing on port 443 (raw TCP passthrough)
- Host-header based HTTP routing on port 80
- Configurable domain-to-backend routes via add-on options
- Zero maintenance: no NPM modifications required
- Supports unlimited dynamic subdomains via suffix matching

## How It Works

```
Internet (80/443) → HAProxy (this add-on)
  ├── matched domains:443   → raw TCP  → external backend
  ├── matched domains:80    → HTTP     → external backend
  ├── everything else:443   → raw TCP  → NPM (127.0.0.1:8443)
  └── everything else:80    → HTTP     → NPM (127.0.0.1:8080)
```

## Setup

1. Change NPM host ports in HA: **Settings → Add-ons → NPM → Network**
   - `80/tcp`: change to `8080`
   - `443/tcp`: change to `8443`
   - Restart NPM
2. Install and start this add-on
3. Configure your routes in the add-on options

## Configuration

| Option | Default | Description |
|--------|---------|-------------|
| `routes` | (see below) | List of domain-to-backend mappings |
| `routes[].domain_suffix` | `.example.com` | Domain suffix to match |
| `routes[].backend_host` | `192.168.1.100` | Backend server IP/hostname |
| `routes[].backend_http_port` | `80` | Backend HTTP port |
| `routes[].backend_https_port` | `443` | Backend HTTPS port |
| `default_http_backend` | `127.0.0.1:8080` | Default HTTP backend |
| `default_https_backend` | `127.0.0.1:8443` | Default HTTPS backend |
