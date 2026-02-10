# gfx-vehicleshop

A fully featured vehicle shop script for FiveM with an immersive gallery experience. Players enter an interior showroom with cinematic camera angles, browse vehicles by category, preview them with real handling stats, take test drives, and purchase vehicles using cash or bank funds. Includes a stock management system and routing bucket isolation for private browsing sessions.

---

## Info

| Key | Value |
|---|---|
| **Resource name** | `gfx-vehicleshop` |
| **Author** | atiysu |
| **FX Version** | cerulean |
| **Lua 5.4** | Yes |
| **UI** | NUI (HTML) |
| **Frameworks** | QBCore, ESX |
| **MySQL Support** | oxmysql, mysql-async, ghmattimysql |

---

## Dependencies

| Dependency | Purpose |
|---|---|
| **qb-core** or **es_extended** | Framework (player data, money, callbacks) |
| **oxmysql** / **mysql-async** / **ghmattimysql** | Database queries (vehicle ownership, plate generation) |

---

## Installation

### 1. Copy the resource
Place `gfx-vehicleshop` into your server's resources folder.

### 2. Add to server.cfg
```cfg
ensure gfx-vehicleshop
```

### 3. Configure
Edit `config.lua` to set your framework, MySQL driver, shop locations, vehicle categories, and prices.

### 4. First Start
On first start, the script automatically generates `stock.json` from the vehicle data defined in `Config.Categories`. This file tracks per-vehicle stock levels.

---

## Configuration

All configuration is done in `config.lua`.

### General Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Framework` | `string` | `"qb"` | Framework to use. `"qb"` for QBCore, `"esx"` for ESX. |
| `Config.MySQL` | `string` | `"oxmysql"` | MySQL resource. Options: `"oxmysql"`, `"mysql-async"`, `"ghmattimysql"`. |

### Callback Functions

| Function | Description |
|---|---|
| `Config.OnMenuOpen()` | Called when the gallery menu opens. Add custom logic here (e.g., disable controls). |
| `Config.OnMenuClose()` | Called when the gallery menu closes. Add custom logic here (e.g., re-enable controls). |
| `Config.Notify(message, type)` | Notification function. Uses framework's built-in notify by default. |
| `Config.KeyExport(veh, plate)` | Called after purchase to give vehicle keys. Default triggers `vehiclekeys:client:SetOwner`. |

### Test Drive Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.TestDrive.Time` | `number` | `60` | Test drive duration in seconds. |
| `Config.TestDrive.Coords` | `vector4` | Airport area | Coordinates where the player is teleported for the test drive. |

### Shop Configuration

Each shop is defined inside `Config.Shops` with a unique key. Multiple shops can be configured.

| Option | Type | Description |
|---|---|---|
| `Label` | `string` | Display name of the shop. |
| `Entrance` | `vector3` | World position of the entrance marker. |
| `PlayerCoords` | `vector4` | Player spawn position inside the showroom interior. |
| `VehicleCoords` | `vector4` | Vehicle display position inside the showroom. |
| `CamCoords` | `vector3` | Camera position for the showroom view. |
| `CamPointCoords` | `vector3` | Camera look-at target position. |
| `CategorySelectedCoords` | `vector3` | Camera position when a category is selected. |
| `PreviewCoords` | `vector3` | Camera position for vehicle preview mode. |
| `PurchaseVehicleCoords` | `vector4` | World position where the purchased vehicle spawns. |
| `Job` | `string` | Required job name. Set to `"none"` for public access. |
| `SpawnPed` | `boolean` | Whether to spawn an NPC at the entrance. |
| `Ped.Model` | `string` | Ped model name (e.g., `"s_m_m_highsec_01"`). |
| `Ped.Coords` | `vector4` | Ped spawn position and heading. |
| `CreateBlip` | `boolean` | Whether to create a map blip for this shop. |
| `Blip.Sprite` | `number` | Blip sprite ID. |
| `Blip.Color` | `number` | Blip color ID. |
| `Blip.Size` | `number` | Blip scale. |
| `Blip.Name` | `string` | Blip display name. |
| `Blip.Coords` | `vector3` | Blip position on the map. |
| `SpecificCategories` | `boolean` | If `true`, only categories set to `true` in the `Categories` table are available. |
| `Categories` | `table` | Key-value pairs of category names and their enabled state (`true`/`false`). |

### Vehicle Categories

Defined in `Config.Categories`. Each category has a `Label` and a `Vehicles` table.

Each vehicle entry requires:

| Field | Type | Description |
|---|---|---|
| `label` | `string` | Display name of the vehicle. |
| `price` | `number` | Purchase price. |
| `stock` | `number` | Initial stock count (used to generate `stock.json` on first run). |

**Default categories:** police, boats, helicopters, compacts, coupes, motorcycles, muscle, off-road, sedans, sports, sports_classic, super, suvs, vans.

---

## Exports

*No exports are created by this script.*

---

## Events

### Client Events

#### `aty_vehicleshop:client:sendStock`
Receives stock data from the server when entering a shop.

