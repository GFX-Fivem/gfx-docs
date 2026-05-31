# gfx-proptest

A client-only developer debug tool for testing custom prop bones and embedded clip-dictionary animations (`PlayEntityAnim`) live in-game via chat commands.

---

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx-proptest` |
| **Frameworks** | Standalone (no framework required) |
| **Database** | None |
| **Lua version** | 5.4 |
| **Sides** | Client only |
| **NUI** | No |

---

## Dependencies

*None.* This resource has no external dependencies and does not require `gfx-lib`.

---

## Installation

### 1. Copy Files

Place the `gfx-proptest` folder into your server's resources directory.

### 2. server.cfg

```cfg
ensure gfx-proptest
```

No specific load order is required. This resource is intended for development/staging servers only — remove it from production.

### 3. Configure

There is no `config.lua`. All behavior is driven entirely by command arguments at runtime.

---

## Configuration

*None.* This resource has no configuration file. All options are passed as command arguments.

---

## Exports

*None.*

---

## Events

*None.* No public network events are registered or exposed.

---

## Commands

All commands are client-side and available to all players (no ACE restriction). Output appears in the F8 console and in the chat feed.

| Command | Arguments | Description |
|---------|-----------|-------------|
| `/spawnprop` | `<model> [distance]` | Spawns the named prop (model name or hash) in front of the player at the given distance (default: 2.0 units). The prop is frozen in place and faces the player. Deletes any previously spawned test prop first. Prints the handle and total bone count on success. |
| `/delprop` | — | Deletes the currently spawned test prop. |
| `/propanim` | `<animDict> <clip> [loop 0\|1] [speed]` | Loads `animDict` and calls `PlayEntityAnim` on the prop with the given `clip`. Pass `1` for `loop` to loop continuously; omit or pass `0` for a one-shot play. `speed` defaults to `1.0`. |
| `/stopanim` | `[animDict] [clip]` | Stops a clip on the prop via `StopEntityAnim`. If `animDict` / `clip` are omitted, defaults to the last dict and clip used by `/propanim`. |
| `/propphase` | `<animDict> <clip> <0.0–1.0>` | Plays the clip at speed `0.0` (frozen) and then seeks to the given phase, allowing inspection of bone positions at any point in the animation (e.g. door half-open). |
| `/bonecheck` | `<boneName>` | Looks up a bone by name on the spawned prop using `GetEntityBoneIndexByName`. Prints the bone index and world coordinates, and draws a red marker on the bone for 8 seconds. Reports "Bone not found" when the name does not match. |
| `/propinfo` | — | Prints the prop's handle, bone count, world coordinates, and heading. If a clip was previously played, also reports whether it is still playing and its current phase (`GetEntityAnimCurrentTime`). |
| `/propheading` | `<degrees>` | Rotates the spawned prop to the given heading. Useful for inspecting all sides without re-spawning. |
| `/prophelp` | — | Prints the full command list to chat. |

---

## Features

- **Argument-driven workflow** -- Nothing is hardcoded; model names, animation dictionaries, clip names, and phases are all supplied at runtime via command arguments
- **Prop lifecycle management** -- `/spawnprop` auto-deletes any previous test prop before spawning a new one; cleanup also runs on `onResourceStop`
- **Animation playback** -- Uses `PlayEntityAnim` / `StopEntityAnim` to drive embedded clip dictionaries (`.ycd`) attached to a custom prop, the only supported way to move rigged bones inside a single prop
- **Phase inspection** -- `/propphase` lets developers freeze a bone-driven animation at any point (0.0–1.0) to verify door-open angles, spiral positions, or any other intermediate bone state
- **Bone verification** -- `/bonecheck` confirms that a bone name exists on the model, reports its index and world position, and marks it with a visible 3D marker for 8 seconds
- **Anim dict validation** -- `loadDict` checks `DoesAnimDictExist` before requesting the dictionary and enforces a 5-second load timeout with a clear error message
- **Chat suggestions** -- All commands are registered with `chat:addSuggestion` so they appear in the chat autocomplete menu with argument hints
- **Zero dependencies** -- Standalone, client-only, no framework or inventory required; safe to drop into any server stack

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Invalid / not-streamed model" when running `/spawnprop` | The model is not loaded in the current streaming session. Ensure the custom prop's stream files (`.ydr`, `.ytyp`) are included in a resource that is started before `gfx-proptest`. |
| "Timed out loading model" | The model exists but did not finish streaming within 5 seconds. Check that the `.ydr` and `.ytyp` files are valid and the streaming resource is running. |
| "Anim dict does not exist" | The `.ycd` dictionary name is incorrect or its containing resource is not started. Verify the dictionary name and ensure the resource that streams the `.ycd` is ensured before `gfx-proptest`. |
| "Timed out loading anim dict" | The dictionary name is valid but did not load within 5 seconds. Check streaming resource health and retry. |
| `PlayEntityAnim` returns false | The clip name does not exist within the loaded dictionary, or the prop does not have matching bones. Double-check clip name spelling in OpenIV/CodeWalker. |
| `/bonecheck` reports "Bone not found" | The bone name is misspelled or does not exist in the prop's skeleton. Open the prop in CodeWalker to list all bone names, then retry. |
| Bone marker not visible after `/bonecheck` | The bone world position may be inside the prop mesh. Move the camera or use `/propheading` to view from another angle. The marker disappears automatically after 8 seconds. |
| Prop not cleaned up after `restart gfx-proptest` | `onResourceStop` fires the deletion. If the prop persists, re-run `/delprop` manually before restarting, or rejoin the session. |

---

## Source

- **GitHub:** [https://github.com/gfx-fivem/gfx-proptest](https://github.com/gfx-fivem/gfx-proptest)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
