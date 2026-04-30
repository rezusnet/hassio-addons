## Getting Started

After installing and starting the add-on:

1. Configure the options below as needed
2. Start the add-on
3. Access the application via the HA sidebar or directly at port 8383

For detailed setup instructions, see the upstream documentation links below.

## Configuration

### Options

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
| `PGID` | int | `1000` | Process Group ID |
| `PUID` | int | `1000` | Process User ID |
| `TZ` | string | `UTC` | Timezone |
| `data_location` | string | `/share/lazylibrarian` | Data Location |
| `env_vars` | list | `[]` | Environment Variables |

### Library Configuration

LazyLibrarian will automatically organize your eBook library. Key configuration areas:

- **Book Search:** Configure NZB sources and torrent sources for automatic book discovery
- **Authors:** Add authors to track, and LazyLibrarian will search for their books
- **Download Clients:** Integrate with your preferred download clients (SABnzbd, transmission, etc.)
- **Post-Processing:** Automatic file organization and metadata management

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/share` | `/share` | RO |
| `/media` | `/media` | RW |

Your library data is stored at the configured `data_location` (default: `/share/lazylibrarian`).

## Ports

| Port | Protocol | Default | Description |
| ---- | -------- | ------- | ----------- |
| `8383` | TCP | `8383` | Web interface |

## Features

### eBook Automation

- Automatic book discovery based on authors and reading lists
- Multi-source searching for availability and quality
- Automatic download and organization
- Integration with download managers for seamless workflow

### Library Management

- Organize books by author, genre, and custom categories
- Automatic metadata and cover art retrieval
- Duplicate detection and removal
- Reading progress tracking

### Advanced Features

- Custom download locations
- Post-download processing and file organization
- Priority-based search and download
- Configurable search intervals

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > LazyLibrarian > Logs**
- Verify all required options are configured
- Check that required ports are available
- Ensure data location is writable

### Downloads not working

- Verify download client is running and configured
- Check LazyLibrarian logs for error messages
- Ensure sufficient disk space available
- Verify NZB/torrent sources are accessible

### Library not updating

- Confirm authors are properly added to your Want List
- Check search source configuration
- Verify internet connectivity
- Review download client logs for issues

## Upstream Documentation

- [Project Homepage](https://github.com/linuxserver/docker-lazylibrarian)
- [GitHub Repository](https://github.com/linuxserver/docker-lazylibrarian)
- [LazyLibrarian Official](https://lazylibrarian.gitlab.io/)
- [Documentation Wiki](https://github.com/linuxserver/docker-lazylibrarian/wiki)
