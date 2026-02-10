# gfx-hacker

## Info

| Key | Value |
|-----|-------|
| **Name** | gfx-hacker |
| **Author** | GFX Development |
| **Version** | 1.0.0 |
| **FX Version** | cerulean |
| **Lua 5.4** | Yes |
| **Games** | GTA5, RDR3 |
| **UI** | NUI (React + Vite + TailwindCSS) |
| **Frameworks** | ESX / QBCore (auto-detected) |
| **Inventories** | qb-inventory, esx_inventoryhud, qs-inventory, codem-inventory, gfx-inventory, ox_inventory, ps-inventory |
| **SQL** | oxmysql, ghmattimysql, mysql-async (auto-detected) |

---

## Description

A hacker-themed NUI interface for FiveM. The script provides a full-screen hacker dashboard with a login page (username selection), a main homepage displaying player stats (hacking banks, computers, ATMs, laundered money), a leveling/XP system, an in-app hacker chat, VPN timer display, navigation (Profile, Leaderboard, Homepage, Store, Settings), and a customizable color theme. Built with React, Redux, TypeScript, and TailwindCSS. Includes built-in framework detection for ESX and QBCore, multi-inventory support, and player photo retrieval (Steam or Discord avatar).

---

## Dependencies

| Dependency | Required | Notes |
|------------|----------|-------|
| **ESX** or **QBCore** | Yes | Auto-detected at runtime |
| **SQL resource** | Yes | One of: oxmysql, ghmattimysql, mysql-async (auto-detected) |
| **Inventory resource** | Optional | Supports: qb-inventory, esx_inventoryhud, qs-inventory, codem-inventory, gfx-inventory, ox_inventory, ps-inventory |
| **Skin script** | Optional | Supports: esx_skin, qb-clothing, skinchanger, illenium-appearance, fivem-appearance |
| **Discord Bot Token** | Optional | Required only if `PhotoType` is set to `"discord"` in server config |

---

## Installation

### 1. Copy the script folder
Place the `gfx-hacker` folder into your server's resources directory.

### 2. Configure server.cfg
```cfg
ensure gfx-hacker
```

### 3. Install NUI dependencies (development only)
If you need to rebuild the web UI:
```bash
cd gfx-hacker/web
npm install
npm run build
```

### 4. Configure the script
Edit `config/client_config.lua` and `config/server_config.lua` to match your preferences (see Configuration section below).

---

## Configuration

### Client Config (`config/client_config.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Theme["primary"]` | string | `'#ff4f22'` | Primary UI color (hex) |
| `Theme["primary-content"]` | string | `'#900000'` | Primary content color (hex) |
| `Theme["primary-opacity"]` | string | `'rgba(255, 47, 47, 0.2)'` | Primary color with opacity (rgba) |
| `Theme["secondary"]` | string | `'#FF2F2F'` | Secondary UI color (hex) |
| `Theme["secondary-content"]` | string | `'#900000'` | Secondary content color (hex) |
| `Theme["secondary-opacity"]` | string | `'rgba(255, 47, 47, 0.2)'` | Secondary color with opacity (rgba) |
| `Notify` | function or nil | `nil` (commented out) | Custom notification function. Uncomment and provide your own export to override default framework notifications. Signature: `function(source, message)` |

### Server Config (`config/server_config.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PhotoType` | string | `"steam"` | Player avatar source. Options: `"steam"`, `"discord"` |
| `NoImage` | string | (Discord CDN URL) | Fallback image URL when no avatar is found |
| `DiscordBotToken` | string | `"YOUR_DISCORD_BOT_TOKEN"` | Discord bot token for fetching Discord avatars. Only needed if `PhotoType` is `"discord"` |
| `Notify` | function or nil | `nil` (commented out) | Custom server-side notification function. Signature: `function(source, message)` |

### Locale (`config/locale.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Locale` | string | `'en'` | Active locale key. Available: `"en"`, `"fr"` |

---

## Exports

*No exports are registered by this script.*

---

## Events

*No public API events are exposed by this script.*

> Internal events (callback system, framework init) are used internally and are not intended for external consumption.

---

## Commands

| Command | Description | Permission |
|---------|-------------|------------|
| `/boiler` | Opens the hacker NUI interface (toggles NUI focus and visibility) | Everyone |

---

## Features

- NUI-based hacker dashboard built with React, Redux, TypeScript, Vite, and TailwindCSS
- Login page with username selection and hacker-themed onboarding flow
- Main dashboard displaying player hacking statistics (banks, computers, ATMs, laundered money)
- Leveling and XP progression system with visual progress bar
- In-app hacker chat with message display
- Navigation bar with sections: Profile, Leaderboard, Homepage, Store, Settings
- VPN status indicator with timer and disconnect button
- Fully customizable color theme via client config (primary/secondary colors with opacity variants)
- Multi-framework support: auto-detects ESX or QBCore at startup
- Multi-inventory support: compatible with 7 popular inventory systems
- Multi-SQL support: works with oxmysql, ghmattimysql, or mysql-async
- Player avatar retrieval from Steam or Discord (configurable)
- Custom notification override support (client and server side)
- Localization system with English and French support
- Escrow-ready with `escrow_ignore` configuration in fxmanifest
- Debug mode via convar (`gfx-hacker-debugMode`)

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| NUI does not open | Ensure the web build exists at `web/build/index.html`. Run `npm run build` inside the `web/` folder if missing. |
| Framework not detected | Make sure ESX (`es_extended`) or QBCore (`qb-core`) starts **before** `gfx-hacker` in your `server.cfg`. |
| Discord avatar not loading | Verify `DiscordBotToken` in `config/server_config.lua` is a valid bot token with user read permissions, and that `PhotoType` is set to `"discord"`. |
| Steam avatar not loading | Ensure players have a Steam identifier. The script fetches avatars from the Steam XML API. If unavailable, the `NoImage` fallback is used. |
| Inventory not detected | Confirm your inventory resource is started before this script. Supported: qb-inventory, esx_inventoryhud, qs-inventory, codem-inventory, gfx-inventory, ox_inventory, ps-inventory. |
| SQL errors | Ensure one of the supported SQL resources (oxmysql, ghmattimysql, mysql-async) is running. |
| Theme not applying | Check that `config/client_config.lua` Theme values are valid CSS color strings (hex or rgba). |
| Debug output not showing | Set the convar: `set gfx-hacker-debugMode 1` in your `server.cfg`. |
