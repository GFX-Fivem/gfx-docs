# gfx-secondhand

A second-hand vehicle marketplace for FiveM where players can sell their owned vehicles at configurable parking lots and other players can browse, test drive, and purchase them. Includes NUI interface, license plate editing, offline selling support, and job-restricted parking lots.

---

## Info

| Key | Value |
|---|---|
| **Resource Name** | `gfx-secondhand` |
| **Version** | 1.1 |
| **Frameworks** | QBCore, ESX |
| **UI** | NUI (HTML/CSS/JS) |
| **Database** | oxmysql / ghmattimysql / mysql-async (configurable) |
| **Lua Version** | 5.4 |
| **OneSync** | Required |
| **Escrow** | Yes (`config.lua`, `client/*.lua`, `server/*.lua`, `locales/*.lua`, `vehicles.lua` open) |

---

## Dependencies

| Dependency | Required | Notes |
|---|---|---|
| `qb-core` | Yes (if QBCore) | Framework core |
| `es_extended` | Yes (if ESX) | Framework core |
| `oxmysql` / `ghmattimysql` / `mysql-async` | Yes | Database queries, configured via `Config.SQLScript` |
| `qb-target` | Optional | Only when `Config.InteractType["target"]` is enabled |
| OneSync | Required | Listed as a dependency in `fxmanifest.lua` |

---

## Installation

### 1. Copy Files
Place the `gfx-secondhand` folder into your server's resources directory.

### 2. Database
The script uses existing framework vehicle tables. No additional SQL migration is required.
- **QBCore:** `player_vehicles` (columns: `license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`)
- **ESX:** `owned_vehicles` (columns: `owner`, `plate`, `vehicle`)

Vehicle listing data is stored in `database.json` within the resource folder (auto-managed by the script).

### 3. server.cfg
```cfg
ensure oxmysql           -- or ghmattimysql / mysql-async
ensure qb-core            -- or es_extended
ensure gfx-secondhand
```

---

## Configuration

Configuration is done in `config.lua`.

### Locale
```lua
Config.Locales = 'EN'  -- EN, FR, PT, TR
```

### SQL Driver
```lua
Config.SQLScript = 'oxmysql'  -- 'oxmysql' / 'ghmattimysql' / 'mysql-async'
```

### License Plate Editing
```lua
Config.EditPlate = true          -- Allow buyers to change the plate on purchase
Config.EditPlateCost = 5000      -- Cost to edit the license plate
```

### Offline Selling
```lua
Config.OfflineSelling = true
-- true  = Vehicles can be purchased even if the owner is offline (money goes to DB)
-- false = Owner must be online for the transaction to complete
```

### Payment Type
```lua
Config.BuyType = "bank"  -- "bank" or "cash"
```

### Test Drive
```lua
Config.TestDriveTime = 60  -- Duration in seconds
Config.TestDriveVector4 = vector4(-1007.3341, -3015.9114, 13.3133, 61.0055)  -- Spawn location
```

### Vehicle Collision
```lua
Config.Collisions = true
-- true  = Display vehicles have no collision (players can walk through them)
-- false = Display vehicles have collision enabled
```

### Parking Lots
Define named parking lots with numbered slot positions. Each slot is a `vector4` (x, y, z, heading).

```lua
Config.ParkingLot = {
    ["Franklin's"] = {
        [1] = vector4(221.4148, -806.7344, 30.0414, 247.9251),
        [2] = vector4(222.4204, -804.3123, 30.0363, 246.9260),
        -- ...up to 15 slots
    },
    ["Winston's"] = {
        [1] = vector4(-1716.6907, -898.9792, 7.0463, 139.1251),
    },
}
```

### Job Restrictions
Restrict specific parking lots to players with a certain job. Parking lots not listed are open to everyone.

```lua
Config.Jobs = {
    ["Franklin's"] = "police"  -- Only police can sell at Franklin's
}
```

### Interaction Type
Choose one of three interaction methods. Set `useThis = true` for the desired method and `false` for the others.

```lua
Config.InteractType = {
    ["textui"]   = { useThis = false },  -- QBCore DrawText UI
    ["drawtext"] = { useThis = true },   -- 3D world text
    ["target"]   = { useThis = false },  -- qb-target box zones
}
```

### Notification Function
Customize the notification system for both client and server sides:

