# gfx-hitmarker

## Info

| Key | Value |
|---|---|
| **Name** | gfx-hitmarker |
| **Description** | Displays 3D floating damage numbers when you hit another player, with optional kill siphon (health/armour restore) and sound effects. |
| **FX Version** | Cerulean |
| **Lua 5.4** | Yes |
| **Side** | Client + Server |
| **GitHub** | [gfx-fivem/gfx-hitmarker](https://github.com/gfx-fivem/gfx-hitmarker) |

---

## Dependencies

| Resource | Required | Purpose |
|---|---|---|
| **gfx-aio** | Optional | When running, the script respects the `showHitmarkers` toggle from gfx-aio settings. If disabled there, hitmarkers will not appear. |
| **InteractSound** | Optional | Plays a hit sound (`hit_marker.ogg`) on damage if `Config.Sound` is enabled. |

---

## Installation

### 1. Copy Files
Place the `gfx-hitmarker` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-hitmarker
```

> If you use `gfx-aio`, make sure it starts **before** `gfx-hitmarker`.

---

## Configuration

All configuration is in `config.lua`.

| Option | Type | Default | Description |
|---|---|---|---|
| `FatalIndex` | `number` | `6` | Index used to detect fatal hits from the damage event data. **Do not change.** |
| `TextDuration` | `number` | `2` | How long (in seconds) each floating damage number stays on screen. |
| `TextOffset` | `number` | `0.175` | Vertical offset between stacked damage numbers when multiple hits occur in quick succession. |
| `Sound` | `boolean` | `false` | If `true`, plays the `hit_marker` sound via InteractSound on each hit. Requires the InteractSound resource. |

### Siphon Mode

Siphon mode restores health and/or armour to the attacker when they get a **kill** (fatal hit).

| Option | Type | Default | Description |
|---|---|---|---|
| `SiphonMode.health.enabled` | `boolean` | `false` | Enable health restoration on kill. |
| `SiphonMode.health.amount` | `function(ped)` | `GetMaxHealth(ped)` | A function that returns the health value to set on kill. By default restores to max health. |
| `SiphonMode.health.TextColor` | `table` | `{r=255, g=0, b=0, a=255}` | RGBA color for damage text when the victim has no armour (red). |
| `SiphonMode.armour.enabled` | `boolean` | `false` | Enable armour restoration on kill. |
| `SiphonMode.armour.amount` | `number` | `0` | The armour value to set on kill. |
| `SiphonMode.armour.TextColor` | `table` | `{r=0, g=0, b=255, a=255}` | RGBA color for damage text when the victim has armour (blue). |

### Example Configuration
```lua
Config = {
    FatalIndex = 6,
    TextDuration = 2,
    TextOffset = 0.175,
    Sound = false,
    SiphonMode = {
        ["health"] = {
            ["enabled"] = false,
            ["amount"] = function(ped) return GetMaxHealth(ped) end,
            ["TextColor"] = {r = 255, g = 0, b = 0, a = 255}
        },
        ["armour"] = {
            ["enabled"] = false,
            ["amount"] = 0,
            ["TextColor"] = {r = 0, g = 0, b = 255, a = 255}
        }
    }
}
```

---

## Exports

*No exports found.*

---

## Events

*No public API events found.*

> The script internally listens to the native `CEventNetworkEntityDamage` game event and optionally triggers `InteractSound_CL:PlayOnOne` (belongs to the InteractSound resource), but it does not expose any custom events for other scripts.

---

## Commands

*No user-facing commands.*

---

## Features

- **3D Floating Damage Numbers** -- When you deal damage to another player, a floating number appears in the 3D world at the hit location showing the exact damage dealt. Numbers are positioned using a gameplay camera raycast for accurate placement.

- **Stacking Numbers** -- Multiple rapid hits stack vertically with a configurable offset (`TextOffset`), so each damage number is readable even during fast combat.

- **Armour-Aware Colors** -- Damage text color changes based on whether the victim has armour: blue text when the victim has armour, red text when they do not. Colors are fully configurable.

- **Auto-Cleanup** -- Damage numbers automatically disappear after the configured `TextDuration` (default 2 seconds). The rendering loop only runs while there are active texts, keeping performance impact minimal.

- **Kill Siphon** -- Optionally restore health and/or armour to the attacker upon getting a kill. The health amount can be a dynamic function (e.g., restore to max health).

- **Hit Sound** -- Optional hit sound effect via the InteractSound resource. Includes a bundled `hit_marker.ogg` audio file.

- **gfx-aio Integration** -- When `gfx-aio` is running, the hitmarker respects its `showHitmarkers` setting, allowing players to toggle hitmarkers on/off through the AIO menu.

- **Player-Only** -- Hitmarkers only appear for damage dealt to other players (not NPCs), and only when you are the attacker.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Hitmarkers not showing | Make sure `gfx-aio` (if running) has `showHitmarkers` enabled. Verify the script is started in `server.cfg`. |
| Damage numbers appear at wrong position | This can happen if the raycast doesn't hit a surface. The script casts from the gameplay camera forward. |
| No sound on hit | Set `Config.Sound = true` in `config.lua` and ensure the `InteractSound` resource is installed and running. |
| Siphon not restoring health/armour | Enable the relevant siphon options (`SiphonMode.health.enabled` / `SiphonMode.armour.enabled`) and set desired amounts. Siphon only triggers on **fatal** (killing) hits. |
| Blue text even when victim has no armour | The color is determined by `GetPedArmour(victim) > 0`. If the victim's armour just broke from your hit, the check may still read armour briefly. This is a timing nuance of the game event. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-hitmarker
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
