# Home Assistant add-on: Mastodon

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fmastodon%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/mastodon)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fmastodon%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/mastodon)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fmastodon%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/mastodon)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Mastodon banner](banner.svg)

## About

[Mastodon](https://joinmastodon.org/) is a free, open-source, self-hosted social networking platform. It is decentralized and federated, using the ActivityPub protocol to communicate with other Mastodon instances and Fediverse platforms.

This add-on is based on the [linuxserver/docker-mastodon](https://github.com/linuxserver/docker-mastodon) Docker image.

**Key features:**

- Decentralized, federated microblogging (part of the Fediverse)
- Real-time timeline updates via WebSocket streaming
- Full-featured web UI accessible via HA Ingress
- Media attachments (images, video, audio)
- Custom emojis, polls, content warnings
- Fine-grained privacy controls per post
- Full-text search (with optional Elasticsearch)
- Push notifications via VAPID
- HA ingress sidebar support
- Auto-generated and persisted encryption secrets

## Requirements

- **PostgreSQL 14+** (external database, not included)
- **Redis 6+** (external cache, not included)
- **SMTP server** (for email delivery and account sign-ups)

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **Mastodon** add-on from the add-on store.
3. Set up PostgreSQL and Redis (see Documentation tab).
4. Configure `LOCAL_DOMAIN`, `DB_HOST`, `DB_PASS`, `REDIS_HOST`, and SMTP settings.
5. Start the add-on.
6. Access via the **HA sidebar** (Ingress) and create your admin account.

For full configuration, federation setup, and troubleshooting, see the **Documentation** tab.
