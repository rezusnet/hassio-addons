<!-- markdownlint-disable -->
<!-- Changelog entries mirror upstream release notes verbatim; upstream formatting is intentionally preserved, so style rules are disabled for this file. -->

## 2.7.0-r3 (2026-09-24)

- Update to upstream v2.7.0
- Upstream release notes: https://github.com/openbao/openbao/releases


## 2.6.2-r3 (2026-09-23)

Add-on-side revision (upstream stays **2.6.2**):

- Publishes a copy of `init.json` (root token + unseal key) to the add-on configuration folder (`addon_configs/2eafa696_openbao/init.json`), so it can be viewed and backed up from the Filebrowser add-on or the Samba `addon_configs` share without host console access. The live Raft database stays in the private data directory by design.
- New `addon_configs:rw` mapping.

## 2.6.2-r2 (2026-09-23)

Add-on-side revision (upstream stays **2.6.2**). The add-on options now mirror the configuration surface of the official [`openbao-helm`](https://github.com/openbao/openbao-helm) chart:

- New options: `log_format`, `ui`, `default_lease_ttl`, `max_lease_ttl`, `disable_mlock`, `dev_mode`, `dev_root_token`, `extra_args`, `telemetry_prometheus_retention`, `extra_config`, `ssl`.
- `extra_config` accepts a JSON object written as an additional server configuration file — the place for `seal` stanzas (KMS/transit auto-unseal).
- `telemetry_prometheus_retention` exposes Prometheus metrics at `/sys/metrics?format=prometheus` without authentication.
- New `ssl` option: native TLS listener using `/ssl/fullchain.pem` + `/ssl/privkey.pem`; certificate material is copied to `/data/openbao/tls` for the unprivileged server user and the CLI env switches to `https` + `BAO_CACERT`.
- Healthcheck is protocol-agnostic (works with and without `ssl`).
- DOCS.md: recipe for pinning OpenBao to the Home Assistant sidebar via `panel_iframe` (HA ingress cannot serve the OpenBao UI — absolute `/v1` API paths), plus KMS/transit auto-unseal examples.

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
