# Home Assistant add-on: HAProxy SNI Router

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fhaproxy%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/haproxy)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fhaproxy%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/haproxy)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![HAProxy SNI Router banner](banner.svg)

## About

[HAProxy SNI Router](https://www.haproxy.org/) is sni and host-header based tcp/http routing proxy. sits in front of nginx proxy manager to route specific domains to external backends (e.g. traefik) while forwarding everything else to npm..

This add-on is based on the [linuxserver/docker-haproxy](https://github.com/linuxserver/docker-haproxy) Docker image.

**Key features:**

- Containerized application
- Easy configuration
- Home Assistant integration
- Multi-architecture support

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **HAProxy SNI Router** add-on from the add-on store.
3. Configure options as needed (see **Documentation** tab).
4. Start the add-on.


For full configuration details and troubleshooting, see the **Documentation** tab.
