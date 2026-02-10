# gfx-marketplace

An in-game player-to-player marketplace system for FiveM. Players can list their inventory items for sale, browse listings from other players, purchase items, and claim earnings from sold items. Features a full NUI interface with seller profiles (Discord/Steam avatars), spam protection, and multi-framework support.

---

## Info

| Key | Value |
|---|---|
| **Resource Name** | `gfx-marketplace` |
| **Type** | Standalone (multi-framework) |
| **Frameworks** | ESX / New ESX / QBCore / New QBCore |
| **SQL Support** | oxmysql, mysql-async, ghmattimysql |
| **UI** | NUI (HTML/JS) |
| **Lua Version** | 5.4 |

---

## Dependencies

| Dependency | Purpose |
|---|---|
| **QBCore** or **ESX** | Framework for player data, inventory, and money management |
| **oxmysql** / **mysql-async** / **ghmattimysql** | Database queries |

---

## Installation

### 1. Import Database

Run the `marketplace.sql` file in your database. This creates three tables:

- `gfxmarketplace_offers` -- Active marketplace listings
- `gfxmarketplace_myoffers` -- Per-player offer tracking
- `gfxmarketplace_sellers` -- Seller profiles (name, avatar)

### 2. Copy Files

Place the `gfx-marketplace` folder into your server's resources directory.

### 3. server.cfg

```cfg
ensure gfx-marketplace
```

Make sure your framework (qb-core or es_extended) and SQL resource start before this script.

---

## Configuration

All configuration is in `config.lua`.

### Framework & SQL

```lua
Config.Framework = "newqb"   -- Options: "esx", "newesx", "qb", "newqb"
Config.SQLScript = "oxmysql" -- Options: "oxmysql", "mysql-async", "ghmattimysql"
```

### Default Image

```lua
Config.NoImage = "https://cdn.discordapp.com/attachments/.../noimage.png"
```

Image displayed when a seller has no profile picture.

### Inventory Image Path

```lua
Config.ImagePath = "gfx-inventory/nui/assets"
```

Path used by the NUI to load item images.

### Opening Methods

#### Command & Keybind

```lua
Config.Open.Command = {
    enabled = true,
    command = "market",          -- Chat command name
    key = "TAB",                 -- Keybind key (set to false to disable keybind)
    keyDescription = "Open market",
}
```

#### NPC

```lua
Config.Open.Npc = {
    enabled = true,
    ped = "s_m_m_highsec_01",   -- Ped model
    coords = {
        vector4(-697.995, 262.8207, 80.876 - 0.98, 330.67126464844),
    },
    text = "Press ~g~[E]~s~ to open the market",
    key = 46,                    -- Control key (46 = E)
}
```

You can add multiple NPC locations by adding more `vector4` entries to the `coords` table.

### Locales

```lua
Locales = {
    ["dont_spam"]    = "Please do not spam!",
    ["already_sold"] = "This item has already sold!",
    ["own_item"]     = "You can't buy your own item!",
}
```

### Custom Opening

You can open the marketplace from any other script using the client-side function or event:

```lua
-- From client-side Lua
SetVisible(true)  -- Open
SetVisible(false) -- Close

-- From another script via event
TriggerClientEvent("gfx-marketplace:openUI", source) -- Server-side trigger
TriggerEvent("gfx-marketplace:openUI")                -- Client-side trigger
```

---

## Exports

No exports are registered by this script.

---

## Events

### Client Events

#### `gfx-marketplace:openUI`

Opens the marketplace UI for the player. Can be triggered from client or server side.

```lua
-- Client-side
TriggerEvent("gfx-marketplace:openUI")

-- Server-side (for a specific player)
TriggerClientEvent("gfx-marketplace:openUI", source)
```

| Parameter | Type | Description |
|---|---|---|
| -- | -- | No parameters required |

---

#### `gfx-marketplace:notify`

