# Home Assistant add-on: Raneto

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Franeto%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/raneto)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Franeto%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/raneto)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Franeto%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/raneto)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Raneto banner](banner.svg)

## About

[Raneto](https://raneto.com/) is a simple, clean knowledge base and documentation system. Organize and share documents with markdown, create nested knowledge bases, and manage team documentation with ease.

This add-on is based on the [linuxserver/docker-raneto](https://github.com/linuxserver/docker-raneto) Docker image.

**Key features:**

- Clean, intuitive web interface for documentation management
- Markdown-based content with live preview
- Nested knowledge base organization
- Full-text search across documents
- User-friendly administration panel
- HA ingress sidebar support
- Customizable branding and appearance
- Multi-language support

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Raneto** add-on from the add-on store.
3. Configure storage location and timezone (see Documentation tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:3000`.

For full configuration details and troubleshooting, see the **Documentation** tab.
