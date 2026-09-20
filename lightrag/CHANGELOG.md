<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 1.5.7 (2026-09-03)

Updated to upstream LightRAG **1.5.7**:

### Important Notes

**New Feature: Add end-user-facing entry point to WebUI** 

v1.5.7 adds a second, end-user-facing entry — `/workspace` — together with the **branding** and **prompt controls** a deployment needs before it can be handed to real users.

* A query-only entry for end users: `/workspace`
* Customizable welcome, login and empty-state pages
* A global `USER_PROMPT_PREFIX`

`/workspace` UI shows the chat surface and nothing else — no document management, no knowledge graph, no API-docs links — and is built for mobile use. Point `UI_TEMPLATES_DIR` at a small directory of Markdown files plus a `manifest.json`, and LightRAG serves **your** welcome page, login-page blurb, query empty state, brand logo and copyright line — in several languages, without rebuilding the WebUI. A locale that declares both a login blurb and an agreement document also switches on a login consent checkbox. A ready-to-copy bundle ships in `docs/ui_templates_example/`.

`USER_PROMPT_PREFIX` (or `USER_PROMPT_PREFIX_FILE` for long, multi-paragraph text) prepends deployment-wide instructions to every request's `user_prompt`. It gives the operator one place to set the LLM's role, tone and output format — Mermaid diagrams, LaTeX delimiters, citation style — for both UI entries and the API alike. Requests can never read or replace it; only the API field `disable_user_prompt_prefix` opts out.

For more information, please refer to:

