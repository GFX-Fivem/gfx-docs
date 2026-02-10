# gfx-tebexshop

In-game Tebex store UI for FiveM. Players redeem Tebex codes for coins and spend them on subscription tiers, time-limited boosts, and weapon skins -- all through a React-based NUI panel. Includes transaction history, refund system, and Discord webhook logging.

---

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx-tebexshop` |
| **Version** | 1.0.0 |
| **Side** | Client + Server |
| **UI** | React (NUI) |
| **Framework** | Standalone |
| **Lua** | 5.4 |
| **Database** | MySQL (oxmysql / ghmattimysql / mysql-async) |
| **Escrow** | Yes (escrow_ignore in fxmanifest) |

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| One of: `oxmysql` / `ghmattimysql` / `mysql-async` | Database queries (configured via `Config.SQLScript`) |

---

## Installation

### 1. Import the SQL tables

The script uses three database tables. Create them before starting the resource:

- `gfxtebexshop_users` -- stores player id, skins (JSON), tier (JSON), coins, boost (JSON), refund_right
- `gfxtebexshop_transactions` -- stores Tebex transaction codes (id, amount)
- `gfxtebexshop_transactionLogs` -- stores per-player transaction history (id, transactions JSON)

### 2. Copy files

Place the `gfx-tebexshop` folder into your server's resources directory.

### 3. Configure Tebex game commands

In your Tebex dashboard, set up packages to run the following command on purchase:

```
packagebought {transaction} {packageId}
```

Where `{packageId}` matches an entry in the `Packages` table inside `server/tebex_options.lua`.

### 4. Configure server options

Edit `server/tebex_options.lua`:

```lua
Packages = {
    ["6136862"] = {    -- Tebex package ID
        amount = 500,  -- coins granted when code is redeemed
    }
}

