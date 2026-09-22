<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 2.6.2 (2026-09-22)

Updated to upstream OpenBao **2.6.2**:

### SECURITY

* core: Ensure internal operation types cannot be dispatched from inline authentication and workflows, preventing token creation. GHSA-rh46-vc3j-w2w3. [[GH-3831](https://github.com/openbao/openbao/pull/3831)]
* secrets/pki: Also enforce `allowed_ip_sans_cidr` on IP SANs from CSRs. GHSA-g892-p242-8g86. [[GH-3833](https://github.com/openbao/openbao/pull/3833)]

### BUG FIXES

* command/agent: Fix file sink chown failing unconditionally on Windows. [[GH-3733](https://github.com/openbao/openbao/pull/3733)]
* core: Prevent recovered panic in request handler due to uncanceled active context between initialization and standby/active enablement. [[GH-3623](https://github.com/openbao/openbao/pull/3623)]
* core: Propagate requests with wrap info to the active node. [[GH-3790](https://github.com/openbao/openbao/pull/3790)]
* core/identity: Write OIDC default keys into per-namespace storage. [[GH-3662](https://github.com/openbao/openbao/pull/3662)]
* core/namespaces: Fix fatal failures writing default OIDC keys on standby nodes during namespace creation. [[GH-3662](https://github.com/openbao/openbao/pull/3662)]
* sys/raw: Propagate delete and write requests to the active node. [[GH-3766](https://github.com/openbao/openbao/pull/3766)]
* sys/leases: Propagate renew, revoke and revoke-prefix requests to the active node by default. [[GH-3766](https://github.com/openbao/openbao/pull/3766)]
* sys/quotas: Fix broken `enable_rate_limit_audit_logging` option. [[GH-3673](https://github.com/openbao/openbao/pull/3673)]
* sys/workflows: Allow unauthenticated workflow execution without authentication. [[GH-3785](https://github.com/openbao/openbao/pull/3785)]
* audit/http: Fix error wrapping in header parsing so the underlying cause is not lost. [[GH-3746](https://github.com/openbao/openbao/pull/3746)]
* ui: Fix client-side validation for auth/userpass user creation. [[GH-3625](https://github.com/openbao/openbao/pull/3625)]

<details>

<summary> <h2> What's Changed </h2></summary>

*(…release notes truncated — follow the link below for the full list)*

[Full release notes](https://github.com/openbao/openbao/releases/tag/v2.6.2)