- [`docs/LightRAG-API-Server.md`](https://github.com/HKUDS/LightRAG/blob/main/docs/LightRAG-API-Server.md) — § *The `/workspace` Query Entry*
- [`docs/UserDefinedUI.md`](https://github.com/HKUDS/LightRAG/blob/main/docs/UserDefinedUI.md) — the complete UI customization guide, plus [`docs/ui_templates_example/`](https://github.com/HKUDS/LightRAG/tree/main/docs/ui_templates_example)
- [`README.md`](https://github.com/HKUDS/LightRAG/blob/main/README.md) — `USER_PROMPT_PREFIX` / `USER_PROMPT_PREFIX_FILE`

### What's New

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.7)

## 1.5.7rc2 (2026-08-20)

Updated to upstream LightRAG **1.5.7rc2**:

### What's New
* Add an offline tool to migrate a graph from Apache AGE to PostgreSQL tables by @ysys143 in https://github.com/HKUDS/LightRAG/pull/3620
* feat: support graph-first ingestion with deferred vector indexing by @letsgetai in https://github.com/HKUDS/LightRAG/pull/3473
* feat: add explicit custom chunking selector by @er-s-an in https://github.com/HKUDS/LightRAG/pull/3665
* feat(api): add ENABLE_API_DOCS switch for API documentation exposure by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3672

### What's Changed
* fix(kg): return copies from NetworkXStorage get_node and get_edge by @santhreal in https://github.com/HKUDS/LightRAG/pull/3588
* fix(operate): compute most common entity type and normalize keywords on rebuild by @santhreal in https://github.com/HKUDS/LightRAG/pull/3589
* fix(kg): return boolean values from get_all_update_flags_status by @santhreal in https://github.com/HKUDS/LightRAG/pull/3590
* fix(utils): split GRAPH_FIELD_SEP in merge_source_ids by @santhreal in https://github.com/HKUDS/LightRAG/pull/3592
* fix(utils): correct docstring example and harden compute_incremental_chunk_ids by @santhreal in https://github.com/HKUDS/LightRAG/pull/3591
* fix(parser): bound native markdown image downloads per document (GHSA-25c3-j78v-83qx) by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3605
* fix(kg): hydrate track docs via shared row helper and catch TypeError by @santhreal in https://github.com/HKUDS/LightRAG/pull/3595
* fix(kg): make get_knowledge_graph truncation deterministic across graph backends by @santhreal in https://github.com/HKUDS/LightRAG/pull/3593
* fix(security): bound DOCX decompression and contain sidecar image paths by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3614
* fix(rebuild_vdb): drop lossy agtype quote-strip that corrupts quote-bearing entity_ids by @ysys143 in https://github.com/HKUDS/LightRAG/pull/3587
* fix(extraction): surface token-limit truncation and fail on empty truncated responses by @pengpengyi92 in https://github.com/HKUDS/LightRAG/pull/3607
* build(deps): bump the github-actions group with 2 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3616
* fix(parser): enforce OOXML member and DOCX image budgets by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3619
* fix(graph): validate attributes on the manual entity/relation APIs (GHSA-c922-pw4m-4wcv) by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3623
* fix(kg): enforce the graph-attribute contract in the backends that need it by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3624
* fix(api): reject unstorable characters in a document source by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3626
* fix(graph): preserve self-loops on entity rename by @pengpengyi92 in https://github.com/HKUDS/LightRAG/pull/3622
* fix(graph): reject self-loop relations at the manual write paths by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3625
* perf(kg): drop the seed-degree round trip from PGTable traversal by @ysys143 in https://github.com/HKUDS/LightRAG/pull/3618
* fix(milvus): page vector/id lookups to respect the gRPC response ceiling #3584 by @El-Tatane in https://github.com/HKUDS/LightRAG/pull/3629
* fix: forward embedding_dim to Ollama's embed API by @Vishwamitra in https://github.com/HKUDS/LightRAG/pull/3604
* fix: disable thinking for Ollama extract/keyword roles by default by @Vishwamitra in https://github.com/HKUDS/LightRAG/pull/3599

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.7rc2)

## 1.5.7rc1 (2026-08-18)

Updated to upstream LightRAG **1.5.7rc1**:

### What's New
* Add an offline tool to migrate a graph from Apache AGE to PostgreSQL tables by @ysys143 in https://github.com/HKUDS/LightRAG/pull/3620
* feat: support graph-first ingestion with deferred vector indexing by @letsgetai in https://github.com/HKUDS/LightRAG/pull/3473

### What's Changed
* fix(kg): return copies from NetworkXStorage get_node and get_edge by @santhreal in https://github.com/HKUDS/LightRAG/pull/3588
* fix(operate): compute most common entity type and normalize keywords on rebuild by @santhreal in https://github.com/HKUDS/LightRAG/pull/3589
* fix(kg): return boolean values from get_all_update_flags_status by @santhreal in https://github.com/HKUDS/LightRAG/pull/3590
* fix(utils): split GRAPH_FIELD_SEP in merge_source_ids by @santhreal in https://github.com/HKUDS/LightRAG/pull/3592
* fix(utils): correct docstring example and harden compute_incremental_chunk_ids by @santhreal in https://github.com/HKUDS/LightRAG/pull/3591
* fix(parser): bound native markdown image downloads per document (GHSA-25c3-j78v-83qx) by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3605
* fix(kg): hydrate track docs via shared row helper and catch TypeError by @santhreal in https://github.com/HKUDS/LightRAG/pull/3595
* fix(kg): make get_knowledge_graph truncation deterministic across graph backends by @santhreal in https://github.com/HKUDS/LightRAG/pull/3593
* fix(security): bound DOCX decompression and contain sidecar image paths by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3614
* fix(rebuild_vdb): drop lossy agtype quote-strip that corrupts quote-bearing entity_ids by @ysys143 in https://github.com/HKUDS/LightRAG/pull/3587
* fix(extraction): surface token-limit truncation and fail on empty truncated responses by @pengpengyi92 in https://github.com/HKUDS/LightRAG/pull/3607
* build(deps): bump the github-actions group with 2 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3616
* fix(parser): enforce OOXML member and DOCX image budgets by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3619
* fix(graph): validate attributes on the manual entity/relation APIs (GHSA-c922-pw4m-4wcv) by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3623
* fix(kg): enforce the graph-attribute contract in the backends that need it by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3624
* fix(api): reject unstorable characters in a document source by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3626
* fix(graph): preserve self-loops on entity rename by @pengpengyi92 in https://github.com/HKUDS/LightRAG/pull/3622
* fix(graph): reject self-loop relations at the manual write paths by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3625
* perf(kg): drop the seed-degree round trip from PGTable traversal by @ysys143 in https://github.com/HKUDS/LightRAG/pull/3618
* fix(milvus): page vector/id lookups to respect the gRPC response ceiling #3584 by @El-Tatane in https://github.com/HKUDS/LightRAG/pull/3629
* fix: forward embedding_dim to Ollama's embed API by @Vishwamitra in https://github.com/HKUDS/LightRAG/pull/3604
* fix: disable thinking for Ollama extract/keyword roles by default by @Vishwamitra in https://github.com/HKUDS/LightRAG/pull/3599
* fix(base): tolerate undeclared fields when rehydrating DocProcessingStatus by @qianheng-aws in https://github.com/HKUDS/LightRAG/pull/3633

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.7rc1)

## 1.5.6 (2026-08-07)

Updated to upstream LightRAG **1.5.6**:

### Important Notes

Introducing **PGTableGraphStorage**, a new graph storage backend built on native PostgreSQL tables. By eliminating the dependency on Apache AGE, it not only simplifies deployment but also delivers significantly higher graph storage performance with reduced storage footprint. It will replace the AGE-based `PGGraphStorage` as the preferred graph storage solution for PostgreSQL. This makes **PostgreSQL** the go-to **all-in-one backend database** for LightRAG, enabling a single database to cover all four storage types.

### What's New

