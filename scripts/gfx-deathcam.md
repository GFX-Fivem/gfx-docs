# gfx-deathcam

A cinematic death camera script for FiveM. When a player is killed by another player, a camera locks onto the killer showing their name, avatar, health, armor, weapon used, and damage dealt. Supports both Discord and Steam profile pictures.

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx-deathcam` |
| **FX version** | `cerulean` |
| **Game** | `gta5` |
| **Lua 5.4** | Yes |
| **NUI** | Yes (Vue.js) |
| **Escrow ignored** | `config.lua`, `svconfig.lua` |
| **Side** | Client + Server |

---

## Dependencies

| Dependency | Type | Description |
|------------|------|-------------|
| `discord-id` | npm | Fetches Discord user profile pictures via bot token |
| `steamapi` | npm | Fetches Steam user profile pictures via Steam Web API |

> **Note:** If using Steam profile pictures, the `steam_webApiKey` convar must be set in your `server.cfg`.

---

## Installation

### 1. Copy Files
```bash
cp -r gfx-deathcam /path/to/resources/
```

### 2. Install Node Dependencies
```bash
cd /path/to/resources/gfx-deathcam
npm install
```

### 3. server.cfg
```cfg
ensure gfx-deathcam
```

If using Steam avatars, also add:
```cfg
set steam_webApiKey "YOUR_STEAM_WEB_API_KEY"
```

---

## Configuration

### config.lua (shared)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `duration` | `number` | `4000` | Duration of the death camera in milliseconds |
| `resetDamageTime` | `number` | `4000` | Time in ms after which accumulated damage tracking is reset |
| `WeaponNames` | `table` | *(see below)* | Mapping of weapon hashes to display names shown on the HUD |

```lua
Config = {
    duration = 4000,
    resetDamageTime = 4000,
    WeaponNames = {
        [453432689] = "Pistol",
        [-1074790547] = "Clash Cove",
        -- ... (full weapon hash to name mapping)
    },
}
```

### svconfig.lua (server)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `discordToken` | `string` | `""` | Discord bot token for fetching Discord profile pictures |
| `showDiscordPP` | `boolean` | `false` | `true` = use Discord avatar, `false` = use Steam avatar |

```lua
SVConfig = {
    discordToken = "",
    showDiscordPP = false,
}
```

---

## Exports

Exports that other scripts can call:

### Server Exports

#### `GetConfig`
Returns the server configuration table (`SVConfig`).

```lua
local svconfig = exports['gfx-deathcam']:GetConfig()
print(svconfig.showDiscordPP) -- true or false
```

**Returns:** `table` - The `SVConfig` table

---

#### `GetIdentifier`
Retrieves a specific identifier for a player (e.g., `steam`, `discord`, `license`).

```lua
local steamId = exports['gfx-deathcam']:GetIdentifier(source, "steam")
local discordId = exports['gfx-deathcam']:GetIdentifier(source, "discord")
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| `source` | `number` | The player's server ID |
| `type` | `string` | Identifier type to search for (e.g. `"steam"`, `"discord"`, `"license"`) |

**Returns:** `string|nil` - The full identifier string, or `nil` if not found

---

#### `GrabDiscordPP`
Fetches a player's Discord profile picture URL. Requires `discordToken` to be set in `svconfig.lua`.

```lua
local avatarUrl = exports['gfx-deathcam']:GrabDiscordPP(playerId)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| `playerId` | `number` | The player's server ID |

**Returns:** `string|nil` - The Discord avatar URL, or `nil` if unavailable

---

#### `GrabSteamPP`
Fetches a player's Steam profile picture URL. Requires the `steam_webApiKey` convar to be set.

```lua
local avatarUrl = exports['gfx-deathcam']:GrabSteamPP(playerId)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| `playerId` | `number` | The player's server ID |

**Returns:** `string|nil` - The Steam avatar URL (large size), or `nil` if unavailable

---

## Events

*No public API events found.* All events used by this script are internal callback mechanisms.

---

## Commands

| Command | Description |
|---------|-------------|
| `/kill` | Debug command. Kills the local player (sets health to 0). Should be removed or restricted in production. |

---

## Features

- Cinematic scripted camera that locks onto and follows the killer on death
- Displays killer's name, profile picture, health bar, and armor bar
- Shows weapon name used for the kill (configurable weapon hash mapping)
- Tracks cumulative damage dealt (HP damage, armor damage, hit count) per encounter
- Automatic damage tracking reset after configurable timeout
- Supports both Discord and Steam profile pictures
- NUI overlay built with Vue.js
- Escrow-ready with `config.lua` and `svconfig.lua` excluded from encryption

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| No avatar showing | Check that `discordToken` is set (if using Discord) or `steam_webApiKey` convar is set (if using Steam) |
| Steam avatar not loading | Ensure the `steam_webApiKey` convar is added to your `server.cfg` with a valid Steam Web API key |
| Discord avatar not loading | Verify the Discord bot token is valid and the bot has access to user profiles |
| Camera not activating on death | Deathcam only triggers when killed by another player ped. Deaths from NPCs, vehicles, falls, or environment do not trigger it |
| Weapon name shows as `nil` | The weapon hash is not mapped in `Config.WeaponNames`. Add the missing hash to `config.lua` |
| `npm install` errors | Make sure Node.js is installed on the server and run `npm install` inside the `gfx-deathcam` folder |
| Damage numbers seem wrong | Damage accumulation resets every `resetDamageTime` ms. If the time between hits exceeds this, tracking restarts |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-deathcam
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
