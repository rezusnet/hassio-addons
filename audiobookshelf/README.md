# Home Assistant add-on: Audiobookshelf

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Faudiobookshelf%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/audiobookshelf)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Faudiobookshelf%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/audiobookshelf)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Audiobookshelf banner](banner.svg)

## About

[Audiobookshelf](https://www.audiobookshelf.org/) is self-hosted audiobook and podcast server. stream audiobooks and podcasts to any device, manage your library with a web ui, track progress across devices. supports all audio formats, ebooks (epub, pdf, cbr, cbz), and automatic library scanning..

This add-on is based on the [linuxserver/docker-audiobookshelf](https://github.com/linuxserver/docker-audiobookshelf) Docker image.

**Key features:**

- Audiobook and podcast streaming
- Web-based library management
- Cross-device progress tracking
- Support for all audio formats
- E-book support (EPUB, PDF, CBR, CBZ)
## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Audiobookshelf** add-on from the add-on store.
3. Configure options as needed (see **Documentation** tab).
4. Start the add-on.
5. Access at `http://<your-ha-ip>:8133`.

For full configuration details and troubleshooting, see the **Documentation** tab.
