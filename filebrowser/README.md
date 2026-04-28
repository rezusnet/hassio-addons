# Home Assistant add-on: Filebrowser

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/filebrowser)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/filebrowser)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/filebrowser)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Filebrowser banner](banner.svg)

## About

[Filebrowser](https://filebrowser.org/) is a web-based file manager that provides a clean interface for browsing, uploading, downloading, renaming, previewing, and editing files directly from your browser.

This add-on is based on the [filebrowser/filebrowser](https://github.com/filebrowser/filebrowser) Docker image and exposes Filebrowser through Home Assistant ingress.

**Key features:**

- Browse, upload, download, rename, move, copy, and delete files from the browser
- Preview images, audio, video, and documents, and edit text files in place
- Optional authentication, user management, and HTTPS support
- Custom base folder selection for narrowing the served path
- Mount local disks and SMB/CIFS network shares
- Access Home Assistant config, media, backups, and add-on data from one UI
- HA ingress sidebar support

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the "Filebrowser" add-on from the add-on store.
3. Configure the add-on options (see Documentation tab).
4. Start the add-on.
5. Access Filebrowser via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:8071`.

For full configuration details, file access, and troubleshooting, see the **Documentation** tab.
