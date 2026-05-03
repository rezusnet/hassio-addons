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

RUN cat > /etc/s6-overlay/s6-rc.d/svc-pairdrop/run << 'RUNEOF'
#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set +u

LOCATION="$(bashio::config 'data_location')"
if [[ "$LOCATION" = "null" || -z "$LOCATION" ]]; then LOCATION=/config; fi
RATE_LIMIT="$(bashio::config 'rate_limit')"
WS_FALLBACK="$(bashio::config 'ws_fallback')"
DEBUG_MODE="$(bashio::config 'debug_mode')"
export DEBUG_MODE

mkdir -p "$LOCATION"

if [[ ${RATE_LIMIT,,} = "true" ]]; then
    OPT_RATE_LIMIT="--rate-limit"
fi

if [[ ${WS_FALLBACK,,} = "true" ]]; then
    OPT_WS_FALLBACK="--include-ws-fallback"
fi

if [[ -z ${LSIO_NON_ROOT_USER} ]]; then
    HOME=$LOCATION exec \
        s6-notifyoncheck -d -n 300 -w 1000 -c "nc -z localhost 3000" \
        cd /app/pairdrop s6-setuidgid abc npm start -- "${OPT_RATE_LIMIT}" "${OPT_WS_FALLBACK}"
else
    HOME=$LOCATION exec \
        s6-notifyoncheck -d -n 300 -w 1000 -c "nc -z localhost 3000" \
        cd /app/pairdrop npm start -- "${OPT_RATE_LIMIT}" "${OPT_WS_FALLBACK}"
fi
RUNEOF
RUN chmod +x /etc/s6-overlay/s6-rc.d/svc-pairdrop/run

ARG MODULES="00-banner.sh 01-custom_script.sh 00-local_mounts.sh 00-smb_mounts.sh"

COPY ha_automodules.sh /ha_automodules.sh
RUN chmod 744 /ha_automodules.sh && /ha_automodules.sh "$MODULES" && rm /ha_automodules.sh

COPY ha_autoapps.sh /ha_autoapps.sh
RUN chmod 744 /ha_autoapps.sh && /ha_autoapps.sh "" && rm /ha_autoapps.sh

ENV S6_STAGE2_HOOK=/ha_entrypoint.sh
COPY ha_entrypoint.sh /ha_entrypoint.sh
RUN chmod 777 /ha_entrypoint.sh

COPY bashio-standalone.sh /usr/local/lib/bashio-standalone.sh
RUN chmod 0755 /usr/local/lib/bashio-standalone.sh

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

ENV HEALTH_PORT="3000" \
    HEALTH_URL="/"
HEALTHCHECK \
    --interval=30s \
    --retries=5 \
    --start-period=30s \
    --timeout=25s \
    CMD curl -A "HealthCheck: Docker/1.0" -s -f "http://127.0.0.1:${HEALTH_PORT}${HEALTH_URL}" &>/dev/null || exit 1
