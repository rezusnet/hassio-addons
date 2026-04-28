## Getting Started

After installing and starting the add-on:

1. Open LightRAG via the **HA sidebar** (Ingress) or at `http://<your-ha-ip>:9621`.
2. Configure your LLM provider and embedding provider in the add-on options.
3. Upload documents through the web UI.
4. Query the indexed data and explore the generated knowledge graph.

## Configuration

### Options

| Option                      | Type     | Default                     | Description                        |
| --------------------------- | -------- | --------------------------- | ---------------------------------- |
| `llm_binding`               | list     | `openai`                    | LLM provider binding               |
| `llm_binding_host`          | str      | `https://api.openai.com/v1` | Provider endpoint                  |
| `llm_binding_api_key`       | password | `""`                        | LLM API key                        |
| `llm_model`                 | str      | `gpt-4o-mini`               | LLM model name                     |
| `embedding_binding`         | list     | `openai`                    | Embedding provider binding         |
| `embedding_binding_host`    | str      | `https://api.openai.com/v1` | Embedding endpoint                 |
| `embedding_binding_api_key` | password | `""`                        | Embedding API key                  |
| `embedding_model`           | str      | `text-embedding-3-small`    | Embedding model                    |
| `embedding_dim`             | int      | `1536`                      | Embedding vector size              |
| `summary_language`          | list     | `English`                   | Summary language                   |
| `chunk_size`                | int      | `1200`                      | Document chunk size                |
| `max_async`                 | int      | `4`                         | Maximum concurrent async jobs      |
| `webui_title`               | str      | `My Graph KB`               | Custom UI title                    |
| `kv_storage`                | list     | _(empty)_                   | Key-value storage backend override |
| `vector_storage`            | list     | _(empty)_                   | Vector storage backend override    |
| `graph_storage`             | list     | _(empty)_                   | Graph storage backend override     |
| `doc_status_storage`        | list     | _(empty)_                   | Document status backend override   |
| `auth_accounts`             | str      | _(empty)_                   | UI auth accounts definition        |
| `token_secret`              | password | _(empty)_                   | Token signing secret               |
| `llm_timeout`               | int      | _(empty)_                   | LLM request timeout                |
| `enable_llm_cache`          | bool     | _(empty)_                   | Enable LightRAG response cache     |
| `top_k`                     | int      | _(empty)_                   | Retrieval top-k override           |
| `env_vars`                  | list     | `[]`                        | Custom environment variables       |

### Example Configuration

```yaml
llm_binding: openai
llm_binding_host: https://api.openai.com/v1
llm_binding_api_key: sk-...
llm_model: gpt-4o-mini
embedding_binding: openai
embedding_binding_host: https://api.openai.com/v1
embedding_binding_api_key: sk-...
embedding_model: text-embedding-3-small
embedding_dim: 1536
summary_language: English
chunk_size: 1200
max_async: 4
webui_title: My Graph KB
```

## Storage Paths

The add-on stores local data under `/data` inside the container:

| Path                | Purpose               |
| ------------------- | --------------------- |
| `/data/rag_storage` | LightRAG working data |
| `/data/inputs`      | Uploaded input files  |
| `/data/tiktoken`    | Tokenizer cache       |

## Provider Setup

### OpenAI-compatible providers

- Set `llm_binding` and `embedding_binding` to `openai`
- Point `*_binding_host` to the provider endpoint if needed
- Supply API keys via the dedicated config options

### Ollama

- Set `llm_binding` and/or `embedding_binding` to `ollama`
- Point the corresponding host to your Ollama instance
- Use models available on that Ollama server

### Advanced storage backends

LightRAG supports alternate backends for key-value, vector, graph, and document status storage. Leave these unset for the lightweight default storage stack.

## Troubleshooting

### Add-on won't start

- Confirm API keys and hosts are configured correctly
- Check the add-on log for provider authentication failures
- Verify the selected model names exist on the configured provider

### Queries return poor results

- Use a stronger LLM model for indexing and query generation
- Verify the embedding model matches your intended language and domain
- Adjust `chunk_size` and `top_k`

### Web UI loads but indexing fails

- Check provider credentials and endpoint reachability
- Verify enough memory and disk are available under `/data`
- Review the add-on log for upstream LightRAG errors

## Upstream Documentation

- [LightRAG GitHub repository](https://github.com/HKUDS/LightRAG)
- [LightRAG server documentation](https://github.com/HKUDS/LightRAG/tree/main/docs)
