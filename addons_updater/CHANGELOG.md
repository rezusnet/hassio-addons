## 1.2.0 (2026-04-25)

- Fix: use hassio-addons/base image for proper s6-overlay and bashio support
- Fix: install lastversion via pip with py3-pip from Alpine
- Remove standalone entrypoint overlay (not needed with proper base image)

## 1.1.0 (2026-04-25)

- Fix: add ha_entrypoint.sh and bashio-standalone.sh to Dockerfile
- Fix: properly install bash, git, jq, lastversion
- Add OCI labels and healthcheck section
- Match Dockerfile pattern used by other add-ons in this repo

## 1.0.0 (2025-04-11)
- Initial release
