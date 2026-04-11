ARG BUILD_FROM
ARG BUILD_VERSION
FROM ${BUILD_FROM}

USER root

COPY rootfs/ /
RUN find . -type f \( -name "*.sh" -o -name "run" \) -print -exec chmod +x {} \;

RUN if ! command -v bash > /dev/null 2> /dev/null; then (apt-get update && apt-get install -yqq --no-install-recommends bash || apk add --no-cache bash) > /dev/null; fi
RUN if ! command -v curl > /dev/null 2> /dev/null; then (apt-get update && apt-get install -yqq --no-install-recommends curl || apk add --no-cache curl) > /dev/null; fi

ARG PACKAGES="git jq lastversion"
RUN pip install lastversion 2>/dev/null || true
RUN apk add --no-cache git jq 2>/dev/null || (apt-get update && apt-get install -yqq git jq) 2>/dev/null || true

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="rezusnet" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}"
