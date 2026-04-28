# Home Assistant add-on: Sonarr

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fsonarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/sonarr)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fsonarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/sonarr)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fsonarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/sonarr)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Sonarr banner](banner.svg)

## About

[Sonarr](https://sonarr.tv/) is a PVR for Usenet and BitTorrent users. It monitors RSS feeds and indexers for new episodes, sends them to your download clients, and organizes them into your TV library.

This add-on is based on the [linuxserver/docker-sonarr](https://github.com/linuxserver/docker-sonarr) Docker image.

**Key features:**

- Monitor and download TV series automatically
- Automatic quality upgrades when better versions are available
- Scan existing libraries and fill in missing episodes
- Failed download handling and manual interactive search
- Fully configurable episode renaming and series organization
- Support for specials and multi-episode releases
- Integrates with Usenet and BitTorrent download clients
- Integrates with Plex and Kodi notification/library refresh workflows
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Sonarr** add-on from the add-on store.
3. Configure media paths and options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:8989`.

For full configuration details, media path planning, and troubleshooting, see the **Documentation** tab.