Displays a notification in the marketplace NUI.

```lua
-- Server-side
TriggerClientEvent("gfx-marketplace:notify", source, text)
```

| Parameter | Type | Description |
|---|---|---|
| `text` | `string` | Notification message to display |

---

## Commands

| Command | Keybind | Description |
|---|---|---|
| `/market` | `TAB` (configurable) | Opens the marketplace UI. Command name and keybind are configurable in `config.lua`. |

---

## Features

- **Player-to-Player Trading** -- Players can list inventory items at any price and other players can purchase them.
- **Offer Management** -- Players can view their active listings, delete unsold offers (items returned), and claim earnings from sold items.
- **Seller Profiles** -- Automatically fetches and displays seller avatars from Discord or Steam.
- **Seller Levels** -- Customizable `GetPlayerLevel` function in `server/open.lua` to integrate with level systems.
- **NUI Interface** -- Full browser-based UI for browsing, buying, selling, and managing offers.
- **Spam Protection** -- Server-side cooldown prevents rapid-fire requests (1 second minimum between actions).
- **Multiple Opening Methods** -- Open via chat command, keybind, or NPC interaction. All configurable.
- **Multiple NPC Locations** -- Add as many NPC marketplace vendors as needed.
- **Multi-Framework** -- Works with ESX (legacy + new export) and QBCore (legacy + new export).
- **Multi-SQL** -- Supports oxmysql, mysql-async, and ghmattimysql.
- **Claim All** -- Players can claim earnings from all sold items at once.

---

## Database Schema

### `gfxmarketplace_offers`

Stores all active marketplace listings grouped by item name.

| Column | Type | Description |
|---|---|---|
| `itemName` | `longtext` | Item name identifier |
| `marketData` | `longtext` | JSON array of offers for this item (sellerId, price, count, id) |

### `gfxmarketplace_myoffers`

Tracks each player's personal offer history and pending claims.

| Column | Type | Description |
|---|---|---|
| `id` | `longtext` | Player identifier |
| `items` | `longtext` | JSON array of the player's offers (itemName, count, price, id, sold) |

### `gfxmarketplace_sellers`

Stores seller profile information for display in the UI.

| Column | Type | Description |
|---|---|---|
| `id` | `longtext` | Player identifier |
| `image` | `longtext` | Avatar URL (Discord or Steam) |
| `name` | `longtext` | Player display name |

---

## Customization

### Player Level System

Edit `GetPlayerLevel` in `server/open.lua` to return the player's level from your level system:

```lua
function GetPlayerLevel(identifier)
    return false -- Replace with your level system logic
end
```

### Item Labels & Types

Edit `GetItemLabel` and `GetItemType` in `server/open.lua` to customize how items are labeled:

```lua
function GetItemLabel(itemName)
    return itemName -- Customize item label lookup
end

function GetItemType(itemName)
    return "item" -- Customize item type lookup
end
```

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Marketplace does not open | Check that `Config.Open.Command.enabled` or `Config.Open.Npc.enabled` is `true`. Verify the resource is started in `server.cfg`. |
| SQL errors on startup | Ensure you imported `marketplace.sql` and that your SQL resource (`oxmysql`, etc.) is started before `gfx-marketplace`. |
| Framework not detected | Verify `Config.Framework` matches your framework (`esx`, `newesx`, `qb`, or `newqb`). |
| Items not showing images | Check that `Config.ImagePath` points to the correct inventory asset folder. |
| "Please do not spam!" message | This is the built-in spam protection. Wait at least 1 second between actions. |
| Seller avatars not loading | Ensure the Discord bot token is valid (in `server/seller.lua`) or that `steam_webApiKey` convar is set for Steam avatars. |
| NPC not appearing | Verify the ped model name is correct and the coordinates are valid. Check for model loading errors in the client console. |
| Cannot buy own items | This is intended behavior. Players cannot purchase their own listings. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-marketplace
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
