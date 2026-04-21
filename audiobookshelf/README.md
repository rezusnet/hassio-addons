# Home Assistant add-on: Audiobookshelf

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Faudiobookshelf%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/audiobookshelf)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Faudiobookshelf%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/audiobookshelf)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[Audiobookshelf](https://github.com/advplyr/audiobookshelf) is a self-hosted audiobook and podcast server. Stream audiobooks and podcasts to any device, manage your library through a web UI, and track progress across devices.

**Key features:**

- Stream audiobooks and podcasts to any device
- Multi-user support with per-user progress tracking
- Supports all audio formats and ebooks (epub, pdf, cbr, cbz)
- Automatic library scanning and metadata fetching
- Podcast episode auto-download
- OpenID Connect (SSO) support
- Companion mobile apps for [Android](https://play.google.com/store/apps/details?id=com.audiobookshelf.app) and [iOS](https://apps.apple.com/us/app/audiobookshelf/id1578137973)

> **Note:** Audiobookshelf uses a Nuxt SPA that is incompatible with the HA ingress sidebar panel. The add-on provides direct web UI access via the "Open Web UI" button which opens the app in a new browser tab. You can add it as an iframe Dashboard panel instead (see the Documentation tab for instructions).

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Audiobookshelf** add-on from the add-on store.
3. Configure the library paths (see Configuration tab).
4. Start the add-on.
5. Click **Open Web UI** to open Audiobookshelf at `http://<your-ha-ip>:8133/audiobookshelf/`.

For full configuration details, guides, and troubleshooting, see the **Documentation** tab.
