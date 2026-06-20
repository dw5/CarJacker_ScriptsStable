# Decompiler Sources & Script Layout

Two sets, by directory:

- **`original/`** — pristine **byte-faithful recovered source**: every one of the 16 scripts re-decompiled clean
  from the original `.luab` with the canonical decompiler (`94a02c7`), no hand-edits. This is the recovered game
  source. Each parse-checks under `luac4 -p`; the gameplay scripts round-trip green (DROP_LOCAL 0, EMPTY_IF = the 3
  genuine stubs). Caveats are per-file in the table below (intro JMPT artifact; menu "diamond" limitation).
- **`modified/`** — the **improvement-pass / playable** versions: only the scripts that diverge from `original/`
  (a feature, a hand-edit, or a still-needed workaround). The in-game-verified versions you actually play.
- **`hdb/`** — the hand-authored **HDB mod layer** (menu/level `*_s.lua` loaders + `Scripts\hdb\` / `hdbv2\`
  scripts: gui, cheats, bonus cars, teleport, music variants). Mirrors the game `Scripts\` paths 1:1. See
  [`hdb/README.md`](hdb/README.md). Not decompiler output — no `.luab` original.

**Playable set = `original/` overlaid with `modified/`** (for each script, use `modified/X.lua` if present, else
`original/X.lua`). To stage that into the game install:
`for f in original/*.lua; do cp "$f" "N:/GamesRE/CarJacker/Scripts/"; done; for f in modified/*.lua; do cp "$f" "N:/GamesRE/CarJacker/Scripts/$(basename $f | sed s/_hdb//)"; done`
(`english_hdb.lua` → the game's `english.lua`). The active dev loop still stages WIP edits via
`autothief_decomp/wip-scripts/deploy.sh`.

## `original/` — byte-faithful recovered source (all 16, decompiler `94a02c7`)

| File | Notes |
|------|-------|
| CarSettings.lua | clean; identical under 008e457→94a02c7 |
| Materials.lua | clean; identical under 008e457→94a02c7 |
| english.lua | clean string table (the hand-edited variant is `modified/english_hdb.lua`) |
| game.lua | clean; TAILCALL `return`, dropped `local prevcounter`, spawn-timeout compound-OR all auto |
| gamegui.lua | clean; dropped `local dispcode` + message/message2 merged-else auto |
| german.lua | clean string table |
| globals.lua | clean; dropped `local bestoy/bestoz` auto |
| intro.lua | clean BUT carries the JMPT-into-body negation artifact (byte-faithful but recompiles `NOT;JMPF`); may hang at load — `modified/intro.lua` is the playable version |
| menu.lua | clean; 2 genuine empty stubs (no bug); `driver/badguy/copnear` "diamond" control flow not bytecode-exact (decompiler limitation, task #7) |
| mimics.lua | clean; reversed multi-return + 6 dropped `local`s (head_Update) + compound-ORs all auto (was old 008e457) |
| polish.lua | clean string table |
| rush.lua | clean; faithful base WITHOUT the lock-on feature; same "diamond" limitation as menu |
| russian.lua | clean string table |
| sanjose.lua | clean; dropped `local progress` (=`tprogress`, the true slot value) + gangpikap respawn compound-OR auto |
| skeleton.lua | clean; dropped `local best_dist=max` + `local dy` auto |
| weather.lua | clean faithful base WITHOUT the extra music |

## `modified/` — improvement-pass / playable versions

| File | Base | Modification |
|------|------|--------------|
| rush.lua | `94a02c7` faithful + feature | GTA lock-on `ShowAimLock` reticle (draws on the auto-aim target each frame) |
| weather.lua | hand-authored | more music: `ActionTrackID=random(1,10)` (was 1,6), `ExploreTrackID=random(1,4)` (was 1,2) |
| intro.lua | `272713c` + hand-patch | only version that doesn't hang at load; `loadingcode and (loadingcode>0)` fade gate + `skip=1` moved to the outer else. Replace `original/intro.lua` when deploying |
| english_hdb.lua | hand-edited | renamed from english; deploys as the game's `english.lua` |

## Decompiler commits

- **`272713c`** (lua4-decompiler repo) — older. Only version with working intro.lua.
- **`210fd78`** (lua4-decompiler repo) — latest in that repo.
- **`008e457`** (autothief_decomp repo, `tools/lua4-decompile/lua4dec.py`) — earlier baseline for most stable scripts.
- **`c4e7889`** (autothief_decomp repo) — fixes the compound-OR / empty-if reconstruction bug. Verified via
  `tools/lua4-decompile/roundtrip_check.py`: empty_if 26→3 (3 residual are genuine stubs), zero regressions.

## History — the dropped-`local` bug (now fixed at source)

The dropped-`local` decompiler bug used to block several scripts from `original/`: in some functions the decompiler
omitted a `local` declaration, so a local became a GLOBAL (e.g. sanjose: a 9-local fn decompiled to 8, and
`GETLOCAL 6`/`SETLOCAL 6` became `GETGLOBAL`/`SETGLOBAL`), corrupting scope/values at runtime even though it
"round-tripped." Present in sanjose(1), skeleton(2), game(1), gamegui(1), globals(1), mimics(1). **Fixed at source in
`94a02c7`** (lazy local declaration) — DROP_LOCAL is now 0 across all 16, so every script has a faithful `original/`.
Lesson that still stands: **bytecode round-trip ≠ runnable** — smoke-test in-game before trusting a `modified/` change.

## Notes / TODO

- **menu.lua, rush.lua**: reviewed against bytecode (2026-06-21) — both are at *equal* fidelity under the OR-fix
  (menu 98==98, rush 226==226 normalized disasm diffs), and **neither version is bytecode-exact**. rush's
  `driver/badguy/copnear` region is a diamond (the body is reachable two ways) that cannot be expressed as either a
  nested-if or a flat OR, so the fixed flat-OR is actually wrong (`driver<=0` alone would trigger it) and the
  committed nested form is also wrong. Refreshing gives no objective gain, so **kept at `008e457`**. These regions are
  a genuine decompiler limitation (complex mixed comparison/boolean control flow) — would need manual correction for a
  bytecode-faithful version. (autothief_decomp task #7)
- **intro.lua**: still has the JMPT-into-body negation bug (`NOT; JMPF`); usable but not bytecode-faithful. (task #6)
- Refreshed/promoted scripts still need an **in-game smoke test** (replace `Scripts\*.lua` in the game install).

## 2026-06-21 batch — reversed-temp decompiler fix + hand-patches (in-game tested)
All gameplay scripts re-decompiled with the reversed multi-return assignment fix (no longer scrambles coordinates)
and re-patched. In-game-verified working: shooting, punch/melee, AI driving, taxi, intro (story + mission-complete
auto-advance), markers.
- game.lua, globals.lua, rush.lua, sanjose.lua, skeleton.lua: source = c4e7889 + reversed-temp fix + hand-patches
  (dropped locals: sanjose `progress`, skeleton `best_dist`/`dy`, globals `bestoy/bestoz`; game `Animate` return;
  rush has the GTA lock-on `ShowAimLock` reticle feature added).
- intro.lua: c4e7889 + loadingcode AND fade gate + skip=1 moved to outer else.
- KNOWN-STILL-BROKEN (see autothief_decomp/TODO.md): chinatown escort enemy spawn (mission 9, dropped block),
  mission-FAILED gui not appearing, vehicle-target arrow, game-over fade, wishlist (jack/camera/sprint).

## 2026-06-21 — decompiler-SOURCE fixes (hand-patches retired)
`lua4dec.py` `94a02c7` fixes four bug classes at the source, so the scripts below now decompile **clean with no
hand-patches** (the round-trip harness is green: DROP_LOCAL 7→0, EMPTY_IF 3 genuine stubs unchanged, DIFFS down
across the board — mimics 660→16, game 432→161, gamegui 201→40, globals 132→16, skeleton 372→108, sanjose 99→26):
1. **TAILCALL dropped `return`** — `return f(args)` no longer rendered as a bare `f(args)` (game `Animate`).
2. **Dropped `local`** — a local whose scope opens after its initializer push (read by the condition that opens
   its scope) is now declared lazily at its true startpc/slot, instead of leaking to a global. Clears all 7:
   game `prevcounter`, gamegui `dispcode`, globals `bestoy/bestoz`, mimics ×6, sanjose `progress`, skeleton
   `best_dist`/`dy`.
3. **Compound-OR with a leading comparison** — `if (a OP x) or (b and c)` no longer inverted to
   `if (a<=x) and (b) then if (c)` (sanjose gangpikap respawn, game spawn-timeout).
4. **Merged-else** — `if C then A else B end` no longer collapses to `if C then A; B; end` when a separate `if`
   follows on the next line (gamegui message/message2 → invisible no-time / Mission-Failed messages).

Promoted from `94a02c7` (re-decompiled, hand-patches dropped): game, gamegui, globals, mimics, sanjose, skeleton.
**IN-GAME VERIFIED 2026-06-21** (user ran the deployed scripts, "everything looks good"): sanjose gangpikap respawn/
teleport, game spawn-timeout (game:591), gamegui no-time messages incl. Mission-Failed, mimics head animation (was
the old reversed-multi-return 008e457), sanjose progress-bar first-frame value (`tprogress` — confirmed byte-faithful
against the original bytecode; the old hand-patch `0` was actually wrong).
