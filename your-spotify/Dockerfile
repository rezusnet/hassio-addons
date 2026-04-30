ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_VERSION

ENV S6_STAGE2_HOOK=/etc/cont-init.d/ha_entrypoint.sh

COPY rootfs /

RUN chmod +x /etc/s6-overlay/s6-rc.d/*/run /etc/s6-overlay/s6-rc.d/*/init /etc/s6-overlay/s6-rc.d/*/finish /etc/cont-init.d/* 2>/dev/null || true

RUN curl -s -o /tmp/ha_lsio.sh https://raw.githubusercontent.com/rezusnet/hassio-addons/master/ha_lsio.sh && \
    bash /tmp/ha_lsio.sh "svc-your_spotify" && \
    rm -f /tmp/ha_lsio.sh

RUN sed -i 's|/config|${LOCATION}|g' /etc/services.d/svc-your_spotify/run

RUN bash /etc/cont-init.d/ha_automodules.sh && \
    bash /etc/cont-init.d/ha_autoapps.sh

COPY ha_entrypoint.sh /etc/cont-init.d/ha_entrypoint.sh
COPY bashio-standalone.sh /usr/local/bin/bashio

RUN chmod +x /etc/cont-init.d/ha_entrypoint.sh /usr/local/bin/bashio

LABEL io.hass.name="Your-Spotify" \
      io.hass.description="Your-Spotify - Spotify analytics and playlist management" \
      io.hass.type="addon" \
      io.hass.version="${BUILD_VERSION}" \
      io.hass.arch="${BUILD_ARCH}" \
      io.hass.url="https://github.com/Yooooomi/your_spotify" \
      maintainer="rezusnet"

ENV HEALTH_PORT=3000 \
    HEALTH_URL=/
