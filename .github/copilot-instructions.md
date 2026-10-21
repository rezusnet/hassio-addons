# Copilot Instructions for rezusnet/hassio-addons

This repository contains Home Assistant add-ons, primarily wrapping LinuxServer.io (LSIO) Docker images.

## Build, Test, and Lint

All validation happens via GitHub Actions on push and PRs:

```bash
# Lint checks (local preview)
shellcheck <addon>/**/*.sh
hadolint <addon>/Dockerfile
shfmt -i 4 -ci -bn -sr <addon>/**/*.sh
prettier --check <addon>/**/*.{json,yaml,md}
```

**Note:** The full CI pipeline automatically validates:
- PR: lint + test-build Docker images (amd64, aarch64)
- Merge to master: builds + pushes to GHCR + updates repository.json
- Use `[nobuild]` in commit message to skip CI builds

## High-Level Architecture

This is a **multi-addon Home Assistant repository** with a standardized structure:

### Addon Types

- **LSIO-based (most common):** Wrap LinuxServer.io official Docker images (Jellyfin, Sonarr, Radarr, etc.)
  - Use S6 init system with `ha_lsio.sh` patch
  - Config data typically stored in `/config` or custom location via `data_location` option
  - Service lifecycle managed by S6 overlay

- **Custom/standalone:** Use `ha_entrypoint.sh` as entrypoint (OpenCode, Audiobookshelf, Fail2ban)
  - Require `init: true` in config.yaml
  - Manage process lifecycle directly in shell script

### Build System

- **Multi-architecture:** Build for amd64 and aarch64
- **Base images:** Pinned to specific versions in `build.json`
- **Registry:** Push to `ghcr.io/rezusnet/<addon>-{arch}`
- **Version tracking:** Via `updater.json` (monitored by scheduled updater job)

### Home Assistant Integration

- **Addon manifest:** `config.yaml` defines HA integration (ingress, ports, devices, mounts, etc.)
- **Icon requirement:** 128x128 PNG icon.png committed to repo (sourced from upstream)
- **Documentation:** DOCS.md (full reference shown in HA UI), README.md (product-facing overview)

## Key Conventions

### Addon Directory Structure

```
<addon-name>/
├── config.yaml              # HA addon manifest (version, ports, schema, mounts)
├── build.json              # Maps arch to upstream Docker image versions
├── Dockerfile              # 6-section build (see below)
├── updater.json            # Upstream version tracking
├── apparmor.txt            # Security profile (LSIO addon copy from jellyfin template)
├── icon.png                # 128x128 PNG from upstream project
├── banner.svg              # README visual banner
├── rootfs/
│   └── etc/cont-init.d/
│       └── 99-run.sh       # Startup initialization (bashio script)
├── DOCS.md                 # Full operational reference for HA UI
├── README.md               # Product-facing with upstream features + badges
└── CHANGELOG.md            # Version history
```

### Dockerfile Structure (LSIO addon template)

The Dockerfile has 6 distinct sections:

1. **Base setup:** `ARG BUILD_FROM`, `FROM`, declare `BUILD_ARCH` and `BUILD_VERSION`
2. **Image modification:** S6 env vars, apply `ha_lsio.sh` patch, sed fixes to service run script
3. **Install apps:** Copy rootfs/, make scripts executable, run `ha_automodules.sh` and `ha_autoapps.sh`
4. **Entrypoint:** Set `S6_STAGE2_HOOK`, copy `ha_entrypoint.sh` and `bashio-standalone.sh`
5. **Labels:** Standard OCI labels with `io.hass.*` metadata
6. **Healthcheck:** Define `HEALTH_PORT` and `HEALTH_URL`, use curl to validate

**Key detail:** LSIO service run scripts are patched via `sed -i` to inject `LOCATION` config and replace `/config` with `$LOCATION`.

### config.yaml Consistency Rules

- Every option in `options` must have a schema definition in `schema`
- Startup scripts must reference only options that exist in both sections
- LSIO addons: `init: false`, custom addons: `init: true`
- `ingress_port`: Set to actual internal port the ingress proxy targets (never `0`)
- `panel_icon` and `panel_admin`: Top-level keys (same indent as `name`), not nested
- `url`: Point to upstream project, not this repository
- `homeassistant`: Set minimum supported version explicitly

### Shell Scripting Standards

- **Indentation:** 4 spaces (enforced by `shfmt -i 4 -ci -bn -sr`)
- **Startup scripts:** Use `#!/usr/bin/env bashio` shebang, source bashio functions
- **Initialization:** All 99-run.sh scripts must set data location, create required dirs, export TZ if configured
- **Logging:** Use `bashio::log.info` and `bashio::log.error`
- **Error handling:** `set -e` to fail on errors

### Versioning and Updates

- **build.json:** Pin base image tags to specific versions (e.g., `arm64v8-1.2.3`), never use `latest`
- **updater.json format:**
  ```json
  {
    "last_update": "2026-04-26",
    "paused": false,
    "repository": "rezusnet/hassio-addons",
    "slug": "<addon-name>",
    "source": "github",
    "upstream_repo": "owner/repo",
    "upstream_version": "v1.2.3"
  }
  ```
  Optional: `github_beta: true` for pre-releases, `dockerhub_tag_filter` for Docker Hub sources

### README.md and DOCS.md Split

- **README.md (product-focused):** Badges, banner, one-paragraph upstream description, Key Features list, installation/access steps
- **DOCS.md (operational reference):** Getting Started, Configuration (full options table), File Access, Ports, Troubleshooting, Upstream Documentation links

Keep both complementary: README explains *what* the app is, DOCS explains *how* to run it in HA.

### Linting Configuration

- **Shell formatting:** `.shellcheckrc` configured, shfmt uses 4-space indent
- **Dockerfile:** `.hadolint.yaml` ignores specific rules (DL3002, DL3006, DL3008, DL3018, etc.)
- **Markdown:** `.markdownlint.yaml` allows custom indent, disables line-length checks
- **JSON/YAML:** Prettier uses 2-space indent

### Commit Convention

- Use descriptive commit messages
- `[nobuild]` prefix (reserved for CI bot) skips the builder workflow
- One addon per commit preferred
- Include Co-authored-by trailer for Copilot-authored commits:
  ```
  Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
  ```
