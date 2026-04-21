# HAProxy SNI Router - Full Documentation

## Overview

This add-on runs HAProxy as a front-facing proxy on ports 80 and 443. It
inspects incoming traffic and routes it based on domain:

- **HTTPS (port 443)**: Reads the SNI (Server Name Indication) field from the
  TLS ClientHello without terminating SSL. Matching connections are forwarded
  as raw TCP to the configured backend.
- **HTTP (port 80)**: Reads the `Host` header. Matching requests are proxied
  to the configured backend.

Traffic that does not match any route is forwarded to the default backends
(typically NPM).

## Architecture

```
Internet → Router (80/443) → HA (HAProxy)
  ├── matched-domain.com:443  → raw TCP → external backend (e.g. Traefik)
  ├── matched-domain.com:80   → HTTP    → external backend
  ├── everything else:443     → raw TCP → NPM (127.0.0.1:8443)
  └── everything else:80      → HTTP    → NPM (127.0.0.1:8080)
```

## Setup Guide

### Step 1: Change NPM Host Ports

NPM currently binds to host ports 80 and 443. Move it to different ports so
HAProxy can take over.

In Home Assistant: **Settings → Add-ons → Nginx Proxy Manager → Network**

- Change `80/tcp` from `80` to `8080`
- Change `443/tcp` from `443` to `8443`
- Restart NPM

NPM's internal nginx still listens on 80/443 inside its container. Only the
host-side port mapping changes. All existing proxy hosts, certificates, and
ACME challenges continue to work.

### Step 2: Install and Start HAProxy

1. Install the HAProxy SNI Router add-on
2. Configure your routes (see Configuration Reference below)
3. Start the add-on

### Step 3: Verify

- Existing sites managed by NPM should work as before (via HAProxy → NPM)
- New domains routed to your external backend should reach it directly

## Configuration Reference

### Routes

Each route defines a domain suffix and its backend:

| Field | Type | Description |
|-------|------|-------------|
| `domain_suffix` | string | Domain suffix to match (e.g. `.example.com`). Must start with a dot. |
| `backend_host` | string | IP address or hostname of the backend server |
| `backend_http_port` | int | Port for HTTP traffic on the backend |
| `backend_https_port` | int | Port for HTTPS traffic on the backend |

### Default Backends

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `default_http_backend` | string | `127.0.0.1:8080` | Backend for unmatched HTTP traffic |
| `default_https_backend` | string | `127.0.0.1:8443` | Backend for unmatched HTTPS traffic |

### Example: Route one domain suffix to Traefik

```yaml
routes:
  - domain_suffix: .example.com
    backend_host: 192.168.1.100
    backend_http_port: 80
    backend_https_port: 443
default_http_backend: 127.0.0.1:8080
default_https_backend: 127.0.0.1:8443
```

### Example: Multiple backends

```yaml
routes:
  - domain_suffix: .example.com
    backend_host: 192.168.1.100
    backend_http_port: 80
    backend_https_port: 443
  - domain_suffix: .another-domain.org
    backend_host: 10.0.0.50
    backend_http_port: 8080
    backend_https_port: 8443
default_http_backend: 127.0.0.1:8080
default_https_backend: 127.0.0.1:8443
```

## How SNI Routing Works

When a client connects on port 443, HAProxy reads the TLS ClientHello message
without terminating the SSL/TLS connection. The SNI field in the ClientHello
contains the server name the client is requesting (e.g. `app.example.com`).

HAProxy matches the server name against configured domain suffixes. If a match
is found, the entire TCP connection is forwarded to the corresponding backend.
The backend (e.g. Traefik) performs the actual SSL termination.

This means:
- The backend handles its own SSL certificates
- HAProxy never sees decrypted traffic

## ACME / Let's Encrypt

### NPM Domains

NPM's ACME challenges continue to work. HTTP-01 challenges arrive on port 80,
HAProxy forwards them to NPM (default backend) which serves the challenge
response.

### External Backend Domains

If the external backend (e.g. Traefik) handles its own SSL certificates via
Let's Encrypt, HTTP-01 challenges arrive on port 80. HAProxy forwards them to
the backend (matched by domain suffix). The backend serves the challenge
response and obtains/renews certificates automatically.

## Troubleshooting

### Add-on won't start

Check that NPM is no longer binding to ports 80 and 443. Two processes cannot
listen on the same port. Verify NPM's network configuration shows `8080` and
`8443` instead of `80` and `443`.

### Existing NPM sites not working

- Verify NPM is running and its host ports are set to 8080/8443
- Check HAProxy add-on logs for routing errors
- Verify `default_http_backend` and `default_https_backend` point to NPM's
  new host ports

### External backend sites not reachable

- Verify the backend host is reachable from the HA host
- Verify the backend is listening on the configured ports
- Check that DNS for the domain points to the HA machine's public IP
- Check HAProxy add-on logs

### SSL certificate errors on routed domains

HAProxy forwards raw TCP and does not touch SSL. Certificate errors indicate
an issue on the backend side. Check the backend's certificate configuration.
