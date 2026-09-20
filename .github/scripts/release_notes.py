#!/usr/bin/env python3
"""Shared upstream release-notes fetcher for the hassio-addons updater.

Used two ways:

* CLI (called from updater.sh) — decides what a CHANGELOG entry should say
  for a version bump:

      release_notes.py --repo OWNER/REPO --version NEW [--prev-version PREV] \
          [--lsio true|false] [--build-suffix S] [--app-name NAME] \
          [--max CHARS] [--url-file FILE]

  * LSIO image rebuild (app version unchanged)  -> exit 0, rebuild line
  * GitHub release found                        -> exit 0, notes block
  * nothing found                               -> exit 3 (caller falls back
                                                    to a mechanical line + link)

* Importable (used by backfill_changelog.py): app_version(), find_release(),
  notes_entry(), rebuild_entry(), upstream_block().
"""

import argparse
import json
import os
import re
import sys
import urllib.error
import urllib.parse
import urllib.request

API = "https://api.github.com"
CORE_RE = re.compile(r"\d+(?:\.\d+)+")


# --------------------------------------------------------------------------- #
# GitHub API
# --------------------------------------------------------------------------- #

def gh_api(path):
    """GET api.github.com/<path> as JSON (follows redirects, honors GH_TOKEN)."""
    req = urllib.request.Request(
        f"{API}/{path}",
        headers={
            "Accept": "application/vnd.github+json",
            "User-Agent": "hassio-addons-updater",
        },
    )
    token = os.environ.get("GH_TOKEN") or os.environ.get("GITHUB_TOKEN")
    if token:
        req.add_header("Authorization", f"token {token}")
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.loads(resp.read().decode())


def _norm(version):
    v = (version or "").strip()
    v = re.sub(r"^release-", "", v, flags=re.IGNORECASE)
    v = v.lstrip("vV")
    return v.strip()


def find_release(repo, version):
    """Find the GitHub release whose tag/name matches `version`.

    Tries exact tag lookups first (v-prefix and release- variants), then
    paginates the release list matching on normalized names. Stable releases
    are preferred over pre-releases.
    """
    candidates = []
    for cand in (version, f"v{version}", f"release-{version}"):
        if cand not in candidates:
            candidates.append(cand)

    for cand in candidates:
        try:
            return gh_api(f"repos/{repo}/releases/tags/{urllib.parse.quote(cand)}")
        except urllib.error.HTTPError as exc:
            if exc.code == 403:  # rate limited — do not hammer further
                print(f"WARNING: rate limited fetching {repo} {version}", file=sys.stderr)
                return None
            continue
        except (urllib.error.URLError, OSError):
            return None

    prerelease_match = None
    try:
        for page in range(1, 7):  # up to 600 releases back
            releases = gh_api(f"repos/{repo}/releases?per_page=100&page={page}")
            if not releases:
                break
            for rel in releases:
                for field in ("tag_name", "name"):
                    if _norm(rel.get(field) or "") == _norm(version):
                        if rel.get("prerelease"):
                            prerelease_match = prerelease_match or rel
                        else:
                            return rel
    except urllib.error.HTTPError as exc:
        print(f"WARNING: HTTP {exc.code} listing releases of {repo}", file=sys.stderr)
        return prerelease_match
    except (urllib.error.URLError, OSError) as exc:
        print(f"WARNING: {exc} listing releases of {repo}", file=sys.stderr)
        return prerelease_match
    return prerelease_match


# --------------------------------------------------------------------------- #
# Version helpers
# --------------------------------------------------------------------------- #

def app_version(version, lsio=False, build_suffix=""):
    """Extract the *application* version from a tracked upstream version.

    * LSIO images ("1.5.6-ls353", "5.2.2_v2.0.13-ls464", "10.11.8ubu2404-ls30"):
      the app version is the leading numeric core.
    * direct tracking: the whole version, minus a local build suffix and any
      leading "v" / "develop-" noise.
    """
    ver = (version or "").strip()
    ver = re.sub(r"^develop[-_]", "", ver, flags=re.IGNORECASE)
    if build_suffix and ver.endswith(build_suffix):
        ver = ver[: -len(build_suffix)]
    if lsio:
        match = CORE_RE.search(ver)
        return match.group(0) if match else ver
    return ver.lstrip("vV")


# --------------------------------------------------------------------------- #
# Rendering
# --------------------------------------------------------------------------- #

def demote_headings(body):
    """Push release-body headings below our `##` section headers."""
    out = []
    for line in body.splitlines():
        match = re.match(r"^(#{1,2})(\s+.*)$", line)
        out.append(f"###{match.group(2)}" if match else line)
    return "\n".join(out)


def trim_body(body, max_chars):
    body = body.strip()
    if len(body) <= max_chars:
        return body
    cut = body.rfind("\n\n", 0, max_chars)
    if cut < max_chars // 2:
        cut = body.rfind("\n", 0, max_chars)
    if cut < 0:
        cut = max_chars
    return body[:cut].rstrip() + "\n\n*(…release notes truncated — follow the link below for the full list)*"


def upstream_block(body, url):
    return f"{body}\n\n[Full release notes]({url})"


def notes_entry(app_name, app_ver, body, url, full_version=None, lsio=False):
    where = f" (image `{full_version}`)" if lsio and full_version else ""
    return f"Updated to upstream {app_name} **{app_ver}**{where}:\n\n{upstream_block(body, url)}"


def rebuild_entry(app_name, app_ver, prev_full, new_full):
    return (
        f"Upstream image rebuild (`{prev_full}` → `{new_full}`) — packaging / "
        f"base-image refresh, no application changes ({app_name} **{app_ver}**)."
    )


# --------------------------------------------------------------------------- #
# CLI
# --------------------------------------------------------------------------- #

def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--repo", required=True)
    parser.add_argument("--version", required=True, help="new tracked upstream version")
    parser.add_argument("--prev-version", default="", help="previously tracked version")
    parser.add_argument("--lsio", default="false", help="true for lsio-* tag strategies")
    parser.add_argument("--build-suffix", default="")
    parser.add_argument("--app-name", default="")
    parser.add_argument("--max", type=int, default=3500)
    parser.add_argument("--url-file", default="", help="write the resolved release URL here")
    args = parser.parse_args()

    lsio = args.lsio.lower() == "true"
    app_name = args.app_name or args.repo.split("/")[-1]
    app_new = app_version(args.version, lsio, args.build_suffix)
    app_prev = app_version(args.prev_version, lsio, args.build_suffix) if args.prev_version else ""

    if lsio and app_prev and app_prev == app_new:
        print(rebuild_entry(app_name, app_new, app_prev and args.prev_version, args.version))
        return 0

    rel = find_release(args.repo, app_new)
    body = (rel or {}).get("body") or ""
    if rel and body.strip():
        body = trim_body(demote_headings(body.strip()), args.max)
        url = rel.get("html_url") or f"https://github.com/{args.repo}/releases/tag/{rel['tag_name']}"
        if args.url_file:
            with open(args.url_file, "w", encoding="utf-8") as fh:
                fh.write(url)
        print(notes_entry(app_name, app_new, body, url, full_version=args.version, lsio=lsio))
        return 0
    return 3


if __name__ == "__main__":
    sys.exit(main())
