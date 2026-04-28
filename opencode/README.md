# Home Assistant add-on: OpenCode

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/opencode)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/opencode)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Fopencode%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/opencode)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)

![OpenCode banner](banner.svg)

## About

[OpenCode](https://github.com/anomalyco/opencode) is an open-source AI coding agent with a browser-based interface. It supports multiple LLM providers (OpenAI, Anthropic, Google, Ollama, and more) and provides a full-featured code editor with AI-powered code generation, analysis, refactoring, and debugging.

This add-on packages the official OpenCode release binaries from [anomalyco/opencode](https://github.com/anomalyco/opencode) on top of a minimal Debian base image and integrates them with Home Assistant.

**Key features:**

- Browser-based AI coding agent with support for multiple LLM providers
- Git integration to clone and update private or public repositories at startup
- Dev profiles and custom package installation for Python, Node.js, or full toolchains
- Configurable workspace with access to Home Assistant directories
- SSH key or PAT authentication for private repositories
- Optional password protection for the web interface
- Home Assistant ingress landing page that opens the full UI in a new tab

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the "OpenCode" add-on from the add-on store.
3. Configure the add-on options (see Documentation tab).
4. Start the add-on.
5. Click "Open Web UI" in the sidebar, then click the button to open OpenCode, or go directly to `http://<your-ha-ip>:8230`.

> **Note:** OpenCode does not support running inside an iframe (which HA ingress uses). The sidebar shows a landing page that auto-opens the full OpenCode UI in a new tab on port 8230.

For full configuration details, git authentication setup, and troubleshooting, see the **Documentation** tab.
