# gfx-emp

EMP weapon and remote vehicle control system. Players can shoot an EMP projectile at vehicles using a custom weapon (`WEAPON_EMP`). The EMP attaches a visible device to the target vehicle's body. Once attached, the player can remotely manage the vehicle through an NUI control panel -- toggling the engine, lights, door locks, steering, and even destroying the engine.

## Info

| Key | Value |
|---|---|
| **Resource name** | `gfx-emp` |
| **Author** | GFX Development |
| **Framework** | Standalone |
| **Escrow** | Yes (config.lua, open.lua, client.lua, server.lua are open) |
| **NUI** | Yes |
| **Streamed assets** | `mertrix_empammo` model (ydr + ytyp) |

## Dependencies

| Dependency | Purpose |
|---|---|
| **LegacyFuel** | Used to read vehicle fuel level for the NUI dashboard display |

## Installation

### 1. Add the weapon
Register the `WEAPON_EMP` weapon in your server's weapon configuration or meta files. The script listens for this weapon hash to trigger EMP shots.

### 2. Copy files
```
gfx-emp -> [your_resources]/gfx-emp
```

### 3. server.cfg
```cfg
ensure LegacyFuel
ensure gfx-emp
```

## Configuration

Configuration is defined in `config.lua`:

```lua
Config = {
    showTime = 10,                -- Duration (seconds) for UI or marker display
    DefaultKey = "Z",             -- Default key binding (referenced in open.lua)
    PlaySound = true,             -- Play a sound when a marker is created
    SpeedMultiplier = 2.236936,   -- Multiplier for speed display (m/s to mph conversion)
    ExplodeVehicle = false,       -- If true, causes an explosion when killing the engine
    Markers = {                   -- Marker type identifiers (marker1 through marker7)
        "marker1", "marker2", "marker3",
        "marker4", "marker5", "marker6", "marker7",
    }
}
```

| Option | Type | Default | Description |
|---|---|---|---|
| `showTime` | number | `10` | Duration in seconds for marker/UI display |
| `DefaultKey` | string | `"Z"` | Key to open the menu |
| `PlaySound` | boolean | `true` | Play sound on marker creation |
| `SpeedMultiplier` | number | `2.236936` | Speed unit multiplier (default converts m/s to mph) |
| `ExplodeVehicle` | boolean | `false` | Create an explosion when the engine kill function is used |
| `Markers` | table | 7 markers | List of marker type identifiers |

### Locales

```lua
Config.Locales = {
    ["far_away"] = "Vehicle is too far, connection lost!"
}
```

| Key | Default | Description |
|---|---|---|
| `far_away` | `"Vehicle is too far, connection lost!"` | Shown when the player moves more than 10 units away from the managed vehicle |

## Exports

*No exports are created by this script.*

## Events

| Event | Side | Direction | Parameters | Description |
|---|---|---|---|---|
| `gfx-emp:server:setVehLockState` | Server | Client -> Server | `vehNetId` (int), `state` (int: 1=unlocked, 2=locked) | Requests a vehicle lock state change, broadcasts to all clients |
| `gfx-emp:client:setVehLockState` | Client | Server -> Client | `netId` (int), `state` (int) | Applies the vehicle door lock state on all clients |
| `gfx-marker:CreateMarker` | Server | Client -> Server | `_`, `coords`, `entity`, `markerType` | Creates a marker visible to all players (broadcasts to all clients) |

## Commands

| Command | Description |
|---|---|
| `/managevehicle` | Opens the NUI remote control panel for the last EMP-attached vehicle. Must have an active EMP on a vehicle. |

## Features

- **EMP Weapon System** -- Custom `WEAPON_EMP` weapon that fires EMP projectiles. Uses raycasting from the gameplay camera to detect hit vehicles and determine the exact bone/surface point.
- **Smart Bone Detection** -- The EMP device attaches to the nearest vehicle bone (engine, doors, wheels, bumpers, etc.) with proper rotation based on the hit surface. Supports an extensive list of vehicle bones for accurate placement.
- **Remote Vehicle Control Panel (NUI)** -- After attaching an EMP, use `/managevehicle` to open an interactive control panel with:
  - **Engine toggle** -- Start or stop the target vehicle's engine remotely
  - **Lights toggle** -- Turn headlights on/off
  - **Door lock toggle** -- Lock or unlock vehicle doors (synced across all clients)
  - **Directional steering** -- Drive the vehicle remotely using W/A/S/D keys or on-screen directional buttons
  - **Kill engine** -- Permanently disable the vehicle: sets engine health to 0, drains fuel/oil, forces the driver out, and optionally triggers an explosion
- **Live Dashboard** -- The NUI panel displays real-time vehicle data: speed, engine temperature, fuel level, engine status, distance from player, and lock status. Updates every 100ms with change detection to minimize NUI messages.
- **Free Camera Mode** -- NUI callback for a free camera mode that allows aiming while the panel is open, re-enabling mouse look and movement controls.
- **Distance Safety** -- Automatically disconnects remote control if the player moves more than 10 units away from the managed vehicle, with a locale notification.
- **Streamed 3D Model** -- Includes a custom `mertrix_empammo` 3D model that visually represents the EMP device attached to vehicles.
- **Cleanup on Stop** -- All EMP entities are automatically deleted when the resource stops. EMP objects are also cleaned up when their attached vehicle no longer exists.

## Troubleshooting

| Problem | Solution |
|---|---|
| EMP does not attach to vehicle | Ensure `WEAPON_EMP` is properly registered in your server's weapon meta. The weapon hash must match the script's expected hash. |
| `/managevehicle` says "Invalid vehicle" | You must first hit a vehicle with the EMP weapon. The command controls the most recently EMP'd vehicle. |
| Fuel always shows 0 | The script requires **LegacyFuel**. Ensure it is started before `gfx-emp`. If you use a different fuel system, edit the `GetFuel` function in `open.lua`. |
| "Vehicle is too far, connection lost!" | You moved more than 10 units from the managed vehicle. Stay close to maintain the remote connection. |
| Vehicle lock does not sync | The lock state is broadcast via server event to all clients. Ensure OneSync is enabled on your server. |
| EMP model not visible | Check that the `stream/` folder contains `mertrix_empammo.ydr` and `mertrix_empammo_ytyp.ytyp`, and that the resource is properly loaded. |
| Engine kill does nothing | Check `GetVehicleEngineHealth` -- the function only works if engine health is above 0. If `Config.ExplodeVehicle` is `false`, there will be no visible explosion. |

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-emp
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
