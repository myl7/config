# config

My dotfiles, app config, and formatter config, synced between host and repo with a single script.

## Features

- Two-way sync between host system and this repository.
- JSON-based mapping for flexible file organization.
- Dry-run mode for safe previewing.
- No external dependencies (Python 3 standard library only).

## Get Started

Clone the repo and pull your host config into it:

```bash
git clone <repo-url> && cd config
./scripts/sync.py            # host -> repo
```

To push repo config back to the host:

```bash
./scripts/sync.py --to-host  # repo -> host
```

Preview before writing:

```bash
./scripts/sync.py --dry-run
```

## Config

### mappings.json

An array of objects, each mapping a host path to a repo path:

```json
[
  { "hostPath": "~/.zshrc", "projPath": "app/.zshrc" }
]
```

- `hostPath`: absolute or `~`-prefixed path on the host.
- `projPath`: path relative to the project root.

### sync.py flags

| Flag | Description |
|------|-------------|
| `--to-host` | Reverse direction: copy from repo to host. |
| `--dry-run` | Preview actions without writing files. |
| `--map FILE` | Use a different mapping file (default: `mappings.json`). |
| `--project-root DIR` | Set the base directory for repo paths (default: current directory). |
| `--verbose` | Print each copy action. |

### Adding new files

1. Place the config file under `app/` (or another fitting directory).
2. Add an entry to `mappings.json`.
3. Run `./scripts/sync.py` or `./scripts/sync.py --to-host` as needed.

## Repository Layout

- `app/`: application config (shell, editor, input method, SSH, etc.).
- `formatters/`: formatter config (clang-format, prettier, ruff).
- `scripts/sync.py`: the sync script.
- `mappings.json`: default host-to-repo path mapping.

## License

Copyright (c) 2025 Yulong Ming <i@myl.moe>

MIT License
