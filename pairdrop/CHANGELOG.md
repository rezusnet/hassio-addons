## 1.11.2-11 (2026-05-07)

- Fix shebang: use `#!/usr/bin/with-contenv bash` + source bashio-standalone.sh
  (`bashio` is not a valid interpreter, causing S6 run script to fail silently)

## 1.11.2-10 (2026-05-03)

- Fix EADDRINUSE: replace `npm start` with `node server/index.js` directly
  (npm spawns node as child; when S6 kills npm, orphaned node keeps port bound)

## 1.11.2-9 (2026-05-03)

- Fix hadolint: use COPY for svc-pairdrop/run instead of heredoc

## 1.11.2-8 (2026-05-03)

- Rewrite to pure LSIO pattern (init:false, S6 manages service lifecycle)
- Root cause of EADDRINUSE: both 99-run.sh AND S6 svc-pairdrop were starting the app
- Remove 99-run.sh, patch svc-pairdrop/run to read HA config via bashio
- Match sonarr/radarr pattern exactly

## 1.11.2-7 (2026-05-03)

- Experimental: diagnostic checks for S6 overlay removal

## 1.11.2-6 (2026-05-03)

- Replace /init (S6 binary) with passthrough script to prevent S6 overlay extraction at runtime

## 1.11.2-5 (2026-05-03)

- Same as 1.11.2-4: remove S6 overlay at build time, run node directly via tini
- New tag to force Supervisor image re-pull (Docker layer caching issue)

## 1.11.2-4 (2026-05-03)

- Remove S6 overlay at build time (Dockerfile), not runtime
- Run PairDrop directly via tini (no S6 service management)

## 1.11.2-3 (2026-05-03)

- Switch to non-LSIO pattern: remove S6 overlay, run node directly via tini
- Fixes EADDRINUSE crash loop caused by S6 compiled service database overriding custom run scripts

## 1.11.2-2 (2026-05-03)

- Fix crash loop: exec directly into node instead of npm (npm forks and exits, confusing S6)

## 1.11.2-1 (2026-05-03)

- Fix EADDRINUSE crash loop by providing custom svc-pairdrop/run script
- Properly handle S6 service lifecycle with cd before exec

## 1.11.2 (2026-05-03)

- Initial release based on PairDrop 1.11.2
- Uses linuxserver/docker-pairdrop as base image
- HA ingress via sidebar (ingress_stream)
- Peer-to-peer file sharing via WebRTC
- WebSocket fallback for VPN clients
- Rate limiting support
- SMB/CIFS network share mounting
- Local disk mounting (USB, SATA, NVMe)
- Custom environment variables
- AppArmor profile
