# Home Assistant add-on: OpenCode

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/opencode)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/opencode)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

## About

[OpenCode](https://github.com/anomalyco/opencode) is an open-source AI coding agent with a browser-based interface. It supports multiple LLM providers (OpenAI, Anthropic, Google, Ollama, and more) and provides a full-featured code editor with AI-powered code generation, analysis, refactoring, and debugging.

This add-on runs OpenCode alongside Home Assistant, exposing it on a dedicated port (default `8230`) for full compatibility with its web UI.

**Key features:**

- Browser-based AI coding agent accessible on port 8230
- Support for multiple LLM providers (configure via the web UI `/connect` flow)
- Full read/write access to your Home Assistant configuration, add-ons, and media
- Configurable workspace directory
- Real-time streaming responses

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the "OpenCode" add-on from the add-on store.
3. Configure the add-on options (see below).
4. Start the add-on.
5. Access the OpenCode web UI at `http://<your-ha-ip>:8230`.

## Configuration

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `workspace` | string | `/homeassistant` | The directory OpenCode will use as its working directory. |
| `server_password` | password | _(empty)_ | Optional password to protect the OpenCode web interface. If set, users must enter it to connect. |
| `env_vars` | list | `[]` | Custom environment variables passed to the OpenCode process (e.g., API keys). |

### Example configuration

```yaml
workspace: /homeassistant
server_password: ""
env_vars:
  - name: OPENAI_API_KEY
    value: sk-your-key-here
  - name: ANTHROPIC_API_KEY
    value: sk-ant-your-key-here
```

### Setting up LLM providers

You have two options to configure your LLM provider:

1. **Via the web UI**: Open OpenCode and navigate to `/connect` in the web interface. This provides a guided setup flow for connecting your preferred LLM provider.

2. **Via environment variables**: Add API keys in the `env_vars` option (e.g., `OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `GOOGLE_API_KEY`). OpenCode will auto-detect available providers.

### Accessing files

The add-on maps the following Home Assistant directories with read/write access:

- `/homeassistant` — Home Assistant configuration
- `/addon_configs` — All add-on configurations
- `/addons` — Add-on data
- `/media` — Media files
- `/share` — Shared files
- `/backup` — Backups
- `/ssl` — SSL certificates

The default workspace is `/homeassistant`. You can change this to any mapped directory.

### Securing the web interface

Set `server_password` to a non-empty value to require password authentication before accessing the OpenCode web UI. This is recommended if your Home Assistant instance is exposed to the internet.
