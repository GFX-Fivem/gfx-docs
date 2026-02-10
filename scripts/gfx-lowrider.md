# GFX Lowrider

1v1 lowrider hydraulic duel system where players compete by performing hydraulic jumps at designated duel zones. Players join with allowed lowrider vehicles, get teleported to spawn positions, and use directional hydraulic controls to score points via a rhythm-based NUI interface. The duel ends when a player reaches the max score or the timer runs out.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-lowrider` |
| **Frameworks** | QBCore, ESX, Standalone |
| **Escrow** | Yes |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `qb-core` | Only if using QBCore | Set `Config.Framework = "qb"` |
| `es_extended` | Only if using ESX | Set `Config.Framework = "esx"` |

No dependencies are required when running in standalone mode (`Config.Framework = false`).

## Installation

1. Copy the `gfx-lowrider` folder into your server's resources directory.
2. Add the resource to your `server.cfg`:
   ```cfg
   ensure gfx-lowrider
   ```
3. Configure `config.lua` to match your framework and customize duel settings (see Configuration below).

## Configuration

### config.lua

#### General Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.Framework` | `string\|false` | `false` | Framework to use. Options: `"qb"`, `"esx"`, or `false` for standalone |
| `Config.InteractKey` | `number` | `46` | Control key index used to join/leave duels (default `46` = E key) |
| `Config.EventTimer` | `number` | `2` | Duration of a duel in minutes. Duel ends automatically after this time |
| `Config.MaxPoints` | `number` | `2500` | Maximum points to win. If a player reaches this score, the duel ends immediately |

#### Vehicle Models

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.VehicleModels` | `table` | `{voodoo, virgo2}` | Hash-indexed table of vehicle models allowed to participate in duels. Only these vehicles can enter a duel |

```lua
Config.VehicleModels = {
    [`voodoo`] = true,
    [`virgo2`] = true
}
```

To add more vehicles, add new entries with the backtick hash syntax: `` [`modelname`] = true ``.

#### Duel Locations

| Option | Type | Description |
|--------|------|-------------|
| `Config.Coords` | `table` | Array of duel zone definitions |
| `Config.Coords[n].center` | `vector3` | Center point of the duel zone (used for proximity detection and 3D text) |
| `Config.Coords[n].spawn` | `table` | Array of exactly 2 spawn positions for the two duel participants |
| `Config.Coords[n].spawn[n].coords` | `vector4` | Spawn position and heading (x, y, z, heading) |

```lua
Config.Coords = {
    {
        center = vector3(0.34, -1758.83, 29.3),
        spawn = {
            {coords = vector4(-2.26, -1751.46, 29.3, 295.62)},
            {coords = vector4(4.47, -1757.16, 29.3, 346.88)},
        }
    },
}
```

#### Blip Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `BlipData.bool` | `boolean` | `true` | Whether to show map blips for duel locations |
| `BlipData.name` | `string` | `"Lowrider Duel"` | Blip label on the map |
| `BlipData.sprite` | `number` | `380` | Blip sprite ID |
| `BlipData.colour` | `number` | `1` | Blip color ID |
| `BlipData.scale` | `number` | `0.8` | Blip size on the map |

#### Locales

All user-facing strings are defined in the `Locales` table in `config.lua` and can be freely edited for localization:

| Key | Default | Description |
|-----|---------|-------------|
| `waiting` | `"There are %s/2 players in duel! Waiting for players!\nPress E to join!"` | Displayed at duel zone when waiting for players |
| `vehicle_not_allowed` | `"This vehicle can not join duels!"` | Shown when trying to join with a disallowed vehicle |
| `cancel` | `"Press E to leave duel!"` | Shown to a player who is in the lobby waiting |
| `score` | `"Score: %s"` | Score display format |
| `winner` | `"The winner is %s"` | Shown when a duel concludes |
| `invalid_model` | `"You can not join duel with this vehicle!"` | Shown when attempting to join with an invalid vehicle |

#### Notifications

The `Notify(text)` function in `config.lua` handles notifications. By default it uses the framework's built-in notification system. For standalone mode, you can add your own notification export or event in the function body.

## Exports

*No exports found.* This script does not create any exports via `exports('name', function)`.

## Events

*No public API events.* All events in this script are internal (used between the client and server of the resource itself) and are not intended for external use.

## Commands

*No commands.* The script does not register any usable commands. A commented-out `startch` command exists in the source but is inactive.

## Features

- 1v1 lowrider hydraulic duel system
- Rhythm-based NUI interface for hydraulic jump controls (front, back, left, right directions)
- Point scoring system with configurable max score threshold
- Timed duels with configurable duration
- Multiple duel zone support (configure as many locations as needed)
- Vehicle whitelist system (only allowed lowrider models can participate)
- Automatic vehicle teleportation to designated spawn positions when joining a duel
- 3D text display at duel zones showing lobby status and scores
- Map blips for all duel locations (toggleable)
- Player controls are restricted during duels (only hydraulic directions and camera allowed)
- Automatic winner determination by score or timer expiration, with draw detection
- Death handling: if a player dies during a duel, the opponent wins automatically
- Hydraulic reset system to prevent stuck wheel states
- Spam protection on hydraulic actions (750ms cooldown)
- Full NUI-based interface for the duel gameplay
- Multi-framework support (QBCore, ESX, Standalone)
- Streaming assets included (dancing minigame GFX/YTD files)

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "You can not join duel with this vehicle!" | The vehicle you are in is not in `Config.VehicleModels`. Add the vehicle model hash to the whitelist |
| Cannot join duel | Make sure you are inside a vehicle, within 10 units of a duel zone center, and press the interact key (default E) |
| Duel does not start | A duel requires exactly 2 players. Wait for a second player to join the same duel zone |
| Hydraulics not responding | Ensure your vehicle model supports hydraulics (lowrider class vehicles). The script uses `SetHydraulicWheelStateTransition` natives |
| Notifications not showing (standalone) | Edit the `Notify(text)` function in `config.lua` to add your own notification system |
| Player names showing as Steam/license ID | Set `Config.Framework` to `"qb"` or `"esx"` to use character names, or customize the `GetName(src)` function for standalone |
| Blips not appearing on map | Check that `BlipData.bool` is set to `true` in `config.lua` |
| Score not updating | The NUI sends score updates via the `jumpaction` callback. Ensure the NUI page is loading correctly (check F8 console for errors) |
| Death during duel not ending the match | The script listens for `hospital:server:SetDeathStatus`. If your death system uses a different event, update `server/death.lua` |
