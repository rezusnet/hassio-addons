## Getting Started

After installing and starting the add-on:

1. Open Bookshelf via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:8787`
2. Complete the setup wizard
3. Add your book libraries pointing to media directories (e.g., `/media/books`, `/share/bookshelf/books`)
4. Connect your download client (qBittorrent, Transmission, SABnzbd, etc.)

## Metadata Configuration

Bookshelf has native [rreading-glasses](https://github.com/blampe/rreading-glasses) integration. By default it uses the public GoodReads metadata instance at `https://api.bookinfo.pro`.

### Self-hosted rreading-glasses

To use a self-hosted rreading-glasses instance (recommended for privacy and performance):

1. Install the **Rreading Glasses** add-on from this repository
2. Set `metadata_url` to your rreading-glasses instance URL (e.g., `http://192.168.7.2:8788`)
3. Restart Bookshelf

The `METADATA_URL` environment variable is automatically set from this option.

Alternatively, you can navigate to the hidden **Settings > Development** page (`/settings/development`) and set the **Metadata Provider Source** directly in the UI.

## Configuration

### Options

| Option          | Type | Default            | Description                                             |
| --------------- | ---- | ------------------ | ------------------------------------------------------- |
| `env_vars`      | list | `[]`               | Custom environment variables (name/value pairs)         |
| `PGID`          | int  | `0`                | Group ID for file permissions                           |
| `PUID`          | int  | `0`                | User ID for file permissions                            |
| `data_location` | str  | `/share/bookshelf` | Path where Bookshelf stores config and data             |
| `TZ`            | str  | `""`               | Timezone (e.g., `Europe/Bucharest`)                     |
| `metadata_url`  | str  | `""`               | rreading-glasses metadata URL (empty = public instance) |
| `localdisks`    | str  | `""`               | Local drives to mount (e.g., `sda1,sdb1`)               |
| `networkdisks`  | str  | `""`               | SMB shares to mount (e.g., `//SERVER/SHARE`)            |
| `cifsusername`  | str  | `""`               | SMB username for network shares                         |
| `cifspassword`  | str  | `""`               | SMB password for network shares                         |
| `cifsdomain`    | str  | `""`               | SMB domain for network shares                           |

### Example Configuration

```yaml
PGID: 0
PUID: 0
TZ: "Europe/Bucharest"
data_location: "/share/bookshelf"
metadata_url: "http://192.168.7.2:8788"
networkdisks: "//192.168.1.100/media"
cifsusername: "mediauser"
cifspassword: "mypassword"
```

## File Access

The add-on maps the following HA directories:

| HA Path            | Container Path                   | Access     |
| ------------------ | -------------------------------- | ---------- |
| `/share/bookshelf` | Configurable via `data_location` | Read/Write |
| `/media/`          | `/media/`                        | Read/Write |
| `/share/`          | `/share/`                        | Read/Write |
| Add-on config      | `/addon_configs/*/`              | Read/Write |

## Media Paths

For best results with hardlinks and atomic moves, use consistent paths inside Bookshelf.
Point your book root folder to `/media/books` or `/share/bookshelf/books`.
Point your download client's output to `/media/downloads` or `/share/downloads`.

See the [Servarr Docker Guide](https://wiki.servarr.com/docker-guide) for path planning best practices.

## Migrating from Readarr

Bookshelf (softcover tag) is backward compatible with existing Readarr databases. To migrate:

1. Stop your existing Readarr instance
2. Install this Bookshelf add-on
3. Set `data_location` to the same path Readarr was using (e.g., `/share/readarr`)
4. Start Bookshelf — it will pick up your existing database and configuration

## Ports

| Port   | Protocol | Default | Description   |
| ------ | -------- | ------- | ------------- |
| `8787` | TCP      | `8787`  | Web interface |

## Upstream Documentation

- [Bookshelf GitHub](https://github.com/pennydreadful/bookshelf)
- [rreading-glasses](https://github.com/blampe/rreading-glasses)
- [Servarr Docker Guide](https://wiki.servarr.com/docker-guide)
