<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 9.0.6 (2026-09-01)

Updated to upstream Valkey **9.0.6**:

Valkey 9.0.6  -  Released Tue 01 September 2026
-----------------------------------------------

Upgrade urgency SECURITY: This release includes security fixes we recommend you apply as soon as possible.

### Security Fixes
* GHSA-jcj7-v34w-v9vv: Fix a use-after-free in RDMA connection handling that could allow an authenticated client to crash the server using CLIENT KILL. Only affects servers built with USE_RDMA and configured with an RDMA listener (#4534)

### Bug Fixes
* Fix crashes, assertion failures, and hangs when using RDMA together with IO threads by @quanyeyang (#3335)
* Fix a double free when a module timer callback stops its own timer with ValkeyModule_StopTimer by @quanyeyang (#4211)
* Fix torn RESP3 push frames when a client publishes a large message to a channel it is also subscribed to by @quanyeyang (#4253)
* RESET now clears CLIENT IMPORT-SOURCE state so reused pooled connections regain normal key expiration semantics by @tjade273 (#3973)
* Truncated AOF files now discard an incomplete MULTI block entirely, preventing loss of later writes after another restart by @chzhoo (#4342)
* Fix an ACL bypass in GEORADIUS and GEORADIUSBYMEMBER where duplicate STORE options checked only the first destination key by @tjade273 (#3971)
* Fix a use-after-free crash when a cluster message arrives for a message type registered by an unloaded module by @enjoy-binbin (#4360)
* Always deep-validate payloads on RDB load and RESTORE, preventing deferred assertion crashes; sanitize-dump-payload is now a deprecated no-op by @jjuleslasarte (#3721)
* Fix out-of-bounds memory access when registering or receiving cluster module messages of type 255, which is now a valid type by @enjoy-binbin (#4410)
* AOF loading no longer applies ACL checks, preventing silent data loss when replaying commands with a disabled default user by @lukepalmer (#3984)
* Fix a client memory accounting leak that inflated the mem_clients_normal INFO field on replicas after primary disconnects by @enjoy-binbin (#4395)
* Fix a permanent client hang when a blocking command such as BLPOP is pipelined with a partially received next command by @foobar (#4531)
* HGETEX now requires write permission on the key, so read-only ACL users can no longer change field TTLs or delete fields by @ranshid (#4576)
* Compare the full TLS certificate CN when authenticating, so an embedded NUL cannot impersonate a truncated ACL username by @madolson (#4577)
* Restore read performance with IO threads on TCP/TLS by applying extra read-completion handling only to RDMA connections by @quanyeyang (#4414)
* Restore write performance with IO threads on TCP/TLS by limiting post-write safety checks to RDMA connections by @quanyeyang (#4452)
* Fix atomic slot migration protocol errors with IO threads by not offloading export connection writes while snapshotting by @satheeshaGowda (#4104)
* Reject invalid slot import ranges when loading an RDB, preventing corrupted files from creating bad migration state by @enjoy-binbin (#4229)
* Reject RDB slot-import records with an invalid job name length, fixing an out-of-bounds read during startup by @quanyeyang (#4210)
* Fix a crash when COPY ends with a bare DB token during slot migration, and block cross-DB COPY regardless of option order by @madolson (#4301)
* HPERSIST, HTTL, HPTTL, HEXPIRETIME, and HPEXPIRETIME now return a syntax error when the FIELDS keyword is missing by @cjx-zar (#4300)

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/9.0.6)

## 9.1.1 (2026-07-22)

Updated to upstream Valkey **9.1.1**:

Valkey 9.1.1  -  Released Tue 21 July 2026
------------------------------------------

Upgrade urgency SECURITY: This release includes security fixes we recommend you apply as soon as possible.

### Security Fixes
* CVE-2026-56684: Fix a use-after-free in TLS connection handling that could allow an authenticated client to achieve remote code execution using CLIENT KILL (#4234)
* CVE-2026-63639: Reject corrupt stream RDB files containing a shared NACK across consumers, which could allow remote code execution. Reported by @z0v3r1n and @lifip. (#4073)

### Bug Fixes
* Omit the implicit `alldbs` ACL rule from `ACL LIST`, `ACL SAVE` and `CONFIG REWRITE` so older versions can parse the output by @dvkashapov (#3964)
* Improve throughput when IO threads are enabled by offloading object deallocation from the main thread by @roshkhatri (#3938)
* Fix use-after-free crash when `ACL LOAD` removes a user whose authenticated client has its close deferred by @ranshid (#3800)
* Enforce `db=` ACL permissions on every DB clause of `COPY`, closing a bypass with `REPLACE` or repeated DB tokens by @enjoy-binbin (#3801)
* Enforce database-level ACLs for `CLUSTER FLUSHSLOT`, which removes keys from all databases by @enjoy-binbin (#3806)
* Fix use-after-free in the module API when unregistering the first registered cluster message receiver by @eifrah-aws (#3846)
* Fix `HRANDFIELD` with a positive count looping forever when non-expired fields are fewer than the requested count by @cjx-zar (#4047)
* Fix clients left on the wrong database after module keyspace notifications for `MOVE` and `COPY` by @enjoy-binbin (#4024)
* Fix Sentinel crash during coordinated failover when the command link to the old primary disconnects by @lukepalmer (#4068)
* Fix crash when active hash field expiration leaves a single-entry expiry bucket whose last field is later removed by @ranshid (#3950)
* Fix assertion in `HEXPIRE`, `HGETDEL` and `HPERSIST` when a module blocks the client in a keyspace notification callback by @enjoy-binbin (#3743)
* Fix undefined behavior in the failover delay calculation when `cluster-node-timeout` is below 30 milliseconds by @enjoy-binbin (#3941)
* Reject zipmap RESTORE/RDB payloads with overflowing length fields that could cause out-of-bounds access on 32-bit builds by @madolson (#3920)
* Reject NAN scores in listpack and ziplist encoded sorted sets on RDB/RESTORE load, preventing a crash on skiplist conversion by @madolson (#3921)
* Fix corrupted replies (dropped leading bytes) caused by a reply buffer race when IO threads are enabled by @nanyan0312 (#4060)
* Fix startup crash on 32-bit systems where time_t is 64-bit (such as Alpine 3.23) when generating `INFO` output by @chenshi5012 (#3787)
* `HGETDEL` now returns a syntax error when the `FIELDS` keyword is missing or misplaced by @lcxn123 (#4049)
* `COMMAND INFO` in RESP3 now returns the subcommands field as an array instead of a set for commands without subcommands by @rickrams (#3939)
* Send the replica version on the dual-channel RDB connection so full syncs with newer encodings like hash field TTLs succeed by @hpatro (#4105)
* Fix duplicate failure handling and an invalid reply sequence in cluster slot migration by @chx9 (#3723)
* Reject control characters in `SENTINEL SET` values to prevent config-file injection via Sentinel config rewrite by @eifrah-aws (#3847)

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/9.1.1)

## 9.1.0 (2026-05-24)

Updated to upstream Valkey **9.1.0**:

Upgrade urgency LOW: This is the first stable release of Valkey 9.1.

### Security fixes

* (CVE-2026-23479) Use-After-Free in unblock client flow
* (CVE-2026-25243) Invalid Memory Access in RESTORE command
* (CVE-2026-23631) Use-after-free when full sync occurs during a yielding Lua/function execution

### New Features and enhanced behavior
* Add cluster bus network traffic usage metric in bytes by @hpatro (#3396)
* Reduce latency spikes during rehashing via incremental page release by @chzhoo (#3481)

### Bug Fixes
* Fix(syncio): Set errno on EOF in syncRead and propagate to conn->last by @abmathur-ie (#3580)
* Fix GEOSEARCH BYPOLYGON leak on invalid COUNT by @bandalgomsu (#3568)
* Handle NULL pointer in streamTrim listpack delta calculation by @smkher (#3591)
* Fixes server crash when RDMA benchmark clients disconnect by @quanyeyang (#3448)
* Fix the memory leak in valkey-benchmark by @nmvk (#3643)

See also the release notes for 9.1.0-rc1 and 9.1.0-rc2.

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/9.1.0)

## 9.0.4 (2026-05-12)

Updated to upstream Valkey **9.0.4**:

Upgrade urgency SECURITY: This release includes security fixes we recommend you
apply as soon as possible.

### Security fixes

* (CVE-2026-23479) Use-After-Free in unblock client flow
* (CVE-2026-25243) Invalid Memory Access in RESTORE command
* (CVE-2026-23631) Use-after-free when full sync occurs during a yielding Lua/function execution

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/9.0.4)

## 9.0.3 (02-05-2026)

- Initial release based on Valkey 9.0.3 (Alpine)
- In-memory key-value data store, fully Redis-compatible
- Configurable persistence, memory limits, eviction policies
- Auto-updates pinned to major version 9.x via `major_version` field

### Upstream Valkey 9.0.3

### Valkey 9.0.3

Upgrade urgency SECURITY: This release includes security fixes we recommend you
apply as soon as possible.

### Security fixes

* (CVE-2025-67733) RESP Protocol Injection via Lua error_reply
* (CVE-2026-21863) Remote DoS with malformed Valkey Cluster bus message
* (CVE-2026-27623) Reset request type after handling empty requests

### Bug fixes

* Avoids crash during MODULE UNLOAD when ACL rules reference a module command and subcommand (#3160)
* Fix server assert on ACL LOAD when current user loses permission to channels (#3182)
* Fix bug causing no response flush sometimes when IO threads are busy (#3205)

[Full release notes](https://github.com/valkey-io/valkey/releases/tag/9.0.3)
