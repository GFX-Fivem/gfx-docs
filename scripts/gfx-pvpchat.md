# gfx-pvpchat

A custom PVP-oriented chat system for FiveM with a React-based NUI interface, supporting multiple chat groups (all, crew, squad), player muting, customizable name colors, player avatars, and admin features.

---

## Info

| Key | Value |
|---|---|
| **Author** | GFX Development |
| **Version** | 1.0.0 |
| **Games** | GTA5, RDR3 |
| **Framework** | ESX / QBCore (auto-detected) |
| **UI** | React (NUI) |

---

## Dependencies

| Dependency | Required | Description |
|---|---|---|
| **es_extended** or **qb-core** | Yes | Framework for player data, names, and admin checks |
| **gfx-crew** | No | Crew integration for crew chat group and crew name display |
| **gfx-squad-remake** | No | Squad integration for squad chat group |
| **Discord Bot Token** | No | Required only if `PhotoType` is set to `"discord"` in server config |

---

## Installation

### 1. Copy the resource
Place the `gfx-pvpchat` folder into your server's resources directory.

### 2. Add to server.cfg
```cfg
ensure gfx-pvpchat
```

### 3. Configure
Edit the config files in the `config/` folder to match your server setup (see Configuration below).

---

## Configuration

### Client Config (`config/client_config.lua`)

```lua
Config = {
    Theme = {
        ["primary"] = '#ff4f22',           -- Primary UI color
        ["primary-content"] = '#900000',   -- Primary content/text color
        ["primary-opacity"] = "rgba(255, 47, 47, 0.2)", -- Primary with opacity
        ["secondary"] = "#FF2F2F",         -- Secondary UI color
        ["secondary-content"] = '#900000', -- Secondary content/text color
        ["secondary-opacity"] = "rgba(255, 47, 47, 0.2)", -- Secondary with opacity
    }
}
```

#### Editable Functions (client_config.lua)

| Function | Description |
|---|---|
| `GetCrewId()` | Returns the player's crew ID. Uses `gfx-crew` by default. Replace with your own crew export if needed. |
| `GetSquadId()` | Returns the player's squad ID. Returns `1` by default. Replace with your own squad logic. |
| `IsAdmin()` | Checks if the local player is an admin. Uses `IsAceAllowed("admin")` by default. |

### Server Config (`config/server_config.lua`)

```lua
Config = {
    PhotoType = "steam",   -- Player avatar source: "steam" or "discord"
    NoImage = "https://...", -- Fallback image URL when no avatar is found
    DiscordBotToken = "YOUR_DISCORD_BOT_TOKEN", -- Required only if PhotoType is "discord"
}
```

| Option | Type | Description |
|---|---|---|
| `PhotoType` | `string` | Avatar source. `"steam"` fetches Steam profile pictures, `"discord"` fetches Discord avatars via bot API. |
| `NoImage` | `string` | Fallback avatar URL used when the player's avatar cannot be retrieved. |
| `DiscordBotToken` | `string` | Your Discord bot token. Only needed when `PhotoType` is `"discord"`. |

### Locale (`config/locale.lua`)

```lua
Locale = 'en' -- Change to your preferred locale key (e.g., 'en', 'fr')
```

---

## Exports

### Client Exports

#### `GetPlayerColor`
Returns the current chat name color of the local player.

```lua
local color = exports['gfx-pvpchat']:GetPlayerColor()
-- Returns: string (hex color, e.g. "#ffffff")
```

### Server Exports

#### `GetPlayerColor`
Returns the chat name color of a specific player on the server.

```lua
local color = exports['gfx-pvpchat']:GetPlayerColor(playerId)
-- @param playerId (number) - The player's server ID
-- Returns: string|nil (hex color or nil if not set)
```

---

## Events

### Client Events

#### `chat:addMessage`
Adds a message to the chat UI for a specific chat group. Triggered by the server to broadcast messages.

```lua
-- Listening (client-side):
RegisterNetEvent('chat:addMessage', function(messageData, group)
    -- messageData: table { text, color, userName, isAdmin, playerId, crewName }
    -- group: string ("all", "crew", "squad")
end)
```

#### `chat:server:playerMuted`
Notifies the client that the player has been muted.

```lua
-- Listening (client-side):
RegisterNetEvent('chat:server:playerMuted', function(seconds)
    -- seconds: number - Duration of mute in seconds
end)
```

#### `chat:server:unMutePlayer`
Notifies the client that the player has been unmuted.

```lua
-- Listening (client-side):
RegisterNetEvent('chat:server:unMutePlayer', function()
    -- Player is now unmuted
end)
```

### Server Events

#### `_chat:messageEntered`
Triggered from the client when a player sends a message in the "all" chat group. The server processes it, checks mute status, and broadcasts to all players.

```lua
-- Triggering (client-side):
TriggerServerEvent('_chat:messageEntered', message, group)
-- @param message (string) - The chat message text
-- @param group (string) - The chat group ("all")
```

#### `chat:setPlayerColor`
Triggered from the client when a player changes their chat name color via the UI.

```lua
-- Triggering (client-side):
TriggerServerEvent('chat:setPlayerColor', color)
-- @param color (string) - Hex color string (e.g. "#ff0000")
```

---

## Commands

| Command | Keybind | Description |
|---|---|---|
| `chat` | `T` | Opens the chat input. Toggles NUI focus. |
| `changeMode` | `L` | Cycles chat visibility mode: `visible` -> `on_message` -> `hidden`. |

---

## Features

- **Multiple Chat Groups** -- Supports "all" (global), "crew", and "squad" chat channels with tab switching in the UI.
- **React NUI Interface** -- Modern web-based chat UI built with React.
- **Player Muting** -- Admins can mute players for a specified duration (minutes, hours, or days). Muted players cannot send messages.
- **Custom Name Colors** -- Players can set their chat name color through the UI. Colors persist per session.
- **Player Avatars** -- Fetches player profile pictures from Steam or Discord (configurable).
- **Admin Badge** -- Admin players are identified in chat messages.
- **Crew Name Display** -- If `gfx-crew` is running, crew short names appear alongside player names.
- **Chat Visibility Modes** -- Three modes: always visible, show on new message only, or fully hidden.
- **Command Suggestions** -- Auto-populates available slash commands based on the player's ACE permissions.
- **Framework Auto-Detection** -- Automatically detects ESX or QBCore for player names and admin checks.
- **Customizable Theme** -- Client config allows full color theme customization for the UI.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Chat does not open when pressing T | Ensure `gfx-pvpchat` is started in server.cfg. Check for conflicting resources that also bind the `chat` command or key `T`. |
| Player avatars not loading | If using `"steam"`, ensure players have Steam identifiers. If using `"discord"`, verify the `DiscordBotToken` is valid and the bot is in your Discord server. |
| Crew chat not working | Ensure `gfx-crew` is started before `gfx-pvpchat`. The script checks resource state on startup. |
| Squad chat not working | Ensure `gfx-squad-remake` is started before `gfx-pvpchat`. |
| Player names showing as nil | Ensure your framework (ESX or QBCore) is running and players are fully loaded before sending messages. |
| Mute not persisting after restart | Mute data is stored in memory only. It resets on resource or server restart. |
| UI theme not applying | Ensure `client_config.lua` is loaded before `client.lua` in the fxmanifest (it is by default). Changes require resource restart. |
| Chat visibility mode not cycling | Make sure key `L` is not bound to another action. You can change the keybind via FiveM settings under Key Mappings. |
