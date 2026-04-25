## 3.3.7 (2026-04-25)

- Switch to official HAProxy Docker image as base
- Add updater.json for automatic version tracking
- Update config paths to match official image layout

## 1.0.1 (2026-04-21)

- Fix icon: use official HAProxy logo

## 1.0.0 (2026-04-21)

- Initial release
- SNI-based TLS routing on port 443
- Host-header based HTTP routing on port 80
- Configurable domain-to-backend routes via add-on options
- Default backends for unmatched traffic (NPM)
- Zero maintenance: no NPM modifications required
