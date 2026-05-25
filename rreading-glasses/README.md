# Home Assistant add-on: Rreading Glasses

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Frreading-glasses%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/rreading-glasses)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Frreading-glasses%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/rreading-glasses)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Rreading Glasses banner](banner.svg)

## About

[Rreading Glasses](https://github.com/blampe/rreading-glasses) is a drop-in replacement for Readarr's defunct proprietary metadata service. It provides fast, complete access to GoodReads and Hardcover book metadata for Readarr and its community forks (e.g. [pennydreadful/bookshelf](https://github.com/pennydreadful/bookshelf), [Faustvii/Readarr](https://github.com/Faustvii/Readarr)).

This add-on is based on the official [blampe/rreading-glasses](https://hub.docker.com/r/blampe/rreading-glasses) Docker image.

**Key features:**

- Drop-in replacement — works with existing Readarr installations
- GoodReads and Hardcover metadata sources
- Full coverage of large authors and new releases
- Bundled PostgreSQL for zero-config setup
- External PostgreSQL option for advanced deployments
- Configurable via Home Assistant add-on options

## Installation

1. Add this repository to your Home Assistant instance:

   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)

2. Install the **Rreading Glasses** add-on from the add-on store.
3. Start the add-on. The bundled PostgreSQL initializes automatically.
4. In Readarr, navigate to `/settings/development` and set **Metadata Provider Source** to `http://<your-ha-ip>:8788`.

For full configuration details, see the **Documentation** tab.
