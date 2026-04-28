# Home Assistant add-on: HAProxy SNI Router

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fhaproxy%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/haproxy)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fhaproxy%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/haproxy)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![HAProxy banner](banner.svg)

## About

HAProxy SNI Router is a lightweight SNI and Host-header based routing proxy for Home Assistant. It sits in front of Nginx Proxy Manager or another default backend and forwards selected domains to external services.

This add-on is based on the official [haproxy:alpine](https://hub.docker.com/_/haproxy) Docker image.

**Key features:**

- SNI-based TLS routing on port 443 using raw TCP passthrough
- Host-header based HTTP routing on port 80
- Domain suffix matching for directing traffic to external backends
- Default backends for unmatched traffic, including Nginx Proxy Manager
- Zero certificate handling in HAProxy for routed HTTPS traffic
- Host network mode for direct front-facing proxy operation

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Move Nginx Proxy Manager host ports away from `80` and `443` if you plan to use it as the default backend.
3. Install the **HAProxy SNI Router** add-on from the add-on store.
4. Configure your route mappings.
5. Start the add-on.

> **Note:** This add-on has no web UI and no ingress panel. Manage it through its Home Assistant configuration and logs.

For full routing examples, setup steps, and troubleshooting, see the **Documentation** tab.
