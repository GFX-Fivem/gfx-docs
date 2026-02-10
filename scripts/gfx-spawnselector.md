# GFX Spawn Selector

An interactive spawn location selector for FiveM. Players choose their spawn point from a list of configurable locations displayed alongside a live GTA V map rendered via DUI on an in-world whiteboard prop. The character is placed in a scenic interior room with a scripted camera while the NUI map and location menu are shown. Hovering a location pans the map; clicking "Spawn Here" teleports the player. Supports both QBCore and ESX frameworks.

---

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx-spawnselector` |
| **FX version** | `cerulean` |
| **Game** | `gta5`, `rdr3` |
| **Lua 5.4** | Yes |
| **Side** | Client + Server |
| **UI** | NUI (HTML/JS) + DUI (Leaflet map on in-world whiteboard) |

---

## Dependencies

| Dependency | Required | Notes |
|------------|----------|-------|
| **ESX** (`es_extended`) | If using ESX | Auto-detected at startup |
| **QBCore** (`qb-core`) | If using QBCore | Auto-detected at startup |
| **A SQL resource** | Optional | One of `oxmysql`, `ghmattimysql`, or `mysql-async` -- auto-detected by server utils |

> The script's built-in utils layer auto-detects the active framework, inventory, skin script, and SQL resource. No manual framework setting is needed.

---

## Installation

### 1. Copy Files

Place the `gfx-spawnselector` folder into your server's resources directory.

### 2. Stream Assets

The script uses a custom whiteboard model (`gfx_whiteboard`). Ensure the model and its texture dictionary (`gfx_whiteboard_text`) are streamed. If the resource includes a `stream/` folder, it is handled automatically; otherwise verify the model asset is available on your server.

### 3. server.cfg

```cfg
ensure gfx-spawnselector
```

> Ensure your framework resource (`es_extended` or `qb-core`) starts before `gfx-spawnselector`.

### 4. Configure

Edit `config/client_config.lua` and `config/server_config.lua` to match your server setup (see Configuration section below).

---

## Configuration

### client_config.lua

#### Theme

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Theme["primary"]` | `string` | `'#ff4f22'` | Primary UI accent color |
| `Theme["primary-content"]` | `string` | `'#900000'` | Primary content/text color |
| `Theme["primary-opacity"]` | `string` | `'rgba(255, 47, 47, 0.2)'` | Primary color with opacity for backgrounds |
| `Theme["secondary"]` | `string` | `'#FF2F2F'` | Secondary UI accent color |
| `Theme["secondary-content"]` | `string` | `'#900000'` | Secondary content/text color |
| `Theme["secondary-opacity"]` | `string` | `'rgba(255, 47, 47, 0.2)'` | Secondary color with opacity for backgrounds |

#### Scene Setup

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `WhiteboardModel` | `hash` | `` `gfx_whiteboard` `` | The prop model used to display the DUI map in the world |
| `WhiteboardCoords` | `vector4` | `vector4(1096.41, -3102.96, -39.95, 180.0)` | World position and heading of the whiteboard prop |
| `CharacterPosition` | `vector4` | `vector4(1094.89, -3102.45, -39.0, 337.23)` | Position and heading where the player ped is placed during selection |
| `CameraPosition` | `vector3` | `vector3(1096.05, -3100.83, -38.50)` | Camera world position for the selection scene |
| `CameraRotation` | `vector3` | `vector3(-7.5, 0.0, 180.0)` | Camera rotation (pitch, roll, yaw) for the selection scene |

#### Spawn Locations

| Option | Type | Description |
|--------|------|-------------|
| `SpawnLocations` | `table` | Array of spawn point definitions |

Each spawn location entry:

| Field | Type | Description |
|-------|------|-------------|
| `name` | `string` | Display name shown in the location list and on the map marker |
| `coords` | `vector3` | World coordinates where the player will be teleported |
| `heading` | `number` | Ped heading after spawning (0-360 degrees) |
| `blipSprite` | `number` | Blip sprite ID for the map marker |
| `blipColor` | `number` | Blip color ID for the map marker |
| `preview.coords` | `vector3` | Camera position for previewing this location (used by the preview cam system) |
| `preview.rotation` | `vector3` | Camera rotation for previewing this location |

> The `description` field for each location is automatically populated at runtime using the GTA V street name at the given coordinates.

Example:

