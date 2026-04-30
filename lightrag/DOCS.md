## Getting Started

After installing and starting the add-on:

1. Configure the options below as needed
2. Start the add-on
3. Access the application

For detailed setup instructions, see the upstream documentation links below.

## Configuration

### Options

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
| `chunk_size` | int | `1200` | Chunk Size |
| `embedding_binding` | string | `"openai"` | Embedding Binding |
| `embedding_binding_api_key` | string | `""` | Embedding Binding Api Key |
| `embedding_binding_host` | string | `"https://api.openai.com/v1"` | Embedding Binding Host |
| `embedding_dim` | int | `1536` | Embedding Dim |
| `embedding_model` | string | `"text-embedding-3-small"` | Embedding Model |
| `env_vars` | list | `[]` | Env Vars |
| `llm_binding` | string | `"openai"` | Llm Binding |
| `llm_binding_api_key` | string | `""` | Llm Binding Api Key |
| `llm_binding_host` | string | `"https://api.openai.com/v1"` | Llm Binding Host |
| `llm_model` | string | `"gpt-4o-mini"` | Llm Model |
| `max_async` | int | `4` | Max Async |
| `summary_language` | string | `"English"` | Summary Language |
| `webui_title` | string | `"My Graph KB"` | Webui Title |

## File Access

The add-on maps the following HA directories:

| HA Path | Container Path | Access |
| ------- | -------------- | ------ |
| `/addon_config` | `/addon_config` | RW |
| `/share` | `/share` | RW |

## Ports

| Port | Protocol | Default | Description |
| ---- | -------- | ------- | ----------- |
| `9621` | TCP | `None` | LightRAG API and Web UI (not needed with ingress) |

## Troubleshooting

### Add-on won't start

- Check logs: **Settings > Add-ons > LightRAG > Logs**
- Verify all required options are configured
- Check that required ports are available

## Upstream Documentation

- [Project Homepage](https://github.com/linuxserver/docker-lightrag)
- [GitHub Repository](https://github.com/linuxserver/docker-lightrag)
