# Decompiler Sources

| File | Source | Notes |
|------|--------|-------|
| CarSettings.lua | `008e457` | autothief_decomp repo |
| Materials.lua | `008e457` | autothief_decomp repo |
| english_hdb.lua | hand-edited | Renamed from english.lua, no decompiler match |
| game.lua | `008e457` | autothief_decomp repo |
| gamegui.lua | `008e457` | autothief_decomp repo |
| globals.lua | `008e457` | autothief_decomp repo |
| intro.lua | `272713c` | lua4-decompiler repo — only version that doesn't hang/crash |
| menu.lua | `008e457` | autothief_decomp repo |
| mimics.lua | `008e457` | autothief_decomp repo |
| rush.lua | `008e457` | autothief_decomp repo |
| weather.lua | `008e457` + hand-edited | Added more music support on top of 008e457 base |

## Missing files

Not yet in ScriptsStable:

- sanjose.lua - mission logic etc
- skeleton.lua - ragdoll physics etc

## Decompiler commits

- **`272713c`** (lua4-decompiler repo) — older. Only version with working intro.lua.
- **`210fd78`** (lua4-decompiler repo) — latest in that repo.
- **`008e457`** (autothief_decomp repo, `tools/lua4-decompile/lua4dec.py`) — source for most stable scripts.
