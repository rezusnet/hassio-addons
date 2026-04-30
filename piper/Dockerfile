ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_VERSION
ARG BUILD_DATE

USER root

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    libsndfile1 \
    espeak-ng \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir \
    piper-tts \
    flask \
    numpy \
    onnxruntime

# Create app directories
RUN mkdir -p /app /share/piper/models /var/log/piper

# Copy rootfs
COPY rootfs/ /

# Make scripts executable
RUN find / -type f \( -name "*.sh" -o -name "run" -o -name "finish" \) -print -exec chmod +x {} \; 2>/dev/null || true

# Create entrypoint
RUN mkdir -p /usr/local/lib && cat > /usr/local/lib/bashio-standalone.sh << 'EOF'
#!/bin/bash
bashio::config() { echo "$1"; }
bashio::config.has_value() { return 0; }
bashio::log.info() { echo "[INFO] $@"; }
bashio::log.error() { echo "[ERROR] $@" >&2; }
export -f bashio::config bashio::config.has_value bashio::log.info bashio::log.error
EOF
chmod 0755 /usr/local/lib/bashio-standalone.sh

# Labels
LABEL \
    io.hass.name="Piper" \
    io.hass.description="Fast, offline neural text-to-speech" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.title="Piper" \
    org.opencontainers.image.description="Fast, offline neural text-to-speech" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/rezusnet" \
    org.opencontainers.image.source="https://github.com/rezusnet/hassio-addons" \
    org.opencontainers.image.documentation="https://github.com/rezusnet/hassio-addons/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.version="${BUILD_VERSION}"

# Health check
ENV HEALTH_PORT="8000" \
    HEALTH_URL="/api/status"
HEALTHCHECK \
    --interval=30s \
    --retries=5 \
    --start-period=60s \
    --timeout=25s \
    CMD curl -A "HealthCheck: Docker/1.0" -s -f "http://127.0.0.1:${HEALTH_PORT}${HEALTH_URL}" &>/dev/null || exit 1

# Set working directory
WORKDIR /app

# Default entrypoint
CMD ["/etc/cont-init.d/99-run.sh"]
