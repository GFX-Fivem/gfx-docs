# gfx-pvphud

## Info

| Key | Value |
|-----|-------|
| **Name** | gfx-pvphud |
| **Author** | atiysu |
| **Version** | 1.0 |
| **Side** | Client |
| **Framework** | Standalone (no framework required) |
| **Description** | Custom PVP-oriented HUD replacement with health bar, segmented armor bar, weapon display, and ammo counter |

---

## Dependencies

None. This script is fully standalone and does not depend on any framework or external library.

---

## Installation

### 1. Copy Files
Place the `gfx-pvphud` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-pvphud
```

---

## Configuration

This script has no configuration file. All behavior is hardcoded in the client script.

---

## Exports

No exports are created by this script.

---

## Events

No public API events are registered or triggered by this script.

---

## Commands

| Command | Description |
|---------|-------------|
| `/test:a` | Debug command. Sets the player's armor to 100 and prints the armor value to the console. Intended for testing only. |

---

## Features

- **Custom Health Display** -- Displays current health as a percentage value and a horizontal health bar. The bar color is red (`rgb(250, 70, 71)`) with a glow effect. Health is calculated as a ratio of current health (minus the 100 base) to max health.
- **Segmented Armor Bar** -- Armor is displayed as 8 individual segments that fill proportionally based on the player's current armor value (0-100). Segments are styled in blue (`rgb(76, 107, 155)`).
- **Weapon Display** -- Shows the currently equipped weapon as an image. Supports 90+ weapons with individual PNG icons including all pistols, SMGs, shotguns, rifles, MGs, snipers, heavy weapons, throwables, and melee weapons.
- **Ammo Counter** -- Displays the current clip ammo count for armed weapons. When the player holds a weapon without ammo tracking (melee, unarmed), an infinity symbol image is shown instead.
- **Default HUD Suppression** -- Hides the following default GTA V HUD components every frame: Vehicle Name, Area Name, Vehicle Class, Street Name, Cash, MP Cash, and the default ammo display.
- **Custom Minimap** -- Includes a custom `minimap.gfx` stream file that replaces the default minimap appearance.
- **NUI-Based Interface** -- The HUD is rendered via an HTML/CSS/JS overlay using jQuery, with smooth CSS transitions on health and armor bar updates.
- **Update Interval** -- HUD data is refreshed every 100ms for a balance between performance and responsiveness.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| HUD not visible | Ensure the resource is started with `ensure gfx-pvphud` in your server.cfg. Check the F8 console for errors. |
| Weapon image not showing | Verify the `html/images/weapons/` folder contains PNG files for all weapons. The weapon name must match the hash lookup table in client.lua. |
| Default HUD elements still visible | Another script may be interfering. Make sure no other HUD script is re-enabling the hidden components. |
| Health bar not updating | Check if another resource is overriding `GetEntityHealth` or `GetPedMaxHealth` values. The script polls every 100ms. |
| Minimap looks unchanged | Ensure the `stream/minimap.gfx` file is present and no other resource is streaming a conflicting minimap GFX file. |
| Ammo shows infinity for all weapons | The `IsPedArmed(ped, 4)` check determines if ammo is tracked. If a custom weapon addon is not recognized, ammo may not display. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-pvphud
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
