ARG BUILD_FROM
ARG BUILD_ARCH
ARG BUILD_VERSION
FROM ${BUILD_FROM}

ENV \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_BEHAVIOUR_IF_STAGE2_THROWS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0

# Apply Home Assistant LSIO patch
COPY ha_lsio.sh /
RUN bash /ha_lsio.sh && rm /ha_lsio.sh

# Patch service run script to use LOCATION variable
RUN sed -i 's|/config|${LOCATION}|g' /etc/s6-overlay/s6-rc.d/svc-thelounge/run

COPY rootfs /

# Install apps
RUN \
    chmod +x /etc/cont-init.d/* && \
    chmod +x /etc/service/*/run && \
    /ha_automodules.sh && \
    /ha_autoapps.sh

# Copy entrypoint
ENV S6_STAGE2_HOOK=/etc/cont-init.d/99-hass-entrypoint.sh
COPY ha_entrypoint.sh /etc/cont-init.d/99-hass-entrypoint.sh
COPY bashio-standalone.sh /usr/bin/bashio

# OCI Labels
LABEL \
    io.hass.name="TheLounge" \
    io.hass.description="TheLounge - IRC web client for group chat" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.arch="${BUILD_ARCH}"

HEALTHCHECK \
    --interval=30s \
    --timeout=5s \
    --start-period=10s \
    --retries=3 \
    CMD curl -f http://localhost:9000/ || exit 1

ENV HEALTH_PORT=9000
ENV HEALTH_URL=/
