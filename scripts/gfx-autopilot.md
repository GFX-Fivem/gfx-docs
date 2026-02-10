# GFX Autopilot

A Tesla-style autopilot system for FiveM that adds autonomous driving, parking assist, emergency mode, and a live map navigation UI to configurable electric vehicles.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-autopilot` |
| **Frameworks** | QBCore, ESX, Standalone |
| **Escrow** | Yes |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `qb-core` or `es_extended` | No | Framework auto-detected at runtime. Standalone works with custom notification function in config. |

## Installation

### 1. Copy Files
Place the `gfx-autopilot` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-autopilot
```

### 3. Configure
Edit `config.lua` to set your allowed vehicles, fixed locations, speed limits, driving modes, and notification texts.

## Configuration

### General

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.UseKmh` | `string` | `"kmh"` | Speed unit displayed in the UI. Use `"kmh"` or `"mph"`. |
| `Config.ComehereModSpeed` | `number` | `40.0` | Vehicle speed when using the `/comehere` summon command. |
| `Config.ComehereModDriveStyle` | `number` | `262701` | GTA driving style flag for the `/comehere` command. |
| `Config.EmergencyLocation` | `table` | `{x=298.0, y=-584.0, z=43.3}` | Destination coordinates for emergency mode. |
| `Config.EmergencyDrivingStyle` | `number` | `262692` | GTA driving style flag for emergency mode driving. |

### Vehicles

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.Vehicles` | `table` | *(see below)* | Hash-keyed table of vehicle models that have autopilot enabled. Only listed vehicles show the autopilot UI. |

Default enabled vehicles: `neon`, `dilettante`, `Imorgon`, `voltic`, `Virtue`, `raiden`, `Cyclone`, `Tezeract`.

Add or remove vehicles:
```lua
Config.Vehicles = {
    [`modelname`] = true,
}
```

### Fixed Locations

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.FixedLocations` | `table` | *(5 presets)* | Named destinations shown as markers on the live map. Each entry has `coords` (x, y, z) and `icon` (asset path). |

Example:
```lua
Config.FixedLocations = {
    policeStation = {
        coords = {x = 402.81, y = -1021.98, z = 28.69},
        icon = "directions/fixedlocations",
    },
}
```

### Speed Multipliers

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.speedMultiplier` | `table` | *(see below)* | Speed values for each driving mode. |

| Mode | Default Speed | Description |
|------|---------------|-------------|
| `ecomode` | `15.0` | Slow, fuel-efficient driving |
| `sportmode` | `40.0` | Normal driving speed |
| `sportPlus` | `100.0` | Fast driving |
| `emergency` | `70.0` | Emergency mode speed |

### Key Bindings

| Option | Key | Control ID | Description |
|--------|-----|------------|-------------|
| `Config.Keys["K"]` | K | 311 | Toggle cursor on the autopilot screen |
| `Config.Keys["U"]` | U | 303 | Cancel current trip or parking |
| `Config.Keys["E"]` | E | 38 | Confirm parking position |
| `Config.Keys["H"]` | H | 74 | Cancel parking placement |
| `Config.Keys["LEFT_ARROW"]` | Left Arrow | 174 | Rotate parking ghost left |
| `Config.Keys["RIGHT_ARROW"]` | Right Arrow | 175 | Rotate parking ghost right |

### Speed Limits

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.SpeedLimits` | `table` | *(200+ streets)* | Street name to speed limit mapping. Displayed as a speed limit sign in the UI when driving on a mapped street. |

### Notification Texts

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.Texts` | `table` | *(see config.lua)* | All user-facing notification strings. Supports `%s` formatting for dynamic autopilot name insertion. |

### Custom Notifications

The `Notify(text, type, time)` function in `config.lua` can be edited to use any notification system. It auto-detects QBCore and ESX by default, with a placeholder for custom systems.

## Exports

*No exports are created by this script.*

## Events

*No public API events are exposed by this script. All interactions are handled through NUI callbacks and internal functions.*

## Commands

