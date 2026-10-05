ARG BUILD_FROM
ARG BUILD_VERSION

# The upstream image ships a single static Go binary (/app/authelia) plus
# its healthcheck script on a stripped minimal base (dpkg but no apt, no
# bash, no user management). We rebuild the add-on on real Ubuntu and copy
# the upstream /app tree over — everything Authelia needs is in /app.
FROM ${BUILD_FROM} AS upstream

FROM ubuntu:26.04

ARG BUILD_ARCH
ARG BUILD_VERSION

USER root

ENV LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

# bash for ha_entrypoint/cont-init, jq for the bashio shim, setpriv
# (util-linux) to drop privileges (numeric uid 1000 — the base image
# already occupies gid 1000 with its own user, so no account is created).
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        jq \
        ca-certificates \
        util-linux && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=upstream /app /app
ENV PATH="/app:${PATH}"

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
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.url="https://www.authelia.com" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/authelia/DOCS.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version="${BUILD_VERSION}"

# Upstream ships /app/healthcheck.sh (wgets /api/health); it is a no-op
# unless X_AUTHELIA_HEALTHCHECK is set. Web port is fixed at 9091.
ENV X_AUTHELIA_HEALTHCHECK=true
HEALTHCHECK --interval=30s --retries=5 --start-period=30s --timeout=5s \
    CMD /app/healthcheck.sh || exit 1
