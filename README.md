# Home Assistant Add-ons by rezusnet

[![Add repository on my Home Assistant][repository-badge]][repository-url]

[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)
[![Code Quality](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Code%20Quality)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)
[![CodeQL](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/codeql.yml?label=CodeQL)](https://github.com/rezusnet/hassio-addons/actions/workflows/codeql.yml)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/rezusnet/hassio-addons/badge)](https://scorecard.dev/viewer/?uri=github.com/rezusnet/hassio-addons)
[![Last commit](https://img.shields.io/github/last-commit/rezusnet/hassio-addons?label=last%20update)](https://github.com/rezusnet/hassio-addons/commits/master)
[![Stars](https://img.shields.io/github/stars/rezusnet/hassio-addons?style=flat)](https://github.com/rezusnet/hassio-addons/stargazers)
[![Open issues](https://img.shields.io/github/issues/rezusnet/hassio-addons)](https://github.com/rezusnet/hassio-addons/issues)
[![License](https://img.shields.io/github/license/rezusnet/hassio-addons)](https://github.com/rezusnet/hassio-addons/blob/master/LICENSE)

## About

Home Assistant allows anyone to create add-on repositories to share their add-ons. This repository provides extra Home Assistant add-ons for your installation.

## Installation

[![Add repository on my Home Assistant][repository-badge]][repository-url]

Or manually: go to **Settings > Add-ons > Add-on Store > ... > Repositories** and add:

```
https://github.com/rezusnet/hassio-addons
```

## Add-ons provided by this repository

| Addon | Version | Arch | Ingress | Updated |
|-------|---------|------|---------|---------|
| [![OpenCode][opencode-badge]](opencode/) | ![OpenCode Version](https://img.shields.io/badge/dynamic/yaml?label=&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml) | ![OpenCode Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml) | ![OpenCode Port](https://img.shields.io/badge/dynamic/yaml?color=blue&label=port&query=%24.ports&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml) | ![OpenCode Updated](https://img.shields.io/badge/dynamic/json?label=&query=%24.last_update&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fupdater.json) |
| [![Filebrowser][filebrowser-badge]](filebrowser/) | ![Filebrowser Version](https://img.shields.io/badge/dynamic/yaml?label=&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fconfig.yaml) | ![Filebrowser Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fconfig.yaml) | ![Filebrowser Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fconfig.yaml) | ![Filebrowser Updated](https://img.shields.io/badge/dynamic/json?label=&query=%24.last_update&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Ffilebrowser%2Fupdater.json) |
| [![Addons updater][addons_updater-badge]](addons_updater/) | ![Addons updater Version](https://img.shields.io/badge/dynamic/yaml?label=&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Faddons_updater%2Fconfig.yaml) | ![Addons updater Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Faddons_updater%2Fconfig.yaml) | — | — |

## Using an Addon

1. Install the addon from the Add-on Store
2. Configure options (check the addon's README for details)
3. Click **Start**
4. Access via the sidebar (Ingress) or at `<your-ip>:<port>`

## Developing Addons

See [CONTRIBUTING.md](CONTRIBUTING.md) for full development guidelines.

### CI/CD Pipeline

- **Push to master** with `config.*` changes triggers the builder
- **PRs** are validated: linted + test-built (no push)
- **Super-Linter** runs shellcheck, hadolint, markdownlint, shfmt, gitleaks, jscpd on changed files
- **CodeQL** scans GitHub Actions workflows for security issues
- **OpenSSF Scorecard** evaluates repo security posture
- **Weekly** auto-updater checks upstream for new versions
- **Weekly** lint autofix creates PRs with formatting fixes
- **`[nobuild]`** in commit messages skips CI builds

## Support

Open an issue on [GitHub Issues](https://github.com/rezusnet/hassio-addons/issues).

[repository-badge]: https://img.shields.io/badge/Add%20repository%20to%20my-Home%20Assistant-41BDF5?logo=home-assistant&style=for-the-badge
[repository-url]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Frezusnet%2Fhassio-addons
[opencode-badge]: https://img.shields.io/badge/OpenCode-robot?logo=robot&style=flat
[filebrowser-badge]: https://img.shields.io/badge/Filebrowser-folder?logo=folder&style=flat
[addons_updater-badge]: https://img.shields.io/badge/Addons_updater-update?logo=refresh&style=flat
