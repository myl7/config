# myl7's Config

## Layout

-   `app/`: application config
-   `formatters/`: formatter config
-   `scripts/sync.py`: helper that copies files between the host and this repository based on a JSON mapping.
-   `mappings.json`: default mapping from host paths to their locations in the repo used by `sync.py`.

## Syncing Config

`scripts/sync.py` reads `mappings.json` and copies each host file into the matching location in the repo. Run it after making changes on the host to capture them in Git.

```bash
./scripts/sync.py            # host → repo (default)
./scripts/sync.py --to-host  # repo → host
./scripts/sync.py --dry-run  # preview without writing files
```

Flags of note:

-   `--map` lets you point to another mapping file.
-   `--project-root` changes the base directory for repo paths (defaults to the current directory).
-   `--verbose` prints each copy action; combine with `--dry-run` when debugging.

The script only uses the Python standard library, so any recent Python 3 should work.

## Adding New Files

1. Place the new config under `app/` (or another directory if it makes more sense).
2. Add a mapping entry to `mappings.json`, pairing the host path with the repo path.
3. Run `./scripts/sync.py --to-host` to push the repo copy back onto the system, or the default direction to pull updates from the host.
