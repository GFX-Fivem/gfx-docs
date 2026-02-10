# gfx-pvpshop

## Info

| Key | Value |
|---|---|
| **Name** | gfx-pvpshop |
| **Version** | 1.0.0 |
| **Side** | Client + Server |
| **UI** | React (TypeScript) NUI |
| **Framework** | ESX / QBCore (auto-detected via gfx-lib) |

## Dependencies

| Dependency | Required | Purpose |
|---|---|---|
| `gfx-lib` | Yes | Framework detection, inventory/money abstraction |

## Installation

### 1. Copy Files

Place the `gfx-pvpshop` folder into your server's resources directory.

### 2. server.cfg

```cfg
ensure gfx-lib
ensure gfx-pvpshop
```

Make sure `gfx-lib` starts before `gfx-pvpshop`.

## Configuration

All configuration is done in `shared/config.lua`.

### Config Structure

```lua
Config = {
    Npcs = { ... },       -- Table of NPC shop definitions
    Currency = "$",       -- Currency symbol displayed in the UI ("$", "Points", etc.)
    Categories = {}       -- Auto-populated at runtime from item categories
}
```

### NPC Definition

Each entry in `Config.Npcs` defines a shop NPC with its location and available items.

```lua
Config.Npcs = {
    {
        coords = vector3(-533.6379, -223.6932, 37.6498),  -- NPC spawn position
        heading = 33.2140,                                  -- NPC facing direction
        ped = "s_m_m_security_01",                          -- Ped model name

        Items = {
            ["item_name"] = {
                name = "item_name",         -- Internal item name (vehicle spawn name or weapon hash)
                label = "Display Name",     -- Label shown in UI
                category = "Vehicles",      -- Category for filtering ("Vehicles", "Guns", etc.)
                image = "https://...",      -- Image URL for UI display
                buyPrice = 1000,            -- Purchase price
                sellPrice = 500,            -- Sell price (per unit)
                amount = 0                  -- Default amount (always 0, updated at runtime from inventory)
            },
        }
    }
}
```

### Item Categories

Items are grouped into categories based on the `category` field. An "All" category is automatically appended at runtime. The UI displays category filters sorted alphabetically.

**Default categories in the example config:**
- `Vehicles` -- Spawnable vehicles (e.g., Deluxo, Oppressor, Nightshark)
- `Guns` -- Weapons (e.g., WEAPON_ASSAULTRIFLE, WEAPON_COMBATMG_MK2)

### Currency

```lua
Config.Currency = "$"
```

Set to any string to customize the currency display in the UI. Use an empty string `""` if no currency symbol is needed.

### Adding a New NPC Shop

Add a new table entry to `Config.Npcs`:

```lua
Config.Npcs = {
    { -- Shop 1
        coords = vector3(-533.63, -223.69, 37.64),
        heading = 33.21,
        ped = "s_m_m_security_01",
        Items = { ... }
    },
    { -- Shop 2
        coords = vector3(100.0, 200.0, 30.0),
        heading = 180.0,
        ped = "a_m_y_hipster_01",
        Items = { ... }
    }
}
```

Each NPC shop operates independently with its own item catalog.

## Exports

*No exports found.*

This script does not register any exports via `exports('name', function)`.

## Events

*No public API events found.*

All events used are internal (NUI callbacks, framework lifecycle events, and the internal callback system). There are no public events intended for external script consumption.

## Commands

*No commands found.*

## Features

- **NPC Shop System** -- Configurable NPCs spawn at defined coordinates and serve as shop interaction points. NPCs are invincible and frozen in place.
- **React NUI Interface** -- Modern React-based UI for browsing, buying, and selling items with category filtering.
- **Buy and Sell** -- Players can purchase items/vehicles/weapons from NPCs and sell inventory items back. Selling removes all units of the item from inventory at once.
- **Sell All** -- One-click button to sell all sellable items from the player's inventory that match the current shop's catalog.
- **Category Filtering** -- Items are automatically grouped by their `category` field. An "All" filter is appended for viewing the full catalog.
- **Multi-Framework Support** -- Works with both ESX and QBCore via `gfx-lib` abstraction layer. Framework is auto-detected at startup.
- **Multi-Inventory Support** -- Compatible with qb-inventory, esx_inventoryhud, qs-inventory, codem-inventory, gfx-inventory, ox_inventory, and ps-inventory.
- **Live Inventory Sync** -- Item amounts in the shop UI reflect the player's current inventory count, updated on each shop open and after every transaction.
- **Proximity Interaction** -- Shop NPC displays a 3D text marker (`[ SHOP ]`) when the player is nearby. Press `E` (control ID 38) within 2.0 units to open the shop.
- **Cash-Based Economy** -- All transactions use the player's cash balance (not bank). Money is deducted on purchase and added on sale.
- **Clean Resource Stop** -- All spawned NPC peds are deleted when the resource stops.

## Troubleshooting

| Problem | Cause | Solution |
|---|---|---|
| NPC does not spawn | Ped model not found or coords are underground | Verify `ped` model name is valid and `coords` are correct in-game |
| Shop UI does not open | Player too far from NPC or NUI build missing | Ensure you are within 2.0 units of the NPC and `web/build/` folder exists |
| "Cannot buy" / money not deducted | Insufficient cash balance | Player needs enough cash (not bank) to cover `buyPrice * amount` |
| Items show amount 0 after buying | Inventory script not detected | Ensure a supported inventory resource is started before gfx-pvpshop |
| Framework not detected | gfx-lib not started or started after gfx-pvpshop | Ensure `ensure gfx-lib` comes before `ensure gfx-pvpshop` in server.cfg |
| Sell All does nothing | No matching items in inventory | Only items that exist in the current NPC's `Items` table can be sold |
| Images not loading in UI | Image URLs point to another resource | Ensure the resource referenced in image URLs (e.g., `gfx-aio`) is running |
