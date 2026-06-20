# hdb/ — HDB mod layer

The "HDB" gameplay-mod layer for CarJacker, mirrored from the game install
`N:\GamesRE\CarJacker\Scripts\` so it's version-controlled alongside `original/` and `modified/`.
These are hand-authored mods (not decompiler output) — backed up here so a Scripts-folder wipe can't lose them.

## Layout = game `Scripts\` relative paths

This folder maps **1:1 onto the game's `Scripts\`** directory. To deploy, copy the contents into the install
preserving the subfolders:

| Here | Deploys to | Role |
|------|-----------|------|
| `menu_s.lua` | `Scripts\menu_s.lua` | loaded by `autoexec.cfg` (HDB menu hook: stealth/openworld, mostly commented) |
| `sanjose_s.lua` | `Scripts\sanjose_s.lua` | per-level HDB loader — `console("run scripts\hdb\…")` for gui/cheats/bonus cars |
| `hdb/*.lua` | `Scripts\hdb\*.lua` | the mod scripts: `hdb_gui`, `hdb_cheats`, `hdb_extrabonuscars`, `de_allmusic`, `hdb_nomusic`, `hdb_breaking_bosscameo`, `minload-sanjose` |
| `hdb/cheats/*` | `Scripts\hdb\cheats\*` | cheat sub-scripts (`tp`/`tp0`/`tp2` teleport, `anytimeOBJ`, `busdrv`, `he.al`) |
| `hdbv2/weather.lua` | `Scripts\hdbv2\weather.lua` | v2 weather variant |

## How it loads

`autoexec.cfg` runs the base scripts (see `../DECOMPILER_SOURCES.md`) then `menu_s.lua`. Each level's `*_s.lua`
stub (e.g. `sanjose_s.lua`) is loaded on level entry and `console("run …")`s the `hdb\` scripts it needs.

## Notes

- Byte-identical copy of the working in-game mods (2026-06-21); the `* - Copy.lua` backups in the install were
  intentionally excluded.
- These are NOT decompiler output and have no `.luab` original — hand-authored, edit directly.
- The base game scripts they sit on top of are the playable set = `../original/` overlaid with `../modified/`.
