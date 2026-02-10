# GFX Crafting

A crafting system for FiveM with a custom NUI interface, configurable recipes with material requirements, optional level gating, rarity tiers, and timed crafting progress.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-crafting` |
| **Frameworks** | All (framework-agnostic via `gfx-base`) |
| **Escrow** | Yes |

## Dependencies

| Resource | Purpose |
|----------|---------|
| `gfx-base` | Framework abstraction layer (player utilities, inventory, notifications, callbacks) |
| XP/Level system (optional) | If `Config.LevelSystem` is enabled, you need to integrate your own level system by editing the `GetPlayerLevel()` functions in `client/client_shared.lua` and `server/server_shared.lua` |

## Installation

1. Ensure `gfx-base` is installed and started before this resource.
2. Place the `gfx-crafting` folder in your server's resources directory.
3. Add `ensure gfx-crafting` to your `server.cfg` (after `gfx-base`).
4. Configure crafting recipes in `config.lua`.
5. If using the level system, edit `GetPlayerLevel()` in both `client/client_shared.lua` and `server/server_shared.lua` to return the actual player level from your XP system.

## Configuration

Configuration is done in `config.lua` via the `Config` table.

### General Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `LevelSystem` | boolean | `true` | Enable or disable level requirements for recipes. When disabled, all recipes are available regardless of player level. |
| `MaxLevel` | number | `100` | Maximum player level. Only relevant when `LevelSystem` is enabled. Should match your XP system's max level. |

### Recipe Definition (`Config.Items`)

Each recipe entry in the `Config.Items` table has the following fields:

| Field | Type | Description |
|-------|------|-------------|
| `item` | string | Item spawn name that will be given on successful craft |
| `label` | string | Display name shown in the crafting UI |
| `image` | string | Image filename displayed in the UI (placed in `nui/img/`) |
| `level` | number | Minimum player level required to craft (only enforced when `LevelSystem` is `true`) |
| `count` | number | Quantity of the item given on successful craft |
| `rarity` | string | Rarity tier for UI display. Values: `"legendary"`, `"epic"`, or other custom tiers |
| `craftTimer` | number | Time in seconds the crafting process takes |
| `requirements` | table | List of required materials (see below) |

### Material Requirements

Each entry in the `requirements` table:

| Field | Type | Description |
|-------|------|-------------|
| `item` | string | Required material item spawn name |
| `label` | string | Display name of the material |
| `image` | string | Image filename for the material |
| `count` | number | Quantity of this material needed |

### Example Recipe

```lua
{
    item = "weapon_heavypistol",
    label = "Heavy Pistol",
    image = "weapon_heavypistol.png",
    level = 5,
    count = 3,
    rarity = "legendary",
    craftTimer = 15,
    requirements = {
        [1] = {
            item = "iron",
            label = "Iron",
            image = "iron.png",
            count = 3,
        },
        [2] = {
            item = "copper",
            label = "Copper",
            image = "copper.png",
            count = 5,
        },
    }
}
```

### Locales

| Key | Default | Description |
|-----|---------|-------------|
| `crafted` | `"You crafted %sx %s!"` | Notification message on successful craft. First `%s` is count, second is item label. |

## Exports

This script does not expose any exports.

## Events

This script does not expose any public API events. All communication is handled internally via callbacks and NUI messages.

## Commands

| Command | Description |
|---------|-------------|
| `/opencraft` | Opens the crafting UI for the player. |

**Note:** The `opencraft` command has no built-in permission restriction. You may want to wrap it with your own permission checks or replace it with a target interaction (e.g., 3D text, ox_target) depending on your server setup.

## Features

- **Custom NUI Interface** -- Full crafting UI with item display, material requirements, rarity indicators, and a crafting progress timer.
- **Configurable Recipes** -- Define unlimited crafting recipes with multiple material requirements, custom images, and rarity tiers.
- **Level System** -- Optional level-gating for recipes. Players must reach a required level before they can craft certain items. Can be toggled off entirely.
- **Rarity Tiers** -- Visual rarity classification for items (e.g., legendary, epic) displayed in the UI.
- **Timed Crafting** -- Each recipe has a configurable crafting duration in seconds, shown as progress in the UI.
- **Server-Side Validation** -- All crafting checks (level requirements, material availability, item removal, and item granting) are performed server-side to prevent exploitation.
- **Framework Agnostic** -- Works with any framework (QBCore, ESX, Qbox, etc.) through the `gfx-base` abstraction layer.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Crafting UI does not open | Ensure `gfx-base` is started before `gfx-crafting` in your `server.cfg`. Check the F8 console for errors. |
| "You don't have enough materials" but player has items | Verify that the `item` spawn names in `Config.Items` and `requirements` match exactly with your inventory system's item names. |
| Level restriction not working | Ensure `Config.LevelSystem` is set to `true` and that you have edited `GetPlayerLevel()` in both `client/client_shared.lua` and `server/server_shared.lua` to return the real player level from your XP system. The default placeholder returns a hardcoded value. |
| Items not being given after craft | Check that the crafted item name exists in your inventory/items database. Check server console for any errors from `gfx-base` item functions. |
| Images not showing in UI | Ensure item images are placed in the `nui/img/` folder and the filenames in config match exactly (case-sensitive). |
