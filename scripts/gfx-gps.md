# gfx-gps

A GPS and bodycam tracking system for law enforcement jobs. Officers can activate GPS devices to share their live location with colleagues on the map, use bodycams to allow supervisors to spectate through a CCTV-style camera, and manage unit call-sign codes (NATO phonetic prefixes). Includes a control room panel for supervisors with player pinning, spectating, and code management.

---

## Info

| Key | Value |
|---|---|
| **Author** | atiysu |
| **Resource Name** | `gfx-gps` |
| **Framework** | ESX / QBCore |
| **UI** | NUI (HTML/JS) |
| **Data Storage** | `database.json` (file-based) |

---

## Dependencies

- **ESX** (`es_extended`) or **QBCore** (`qb-core`)
- A Discord Bot Token (optional, used to fetch player profile avatars)

---

## Installation

### 1. Copy the resource
Place the `gfx-gps` folder into your server's resources directory.

### 2. Add items to your framework
Add the following items to your shared items / database:

| Item | Default Name | Description |
|---|---|---|
| GPS Device | `gps` | Toggles officer GPS tracking on/off |
| Bodycam | `bodycam` | Toggles officer bodycam on/off |

### 3. server.cfg
```cfg
ensure gfx-gps
```

### 4. Discord Bot Token (optional)
In `serverconfig.lua`, set your Discord bot token to enable player avatar fetching:
```lua
Config.DiscordBotToken = "YOUR_BOT_TOKEN_HERE"
```

---

## Configuration

Configuration is in `config.lua`.

### Framework
```lua
Config.Framework = "esx" -- "qb" or "esx"
```

### Items
```lua
Config.GpsItem = "gps"         -- GPS item name in your framework
Config.BodyCamItem = "bodycam" -- Bodycam item name in your framework
```

### Menu Command
```lua
Config.MenuCommand = "polices" -- Chat command to open the GPS panel (no slash)
```

### Notification Function
```lua
Config.Notify = function(message, type, length)
    -- Customize notification delivery
end
```

### Whitelisted Jobs
Define which jobs can use the GPS system:
```lua
Config.WhitelistedJobs = {
    ["police"] = { enabled = true },
    ["ambulance"] = { enabled = true },
}
```

### GPS Control Rooms
Physical locations where supervisors can access the boss panel. Each job gets one control room with a minimum grade requirement:
```lua
Config.GpsControlRooms = {
    ["police"] = {
        x = 448.2043,
        y = -973.1937,
        z = 30.6896,
        mingrade = 3, -- Minimum job grade to access the control room
    },
    ["ambulance"] = {
        x = 307.5563,
        y = -596.4658,
        z = 43.1279,
        mingrade = 1,
    },
}
```

### Blip Customization
Blip sprite and color per job:
```lua
Config.Blips = {
    ["police"] = { sprite = 57, color = 3 },
    ["ambulance"] = { sprite = 1, color = 1 },
}
```

### Vehicle Blip Types
Blip sprites change based on the vehicle type the officer is in:
```lua
Config.BlipTypes = {
    ["automobile"] = 56,
    ["bike"] = 226,
    ["boat"] = 427,
    ["plane"] = 423,
    ["heli"] = 43,
    ["train"] = 67,
    ["submarine"] = 308,
    ["blimp"] = 423,
    ["dirigible"] = 423,
    ["parachute"] = 550,
    ["vehicle"] = 56,
}
```

### Code Prefixes (NATO Phonetic)
Officers are assigned a call-sign code with a NATO phonetic prefix. Each prefix starts numbering from a base value:
```lua
Config.CodePrefixes = {
    ["UNKNOWN"] = 000,
    ["ALPHA"] = 100,
    ["BRAVO"] = 200,
    ["CHARLIE"] = 300,
    ["DELTA"] = 400,
    ["ECHO"] = 500,
    ["FOXTROT"] = 600,
    ["GOLF"] = 700,
    ["HOTEL"] = 800,
    ["INDIA"] = 900,
}
```

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events for external scripts. All events are internal to the resource.*

---

## Commands

| Command | Description | Access |
|---|---|---|
| `/polices` (configurable via `Config.MenuCommand`) | Opens the GPS tracking panel UI | Whitelisted job + GPS must be active |

---

## Features

- **GPS Tracking** -- Officers use the `gps` item to toggle live location sharing. All active officers see each other on the minimap with labeled blips.
- **Bodycam System** -- Officers use the `bodycam` item to toggle a virtual bodycam. Supervisors can spectate officers who have bodycam enabled via a CCTV-style camera view.
- **Dynamic Blips** -- Blip sprites change based on whether the officer is on foot, in a vehicle, or has sirens active. Siren-active officers show a distinct chase blip.
- **Control Room (Boss Panel)** -- Supervisors meeting the minimum grade can access a physical control room location (marker + interact) to open an advanced panel with spectate and code management.
- **Officer Panel (Command)** -- Regular officers with GPS active can open the panel via the chat command to view all tracked officers and ping locations.
- **Call-Sign Codes** -- Each officer is assigned a unique code with a NATO phonetic prefix (e.g., ALPHA-102). Codes persist across sessions in `database.json`. Supervisors can reassign prefixes from the boss panel.
- **Player Pinning** -- From the panel, officers can ping another officer's location, which sets a waypoint on the map.
- **Spectate Mode** -- Supervisors can spectate an officer's bodycam feed with a CCTV filter effect. Press `E` to exit spectate mode. Street name overlay is shown during spectate.
- **Discord Avatars** -- Player profile pictures are fetched from Discord (via bot token) and displayed in the UI panel.
- **Multi-Framework** -- Supports both ESX and QBCore with automatic framework detection via config.
- **Auto-Cleanup** -- GPS data and blips are cleaned up on player disconnect or job change to a non-whitelisted job.
- **Item Validation** -- Server periodically checks that officers still have the GPS/bodycam items in inventory. If removed, the corresponding feature is automatically disabled.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| GPS item does nothing | Ensure the item name in `Config.GpsItem` matches your framework's shared items exactly. |
| "You don't have permission" notification | The player's job is not in `Config.WhitelistedJobs` or the job is not set to `enabled = true`. |
| Control room marker not showing | Verify the player's job grade meets the `mingrade` in `Config.GpsControlRooms` and the job is whitelisted. |
| Blips not appearing on map | Make sure GPS is enabled (item used) and at least two officers have GPS active. Blips only show for officers in `ActivePolices`. |
| Player avatars not loading | Set a valid Discord bot token in `serverconfig.lua`. The bot must have access to fetch user data. |
| Spectate not working | The target officer must have bodycam enabled. Check the "Player is not streaming" notification. |
| Command does nothing | The officer must have GPS active (`GpsOn = true`) and be in a whitelisted job. The command only works when GPS is toggled on. |
| Framework errors on startup | Ensure `Config.Framework` is set correctly to `"esx"` or `"qb"` and the corresponding framework resource is started before `gfx-gps`. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-gps
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