```lua
function Config.Notification(text, server, source)
    if server then
        TriggerClientEvent('esx:showNotification', source, text)
    else
        TriggerEvent('esx:showNotification', text)
    end
end
```

### HUD Toggle
Called when opening/closing the vehicle preview UI:

```lua
function Config.Hud(bool)
    if bool then
        TriggerEvent('ShowHud')
    else
        TriggerEvent('HideHud')
    end
end
```

### Vehicle Key Integration
Configure key assignment for test drives and purchases:

```lua
function Config.TestVehicle(model, plate)
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
end

function Config.BuyVehicle(model, plate)
    TriggerServerEvent('qb-vehiclekeys:server:BuyVehicle', plate, model)
end
```

### Vehicle List
The `vehicles.lua` file contains a comprehensive `Config.Vehicles` table mapping vehicle spawn names to display titles and categories. This table is used to show vehicle names and categories in the UI.

```lua
Config.Vehicles = {
    ["adder"] = { title = "Adder Truffade", category = "sports" },
    ["zentorno"] = { title = "Zentorno Pegassi", category = "super" },
    -- 700+ vehicles across all categories
}
```

Categories include: `compacts`, `sedans`, `suv`, `coupes`, `muscle`, `sport-classic`, `sports`, `super`, `motorcycles`, `off-road`, `industrial`, `utility`, `vans`, `cycles`, `boats`, `helicopters`, `planes`, `service`, `emergency`, `military`, `commercial`, `openwheel`.

---

## Exports

### Client Exports

#### `IsParkingSlotOccupied`
Checks whether a specific parking slot currently has a vehicle listed for sale. Only created when `Config.InteractType["target"]` is enabled (used internally for `qb-target` canInteract checks).

```lua
local occupied = exports['gfx-secondhand']:IsParkingSlotOccupied(parkingLotName, slotIndex)
```

| Parameter | Type | Description |
|---|---|---|
| `parkingLotName` | string | Name of the parking lot (e.g. `"Franklin's"`) |
| `slotIndex` | number | Slot number within the parking lot |

**Returns:** `boolean` -- `true` if a vehicle is listed in that slot, `false` otherwise.

---

## Events

### Client Events

#### `Jakrino:Client:OpenSellingPopUp`
Opens the vehicle selling popup UI. The player must be in a vehicle to sell it.

```lua
-- Trigger from client
TriggerEvent('Jakrino:Client:OpenSellingPopUp', targetdata, parkindex)
```

| Parameter | Type | Description |
|---|---|---|
| `targetdata` | table/boolean | Table with `parkindex` field (from qb-target), or `false` for direct trigger |
| `parkindex` | string | Parking lot name (used when `targetdata` is `false`) |

#### `Jakrino:Client:ViewVehicle`
Opens the vehicle preview camera and NUI for browsing a listed vehicle at a specific parking slot.

```lua
-- Trigger from client
TriggerEvent('Jakrino:Client:ViewVehicle', targetdata, parkindex, slotindex, inUi)
```

| Parameter | Type | Description |
|---|---|---|
| `targetdata` | table/nil | Table with `parkindex` and `slotindex` fields (from qb-target), or `nil` |
| `parkindex` | string | Parking lot name |
| `slotindex` | number | Slot index within the parking lot |
| `inUi` | boolean | `true` if already in the UI (switching between vehicles), `false` for fresh open |

#### `Jakrino:Client:UpdateVehicles`
Updates all displayed vehicles at parking lots. Called after a vehicle is listed or purchased.

```lua
-- Trigger from server to all clients
TriggerClientEvent('Jakrino:Client:UpdateVehicles', -1, data)
```

| Parameter | Type | Description |
|---|---|---|
| `data` | table/nil | Full vehicle listing data table. If `nil`, the client fetches data via callback. |

#### `Jakrino:Client:DeleteVehicle`
Deletes the vehicle the player is currently sitting in (used after listing a vehicle for sale).

```lua
-- Trigger from server to specific client
TriggerClientEvent('Jakrino:Client:DeleteVehicle', source)
```

**Parameters:** None

### Server Events

#### `Jakrino:Server:SaveVehicle`
Lists a vehicle for sale at the nearest parking slot. Validates ownership and slot availability.

```lua
TriggerServerEvent('Jakrino:Server:SaveVehicle', vehicleProps, price, parkingLotName, slotIndex, vehicleName)
```

