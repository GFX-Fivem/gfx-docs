# GFX Stormbreaker

A FiveM script that adds Thor's Stormbreaker axe as a custom weapon with lightning particle effects, thunder sound, and weather manipulation. Admin-only access.

---

## Info

| Key | Value |
|---|---|
| **Resource Name** | `gfx-stormbreaker` |
| **Side** | Client & Server |
| **Framework** | Standalone |
| **Escrow** | No |

---

## Dependencies

| Dependency | Required | Purpose |
|---|---|---|
| [interact-sound](https://github.com/plunkettscott/interact-sound) | Optional | Plays thunder sound effect (`thor.ogg`) when summoning the weapon. Only needed if `Config.Sound = true`. |

---

## Installation

### 1. Copy Files
Place the `gfx-stormbreaker` folder into your server's resources directory.

### 2. Sound Setup (Optional)
If you want the thunder sound effect (`Config.Sound = true`):
1. Copy `thor.ogg` from the script folder into `interact-sound/client/html/sounds/`
2. Make sure `thor.ogg` is referenced in `interact-sound`'s `fxmanifest.lua`

### 3. server.cfg
```cfg
ensure gfx-stormbreaker
```

---

## Configuration

Configuration is located in `config.lua`.

### General Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Effect` | `boolean` | `true` | Enable lightning particle effects on the player when the weapon is equipped. |
| `Config.Sound` | `boolean` | `true` | Enable thunder sound effect when summoning the weapon. Requires `interact-sound` resource. |
| `Config.Key` | `number` | `68` | Control key index to summon/dismiss the Stormbreaker. Default `68` = `INPUT_SELECT_WEAPON_SPECIAL` (B key). See [FiveM Controls](https://docs.fivem.net/docs/game-references/controls/#controls). |

### Admin List

```lua
Config.Admin = {
    ['license:xxxxx'] = true,
}
```

| Option | Type | Description |
|---|---|---|
| `Config.Admin` | `table` | A whitelist of player identifiers allowed to use the Stormbreaker. Use `license:` identifier if no Steam Web API key is set in `server.cfg`, otherwise use the Steam hex identifier. |

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events for external scripts.* All events in this script are internal (used for client-server communication within the resource).

---

## Commands

| Command | Side | Permission | Description |
|---|---|---|---|
| `/create` | Client | Admin (via `Config.Admin`) | Spawns the Stormbreaker axe model in the air. The axe flies toward the player's hand, then equips the custom weapon. Includes a cinematic animation of the axe approaching the player. |
| `/effect` | Client | None (requires weapon equipped) | Toggles the lightning particle effect while holding the Stormbreaker weapon. If the effect is active, it stops it. If not active, it starts it. |

> **Note:** The `/create` command triggers a server-side admin check. Only players whose identifier is listed in `Config.Admin` will have the command work.

---

## Features

- **Custom Weapon** -- Adds `weapon_stormbreaker` as a fully functional melee weapon with custom model (`w_me_stormbreaker.ydr`), texture (`w_me_stormbreaker.ytd`), and weapon metadata (damage, animations, archetypes).
- **Axe Summon Animation** -- When using `/create`, a 3D axe model spawns in the air and flies toward the player's hand before equipping the weapon, mimicking Thor's summoning ability.
- **Keybind Summon** -- Press the configured key (default: B) while unarmed to summon the Stormbreaker directly (admin-only). If already equipped, pressing the key removes the weapon.
- **Lightning Particle Effects** -- When the weapon is equipped, a looping lightning particle effect (`scr_adversary_wheel_lightning`) plays on the player's right hand bone, visible to all players on the server.
- **Thunder Sound** -- A thunder sound effect (`thor.ogg`) plays for all players via the `interact-sound` resource when the weapon is summoned.
- **Weather Manipulation** -- When the weapon is summoned, artificial lights in the game world briefly turn off for 3 seconds, creating a dramatic dark-sky thunder effect for all players.
- **Admin-Only Access** -- Both the keybind and the `/create` command are restricted to players listed in `Config.Admin`.
- **Streamed Assets** -- Includes custom weapon meta files (`weapons.meta`, `weaponarchetypes.meta`, `weaponanimations.meta`, `pedpersonality.meta`) and streamed model/texture files.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Keybind or `/create` does nothing | Verify your player identifier is correctly added to `Config.Admin` in `config.lua`. Use `license:` if no Steam Web API key is set, or Steam hex if it is. |
| No sound plays when summoning | Ensure `interact-sound` is installed and running. Copy `thor.ogg` to `interact-sound/client/html/sounds/`. Set `Config.Sound = true`. |
| No lightning effect visible | Check that `Config.Effect = true` in `config.lua`. |
| Weapon model not appearing | Ensure the `stream/` folder contains `w_me_stormbreaker.ydr` and `w_me_stormbreaker.ytd`, and the `meta/` folder contains all four `.meta` files. Restart the server (not just the resource) for streamed assets to load. |
| `/effect` command does nothing | The command only works while the Stormbreaker weapon is currently selected/equipped. Equip it first using the keybind or `/create`. |
| Axe flies but weapon doesn't equip | Make sure you are unarmed (fists) when using the keybind or `/create`. The weapon will not equip if you have another weapon selected. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-stormbreaker
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