* feat(kg): add PGTableGraphStorage — PostgreSQL-native graph backend (no AGE dependency) by @ysys143 in https://github.com/HKUDS/LightRAG/pull/3103
* docs(pipeline): rewrite the dedup and concurrency chapters from a user's view by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3583

### What's Changed

* Implement fail-closed recovery proof for whole-document purge by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3535
* docs: fix broken links and correct VLM gating semantics by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3539
* docs: extract parser service deployment runbooks by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3540
* docs: restructure FileProcessingPipeline into a usable guide by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3541
* docs: fix documentation typos, grammar errors, and incorrect warning messages by @Rythamo8055 in https://github.com/HKUDS/LightRAG/pull/3538
* feat(utils): bound thread-pool submission and pin the tokenizer contract by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3543
* fix(deps): sync uv.lock with the tiktoken floor and correct the restore rationale by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3546
* fix(api): bound request bodies and take token counting off the event loop by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3544
* fix(pipeline): take chunking off the event loop and bound the separator cascade by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3547
* build(deps): bump actions/stale from 10 to 11 in the github-actions group by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3549
* fix(chunker): cache separator normalization warnings by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3550
* fix(utils): strip whitespace before bool env conversion by @santhreal in https://github.com/HKUDS/LightRAG/pull/3554
* fix(kg): set is_truncated when get_knowledge_graph hits max_nodes by @santhreal in https://github.com/HKUDS/LightRAG/pull/3558
* fix(utils): return 0.0 from cosine_similarity on non-finite vectors by @santhreal in https://github.com/HKUDS/LightRAG/pull/3553
* fix(kg): report is_truncated correctly in mongo/neo4j/opensearch BFS fallbacks by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3564
* feat(tokenizer): safe encode-verified split/truncate contract, replacing #3559 by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3565
* fix(milvus): escape quotes and backslashes in filter ids by @santhreal in https://github.com/HKUDS/LightRAG/pull/3555
* fix(graph): normalize manually managed entity names by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3566
* fix(kg): return copies from JsonDocStatusStorage reads by @santhreal in https://github.com/HKUDS/LightRAG/pull/3556
* fix(kg): deep-copy JsonKVStorage read results to prevent aliasing by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3567

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.6)

## 1.5.5 (2026-08-01)

Updated to upstream LightRAG **1.5.5**:

### 🎉 Add`Smart Heading` Recognition Feature For Word Document

Starting from v1.5.5, LightRAG's built-in DOCX parser introduces the **Smart Heading** feature -- enabling better section-based chunking even for poorly formatted DOCX documents.

Many DOCX documents have visually clear section structures but lack properly configured Word outline levels, or retain incorrect heading styles from editing, copying, and concatenation processes. In the past, these issues could cause section titles to be treated as body text, or regular text to be misidentified as headings, resulting in chunking boundaries that deviate from the document's true semantic sections. For P chunking strategies that rely on heading structures, this creates fragmented context or mixed content from different sections, affecting subsequent indexing and retrieval.

**Smart Heading** targets such poorly formatted but semantically clear documents, restoring their true heading structures as much as possible:

1. **Recover Missing Section Titles**: Identify content that visually appears as titles but lacks properly configured outline levels, reducing loss of section structures.
2. **Reduce False Positives of Body Text as Headings**: Restore regular body text, complete clauses, captions, dates, and version notes that incorrectly carry heading styles back to body text, avoiding meaningless chunking boundaries.
3. **Improve Inconsistent Heading Hierarchies**: Reduce issues such as inconsistent sibling heading levels, inverted parent-child hierarchies, and skipped levels, making section structures more coherent.
4. **Distinguish Multiple Contents in Merged Documents**: Identify main titles and document boundaries of each piece of content, preventing section level interference between different documents.
5. **Reduce Noise from Long Tables of Contents**: Compress excessively long table of contents, minimizing the interference of duplicate information on indexing and retrieval.

By providing more reliable section structures for subsequent chunking, Smart Heading helps maintain semantic associations between titles and their corresponding body text, making chunking results align better with the document's original content organization.

Smart Heading is an optional capability of the Native DOCX parser and requires activation to take effect. For enabling and configuration instructions, please refer to: [docs/FileProcessingPipeline](https://github.com/HKUDS/LightRAG/blob/main/docs/FileProcessingPipeline.md#using-the-native-file-parsing-engine)  / [中文版](https://github.com/HKUDS/LightRAG/blob/main/docs/FileProcessingPipeline-zh.md#%E4%BD%BF%E7%94%A8-native-%E6%96%87%E4%BB%B6%E8%A7%A3%E6%9E%90%E5%BC%95%E6%93%8E).

### What's New

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.5)

## 1.5.5rc1 (2026-07-14)

Updated to upstream LightRAG **1.5.5rc1**:

### What's New:`Smart Heading Recognition` Feature For Word Document

