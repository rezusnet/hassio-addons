# Piper Text-to-Speech Add-on Documentation

## Getting Started

Piper TTS is now running as a backend service. It provides a REST API for text-to-speech synthesis. The service automatically downloads default TTS models on first startup.

### Initial Setup

1. After starting the add-on, wait 60-90 seconds for models to download
2. Models are downloaded automatically from Hugging Face
3. Check the add-on logs for initialization progress
4. The TTS API will be available at `http://<your-host>:8000`

## Configuration

### Options

| Option | Type | Required | Default | Description |
|--------|------|----------|---------|-------------|
| `PUID` | int | No | 0 | User ID for file permissions |
| `PGID` | int | No | 0 | Group ID for file permissions |
| `TZ` | string | No | UTC | Timezone |
| `data_location` | string | No | `/share/piper` | Directory for temporary audio files |
| `models_location` | string | No | `/share/piper/models` | Directory to store TTS models |
| `server_port` | int | No | 8000 | Port for the TTS API server |

## API Reference

### Status Endpoint

```bash
GET /api/status
```

Returns service status:

```json
{
  "status": "ok",
  "service": "piper-tts"
}
```

### Synthesize Endpoint

```bash
POST /api/synthesize
Content-Type: application/json

{
  "text": "Hello from Piper",
  "model": "en_US-amy-medium"
}
```

Returns WAV audio file.

### List Models

```bash
GET /api/models
```

Returns available models:

```json
{
  "models": ["en_US-amy-medium", "en_US-john-medium"]
}
```

## Supported Models

Default model: `en_US-amy-medium` (English, female voice)

Available languages and voices:
- English (US): amy, john, michael, john, lessac
- English (GB): alba, fiona, george
- German: claudette, friedrich
- Spanish: mario, pablo
- French: . claude, daphne, denise

Models are automatically downloaded from Hugging Face on first use.

## Home Assistant Integration

### Add Piper as Custom TTS

1. In Home Assistant, go to **Settings > Devices & Services > Text-to-Speech**
2. Create a custom service or use an automation:

```yaml
service: tts.speak
data:
  message: "Welcome home"
  entity_id: media_player.your_speaker
```

### Bash Integration

```bash
curl -X POST http://localhost:8000/api/synthesize \
  -H "Content-Type: application/json" \
  -d '{"text":"Hello","model":"en_US-amy-medium"}' \
  -o output.wav
```

## File Storage

- **Models**: Stored in `/share/piper/models` (downloaded automatically)
- **Audio Output**: Temporary files in `/share/piper`
- **Logs**: Check add-on logs for troubleshooting

## Troubleshooting

### Models Not Downloaded

1. Check internet connectivity
2. Verify sufficient disk space (models are ~100-200MB each)
3. Check add-on logs for download errors
4. Manually download models and place in `/share/piper/models`

### TTS Server Not Starting

1. Check that port 8000 is available
2. Verify add-on logs for Python errors
3. Restart the add-on

### Quality Issues

- Use full models (not lite) for better quality
- Different voices have different characteristics
- Experiment with different models to find your preference

## Upstream Documentation

For detailed Piper documentation and features:
- **GitHub**: https://github.com/rhasspy/piper
- **Models**: https://huggingface.co/rhasspy/piper-voices
- **Voice Samples**: https://github.com/rhasspy/piper#voices
