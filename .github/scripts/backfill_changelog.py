#!/usr/bin/env python3
"""Idempotent backfill: rewrite mechanical CHANGELOG.md entries with the real
upstream release notes.

Mechanical entries look like::

    ## 1.5.6-ls353 (2026-07-01)

    - Update to upstream 1.5.6-ls353

and get replaced with the upstream application's actual release notes (fetched
from GitHub). For LSIO-based add-ons, image rebuilds whose application version
did not change become a one-line "rebuild" entry instead. Manual entries (like
local fixes) are preserved verbatim; when such an entry introduces a new
application version, the upstream notes are appended below the manual text.

Re-running is safe: rewritten entries are no longer "mechanical", and entries
that already carry upstream notes are skipped.

Usage:
    backfill_changelog.py [--dry-run] [--only SLUG ...] [--max-chars N]

Reads GH_TOKEN/GITHUB_TOKEN from the environment for GitHub API access.
"""

import argparse
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from release_notes import (  # noqa: E402
    app_version,
    demote_headings,
    find_release,
    notes_entry,
    rebuild_entry,
    trim_body,
)

HDR_RE = re.compile(r"^## (.+?) \(([^)]+)\)\s*$")
MECH_RES = (
    re.compile(r"^- Update to upstream "),
    re.compile(r"^- Update to latest version from "),
    re.compile(r"^- Update to \S+ v?\d"),
)
LINT_HEADER = (
    "<!-- markdownlint-disable -->\n"
    "<!-- Changelog entries mirror upstream release notes verbatim; upstream "
    "formatting is intentionally preserved, so style rules are disabled for "
    "this file. -->"
)


def is_mechanical(body):
    lines = [line for line in body.splitlines() if line.strip()]
    return bool(lines) and all(any(rx.match(line) for rx in MECH_RES) for line in lines)


def has_upstream_notes(body):
    return "Full release notes](" in body or "### Upstream" in body


class NotesCache:
    def __init__(self, max_chars):
        self.max_chars = max_chars
        self.positive = {}
        self.negative = set()

    def get(self, repo, version):
        key = (repo, version)
        if key in self.positive:
            return self.positive[key]
        if key in self.negative:
            return None
        rel = find_release(repo, version)
        body = (rel or {}).get("body") or ""
        if rel and body.strip():
            body = trim_body(demote_headings(body.strip()), self.max_chars)
            url = rel.get("html_url") or f"https://github.com/{repo}/releases/tag/{rel['tag_name']}"
            result = (body, url)
            self.positive[key] = result
            return result
        self.negative.add(key)
        return None


def parse_changelog(path):
    with open(path, encoding="utf-8") as fh:
        lines = fh.read().splitlines()

    preamble, sections, current = [], [], None
    for line in lines:
        match = HDR_RE.match(line)
        if match:
            if current:
                sections.append(current)
            current = {
                "header": line,
                "version": match.group(1).strip(),
                "date": match.group(2).strip(),
                "body_lines": [],
            }
        elif current is None:
            preamble.append(line)
        else:
            current["body_lines"].append(line)
    if current:
        sections.append(current)

    for sec in sections:
        sec["body"] = "\n".join(sec["body_lines"]).strip("\n").strip()
    return preamble, sections


def fallback_url(updater, app_ver):
    template = updater.get("changelog_url") or ""
    if template:
        return template.replace("{version}", app_ver)
    return f"https://github.com/{updater['app_repo']}/releases"


def backfill(addon_dir, cache, dry_run):
    updater_path = os.path.join(addon_dir, "updater.json")
    changelog_path = os.path.join(addon_dir, "CHANGELOG.md")
    if not (os.path.isfile(updater_path) and os.path.isfile(changelog_path)):
        return None

    with open(updater_path, encoding="utf-8") as fh:
        updater = json.load(fh)
    if updater.get("paused"):
        return "skip (paused)"
    app_repo = updater.get("app_repo") or updater.get("upstream_repo") or ""
    if not app_repo:
        return f"skip (no app_repo)"
    app_name = updater.get("app_name") or app_repo.split("/")[-1]
    lsio = str(updater.get("tag_strategy", "")).startswith("lsio")
    build_suffix = updater.get("build_suffix") or ""

    preamble, sections = parse_changelog(changelog_path)
    if not sections:
        return "skip (no sections)"

    for sec in sections:
        sec["app"] = app_version(sec["version"], lsio, build_suffix)

    # Walk oldest -> newest: a section "introduces" its app version when the
    # older neighbor carried a different app version.
    prev_app = None
    for sec in reversed(sections):
        sec["introduces"] = sec["app"] != prev_app
        prev_app = sec["app"]

    stats = {"notes": 0, "rebuild": 0, "link": 0, "appended": 0, "kept": 0}
    for idx, sec in enumerate(sections):
        older = sections[idx + 1] if idx + 1 < len(sections) else None

        if is_mechanical(sec["body"]):
            if sec["introduces"]:
                notes = cache.get(app_repo, sec["app"])
                if notes:
                    body, url = notes
                    sec["body"] = notes_entry(
                        app_name, sec["app"], body, url,
                        full_version=sec["version"], lsio=lsio,
                    )
                    stats["notes"] += 1
                else:
                    sec["body"] = (
                        f"- Update to upstream {sec['version']}\n"
                        f"- Upstream release notes: {fallback_url(updater, sec['app'])}"
                    )
                    stats["link"] += 1
            elif lsio and older:
                sec["body"] = rebuild_entry(app_name, sec["app"], older["version"], sec["version"])
                stats["rebuild"] += 1
            else:
                stats["kept"] += 1
        else:
            if sec["introduces"] and not has_upstream_notes(sec["body"]):
                notes = cache.get(app_repo, sec["app"])
                if notes:
                    body, url = notes
                    sec["body"] = (
                        f"{sec['body']}\n\n### Upstream {app_name} {sec['app']}\n\n"
                        f"{body}\n\n[Full release notes]({url})"
                    )
                    stats["appended"] += 1
                else:
                    stats["kept"] += 1
            else:
                stats["kept"] += 1

    out_lines = list(preamble) if preamble else []
    header_present = bool(preamble) and "markdownlint-disable" in "\n".join(preamble[:3])
    if not header_present:
        out_lines = [LINT_HEADER, ""] + out_lines
    for sec in sections:
        out_lines.append(sec["header"])
        out_lines.append("")
        if sec["body"]:
            out_lines.append(sec["body"])
        out_lines.append("")
    content = "\n".join(out_lines).rstrip("\n") + "\n"

    if not dry_run:
        with open(changelog_path, "w", encoding="utf-8") as fh:
            fh.write(content)

    return stats


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--only", action="append", default=[], help="restrict to these slugs")
    parser.add_argument("--max-chars", type=int, default=3500)
    args = parser.parse_args()

    root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    cache = NotesCache(args.max_chars)

    for entry in sorted(os.listdir(root)):
        addon_dir = os.path.join(root, entry)
        if not os.path.isdir(addon_dir) or entry.startswith("."):
            continue
        if args.only and entry not in args.only:
            continue
        result = backfill(addon_dir, cache, args.dry_run)
        if result is None:
            continue
        if isinstance(result, dict):
            summary = ", ".join(f"{v} {k}" for k, v in result.items() if v)
            print(f"{entry:20s} {summary or 'nothing to do'}")
        else:
            print(f"{entry:20s} {result}")


if __name__ == "__main__":
    main()
