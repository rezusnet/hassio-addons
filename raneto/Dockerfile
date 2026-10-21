ARG BUILD_FROM
ARG BUILD_VERSION
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_VERSION

USER root

ENV S6_CMD_WAIT_FOR_SERVICES=0 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    S6_SERVICES_GRACETIME=0

COPY ha_lsio.sh /ha_lsio.sh
ARG CONFIGLOCATION="/config"
RUN chmod 744 /ha_lsio.sh && if grep -qr "lsio" /etc; then /ha_lsio.sh "$CONFIGLOCATION"; fi && rm /ha_lsio.sh

RUN \
    sed -i "s|contenv bash|contenv bashio|g" /etc/s6-overlay/s6-rc.d/svc-raneto/run && \
    sed -i "1a if [[\" \$LOCATION\" = \"null\" || -z \"\$LOCATION\" ]]; then LOCATION=/config; fi" /etc/s6-overlay/s6-rc.d/svc-raneto/run && \
    sed -i "1a LOCATION=\$(bashio::config 'data_location')" /etc/s6-overlay/s6-rc.d/svc-raneto/run && \
    sed -i "s|/config|\$LOCATION|g" /etc/s6-overlay/s6-rc.d/svc-raneto/run && \
    sed -i "1a set +u" /etc/s6-overlay/s6-rc.d/svc-raneto/run

COPY rootfs/ /
RUN find . -type f \( -name "*.sh" -o -name "run" -o -name "finish" \) -print -exec chmod +x {} \;

ARG MODULES="00-banner.sh 01-custom_script.sh 00-local_mounts.sh 00-smb_mounts.sh"
COPY ha_automodules.sh /ha_automodules.sh
RUN chmod 744 /ha_automodules.sh && /ha_automodules.sh "$MODULES" && rm /ha_automodules.sh

ENV PACKAGES=""
COPY ha_autoapps.sh /ha_autoapps.sh
RUN chmod 744 /ha_autoapps.sh && /ha_autoapps.sh "$PACKAGES" && rm /ha_autoapps.sh

ENV S6_STAGE2_HOOK=/ha_entrypoint.sh
COPY ha_entrypoint.sh /ha_entrypoint.sh
RUN chmod 777 /ha_entrypoint.sh

COPY bashio-standalone.sh /usr/local/lib/bashio-standalone.sh
RUN chmod 0755 /usr/local/lib/bashio-standalone.sh

LABEL io.hass.version="${BUILD_VERSION}" \
      io.hass.type="addon" \
      io.hass.arch="${BUILD_ARCH}" \
      maintainer="rezusnet" \
      org.opencontainers.image.title="Raneto" \
      org.opencontainers.image.description="Raneto - Knowledge base built for markdown" \
      org.opencontainers.image.url="https://github.com/rezusnet/hassio-addons/tree/master/raneto" \
      org.opencontainers.image.source="https://github.com/rezusnet/hassio-addons" \
      org.opencontainers.image.documentation="https://github.com/rezusnet/hassio-addons/blob/master/raneto/DOCS.md"

ENV HEALTH_PORT=3000 \
    HEALTH_URL="http://127.0.0.1:3000/admin/login"

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -s -k "${HEALTH_URL}" || exit 1
