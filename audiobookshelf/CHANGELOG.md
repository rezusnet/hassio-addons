## 2.33.2 (25-04-2026)

- Fix version to match actual upstream audiobookshelf release

## 2.33.15 (20-04-2026)

- Move full documentation to DOCS.md (Documentation tab in HA)
- Slim README.md to essentials (Info tab)
- Include official Audiobookshelf docs: first launch, library setup, formats, directory structure
- Add guides: reverse proxy, OpenID Connect, troubleshooting, mobile apps

## 2.33.14 (20-04-2026)

- Fix query_logging schema: use str? instead of list() to avoid YAML boolean coercion of 'off'

## 2.33.13 (20-04-2026)

- Expose all Audiobookshelf environment variables as HA add-on options (22 total)
- New options: allow_iframe, max_failed_episode_checks, access_token_expiry, refresh_token_expiry, router_base_path, exp_proxy_support, use_x_accel, skip_binaries_check, query_logging, sqlite_cache_size, sqlite_mmap_size, sqlite_temp_store
- Add full README.md documentation for every option

## 2.33.12 (20-04-2026)

- Remove ingress proxy — Audiobookshelf Nuxt SPA is incompatible with HA ingress
- Direct Web UI access via "Open Web UI" button (opens in new tab)
- Revert to simple startup matching upstream docker image

## 2.33.11 (20-04-2026)

- Add Node.js ingress proxy for HA sidebar panel support (did not work)

## 2.33.10 (20-04-2026)

- Remove HA ingress (incompatible with Audiobookshelf Nuxt SPA absolute API paths)
- Expose port 8133 directly for web UI access
- Revert client file rewriting — use upstream default ROUTER_BASE_PATH=/audiobookshelf
- Access the UI at http://<HA-IP>:8133/audiobookshelf/
- Optionally add a sidebar panel via HA Settings → Dashboards → Add Panel (iframe)

## 2.33.9 (20-04-2026)

- Disable ingress_stream to fix buffering issues with Nuxt SPA

## 2.33.8 (19-04-2026)

- Fix ingress: rewrite client asset paths at build time to serve from /
- Set ROUTER_BASE_PATH=/ for HA ingress compatibility
- Remove ingress_entry, use default /

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
