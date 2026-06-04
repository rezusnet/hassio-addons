ARG BUILD_VERSION

FROM ghcr.io/rezuscloud/rezuscloud:v0.0.1-35 AS rezuscloud

FROM ghcr.io/home-assistant/base:latest

ARG BUILD_ARCH
ARG BUILD_VERSION

USER root

RUN apk add --no-cache \
        bash \
        ca-certificates \
        curl \
        su-exec

COPY --from=rezuscloud /rezuscloud /usr/local/bin/rezuscloud
RUN chmod +x /usr/local/bin/rezuscloud

COPY rootfs/ /
RUN find . -type f \( -name "*.sh" -o -name "run" -o -name "finish" \) -print -exec chmod +x {} \;

COPY bashio-standalone.sh /usr/local/lib/bashio-standalone.sh
RUN chmod 0755 /usr/local/lib/bashio-standalone.sh

VOLUME ["/data"]
WORKDIR /

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
ENV BUILD_VERSION="${BUILD_VERSION}"
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="rezusnet (https://github.com/rezusnet)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/rezusnet" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version="${BUILD_VERSION}"

HEALTHCHECK \
    --interval=30s \
    --retries=5 \
    --start-period=30s \
    --timeout=10s \
    CMD curl -sf "http://127.0.0.1:3000/healthz" || exit 1
