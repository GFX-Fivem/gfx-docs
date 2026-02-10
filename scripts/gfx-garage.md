# gfx-garage

A feature-rich garage system for FiveM with NUI vehicle preview, multi-type garage support (normal, impound, job, aircraft, boat), damage persistence, and framework-agnostic design.

---

## Info

| Key | Value |
|---|---|
| **Resource Name** | `gfx-garage` |
| **Frameworks** | QBCore, ESX |
| **UI** | NUI (HTML/CSS/JS) |
| **Database** | oxmysql |
| **Lua Version** | 5.4 |
| **Escrow** | Yes (`config.lua` open) |

---

## Dependencies

| Dependency | Required | Notes |
|---|---|---|
| `qb-core` | Yes (if QBCore) | Framework core |
| `es_extended` | Yes (if ESX) | Framework core |
| `oxmysql` | Yes | Database queries (`@oxmysql/lib/MySQL.lua`) |
| `qb-target` | Optional | Only if `Config.DrawTextOrTarget.Enabled` is set to `"target"` |
| Fuel export (e.g. `LegacyFuel`) | Optional | Configurable via `Config.FuelExport` |

---

## Installation

### 1. Copy Files
Place the `gfx-garage` folder into your server's resources directory.

### 2. Database
The script uses existing framework vehicle tables:
- **QBCore:** `player_vehicles` (columns: `citizenid`, `vehicle`, `plate`, `state`, `fuel`, `engine`, `body`, `mods`, `garage`)
- **ESX:** `owned_vehicles` (columns: `owner`, `plate`, `vehicle`, `stored`, `fuel`, `parking`)

No additional SQL migration is required.

### 3. server.cfg
```cfg
ensure oxmysql
ensure qb-core       -- or es_extended
ensure gfx-garage
```

### 4. Vehicle List (ESX Only)
ESX users must edit `vehicles.lua` to define available vehicles with their name, brand, model, price, category, and hash. QBCore users get vehicle data from `QBCore.Shared.Vehicles` automatically.

---

## Configuration

Configuration is done in `config.lua`.

### Framework
```lua
Config.Framework = "qb"  -- "qb" or "esx"
```

### Fuel Export
```lua
Config.FuelExport = "LegacyFuel"  -- resource name for fuel export, or false to disable
```

### Impound Prices
```lua
Config.ImpoundPrice = {
    ["impound"] = 5000,
    ["boat_impound"] = 5000,
    ["aircraft_impound"] = 10000,
}
```

### Damage Persistence (QBCore only)
```lua
Config.SaveDamage = {
    Doors = true,     -- save/restore broken doors
    Windows = true,   -- save/restore broken windows
    Tyres = true      -- save/restore burst tyres
}
```

### Same-Garage Restriction
```lua
Config.TakeVehicleFromSameGarage = false  -- true = only show vehicles stored in the current garage
```

### Interaction Mode
```lua
Config.DrawTextOrTarget.Enabled = "text"  -- "text" (DrawText + keybind) or "target" (qb-target on NPC)
```

When set to `"text"`, pressing the configured control key (default: `46` / E) near a garage NPC opens the menu. When set to `"target"`, the NPC gets a qb-target interaction zone.

### DrawText Settings
```lua
Config.DrawTextOrTarget.DrawText = {
    control = 46,       -- control key ID (E)
    x = 0.5, y = 0.5,
    scale = 0.4,
    r = 255, g = 255, b = 255, a = 255,
    text = "Press ~g~[E]~s~ to open the garage menu"
}
```

### Garages
Each garage entry in `Config.Garages` supports these fields:

| Field | Type | Description |
|---|---|---|
| `name` | string | Display name and blip label |
| `type` | string | `"normal"`, `"impound"`, `"job"`, `"aircraft"`, `"boat"`, `"boat_impound"`, `"aircraft_impound"` |
| `coords` | vector4 | Garage/store marker location and heading |
| `job` | string | Required job name (only for `type = "job"`) |
| `blip` | boolean | Show on map |
| `sprite` | number | Blip sprite ID |
| `scale` | number | Blip scale |
| `colour` | number | Blip colour ID |
| `public` | boolean | Accessible to all players |
| `distance` | number | Store-vehicle marker interaction distance (default: 15) |
| `Npc.model` | string | Ped model for the garage NPC |
| `Npc.coords` | vector4 | NPC spawn position and heading |
| `authorizedVehicles` | table | Optional table of allowed vehicle hashes (key = hash, value = true) |

Example garage entry:
```lua
[1] = {
    name = "Garage",
    type = "normal",
    coords = vector4(231.78, -794.99, 30.58, 158.87),
    r = 1.0, g = 0.0, b = 0.0, a = 100,
    sprite = 357, scale = 0.7, colour = 3,
    blip = true, public = true,
    Npc = {
        model = "s_m_m_autoshop_01",
        coords = vector4(214.59, -806.78, 30.81, 341.86)
    }
}
```

### Vehicle Camera Offsets
Camera position offsets per vehicle class for the NUI preview:
```lua
Config.VehicleCamOffsets = {
    [0] = vector3(0.0, -5.0, 2.0),   -- Compacts
    [14] = vector3(0.0, -10.0, 2.0),  -- Boats
    [15] = vector3(0.0, -15.0, 3.0),  -- Helicopters
    [16] = vector3(0.0, -15.0, 4.0),  -- Planes
    -- ... all 23 vehicle classes supported
}
```