| Command | Permission | Description |
|---------|------------|-------------|
| `/comehere` | None | Summons the last autopilot-enabled vehicle you were in to your current location. An invisible NPC driver is created to drive the vehicle to you. The vehicle stops and opens its door upon arrival. |

## Features

- **Live Map Navigation** -- Interactive in-vehicle map powered by Leaflet.js with GTA V atlas tiles. Double-click to set custom destinations, view your real-time position, and see fixed location markers.
- **Autopilot Driving** -- Autonomous driving to any map destination. Supports custom map clicks, fixed preset locations, and saved personal locations. Works whether the player is in the driver seat or a passenger (spawns an invisible NPC driver if needed).
- **Driving Modes** -- Four speed modes selectable from the UI: Eco, Sport, Sport+, and Emergency. Each mode has a configurable speed multiplier.
- **Driving Style Options** -- Configurable GTA driving style flags that control AI behavior (traffic light obedience, vehicle avoidance, etc.).
- **Emergency Mode** -- One-click emergency route to a preconfigured location (e.g., hospital) with emergency driving behavior and vehicle alarm on arrival.
- **Parking Pilot** -- Visual parking assist system. A transparent ghost of your vehicle appears that you position and rotate with arrow keys, then confirm to have the vehicle (or NPC driver) park itself at that exact spot.
- **Vehicle Summon** -- `/comehere` command calls your last autopilot vehicle to your location with an invisible driver.
- **Car Dance** -- Toggle vehicle door dance mode that rapidly opens and closes doors for a visual effect.
- **Hood/Trunk Control** -- Toggle hood and trunk open/close from the UI.
- **Turn-by-Turn Directions** -- Real-time navigation directions displayed in the UI showing turn type (left, right, sharp turns, straight), distance to next turn, current street name, and distance to destination.
- **Traffic Light Detection** -- UI indicator when the vehicle is stopped at a traffic light.
- **Nearby Vehicle Detection** -- Raycasting system that detects vehicles in front, cross-left, and cross-right directions, displayed as collision warnings in the UI.
- **Speed Limit Display** -- Shows the speed limit for the current street based on configurable street-to-limit mappings.
- **Vehicle Info Display** -- Real-time speed (km/h or mph), fuel level, and in-game time/day shown in the UI.
- **Save/Delete Locations** -- Save custom map locations with names to browser localStorage for quick reuse. Saved locations appear as markers on the map.
- **Custom Autopilot Name** -- First-time setup prompt lets the player name their autopilot system, persisted in localStorage.
- **Cancel Trip** -- Active trips can be cancelled via the UI button or the U key hotkey.
- **Vehicle-Specific Activation** -- Autopilot UI only appears when entering a whitelisted vehicle model.
- **Resource Cleanup** -- NPC drivers and active tasks are properly cleaned up when the resource stops.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Autopilot UI does not appear | Verify the vehicle model hash is listed in `Config.Vehicles`. Model names are case-sensitive and must use backtick hash syntax (e.g., `` [`modelname`] ``). |
| Vehicle does not move after setting destination | Ensure the player is either in the driver seat or a passenger seat. If another NPC is already driving, the autopilot cannot take over. |
| `/comehere` says "lost contact" | The last autopilot vehicle no longer exists in the game world (despawned, destroyed, or resource restarted). Enter a new whitelisted vehicle first. |
| Speed shows wrong unit | Check `Config.UseKmh` is set to exactly `"kmh"` or `"mph"` (lowercase matters). |
| Map tiles not loading | Ensure the `nui/mapStyles/` folder and its contents are present. The `files` directive in `fxmanifest.lua` must include `nui/mapStyles/**/*`. |
| Notifications not showing | If not using QBCore or ESX, implement your custom notification in the `Notify()` function inside `config.lua`. |
| Parking ghost vehicle not appearing | Make sure autopilot is not currently active. Parking is disabled while autopilot is driving. |
| NPC driver remains visible | The NPC driver should be invisible (alpha 0). If visible, check for conflicting scripts that reset ped alpha. |
