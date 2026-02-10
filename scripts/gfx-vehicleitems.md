# gfx-vehicleitems

## Info

| Key | Value |
|---|---|
| **Name** | gfx-vehicleitems |
| **Type** | Vehicle Item System |
| **Framework** | Auto-detected via gfx-lib (QBCore / ESX / Qbox) |
| **FX Version** | Cerulean |
| **Lua** | 5.4 |
| **Escrow** | Yes (client.lua, server.lua, warmenu.lua are escrowed) |

---

## Dependencies

| Resource | Required | Purpose |
|---|---|---|
| **gfx-lib** | Yes | Framework detection, shared utilities, item registration, notifications |
| **gfx-pvphud-remake** | No (optional) | Displays spawn cooldown timer on HUD |
| **gfx-bennys** | No (optional) | Applies saved vehicle modifications on spawn |

---

## Installation

### 1. Copy Files
Place the `gfx-vehicleitems` folder into your server's resources directory.

### 2. Add Items to Your Inventory
Add the vehicle item names (matching the keys in `Config.Vehicles`) to your framework's item list. For example, if using `ox_inventory`, add items named `deluxo`, `savestra`, etc.

### 3. server.cfg
```cfg
ensure gfx-lib
ensure gfx-vehicleitems
```

Make sure `gfx-lib` starts before `gfx-vehicleitems`.

---

## Configuration

Configuration is located in `config.lua`.

```lua
Config = {
    VehicleSpawnCooldown = 3,        -- Cooldown in seconds between spawn/store actions
    MaxSpeedForStore = 20,           -- Max speed (km/h) allowed when storing a vehicle
    MaxHeightForStore = 5,           -- Max height above ground allowed when storing a vehicle
    Vehicles = {
        ["deluxo"] = true,           -- Vehicle model name = enabled
        ["savestra"] = true,
    },
    Locales = {
        ["spawned"] = "You have spawned ~g~%s~w~ | ID: ~g~%s~w~",
        ["stored"] = "You have stored ~g~%s~w~ | ID: ~g~%s~w~",
        ["cooldown"] = "You have to wait for cooldown!",
        ["you_have_to_slow"] = "You are too fast to store vehicle!",
        ["you_are_too_high"] = "You have to heat your altitude to store vehicle!",
        ["already_in_vehicle"] = "You cannot spawn while in a vehicle!",
    }
}
```

### Config Options

| Option | Type | Default | Description |
|---|---|---|---|
| `VehicleSpawnCooldown` | number | `3` | Seconds the player must wait between spawning/storing vehicles |
| `MaxSpeedForStore` | number | `20` | Maximum vehicle speed (km/h) to allow storing |
| `MaxHeightForStore` | number | `5` | Maximum height above ground to allow storing |
| `Vehicles` | table | `{}` | A table of vehicle model names. Set to `true` to register as a usable item |
| `Locales` | table | `{}` | Notification messages. Supports GTA text formatting (`~g~`, `~w~`, etc.) |

### Adding New Vehicle Items

To add a new vehicle item, add its model name to the `Config.Vehicles` table:

```lua
Vehicles = {
    ["deluxo"] = true,
    ["savestra"] = true,
    ["zentorno"] = true,  -- new vehicle item
}
```

Make sure the item is also registered in your inventory system with the same name.

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events are exposed by this script. All events are internal.*

---

## Commands

| Command | Keybind | Description |
|---|---|---|
| `examinevehicle` | `G` | Stores the vehicle the player is currently driving back into their inventory. The player must be the driver, the vehicle speed must be below `MaxSpeedForStore`, and the vehicle height above ground must be below `MaxHeightForStore`. |

The keybind can be changed by players in **Settings > Key Bindings > FiveM**.

---

## Features

- **Vehicle as Inventory Items** -- Vehicles are registered as usable inventory items. When a player uses a vehicle item, it is removed from their inventory and spawned at their location.
- **Store Vehicle Back** -- Players can press `G` (default) to store their current vehicle back into their inventory as an item.
- **Spawn Cooldown** -- A configurable cooldown prevents spam-spawning vehicles.
- **Speed Check** -- Vehicles can only be stored when traveling below a configurable speed limit.
- **Height Check** -- Vehicles can only be stored when below a configurable height above ground, preventing mid-air storage.
- **Already-in-Vehicle Check** -- Players cannot spawn a vehicle item while already sitting in a vehicle.
- **Unique Vehicle IDs** -- Each spawned vehicle gets a random unique ID (1000-99999) to track which vehicle belongs to which item usage.
- **gfx-pvphud-remake Integration** -- If `gfx-pvphud-remake` is running, the cooldown timer is displayed on the player's HUD.
- **gfx-bennys Integration** -- If `gfx-bennys` is running, saved vehicle modifications are automatically applied when a vehicle is spawned.
- **Framework Agnostic** -- Uses `gfx-lib` for item registration, add/remove item, and notifications, supporting QBCore, ESX, and Qbox.

---

## Customization Hooks

The following files are **not escrowed** and can be freely edited:

### client_hook.lua

| Function | Description |
|---|---|
| `Notify(text, type)` | Client-side notification wrapper. Uses `gfx-lib` shared notify by default. |
| `SetVehicleProps(vehicle, model)` | Called after a vehicle is spawned. Empty by default -- edit this to apply custom vehicle properties or modifications from your tuning script. |

### server_hook.lua

| Function | Description |
|---|---|
| `GetPlayer(source)` | Returns the player object via `gfx-lib`. |
| `AddItem(source, itemName, count)` | Adds an item to the player's inventory via `gfx-lib`. |
| `RemoveItem(source, itemName, count)` | Removes an item from the player's inventory via `gfx-lib`. |
| `Notify(source, text)` | Sends a notification to a player via the client event. |

---

## Troubleshooting

| Problem | Cause | Solution |
|---|---|---|
| Item does nothing when used | Vehicle model not in `Config.Vehicles` or item not registered in inventory | Add the model to `Config.Vehicles` with `true` and register the item in your inventory system |
| "You cannot spawn while in a vehicle!" | Player is already in a vehicle | Exit the current vehicle before using the item |
| "You are too fast to store vehicle!" | Vehicle speed exceeds `MaxSpeedForStore` | Slow down below the configured speed limit |
| "You have to heat your altitude to store vehicle!" | Vehicle is too high above ground | Lower altitude below `MaxHeightForStore` |
| "You have to wait for cooldown!" | Cooldown timer has not expired | Wait for the configured `VehicleSpawnCooldown` seconds |
| Vehicle spawns but no modifications applied | `gfx-bennys` not running or `SetVehicleProps` not configured | Install `gfx-bennys` or customize `SetVehicleProps()` in `client_hook.lua` |
| Cooldown timer not showing on HUD | `gfx-pvphud-remake` not installed | Install `gfx-pvphud-remake` for visual cooldown display (optional) |
| Script not starting | `gfx-lib` not ensured before this script | Ensure `gfx-lib` starts before `gfx-vehicleitems` in `server.cfg` |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-vehicleitems
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
