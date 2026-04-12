## Open Request : [OpenCode: Add full ingress support (depends on upstream subpath support) (opened 2026-04-11)](https://github.com/rezusnet/hassio-addons/issues/6) by [@tibrezus](https://github.com/tibrezus)
# Home Assistant add-on: OpenCode

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/opencode)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/opencode)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[OpenCode](https://github.com/anomalyco/opencode) is an open-source AI coding agent with a browser-based interface. It supports multiple LLM providers (OpenAI, Anthropic, Google, Ollama, and more) and provides a full-featured code editor with AI-powered code generation, analysis, refactoring, and debugging.

This add-on runs OpenCode alongside Home Assistant with a sidebar entry, dev profiles, and git repository management.

**Key features:**

- Sidebar entry with one-click access to the full web UI
- Git integration — clone private or public repositories at startup
- Dev profiles — install language runtimes and tools on demand (Python, Node.js, full dev)
- Configurable workspace with full access to HA directories
- SSH key or PAT authentication for private repositories

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the "OpenCode" add-on from the add-on store.
3. Configure the add-on options (see below).
4. Start the add-on.
5. Click "Open Web UI" in the sidebar, then click the button to open OpenCode, or go directly to `http://<your-ha-ip>:8230`.

> **Note:** OpenCode does not support running inside an iframe (which HA ingress uses). The sidebar shows a landing page that auto-opens the full OpenCode UI in a new tab on port 8230.

## Configuration

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `workspace` | string | `/homeassistant` | The directory OpenCode uses as its working directory. |
| `server_password` | password | _(empty)_ | Optional password to protect the web interface. |
| `dev_profile` | list | `minimal` | Development tools to install at startup. |
| `repositories` | list | `[]` | Git repositories to clone at startup. |
| `git_ssh_key` | password | _(empty)_ | SSH private key for git authentication. |
| `git_token` | password | _(empty)_ | GitHub PAT for HTTPS git authentication. |
| `custom_packages` | string | _(empty)_ | Extra apt packages to install (space-separated). |
| `env_vars` | list | `[]` | Custom environment variables (e.g., API keys). |

### Dev profiles

| Profile | Installs |
|---------|----------|
| `minimal` | git (always included) |
| `python` | python3, pip, venv |
| `node` | nodejs, npm |
| `full` | python3, pip, venv, nodejs, npm, build-essential, libffi-dev, libssl-dev |

You can select multiple profiles if needed (they combine). Profile tools are installed at startup, so the first boot with a new profile will take extra time.

### Git authentication

#### SSH key (works with any git host)

1. Generate a key pair: `ssh-keygen -t ed25519 -C "opencode-addon"`
2. Add the **public key** as a deploy key on your GitHub/GitLab repository (with write access if you want to push)
3. Paste the **private key** contents into `git_ssh_key`
4. Use SSH URLs in your repositories: `git@github.com:user/repo.git`

#### GitHub PAT (HTTPS only)

1. Create a fine-grained PAT at [GitHub Settings > Tokens](https://github.com/settings/tokens) with `contents: read` (and `write` if needed)
2. Paste the token into `git_token`
3. Use HTTPS URLs in your repositories: `https://github.com/user/repo.git`

Public repositories need no authentication.

### Example configurations

#### Basic — edit HA config

```yaml
workspace: /homeassistant
dev_profile:
  - minimal
repositories: []
```

#### Develop addons with full tools

```yaml
workspace: /homeassistant/repos/hassio-addons
dev_profile:
  - full
git_ssh_key: |
  -----BEGIN OPENSSH PRIVATE KEY-----
  ...
  -----END OPENSSH PRIVATE KEY-----
repositories:
  - url: git@github.com:rezusnet/hassio-addons.git
    branch: master
    path: /homeassistant/repos/hassio-addons
```

#### Python project via GitHub PAT

```yaml
workspace: /homeassistant/repos/my-project
dev_profile:
  - python
git_token: "ghp_xxxxxxxxxxxxxxxxxxxx"
repositories:
  - url: https://github.com/user/my-private-project.git
    branch: main
    path: /homeassistant/repos/my-project
```

#### Multiple public repos with Node.js

```yaml
workspace: /homeassistant/repos/frontend
dev_profile:
  - node
repositories:
  - url: https://github.com/user/frontend-app.git
    path: /homeassistant/repos/frontend
  - url: https://github.com/user/shared-lib.git
    path: /homeassistant/repos/shared-lib
custom_packages: "imagemagick jq"
```

### Setting up LLM providers

You have two options to configure your LLM provider:

1. **Via the web UI**: Open OpenCode and navigate to `/connect` in the web interface.
2. **Via environment variables**: Add API keys in the `env_vars` option (e.g., `OPENAI_API_KEY`, `ANTHROPIC_API_KEY`). OpenCode will auto-detect available providers.

### Accessing files

The add-on maps the following Home Assistant directories with read/write access:

- `/homeassistant` — Home Assistant configuration
- `/addon_configs` — All add-on configurations
- `/addons` — Add-on data
- `/media` — Media files
- `/share` — Shared files
- `/backup` — Backups
- `/ssl` — SSL certificates

### Securing the web interface

Set `server_password` to a non-empty value to require password authentication. Recommended if your Home Assistant instance is exposed to the internet.

### Git defaults

The add-on configures git with sensible defaults at startup:
- `user.name`: OpenCode
- `user.email`: opencode@homeassistant
- `init.defaultBranch`: main

If your repositories require a different git identity, set `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL` via the `env_vars` option.
