## 2023.11.14-2 (2026-05-01)
- Update to upstream 2023.11.14-2

# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-05-01

### Added
- Initial Home Assistant add-on release
- Fast neural text-to-speech synthesis
- Multiple language and voice support
- REST API for speech synthesis
- Automatic model downloading
- Low-latency offline TTS engine
- Health checks for container monitoring
- Flask-based HTTP server

### Features
- `GET /api/status`: Health check endpoint
- `POST /api/synthesize`: Text to speech synthesis
- `GET /api/models`: List available models
- Automatic model management from Hugging Face

### Documentation
- Added comprehensive README with features
- Added detailed API documentation in DOCS.md
- Added AppArmor security profile