| Parameter | Type | Description |
|---|---|---|
| `vehicleProps` | table | Full vehicle properties table (model, mods, plate, colors, etc.) |
| `price` | number | Asking price set by the seller |
| `parkingLotName` | string | Name of the parking lot |
| `slotIndex` | number | Slot number within the parking lot |
| `vehicleName` | string | Display name of the vehicle |

---

## Commands

*No commands are registered by this script.*

---

## Features

- **Player-to-player vehicle sales** -- Players can list their owned vehicles for sale at designated parking lots with a custom price
- **NUI marketplace interface** -- Browse listed vehicles with a full-featured UI showing vehicle details, seller info, fuel level, turbo status, and modification levels
- **Vehicle preview camera** -- 3D scripted camera that lets buyers view listed vehicles from different angles with left/right rotation
- **Test drive system** -- Take any listed vehicle for a timed test drive before purchasing, with automatic return after the timer expires
- **License plate editing** -- Buyers can optionally change the license plate when purchasing (configurable cost)
- **Offline selling** -- When enabled, vehicles can be purchased even when the seller is offline; money is deposited directly into their database record
- **Online-only selling** -- When disabled, the seller must be online for the transaction to complete; if offline, the buyer is refunded
- **Job-restricted parking lots** -- Specific parking lots can be restricted to players with a certain job
- **Multiple parking lots** -- Configure unlimited named parking lots with multiple numbered slots each
- **Full vehicle property persistence** -- All vehicle modifications, colors, neons, damage states, extras, liveries, and wheel configurations are saved and restored
- **Three interaction modes** -- Choose between 3D DrawText, QBCore TextUI, or qb-target box zones for interacting with parking slots
- **Multi-framework support** -- Works with both QBCore and ESX out of the box with auto-detection
- **Multi-database support** -- Supports oxmysql, ghmattimysql, and mysql-async via config switch
- **JSON data storage** -- Vehicle listings are stored in `database.json` for persistence without additional database tables
- **Map blips** -- Automatic blip placement for each parking lot location
- **Vehicle stabilization** -- Periodic thread repositions display vehicles to prevent physics drift
- **Collision toggle** -- Option to enable or disable collision on display vehicles
- **Multi-language support** -- Locale system with EN, FR, PT, TR translations
- **Comprehensive vehicle list** -- 700+ vehicles pre-configured with display names and categories

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Vehicles not spawning at parking lots | Ensure `Config.ParkingLot` coordinates are valid and at ground level. Check server console for model loading errors. |
| "You are not in any vehicle!" when trying to sell | The player must be seated in a vehicle to list it for sale. |
| "This vehicle is not yours!" | The vehicle plate must exist in the framework's vehicle database (`player_vehicles` for QBCore, `owned_vehicles` for ESX). |
| "This parking space is occupied." | The selected parking slot already has a vehicle listed. The player must use a different slot. |
| Selling popup does not appear | Verify `Config.InteractType` has exactly one method set to `useThis = true`. If using `target`, ensure `qb-target` is running. |
| "Your transaction has been canceled because the owner is not active!" | `Config.OfflineSelling` is set to `false` and the seller is offline. Set to `true` to allow offline sales. |
| Vehicle purchased but seller did not receive money | If `Config.OfflineSelling` is `true`, verify the seller's database record exists. Check `Config.BuyType` matches the correct money account. |
| Test drive vehicle disappears instantly | Ensure `Config.TestDriveTime` is set to a positive number (seconds) and `Config.TestDriveVector4` coordinates are valid. |
| "To sell vehicles here, you must have a certain professional group." | The parking lot is job-restricted via `Config.Jobs`. The player's job must match the configured job name. |
| Vehicles drifting from their parking positions | The script auto-corrects positions every 15 seconds. If the issue persists, verify the `vector4` values in `Config.ParkingLot`. |
| License plate edit not showing | Set `Config.EditPlate = true` in the config. |
| SQL errors in server console | Verify `Config.SQLScript` matches the SQL resource running on your server (`oxmysql`, `ghmattimysql`, or `mysql-async`). |
| NUI not opening | Check that the `web/` folder contains `index.html`, `main.js`, and `style.css`. Ensure no other resource is blocking NUI focus. |

---

## Source

- **GitHub:** [https://github.com/gfx-fivem/gfx-secondhand](https://github.com/gfx-fivem/gfx-secondhand)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
