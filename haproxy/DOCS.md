# HAProxy SNI Router - Full Documentation

## Overview

This add-on runs HAProxy as a front-facing proxy on ports 80 and 443. It
inspects incoming traffic and routes it based on domain:

- **HTTPS (port 443)**: Reads the SNI (Server Name Indication) field from the
  TLS ClientHello without terminating SSL. Matching connections are forwarded
  as raw TCP to the configured backend.
- **HTTP (port 80)**: Reads the `Host` header. Matching requests are proxied
  to the configured backend.

Traffic that doesn't match any route is forwarded to the default backends
(typically NPM).

## Architecture

```
Internet → Router (80/443) → HA (HAProxy)
  ├── *.rezus.net:443    → raw TCP → Traefik (192.168.7.5:443)
  ├── *.rezus.net:80     → HTTP    → Traefik (192.168.7.5:80)
  ├── everything else:443 → raw TCP → NPM (127.0.0.1:8443)
  └── everything else:80  → HTTP    → NPM (127.0.0.1:8080)
```

## Setup Guide

### Step 1: Change NPM Host Ports

NPM currently binds to host ports 80 and 443. You need to move it to different
ports so HAProxy can take over 80 and 443.

In Home Assistant: **Settings → Add-ons → Nginx Proxy Manager → Configuration → Network**

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

- Existing `*.maschiezza.duckdns.org` sites should work as before (via
  HAProxy → NPM)
- New `*.rezus.net` sites should reach Traefik (via HAProxy → Traefik)

## Configuration Reference

### Routes

Each route defines a domain suffix and its backend:

| Field | Type | Description |
|-------|------|-------------|
| `domain_suffix` | string | Domain suffix to match (e.g. `.rezus.net`). Must start with a dot. |
| `backend_host` | string | IP address or hostname of the backend server |
| `backend_http_port` | int | Port for HTTP traffic on the backend |
| `backend_https_port` | int | Port for HTTPS traffic on the backend |

### Default Backends

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `default_http_backend` | string | `127.0.0.1:8080` | Backend for unmatched HTTP traffic |
| `default_https_backend` | string | `127.0.0.1:8443` | Backend for unmatched HTTPS traffic |

### Example Configuration

```yaml
routes:
  - domain_suffix: .rezus.net
    backend_host: 192.168.7.5
    backend_http_port: 80
    backend_https_port: 443
default_http_backend: 127.0.0.1:8080
default_https_backend: 127.0.0.1:8443
```

## How SNI Routing Works

When a client connects on port 443, HAProxy reads the TLS ClientHello message
without terminating the SSL/TLS connection. The SNI field in the ClientHello
contains the server name the client is requesting (e.g. `app.rezus.net`).

HAProxy matches the server name against configured domain suffixes. If a match
is found, the entire TCP connection is forwarded to the corresponding backend.
The backend (e.g. Traefik) performs the actual SSL termination.

This means:
- The backend handles its own SSL certificates
- HAProxy never sees decrypted traffic
- The backend sees the original client IP only if PROXY protocol is enabled
  (not enabled by default)

## ACME / Let's Encrypt

### NPM Domains (*.maschiezza.duckdns.org)

NPM's ACME challenges continue to work. HTTP-01 challenges arrive on port 80,
HAProxy forwards them to NPM (default backend) which serves the challenge
response.

### Traefik Domains (*.rezus.net)

Traefik handles its own SSL certificates. HTTP-01 challenges for Traefik
domains arrive on port 80, HAProxy forwards them to Traefik (matched by
domain suffix). Traefik serves the challenge response and obtains/renews
certificates automatically.

## Troubleshooting

### Add-on won't start

Check that NPM is no longer binding to ports 80 and 443. Two processes cannot
listen on the same port. Verify with:

```bash
ss -tlnp | grep -E ':80|:443'
```

### Existing NPM sites not working

- Verify NPM is running and its host ports are set to 8080/8443
- Check HAProxy logs for routing errors
- Verify `default_http_backend` and `default_https_backend` point to NPM's
  new host ports

### Traefik sites not reachable

- Verify the Traefik machine (192.168.7.5) is reachable from the HA host
- Verify Traefik is listening on ports 80 and 443
- Check that DNS for `*.rezus.net` points to the HA machine's public IP
- Check HAProxy logs: `docker logs addon_2eafa696_haproxy`

### SSL certificate errors on Traefik domains

HAProxy forwards raw TCP — it doesn't touch SSL. Certificate errors indicate
an issue on the Traefik side. Check Traefik's certificate configuration and
logs.