### Vehicle Type Classification
Define which vehicles are boats or aircraft (used for garage type filtering):
```lua
Config.Boats = {
    [`dinghy`] = true,
}
Config.Aircrafts = {
    [`luxor2`] = true,
}
```

### Vehicle Value Tiers
Used to assign a value label displayed in the UI:
```lua
Config.Values = {
    { label = "High",   price = 99999999 },
    { label = "Medium", price = 150000 },
    { label = "Low",    price = 50000 },
}
```

### Job Vehicles
Vehicles available from job-type garages:
```lua
Config.JobVehicles = {
    ["police"] = {
        { name = "police3", label = "Police Cruiser", grade = 0 },
        { name = "policet", label = "Police Van",     grade = 0 },
    }
}
```

### Locales
All UI strings are configurable in the `Locales` table within `config.lua`:
```lua
Locales = {
    ["open_garage"] = "Open Garage",
    ["store_vehicle"] = "Store Vehicle",
    ["no_vehicles"] = "There is no vehicle belong to you here!",
    ["not_owned"] = "This vehicle is not belong to you!",
    ["not_enough_money"] = "You dont have enough money!",
    ["cant_store_this"] = "You can't store this vehicle!",
    ["categories"] = {
        ["compacts"] = "Compacts",
        ["coupes"] = "Coupes",
        -- ...
    },
}
```

---

## Exports

*No exports are created by this script.*

---

## Events

### Client Events

#### `gfx-garage:client:openGarage`
Opens the garage UI for the nearest garage location. Can be triggered from other scripts or used with qb-target.

```lua
-- Trigger from server
TriggerClientEvent("gfx-garage:client:openGarage", source)

-- Trigger from client
TriggerEvent("gfx-garage:client:openGarage")
```

**Parameters:** None (automatically detects the nearest garage)

### Server Events

#### `gfx-garage:takeOutVehicle`
Marks a vehicle as taken out of the garage (sets state to 0 in the database). Triggered internally when a player spawns a vehicle from the garage.

```lua
TriggerServerEvent("gfx-garage:takeOutVehicle", plate, netId)
```

| Parameter | Type | Description |
|---|---|---|
| `plate` | string | Vehicle plate number |
| `netId` | number | Network ID of the spawned vehicle entity |

---

## Commands

*No commands are registered by this script.*

---

## Features

- **Multi-type garages** -- Normal, impound, job, aircraft, boat, and their impound variants all in one system
- **NUI vehicle preview** -- 3D vehicle preview with scripted camera when browsing the garage, with per-class camera offsets
- **Vehicle categorization** -- Vehicles are sorted by category (compacts, sedans, sports, etc.) in the UI
- **Vehicle value display** -- Configurable value tiers (High/Medium/Low) shown in the garage UI
- **Impound system** -- Impounded vehicles require a cash payment to retrieve, with separate prices for cars, boats, and aircraft
- **Job garages** -- Restricted garages that only show pre-configured job vehicles to players with the matching job and minimum grade
- **Damage persistence** -- Saves and restores door, window, and tyre damage states (QBCore)
- **Same-garage restriction** -- Optional setting to only show vehicles stored in the specific garage the player is at
- **Dual interaction modes** -- DrawText with keybind or qb-target NPC interaction
- **Garage NPCs** -- Configurable ped models spawned at each garage location
- **Map blips** -- Per-garage configurable blips with custom sprites, colors, and scales
- **Fuel integration** -- Sets fuel level on vehicle spawn via configurable fuel export
- **Vehicle keys** -- Triggers `vehiclekeys:client:SetOwner` on vehicle spawn for key system compatibility
- **Framework agnostic** -- Single config switch between QBCore and ESX
- **ESX vehicle list** -- Bundled `vehicles.lua` with full vehicle database for ESX servers

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Garage UI does not open | Verify interaction mode in `Config.DrawTextOrTarget.Enabled` matches your setup. If `"target"`, ensure `qb-target` is running. |
| "There is no vehicle belong to you here!" | Player has no vehicles in the database with the correct state, or vehicles are filtered by garage type (boat/aircraft mismatch). |
| Impound says not enough money | Check `Config.ImpoundPrice` values and ensure the garage type key matches (e.g. `"impound"`, `"boat_impound"`, `"aircraft_impound"`). |
| Vehicle spawns without damage | `Config.SaveDamage` only works on QBCore. Ensure the relevant damage flags are set to `true`. |
| Vehicles not showing in aircraft/boat garage | Add the vehicle model hash to `Config.Aircrafts` or `Config.Boats` tables. |
| Job garage shows no vehicles | Ensure `Config.JobVehicles` has an entry matching the garage's `job` field, and the player's job grade meets `minRank`. |
| Fuel not set on spawn | Verify `Config.FuelExport` matches the exact resource name of your fuel script, or set to `false` to disable. |
| ESX vehicles not loading | Edit `vehicles.lua` and ensure all your server's vehicles are listed with correct `hash` values. |
| Same garage restriction not working | Set `Config.TakeVehicleFromSameGarage = true` and ensure the `garage`/`parking` column exists in your vehicle database table. |

---

## Source

- **GitHub:** [https://github.com/gfx-fivem/gfx-garage](https://github.com/gfx-fivem/gfx-garage)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
