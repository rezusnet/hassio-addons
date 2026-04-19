## 2.33.7 (19-04-2026)

- Fix ingress_entry: remove leading slash (was causing //audiobookshelf/)
- Change internal port from 80 to 8133 to avoid conflicts

## 2.33.6 (19-04-2026)

- Fix ingress UI: use ingress_entry=/audiobookshelf/ instead of ROUTER_BASE_PATH=/
- Keep upstream default ROUTER_BASE_PATH=/audiobookshelf for correct asset loading

## 2.33.5 (19-04-2026)

- Fix ingress: set ROUTER_BASE_PATH=/ so app serves from root
- Fix tini subreaper warning with -s flag

## 2.33.4 (19-04-2026)

- Fix startup: tini is at /sbin/tini, not /usr/bin/tini

## 2.33.3 (17-04-2026)

- Fix schema validation: remove space in int(10,300) type expression

## 2.33.2 (17-04-2026)

- Replace icon with high-resolution version (512x512)

## 2.33.1 (17-04-2026)

- Initial release
- Based on Audiobookshelf v2.33.1
- Self-hosted audiobook and podcast server
- Web UI with HA ingress support (websocket enabled)
- Audiobook and podcast streaming with multi-user support
- Configurable media paths (audiobooks, podcasts)
- Supports all audio formats and ebooks (epub, pdf, cbr, cbz)
- Automatic library scanning
- Extended options: backup path, CORS, SSRF filter, rate limiting
- Custom environment variables support
