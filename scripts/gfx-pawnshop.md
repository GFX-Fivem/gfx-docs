# gfx-pawnshop

## Info

| Key | Value |
|---|---|
| **Name** | gfx-pawnshop |
| **Author** | Jakrino |
| **Version** | 1.0 |
| **FX Version** | adamant |
| **Game** | GTA5 |
| **Lua 5.4** | Yes |
| **UI** | NUI (HTML/JS/CSS) |
| **Frameworks** | QBCore, ESX |
| **Database** | MySQL (oxmysql, ghmattimysql, mysql-async) |

---

## Dependencies

| Dependency | Required | Notes |
|---|---|---|
| **qb-core** or **es_extended** | Yes | One of the two frameworks must be running |
| **oxmysql** / **ghmattimysql** / **mysql-async** | Yes | One SQL resource, configured via `Config.SQLScript` |
| **qb-target** | Optional | Only if `Config.InteractType["target"].useThis` is enabled |

---

## Installation

### 1. Import SQL
Run the `insert-me.sql` file in your database. This creates two tables:

```sql
-- Player sell data and bonus tracking
CREATE TABLE IF NOT EXISTS `gfx_pawnshop_user` (
  `citizenid` varchar(255) NOT NULL,
  `buydata` longtext NOT NULL DEFAULT '{}',
  `bonusdata` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`citizenid`)
);

-- Shop ownership, item config, stash, and money
CREATE TABLE IF NOT EXISTS `gfx_pawnshop_shop` (
  `shopid` varchar(255) NOT NULL,
  `sellingdata` longtext NOT NULL DEFAULT '{}',
  `itemconfig` longtext NOT NULL DEFAULT '{}',
  `shopstash` longtext NOT NULL DEFAULT '{}',
  `money` bigint(255) NOT NULL DEFAULT 0,
  `owner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`shopid`),
  UNIQUE KEY `owner` (`owner`)
);
```

### 2. Copy Files
Place the `gfx-pawnshop` folder into your server's resources directory.

### 3. server.cfg
```cfg
ensure gfx-pawnshop
```

Make sure your framework (`qb-core` or `es_extended`) and SQL resource start **before** this script.

---

## Configuration

All configuration is in `config.lua`.

### General Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Locales` | string | `'EN'` | Language code. Available: `EN`, `TR` |
| `Config.SQLScript` | string | `'oxmysql'` | SQL driver. Options: `oxmysql`, `ghmattimysql`, `mysql-async` |
| `Config.MoneyAsItem` | boolean | `false` | If `true`, uses an inventory item as currency instead of player cash |
| `Config.MoneyName` | string | `'cash'` | The item name used as currency when `MoneyAsItem` is enabled |

### Interaction Type

Only **one** should be set to `true` at a time:

```lua
Config.InteractType = {
    ["textui"]   = { useThis = false },  -- QBCore DrawText UI
    ["drawtext"] = { useThis = true  },  -- 3D floating text (default)
    ["target"]   = { useThis = false },  -- qb-target eye interaction
}
```

- **drawtext** -- Renders 3D text above the NPC. Press `[E]` to sell, `[G]` for boss menu.
- **textui** -- Uses QBCore's `DrawText` / `HideText` exports. Same keybinds.
- **target** -- Uses `qb-target` box zones around each NPC. Requires `qb-target` resource.

### Pawn Shops

Each entry in `Config.PawnShops` defines a shop location:

```lua
Config.PawnShops = {
    ["Winston's"] = {
        npcSettings = {
            model = "a_m_m_indian_01",                              -- Ped model
            coords = vector4(-1308.52, -1316.76, 3.88, 332.91)     -- Position + heading
        },
        blipSettings = {
            id = 570,                                    -- Blip sprite ID
            colour = 5,                                  -- Blip color
            scale = 0.65,                                -- Blip scale
            displayName = "Winston's Pawn Shop",         -- Blip label when owned/NPC
            notOwnedDisplayName = "Not Owned Pawn Shop"  -- Blip label when unowned
        },
        shopSettings = {
            npc = false,   -- true = NPC-run (cannot be purchased), false = player-purchasable
            price = 1000   -- Purchase price (only used when npc = false)
        }
    },
}
```

- When `npc = true`: The shop is permanently NPC-operated. Players can only sell items here.
- When `npc = false`: The shop can be purchased by a player. The owner gets a boss menu to manage items, prices, and the shop safe.

### Bonus Options

Players earn bonus money based on cumulative sales at NPC shops. Configured via `Config.NPCBonusOptions`:

```lua
Config.NPCBonusOptions = {
    [1] = { requiredSelling = 5,   multiplierPercentage = 2.5  },
    [2] = { requiredSelling = 10,  multiplierPercentage = 5    },
    -- ...up to 10 tiers
    [10] = { requiredSelling = 225, multiplierPercentage = 25  },
}
```

