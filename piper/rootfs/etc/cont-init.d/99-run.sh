#!/usr/bin/env bash
set -e

echo "[INFO] Starting Piper add-on initialization"

# Parse config (simple implementation)
DATA_LOCATION="/share/piper"
MODELS_LOCATION="/share/piper/models"
SERVER_PORT="8000"

if [ -n "${BASHIO_CONFIG_DATA_LOCATION}" ]; then
    DATA_LOCATION="${BASHIO_CONFIG_DATA_LOCATION}"
fi

if [ -n "${BASHIO_CONFIG_MODELS_LOCATION}" ]; then
    MODELS_LOCATION="${BASHIO_CONFIG_MODELS_LOCATION}"
fi

if [ -n "${BASHIO_CONFIG_SERVER_PORT}" ]; then
    SERVER_PORT="${BASHIO_CONFIG_SERVER_PORT}"
fi

# Create directories
mkdir -p "${DATA_LOCATION}" "${MODELS_LOCATION}" /var/log/piper

echo "[INFO] Data location: ${DATA_LOCATION}"
echo "[INFO] Models location: ${MODELS_LOCATION}"
echo "[INFO] Server port: ${SERVER_PORT}"

# Download default model if not present
if [ ! -f "${MODELS_LOCATION}/en_US-amy-medium.onnx" ]; then
    echo "[INFO] Downloading default TTS model..."
    mkdir -p "${MODELS_LOCATION}"
    cd "${MODELS_LOCATION}"
    # Download a small English model
    curl -sL "https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/amy/medium/en_US-amy-medium.onnx" \
        -o en_US-amy-medium.onnx || echo "[WARNING] Could not download model, continuing..."
    curl -sL "https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/amy/medium/en_US-amy-medium.onnx.json" \
        -o en_US-amy-medium.onnx.json || echo "[WARNING] Could not download model config, continuing..."
fi

# Start Flask TTS server
echo "[INFO] Starting Piper TTS server on port ${SERVER_PORT}"

cat > /tmp/piper_server.py << 'PYSCRIPT'
#!/usr/bin/env python3
from flask import Flask, request, jsonify, send_file
import subprocess
import os
import sys
from pathlib import Path

app = Flask(__name__)

DATA_LOCATION = os.environ.get('DATA_LOCATION', '/share/piper')
MODELS_LOCATION = os.environ.get('MODELS_LOCATION', '/share/piper/models')
SERVER_PORT = int(os.environ.get('SERVER_PORT', 8000))

@app.route('/api/status', methods=['GET'])
def status():
    """Health check endpoint"""
    return jsonify({'status': 'ok', 'service': 'piper-tts'}), 200

@app.route('/api/synthesize', methods=['POST'])
def synthesize():
    """Synthesize text to speech"""
    try:
        data = request.json
        text = data.get('text', '')
        model = data.get('model', 'en_US-amy-medium')
        
        if not text:
            return jsonify({'error': 'No text provided'}), 400
        
        # Use piper command-line tool
        model_path = os.path.join(MODELS_LOCATION, f'{model}.onnx')
        output_path = os.path.join(DATA_LOCATION, 'output.wav')
        
        # Run piper
        cmd = f'echo "{text}" | piper --model "{model_path}" --output_file "{output_path}"'
        subprocess.run(cmd, shell=True, check=False)
        
        if os.path.exists(output_path):
            return send_file(output_path, mimetype='audio/wav'), 200
        else:
            return jsonify({'error': 'Synthesis failed'}), 500
            
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/models', methods=['GET'])
def list_models():
    """List available models"""
    models = []
    if os.path.exists(MODELS_LOCATION):
        for f in Path(MODELS_LOCATION).glob('*.onnx'):
            models.append(f.stem)
    return jsonify({'models': models}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=SERVER_PORT, debug=False)
PYSCRIPT

chmod +x /tmp/piper_server.py
export DATA_LOCATION
export MODELS_LOCATION
export SERVER_PORT

python3 /tmp/piper_server.py
