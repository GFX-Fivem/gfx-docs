# gfx-shop

NPC-based point shop system with a modern NUI interface. Players can buy and sell items (weapons, vehicles) through configurable NPC vendors using a points-based currency. Each item has separate buy and sell point values.

---

## Info

| Key | Value |
|---|---|
| **Resource Name** | `gfx-shop` |
| **FX Version** | `cerulean` |
| **Game** | `gta5` |
| **Lua 5.4** | Yes |
| **Escrow Ignore** | `config.lua` |
| **UI** | NUI (HTML/JS/CSS) |

---

## Dependencies

| Dependency | Purpose |
|---|---|
| `gfx-base` | Framework-agnostic utility layer (player data, inventory, money, notifications, callbacks) |

---

## Installation

### 1. Copy Files
Place the `gfx-shop` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-base
ensure gfx-shop
```

Make sure `gfx-base` starts **before** `gfx-shop`.

---

## Configuration

All configuration is in `config.lua`.

### Config.Items

Defines purchasable/sellable items grouped by category key. Each item has a name, label, and point costs for buying and selling.

```lua
Config.Items = {
    ["weapon"] = {
        {
            name = "weapon_carbinerifle",  -- Item/weapon spawn name
            label = "Carbine Rifle",       -- Display name in UI
            points = {
                buy = 2,                   -- Points required to buy
                sell = 1                   -- Points received when selling
            }
        },
        -- Add more weapon items...
    },
    ["vehicle"] = {
        {
            name = "vigilante",
            label = "Vigilante",
            points = {
                buy = 2,
                sell = 1
            }
        },
        -- Add more vehicle items...
    }
}
```

You can add custom category keys (e.g., `"food"`, `"tools"`) as long as the NPC references the same key.

### Config.NPC

Defines shop NPCs placed in the world. Each NPC is linked to an item category.

```lua
Config.NPC = {
    {
        coords = vec4(-535.799988, -212.500000, 37.799999, 310.7),  -- x, y, z, heading
        model = `s_m_y_ammucity_01`,  -- Ped model hash
        textData = {
            farText = "Open Shop",       -- Text shown at distance (< 7.5 units)
            closeText = "E - Open Shop"  -- Text shown when close (< 3.5 units)
        },
        key = "weapon"  -- Links to Config.Items category key
    }
}
```

### Locales

Notification messages displayed to the player.

```lua
Locales = {
    ["not_enough_money"] = "You dont have enough points!",
    ["not_enough_item"] = "You dont have enough item!",
    ["bought"] = "You bought %sx %s for %s",   -- count, label, total price
    ["sold"] = "You sold your items for %s points!"  -- total price
}
```

---

## Exports

*No exports are created by this script.*

---

## Events

### Client Events

#### `gfx-shop:OpenMenu`
Opens the shop NUI menu for a specific item category. Can be triggered from the server or other client scripts.

| Parameter | Type | Description |
|---|---|---|
| `key` | `string` | The item category key from `Config.Items` (e.g., `"weapon"`, `"vehicle"`) |

**Server-side usage:**
```lua
TriggerClientEvent("gfx-shop:OpenMenu", source, "weapon")
```

**Client-side usage:**
```lua
TriggerEvent("gfx-shop:OpenMenu", "vehicle")
```

---

## Commands

*No commands are registered by this script.*

---

## Features

- **NPC Vendors** -- Configurable peds spawned in the world with 3D text interaction prompts
- **Point-Based Economy** -- Items are bought and sold using points (uses cash money type via gfx-base)
- **Buy & Sell** -- Players can purchase items or sell owned items back to the shop
- **Category System** -- Items are organized by category keys (weapon, vehicle, or custom categories)
- **NUI Interface** -- Modern HTML/JS/CSS shop interface with buy/sell tabs
- **Dynamic Inventory** -- Sell tab dynamically shows only items the player currently owns with correct counts
- **Multiple NPCs** -- Support for multiple shop NPCs, each linked to a different item category
- **Invincible NPCs** -- Shop peds are frozen, invincible, and cannot be ragdolled or interrupted
- **Auto Cleanup** -- NPCs are automatically deleted when the resource stops

---

## Troubleshooting

| Problem | Solution |
|---|---|
| NPC does not spawn | Verify the `model` hash in `Config.NPC` is valid and the model exists in game files |
| "No item at gfx-npcshop:config" in server console | The item name sent from the UI does not match any `name` in `Config.Items` for that key. Check spelling |
| Shop menu does not open | Ensure `gfx-base` is started before `gfx-shop` and the player is within 3.5 units of the NPC |
| "You dont have enough points!" | The player's cash balance is less than the total point cost. Points use the `cash` money type via gfx-base |
| Sell tab shows no items | The player does not own any items that match the current category's `Config.Items` list |
| NUI not displaying | Check that the `nui/` folder contains `index.html`, `script.js`, `style.css`, and the `assets/` directory |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-shop
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
