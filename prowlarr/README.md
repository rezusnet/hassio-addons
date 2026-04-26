# Home Assistant add-on: Prowlarr

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fprowlarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/prowlarr)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fprowlarr%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/prowlarr)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[Prowlarr](https://prowlarr.com/) is an indexer manager for PVR applications. It manages Torznab and Newznab indexers and syncs them with Sonarr, Radarr, Lidarr, and Readarr.

This add-on is based on the [linuxserver/docker-prowlarr](https://github.com/linuxserver/docker-prowlarr) Docker image.

**Key features:**

- Manage Torznab and Newznab indexers in one place
- Sync indexers to Sonarr, Radarr, Lidarr, and Readarr automatically
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