```lua
Config.SpawnLocations = {
    {
        name = "Legion Square",
        coords = vector3(213.94, -920.4, 30.69),
        heading = 320.0,
        blipSprite = 1,
        blipColor = 2,
        preview = {
            coords = vector3(213.94, -920.4, 50.69),
            rotation = vector3(-30.0, 0.0, 160.0)
        }
    },
    -- Add more locations here
}
```

### server_config.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PhotoType` | `string` | `"steam"` | Player avatar source. `"steam"` fetches from Steam profile XML, `"discord"` fetches from Discord API |
| `NoImage` | `string` | *(URL)* | Fallback image URL when a player avatar cannot be retrieved |
| `DiscordBotToken` | `string` | `"YOUR_DISCORD_BOT_TOKEN"` | Discord bot token used to fetch player avatars when `PhotoType` is `"discord"` |
| `Notify` | `function\|nil` | `nil` | Optional custom notification function `function(source, message)`. Uncomment and set to override framework notifications |

### locale.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Locale` | `string` | `"en"` | Active locale code |
| `Locales` | `table` | `{ en = {...}, fr = {...} }` | Translation table keyed by locale code. Access translations with `_L("key")` |

---

## Exports

*No exports are created by this script.*

> Note: The client utils file contains several DUI helper functions (`getDui`, `changeDuiUrl`, `releaseDui`, `sendDuiMessage`, `getDuiHandle`) but their export registrations are commented out and not active.

---

## Events

*No public API events are exposed by this script for external use.*

All registered events are internal (framework initialization callbacks, NUI communication, and resource cleanup).

---

## Commands

| Command | Description |
|---------|-------------|
| `/spawnselector` | Opens the spawn selector UI. Displays the map, positions the character in the selection scene, activates the camera, and shows the NUI location menu. |

> There is also a `/boiler` command inherited from the boilerplate template that toggles the NUI frame visibility. This is a development leftover and not intended for production use.

---

## Features

### Interactive Map Display
- **DUI-based Leaflet map** rendered on an in-world whiteboard prop using GTA V Atlas-style map tiles
- **Location markers** placed on the map for each configured spawn point
- **Map panning** -- hovering over a location in the sidebar smoothly pans the map to that point

### Selection Scene
- **Interior room setup** -- the player is teleported to a configured interior position during selection
- **Scripted camera** -- a fixed camera frames the character and whiteboard for a cinematic selection view
- **Character animation** -- the player ped plays an idle guard animation while the selector is open
- **Preview cameras** -- each spawn location has configurable preview camera coordinates for location previews with smooth camera interpolation

### Spawn Location Menu
- **Sidebar UI** with location name, auto-generated street description, optional icon, and a "Spawn Here" button
- **Hover effects** -- non-hovered locations dim to 60% opacity for visual focus
- **Configurable locations** -- add, remove, or modify spawn points entirely through config

### Framework Support
- **Auto-detection** of ESX or QBCore at startup
- **Notification integration** with framework-native notifications (or custom override via config)
- **Player avatar retrieval** via Steam profile or Discord API (server-side)

### Technical
- **DUI pooling system** -- reuses DUI browser instances by size for efficiency
- **Clean resource stop** -- destroys cameras, DUI objects, whiteboard props, and clears ped tasks on resource stop
- **Locale system** -- built-in translation support with `_L()` function

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Map not displaying on whiteboard | Verify the `gfx_whiteboard` model and `gfx_whiteboard_text` texture dictionary are properly streamed. Check that no other resource replaces the same texture |
| Spawn selector not opening | Run `/spawnselector` in chat. Check the F8 console for Lua errors. Ensure the resource started without errors |
| Player stuck after selecting spawn | Ensure `CleanupSpawnSelector` runs correctly. Check that `SetNuiFocus(false, false)` is being called. If the resource errored mid-spawn, restart it |
| Camera not rendering | Verify `Config.CameraPosition` and `Config.CameraRotation` are valid coordinates. The camera is created at resource start -- if the interior is not loaded, it may appear black |
| Discord avatar not loading | Set a valid bot token in `Config.DiscordBotToken` in `server_config.lua`. The bot must be in the same Discord server as the player, or the player's Discord ID must be resolvable |
| Steam avatar not loading | The player must have a Steam identifier. If they connect without Steam, the `Config.NoImage` fallback URL is used |
| NUI focus stuck (cannot move) | This can happen if the resource errors before cleanup. Restart the resource or use another script to call `SetNuiFocus(false, false)` |
| Framework not detected | Ensure `es_extended` or `qb-core` is started before `gfx-spawnselector` in your `server.cfg` |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-spawnselector
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
