# Piper Text-to-Speech Add-on

[![Latest Release](https://img.shields.io/github/v/release/rezusnet/hassio-addons?label=Latest%20Release)](https://github.com/rezusnet/hassio-addons/releases)
[![Project Stage](https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg)](https://github.com/rezusnet/hassio-addons#readme)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Open your Home Assistant instance and show the add-on store page of the add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=piper)

![Piper Banner](banner.svg)

## About

Piper is a fast, offline neural text-to-speech system. It converts text into natural-sounding speech with excellent quality and very low latency. Piper runs locally on your hardware, ensuring complete privacy for your speech synthesis needs.

## Key Features

- 🎙️ **Neural TTS Engine**: High-quality speech synthesis
- ⚡ **Fast & Lightweight**: Low latency, minimal CPU usage
- 🔒 **Privacy-First**: Runs completely offline
- 🌍 **Multi-Language**: Support for multiple languages
- 🗣️ **Multiple Voices**: Various voice options per language
- 🔊 **High Quality**: Natural-sounding speech output
- 🚀 **Easy Integration**: REST API for speech synthesis

## Installation

1. Add the add-on repository (if not already added)
2. Install the Piper add-on from the add-on store
3. Configure the add-on (see DOCS.md for details)
4. Start the add-on
5. Begin synthesizing text to speech via the API

## Quick Access

- **TTS API**: Available at `http://<your-host>:8000`
- **Status Endpoint**: `http://<your-host>:8000/api/status`
- **Synthesis**: POST to `http://<your-host>:8000/api/synthesize`

## Integration with Home Assistant

Use Home Assistant's `tts.speak` service to integrate Piper with your automations:

```yaml
service: tts.speak
data:
  message: "Hello from Piper"
  entity_id: media_player.your_device
```

## Support & Documentation

For detailed configuration, API usage, and troubleshooting, see [DOCS.md](DOCS.md).

For upstream documentation and source code, visit:
- **Website**: https://github.com/rhasspy/piper
- **Models**: https://huggingface.co/rhasspy/piper-voices
- **Documentation**: https://github.com/rhasspy/piper/blob/master/README.md
- **GitHub**: https://github.com/rhasspy/piper
