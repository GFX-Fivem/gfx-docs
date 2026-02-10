# gfx-kit

Claimable kit system with NUI interface. Players open a UI panel to view and claim configured kits (items, weapons, armor, etc.) with per-kit cooldown timers. Supports conditional access via custom functions (e.g., Discord role checks).

---

## Info

| Key | Value |
|---|---|
| **Resource name** | `gfx-kit` |
| **Side** | Client + Server |
| **Framework** | Framework-independent (uses `gfx-lib` for framework abstraction) |
| **UI** | NUI (HTML) |
| **Database** | MySQL (`gfx_kits` table, auto-created on first boot) |
| **Lua version** | 5.4 |

---

## Dependencies

| Dependency | Purpose |
|---|---|
| `gfx-lib` | Framework detection, player identifier retrieval, inventory item management, SQL execution |
| MySQL resource | One of: `oxmysql`, `ghmattimysql`, or `mysql-async` (configured through `gfx-lib`) |

---

## Installation

### 1. Copy files
Place the `gfx-kit` folder into your server's resources directory.

### 2. Import SQL (optional)
The script auto-creates the `gfx_kits` table on first boot. If you prefer manual setup, import `kits.sql`:

```sql
CREATE TABLE IF NOT EXISTS `gfx_kits` (
    `identifier` VARCHAR(64) NOT NULL,
    `kits` LONGTEXT DEFAULT NULL,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```

### 3. server.cfg
```cfg
ensure gfx-lib
ensure gfx-kit
```

Make sure `gfx-lib` starts before `gfx-kit`.

---

## Configuration

All configuration is in `config.lua`.

### General Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.ServerName` | `string` | `"GFX Server"` | Server name displayed in the kit UI |
| `Config.ServerLogo` | `string` | URL | Server logo displayed in the kit UI |

### Kit Definition — `Config.Kits`

Each kit is defined as a key-value entry in `Config.Kits`. The key is the kit's unique identifier string.

```lua
Config.Kits = {
    ["starter"] = {
        name = "Starter Kit",              -- Display name in UI
        description = "This is a starter kit", -- Description shown in UI
        duration = 1,                       -- Cooldown in hours before kit can be claimed again
        image = "assets/armor.png",         -- Image path (relative to nui folder)
        items = {                           -- Items given when claimed
            { name = "weapon_carbinerifle", count = 1 },
            { name = "rifle_ammo", count = 1 },
            { name = "armor", count = 1 },
        },
        playerCanInteract = function(source) -- Access control function
            return true                      -- Return true to allow, false to lock
        end,
    },
}
```

#### Kit Options

| Field | Type | Required | Description |
|---|---|---|---|
| `name` | `string` | Yes | Display name shown in the NUI panel |
| `description` | `string` | Yes | Description shown in the NUI panel |
| `duration` | `number` | Yes | Cooldown period in **hours** before the kit can be claimed again (e.g., `0.1` = 6 minutes, `24 * 7` = one week) |
| `image` | `string` | Yes | Image path for the kit icon, relative to the `nui/` folder |
| `items` | `table` | Yes | Array of `{ name, count }` tables defining the items to give |
| `playerCanInteract` | `function(source)` | Yes | Server-side function that receives the player source and returns `true` (unlocked) or `false` (locked). Used for conditional access (e.g., Discord role, job, permission checks) |

#### Example: Discord Role-Gated Kit

```lua
["discord"] = {
    name = "Discord Kit",
    description = "Requires Discord Prime role",
    duration = 6,
    image = "assets/armor.png",
    items = {
        { name = "weapon_carbinerifle", count = 1 },
    },
    playerCanInteract = function(source)
        return HasPlayerHasRoleOnDiscord(source, "Prime")
    end,
},
```

### Helper Functions

The config file also provides these utility functions:

| Function | Description |
|---|---|
| `HasPlayerHasRoleOnDiscord(source, requiredRole)` | Checks if a player has a specific Discord role. Requires a Discord permissions resource (e.g., `discord_perms`). |
| `GetDiscordIdentifier(source)` | Extracts the player's Discord identifier from their FiveM identifiers. |
| `ExecuteSql(query, parameters, cb)` | Legacy SQL wrapper supporting `oxmysql`, `ghmattimysql`, and `mysql-async`. |

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events are exposed by this script. All internal events use a private callback system (`gfx-kit:triggerCallback`, `gfx-kit:getKits`, `gfx-kit:claimKit`) and are not intended for external use.*

---

## Commands

| Command | Side | Arguments | Description |
|---|---|---|---|
| `/kit` | Client | None | Opens the kit claim NUI panel |

---

## Features

- **NUI Kit Panel** — Full HTML/JS interface to browse, view, and claim kits.
- **Configurable Kits** — Define unlimited kits with custom names, descriptions, images, items, and cooldowns.
- **Cooldown System** — Per-kit cooldown timer stored in the database. Duration is configured per kit in hours. Players cannot claim the same kit until the cooldown expires.
- **Conditional Access** — Each kit has a `playerCanInteract` function that controls who can see/claim it. Useful for role-gated, job-gated, or permission-gated kits.
- **Discord Integration** — Built-in helper functions for checking Discord roles, enabling Discord-exclusive kits.
- **Auto Table Creation** — The `gfx_kits` database table is automatically created if it does not exist on server start.
- **Persistent Tracking** — Kit claim timestamps are stored per player identifier in the database, persisting across server restarts and reconnects.
- **Framework Independent** — Uses `gfx-lib` for all framework-specific operations (player lookup, item giving, identifier retrieval), so it works with QBCore, ESX, Qbox, and others.
- **Player Initialization** — On player load, initializes kit cooldown records for all configured kits so new kits are immediately claimable.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| `/kit` command does nothing | Ensure `gfx-kit` is started and the NUI files exist in the `nui/` folder. Check the F8 console for errors. |
| "Table not found" or SQL errors | Verify your MySQL resource is running and `gfx-lib` is configured to use the correct SQL driver. The table auto-creates on first boot. |
| Kit shows as locked | The `playerCanInteract` function for that kit is returning `false`. Check the condition (e.g., Discord role, job check). |
| Kit claim returns false / cannot claim | The cooldown has not expired yet. Check the `duration` value (in hours) in the kit config. |
| Items not received after claiming | Verify the item names in the kit config match your framework's item registry exactly (e.g., `weapon_carbinerifle`, not `carbinerifle`). |
| Discord role check not working | Ensure a Discord permissions resource (e.g., `discord_perms`) is installed and the `HasPlayerHasRoleOnDiscord` function is updated to use its exports. The default config has a placeholder implementation. |
| NUI panel is blank or broken | Check that the `nui/` folder contains `index.html` and all required assets. Verify no file path errors in the F8 console. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-kit
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
