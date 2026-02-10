# Inventory Integration

GFX scripts interact with your inventory system through `gfx-lib`'s server-side inventory bridge. This means you don't need to edit script code when switching inventories.

## How It Works

`gfx-lib` detects your inventory on startup and stores it in `Utils.InventoryName`. All inventory operations (`AddItem`, `RemoveItem`, `HasItem`, `GetItemCount`, `GetInventory`) are routed through framework-specific adapter functions.

## Supported Inventories

| Inventory | Resource Name | AddItem | RemoveItem | HasItem | GetItemCount | GetInventory |
|---|---|---|---|---|---|---|
| QBCore Inventory | `qb-inventory` | Yes | Yes | Yes | Yes | Yes |
| ESX Inventory HUD | `esx_inventoryhud` | Yes | Yes | Yes | Yes | Yes |
| OX Inventory | `ox_inventory` | Yes | Yes | Yes | Yes | Yes |
| QS Inventory | `qs-inventory` | Yes | Yes | Yes | Yes | Yes |
| Codem Inventory | `codem-inventory` | Yes | Yes | Yes | Yes | Yes |
| PS Inventory | `ps-inventory` | Yes | Yes | Yes | Yes | Yes |
| Tgiann Inventory | `tgiann-inventory` | Yes | Yes | Yes | Yes | Yes |
| GFX Inventory | `gfx-inventory` | Yes | Yes | Yes | Yes | Yes |

## Server-Side API

All functions are available via `modules` on the server:

```lua
local modules = exports['gfx-lib']:getModules()

-- Add item to player
modules.AddItem(source, "water", 1)

-- Remove item from player
modules.RemoveItem(source, "water", 1)

-- Check if player has item
local has = modules.HasItem(source, "water", 1) -- returns boolean

-- Get count of specific item
local count = modules.GetItemCount(source, "water") -- returns number

-- Get full inventory
local items = modules.GetInventory(source) -- returns table
```

### Function Signatures

#### `modules.AddItem(source, item, count, slot?, metadata?)`

| Parameter | Type | Description |
|---|---|---|
| `source` | number | Player server ID |
| `item` | string | Item name |
| `count` | number | Amount to add |
| `slot` | number? | Target slot (optional, inventory-dependent) |
| `metadata` | table? | Item metadata (optional, ox_inventory/qs-inventory) |

#### `modules.RemoveItem(source, item, count, slot?, metadata?)`

| Parameter | Type | Description |
|---|---|---|
| `source` | number | Player server ID |
| `item` | string | Item name |
| `count` | number | Amount to remove |
| `slot` | number? | Target slot (optional) |
| `metadata` | table? | Item metadata (optional) |

#### `modules.HasItem(source, item, count)`

Returns `boolean` — whether the player has at least `count` of the item.

#### `modules.GetItemCount(source, item)`

Returns `number` — the total count of the item in the player's inventory.

#### `modules.GetInventory(source)`

Returns `table` — the player's full inventory. Items are normalized to have both `.count` and `.amount` fields.

## Money API

`gfx-lib` also bridges money operations:

```lua
local modules = exports['gfx-lib']:getModules()

modules.GetMoney(source, "cash")            -- returns number
modules.AddMoney(source, 1000, "cash")      -- adds $1000 cash
modules.RemoveMoney(source, 500, "bank")    -- removes $500 from bank
modules.HasMoney(source, 1000, "cash")      -- returns boolean
```

Money types:
- QBCore: `"cash"`, `"bank"`, `"crypto"`
- ESX: `"money"` (cash), `"bank"`

> **Note:** `gfx-lib` normalizes money types between frameworks. `"cash"` and `"money"` are interchangeable.

## GFX Inventory

If you use `gfx-inventory` as your inventory system, GFX scripts automatically integrate with it. `gfx-inventory` uses a stash-based system where each inventory type is a named stash (`"inventory"`, `"stash"`, etc.).

See [gfx-inventory documentation](../core/gfx-inventory.md) for details.

## Adding Items to Your Inventory

When a GFX script requires custom items, you need to register them in your inventory system. The method depends on your inventory:

**QBCore (qb-core/shared/items.lua):**
```lua
['gfx_example_item'] = {
    name = 'gfx_example_item',
    label = 'Example Item',
    weight = 100,
    type = 'item',
    image = 'gfx_example_item.png',
    unique = false,
    useable = true,
    shouldClose = true,
    description = 'An example item'
},
```

**OX Inventory (ox_inventory/data/items.lua):**
```lua
['gfx_example_item'] = {
    label = 'Example Item',
    weight = 100,
    stack = true,
    close = true,
    description = 'An example item'
},
```

Each script's documentation lists the specific items it requires.
