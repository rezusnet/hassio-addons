# Home Assistant add-on: Prowlarr

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fprowlarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/prowlarr)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fprowlarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/prowlarr)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fprowlarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/prowlarr)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Prowlarr banner](banner.svg)

## About

[Prowlarr](https://prowlarr.com/) is an indexer manager and proxy for the Servarr stack. It manages torrent trackers and Usenet indexers in one place and syncs them across your connected applications.

This add-on is based on the [linuxserver/docker-prowlarr](https://github.com/linuxserver/docker-prowlarr) Docker image.

**Key features:**

- Manage torrent trackers and Usenet indexers in one place
- Sync indexers automatically to Sonarr, Radarr, Lidarr, Readarr, and other supported apps
- Manual category-based searching and parameter-based search tools
- Push one or more releases directly to download clients
- Indexer history, health, and usage statistics
- Per-indexer proxy support for SOCKS4, SOCKS5, HTTP, and Flaresolverr setups
- Support for custom Cardigann YML indexer definitions
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Prowlarr** add-on from the add-on store.
3. Configure options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:9696`.

For full configuration details, indexer sync setup, and troubleshooting, see the **Documentation** tab.
