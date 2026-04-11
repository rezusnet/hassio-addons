ARG BUILD_FROM
ARG BUILD_VERSION
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_VERSION

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

RUN if [ "$BUILD_ARCH" = "aarch64" ]; then \
        OPENCODE_ARCH="arm64"; \
    elif [ "$BUILD_ARCH" = "amd64" ]; then \
        OPENCODE_ARCH="x64"; \
    else \
        echo "Unsupported architecture: $BUILD_ARCH" && exit 1; \
    fi && \
    OPENCODE_ARCHIVE="opencode-linux-${OPENCODE_ARCH}.tar.gz" && \
    echo "Downloading opencode v${BUILD_VERSION} for ${OPENCODE_ARCH}" && \
    curl -fsSL -o "/tmp/${OPENCODE_ARCHIVE}" \
        "https://github.com/anomalyco/opencode/releases/download/v${BUILD_VERSION}/${OPENCODE_ARCHIVE}" && \
    tar -xzf "/tmp/${OPENCODE_ARCHIVE}" -C /tmp/ && \
    mv /tmp/opencode /usr/local/bin/opencode && \
    chmod 755 /usr/local/bin/opencode && \
    rm -rf /tmp/${OPENCODE_ARCHIVE} && \
    ls -la /usr/local/bin/opencode && \
    file /usr/local/bin/opencode || true

COPY rootfs/ /
RUN find . -type f \( -name "*.sh" -o -name "run" -o -name "finish" \) -print -exec chmod +x {} \;

ARG MODULES="00-banner.sh 01-custom_script.sh"

COPY ha_automodules.sh /ha_automodules.sh
RUN chmod 744 /ha_automodules.sh && /ha_automodules.sh "$MODULES" && rm /ha_automodules.sh

ENV PACKAGES=""

COPY ha_autoapps.sh /ha_autoapps.sh
RUN chmod 744 /ha_autoapps.sh && /ha_autoapps.sh "$PACKAGES" && rm /ha_autoapps.sh

COPY ha_entrypoint.sh /ha_entrypoint.sh
RUN chmod 777 /ha_entrypoint.sh

COPY bashio-standalone.sh /usr/local/lib/bashio-standalone.sh
RUN chmod 0755 /usr/local/lib/bashio-standalone.sh

VOLUME [ "/data" ]
WORKDIR /

ENTRYPOINT [ "/usr/bin/env" ]
CMD [ "/ha_entrypoint.sh" ]

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
    org.opencontainers.image.version=${BUILD_VERSION}

ENV HEALTH_PORT="8080" \
    HEALTH_URL=""
HEALTHCHECK \
    --interval=5s \
    --retries=5 \
    --start-period=30s \
    --timeout=25s \
    CMD curl -A "HealthCheck: Docker/1.0" -s -f "http://127.0.0.1:${HEALTH_PORT}${HEALTH_URL}" &>/dev/null || exit 1
