ARG BUILD_FROM
FROM ${BUILD_FROM} as builder

ARG BUILD_VERSION

WORKDIR /build

# Install dependencies
RUN apk add --no-cache git ca-certificates tzdata

# Clone and build hishtory
RUN git clone --depth 1 --branch v${BUILD_VERSION} https://github.com/ddpom/hishtory.git . && \
    go build -o hishtory-server ./server && \
    chmod +x hishtory-server

# Final stage
FROM alpine:latest

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_VERSION

RUN apk add --no-cache ca-certificates tzdata bash

# Create app directory
RUN mkdir -p /app /share/hisshtory

# Copy binary from builder
COPY --from=builder /build/hishtory-server /app/

# Copy rootfs
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

# Labels
LABEL \
    io.hass.name="Hishtory Server" \
    io.hass.description="Private AI-powered shell history manager" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.title="Hishtory Server" \
    org.opencontainers.image.description="Private AI-powered shell history manager" \
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
