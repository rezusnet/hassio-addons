# Home Assistant add-on: MinIO

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fminio%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/minio)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fminio%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/minio)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[Silo](https://silo.pigsty.io) (by [Pigsty](https://pigsty.io)) is an open source S3-compatible object storage server — an active community fork of MinIO. It provides a fully compatible Amazon S3 API with a built-in web console for managing buckets, objects, and access policies.

This add-on is based on the [pgsty/minio](https://hub.docker.com/r/pgsty/minio) Docker image.

**Key features:**

- Fully S3-compatible API — works with any S3 client library or tool (aws cli, s3cmd, mc)
- Web console for bucket management, file upload/download, and access control
- Supports versioning, lifecycle policies, and event notifications
- Lightweight single-node deployment ideal for Home Assistant
- Accessible via HA ingress (web console) and S3 API port

## Installation

1. Add this repository to your Home Assistant instance:

   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)

2. Find "MinIO" in the add-on store and install it.
3. Configure `access_key` and `secret_key` (change from defaults!).
4. Start the add-on.
5. Open the web console from the HA sidebar.

## Configuration

| Option          | Type     | Default        | Description                  |
| --------------- | -------- | -------------- | ---------------------------- |
| `access_key`    | string   | `minioadmin`   | Root access key (username)   |
| `secret_key`    | password | `minioadmin`   | Root secret key (password)   |
| `data_location` | string   | `/share/minio` | Storage path for objects     |
| `TZ`            | string   |                | Timezone                     |
| `env_vars`      | list     | `[]`           | Custom environment variables |

### Example

```yaml
access_key: myaccesskey
secret_key: mysecretkey123
data_location: /share/minio
TZ: Europe/Brussels
```

## Ports

| Port       | Purpose                                           |
| ---------- | ------------------------------------------------- |
| 9000 (TCP) | S3 API endpoint — use this in client applications |
| 9001       | Web console — accessible via HA ingress sidebar   |

## Using with other add-ons

Other add-ons or services can connect to MinIO via the S3 API:

- **Endpoint**: `http://homeassistant:9000` (from within HA network)
- **Access key**: your configured `access_key`
- **Secret key**: your configured `secret_key`

Compatible with `aws cli`, `mc` (MinIO Client), `s3cmd`, and any S3-compatible client library.
