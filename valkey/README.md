# Home Assistant add-on: Valkey

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fvalkey%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/valkey)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fvalkey%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/valkey)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![Valkey banner](banner.svg)

## About

[Valkey](https://github.com/valkey-io/valkey) is an open source (BSD-3 licensed), high-performance key-value data store. It is a drop-in replacement for Redis, fully wire-protocol compatible.

This add-on is based on the official [valkey/valkey](https://hub.docker.com/r/valkey/valkey) Docker image (Alpine variant).

**Key features:**

- Fully Redis-compatible — works with any Redis client library
- In-memory data store with optional persistence (RDB snapshots)
- Supports strings, hashes, lists, sets, sorted sets, streams, and more
- Pub/Sub messaging, Lua scripting, transactions
- Configurable memory limits and eviction policies
- Lightweight (~18MB Alpine image)

## Installation

1. Add this repository to your Home Assistant instance:

   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)

2. Install the **Valkey** add-on from the add-on store.
3. (Optional) Set a password in the Configuration tab.
4. Start the add-on.

For full configuration details, see the **Documentation** tab.