DiscordWebhook = ""        -- Discord webhook URL for logging
DefaultRefundRight = 1     -- number of refunds each player gets
```

### 5. server.cfg

```cfg
ensure gfx-tebexshop
```

---

## Configuration

All client/shared options are in `config.lua`.

### Config.SQLScript
```lua
Config.SQLScript = "ghmattimysql" -- "mysql-async" | "oxmysql" | "ghmattimysql"
```
Selects which MySQL wrapper to use for database queries.

### Config.NoImage
```lua
Config.NoImage = "https://..."
```
Fallback image URL displayed when no image is available.

### Config.HomePagePackages

Defines the shop home page items in two categories:

#### Boosts
```lua
Config.HomePagePackages.boosts = {
    { id = 1, name = "Boost 1", price = 100, icon = "tebexshop-icon4.png", hours = 1, visible = true },
    -- ...
}
```
| Field | Type | Description |
|-------|------|-------------|
| `id` | number | Unique boost identifier |
| `name` | string | Display name |
| `price` | number | Cost in coins |
| `icon` | string | Icon filename |
| `hours` | number | Duration of boost in hours |
| `visible` | boolean | Whether to show in the UI |

#### Coins
```lua
Config.HomePagePackages.coins = {
    { id = 1, amount = "500", icon = "tebexshop-icon3.png", link = "https://gfx.tebex.io", visible = true },
    -- ...
}
```
| Field | Type | Description |
|-------|------|-------------|
| `id` | number | Unique identifier |
| `amount` | string | Coin amount label |
| `icon` | string | Icon filename |
| `link` | string | External Tebex store URL |
| `visible` | boolean | Whether to show in the UI |

### Config.Admins
```lua
Config.Admins = {
    ["steam:1100001..."] = true,
}
```
Steam identifiers of players allowed to use admin commands (e.g. `/givecoin`).

### Config.Tiers
```lua
Config.Tiers = {
    {
        id = 1,
        tier = "bronze",       -- internal tier key
        name = "Bronze",       -- display name
        color = "blue",        -- UI color
        description = "Basic Tier",
        price = 2000,          -- cost in coins
        items = {              -- tier perk descriptions
            { id = 1, text = "Speed Running" },
            { id = 2, text = "Extra Stash" },
            { id = 3, text = "1 Vehicle" }
        },
        visible = true
    },
    -- ...
}
```
Tiers expire after 30 days (2592000 seconds) from purchase.

### Config.Skins
```lua
Config.Skins = {
    {
        id = 1,
        name = "M4 Default",
        weapon = "weapon_assaultrifle",      -- weapon hash name
        weaponLabel = "M4",                  -- display label
        skin = "default",                    -- component name or "default"
        owned = true,                        -- default skins are always owned
        equipped = true,                     -- default skins are equipped by default
        price = 0,
        image = "https://...",
        visible = true
    },
    {
        id = 2,
        type = "common",                     -- rarity: common, rare, etc.
        name = "M4 Anime Skin",
        weapon = "weapon_carbinerifle_mk2",
        weaponLabel = "M4",
        skin = "COMPONENT_CARBINERIFLE_MK2_ANIME",
        price = 16,
        image = "COMPONENT_CARBINERIFLE_MK2_ANIME.png",
        visible = false
    },
    -- ...
}
```
Each weapon should have a "default" skin entry. Purchased skins are applied as weapon components via `GiveWeaponComponentToPed`.

---

## Exports

### Client-side

#### toggleNuiFrame
Opens or closes the Tebex shop UI.
```lua
exports['gfx-tebexshop']:toggleNuiFrame(shouldShow)
```
| Parameter | Type | Description |
|-----------|------|-------------|
| `shouldShow` | boolean | `true` to open, `false` to close |

#### GetPlayerTier (Client)
Returns the current player's tier data from the local cache.
```lua
local tier = exports['gfx-tebexshop']:GetPlayerTier()
-- Returns: table (e.g. { tier = "bronze", bought = 1700000000 }) or nil
```

#### GetPlayerCoins (Client)
Returns the current player's coin balance from the local cache.
```lua
local coins = exports['gfx-tebexshop']:GetPlayerCoins()
-- Returns: number
```

### Server-side

#### GetPlayerTier (Server)
Returns a player's active tier name. Returns `"user"` if no tier or tier has expired (30-day expiry).
```lua
local tier = exports['gfx-tebexshop']:GetPlayerTier(source)
-- Returns: string ("user", "bronze", "silver", "gold")
```
| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Server-side player ID |

#### GetPlayerCoins (Server)
Returns a player's coin balance.
```lua
local coins = exports['gfx-tebexshop']:GetPlayerCoins(source)
-- Returns: number
```
| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | Server-side player ID |

---

## Events

### Client Event: gfx-tebexshop:updateUserData
Sent from server to client to update the local user data cache.
```lua
-- Triggered by the server:
TriggerClientEvent("gfx-tebexshop:updateUserData", source, key, value)
```
| Parameter | Type | Description |
|-----------|------|-------------|
| `key` | string or nil | Data key to update (`"coins"`, `"tier"`, `"skins"`, `"boost"`, etc.). If `nil`, replaces entire userData table. |
| `value` | any | The new value for the given key, or the full user data table if key is nil. |

---

## Commands

| Command | Access | Arguments | Description |
|---------|--------|-----------|-------------|
| `/tebexshop` | Everyone | None | Opens the Tebex shop NUI panel |
| `/givecoin` | Admin only | `[playerId] [amount]` | Gives coins to a target player. Requires the executor's steam identifier to be in `Config.Admins`. |
| `/packagebought` | Console only | `[transactionId] [packageId]` | Called by Tebex webhook when a package is purchased. Creates a redeemable transaction code in the database. Only works from server console (source 0). |

---

## Features

- **React NUI Interface** -- Modern web-based shop interface built with React/TypeScript
- **Coin Economy** -- Players purchase coins via Tebex and spend them in-game on tiers, boosts, and skins
- **Code Redemption** -- Players redeem Tebex transaction codes to receive coins
- **Subscription Tiers** -- Bronze, Silver, Gold tiers with 30-day expiration and configurable perks
- **Time-Limited Boosts** -- Purchasable boosts with configurable duration (hours); stacks with existing boost time
- **Weapon Skins** -- Buy and equip custom weapon skins (applied as weapon components with rarity types)
- **Transaction History** -- Full transaction log per player viewable in the UI
- **Refund System** -- Players get a configurable number of refund rights to undo purchases (tiers, boosts, skins)
- **Steam Avatar** -- Fetches player's Steam profile picture for display in the UI
- **Discord Logging** -- All purchases, code claims, and admin actions logged via Discord webhook
- **Multi-SQL Support** -- Works with oxmysql, ghmattimysql, or mysql-async
- **Custom Weapon Meta** -- Includes weapon component/archetype meta files for custom skins (stream/weapons)
- **Admin Coin Management** -- Admins can give coins to players via command

---

## Troubleshooting

| Problem | Cause | Solution |
|---------|-------|----------|
| Shop does not open | Command not registered or NUI build missing | Ensure `web/build/` folder exists with compiled React files. Check console for errors on resource start. |
| "error" when claiming code | Transaction code not found in database | Verify Tebex is calling `packagebought` correctly with the right package ID matching `Packages` in `tebex_options.lua`. |
| Coins not updating after purchase | MySQL wrapper mismatch | Ensure `Config.SQLScript` matches your installed MySQL resource (`oxmysql`, `ghmattimysql`, or `mysql-async`). |
| Skins not applying on weapon | Wrong weapon hash or component name | Verify `weapon` matches the exact weapon hash (e.g. `weapon_carbinerifle_mk2`) and `skin` matches a valid weapon component name. |
| Tier shows as "user" after purchase | 30-day expiration passed | Tiers automatically expire after 30 days. The player needs to repurchase. |
| `/givecoin` does nothing | Not in admin list | Add your steam identifier to `Config.Admins` in `config.lua`. |
| `/packagebought` does nothing | Executed by a player instead of console | This command only works when `source == 0` (server console). Configure Tebex to send it as a game server command. |
| Steam avatar not loading | Player not using Steam | The script only fetches avatars for players with a `steam:` identifier. Other identifier types will show `Config.NoImage` or an empty string. |
| Database errors on start | Tables not created | Create the required tables: `gfxtebexshop_users`, `gfxtebexshop_transactions`, `gfxtebexshop_transactionLogs`. |
| Discord logs not working | Webhook URL empty | Set `DiscordWebhook` in `server/tebex_options.lua` to a valid Discord webhook URL. |
