ARG BUILD_FROM
ARG BUILD_ARCH

FROM $BUILD_FROM

ENV HEALTH_PORT=8337 \
    HEALTH_URL=/

RUN echo "**** install bashio ****" && \
    apk add --no-cache --virtual=build-dependencies \
        build-base \
        jq && \
    apk add --no-cache \
        bash \
        curl && \
    curl -s https://raw.githubusercontent.com/hassio-addons/bashio/master/bashio > /usr/bin/bashio && \
    chmod +x /usr/bin/bashio && \
    apk del --no-cache --purge build-dependencies && \
    echo "**** Beets addon base installed ****"

COPY rootfs/ /

RUN chmod +x /etc/cont-init.d/* && \
    chmod +x /etc/services.d/*/run

LABEL io.hass.name="Beets" \
      io.hass.description="Music library organizer and tagger" \
      io.hass.type="addon" \
      io.hass.release="1.0.0" \
      io.hass.url="https://github.com/rezusnet/hassio-addons/tree/master/beets" \
      io.hass.arch="aarch64|amd64"

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:$HEALTH_PORT$HEALTH_URL || exit 1
