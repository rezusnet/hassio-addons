# Home Assistant add-on: Bookshelf

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fbookshelf%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/bookshelf)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fbookshelf%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/bookshelf)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fbookshelf%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/bookshelf)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/lint.yml)

![Bookshelf banner](banner.svg)

## About

[Bookshelf](https://github.com/pennydreadful/bookshelf) is a book and audiobook collection manager — a community fork of Readarr with native [rreading-glasses](https://github.com/blampe/rreading-glasses) metadata integration.

This add-on is based on the [pennydreadful/bookshelf](https://github.com/pennydreadful/bookshelf) Docker image (LSIO-based).

**Key features:**

- Native rreading-glasses metadata support (GoodReads or Hardcover)
- Self-hosted metadata URL configuration
- Backward compatible with existing Readarr databases
- Add new books with metadata, ratings, and release monitoring
- Monitor RSS feeds and search indexers automatically
- Automatically import, rename, and organize completed downloads
- Integrates with major Usenet and BitTorrent download clients
- HA ingress sidebar support
- SMB/CIFS network share mounting
- Local USB/SATA/NVMe disk mounting

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Bookshelf** add-on from the add-on store.
3. Configure media paths and metadata options (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:8787`.

For full configuration details, media path planning, and troubleshooting, see the **Documentation** tab.
