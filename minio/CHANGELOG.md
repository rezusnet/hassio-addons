<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## RELEASE.2026-09-16T00-00-00Z.2 (2026-09-21)

Updated to upstream MinIO **RELEASE.2026-09-16T00-00-00Z**:

SILO 20260916 is a security and correctness release following `RELEASE.2026-09-03T13-18-01Z`, built from [`2a4d51406b7ed87af5fe6fe0f801f3290f96eb3c`](https://github.com/pgsty/silo/commit/2a4d51406b7ed87af5fe6fe0f801f3290f96eb3c). The package version is `20260916000000.0.0`.

### Highlights

- **Authentication and policies:** reject unsigned `x-amz-*` operation headers, verify header-bound presigned payloads, and align signature-age and payload-hash conditions with authenticated values. Shared policy fixes preserve distinct Deny statements and avoid exponential wildcard matching. See [SN-2026-011 through SN-2026-014](https://silo.pgsty.com/about/security-advisories/).
- **Durable IAM revocation:** retain deletion revisions, membership grant times and parent revocation boundaries so stale replication events and old child credentials cannot cross retained revocations. Peer notifications reload committed state. Password self-service now checks `admin:ChangeMyPassword` separately from `admin:CreateUser`.
- **Multi-pool consistency:** evaluate conditional PUT and multipart completion against the logical current object; honor single-object conditional DELETE; reconcile addressed-version deletion and independently ordered tags/Object Lock metadata across pools. Rebalance and decommission preserve object tags and their revisions for ordinary and multipart objects ([`fced86303`](https://github.com/pgsty/silo/commit/fced8630365fd57d6116c595b65252bcd12e13be)).
- **Listing and delete-marker repairs:** retain a quorate null version when a newer minority would hide it; require majority-confirmed absence for missing-version purge retries; preserve marker replication/purge metadata through healing; recheck queued marker creations under the replication lock; and report a purged data version without incorrectly identifying it as a delete marker ([`8d06424b1`](https://github.com/pgsty/silo/commit/8d06424b126b4ac640cd076a4585b66f2ec753a6), [`eb4f5e5b3`](https://github.com/pgsty/silo/commit/eb4f5e5b3178da42b8b5137acfded62c35f6e3b2), [`254b19ac0`](https://github.com/pgsty/silo/commit/254b19ac071ba0afc178c875aa1681bc9e9c07af), [`358ab38fb`](https://github.com/pgsty/silo/commit/358ab38fb0876d10420373d88af99a1413e65e93)).
- **Encrypted and federated copies:** preserve raw SSE-C replicas, logical multipart sizes, lock/tag revisions and key-rotation checksums; prevent new compressed SSE-C writes; bind federated CopyObject checksums, version and timestamps to the actual destination write.
- **Replication and configuration:** repair ordered tag deletion, marker purge/MRF recovery, resync counters and cancellation, bucket metadata convergence and CORS export/import. Prevent transport-only `aws-chunked` from being stored as object encoding.
- **Multipart discovery:** add durable, quorum-checked listing and preflight with global prefix, delimiter and pagination behavior. **Legacy remains the default.** Strict mode is enabled only through `MINIO_API_MULTIPART_LISTING=strict` after the documented upgrade and capacity checks ([#198](https://github.com/pgsty/silo/pull/198), [#213](https://github.com/pgsty/silo/pull/213)).

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/pgsty/silo/releases/tag/RELEASE.2026-09-16T00-00-00Z)


## RELEASE.2026-08-04T00-00-00Z.2 (2026-08-05)

Updated to upstream MinIO **RELEASE.2026-08-04T00-00-00Z**:

SILO 20260804 is a security, correctness, and release-engineering update to the `pgsty/minio` community fork. It completes the internode storage-containment work begun with CVE-2026-42600, stops request-controlled values from impersonating server-calculated S3/IAM policy conditions, restores streaming flush behavior, fixes several multipart and versioning edge cases, hardens notification configuration, moves the baseline to Go 1.26.5, and rebuilds the release pipeline to produce reproducible binaries and GPG-signed packages.

50 commits after the pre-2026-06-18 baseline (155 files, +9,241/-981). Reviewed against this tagged commit and verified on macOS ARM64 and Linux AMD64 with GitHub CI green on the released HEAD.

[**Full Release Notes**](https://silo.pgsty.com/blog/release/silo-20260804/)

### Highlights

- **Internode containment completed** — validates storage-REST bodies, storage Grid frames, and peer-S3 Grid requests at the storage boundary, closing the remaining path, volume, erasure-metadata, panic, and unbounded-allocation defects left after removing `ReadMultiple`.
- **S3/IAM decisions use effective values** — client input can no longer shadow internal condition values; request tags and existing-object tags are separated; `s3:signatureAge` is confined to verified presigned requests; `s3:versionid` follows the version the server actually acts on.
- **Bucket and object resources separated** — twelve sensitive bucket-level writes are no longer authorized through an object-only `bucket/*` pattern (documented compatibility switch available).
- **Multipart correctness** — full-object checksum completion works without per-part checksums where the protocol permits; zero-length checksums are preserved; duplicate part numbers are rejected instead of assembling duplicated data.
- **Streaming reliability restored** — `trackingResponseWriter` implements `Flush` correctly and records implicit HTTP 200, repairing `mcli watch`, bucket-notification listeners, and S3 Select keep-alives.
- **Notification hardening** — NATS/AMQP parser and migration keys are registered and round-trip; libpq parameters are quoted safely; invalid-key errors no longer echo secrets.
- **Reproducible, signed pipeline** — binaries drop the build-machine paths, packages install under the canonical systemd path, RPMs are GPG-signed, and the container entrypoint shuts down gracefully on every privilege path.

### Security Hardening

Four hardening areas, each with a full advisory:

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/pgsty/silo/releases/tag/RELEASE.2026-08-04T00-00-00Z)

## RELEASE.2026-06-18T00-00-00Z.2 (2026-06-19)

Updated to upstream MinIO **RELEASE.2026-06-18T00-00-00Z**:

### [RELEASE.2026-06-18T00-00-00Z](https://silo.pigsty.io/reference/release-note)

2026-06-18: https://github.com/pgsty/minio/releases/tag/RELEASE.2026-06-18T00-00-00Z

This release is a security and dependency-maintenance update for the `pgsty/minio` fork. It hardens LDAP STS throttling, completes S3 Select oversized-record enforcement, removes the obsolete `ReadMultiple` internode storage-REST API, upgrades the Go build baseline to `1.26.4`, and refreshes Go module dependencies to pick up additional third-party security fixes.

### Major Changes

- Remove the obsolete `ReadMultiple` storage-REST API: the legacy `/rmpl` internode endpoint is removed rather than patched in place, including its route, handler, client wrapper, storage interfaces, xlStorage methods, generated datatypes, and related metric. No production caller is expected after upstream multipart handling moved to `ReadParts`, but clusters should still run a consistent release during rolling upgrades.
- Complete S3 Select oversized-record enforcement: JSON Lines input now uses the bounded reader path, so oversized records are rejected consistently instead of bypassing limits on SIMD-capable CPUs. S3 Select stream errors now preserve the intended error code and wrap JSON parser failures as `JSONParsingError`.
- Harden LDAP STS rate-limit source bucketing: throttling is now keyed only by source IP, avoiding username-shared buckets that could be drained by one client to lock out a legitimate user. Trusted-proxy handling now resolves `X-Forwarded-For` from right to left, rejects catch-all trusted-proxy CIDRs, ignores RFC 7239 `Forwarded`, and documents the `X-Real-IP` deployment contract.
- Refresh the Go runtime and module baseline: release, hotfix, goreleaser, and old-CPU Docker builds now use `golang:1.26.4-alpine`; `go.mod` is updated to Go `1.26.4`; and dependencies are refreshed across NATS, Prometheus, Azure SDK, Apache Thrift, gRPC, OpenTelemetry, Google API/auth, Go `x/*`, and related transitive libraries.

### Direct Security Fixes

- [CVE-2026-42600](https://github.com/advisories/GHSA-xh8f-g2qw-gcm7): remove the obsolete `ReadMultiple` storage-REST API to close the legacy internode file-read path exposed through `/rmpl`.
- [CVE-2026-39414](https://github.com/advisories?query=CVE-2026-39414): complete oversized S3 Select record enforcement for JSON Lines inputs and preserve correct S3 Select error semantics.
- [CVE-2026-33419](https://github.com/advisories?query=CVE-2026-33419): further harden LDAP STS rate-limit accounting and trusted-proxy source-IP handling.

### Dependency Security Updates

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/pgsty/silo/releases/tag/RELEASE.2026-06-18T00-00-00Z)

## RELEASE.2026-04-17T00-00-00Z (2026-05-10)

- Initial release based on pgsty/minio (Silo) RELEASE.2026-04-17T00-00-00Z
- S3-compatible API on port 9000
- Web console via HA ingress on port 9001
- Configurable access key, secret key, data location

### Upstream MinIO RELEASE.2026-04-17T00-00-00Z

### [RELEASE.2026-04-17T00-00-00Z](https://silo.pigsty.io/reference/release-note#id16)

2026-04-17: https://github.com/pgsty/minio/releases/tag/RELEASE.2026-04-17T00-00-00Z

This release focuses on security hardening and compatibility tightening. It bundles fixes across OIDC, LDAP STS, S3 Select, replication metadata handling, unsigned-trailer flows, the Snowball upload path, and multiple dependency- and Go toolchain-related security issues, while also incorporating the LDAP TLS regression fix and a cleanup of community-fork documentation.

### Major Changes

- Tighten the identity-authentication flow: OIDC / WebIdentity now accepts only asymmetrically signed `ID Token` values backed by the IdP `JWKS`; symmetrically signed tokens such as `HS256` are no longer accepted. LDAP STS also now hides the distinction between unknown-user and bad-password failures to reduce username-enumeration risk.
- Update LDAP STS rate limiting: limits now apply to both source IP and normalized username, and successful requests no longer consume quota incorrectly. By default MinIO now uses only the socket peer address as the source and no longer trusts `X-Forwarded-For`, `X-Real-IP`, or `Forwarded`; to rate-limit by real client IP, configure `MINIO_IDENTITY_LDAP_STS_TRUSTED_PROXIES` explicitly.
- Make upload and write paths stricter: presigned query parameters can no longer be combined with `unsigned-trailer` `PUT` or multipart uploads. Snowball auto-extract now also performs full signature validation on the `unsigned-trailer` path and rejects anonymous or forged-signature requests.
- Prevent replication metadata spoofing: internal `X-Minio-Replication-*` headers attached to ordinary `PUT` / `COPY` requests are now rejected or ignored, and only trusted replication flows may write the related internal metadata.
- Clarify S3 Select error semantics: oversized CSV and line-delimited JSON records now return `OverMaxRecordSize` directly instead of the generic `InternalError`; clients or alerting rules that depend on the old error code should be adjusted.
- Upgrade the runtime and dependency baseline: fix the regression where `ldaps://` did not correctly apply TLS settings, replace `minio/pkg/v3` with `pgsty/minio-pkg/v3`, and pin several critical dependencies that are prone to breaking changes. The release also upgrades `go-jose`, `go.opentelemetry.io`, and Go `1.26.2` to unify the build and release baseline.
- Refresh documentation and security guidance: update `SECURITY.md`, `VULNERABILITY_REPORT.md`, `docs/sts/ldap.md`, and related documents, add a security advisory index, and switch upstream `minio/minio` references in the security guidance over to `pgsty/minio`.

### Fixed CVEs

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/pgsty/silo/releases/tag/RELEASE.2026-04-17T00-00-00Z)
