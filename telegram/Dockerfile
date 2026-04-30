ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_VERSION
ARG BUILD_DATE

USER root

# Create directories
RUN mkdir -p /share/telegram /var/lib/telegram

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
    io.hass.name="Telegram Bot API" \
    io.hass.description="Telegram Bot API Server" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.title="Telegram Bot API" \
    org.opencontainers.image.description="Telegram Bot API Server" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/rezusnet" \
    org.opencontainers.image.source="https://github.com/rezusnet/hassio-addons" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.version="${BUILD_VERSION}"

# Default entrypoint
CMD ["/etc/cont-init.d/99-run.sh"]
