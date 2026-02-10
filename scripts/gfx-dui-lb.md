# gfx-dui-lb

## Info

| Key | Value |
|-----|-------|
| **Name** | gfx-dui-lb |
| **Author** | GFX Development |
| **Version** | 1.0.0 |
| **FX Version** | cerulean |
| **Lua** | 5.4 |
| **Games** | GTA5, RDR3 |
| **UI** | NUI (React + TypeScript) |
| **Repository** | https://github.com/GFX-Fivem/fivem-script-boilerplate |

DUI-based leaderboard script with a React (TypeScript) NUI interface. Automatically detects ESX or QBCore frameworks and adapts accordingly. Supports player avatar fetching from Steam or Discord, customizable UI theming, and multi-language localization.

---

## Dependencies

| Dependency | Required | Notes |
|-----------|----------|-------|
| **ESX** or **QBCore** | Yes | One framework must be running. Auto-detected at startup. |
| **SQL resource** | Yes | One of: `oxmysql`, `ghmattimysql`, `mysql-async`. Auto-detected. |
| **Discord Bot Token** | Optional | Required only if `Config.PhotoType` is set to `"discord"` in server config. |

The script also auto-detects the following (if present) through its server utilities:
- **Inventory**: `qb-inventory`, `esx_inventoryhud`, `qs-inventory`, `codem-inventory`, `gfx-inventory`, `ox_inventory`, `ps-inventory`
- **Skin script**: `esx_skin`, `qb-clothing`, `skinchanger`, `illenium-appearance`, `fivem-appearance`

---

## Installation

### 1. Copy Files
Place the `gfx-dui-lb` folder into your server's resources directory.

### 2. Build the Web UI
Navigate to the `web` folder and install dependencies, then build:
```bash
cd gfx-dui-lb/web
npm install
npm run build
```
This generates the `web/build/` folder required by the NUI.

### 3. server.cfg
Add to your `server.cfg`:
```cfg
ensure gfx-dui-lb
```

Make sure the script starts **after** your framework resource (ESX/QBCore) and your SQL resource.

### 4. Configure
Edit the configuration files in the `config/` folder (see Configuration section below).

---

## Configuration

### config/client_config.lua

```lua
Config = {
    Theme = {
        ["primary"] = '#ff4f22',            -- Primary color (hex)
        ["primary-content"] = '#900000',     -- Primary content/text color
        ["primary-opacity"] = "rgba(255, 47, 47, 0.2)", -- Primary with opacity (rgba)
        ["secondary"] = "#FF2F2F",           -- Secondary color
        ["secondary-content"] = '#900000',   -- Secondary content/text color
        ["secondary-opacity"] = "rgba(255, 47, 47, 0.2)", -- Secondary with opacity
    }
    -- Notify = function(source, message)
    -- end, -- Uncomment and add your notification export for custom client notifications
}
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Theme.primary` | string | `'#ff4f22'` | Main UI accent color |
| `Theme.primary-content` | string | `'#900000'` | Text/content color for primary elements |
| `Theme.primary-opacity` | string | `'rgba(255, 47, 47, 0.2)'` | Semi-transparent primary color for backgrounds |
| `Theme.secondary` | string | `'#FF2F2F'` | Secondary UI color |
| `Theme.secondary-content` | string | `'#900000'` | Text/content color for secondary elements |
| `Theme.secondary-opacity` | string | `'rgba(255, 47, 47, 0.2)'` | Semi-transparent secondary color for backgrounds |
| `Notify` | function or nil | `nil` | Optional custom notification function. If not set, uses framework default (ESX/QBCore). |

### config/server_config.lua

```lua
Config = {
    PhotoType = "steam",                -- "steam" or "discord"
    NoImage = "https://cdn.discordapp.com/attachments/.../noimage.png",
    DiscordBotToken = "YOUR_DISCORD_BOT_TOKEN",
    -- Notify = function(source, message)
    -- end, -- Uncomment and add your notification export for custom server notifications
}
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PhotoType` | string | `"steam"` | Player avatar source: `"steam"` for Steam profile pictures, `"discord"` for Discord avatars. |
| `NoImage` | string | *(URL)* | Fallback image URL when a player's avatar cannot be fetched. |
| `DiscordBotToken` | string | `"YOUR_DISCORD_BOT_TOKEN"` | Your Discord bot token. Required only when `PhotoType` is `"discord"`. |
| `Notify` | function or nil | `nil` | Optional custom server-side notification function `(source, message)`. Falls back to framework notifications if not set. |

### config/locale.lua

```lua
Locale = 'en'  -- Active locale key

Locales = {
    ["en"] = {
        ["test"] = "Test"
    },
    ["fr"] = {
        ["test"] = "Test"
    }
}
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Locale` | string | `"en"` | Active language. Must match a key in `Locales`. |
| `Locales` | table | `{ en, fr }` | Language translation tables. Add new languages by adding a new key with translated strings. |

Use `_L("key")` in Lua to retrieve a translated string.

---

## Exports

*No exports found.*

This script does not register any callable exports via `exports('name', function)`.

---

## Events

*No public API events found.*

All events used by the script are internal (NUI callbacks, framework detection, internal callback system). There are no public events intended for external scripts to listen to or trigger.

---

## Commands

| Command | Description | Permission |
|---------|-------------|------------|
| `/boiler` | Opens the leaderboard NUI interface. Toggles NUI focus and displays the UI frame. | None (any player) |

---

## Features

- NUI interface built with React and TypeScript (Vite + Tailwind CSS)
- Automatic framework detection (ESX / QBCore)
- Automatic SQL resource detection (oxmysql / ghmattimysql / mysql-async)
- Automatic inventory system detection (supports 7 inventory resources)
- Automatic skin script detection (supports 5 skin resources)
- Player avatar fetching from Steam profile or Discord (via bot token)
- Fully customizable UI theme colors (primary, secondary, opacity variants)
- Multi-language localization support
- Custom notification function override (client and server side)
- Callback system with promise-based async/await pattern and 15-second timeout
- Debug mode via convar (`setr gfx-dui-lb-debugMode 1`)
- Escrow support (dual escrow/open-source zip packaging)
- Lua 5.4 enabled

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| **UI does not appear** | Make sure the `web/build/` directory exists. Run `npm install && npm run build` inside the `web/` folder. |
| **"Locale not found" / "Key not found"** | Verify that `Locale` in `config/locale.lua` matches a key in the `Locales` table, and that the translation key exists for that language. |
| **No player avatars showing** | If using `"steam"`, ensure players have Steam identifiers. If using `"discord"`, verify your `DiscordBotToken` is valid and the bot has access to user data. |
| **Framework not detected** | Ensure your framework resource (`es_extended` or `qb-core`) is started **before** this script in `server.cfg`. |
| **SQL errors** | Confirm one of the supported SQL resources (`oxmysql`, `ghmattimysql`, `mysql-async`) is running and started before this script. |
| **Debug output not showing** | Enable debug mode with `setr gfx-dui-lb-debugMode 1` in your `server.cfg` or server console. |
| **Fallback/default avatar image** | The `Config.NoImage` URL is used when a player avatar cannot be retrieved. Update it to a valid image URL if the default CDN link is broken. |
