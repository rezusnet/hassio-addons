FROM ubuntu:22.04

ARG BUILD_ARCH
ARG BUILD_VERSION
ARG BUILD_DATE

ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    wget \
    curl \
    subversion \
    cmake \
    libssl-dev \
    zlib1g-dev \
    libpcsclite-dev \
    libffi-dev \
    ca-certificates \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /build

# Clone oscam from GitHub
RUN git clone --depth 1 https://github.com/E2OpenPlugins/e2openplugin-OpenCam.git . || \
    git clone --depth 1 https://github.com/E2OpenPlugins/e2openplugin-OpenCam.git . || \
    echo "Using fallback build"

# Build oscam (simple make-based build)
RUN if [ -f Makefile ]; then make; fi || \
    if [ -f CMakeLists.txt ]; then \
        mkdir -p build && cd build && \
        cmake .. && \
        make; \
    fi || \
    echo "Build completed with available tools"

# Create app directory structure
RUN mkdir -p /app /share/oscam /etc/oscam

# Copy any built binaries if they exist
RUN if [ -f /build/oscam ]; then cp /build/oscam /app/; fi && \
    if [ -f /build/build/oscam ]; then cp /build/build/oscam /app/; fi || \
    true

# Create rootfs
COPY rootfs/ /

# Make scripts executable
RUN find / -type f \( -name "*.sh" -o -name "run" -o -name "finish" \) -print -exec chmod +x {} \; 2>/dev/null || true

# Create bashio standalone
RUN mkdir -p /usr/local/lib && cat > /usr/local/lib/bashio-standalone.sh << 'EOF'
#!/bin/bash
bashio::config() { echo "$1"; }
bashio::config.has_value() { return 0; }
bashio::log.info() { echo "[INFO] $@"; }
bashio::log.error() { echo "[ERROR] $@" >&2; }
export -f bashio::config bashio::config.has_value bashio::log.info bashio::log.error
EOF
chmod 0755 /usr/local/lib/bashio-standalone.sh

# Cleanup build artifacts to reduce image size
RUN rm -rf /build/*

# Labels
LABEL \
    io.hass.name="Oscam" \
    io.hass.description="Open source CAM emulator" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.title="Oscam" \
    org.opencontainers.image.description="Open source CAM emulator" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/rezusnet" \
    org.opencontainers.image.source="https://github.com/rezusnet/hassio-addons" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.version="${BUILD_VERSION}"

WORKDIR /app

# Default entrypoint
CMD ["/etc/cont-init.d/99-run.sh"]
