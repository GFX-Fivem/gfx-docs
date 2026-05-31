# GFX Inventory

A standalone inventory system for FiveM with weight-based slot management, a 6-slot hotbar, stash locations, weapon equipping, and a vanilla NUI interface — no framework dependency required.

---

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx-inventory` |
| **Frameworks** | Standalone (no framework bridge required) |
| **Database** | MySQL (oxmysql) |
| **Lua version** | 5.4 |
| **Sides** | Client + Server |
| **NUI** | Yes (vanilla HTML / CSS / JS) |

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| **oxmysql** | Database driver for loading, saving, and creating player inventory records |

---

## Installation

### 1. Import the SQL table

Run `install.sql` against your database, or execute the statement manually:

```sql
CREATE TABLE IF NOT EXISTS `inventory` (
    `identifier` VARCHAR(60) NOT NULL,
    `inventory` LONGTEXT DEFAULT '[]',
    `protected` LONGTEXT DEFAULT '[]',
    `stash` LONGTEXT DEFAULT '[]',
    `hotbar` LONGTEXT DEFAULT '[]',
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 2. Copy files

Place the `gfx-inventory` folder into your server's resources directory.

### 3. server.cfg

```cfg
ensure oxmysql
ensure gfx-inventory
```

### 4. Configure

Edit `config/serverconfig.lua` and `config/clientconfig.lua` to match your server's needs (weight limits, stash coordinates, admin identifiers, default items). Edit `config/items.lua` to define your item catalogue.

---

## Configuration

### Client config (`config/clientconfig.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `OpenCommand` | string | `"inventory"` | Chat command (and key mapping name) used to open/close the inventory UI |
| `InteractKey` | number | `46` | Control index for interacting with stash locations (46 = E) |
| `Stashes.coords` | table | two `vector3` entries | World coordinates of static stash locations players can open |
| `Stashes.textData.closeText` | string | `"[E] - Open Stash"` | 3D text shown when within close distance of a stash |
| `Stashes.textData.farText` | string | `"Open Stash"` | 3D text shown when within far distance of a stash |
| `Stashes.textData.closeDist` | number | `2.0` | Distance (metres) at which the player can press E to open the stash |
| `Stashes.textData.farDist` | number | `7.0` | Distance (metres) at which the stash label becomes visible |
| `DeathSettings.deathTime` | number | `4` | Seconds the inventory stays disabled after a player dies |

### Server config (`config/serverconfig.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `DefaultWeaponAmmo` | number | `999` | Ammo count assigned to every newly added weapon item. Set to `0` for empty-on-spawn. |
| `InventoryTypes.inventory.maxWeight` | number | `100` | Maximum carry weight (kg) of the main inventory |
| `InventoryTypes.protected.maxWeight` | number | `100` | Maximum carry weight (kg) of the protected inventory |
| `InventoryTypes.stash.maxWeight` | number | `100` | Maximum carry weight (kg) of the stash inventory |
| `InventoryTypes.inventory.label` | string | `"Inventory"` | Display label for the main inventory panel |
| `InventoryTypes.protected.label` | string | `"Protected"` | Display label for the protected inventory panel |
| `InventoryTypes.stash.label` | string | `"Stash"` | Display label for the stash inventory panel |
| `Admins` | table | `{}` | Map of identifier strings to `true`. Admins can use console commands in-game and can open other players' inventories. Example: `["license:abc123"] = true` |
| `DeleteBlockedItems` | table | `{ ["deluxo"] = false }` | Items whose delete (drop) action is blocked. Set the item's value to `true` to prevent deletion. |
| `DefaultItems` | table | `{}` | Items given to a player on first inventory creation. Each entry: `{ name = "itemName", count = N }`. Skipped if the player already owns the item (idempotent). |
| `RemoveInventoriesWhenDead.bool` | function | returns `true` | Function receiving the victim's source; return `true` to clear inventories on death. |
| `RemoveInventoriesWhenDead.types` | table | `{ "inventory" }` | Inventory types cleared on death. Add `"protected"` to also wipe the protected slot. |

### Items catalogue (`config/items.lua`)

Each key in the `Items` table is the item name. Fields per item:

| Field | Type | Description |
|-------|------|-------------|
| `label` | string | Human-readable display name |
| `weight` | number | Weight in kg per unit |
| `type` | string | `"item"`, `"weapon"`, or `"vehicle"` |
| `useItemInfo` | boolean | Whether per-instance metadata (e.g. weapon ammo/attachments) is stored |
| `rarity` | string or `false` | Rarity glow effect on the inventory slot. Any string enables the effect; `false` disables it. |

Item images are resolved automatically as `nui/assets/<itemName>.png`.

---

## Exports

### Shared (`config/items.lua` — available on both sides)

#### `Items`

Returns the full item catalogue table.

```lua
local items = exports['gfx-inventory']:Items()
```

#### `GetItems`

Alias for `Items()`.

```lua
local items = exports['gfx-inventory']:GetItems()
```

---

### Client exports

#### `isOpened`

Returns `true` if the inventory NUI is currently open.

```lua
local open = exports['gfx-inventory']:isOpened()
```

---

#### `disableInventory`

Prevents (or re-allows) the player from opening the inventory.

```lua
exports['gfx-inventory']:disableInventory(bool)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `bool` | boolean | `true` to disable, `false` to re-enable |

---

#### `OpenInventory`

Opens the inventory UI for the given inventory type.

```lua
exports['gfx-inventory']:OpenInventory(inventoryType)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `inventoryType` | string | One of the configured inventory types: `"inventory"`, `"protected"`, `"stash"` |

**Example:**
```lua
exports['gfx-inventory']:OpenInventory("protected")
```

---

#### `HasItem` (client)

Checks whether the local player has at least `count` of an item in a given inventory.

```lua
local found = exports['gfx-inventory']:HasItem(inventoryType, itemName, count)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `inventoryType` | string | Inventory type to check |
| `itemName` | string | Item name as defined in `config/items.lua` |
| `count` | number | Minimum quantity required |

**Returns:** `boolean`

**Example:**
```lua
if exports['gfx-inventory']:HasItem("inventory", "medkit", 1) then
    -- player has at least one medkit
end
```

---

### Server exports

#### `GetInventoryWeight`

Returns the current total weight (kg) of a player's inventory.

```lua
local weight = exports['gfx-inventory']:GetInventoryWeight(source, inventoryType)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |
| `inventoryType` | string | Inventory type to check |

**Returns:** `number`

---

#### `HasInventoryGotSpaceForItem`

Checks whether adding `itemCount` units of `itemName` would stay within the weight limit.

```lua
local hasSpace = exports['gfx-inventory']:HasInventoryGotSpaceForItem(source, inventoryType, itemName, itemCount)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |
| `inventoryType` | string | Inventory type to check |
| `itemName` | string | Item name |
| `itemCount` | number | Quantity to check |

**Returns:** `boolean`

---

#### `HasItem` (server)

Checks whether a player has at least `itemCount` of an item.

```lua
local found = exports['gfx-inventory']:HasItem(source, inventoryType, itemName, itemCount)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |
| `inventoryType` | string | Inventory type |
| `itemName` | string | Item name |
| `itemCount` | number | Minimum quantity (optional — omit to return the item data instead of a boolean) |

**Returns:** `boolean` (or the item data table when `itemCount` is omitted and the item exists)

---

#### `AddItem`

Adds an item to a player's inventory.

```lua
local success = exports['gfx-inventory']:AddItem(source, inventoryType, itemName, itemCount, info, forceAdd)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |
| `inventoryType` | string | Inventory type to add into |
| `itemName` | string | Item name as defined in `config/items.lua` |
| `itemCount` | number | Quantity to add |
| `info` | table\|nil | Per-instance metadata (used when `useItemInfo = true`). Pass `nil` for standard items. |
| `forceAdd` | boolean\|nil | If `true`, bypasses the weight check and always adds the item |

**Returns:** `boolean` — `true` on success, `false` if the item is unknown or there is no space (and `forceAdd` is not set).

**Example:**
```lua
exports['gfx-inventory']:AddItem(source, "inventory", "medkit", 2)
```

---

#### `RemoveItem`

Removes an item from a player's inventory.

```lua
local success = exports['gfx-inventory']:RemoveItem(source, inventoryType, itemName, itemCount)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |
| `inventoryType` | string | Inventory type to remove from |
| `itemName` | string | Item name |
| `itemCount` | number | Quantity to remove |

**Returns:** `boolean` — `true` on success, `false` if the player does not have the item.

**Example:**
```lua
exports['gfx-inventory']:RemoveItem(source, "inventory", "bread", 1)
```

---

#### `GetItemByName`

Returns the item data table and its index in the inventory array for a specific item.

```lua
local itemData, index = exports['gfx-inventory']:GetItemByName(source, inventoryType, itemName)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |
| `inventoryType` | string | Inventory type |
| `itemName` | string | Item name |

**Returns:** `table, number` — item data `{ name, count, info }` and its array index, or `false` if not found.

---

#### `GetInventory`

Returns the full inventory array for a player.

```lua
local inventory = exports['gfx-inventory']:GetInventory(source, inventoryType)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |
| `inventoryType` | string | Inventory type. Defaults to `"inventory"` if omitted. |

**Returns:** `table` — array of `{ name, count, info }` entries, or `nil` if the player is not loaded.

---

#### `ClearInventory`

Removes all items from a player's inventory type and syncs to the client.

```lua
exports['gfx-inventory']:ClearInventory(source, inventoryType)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |
| `inventoryType` | string | Inventory type to clear. Defaults to `"inventory"` if omitted. |

---

#### `CreateUseableItem`

Registers a callback that fires when a player uses an item from the hotbar or inventory.

```lua
exports['gfx-inventory']:CreateUseableItem(itemName, callback)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `itemName` | string | Item name to register |
| `callback` | function | `function(source, itemName, info)` called when the item is used |

**Example:**
```lua
exports['gfx-inventory']:CreateUseableItem("medkit", function(source, itemName, info)
    exports['gfx-inventory']:RemoveItem(source, "inventory", "medkit", 1)
    -- heal player ...
end)
```

---

#### `UseItem`

Triggers item use for a player programmatically (fires the registered `CreateUseableItem` callback or equips a weapon).

```lua
exports['gfx-inventory']:UseItem(source, itemName, info)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |
| `itemName` | string | Item name |
| `info` | table\|nil | Per-instance metadata passed to the callback |

---

#### `GiveDefaultItems`

Gives the items listed in `Config.DefaultItems` to a player. Skips items the player already owns (idempotent). Useful for multi-character hooks where multiple characters share one license identifier.

```lua
local given = exports['gfx-inventory']:GiveDefaultItems(source)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Player server ID |

**Returns:** `number` — count of items successfully added.

---

#### `SavePlayerInventories`

Immediately saves a player's inventory data to the database by their identifier string.

```lua
exports['gfx-inventory']:SavePlayerInventories(identifier)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `identifier` | string | The player's stable identifier (e.g. `"license:abc123"`) |

---

## Events

### Client events (received by client from server)

| Event | Payload | Description |
|-------|---------|-------------|
| `gfx-inventory:OpenInventory` | `{ inventoryInfo }` | Instructs the client to open the NUI for the given inventory type |
| `gfx-inventory:UpdateInventory` | `value, inventoryType, index, key, refresh` | Partial or full inventory sync. When `inventoryType` is nil, replaces the entire `PlayerItems` table. When an `index` is provided, updates a single slot. |
| `gfx-inventory:SetHotbar` | `value, key, index` | Partial or full hotbar sync |
| `gfx-inventory:client:OnItemUsed` | `itemName, info` | Fired after a useable item is triggered. Automatically equips weapons and triggers `t11_vehicle:Spawn` for vehicle items. |
| `gfx-inventory:client:RemoveWeapon` | `itemName` | Calls `RemoveAllPedWeapons` when a weapon is removed from the inventory |
| `gfx-inventory:client:UseWeapon` | `itemName, info` | Equips or de-equips a weapon on the local ped |

### Server events (received by server from client)

| Event | Description |
|-------|-------------|
| `gfx-inventory:server:OpenInventory` | Opens inventory for the requesting player. Validates inventory type and optionally allows admins to open another player's inventory. |
| `gfx-inventory:ItemDrag` | Moves an item between two inventory types. Rate-limited to 15 calls/second. Validates item existence, count, and target weight. |
| `gfx-inventory:RemoveItem` | Drops (deletes) an item from the player's inventory. Rate-limited to 10 calls/second. Respects `DeleteBlockedItems`. |
| `gfx-inventory:UpdateHotbar` | Assigns or clears a hotbar slot. Rate-limited to 10 calls/second. Validates slot index (1–6) and item ownership. |
| `gfx-inventory:OnItemUsed` | Triggers item use from the hotbar. Rate-limited to 5 calls/second. |
| `inventory:killed` | Fired by the client on death. Clears the inventory types listed in `RemoveInventoriesWhenDead.types` if the config function returns `true`. |

---

## Commands

| Command | Side | Access | Description |
|---------|------|--------|-------------|
| `/<OpenCommand>` (default: `/inventory`) | Client | All players | Opens or closes the inventory NUI. Bound to TAB by default via `RegisterKeyMapping`. |
| `/useslot1` … `/useslot6` | Client | All players | Uses the item in hotbar slot 1–6. Bound to keyboard keys 1–6 by default. |
| `/clearinventory [playerId] [inventoryType]` | Server | Admins / console | Clears all items from the specified inventory type for the target player. |
| `/additem [playerId] [inventoryType] [itemName] [count]` | Server | Admins / console | Adds `count` of `itemName` to the target player's inventory. |
| `/removeitem [playerId] [inventoryType] [itemName] [count]` | Server | Admins / console | Removes `count` of `itemName` from the target player's inventory. |

---

## Features

- **Three inventory types** — `inventory` (main), `protected`, and `stash`, each with configurable weight limits and labels
- **Weight-based capacity** — every item has a per-unit weight; `AddItem` checks available weight before inserting and notifies the player if there is no space
- **6-slot hotbar** — players can pin items to hotbar slots and activate them with keys 1–6 without opening the full inventory
- **Drag between panels** — the NUI supports dragging items from the main inventory to the secondary panel (stash, protected) and back with server-side validation
- **Weapon equipping** — items with `type = "weapon"` are equipped/de-equipped on the ped via `GiveWeaponToPed`; removing the weapon from inventory also calls `RemoveAllPedWeapons`
- **Weapon ammo metadata** — weapons use `useItemInfo` to track per-instance ammo counts and attachments
- **Vehicle items** — items with `type = "vehicle"` trigger a `t11_vehicle:Spawn` event on use
- **Static stash locations** — configure world coordinates where any player can press E to open the shared stash inventory
- **Death inventory wipe** — configurable inventory types are cleared when a player dies (togglable per-source via a function)
- **Default items on first join** — `Config.DefaultItems` are given to new players automatically; `GiveDefaultItems` export allows re-triggering for multi-character setups
- **Persistent storage** — inventories are saved to MySQL on player disconnect and on resource stop; loaded on join and on resource (re)start
- **Duplicate healing** — on load, the server deduplicates any same-name entries that may have accumulated from past bugs
- **Rate limiting** — all client→server inventory events are rate-limited per event type to prevent abuse
- **Admin commands** — server-console and in-game admin commands for adding, removing, and clearing items
- **Item rarity glow** — slots display a rarity glow effect based on the `rarity` field in `config/items.lua`
- **Vanilla NUI stack** — no frontend framework; HTML + CSS + JS with PNG item images in `nui/assets/`

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Inventory not opening / UI blank | Confirm `oxmysql` is started before `gfx-inventory`. Check the F8 console for Lua errors and the browser console (F12) for JS errors. |
| `attempt to index a nil value` on first join | Ensure `oxmysql` is running and the `inventory` table exists. The table must be created before the resource starts. |
| Items duplicating after restart | Run the install SQL again — the `DeduplicatePlayerItems` function heals existing duplicates on next load. |
| Weight shows as 0 for all items | Verify the item name in `PlayerItems` matches the key in `Items` (case-sensitive). Items not found in `Items` are skipped in the weight calculation. |
| Item image missing / broken | Add a PNG named `<itemName>.png` to `nui/assets/` and declare it in `fxmanifest.lua`'s `files` block if adding new assets. |
| `CreateUseableItem` callback not firing | Confirm the resource calling `CreateUseableItem` is started after `gfx-inventory`. The callback is stored by resource; if the caller restarts, re-register it. |
| `/additem` or `/removeitem` denied in-game | The player's identifiers are not listed in `Config.Admins`. Add their `license:`, `steam:`, or `discord:` identifier. |
| Hotbar slots not persisting after restart | Hotbar data is saved in the `hotbar` column on disconnect. If the column does not exist, re-import `install.sql`. |
| Default items given every join | `GiveDefaultItems` is idempotent by default — it skips items already owned. If duplicates appear, check that `HasItem` returns the correct result for that item name. |
| Inventory not cleared on death | Verify `Config.RemoveInventoriesWhenDead.bool(source)` returns `true` for that player and that the target inventory type is listed in `Config.RemoveInventoriesWhenDead.types`. |

---

## Source

- **GitHub:** [https://github.com/gfx-fivem/gfx-inventory](https://github.com/gfx-fivem/gfx-inventory)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