Starting from v1.5.5, LightRAG's built-in DOCX parser introduces the **Smart Heading** feature -- enabling better section-based chunking even for poorly formatted DOCX documents.

Many DOCX documents have visually clear section structures but lack properly configured Word outline levels, or retain incorrect heading styles from editing, copying, and concatenation processes. In the past, these issues could cause section titles to be treated as body text, or regular text to be misidentified as headings, resulting in chunking boundaries that deviate from the document's true semantic sections. For P chunking strategies that rely on heading structures, this creates fragmented context or mixed content from different sections, affecting subsequent indexing and retrieval.

**Smart Heading** targets such poorly formatted but semantically clear documents, restoring their true heading structures as much as possible:

1. **Recover Missing Section Titles**: Identify content that visually appears as titles but lacks properly configured outline levels, reducing loss of section structures.
2. **Reduce False Positives of Body Text as Headings**: Restore regular body text, complete clauses, captions, dates, and version notes that incorrectly carry heading styles back to body text, avoiding meaningless chunking boundaries.
3. **Improve Inconsistent Heading Hierarchies**: Reduce issues such as inconsistent sibling heading levels, inverted parent-child hierarchies, and skipped levels, making section structures more coherent.
4. **Distinguish Multiple Contents in Merged Documents**: Identify main titles and document boundaries of each piece of content, preventing section level interference between different documents.
5. **Reduce Noise from Long Tables of Contents**: Compress excessively long table of contents, minimizing the interference of duplicate information on indexing and retrieval.

By providing more reliable section structures for subsequent chunking, Smart Heading helps maintain semantic associations between titles and their corresponding body text, making chunking results align better with the document's original content organization.

Smart Heading is an optional capability of the Native DOCX parser and requires activation to take effect. For enabling and configuration instructions, please refer to: [docs/FileProcessingPipeline](https://github.com/HKUDS/LightRAG/blob/main/docs/FileProcessingPipeline.md#using-the-native-file-parsing-engine)  / [中文版](https://github.com/HKUDS/LightRAG/blob/main/docs/FileProcessingPipeline-zh.md#%E4%BD%BF%E7%94%A8-native-%E6%96%87%E4%BB%B6%E8%A7%A3%E6%9E%90%E5%BC%95%E6%93%8E).

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.5rc1)

## 1.5.4 (2026-06-25)

Updated to upstream LightRAG **1.5.4**:

### What's New
* feat(parser): native engine **support for Markdown parsing**, including **embedded base64 images** and `.textpack` bundle image integration by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3280
* feat(parser): per-file engine parameters via hint/rule (Phase 2 — MinerU + Docling) by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3284
* perf(webui): made graph rendering more efficient -> large knowledge graphs now usable by @Xaverrrrr in https://github.com/HKUDS/LightRAG/pull/3304

### What's Changed
* Add parameterized parser hints for chunk strategy tuning by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3282
* feat(chunker): add drop_references option to P chunking strategy by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3285
* feat(webui): reorder query modes and warn on lower-quality modes by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3287
* fix(mineru): drop page_number items from blocks content by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3288
* fix(storage): handle set ids in delete (Issue #3286) by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3289
* Fixed typo (Dokcer -> Docker) by @aleksvujic in https://github.com/HKUDS/LightRAG/pull/3291
* refactor(parser): move all chunking out of the docx parser by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3295
* fix(api): stop guest tokens from bypassing X-API-Key auth by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3319
* fix(api): don't pair wildcard CORS origin with credentials by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3317
* docs(README): add optional HVTracker trust badge by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3320
* fix(sidecar): prevent path traversal in asset materialization by @VectorPeak in https://github.com/HKUDS/LightRAG/pull/3316

### New Contributors
* @VectorPeak made their first contribution in https://github.com/HKUDS/LightRAG/pull/3316

**Full Changelog**: https://github.com/HKUDS/LightRAG/compare/v1.5.3...v1.5.4

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.4)

## 1.5.3 (2026-06-14)

Updated to upstream LightRAG **1.5.3**:

### ⚠️ Upgrade Notes (existing Milvus deployments)

Due to PR #3228, upgrading an existing Milvus deployment triggers a one-time automatic migration on the next initialize_storages(): the legacy collection is copied into the new model-suffixed collection (schema-upgraded and byte-truncated) before the service becomes ready. Plan for the extra startup time and write throughput on large collections.

* The migration runs only once. After the suffixed collection exists, every subsequent startup validates and loads it directly and does not re-scan or re-migrate the legacy collection.
* The legacy data is never deleted automatically. For safety the old {workspace}_{namespace} collection is kept, not dropped, so vector storage is temporarily duplicated after the upgrade. This is intentional — the migration does not reclaim the space for you.
  * Action required: once you have confirmed the migration succeeded and the new system works correctly against the model-suffixed collection, manually drop the old {workspace}_{namespace} collection yourself to reclaim storage. Until you do, the duplicated vectors remain on disk.
