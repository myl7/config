#!/usr/bin/env python3
"""
sync.py — sync dotfiles between host and project using a JSON mapping.

Mapping JSON example (default: mappings.json in the current directory):
[
  { "hostPath": "~/.zshrc", "projPath": "app/.zshrc" },
  { "hostPath": "~/.ssh/config", "projPath": "app/ssh/config", "script": "app/ssh/config.sh" },
]

Usage:
  # Host -> Project (default direction)
  ./scripts/sync.py

  # Project -> Host
  ./scripts/sync.py --to-host

  # Use a different mapping file and project root
  ./scripts/sync.py -m path/to/mappings.json --project-root /path/to/repo

Tips:
  - Use --dry-run to preview actions
  - Use --verbose for more logs
"""

from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import tempfile
from pathlib import Path
from typing import List, Dict


def load_mapping(path: Path) -> List[Dict[str, str]]:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        raise SystemExit(f"[error] mapping file not found: {path}")
    except json.JSONDecodeError as e:
        raise SystemExit(f"[error] failed to parse JSON {path}: {e}")

    if not isinstance(data, list):
        raise SystemExit("[error] mapping must be a JSON array of objects")

    for i, item in enumerate(data):
        if not isinstance(item, dict):
            raise SystemExit(f"[error] mapping[{i}] is not an object")
        if "hostPath" not in item or "projPath" not in item:
            raise SystemExit(f"[error] mapping[{i}] missing 'hostPath' or 'projPath'")
        if not isinstance(item["hostPath"], str) or not isinstance(item["projPath"], str):
            raise SystemExit(f"[error] mapping[{i}] paths must be strings")
        if "script" in item and not isinstance(item["script"], str):
            raise SystemExit(f"[error] mapping[{i}] 'script' must be a string")
    return data


def resolve_paths(item: Dict[str, str], project_root: Path, to_host: bool) -> tuple[Path, Path]:
    host = Path(item["hostPath"]).expanduser()
    proj = (project_root / item["projPath"]).resolve()
    return (proj, host) if to_host else (host, proj)


def copy_one(src: Path, dst: Path, dry_run: bool, verbose: bool) -> bool:
    if not src.exists():
        print(f"[skip] source missing: {src}")
        return False
    dst.parent.mkdir(parents=True, exist_ok=True)
    if verbose:
        print(f"[copy] {src}  ->  {dst}")
    if not dry_run:
        try:
            shutil.copy2(src, dst)
        except IsADirectoryError:
            print(f"[error] source is a directory (not supported): {src}")
            return False
        except Exception as e:
            print(f"[error] failed to copy {src} -> {dst}: {e}")
            return False
    return True


def filter_one(src: Path, dst: Path, script: Path, dry_run: bool, verbose: bool) -> bool:
    if not src.exists():
        print(f"[skip] source missing: {src}")
        return False
    if not script.exists():
        print(f"[error] script missing: {script}")
        return False
    if verbose:
        print(f"[filter] {src}  ->  {script}  ->  {dst}")
    if dry_run:
        return True

    temporary_path: Path | None = None
    try:
        dst.parent.mkdir(parents=True, exist_ok=True)
        descriptor, temporary_name = tempfile.mkstemp(dir=dst.parent, prefix=f".{dst.name}.")
        temporary_path = Path(temporary_name)
        with os.fdopen(descriptor, "wb") as output_file, src.open("rb") as input_file:
            subprocess.run([script], stdin=input_file, stdout=output_file, check=True)
        shutil.copystat(src, temporary_path)
        temporary_path.replace(dst)
    except IsADirectoryError:
        print(f"[error] source or destination is a directory: {src} -> {dst}")
        return False
    except (OSError, subprocess.CalledProcessError) as e:
        print(f"[error] failed to filter {src} with {script}: {e}")
        return False
    finally:
        if temporary_path is not None:
            temporary_path.unlink(missing_ok=True)
    return True


def main() -> None:
    p = argparse.ArgumentParser(
        description="Sync files between host and project using a JSON mapping.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    p.add_argument("-m", "--map", default="mappings.json", help="Path to the JSON mapping file.")
    p.add_argument("--project-root", default=".", help="Project root used to resolve each 'projPath'.")
    p.add_argument(
        "-t", "--to-host", action="store_true", help="Sync from project to host (default is host to project)."
    )
    p.add_argument("-n", "--dry-run", action="store_true", help="Show what would be copied, without writing.")
    p.add_argument("-v", "--verbose", action="store_true", help="Verbose output.")
    args = p.parse_args()

    mapping_path = Path(args.map)
    project_root = Path(args.project_root).resolve()

    direction = "project → host" if args.to_host else "host → project"
    print(f"[info] direction: {direction}")
    print(f"[info] mapping:   {mapping_path}")
    print(f"[info] project:   {project_root}")
    if args.dry_run:
        print("[info] dry-run:   enabled")

    mapping = load_mapping(mapping_path)

    copied = 0
    total = len(mapping)
    for i, item in enumerate(mapping, start=1):
        src, dst = resolve_paths(item, project_root, args.to_host)
        if args.verbose:
            print(f"[{i}/{total}] {src} -> {dst}")
        script = item.get("script")
        if script and not args.to_host:
            script_path = (project_root / script).resolve()
            synced = filter_one(src, dst, script_path, args.dry_run, args.verbose)
        else:
            synced = copy_one(src, dst, args.dry_run, args.verbose)
        if synced:
            copied += 1

    print(f"[done] {copied}/{total} item(s) {'would be ' if args.dry_run else ''}synced.")


if __name__ == "__main__":
    main()
