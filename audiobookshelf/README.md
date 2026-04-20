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

> **Note:** Audiobookshelf uses a Nuxt SPA with absolute API paths, which is incompatible with the HA ingress sidebar panel. The add-on provides direct web UI access via the "Open Web UI" button which opens the app in a new browser tab.

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the "Audiobookshelf" add-on from the add-on store.
3. Configure the add-on options (see below).
4. Start the add-on.
5. Click "Open Web UI" to open Audiobookshelf in a new tab at `http://<your-ha-ip>:8133/audiobookshelf/`.

## Configuration

### Library Paths

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `audiobooks_path` | string | `/media/audiobooks` | Directory for audiobook files. Configure as a library inside the Audiobookshelf web UI after first launch. |
| `podcasts_path` | string | `/media/podcasts` | Directory for podcast files. Configure as a library inside the Audiobookshelf web UI after first launch. |
| `backup_path` | string | _(empty)_ | Custom path for database backups. When empty, backups are stored in `/data/metadata/backups` (add-on config volume). |

### Podcast

| Option | Type | Default | Env var | Description |
|--------|------|---------|---------|-------------|
| `podcast_download_timeout` | int | `30` | `PODCAST_DOWNLOAD_TIMEOUT` | Timeout in seconds to wait for a podcast RSS feed download to start. Range: 1–300. |
| `max_failed_episode_checks` | int | `24` | `MAX_FAILED_EPISODE_CHECKS` | Maximum consecutive failed episode auto-download checks before auto-download is disabled for a podcast. Set to `0` to never auto-disable. Leave empty to use the upstream default (24). |

### Network

| Option | Type | Default | Env var | Description |
|--------|------|---------|---------|-------------|
| `router_base_path` | string | `/audiobookshelf` | `ROUTER_BASE_PATH` | Base URL path prefix for all routes. Change only if you are using a reverse proxy that serves Audiobookshelf under a different subpath. The default `/audiobookshelf` works with the add-on's direct port access. |
| `allow_cors` | bool | `false` | `ALLOW_CORS` | Enable Cross-Origin Resource Sharing. Needed if you have a separate web app or browser extension that needs to access the Audiobookshelf API. |
| `exp_proxy_support` | bool | `false` | `EXP_PROXY_SUPPORT` | Enable experimental proxy support. When enabled, Audiobookshelf respects the `HTTP_PROXY`/`HTTPS_PROXY` environment variables for outbound requests. **Warning:** This also disables the SSRF request filter. |

### Security

| Option | Type | Default | Env var | Description |
|--------|------|---------|---------|-------------|
| `allow_iframe` | bool | `true` | `ALLOW_IFRAME` | Allow the Audiobookshelf UI to be embedded in iframes. Enabled by default for compatibility with Home Assistant iframe panels and Dashboard cards. |
| `disable_ssrf_filter` | bool | `false` | `DISABLE_SSRF_REQUEST_FILTER` | Disable the Server-Side Request Forgery protection filter. May be needed if you self-host podcasts on the same server. |
| `ssrf_whitelist` | string | _(empty)_ | `SSRF_REQUEST_FILTER_WHITELIST` | Comma-separated list of domain hostnames to exclude from the SSRF filter (e.g., `localhost,internal.example.com`). Only effective when the SSRF filter is enabled. |
| `rate_limit_auth_window` | int | `600000` | `RATE_LIMIT_AUTH_WINDOW` | Rate limiting window in milliseconds for authentication endpoints. Default is 10 minutes. Leave empty to use the upstream default. |
| `rate_limit_auth_max` | int | `40` | `RATE_LIMIT_AUTH_MAX` | Maximum number of authentication attempts per IP within the rate limit window. Set to `0` to disable rate limiting entirely. Leave empty to use the upstream default. |
| `access_token_expiry` | int | `3600` | `ACCESS_TOKEN_EXPIRY` | Access token expiration time in seconds. Default is 1 hour. Shorter values are more secure but require more frequent re-authentication. Leave empty to use the upstream default. |
| `refresh_token_expiry` | int | `2592000` | `REFRESH_TOKEN_EXPIRY` | Refresh token expiration time in seconds. Default is 30 days. Leave empty to use the upstream default. |

### Media Delivery

