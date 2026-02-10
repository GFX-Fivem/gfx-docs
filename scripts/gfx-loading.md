# gfx-loading

A fully customizable FiveM loading screen featuring a built-in music player, live player list, patch notes, keybind information, social media links, and Steam profile picture integration.

---

## Info

| Key | Value |
|---|---|
| **Resource Name** | `gfx-loading` |
| **Type** | Loading Screen |
| **Side** | Client + Server |
| **Framework** | Standalone (optional ESX / QBCore for RP names) |
| **Escrow** | Supported (`escrow_ignore` defined) |

---

## Dependencies

| Dependency | Required | Notes |
|---|---|---|
| **Steam Web API Key** | Yes | Must be set via `steam_webApiKey` convar in `server.cfg` for player profile pictures |
| **ESX / QBCore** | No | Only required if `Config.RPName.enabled` is `true` |
| **es_extended** | No | Required if framework is set to `"newesx"` or `"esx"` |
| **qb-core** | No | Required if framework is set to `"newqb"` or `"qb"` |

---

## Installation

### 1. Copy Files

Place the `gfx-loading` folder into your server's resources directory.

### 2. Set Steam API Key

Add the following to your `server.cfg`:

```cfg
set steam_webApiKey "YOUR_STEAM_API_KEY_HERE"
```

### 3. Configure Server IP

Open `nui/script.js` and change the `serverIp` variable on line 1 to match your server's IP and port:

```js
const serverIp = "YOUR_SERVER_IP:30120"
```

> **Important:** The loading screen will not function properly without setting the correct server IP in `script.js`.

### 4. Start the Resource

Add to your `server.cfg`:

```cfg
ensure gfx-loading
```

> **Note:** Since this is a loading screen, it should be started early in your `server.cfg` before other resources.

---

## Configuration

All configuration is done in `config.lua`.

### Steam API Key

```lua
Config.SteamAPIKey = GetConvar("steam_webApiKey", "")
```

Automatically reads the Steam Web API key from the server convar. This is used to fetch player profile pictures from Steam.

### RP Name Display

```lua
Config.RPName = {
    enabled = false,                -- Enable/disable RP name display
    framework = "newesx",           -- "esx" | "qb" | "newesx" | "newqb"
}
```

When enabled, player names on the loading screen will show their in-game RP character name instead of their Steam/FiveM name. Supported frameworks:

| Value | Framework |
|---|---|
| `"esx"` | ESX Legacy (old method via `esx:getSharedObject`) |
| `"newesx"` | ESX (new method via `exports['es_extended']`) |
| `"qb"` | QBCore (old method via `QBCore:GetObject`) |
| `"newqb"` | QBCore (new method via `exports['qb-core']`) |

### Music Tracks

```lua
Config.Tracks = {
    {
        image = "https://example.com/cover.jpg",   -- Album cover image URL
        name = "Song Name",                         -- Track title
        singer = "Artist Name",                     -- Artist name
        file = "assets/tracks/music.mp3"            -- Path to audio file in nui/assets/tracks/
    },
}
```

Add music files (`.mp3`) to the `nui/assets/tracks/` folder and reference them in this table. The first track plays automatically on load.

### Server Info

```lua
Config.ServerInfo = {
    ServerName = "GFX Loading Screen",      -- Server name displayed on the loading screen
    ServerImage = "assets/logo.png",        -- Server logo image path (relative to nui/)
    smallTitle = "Details Here",            -- Subtitle text below the server name
    serverDescription = "This is a description",  -- Server description text
}
```

### Update / Patch Notes

```lua
Config.Updates = {
    [1] = {
        title = "New Update",                       -- Update title
        message = "Description of the update...",   -- Update description text
        date = "01.01.2024",                        -- Date string
        publishedBy = "username",                   -- Author name
        publishedByImage = "assets/logo.png",       -- Author avatar image
        image = "assets/logo.png",                  -- Update banner image
    },
}
```

Add multiple entries to display a list of patch notes on the loading screen. Entries are displayed in the "Patch Notes" tab.

### Keybind Information

```lua
Config.Keys = {
    ["ESC"] = {
        title = "Pause Menu",                               -- Key action title
        description = "Press ESC to open the pause menu",   -- Key action description
    },
    ["F2"] = {
        title = "INVENTORY",
        description = "Press F2 to open the inventory",
    },
}
```

Displays keybind hints in the "Game Key Info" tab to inform players about available controls.

### Social Media Links

```lua
Config.SocialMedia = {
    [1] = {
        image = "assets/inst-icon.png",         -- Icon image path (relative to nui/)
        link = "instagram.com/gfxdevs",         -- Social media URL (without https://www.)
    },
}
```

Clickable social media buttons displayed in the "Social Media" tab. The link automatically prepends `https://www.` when opened.

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events are exposed by this script.*

---

## Commands

*No commands are registered by this script.*

---

## Features

- **Customizable Loading Screen** -- Full NUI-based loading screen that replaces the default FiveM loading screen
- **Music Player** -- Built-in audio player with play/pause, next/previous track, volume control, and song progress bar. Supports multiple configurable tracks with album artwork
- **Live Player List** -- Shows currently connected players with their Steam profile pictures and names in real-time
- **Connecting Player Info** -- Displays the connecting player's own name and Steam profile picture
- **Patch Notes / Update Notes** -- Tabbed section to display server updates, changelogs, and announcements with author attribution and images
- **Keybind Guide** -- Tabbed section showing configurable key bindings and their descriptions to onboard new players
- **Social Media Links** -- Tabbed section with clickable social media buttons that open external links
- **Steam Profile Pictures** -- Fetches and displays player avatars from Steam using the Steam Web API
- **RP Name Support** -- Optional integration with ESX or QBCore to display character RP names instead of Steam names
- **Loading Progress Bar** -- Visual progress bar that tracks the actual FiveM loading state (init functions and map data)
- **Tabbed Navigation** -- Three navigable tabs: Patch Notes, Game Key Info, and Social Media
- **Responsive Volume Control** -- Slider-based volume control for the music player

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Loading screen is blank or not showing | Verify `serverIp` in `nui/script.js` matches your server's IP and port |
| Player pictures not loading | Ensure `steam_webApiKey` convar is set correctly in `server.cfg` with a valid Steam Web API key |
| Player names showing Steam name instead of RP name | Set `Config.RPName.enabled = true` and configure the correct `framework` value in `config.lua` |
| Music not playing | Check that `.mp3` files exist in `nui/assets/tracks/` and file paths in `Config.Tracks` are correct |
| Social media links not opening | Ensure link values in `Config.SocialMedia` do not include `https://www.` prefix (it is added automatically) |
| Loading screen not appearing at all | Make sure `ensure gfx-loading` is in your `server.cfg` and the resource is starting without errors |
| RP names returning Steam names as fallback | The player's framework data may not be loaded yet at connect time; this is expected fallback behavior |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-loading
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
