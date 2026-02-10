# GFX Crafting ATY

A feature-rich crafting system with a modern NUI interface, supporting multiple crafting tables, leveling/experience progression, weapon attachment management, coin/boost economy, and Tebex integration.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-crafting_aty` |
| **Frameworks** | QBCore, ESX, OldESX |
| **Escrow** | No |

## Dependencies

- **QBCore** (`qb-core`) or **ESX** (`es_extended`) -- depending on framework choice
- **MySQL** -- one of: `oxmysql`, `mysql-async`, or `ghmattimysql`
- **Discord Bot Token** -- required for player avatar fetching (configured in `server/serverconfig.lua`)

## Installation

### 1. Import SQL

Run the `data.sql` file in your database to create the required tables:

- `crafting_data` -- stores player experience, coins, and boosts
- `crafting_codes` -- stores redeemable coin codes (generated via Tebex purchases)

### 2. Add Items to Your Inventory System

**QBCore:** Add the entries from `items/qb.txt` to your `qb-core/shared/items.lua`:
- `clip_attachment`
- `flashlight_attachment`
- `suppressor_attachment`
- `grip_attachment`
- `smallscope_attachment`

**ESX:** Run the SQL from `items/esx.sql` to insert the items into your `items` table.

You also need to add any crafting ingredient items (e.g., `cloth`, `iron`, `wood`) and craftable output items (e.g., `bandage`, `weapon_pistol`) that you define in your config.

### 3. Copy Resource

Place the `gfx-crafting_aty` folder into your server's resources directory.

### 4. Configure

Edit `config.lua` to set your framework, MySQL driver, crafting tables, recipes, levels, and attachments. Edit `server/serverconfig.lua` to set your Discord bot token.

### 5. server.cfg

```cfg
ensure gfx-crafting_aty
```

## Configuration

Configuration is done in `config.lua`. Key options:

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Framework` | `string` | `"qb"` | Framework to use: `"qb"`, `"esx"`, or `"oldesx"` |
| `MySQL` | `string` | `"oxmysql"` | MySQL resource: `"oxmysql"`, `"ghmattimysql"`, `"mysql-async"`, or `false` |
| `Tebex` | `string` | `""` | Tebex store URL for coin purchases |
| `BoostPrice` | `number` | `100` | Coin cost to purchase a crafting boost |
| `BoostPercentage` | `number` | `0.5` | Duration multiplier when boost is active (0.5 = 50% faster) |
| `blips` | `boolean` | `false` | Whether to show map blips for crafting tables |

### Crafting Tables

Defined in `Config.CraftingTables`. Each table entry is a keyed table with:

| Field | Type | Description |
|-------|------|-------------|
| `Coords` | `vector3` | World position of the crafting table |
| `Job` | `string` | Job restriction (`"all"` for no restriction, or a job name like `"police"`) |
| `Grade` | `number` | Minimum job grade required to access the table |
| `Distance` | `number` | Interaction distance in units |
| `Marker` | `table` | Marker appearance: `Type`, `Size` (vector3), `Color` (r,g,b,a) |
| `Blip` | `table` | Blip settings: `Sprite`, `Color`, `Label`, `Enabled` |
| `Categories` | `table` | Array of category objects with `categoryCode` and `categoryLabel` |
| `Items` | `table` | Array of craftable item recipes (see below) |

### Craftable Item Recipe

Each item in a crafting table's `Items` array:

| Field | Type | Description |
|-------|------|-------------|
| `itemCategory` | `string` | Category code this item belongs to |
| `itemCode` | `string` | Item name/code in inventory |
| `itemLabel` | `string` | Display name |
| `itemImage` | `string` | Image filename |
| `itemLevel` | `number` | Minimum crafting level required |
| `itemDuration` | `number` | Base crafting duration in seconds |
| `itemPrice` | `number` | Cash cost per craft |
| `itemExp` | `number` | Experience gained per craft |
| `itemDesc` | `string` | Item description |
| `ingredients` | `table` | Array of required materials: `{ itemCode, quantity, label, image }` |

### Levels

Defined in `Config.Levels`. A table mapping level number to the required cumulative experience:

```lua
Levels = {
    [1] = { exp = 0 },
    [2] = { exp = 50 },
    [3] = { exp = 100 },
    -- ... up to [15] = { exp = 4000 }
}
```

### Weapon Attachments

`Config.AttachmentItems` maps attachment slot names to inventory item codes:

| Slot | Item Code |
|------|-----------|
| `clip` | `clip_attachment` |
| `silencer` | `suppressor_attachment` |
| `flashlight` | `flashlight_attachment` |
| `scope` | `smallscope_attachment` |
| `grip` | `grip_attachment` |

`Config.Attachments` defines which weapon supports which attachment components (with GTA hash keys). Supported weapons include pistols, SMGs, rifles, shotguns, and snipers.

