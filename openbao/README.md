# Home Assistant add-on: OpenBao

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopenbao%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/openbao)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopenbao%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/openbao)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![OpenBao banner](banner.svg)

## About

[OpenBao](https://openbao.org) is an open source, identity-based secrets and
encryption management system — the community fork of HashiCorp Vault,
licensed MPL-2.0. It secures, stores and tightly controls access to tokens,
passwords, certificates and encryption keys.

This add-on runs OpenBao as a **single-node** server with **integrated Raft
storage** on your Home Assistant device (aarch64 / amd64).

**Key features:**

- Central secrets management with the full Vault/OpenBao API and CLI
- Web UI on port 8200
- Integrated Raft storage — data lives in the add-on's own directory and is
  included in Home Assistant backups
- Automatic initialization and (optional) auto-unseal after restarts
- Audit logging to stdout and/or file

## Installation

1. Add this repository to your Home Assistant instance:

   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)

2. Install the *OpenBao* add-on.
3. Start it and follow the first-run steps in the [Documentation](DOCS.md) —
   most importantly: **back up `init.json` off the device**.

## Support

- [Documentation](DOCS.md)
- [OpenBao documentation](https://openbao.org/docs/)
- [Report an issue](https://github.com/rezusnet/hassio-addons/issues)

## Authors & contributors

Maintained by [rezusnet](https://github.com/rezusnet).
Upstream: [openbao/openbao](https://github.com/openbao/openbao) (MPL-2.0).
Logo and banner: [openbao/artwork](https://github.com/openbao/artwork), CC-BY-4.0.

## License

Add-on code: MIT. OpenBao itself: MPL-2.0.