| Field | Description |
|---|---|
| `requiredSelling` | Total sales needed to reach this bonus tier |
| `multiplierPercentage` | Percentage bonus added to item base price (e.g., `5` = 5% extra) |

Bonus money accumulates in the database and must be collected by the player through the UI.

### Sellable Items

Items that can be sold at pawn shops. Defined in `Config.SellableItems`:

```lua
Config.SellableItems = {
    [1] = {
        itemCode = "weapon_pistol",    -- Item/weapon name
        itemLabel = "Pistol",          -- Display name in UI
        requiredSelling = 0,           -- Sales needed before this item is unlocked
        defaultPrice = 1000,           -- Base sell price (NPC shops use this fixed; player shops can edit)
        visibleForNpc = true           -- true = visible in both NPC and player shops; false = player shops only
    },
}
```

### Notification Function

Override `Config.Notification` in `config.lua` to use your own notification system:

```lua
function Config.Notification(text, server, source)
    if server then
        TriggerClientEvent('QBCore:Notify', source, text)
    else
        TriggerEvent('QBCore:Notify', text)
    end
end
```

### HUD Toggle Function

Override `Config.Hud` to control HUD visibility when the shop UI opens/closes:

```lua
function Config.Hud(boolen)
    if boolen then
        TriggerEvent('ShowHud')
    else
        TriggerEvent('HideHud')
    end
end
```

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events for external scripts. All events are internal to the resource.*

---

## Commands

*No commands are registered by this script.*

---

## Features

- **Dual Framework Support** -- Works with both QBCore and ESX. Automatically detects which framework is running.
- **NPC and Player-Owned Shops** -- Shops can be NPC-operated (fixed prices, always available) or purchasable by players who then manage them.
- **Boss Menu** -- Shop owners can toggle item visibility, edit prices, add/remove items from the shop stash, and deposit/withdraw money from the shop safe.
- **Sales Progression System** -- Some items require a minimum number of prior sales before they become available to sell, creating a progression curve.
- **Bonus Multiplier System** -- Players earn escalating percentage bonuses on NPC shops based on total sales count (up to 10 tiers, max 25% bonus). Bonus money accumulates and can be collected through the UI.
- **Shop Safe / Money Management** -- Player-owned shops have a money safe. Selling items deducts from the safe. Owners can deposit and withdraw funds.
- **Shop Stash Tracking** -- Player-owned shops track how many of each item has been sold into the shop, with daily selling data.
- **Three Interaction Modes** -- DrawText (3D floating text), TextUI (QBCore DrawText), or qb-target (eye targeting).
- **Multiple SQL Drivers** -- Supports oxmysql, ghmattimysql, and mysql-async.
- **NUI Interface** -- Full HTML/JS/CSS shop interface for selling items and managing shops.
- **Map Blips** -- Configurable blips for each shop location with different labels for owned vs unowned shops.
- **NPC Spawning** -- Spawns invincible, frozen peds at each shop location with configurable models.
- **Localization** -- Multi-language support with locale files (English and Turkish included).
- **Money as Item** -- Optional mode to use an inventory item as currency instead of player cash.
- **Auto-Sync** -- New items added to `Config.SellableItems` are automatically synced to existing shop databases on resource start.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| NPC not spawning | Verify the ped model name in `npcSettings.model` is valid. Check server console for model loading errors. |
| Shop cannot be purchased | Ensure `shopSettings.npc` is set to `false` for purchasable shops. |
| "Not enough money in safe" when selling | Player-owned shops require funds in the shop safe. The owner must deposit money via the boss menu. NPC shops pay directly. |
| Items not appearing in shop | Check `visibleForNpc` (must be `true` for NPC shops), `requiredSelling` (player may not have enough sales), and that the item exists in `Config.SellableItems`. |
| SQL errors on start | Run `insert-me.sql` to create the required tables. Verify `Config.SQLScript` matches your SQL resource. |
| Boss menu says "not your shop" | Only the player who purchased the shop can access the boss menu. Check `gfx_pawnshop_shop.owner` in the database. |
| Bonus not collecting | Bonus is only available at NPC shops (`npc = true`). The player must click the bonus collect button in the UI. |
| DrawText / TextUI not showing | Ensure only one interaction type is set to `true` in `Config.InteractType`. If using `textui`, QBCore `DrawText`/`HideText` exports must be available. |
| qb-target zones not appearing | Ensure `qb-target` is started before this resource and `Config.InteractType["target"].useThis` is `true`. |
| Framework not detected | Make sure `qb-core` or `es_extended` is started before `gfx-pawnshop` in your `server.cfg`. |
| Players can buy multiple shops | Each player can only own one shop. The script checks for existing ownership before allowing a purchase. |