* Legacy collections whose data is incompatible (different vector dimension, or an old simple schema with no vector field) are not migrated; a fresh suffixed collection is created instead and the legacy data is left untouched.

### What's New
* feat(tools): add offline VDB rebuild for vector drift recovery by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3243
* feat(concurrency): make MAX_ASYNC a true cross-worker limit under gunicorn + aggregated queue stats by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3253
* refact(Milvus): Fix Milvus dynamic field overflow + isolate collections by embedding model by @ye-guan-xing in https://github.com/HKUDS/LightRAG/pull/3228

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.3)

## 1.5.2 (2026-06-11)

Updated to upstream LightRAG **1.5.2**:

### What's New

* feat(parser): standardize the parser engine interface through a registration mechanism with support for third-party parsers by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3235

### What's Changed

* 🐛 fix(neo4j): sanitize Lucene reserved chars in label search by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3233
* fix(multimodal): strip XML-illegal control chars before they reach the graph by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3237
* fix: repair LaTeX escape damage in LLM JSON responses (multimodal analysis & entity extraction) by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3238
* fix(pipeline): map parse-stage failures onto the legacy error-document UI fields by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3239
* refactor(pipeline)!: remove the deprecated docs_format="lightrag" enqueue entrypoint by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3240

**Full Changelog**: https://github.com/HKUDS/LightRAG/compare/v1.5.1...v1.5.2

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.2)

## 1.5.1 (2026-06-10)

Updated to upstream LightRAG **1.5.1**:

### Importance Notes

To prevent weaker LLMs from inadvertently incorporating few-shot examples from the prompt into the extraction results, the official **entity-relation extraction prompt has been updated in the current version by removing the few-shot examples**. Empirical evaluation on the Qwen3-30B model shows no degradation in extraction quality. However, users are advised to monitor performance carefully on their specific LLMs to ensure consistent results.

To modify the system's default behavior, provide entity types and example prompt texts via env var `ENTITY_TYPE_PROMPT_FILE`.

### What's New

* feat(query): optionally send chunk heading path to the LLM by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3211
* ✨ feat(chunker): inject split-table headers at split time, freeze split slices by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3218
* feat(extract): inject section heading breadcrumb into extraction prompts by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3225
* Add query cancellation with Stop button by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3227
* ♻️ refactor: make extraction prompt examples format-only by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3231

### What's Changed

* build(deps): update redis requirement from <8.0.0,>=5.0.0 to >=5.0.0,<9.0.0 by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3194
* 🔧 chore(mineru): default MINERU_LOCAL_IMAGE_ANALYSIS to false by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3208
* build(deps): bump the react group in /lightrag_webui with 3 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3199
* build(deps): bump lucide-react from 1.16.0 to 1.17.0 in /lightrag_webui in the ui-components group by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3200
* build(deps-dev): bump the build-tools group in /lightrag_webui with 3 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3201
* build(deps): bump katex from 0.16.47 to 0.17.0 in /lightrag_webui in the content-rendering group across 1 directory by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3202
* build(deps): bump the frontend-minor-patch group across 1 directory with 2 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3203
* ♻️ refactor(config): rename MAX_ASYNC to MAX_ASYNC_LLM with alias fallback by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3209
* fix: honor Postgres search path in table checks by @he-yufeng in https://github.com/HKUDS/LightRAG/pull/3206
* fix(parser): surface accurate error for non-ZIP .docx files by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3210
* ✨ fix(chunker): glue body-less heading blocks into their deeper child (P strategy) by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3214
* ✨ fix(chunker): land parent-path gate + bridge overlap for P strategy by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3215
* fix(mineru): preserve HTML table content by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3219
* ✨ feat(multimodal): declare table content format (html/json) in analysis prompt by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3221
* Preserve HTML table header spans in split tables by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3222
* feat(sidecar): add parent_headings to tables/drawings/equations sidecars by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3223

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.1)

## 1.5.0 (2026-06-03)

Updated to upstream LightRAG **1.5.0**:

### Major Improvements