| Parameter | Type | Description |
|---|---|---|
| `stock` | `table` | Stock data table containing vehicle stock levels. |

```lua
-- Sent by the server, received on client
RegisterNetEvent("aty_vehicleshop:client:sendStock", function(stock) end)
```

#### `aty_vehicleshop:setPlate`
Sets the license plate on the purchased vehicle after a successful purchase.

| Parameter | Type | Description |
|---|---|---|
| `plate` | `string` | The generated license plate text. |

```lua
-- Sent by the server after purchase
RegisterNetEvent("aty_vehicleshop:setPlate", function(plate) end)
```

### Server Events

#### `aty_vehicleshop:server:createRandomBucket`
Creates a random routing bucket for the player to isolate their showroom session. No parameters -- uses `source` internally.

```lua
-- Triggered from the client when entering a shop
TriggerServerEvent("aty_vehicleshop:server:createRandomBucket")
```

#### `aty_vehicleshop:server:sendBackBucket`
Returns the player to their original routing bucket after leaving the shop or purchasing a vehicle. No parameters -- uses `source` internally.

```lua
-- Triggered from the client when exiting
TriggerServerEvent("aty_vehicleshop:server:sendBackBucket")
```

### Server Callbacks

#### `aty_vehicleshop:server:purchase`
Handles the vehicle purchase transaction. Validates funds, deducts money, decrements stock, generates a unique plate, and inserts the vehicle into the database.

| Parameter | Type | Description |
|---|---|---|
| `vehicle` | `string` | Vehicle spawn name (e.g., `"adder"`). |
| `moneyType` | `string` | Payment method: `"cash"` or `"bank"`. |
| `props` | `table` | Vehicle properties table from the framework. |

Returns `true` on success or `false` with a reason string on failure.

---

## Commands

*No commands are registered by this script.*

---

## Features

- **Immersive gallery showroom** -- Players are teleported into a dedicated interior with cinematic camera angles for browsing vehicles.
- **Routing bucket isolation** -- Each player enters a unique routing bucket when browsing, ensuring private showroom sessions without interference from other players.
- **Category-based browsing** -- Vehicles are organized into 14 default categories (compacts, coupes, motorcycles, muscle, off-road, sedans, sports, sports classic, super, SUVs, vans, boats, helicopters, police).
- **Real-time vehicle stats** -- Displays handling data (speed, acceleration, handling, braking) as percentages calculated from the vehicle's actual handling values.
- **Test drive system** -- Players can test drive any vehicle for a configurable duration at a designated location, with automatic return to the showroom when time expires or the player exits manually.
- **Stock management** -- Each vehicle has a limited stock count tracked in `stock.json`. Stock decreases on purchase and displays availability in the UI.
- **Dual payment methods** -- Supports purchasing with either cash or bank account funds.
- **Job-restricted shops** -- Each shop can be locked to a specific job or set to `"none"` for public access.
- **Multiple shop locations** -- Configure any number of independent shops, each with their own categories, entrance, interior coordinates, and spawn points. Default includes a vehicle gallery and a helicopter gallery.
- **NPC peds at entrances** -- Optional configurable peds spawn at shop entrances for immersion.
- **Map blips** -- Optional configurable blips for each shop location.
- **Unique plate generation** -- Purchased vehicles receive a randomly generated unique license plate verified against the database.
- **Multi-framework support** -- Works with both QBCore and ESX frameworks.
- **Multi-MySQL support** -- Compatible with oxmysql, mysql-async, and ghmattimysql.
- **NUI interface** -- Full HTML/JS/CSS user interface for vehicle browsing, previewing, and purchasing.
- **Locale system** -- Configurable text strings in `locales.lua` for help texts and notifications.

---

## Troubleshooting

| Issue | Cause | Solution |
|---|---|---|
| Shop marker not appearing | Player is too far from the entrance or not on foot | Walk closer to the configured `Entrance` coordinates. Markers only render within 10 units and while not in a vehicle. |
| Cannot enter shop | Job restriction | Check `Config.Shops[shop].Job`. Set to `"none"` for public access. |
| Vehicles not loading in showroom | Model not streaming | Ensure the vehicle model exists on the server. Custom vehicles need proper `stream/` folder setup. |
| Stock shows 0 for all vehicles | `stock.json` is empty or corrupted | Delete `stock.json` and restart the resource. It will regenerate from `Config.Categories`. |
| "Player not found" on purchase | Framework mismatch | Verify `Config.Framework` matches your server's framework (`"qb"` or `"esx"`). |
| Database insert fails on purchase | Wrong MySQL resource | Verify `Config.MySQL` matches your MySQL resource name. |
| Vehicle keys not given after purchase | Key script mismatch | Edit `Config.KeyExport(veh, plate)` in config to match your vehicle keys resource. |
| Player stuck in showroom | Routing bucket issue | Restart the resource. The `onResourceStop` handler cleans up entities and blips but routing buckets may need a reconnect. |
| Test drive timer not resetting | Script restarted during test drive | Reconnect or restart the resource. `Config.TestDrive.Time` is mutated at runtime and resets to 60 on restart. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-vehicleshop
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
