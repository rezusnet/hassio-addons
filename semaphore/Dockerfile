ARG BUILD_FROM
ARG BUILD_VERSION

# The upstream image is a complete runner (ansible venv, terraform,
# opentofu, terragrunt, ssh stack, tini) running as unprivileged user
# 1001. We keep it whole and only add the HAOS add-on init layer on top.
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_VERSION

USER root

# su-exec for privilege drop from the cont-init supervisor to user 1001.
RUN apk add --no-cache \
        su-exec

COPY rootfs/ /
RUN find . -type f \( -name "*.sh" -o -name "run" -o -name "finish" \) -print -exec chmod +x {} \;

ARG MODULES="00-banner.sh 01-custom_script.sh"

COPY ha_automodules.sh /ha_automodules.sh
RUN chmod 744 /ha_automodules.sh && /ha_automodules.sh "$MODULES" && rm /ha_automodules.sh

ENV PACKAGES=""

COPY ha_autoapps.sh /ha_autoapps.sh
RUN chmod 744 /ha_autoapps.sh && /ha_autoapps.sh "$PACKAGES" && rm /ha_autoapps.sh

# ha_autoapps installs the upstream bashio, which is unpinned and now
# waits on the Supervisor API at startup. This add-on runs fully
# standalone — pin bashio to the repo's standalone shim instead.
RUN rm -rf /usr/lib/bashio /usr/bin/bashio

COPY ha_entrypoint.sh /ha_entrypoint.sh
RUN chmod 777 /ha_entrypoint.sh

COPY bashio-standalone.sh /usr/local/lib/bashio-standalone.sh
RUN chmod 0755 /usr/local/lib/bashio-standalone.sh && \
    ln -s /usr/local/lib/bashio-standalone.sh /usr/bin/bashio

VOLUME ["/data"]
WORKDIR /

ENTRYPOINT ["/usr/bin/env"]
CMD ["/ha_entrypoint.sh"]

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
    org.opencontainers.image.url="https://semaphoreui.com" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/semaphore/DOCS.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version="${BUILD_VERSION}"

# /api/ping is the upstream health endpoint (unauthenticated). The listen
# port is configurable, so the healthcheck helper reads it from config.json.
HEALTHCHECK --interval=30s --retries=5 --start-period=30s --timeout=5s \
    CMD /usr/local/bin/semaphore-healthcheck || exit 1