| Option | Type | Default | Env var | Description |
|--------|------|---------|---------|-------------|
| `use_x_accel` | bool | `false` | `USE_X_ACCEL` | Enable Nginx `X-Accel-Redirect` headers for file serving. Enable only if you are using an Nginx reverse proxy in front of the add-on for optimized media file delivery. |

### Advanced

| Option | Type | Default | Env var | Description |
|--------|------|---------|---------|-------------|
| `skip_binaries_check` | bool | `false` | `SKIP_BINARIES_CHECK` | Skip the automatic ffmpeg/ffprobe binary download and version check at startup. The upstream Docker image includes these binaries, so this is usually not needed. |
| `query_logging` | list | `off` | `QUERY_LOGGING` | SQL query logging level. Options: `off` (no logging), `log` (log all SQL queries), `benchmark` (log queries with execution times). Useful for debugging performance issues. |
| `sqlite_cache_size` | int | _(empty)_ | `SQLITE_CACHE_SIZE` | Set the `cache_size` pragma for the SQLite database. Controls the number of database pages held in memory. Higher values use more RAM but can improve query performance. Leave empty for the SQLite default. |
| `sqlite_mmap_size` | int | _(empty)_ | `SQLITE_MMAP_SIZE` | Set the `mmap_size` pragma for the SQLite database. Memory-mapped I/O can improve read performance on supported systems. Leave empty for the SQLite default. |
| `sqlite_temp_store` | int | _(empty)_ | `SQLITE_TEMP_STORE` | Set the `temp_store` pragma for the SQLite database. Controls where temporary tables and indices are stored: `0` or `1` = file, `2` or `3` = memory. Range: 0–3. Leave empty for the SQLite default. |
| `env_vars` | list | `[]` | _(varies)_ | Custom environment variables passed directly to Audiobookshelf. Each entry has a `name` and optional `value`. Useful for setting variables not exposed as dedicated options. |

### Auto-managed (not configurable)

The following environment variables are set automatically by the add-on and cannot be overridden:

| Env var | Value | Purpose |
|---------|-------|---------|
| `CONFIG_PATH` | `/data/config` | Config directory (database, settings). Must be on local storage. |
| `METADATA_PATH` | `/data/metadata` | Metadata directory (cache, streams, covers, logs). |
| `PORT` | `8133` | Listening port. Fixed for the add-on. |
| `SOURCE` | `docker` | Installation source identifier. |

### Accessing files

The add-on maps the following Home Assistant directories:

| HA path | Container path | Access |
|---------|---------------|--------|
| Add-on config | `/data` | Read/Write |
| Media | `/media` | Read/Write |
| Share | `/share` | Read/Write |

Place your audiobook and podcast files under `/media/` (e.g., via the Samba add-on or Filebrowser) and set the library paths accordingly.

### Example configurations

#### Basic — audiobooks and podcasts

```yaml
audiobooks_path: /media/audiobooks
podcasts_path: /media/podcasts
```

#### Custom media paths with backup

```yaml
audiobooks_path: /share/books/audiobooks
podcasts_path: /share/podcasts
backup_path: /share/backups/audiobookshelf
```

#### Secure setup with rate limiting

```yaml
rate_limit_auth_window: 300000
rate_limit_auth_max: 10
access_token_expiry: 1800
```

#### Debugging with query logging

```yaml
query_logging: benchmark
sqlite_cache_size: -20000
```

#### Custom env vars (e.g., OpenID Connect)

```yaml
env_vars:
  - name: TZ
    value: Europe/Amsterdam
```

## Adding Audiobookshelf to the HA sidebar

Since ingress is not supported, you can add Audiobookshelf as a Dashboard iframe panel:

1. Go to **Settings** → **Dashboards**
2. Click **Add Panel** → **Webpage**
3. Set the URL to `http://<your-ha-ip>:8133/audiobookshelf/`
4. Choose an icon (e.g., `mdi:book-open-page-variant`)
5. Click **Create**

## Upstream documentation

- [Audiobookshelf GitHub](https://github.com/advplyr/audiobookshelf)
- [Audiobookshelf Docs](https://www.audiobookshelf.org/docs)
- [Environment Variables Reference](https://www.audiobookshelf.org/docs#env-configuration)