*  🎉✨**Feacture**:  **LightRAG now supports multimodal document processing** and can fully leverage images, tables, and formulas within documents to answer queries. **All RagAnything’s multimodal processing capabilities are merged into LightRAG**; ( [RagAnything](https://github.com/HKUDS/RAG-Anything) will no longer receive core feature updates or maintenance going forward)
*  ✨🎉**Feacture**: **Fully upgraded the document processing pipeline**, with support for using **MinerU** and **Docling** to parse and extract file content, seamlessly integrating with multimodal content analysis and entity-relationship extraction.
*  💡✨**Feacture**: LightRAG now introduces **Native Parsing**, enabling high-quality content extraction from DOCX documents. It supports accurate reconstruction of Word auto-numbering, as well as extraction of images, tables, and formulas, providing seamless integration with multimodal content analysis and entity-relationship extraction. Expanded format support for the **Native Parser** is coming soon.
*  💡🧠**Feacture**: **Introduced four selectable text chunking strategies: `Fix`, `Recursive`, `Vector`, and `Paragraph`.** The parameters for each chunking strategy can be configured through environment variables.
*  💡🎯**Feacture**: The file processing pipeline supports **selecting the file parsing engine and text chunking strategy either based on file extensions or on a per-file basis**. For detailed usage instructions, refer to [FileProcessingPipeline.md](https://github.com/HKUDS/LightRAG/blob/main/docs/FileProcessingPipeline.md).
*  🚀⚡**Performance**: Optimized the vector storage persistence logic by deferring vector computations until the end of each file processing batch, enabling centralized bulk computation. **This significantly reduced the number of vector model invocations and significantly enhance the upsert speed of all vector DB LightRAG supported**.
*  Enable **task-aware embedding** support for asymmetric models, including `voyage-3`, `text-embedding-004`, `embed-multilingual-v3.0`, and `jina-embeddings-v3`.
*  Improved entity/relation extraction reliability by **introducing LLM  JSON-structured output**; set ENTITY_EXTRACTION_USE_JSON=true to enable it.
*  Introduce `ENTITY_TYPE_PROMPT_FILE` to empower users with enhanced guidance for LLM-driven **entity type recognition** and extraction.
*  Fully support Amazon and Anthropic models on **AWS Bedrock API**.
*  🎯✨🎉**Feacture**: Implemented **role-specific LLM configuration** support, introducing four distinct roles: EXTRACT, QUERY, KEYWORDS, and VLM, each with independent LLM settings. It is recommended to configure the KEYWORDS role with a small-parameter, non-reasoning, high-speed model to optimize query latency; the EXTRACT role with a medium-parameter, non-reasoning model to balance accuracy and throughput; and the QUERY role with a large-parameter reasoning model to enhance query quality. For detailed usage instructions, refer to [RoleSpecificLLMConfiguration.md](https://github.com/HKUDS/LightRAG/blob/main/docs/RoleSpecificLLMConfiguration.md).

### What's Broken

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.0)

## 1.5.0rc3 (2026-05-27)

Updated to upstream LightRAG **1.5.0rc3**:

### Major Improvements

*  **LightRAG now supports multimodal document processing** and can fully leverage images, tables, and formulas within documents to answer queries. **All RagAnything’s multimodal processing capabilities are merged into LightRAG**; ( [RagAnything](https://github.com/HKUDS/RAG-Anything) will no longer receive core feature updates or maintenance going forward)
*  **Fully upgraded the document processing pipeline**, with support for using **MinerU** and **Docling** to parse and extract file content, seamlessly integrating with multimodal content analysis and entity-relationship extraction.
*  LightRAG now introduces **Native Parsing**, enabling high-quality content extraction from DOCX documents. It supports accurate reconstruction of Word auto-numbering, as well as extraction of images, tables, and formulas, providing seamless integration with multimodal content analysis and entity-relationship extraction. Expanded format support for the **Native Parser** is coming soon.
*  **Introduced four selectable text chunking strategies: `Fix`, `Recursive`, `Vector`, and `Paragraph`.** The parameters for each chunking strategy can be configured through environment variables.
*  The file processing pipeline supports selecting the content parsing engine and text chunking strategy either based on file extensions or on a per-file basis. For detailed usage instructions, refer to [FileProcessingPipeline.md](https://github.com/HKUDS/LightRAG/blob/main/docs/FileProcessingPipeline.md).
*  Enable **task-aware embedding** support for asymmetric models, including `voyage-3`, `text-embedding-004`, `embed-multilingual-v3.0`, and `jina-embeddings-v3`.
*  Add optional **JSON-formatted LLM** output to enhance stability in the entity and relation extraction pipeline.
*  Improved entity/relation extraction reliability by **introducing LLM  JSON-structured output**; set ENTITY_EXTRACTION_USE_JSON=true to enable it.
*  Introduce `ENTITY_TYPE_PROMPT_FILE` to empower users with enhanced guidance for LLM-driven **entity type recognition** and extraction.
*  Fully support Amazon and Anthropic models on **AWS Bedrock API**.
*  Implemented **role-specific LLM configuration** support, introducing four distinct roles: EXTRACT, QUERY, KEYWORDS, and VLM, each with independent LLM settings. It is recommended to configure the KEYWORDS role with a small-parameter, non-reasoning, high-speed model to optimize query latency; the EXTRACT role with a medium-parameter, non-reasoning model to balance accuracy and throughput; and the QUERY role with a large-parameter reasoning model to enhance query quality. For detailed usage instructions, refer to [RoleSpecificLLMConfiguration.md](https://github.com/HKUDS/LightRAG/blob/main/docs/RoleSpecificLLMConfiguration.md).

<img width="953" height="682" alt="iShot_2026-05-20_18 14 32" src="https://github.com/user-attachments/assets/5077c30b-742b-481b-8251-edf8bfaf1c4e" />

### What's Broken

* The `ENTITY_TYPES` environment variable has been deprecated; Please replace it with ENTITY_TYPE_PROMPT_FILE before launching this new version.
* For OpenSearch versions prior to 3.3.0, upgrade OpenSearch before upgrading LightRAG (see https://github.com/HKUDS/LightRAG/pull/2991).

### What's Changed

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.5.0rc3)

## 1.5.0rc2 (2026-05-24)

- Update to upstream 1.5.0rc2
- Upstream release notes: https://github.com/HKUDS/LightRAG/releases

## 1.5.0rc1 (2026-05-13)

- Update to upstream 1.5.0rc1
- Upstream release notes: https://github.com/HKUDS/LightRAG/releases

## 1.4.16 (2026-05-12)

Updated to upstream LightRAG **1.4.16**:

### Breaking Change

It's a breaking change for existing deployments on OpenSearch < 3.3.0. OpenSearch: Use version-aware sort tiebreaker for PIT search by @LantaoJin in https://github.com/HKUDS/LightRAG/pull/2991

### What's New
* Explicit voyageai embed support by @laszukdawid in https://github.com/HKUDS/LightRAG/pull/2484
* feat: Add task-aware embedding support by @StoreksFeed in https://github.com/HKUDS/LightRAG/pull/2560

### What's Changed
* chore(deps): bump react-router-dom from 7.14.0 to 7.14.1 in /lightrag_webui in the react group by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/2967
* chore(deps-dev): bump the build-tools group in /lightrag_webui with 3 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/2968
* chore(deps): bump the frontend-minor-patch group across 1 directory with 3 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/2969
* chore(deps): bump lucide-react from 0.577.0 to 1.6.0 in /lightrag_webui by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/2970
* Add Podman-compatible compose file by @tears710 in https://github.com/HKUDS/LightRAG/pull/2983
* fix: remove `stream` parameter from `.parse()` call when `response_format` is present by @PaulTitto in https://github.com/HKUDS/LightRAG/pull/2965
* chore(deps): bump react-router-dom from 7.14.1 to 7.14.2 in /lightrag_webui in the react group by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3001
* chore(deps): bump the ui-components group in /lightrag_webui with 3 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3002
* chore(deps): bump axios from 1.15.1 to 1.15.2 in /lightrag_webui in the frontend-minor-patch group by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3004
* chore(deps-dev): bump the build-tools group across 1 directory with 5 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3003
* Replace status tooltip with details modal by @g2424303264-code in https://github.com/HKUDS/LightRAG/pull/3025
* fix(webui): resolve react-hooks lint errors after eslint-plugin upgrade by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/3036
* chore(deps): bump lucide-react from 1.9.0 to 1.14.0 in /lightrag_webui in the ui-components group by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3032
* chore(deps): bump sigma from 3.0.2 to 3.0.3 in /lightrag_webui in the graph-viz group by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3033
* chore(deps-dev): bump typescript-eslint from 8.59.1 to 8.59.2 in /lightrag_webui in the build-tools group by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3034
* chore(deps): bump i18next from 25.10.10 to 26.0.3 in /lightrag_webui by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/3035

### New Contributors
* @tears710 made their first contribution in https://github.com/HKUDS/LightRAG/pull/2983
* @PaulTitto made their first contribution in https://github.com/HKUDS/LightRAG/pull/2965
* @laszukdawid made their first contribution in https://github.com/HKUDS/LightRAG/pull/2484
* @g2424303264-code made their first contribution in https://github.com/HKUDS/LightRAG/pull/3025

**Full Changelog**: https://github.com/HKUDS/LightRAG/compare/v1.4.15...v1.4.16

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.4.16)

## 1.5.0rc1 (2026-04-27)

- Update to upstream 1.5.0rc1
- Upstream release notes: https://github.com/HKUDS/LightRAG/releases

## 1.4.15 (25-04-2026)

Updated to upstream LightRAG **1.4.15**:

### What's New
* ci: sign GHCR docker images with cosign by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2940
* feat(embeddings): added embedding support for providers that don't support base64 encoding (e.g. Yandex Cloud) by @KirillCh143 in https://github.com/HKUDS/LightRAG/pull/2935

### What's Changed
* fix(postgres): remove duplicate SET clause in upsert_edge Cypher query by @sjhddh in https://github.com/HKUDS/LightRAG/pull/2929
* feat(postgres): auto-resolve postgres vector setting by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2933
* fix(postgres): parameterize Cypher write queries to prevent injection by @sjhddh in https://github.com/HKUDS/LightRAG/pull/2931
* fix(graph): return 0 for missing node/edge degree instead of None by @sjhddh in https://github.com/HKUDS/LightRAG/pull/2930
* fix(setup): preserve storage images on compose rewrites by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2934
* Fix local setup device prompt defaults and ordering by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2939
* chore(deps): bump the react group in /lightrag_webui with 3 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/2945
* chore(deps-dev): bump the build-tools group in /lightrag_webui with 4 updates by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/2946
* chore(deps): bump axios from 1.14.0 to 1.15.0 in /lightrag_webui in the frontend-minor-patch group by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/2947
* chore(deps-dev): bump vite from 7.3.2 to 8.0.0 in /lightrag_webui by @dependabot[bot] in https://github.com/HKUDS/LightRAG/pull/2948
* fix(webui): graph settings not persisting when popover closes by @radioflyer28 in https://github.com/HKUDS/LightRAG/pull/2954

### New Contributors
* @KirillCh143 made their first contribution in https://github.com/HKUDS/LightRAG/pull/2935
* @radioflyer28 made their first contribution in https://github.com/HKUDS/LightRAG/pull/2954

**Full Changelog**: https://github.com/HKUDS/LightRAG/compare/v1.4.14...v1.4.15

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.4.15)

## 1.4.14 (17-04-2026)

- Initial release
- Based on LightRAG v1.4.14
- Web UI with HA ingress support
- Configurable LLM provider (OpenAI, Ollama, Azure, Gemini, Bedrock)
- Configurable embedding provider
- Default JSON/NanoVectorDB storage (zero external dependencies)
- Optional external storage backends via env vars
- Document upload and knowledge graph visualization

### Upstream LightRAG 1.4.14

### What's New
* feat(setup): **support Atlas Local Docker for Mongo vector storage** by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2925
* perf: batch graph operations in ainsert_custom_kg for large-scale imports by @nszhsl in https://github.com/HKUDS/LightRAG/pull/2910
* examples: add AG2 multi-agent demo with LightRAG retrieval by @faridun-ag2 in https://github.com/HKUDS/LightRAG/pull/2867

### What's Fixed
* fix: remove redundant file_path_placeholder lookup in _merge_edges_then_upsert by @jwchmodx in https://github.com/HKUDS/LightRAG/pull/2877
* chore: remove dead config.ini / configparser code by @jwchmodx in https://github.com/HKUDS/LightRAG/pull/2887
* chore: remove dead OLLAMA_NUM_CTX / args.ollama_num_ctx assignment by @jwchmodx in https://github.com/HKUDS/LightRAG/pull/2888
* fix(webui): resolve all bun run lint errors in lightrag_webui by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2891
* chore(webui): migrate ESLint stylistic plugin by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2893
* docs(readme): restructure documentation and consolidate core api by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2896
* fix pipeline status history trimming by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2897
* fix: Corrected exception handling for LLM API timeouts where the subclass incorrectly passes keyword args by @hillct in https://github.com/HKUDS/LightRAG/pull/2902
* Improve LLM API failure diagnostics by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2903
* docs: deprecate config.ini in documentation by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2905
* fix(auth): prevent JWT algorithm confusion attack (GHSA-8ffj-4hx4-9pgf) by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2907
* fix(api): add missing metadata field in /query/data error response by @lawrence3699 in https://github.com/HKUDS/LightRAG/pull/2923
* fix(utils): **prevent remove_think_tags from truncating responses with embedded <think> tags** by @sjhddh in https://github.com/HKUDS/LightRAG/pull/2900
* fix(opensearch): **ensure consistent by lazy index refresh and real-time edge lookups** by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2926
* fix(kg): **correct omission of isolated nodes in `get_knowledge_graph` during full graph retrieval** by @danielaskdd in https://github.com/HKUDS/LightRAG/pull/2928

### New Contributors
* @jwchmodx made their first contribution in https://github.com/HKUDS/LightRAG/pull/2877
* @hillct made their first contribution in https://github.com/HKUDS/LightRAG/pull/2902
* @faridun-ag2 made their first contribution in https://github.com/HKUDS/LightRAG/pull/2867
* @lawrence3699 made their first contribution in https://github.com/HKUDS/LightRAG/pull/2923
* @sjhddh made their first contribution in https://github.com/HKUDS/LightRAG/pull/2900
* @nszhsl made their first contribution in https://github.com/HKUDS/LightRAG/pull/2910

**Full Changelog**: https://github.com/HKUDS/LightRAG/compare/v1.4.13...v1.4.14

[Full release notes](https://github.com/HKUDS/LightRAG/releases/tag/v1.4.14)
