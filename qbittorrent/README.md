# Home Assistant add-on: qBittorrent

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fqbittorrent%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/qbittorrent)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fqbittorrent%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/qbittorrent)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[qBittorrent](https://www.qbittorrent.org/) is a cross-platform BitTorrent client with a feature-rich web UI. It is fast, lightweight, and supports RSS feeds, torrent search, and IP filtering.

This add-on is based on the [linuxserver/docker-qbittorrent](https://github.com/linuxserver/docker-qbittorrent) Docker image.

**Key features:**

- Feature-rich web UI for torrent management
- RSS feed support for automated downloads
- Integrated torrent search engine
- IP filtering and encryption support
- HA ingress sidebar support
- SMB/CIFS network share mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **qBittorrent** add-on from the add-on store.
3. Configure options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:8080`.
