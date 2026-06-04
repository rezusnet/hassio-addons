# Home Assistant add-on: RezusCloud

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Frezuscloud%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/rezuscloud)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Frezuscloud%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/rezuscloud)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Frezuscloud%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/rezuscloud)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![RezusCloud banner](banner.svg)

## About

[RezusCloud](https://github.com/rezuscloud/rezuscloud) is a personal cloud management platform. Run Kubernetes clusters from your home — manage Talos-based nodes, tenants, and machine lifecycles from the Home Assistant sidebar.

This add-on runs the RezusCloud management plane (HTTP API, WebUI, MachineLink, provider gRPC) as a native HA add-on.

**Key features:**

- WebUI dashboard in the HA sidebar (ingress)
- Create and manage Talos-based Kubernetes tenants
- MachineLink gRPC for node provisioning
- Provider gRPC for machine lifecycle management
- SQLite state storage (no external database needed)
- S3 backup support
- Join token-based machine enrollment

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Frezusnet%2Fhassio-addons)
2. Install the **RezusCloud** add-on from the add-on store.
3. Configure options (see Documentation tab).
4. Click **Start**.
5. Access via the **HA sidebar** (RezusCloud panel, admin users only).

## Requirements

- **Home Assistant OS or Supervised**
- **Minimum 4 GB RAM** — management cluster components need headroom
- **Docker access** — creates Talos containers via Docker socket
- **ARM64 or AMD64** architecture