### Server Config

In `server/serverconfig.lua`:

| Option | Type | Description |
|--------|------|-------------|
| `Config.DiscordBotToken` | `string` | Discord bot token used to fetch player avatars |

## Exports

### Client Exports

#### `OpenCraftingTable`
Opens a specific crafting table UI by its config key.

```lua
exports['gfx-crafting_aty']:OpenCraftingTable(id)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `string` | The key of the crafting table in `Config.CraftingTables` (e.g., `"police"`) |

#### `CloseCraftingTable`
Closes the crafting table UI.

```lua
exports['gfx-crafting_aty']:CloseCraftingTable()
```

No parameters.

## Events

### Client Events

#### `aty_crafting:client:updatePlayerData`
Triggered from the server to update the player's experience and level in the UI after crafting completes.

```lua
-- Triggered by the server, listened on the client
TriggerClientEvent("aty_crafting:client:updatePlayerData", source, newExp)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `newExp` | `number` | The player's updated total experience |

### Server Events

#### `aty_crafting:server:craftEnded`
Triggered by the client when a crafting queue item finishes. Awards the crafted item and experience to the player.

```lua
-- Triggered from client
TriggerServerEvent("aty_crafting:server:craftEnded", item)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `item` | `table` | The crafted item data including `itemCode`, `itemExp`, and `amount` |

## Commands

| Command | Parameters | Description |
|---------|------------|-------------|
| `purchase_made_for_crafting` | `<tebexId> <coins>` | **Console-only (RCON).** Creates a redeemable coin code in the database. Used by Tebex purchase webhooks to grant coins to players. |

## Features

- **Multiple Crafting Tables** -- Define unlimited crafting stations at different locations, each with their own recipes and categories
- **Job & Grade Restrictions** -- Lock crafting tables behind specific jobs and minimum grades, or set to "all" for public access
- **Leveling System** -- Players earn experience from crafting and unlock higher-level recipes as they progress (up to 15 levels)
- **Category Filtering** -- Items in each crafting table are organized into categories (weapons, consumables, attachments, etc.) with an "all" view and search functionality
- **Crafting Queue** -- Players can queue multiple items for crafting; progress persists across menu open/close during the session
- **Batch Crafting** -- Craft multiple quantities of an item at once (duration and ingredient costs scale accordingly)
- **Coin & Boost Economy** -- Players earn coins (via Tebex codes) that can be spent on crafting boosts to reduce crafting time by a configurable percentage
- **Weapon Attachment System** -- Add/remove weapon attachments (clips, silencers, flashlights, scopes, grips) directly from the crafting UI when holding a weapon; consumes/returns attachment items from inventory
- **Tebex Integration** -- Coin purchase codes are generated via a console command triggered by Tebex webhooks; players redeem codes in the UI
- **Map Blips** -- Optional configurable blips for each crafting table that respect job restrictions
- **Player Avatars** -- Fetches Discord avatars for display in the crafting UI
- **Multi-Framework** -- Supports QBCore, ESX, and OldESX with configurable MySQL driver
- **NUI Interface** -- Modern web-based UI with localization support
- **Localization** -- All UI text is configurable through `locales.lua`

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Crafting table not appearing | Verify `Config.CraftingTables` coordinates are correct. Check that the player's job and grade meet the table's `Job` and `Grade` requirements. |
| "No materials to craft" | Ensure the player has all required ingredient items in their inventory with sufficient quantities. Ingredient item codes must match your inventory system exactly. |
| Items not given after crafting | Confirm that all `itemCode` values in your recipes exist as valid items in your framework's item registry. |
| Database errors on startup | Run `data.sql` to create the `crafting_data` and `crafting_codes` tables. Verify your `Config.MySQL` setting matches your installed MySQL resource. |
| Attachments not working | Make sure attachment items (`clip_attachment`, `suppressor_attachment`, etc.) are added to your inventory system. The player must be holding a weapon that supports the attachment. |
| Blips not showing | Set `Config.blips = true` in `config.lua`. Blips only appear for tables the player has job access to. |
| Player avatar not loading | Verify `Config.DiscordBotToken` in `server/serverconfig.lua` is a valid Discord bot token. The bot must be in a server with the player, or the player must have a linked Discord identifier. |
| Boost not reducing time | Confirm `Config.BoostPercentage` is set correctly (e.g., `0.5` for 50% time reduction). Boosts must be activated before starting a craft. |
| Coin codes not working | Codes are created via the `purchase_made_for_crafting` console command. Verify the code exists in the `crafting_codes` database table. Each code can only be used once. |
| Framework not detected | Ensure `Config.Framework` is set to exactly `"qb"`, `"esx"`, or `"oldesx"` and the corresponding core resource is started before this script. |
