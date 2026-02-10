# gfx-squad-remake

A full-featured squad/party system for FiveM with a React-based NUI interface. Players can create squads, invite members, chat, and track teammates with map blips, nametags, and a HUD overlay showing member health and armor. Supports optional friendly fire protection between squad members.

---

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-squad-remake` |
| **Version** | 1.0.0 |
| **Author** | GFX Development |
| **Framework** | ESX / QBCore (auto-detected via gfx-lib) |
| **Side** | Client + Server |
| **UI** | React (NUI) |
| **Lua 5.4** | Yes |

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| `gfx-lib` | Framework detection, player photo retrieval, notification module |

---

## Installation

### 1. Copy the resource folder
Place the `gfx-squad-remake` folder into your server's resources directory.

### 2. Add to server.cfg
```cfg
ensure gfx-lib
ensure gfx-squad-remake
```

Make sure `gfx-lib` starts before `gfx-squad-remake`.

### 3. Configure Discord Bot Token (optional)
If you want player avatars fetched from Discord, set your bot token in `config/server_config.lua`:
```lua
Config = {
    DiscordBotToken = "YOUR_BOT_TOKEN_HERE",
}
```

---

## Configuration

### Client Config (`config/client_config.lua`)

```lua
Config = {
    FriendlyFire = false,         -- false = squad members cannot damage each other
    HudInterval = 5000,           -- HUD update interval in milliseconds (used for infinity mode, currently disabled)
    Theme = {
        ["primary"] = '#FF2F2F',                    -- Primary UI color
        ["primary-content"] = '#900000',            -- Primary content/accent color
        ["primary-opacity"] = "rgba(255, 47, 47, 0.2)", -- Primary color with transparency
    }
}
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `FriendlyFire` | boolean | `false` | When `false`, squad members cannot deal damage to each other using GTA relationship groups |
| `HudInterval` | number | `5000` | HUD data refresh interval in ms |
| `Theme.primary` | string | `#FF2F2F` | Primary theme color for the NUI |
| `Theme.primary-content` | string | `#900000` | Content/accent theme color |
| `Theme.primary-opacity` | string | `rgba(255, 47, 47, 0.2)` | Primary color with opacity for backgrounds |

### Server Config (`config/server_config.lua`)

```lua
local modules = exports["gfx-lib"]:getModules()

Config = {
    DiscordBotToken = "",               -- Discord bot token for fetching player avatars
    Notify = function(source, message)  -- Notification function (customizable)
        modules.Notify(source, message)
    end,
}
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `DiscordBotToken` | string | `""` | Bot token used to fetch Discord profile pictures for squad member avatars |
| `Notify` | function | gfx-lib Notify | Override with your own notification function. Receives `source` (player ID) and `message` (string) |

### Locale (`config/locale.lua`)

The script supports localization. Set the active locale:
```lua
Locale = 'en'
```

All UI strings are defined in the `Locales` table and can be translated by adding a new language key.

---

## Exports

All exports are **server-side**.

### GetSquadMembers

Returns a table of server IDs of all members in the player's squad.

```lua
-- Server-side
local memberIds = exports['gfx-squad-remake']:GetSquadMembers(source)
-- Returns: { 1, 4, 7 } (table of server IDs) or {} if not in a squad
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | The player's server ID |

**Returns:** `table` - Array of server IDs of squad members, or empty table if the player is not in a squad.

---

### GetSquadData

Returns the full squad data object for the player's current squad.

```lua
-- Server-side
local squad = exports['gfx-squad-remake']:GetSquadData(source)
--[[
Returns:
{
    id = 123456,              -- Unique squad ID
    name = "Squad Name",      -- Squad name
    owner = 4,                -- Owner's server ID
    image = "https://...",    -- Squad avatar image URL
    privacy = "public",       -- "public" or "private"
    memberLimit = 12,         -- Maximum member count
    members = { ... },        -- Array of member objects
    chat = { ... }            -- Array of chat messages
}
]]
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | The player's server ID |

**Returns:** `table` - Full squad data object, or empty table if not in a squad.

---

### HasMemberGotASquad

Checks whether a player is currently in any squad.

```lua
-- Server-side
local inSquad = exports['gfx-squad-remake']:HasMemberGotASquad(source)
-- Returns: true or false
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | The player's server ID |

**Returns:** `boolean` - `true` if the player is in a squad, `false` otherwise.

---

### GetSquadId

Returns the squad ID of the player's current squad.

```lua
-- Server-side
local squadId = exports['gfx-squad-remake']:GetSquadId(source)
-- Returns: 123456 (number) or nil
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | The player's server ID |

**Returns:** `number|nil` - The squad ID, or `nil` if the player is not in a squad.

---

## Events

*No public API events found.* All events used by this script are internal (NUI communication, member sync, relationship handling).

---

## Commands

| Command | Description |
|---------|-------------|
| `/squad` | Opens the squad NUI menu where players can create, browse, join, and manage squads |

---

## Features

- **Squad Creation** - Create squads with a custom name, avatar image, privacy setting (public/private), and member limit
- **Squad Browsing** - Browse and join public squads through the NUI menu
- **Invite System** - Squad owners can invite other players; invited players receive a notification and pending invite count
- **Squad Chat** - Real-time in-squad text chat with timestamps and player avatars
- **Member HUD** - On-screen HUD overlay showing squad member names, health bars, and armor values (position and alignment configurable per player)
- **Map Blips** - Squad members appear as blips on the minimap with their name, updated every 5 seconds
- **Nametags** - GTA MP-style gamer tags above squad members showing name and health bar with color-coded health (green > yellow > red)
- **Friendly Fire Protection** - Optional feature that prevents squad members from damaging each other using GTA relationship groups
- **Squad Settings** - Owners can update squad name, avatar, privacy, and member limit after creation
- **Kick Members** - Squad owners can kick members from the squad
- **Player Avatars** - Automatic avatar fetching from Discord (via bot token) or Steam profile pictures
- **Personal Settings** - Each player can toggle HUD, nametags, and blips visibility, and choose HUD alignment (left/center/right)
- **Waypoint Sharing** - Click on a squad member in the UI to set a waypoint to their location
- **Auto-Cleanup** - When an owner disconnects, the squad is deleted; when a member disconnects, they leave the squad automatically
- **Localization** - Full locale support with all UI strings configurable
- **Theme Customization** - Configurable primary colors for the NUI interface
- **React NUI** - Modern React-based user interface

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Squad menu does not open | Ensure `gfx-lib` is started before `gfx-squad-remake` in your `server.cfg` |
| Player avatars show as default | Set a valid Discord bot token in `server_config.lua`. The bot must be in your Discord server and have permission to read user profiles |
| Blips not appearing on map | Check that the player has blips enabled in their personal settings. Blips update every 5 seconds |
| Nametags not showing | Ensure nametags are enabled in personal settings. The target player must be within 100 units and their ped must be active/streamed |
| Friendly fire still works | Make sure `Config.FriendlyFire` is set to `false` in `client_config.lua`. Note: this uses GTA relationship groups, which may not prevent all damage types |
| NUI not loading | Verify that the `web/build/` folder exists and contains the compiled React app (`index.html` and assets) |
| Framework not detected | Ensure `gfx-lib` is properly configured and your framework (`es_extended` or `qb-core`) is started before `gfx-lib` |
| Chat messages not syncing | Messages are stored in memory only and reset on server restart. This is by design -- squads do not persist across restarts |
