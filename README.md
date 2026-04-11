# Home Assistant Add-ons by rezusnet

[![Add repository on my Home Assistant][repository-badge]][repository-url]

[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)

## About

Home Assistant allows anyone to create add-on repositories to share their add-ons. This repository provides extra Home Assistant add-ons for your installation.

The primary goal is to provide additional, high quality add-ons that allow you to take your automated home to the next level.

## Installation

[![Add repository on my Home Assistant][repository-badge]][repository-url]

Or manually: go to **Settings > Add-ons > Add-on Store > ... > Repositories** and add:

```
https://github.com/rezusnet/hassio-addons
```

## Add-ons provided by this repository

| Addon | Description |
|-------|-------------|
| [Filebrowser](filebrowser/) | Web-based file management interface for your Home Assistant system |

## Using an Addon

1. Install the addon from the Add-on Store
2. Configure options (check the addon's README for details)
3. Click **Start**
4. Access via the sidebar (Ingress) or at `<your-ip>:<port>`

## Developing Addons

See [CONTRIBUTING.md](CONTRIBUTING.md) for full development guidelines.

Quick start:

1. Create a directory with your addon slug name
2. Add `config.yaml`, `Dockerfile`, `build.json`
3. Optionally add `updater.json` for auto-version tracking
4. Commit - CI will lint, build, and publish automatically

### Addon Directory Structure

```
my-addon/
├── config.yaml          # Addon manifest
├── build.json           # Base images per arch
├── Dockerfile           # Build instructions (6-section pattern)
├── updater.json         # Auto-update tracking (optional)
├── apparmor.txt         # Security profile (optional)
├── rootfs/              # Files overlaid onto container
│   └── etc/
│       └── cont-init.d/ # S6 init scripts
├── README.md            # Addon docs
├── CHANGELOG.md         # Version history (auto-maintained)
└── icon.png             # Addon icon
```

### The config.yaml Manifest

```yaml
name: My Addon
description: What it does
version: "1.0.0"
arch:
  - aarch64
  - amd64
image: ghcr.io/rezusnet/my-addon-{arch}
slug: my_addon
url: https://github.com/rezusnet/hassio-addons
options:
  setting: default_value
schema:
  setting: str
```

### The Dockerfile Pattern

All addons follow a 6-section pattern:

1. **Build Image** - `ARG BUILD_FROM; FROM ${BUILD_FROM}`
2. **Modify Image** - S6 overlay environment variables
3. **Install Apps** - Copy rootfs, download shared template modules, install packages
4. **Entrypoint** - Copy `ha_entrypoint.sh` and `bashio-standalone.sh`
5. **Labels** - OCI and `io.hass.*` labels
6. **Healthcheck** - HTTP health check

### Shared Templates (`.templates/`)

Shared scripts are downloaded at build time from GitHub:
- `00-banner.sh` - Startup info banner
- `00-global_var.sh` - Converts options to environment variables
- `00-smb_mounts.sh` - Mounts SMB/CIFS shares
- `00-local_mounts.sh` - Mounts local disks
- `01-custom_script.sh` - Runs custom user scripts
- `ha_entrypoint.sh` - Main entrypoint with shebang detection
- `bashio-standalone.sh` - Standalone bashio for non-Supervisor environments

Reference in your Dockerfile:
```dockerfile
ARG MODULES="00-banner.sh 01-custom_script.sh"
COPY ha_automodules.sh /ha_automodules.sh
RUN chmod 744 /ha_automodules.sh && /ha_automodules.sh "$MODULES" && rm /ha_automodules.sh
```

### Auto-Update Tracking

Add `updater.json` to your addon to enable automatic upstream version tracking:

```json
{
  "source": "github",
  "upstream_repo": "upstream/project",
  "upstream_version": "1.0.0",
  "repository": "rezusnet/hassio-addons",
  "slug": "my_addon",
  "paused": false
}
```

### CI/CD Pipeline

- **Push to master** with `config.*` changes triggers the builder
- **PRs** are validated: linted + test-built (no push)
- **Weekly** auto-updater checks upstream for new versions
- **Daily** stale issue management
- **`[nobuild]`** in commit messages skips CI builds

### Local Development

Use the included devcontainer (requires Docker):
1. Open in VS Code with Dev Containers extension
2. The official HA devcontainer image provides Supervisor integration
3. Test addon builds locally before pushing

## Support

Open an issue on [GitHub Issues](https://github.com/rezusnet/hassio-addons/issues).

[repository-badge]: https://img.shields.io/badge/Add%20repository%20to%20my-Home%20Assistant-41BDF5?logo=home-assistant&style=for-the-badge
[repository-url]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Frezusnet%2Fhassio-addons
