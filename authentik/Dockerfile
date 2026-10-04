ARG BUILD_FROM
ARG BUILD_VERSION

# The upstream image bundles the full authentik runtime (Go server/worker
# supervisor, python venv, geoip, fonts) as user 1000 and expects PostgreSQL
# reachable over TCP. We add the HAOS add-on init layer plus a local
# PostgreSQL 17 (authentik 2026.x needs no Redis — its task queue is
# dramatiq with a PostgreSQL-backed broker, per the image's own reference
# compose).
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_VERSION

USER root

ENV LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

# PostgreSQL 17 (Debian trixie). No default cluster — initdb runs per
# instance into /data on first boot.
RUN mkdir -p /etc/postgresql-common && \
    echo 'CREATE_MAIN_CLUSTER=false' > /etc/postgresql-common/createcluster.conf && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql \
        postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
    org.opencontainers.image.url="https://goauthentik.io" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/authentik/DOCS.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version="${BUILD_VERSION}"

# Upstream readiness endpoint (unauthenticated, served once the web tier
# is live). The web port is fixed at 9000 (supervisor maps the host side).
HEALTHCHECK --interval=30s --retries=5 --start-period=60s --timeout=5s \
    CMD curl -sf -o /dev/null http://127.0.0.1:9000/-/health/ready/ || exit 1
