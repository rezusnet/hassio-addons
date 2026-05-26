# Rreading Glasses — Full Documentation

## Getting Started

After installing and starting the add-on:

1. The bundled PostgreSQL initializes automatically on first start.
2. The metadata API becomes available at `http://<your-ha-ip>:8788`.
3. In Readarr, navigate to **Settings → Development** (`/settings/development` — this page is hidden from the UI).
4. Set **Metadata Provider Source** to `http://<your-ha-ip>:8788`.
5. Click **Save**.
6. You can now search and add authors/works not available on the defunct official service.

## Configuration

All options are configured in the Home Assistant add-on **Configuration** tab.

### Metadata Source

| Option           | Type | Default     | Description                                                    |
| ---------------- | ---- | ----------- | -------------------------------------------------------------- |
| `source`         | list | `goodreads` | Metadata source: `goodreads` or `hardcover`                    |
| `port`           | int  | `8788`      | TCP port for the metadata API                                  |
| `hardcover_auth` | pass | _(empty)_   | Hardcover API auth token (required when source is `hardcover`) |
| `verbose`        | bool | `false`     | Enable verbose logging                                         |

### PostgreSQL (Bundled — Default)

Leave `postgres_host` empty to use the bundled PostgreSQL. It initializes automatically and stores data in `/data/postgres`.

### PostgreSQL (External)

Set `postgres_host` to use an external PostgreSQL server:

| Option              | Type     | Default            | Description                                |
| ------------------- | -------- | ------------------ | ------------------------------------------ |
| `postgres_host`     | str      | _(empty)_          | External PG host. Leave empty for bundled. |
| `postgres_port`     | int      | `5432`             | External PG port                           |
| `postgres_user`     | str      | `rreading-glasses` | PG username                                |
| `postgres_password` | password | _(empty)_          | PG password                                |
| `postgres_database` | str      | `rreading-glasses` | PG database name                           |

### Advanced

| Option     | Type | Default | Description                                                                 |
| ---------- | ---- | ------- | --------------------------------------------------------------------------- |
| `env_vars` | list | `[]`    | Custom environment variables. Each entry has a `name` and optional `value`. |

### Example Configuration

**GoodReads (default):**

```yaml
source: goodreads
port: 8788
verbose: false
```

**Hardcover:**

```yaml
source: hardcover
hardcover_auth: Bearer eyJ...
port: 8788
```

**External PostgreSQL:**

```yaml
source: goodreads
postgres_host: 192.168.1.100
postgres_port: 5432
postgres_user: myuser
postgres_password: mypassword
postgres_database: rreading-glasses
```

## Data Storage

When using the bundled PostgreSQL, data is stored in `/data/postgres` inside the container, which maps to the add-on's persistent storage volume.

## Metadata Sources

### GoodReads

- Backward-compatible with existing Readarr databases
- Full coverage of GoodReads including large authors
- No additional configuration needed

### Hardcover

- Higher quality metadata with active community curation
- Requires a [Hardcover](https://hardcover.app) account and API token
- Set `source` to `hardcover` and provide your token in `hardcover_auth`
- The token should be prefixed with `Bearer ` (e.g., `Bearer eyJ...`)
- Consider [supporting Hardcover](https://hardcover.app/supporter) if you use this source

## Troubleshooting

### Add-on won't start

- Check the add-on **Log** tab for PostgreSQL or application errors
- If using bundled PG, ensure `/data/postgres` is not corrupted — stop the add-on, delete `/data/postgres`, and restart to reinitialize
- If using external PG, verify connectivity and credentials

### Readarr can't connect

- Ensure port `8788` is not blocked by a firewall
- Verify the URL in Readarr's **Settings → Development** matches `http://<your-ha-ip>:8788`
- Try accessing `http://<your-ha-ip>:8788/health` directly — it should return a 200 response

### Metadata not loading

- Check the add-on **Log** tab for errors
- Enable `verbose` mode for detailed logging
- Verify the selected source is correct (GoodReads vs Hardcover)

## Upstream Documentation

- [Rreading Glasses GitHub](https://github.com/blampe/rreading-glasses) — Source code, issues, discussion
- [Docker Hub](https://hub.docker.com/r/blampe/rreading-glasses) — Docker images
- [Discord](https://discord.gg/Xykjv87yYs) — Community support
