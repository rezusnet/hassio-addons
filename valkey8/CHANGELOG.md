<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 8.1.10 (2026-09-01)

Updated to upstream Valkey **8.1.10**:

Valkey 8.1.10  -  Released Mon 31 August 2026
---------------------------------------------

Upgrade urgency SECURITY: This release includes security fixes we recommend you apply as soon as possible.

### Security Fixes
* GHSA-jcj7-v34w-v9vv: Fix a use-after-free in RDMA connection handling that could allow an authenticated client to crash the server using CLIENT KILL. Only affects servers built with USE_RDMA and configured with an RDMA listener (#4534)

### Bug Fixes
* Fix a double free when a module timer callback stops its own timer with `ValkeyModule_StopTimer` by @quanyeyang (#4211)
* RESET now clears the `CLIENT IMPORT-SOURCE` flag so reused pooled connections stop reading logically expired keys by @tjade273 (#3973)
* Fix AOF recovery of a truncated MULTI/EXEC block that could cause new writes to be lost after a subsequent restart by @chzhoo (#4342)
* Fix an ACL bypass where duplicate STORE/STOREDIST options in GEORADIUS commands escaped key write permission checks by @tjade273 (#3971)
* Fix a use-after-free crash when a cluster message of a module-registered type arrives after the module is unloaded by @enjoy-binbin (#4360)
* Fix out-of-bounds access when registering or receiving cluster module messages of type 255, which is now fully supported by @enjoy-binbin (#4410)
* Skip ACL permission checks when replaying the AOF, preventing silent data loss when users are restricted or disabled by @lukepalmer (#3984)
* Fix a client memory accounting leak that inflated `mem_clients_normal` on replicas after disconnecting from the primary by @enjoy-binbin (#4395)
* Always validate listpacks on RDB load and RESTORE to prevent deferred crashes; `sanitize-dump-payload` and the related ACL flags are now deprecated no-ops by @jjuleslasarte (#3721)
* Fix a stack overflow crash when retrying large TLS writes after an OpenSSL write error by @murphyjacob4 (#4307)
* Validate PUBLISH and MODULE cluster bus packet lengths, preventing a crash from forged packets with oversized payload lengths by @tjade273 (#3972)
* Reject crafted stream RESTORE/RDB payloads with inconsistent lengths or negative field counts that could crash the server by @madolson (#3922)
* Fix a use-after-free crash when serving multiple clients blocked on the same key if one is freed during processing by @quanyeyang (#4212)
* Fix CLUSTER SLOT-STATS ORDERBY sorting when slot statistics differ by more than 2^31 by @jzy1688 (#4459)

**Full Changelog**: https://github.com/valkey-io/valkey/compare/8.1.9...8.1.10

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/8.1.10)

## 8.1.9 (2026-07-22)

Updated to upstream Valkey **8.1.9**:

Valkey 8.1.9  -  Released Tue 21 July 2026
------------------------------------------

Upgrade urgency SECURITY: This release includes security fixes we recommend you apply as soon as possible.

### Security Fixes
* CVE-2026-56684: Fix a use-after-free in TLS connection handling that could allow an authenticated client to achieve remote code execution using CLIENT KILL (#4234)
* CVE-2026-63639: Reject corrupt stream RDB files containing a shared NACK across consumers, which could allow remote code execution. Reported by @z0v3r1n and @lifip. (#4073)

### Bug Fixes
* Fix clients being left on the wrong database after module keyspace notifications from commands like `MOVE` and `COPY` by @enjoy-binbin (#4024)
* Fix an I/O thread job queue memory-ordering race that could trigger an assertion crash on ARM/aarch64 by @jjuleslasarte (#3878)
* Reject zipmap `RESTORE` payloads with overflowing length fields that could cause out-of-bounds access on 32-bit builds by @madolson (#3920)
* Reject NAN scores when loading listpack/ziplist-encoded sorted sets, preventing a crash from crafted `RESTORE` payloads by @madolson (#3921)
* Fix a startup crash when generating `INFO` output on 32-bit systems where `time_t` is 64-bit (e.g. Alpine time64) by @chenshi5012 (#3787)
* Fix `COMMAND INFO` in RESP3 to reply with an empty Array instead of a Set for commands without subcommands by @rickrams (#3939)
* Reject invalid characters in cluster AUX fields and `cluster-announce-ip` to prevent `nodes.conf` corruption and injection by @eifrah-aws (#3848)
* Fix `lua-enable-insecure-api` having no effect when enabled at startup via config file or command line by @enjoy-binbin (#3548)
* Increase the maximum process title length from 255 to 1024 characters to avoid truncation with long installation paths by @pkhartsk (#3843)

**Full Changelog**: https://github.com/valkey-io/valkey/compare/8.1.8...8.1.9

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/8.1.9)

## 8.1.8 (2026-06-03)

Updated to upstream Valkey **8.1.8**:

Upgrade urgency HIGH: There is a critical bug that may affect a subset of users.

Bug fixes
=========
* Fix ZDIFF algorithm 2 memory leak on early exit (#3342)
* Strictly check CRLF when parsing querybuf (#2872)
* Fix incorrect memory overhead calculation for watched keys (#3359)
* Fix `valkey-cli --cluster del-node` for unreachable nodes (#3209)
* Fix race condition during async client freeing with IO threading enabled (#3458)
* Fix double free in stream consumer PEL loading with corrupt RDB data (#3498)
* Fixes server crash when RDMA benchmark clients disconnect (#3448)
* Fix misleading log "I/O error reading bulk count from PRIMARY: Success" (#3580)
* Handle NULL pointer in streamTrim listpack delta calculation (#3591)
* Fix Deferred Reply Placeholders in Active Deferred Buffers (#3578)
* Add NULL check in updateSSLPendingFlag (#3641)
* Fix heap-use-after-free in ACL LOAD when client free is deferred (#3800)
* Redacting customer information when hide_user_data_from_log is true in rdb.c, networking.c, debug.c and t_hash  (#3872)
* Fix use-after-free in VM_RegisterClusterMessageReceiver (#3846)
* Harden SENTINEL commands and config rewrite against control-character injection (#3847)
* Fix CLUSTER SLOTS crash when called from module timer callback (#2915)

**Full Changelog**: https://github.com/valkey-io/valkey/compare/8.1.7...8.1.8

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/8.1.8)

## 8.1.7 (2026-05-12)

Updated to upstream Valkey **8.1.7**:

Upgrade urgency SECURITY: This release includes security fixes we recommend you
apply as soon as possible.

### Security fixes

* (CVE-2026-23479) Use-After-Free in unblock client flow
* (CVE-2026-25243) Invalid Memory Access in RESTORE command
* (CVE-2026-23631) Use-after-free when full sync occurs during a yielding Lua/function execution

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/8.1.7)

## 8.1.6 (02-05-2026)

- Initial release based on Valkey 8.1.6 (Alpine)
- In-memory key-value data store, fully Redis-compatible
- Configurable persistence, memory limits, eviction policies
- Auto-updates pinned to major version 8.x via `major_version` field

### Upstream Valkey 8.1.6

### Valkey 8.1.6

Upgrade urgency SECURITY: This release includes security fixes we recommend you
apply as soon as possible.

### Security fixes
* (CVE-2026-21863) Remote DoS with malformed Valkey Cluster bus message
* (CVE-2025-67733) RESP Protocol Injection via Lua error_reply

### Bug fixes
* Restrict ttl from being negative and avoid crash in import-mode (#2944)
* Fix chained replica crash when doing dual channel replication (#2983)
* Fix used_memory_dataset underflow due to miscalculated used_memory_overhead (#3005)
* Fix crashing while MODULE UNLOAD when ACL rules reference a module command or subcommand (#3160)
* Fix server assert on ACL LOAD and resetchannels (#3182)
* Fix bug causing no response flush sometimes when IO threads are busy (#3205)

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/8.1.6)
