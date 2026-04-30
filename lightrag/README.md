# Home Assistant add-on: LightRAG

[![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Flightrag%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/lightrag)
[![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Flightrag%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/lightrag)
[![Builder](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/onpush_builder.yaml?label=Builder)](https://github.com/rezusnet/hassio-addons/actions/workflows/onpush_builder.yaml)
[![Lint](https://img.shields.io/github/actions/workflow/status/rezusnet/hassio-addons/lint.yml?label=Lint)](https://github.com/rezusnet/hassio-addons/actions/workflows/lint.yml)
[![Ingress](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Frezusnet%2Fhassio-addons%2Fmaster%2Flightrag%2Fconfig.yaml)](https://github.com/rezusnet/hassio-addons/tree/master/lightrag)

![LightRAG banner](banner.svg)

## About

[LightRAG](https://github.com/HKUDS/LightRAG) is lightrag is a simple and fast retrieval-augmented generation system with a web ui for document indexing, knowledge graph exploration, and rag queries. requires an external llm provider (openai, ollama, azure, gemini, etc.)..

This add-on is based on the [linuxserver/docker-lightrag](https://github.com/linuxserver/docker-lightrag) Docker image.

**Key features:**

- Containerized application
- Easy configuration
- Home Assistant integration
- Multi-architecture support

## Installation

1. Add this repository to your Home Assistant instance:
   [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/rezusnet/hassio-addons)
2. Install the **LightRAG** add-on from the add-on store.
3. Configure options as needed (see **Documentation** tab).
4. Start the add-on.
5. Access via the **HA sidebar** (Ingress) or directly at `http://<your-ha-ip>:9621`.

For full configuration details and troubleshooting, see the **Documentation** tab.
