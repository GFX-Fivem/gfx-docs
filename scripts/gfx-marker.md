# gfx-marker

A radial-menu based world marker system for FiveM that lets players place temporary map markers visible to all squad members. Players open a radial wheel, select a marker style, and a 3D marker with distance indicator is placed at the aimed location in the world. Markers automatically expire after a configurable duration.

---

## Info

| Key | Value |
|---|---|
| **Author** | GFX Development |
| **FX Version** | Cerulean |
| **Game** | GTA 5 |
| **Lua 5.4** | Yes |
| **UI** | NUI (HTML/JS/CSS) |
| **Streaming Assets** | `markers.ytd` (custom marker textures) |
| **Escrow Ignore** | `config.lua`, `open.lua` |

---

## Dependencies

| Dependency | Required | Notes |
|---|---|---|
| **gfx-squad** or **gfx-squad-remake** | One of them | Provides `GetSquadMembers` export to determine which players receive the marker. If neither is present, you must add your own squad member logic in `open.lua`. |

---

## Installation

### 1. Copy Files
Place the `gfx-marker` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-squad
ensure gfx-marker
```
Make sure your squad resource (`gfx-squad` or `gfx-squad-remake`) starts before `gfx-marker`.

### 3. Customize (Optional)
Edit `open.lua` if you want to provide your own squad member logic instead of using `gfx-squad` / `gfx-squad-remake`. The function must return a table of player server IDs (e.g., `{1, 2, 3}`).

---

## Configuration

Configuration is defined in `config.lua`:

```lua
Config = {
    showTime = 10,         -- Duration (in seconds) before a marker expires
    DefaultKey = "Z",      -- Default keybind to open/close the radial marker menu
    PlaySound = true,      -- Play a confirmation beep when a marker is placed
    Markers = {            -- List of marker texture names (from markers.ytd)
        "marker1",
        "marker2",
        "marker3",
        "marker4",
        "marker5",
        "marker6",
        "marker7",
    }
}
```

| Option | Type | Default | Description |
|---|---|---|---|
| `showTime` | `number` | `10` | How many seconds a placed marker remains visible before auto-removal. |
| `DefaultKey` | `string` | `"Z"` | The default keyboard key to open/close the radial marker menu. Players can rebind this in FiveM keybind settings. |
| `PlaySound` | `boolean` | `true` | Whether to play a frontend confirmation sound when a marker is created. |
| `Markers` | `table` | 7 markers | A list of marker texture names from the streamed `markers.ytd` file. Each entry corresponds to a slot on the radial menu (up to 10 slots supported by the UI). |

---

## Exports

*No exports are created by this script.*

---

## Events

### Server Events (listened)

| Event | Parameters | Description |
|---|---|---|
| `gfx-marker:CreateMarker` | `_` (unused), `coords` (vector3), `entity` (number), `markerType` (string) | Triggered by the client when a player places a marker. The server uses `GetSquadMembers` to find all squad members and broadcasts the marker to them. |

### Client Events (listened)

| Event | Parameters | Description |
|---|---|---|
| `marker:CreateMarker` | `_` (unused), `coords` (vector3), `entity` (number), `src` (number - source player ID), `markerType` (string) | Received from the server to create and render a 3D marker at the specified coordinates for the client. The marker displays a distance indicator and auto-removes after `Config.showTime` seconds. |

> **Note:** These are internal events used between the client and server sides of this script. They are not designed as a public API for external scripts.

---

## Commands

| Command | Type | Default Key | Description |
|---|---|---|---|
| `+openMarker` / `-openMarker` | Key Mapping | `Z` | Hold to open the radial marker selection menu. Release to close it. While held, hover over a marker icon and release the key to place that marker at the aimed world position. |

Players can rebind this key through **Settings > Key Bindings > FiveM** in-game.

---

## Features

- **Radial Marker Menu** -- Hold the configured key to open a circular NUI menu with up to 10 marker style options. Hover over a marker and release the key to place it.
- **3D World Markers** -- Markers are rendered as 3D sprites in the game world using custom textures from the streamed `markers.ytd` asset.
- **Distance Indicator** -- Each placed marker displays a live-updating distance (in meters) as 3D text below the marker sprite.
- **Auto-Expiry** -- Markers automatically disappear after the configured `showTime` duration (default 10 seconds), and their associated blips are removed.
- **Squad Integration** -- Markers are shared with all members of the player's squad via `gfx-squad` or `gfx-squad-remake`. Only squad members can see placed markers.
- **Spam Protection** -- Players are limited to a maximum of 5 active markers at a time to prevent spam.
- **Sound Feedback** -- An optional confirmation beep plays when a marker is placed (configurable via `Config.PlaySound`).
- **Raycast Placement** -- Markers are placed at the exact world position the player is aiming at using a raycast from the gameplay camera (up to 1000 units range).
- **Custom Marker Textures** -- The script streams a custom `markers.ytd` texture dictionary with 7 marker styles included by default.
- **Rebindable Key** -- Uses FiveM's `RegisterKeyMapping` system so players can change the keybind in their settings.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Marker menu does not open | Make sure the key binding is set correctly. Check **Settings > Key Bindings > FiveM** for the "Marker Menu" binding. Ensure the script is started without errors in the server console. |
| Markers are not visible to squad members | Ensure `gfx-squad` or `gfx-squad-remake` is started **before** `gfx-marker`. Verify the squad resource's `GetSquadMembers` export returns a valid table of player server IDs. |
| No markers appear at all | If neither `gfx-squad` nor `gfx-squad-remake` is running and `open.lua` has not been customized, `GetSquadMembers` returns `nil` and no markers will be created. Add your own logic to `open.lua`. |
| Marker textures are missing/invisible | Verify that the `stream/markers.ytd` file exists and the marker names in `Config.Markers` match the texture names inside the YTD file. |
| Cannot place markers (spam limit) | Players can only have 5 active markers at once. Wait for existing markers to expire (default 10 seconds) before placing new ones. |
| Sound not playing on marker placement | Check that `Config.PlaySound` is set to `true` in `config.lua`. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-marker
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
