# GFX Killfeed

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-killfeed` |
| **Author** | GFX Development |
| **Version** | 1.0.0 |
| **Games** | GTA5, RDR3 |
| **UI** | NUI (React) |
| **Framework** | ESX / QBCore (auto-detect) |

---

## Dependencies

| Dependency | Required | Notes |
|------------|----------|-------|
| **ESX** or **QBCore** | Yes | Framework is auto-detected at runtime |
| **Discord Bot Token** | Optional | Required only if `PhotoType` is set to `"discord"` in server config |

---

## Installation

### 1. Copy Files
Place the `gfx-killfeed` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-killfeed
```

### 3. Configure
Edit the config files under `config/` to match your server setup (see Configuration below).

---

## Configuration

### Client Config (`config/client_config.lua`)

Handles the NUI theme colors sent to the React frontend.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Theme["primary"]` | string | `'#ff4f22'` | Primary UI color |
| `Theme["primary-content"]` | string | `'#900000'` | Primary content/text color |
| `Theme["primary-opacity"]` | string | `'rgba(255, 47, 47, 0.2)'` | Primary color with opacity |
| `Theme["secondary"]` | string | `'#FF2F2F'` | Secondary UI color |
| `Theme["secondary-content"]` | string | `'#900000'` | Secondary content/text color |
| `Theme["secondary-opacity"]` | string | `'rgba(255, 47, 47, 0.2)'` | Secondary color with opacity |

```lua
Config = {
    Theme = {
        ["primary"] = '#ff4f22',
        ["primary-content"] = '#900000',
        ["primary-opacity"] = "rgba(255, 47, 47, 0.2)",
        ["secondary"] = "#FF2F2F",
        ["secondary-content"] = '#900000',
        ["secondary-opacity"] = "rgba(255, 47, 47, 0.2)",
    }
}
```

### Server Config (`config/server_config.lua`)

Handles player photo retrieval and fallback images.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PhotoType` | string | `"steam"` | Avatar source: `"steam"` or `"discord"` |
| `NoImage` | string | CDN URL | Fallback image URL when no avatar is found |
| `DiscordBotToken` | string | `"YOUR_DISCORD_BOT_TOKEN"` | Discord bot token (required only when `PhotoType` is `"discord"`) |

```lua
Config = {
    PhotoType = "steam",
    NoImage = "https://cdn.discordapp.com/attachments/.../noimage.png",
    DiscordBotToken = "YOUR_DISCORD_BOT_TOKEN",
}
```

### Locale (`config/locale.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Locale` | string | `'en'` | Active language code (`'en'`, `'fr'`) |

Supported languages: English (`en`), French (`fr`).

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events are exposed by this script.*

---

## Commands

| Command | Description |
|---------|-------------|
| `/boiler` | Opens the NUI frame (debug/boilerplate command) |

---

## Features

- NUI-based React interface for killfeed display
- Customizable theme colors via client config
- Player avatar support with two sources:
  - **Steam** -- fetches profile picture from Steam XML API
  - **Discord** -- fetches avatar via Discord Bot API (requires bot token)
- Fallback image when player avatar is unavailable
- Multi-framework support (ESX and QBCore auto-detected)
- Multi-language locale system (English, French)
- Debug mode via server convar (`gfx-killfeed-debugMode 1`)

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| NUI frame does not appear | Ensure the `web/build/` folder exists with compiled React files. Check F8 console for NUI errors. |
| Player avatars not loading (Steam) | Verify the player has a Steam identifier. The script requires a `steam:` identifier to fetch the avatar. |
| Player avatars not loading (Discord) | Set a valid `DiscordBotToken` in `server_config.lua`. Ensure the bot has access to Discord API user endpoints. |
| Fallback image shows for all players | Check `PhotoType` in server config. If set to `"steam"`, players must be connected via Steam. If set to `"discord"`, a valid bot token is needed. |
| Framework not detected | Ensure `es_extended` or `qb-core` is started before `gfx-killfeed` in your `server.cfg`. |
| Debug messages not showing | Enable debug mode with the convar: `set gfx-killfeed-debugMode 1` in your `server.cfg`. |
