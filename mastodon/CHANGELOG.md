## 4.5.9-ls192 (2026-05-15)

- Update to upstream v4.5.9-ls192

## 4.5.9-ls191 (2026-05-12)

- Update to upstream v4.5.9-ls191

## 4.5.9 (02-05-2026)

- Initial release based on linuxserver/docker-mastodon v4.5.9
- HA ingress support via nginx HTTP (port 80)
- Auto-generation and persistence of SECRET_KEY_BASE, OTP_SECRET, VAPID keys, and Active Record encryption keys
- External PostgreSQL and Redis required
- SMTP email configuration
- HTTPS nginx redirect disabled for ingress compatibility
- Elasticsearch support optional (ES_ENABLED toggle)
- Port 443 exposed for direct/federation access
