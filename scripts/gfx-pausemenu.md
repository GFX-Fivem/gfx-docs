# gfx-pausemenu

A custom pause menu replacement for FiveM that overrides the default GTA V pause menu with a modern NUI-based interface displaying character information, financials, and Steam profile integration.

---

## Info

| Key | Value |
|---|---|
| **Author** | GFX Development |
| **FX Version** | Cerulean |
| **Game** | GTA 5 |
| **Lua** | 5.4 |
| **Side** | Client + Server |
| **UI** | NUI (HTML/CSS/JS) |

---

## Dependencies

| Dependency | Required | Notes |
|---|---|---|
| **Framework** | Yes | One of: `qb-core`, `es_extended` |
| **SQL Resource** | Yes | One of: `oxmysql`, `ghmattimysql`, `mysql-async` |
| **Steam Web API Key** | Recommended | Required for Steam profile pictures. Set via `steam_webApiKey` convar. |

---

## Installation

### 1. Copy the resource
Place the `gfx-pausemenu` folder into your server's resources directory.

### 2. Configure `server.cfg`
```cfg
ensure gfx-pausemenu
```

### 3. Steam API Key (optional)
To enable Steam profile pictures, add your Steam Web API key as a convar in `server.cfg`:
```cfg
set steam_webApiKey "YOUR_STEAM_API_KEY_HERE"
```

---

## Configuration

Configuration is located in `config.lua`:

```lua
Config = {
    Framework = "newqb",        -- Framework: "qb", "newqb", "newesx", "esx"
    NoImage = "https://...",    -- Fallback image when no Steam profile picture is found
    SteamAPIKey = GetConvar("steam_webApiKey", ""),  -- Steam API Key (auto-read from convar)
    SQLScript = "oxmysql",      -- SQL resource: "oxmysql", "ghmattimysql", "mysql-async"
    MoneyIcon = "$",            -- Currency symbol displayed in the UI
}
```

| Option | Type | Default | Description |
|---|---|---|---|
| `Framework` | `string` | `"newqb"` | The framework your server uses. Options: `qb`, `newqb`, `newesx`, `esx` |
| `NoImage` | `string` | Discord CDN URL | Fallback image URL when the player's Steam profile picture cannot be fetched |
| `SteamAPIKey` | `string` | From convar | Steam Web API key used to fetch player profile pictures |
| `SQLScript` | `string` | `"oxmysql"` | The SQL resource your server uses. Options: `oxmysql`, `ghmattimysql`, `mysql-async` |
| `MoneyIcon` | `string` | `"$"` | Currency symbol displayed next to cash and bank values |

### Locales

Locale strings are defined in `locale.lua`:

```lua
Locales = {
    ["male"] = "Male",
    ["female"] = "Female"
}
```

---

## Exports

*No exports are provided by this script.*

---

## Events

*No public API events are provided by this script.* All events are internal to the resource's callback system.

---

## Commands

*No commands are registered by this script.* The pause menu is triggered by the default pause key (P / ESC).

---

## Features

- **Custom Pause Menu** -- Completely replaces the native GTA V pause menu with a modern NUI interface.
- **Character Information** -- Displays the player's character name, job label, date of birth, and gender.
- **Financial Overview** -- Shows current cash and bank balance with a configurable currency icon.
- **Steam Profile Picture** -- Fetches and displays the player's Steam avatar via the Steam Web API.
- **Framework-Specific Data** -- Shows nationality (QB/New QB) or height (ESX/New ESX) depending on the active framework.
- **Map Access** -- Provides a button to open the native GTA V map directly from the pause menu.
- **Settings Access** -- Provides a button to open the native GTA V settings menu.
- **Multi-Framework Support** -- Compatible with QB-Core (old and new) and ESX (old and new).
- **Multi-SQL Support** -- Works with oxmysql, ghmattimysql, and mysql-async.
- **Data Caching** -- Character profile data (name, job, DOB, etc.) is fetched only on first open and cached for subsequent openings. Financial data (cash/bank) is refreshed every time the menu opens.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Pause menu does not open | Ensure the resource is started and no other script is consuming the pause key (control IDs 199/200). |
| Profile picture not showing | Verify that `steam_webApiKey` convar is set in `server.cfg` and the key is valid. The player must have a Steam identifier. |
| "N/A" shown for date of birth or gender | For ESX/New ESX, ensure the `users` table in your database has `dateofbirth` and `sex` columns populated. |
| "N/A" shown for height | For ESX/New ESX, ensure the `users` table has a `height` column. This field is not available on QB frameworks. |
| "N/A" shown for nationality | Nationality is only available on QB/New QB frameworks via `charinfo.nationality`. |
| Cash/Bank values are wrong or nil | Ensure your framework is correctly configured in `Config.Framework` and players have valid money data. |
| SQL errors in console | Verify that `Config.SQLScript` matches the SQL resource you are running on your server. |
| Fallback image shown instead of avatar | The player may not have a linked Steam account, or the Steam API may be rate-limited/unavailable. |

---

## Source

- **GitHub:** [gfx-pausemenu](https://github.com/gfx-fivem/gfx-pausemenu)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
