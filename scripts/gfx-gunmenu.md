# gfx-gunmenu

## Info

| Key | Value |
|-----|-------|
| **Name** | gfx-gunmenu |
| **Type** | Weapon Shop / Gun Menu |
| **Side** | Client + Server |
| **Framework** | ESX / NewESX / QB / NewQB |
| **FX Version** | Cerulean |
| **Lua 5.4** | Yes |
| **Escrow** | Yes (config.lua, client/*.lua, server/*.lua are open) |
| **NUI** | Yes |
| **GitHub** | https://github.com/gfx-fivem/gfx-gunmenu |

---

## Dependencies

- A supported framework: **ESX**, **NewESX**, **QBCore**, or **NewQB**
- (Optional) **ox_inventory** -- if `Config.OXInventory` is enabled
- (Optional) **gfx-inventory** -- if `Config.GFXInventory` is enabled

---

## Installation

### 1. Copy Files
Place the `gfx-gunmenu` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-gunmenu
```

### 3. Configure
Edit `config.lua` to match your framework and server setup.

---

## Configuration

All configuration is done in `config.lua`.

```lua
Config = {
    OXInventory = false,          -- Use ox_inventory for item management
    GFXInventory = false,         -- Use gfx-inventory for item management
    Framework = "newqb",          -- Framework: "esx" / "newesx" / "qb" / "newqb"
    BuyTime = 0,                  -- Time in seconds for the buy timer (0 = disabled)
    UseWithItem = true,           -- If true, weapons are given as inventory items; if false, weapons are given directly to the player ped
    RefundPercent = 0.5,          -- Percentage of money refunded when switching weapons in the same category (0.0 - 1.0)
    armorItemHash = "armor",      -- Item name used for armor matching
    ArenaOnly = false,            -- If true, the /openmenu command is disabled (menu can only be opened via events)

    InteractSettings = {
        command = {
            enabled = true,       -- Enable the chat command to open the menu
            name = "weaponmenu"   -- Command name (usage: /weaponmenu)
        },
        npc = {
            enabled = true,                          -- Enable NPC interaction point
            model = "s_m_m_ammucountry",             -- Ped model for the NPC
            text = "Press [~g~E~w~] to open the weapon menu",  -- Interaction prompt text
            coords = {                               -- NPC spawn locations (vector4: x, y, z, heading)
                vector4(-659.804, -936.421, 21.829 - 0.98, 134.34289550781)
            }
        }
    },

    Weapons = {
        ["category_key"] = {
            label = "Category Label",    -- Display name in the UI
            items = {
                {
                    name = "weapon_pistol",  -- Weapon hash name or item name
                    label = "Pistol",        -- Display name in the UI
                    price = 0,               -- Purchase price (uses cash)
                    amount = 50              -- (Optional) Used for equipment like armor to set the amount
                },
            }
        },
    }
}
```

### Default Weapon Categories

| Category | Label | Items |
|----------|-------|-------|
| `equipment` | Equipment | Half Kevlar, Kevlar, Stun Gun |
| `pistols` | Pistols | Pistol, Combat Pistol, Heavy Pistol, AP Pistol, Desert-Eagle |
| `midtier` | Mid-Tier | Pump Shotgun, Assault Shotgun, Micro SMG, SMG, Combat PDW |
| `rifles` | Rifles | Sniper Rifle, Marksman Rifle, Assault Rifle, Bullpup Rifle, Carbine Rifle |
| `grenades` | Grenades | Grenade, Molotov, Smoke Grenade, Flare |

### Weapon Switching and Refund Logic

When a player buys a new weapon in a non-grenade category, the previously selected weapon in that category is automatically removed. The player receives a partial refund based on `Config.RefundPercent`. For example, with `RefundPercent = 0.5`, switching from a $1000 weapon gives back $500.

Grenades are an exception -- they do not replace previous selections and stack instead.

---

## Exports

*No exports are created by this script.*

---

## Events

### Client Events

#### `gfx-gunmenu:openMenu`
Opens the weapon menu for the player. Can be triggered from client or server side.

**Client-side trigger (local):**
```lua
TriggerEvent("gfx-gunmenu:openMenu")
```
When triggered locally without parameters, the menu opens with default settings from config.

**Server-side trigger (to a specific player):**
```lua
TriggerClientEvent("gfx-gunmenu:openMenu", source, money, timer, freeze)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `money` | `number` or `nil` | Player's current cash amount to display in the UI |
| `timer` | `number` or `nil` | Override for `Config.BuyTime` -- time in seconds for the buy window |
| `freeze` | `boolean` or `nil` | If `true`, freezes the player in place for the duration of the timer and auto-closes the menu when time expires |

### Server Events

#### `gfx-gunmenu:deleteWeapons`
Removes all weapons that were purchased through the gun menu (items tagged with `gunpanel = true` metadata) from a player's inventory. Works with OX Inventory, QBCore (old and new), and uses metadata tagging to identify gun-menu items.

```lua
TriggerEvent("gfx-gunmenu:deleteWeapons", playerId)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `playerId` | `number` | The server ID of the player whose gun-menu weapons should be removed |

---

## Commands

| Command | Side | Description |
|---------|------|-------------|
| `/weaponmenu` | Server | Opens the weapon menu for the player who runs the command. Only available if `Config.InteractSettings.command.enabled` is `true`. The command name is configurable via `Config.InteractSettings.command.name`. |
| `/openmenu` | Client | Opens the weapon menu locally. Disabled when `Config.ArenaOnly` is `true`. |
| `/checkgun` | Server | Triggers `gfx-gunmenu:deleteWeapons` for the player who runs the command, removing all gun-menu purchased weapons from their inventory. |

---

## Features

- NUI-based weapon shop interface with categorized weapon browsing
- Multi-framework support: ESX, NewESX, QBCore, NewQB
- Multi-inventory support: ox_inventory, gfx-inventory, or native framework inventory
- Configurable NPC interaction points with 3D text prompts (press E to interact)
- Optional chat command to open the menu
- Weapon switching with automatic partial refund system
- Timer-based purchasing with optional player freeze
- Items vs direct weapon giving mode (`UseWithItem` toggle)
- Grenade stacking (grenades do not replace previous selections)
- Arena mode support (`ArenaOnly` flag to restrict command access)
- Equipment support including armor with configurable amounts
- Metadata tagging (`gunpanel = true`) for tracking purchased items
- Bulk weapon removal via `/checkgun` command or `deleteWeapons` event

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Menu does not open | Check that `Config.InteractSettings.command.enabled` or `Config.InteractSettings.npc.enabled` is `true`. Verify the framework setting matches your server. |
| Weapons not given after purchase | If `Config.UseWithItem` is `true`, ensure weapons are registered as items in your inventory system. If `false`, weapons are given directly to the ped. |
| NPC not spawning | Verify the `model` hash in `Config.InteractSettings.npc` is valid and the `coords` are set correctly. The NPC spawns at the configured `vector4` positions. |
| Refund not working | Refunds only apply when switching weapons within the same non-grenade category. Check that `Config.RefundPercent` is set to a value between 0 and 1. |
| "Not enough money" | The script checks the player's cash balance. Ensure the framework is configured correctly and the player has enough cash (not bank). |
| `/openmenu` does nothing | If `Config.ArenaOnly` is `true`, this command is intentionally disabled. Use the server-side command or NPC interaction instead. |
| ox_inventory items not tracked | Make sure `Config.OXInventory` is set to `true`. Items are tagged with `{gunpanel = true}` metadata for tracking. |
| `/checkgun` not removing items | This only works when `Config.UseWithItem` is `true` and items have the `gunpanel` metadata tag. Direct-ped weapons are not tracked. |
