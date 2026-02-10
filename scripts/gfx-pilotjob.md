# gfx-pilotjob

## Info

| Key | Value |
|---|---|
| **Name** | gfx-pilotjob |
| **Description** | GFX Development Pilot Job |
| **FX Version** | Cerulean |
| **Lua 5.4** | Yes |
| **Game** | common |
| **Frameworks** | QBCore / ESX |
| **Data Storage** | JSON file (`database.json`) |
| **NUI** | Yes |

---

## Dependencies

| Dependency | Required | Notes |
|---|---|---|
| **qb-core** | Yes (if QBCore) | Framework core for QBCore servers |
| **es_extended** | Yes (if ESX) | Framework core for ESX servers |
| **vehiclekeys** | Optional | Used for granting vehicle key ownership (`vehiclekeys:client:SetOwner`) |
| **qb-phone** | Optional | Police alert integration for illegal missions (`qb-phone:client:addPoliceAlert`) |

---

## Installation

### 1. Copy Files
Place the `gfx-pilotjob` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-pilotjob
```

### 3. Configure Framework
Open `config.lua` and set `GFX.Framework` to your framework:
```lua
GFX.Framework = "qb" -- "esx" or "qb"
```

---

## Configuration

All configuration is done in `config.lua` via the `GFX` table.

### General Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `GFX.Framework` | `string` | `"qb"` | Framework type: `"qb"` or `"esx"` |
| `GFX.StartWork` | `vector3` | `vector3(-943.68, -2958.23, 13.95)` | Location of the pilot job NPC and map blip (LSIA area) |
| `GFX.DrawDistance` | `number` | `5` | Distance (in units) at which the NPC interaction prompt appears |
| `GFX.Ped` | `any` | `nil` | Reserved ped reference (not used in default config) |
| `GFX.PoliceText` | `string` | `"Someone is up for illegal cargo delivery"` | Alert message sent to police during illegal missions |
| `GFX.MoneyType` | `string` | `"cash"` | Money account type for rewards (e.g. `"cash"`, `"bank"`) |
| `GFX.WaitingSec` | `number` | `25` | Seconds the player waits at the cargo pickup point (NUI timer) |

### Reward Function

A custom function to handle reward distribution. By default it is empty and the script uses the built-in `AddMoney` function. You can override it for custom reward logic:

```lua
GFX.Reward = function(source, missionId, xPlayer)
    -- Example: xPlayer.Functions.AddMoney("cash", reward)
end
```

### Missions

Missions are defined in `GFX.Missions` as a numbered table. Each mission has the following structure:

| Field | Type | Description |
|---|---|---|
| `level` | `number` | Mission level (1-4) |
| `requiredJob` | `number` | Number of completed flights required to unlock this mission |
| `reward` | `number` | Money reward on completion |
| `coords` | `vector3` | Spawn coordinates for the aircraft |
| `plane` | `string` | Vehicle model name for the aircraft (e.g. `"miljet"`, `"raiju"`, `"alphaz1"`) |
| `type` | `string` | `"legal"` or `"illegal"` -- illegal missions alert police players |
| `markers` | `table` | Ordered list of `vector3` checkpoint coordinates defining the flight path |
| `veh` | `any` | Runtime vehicle reference (set to `nil` in config) |

**Default missions:**

| Mission | Level | Required Flights | Reward | Aircraft | Type |
|---|---|---|---|---|---|
| 1 | 1 | 0 | $10,000 | Miljet | Legal |
| 2 | 2 | 50 | $15,000 | Raiju | Illegal |
| 3 | 3 | 100 | $20,000 | Alpha-Z1 | Legal |
| 4 | 4 | 150 | $30,000 | Alpha-Z1 | Illegal |

### Locales

All user-facing text is defined in `GFX.Locales`:

| Key | Default Text |
|---|---|
| `planeExplode` | `"Mission failed because the plane exploded."` |
| `drawText` | `"Open Pilot Menu"` |
| `beforeproductWait` | `"Get the products"` |
| `finishText` | `"Finish mission"` |
| `reward` | `"You have successfully completed the mission. $%s has been added to your account."` |
| `startedMission` | `"The mission has started, please follow the checkpoints and complete the mission."` |
| `finishedMission` | `"The mission has finished."` |
| `toolowfly` | `"You Cant Fly That Low"` |
| `wrongWay` | `"You Are Going To Wrong Way Go Back Now."` |
| `wrongWay2` | `"You Have Gone To The Wrong Way."` |

### Hook Files

The script provides two hook files for framework-specific customization:

- **`client/client_hook.lua`** -- Contains client-side framework integration: `Notify()`, `DrawText3D()`, `AddVehicleKey()`, and the police alert handler. Modify `AddVehicleKey` to match your vehicle keys resource.
- **`server/server_hook.lua`** -- Contains server-side framework integration: `Notify()`, `GetPlayerFromId()`, `GetIdentifier()`, `GetPlayersAll()`, `GetJob()`, `GetSource()`, `AddMoney()`. Modify these functions if using a non-standard framework setup.

---

## Exports

*No exports are created by this script.*

---

## Events

Public API events that other scripts can listen to or trigger.

### Client Events

#### `gfx-pilotjob:client:CallCops`
Triggered on police players' clients when an illegal mission starts. Displays a blip and chat alert.

```lua
-- Parameters:
-- coords (vector3) - Location of the illegal flight activity
-- msg (string) - Alert message text

RegisterNetEvent('gfx-pilotjob:client:CallCops', function(coords, msg)
    -- Creates a fading radius blip at the coords
    -- Sends a chat message with the alert
end)
```

#### `missionFailed`
Triggered when a mission fails. Cleans up checkpoints and notifies the player.

```lua
-- Parameters:
-- vehicle (entity) - The mission vehicle entity

RegisterNetEvent('missionFailed', function(vehicle)
    -- Stops the mission and cleans up markers
end)
```

### Server Events

#### `gfx-pilotjob:server:CallCops`
Triggered by the client when an illegal mission starts. Broadcasts the alert to all online police players.

```lua
-- Parameters:
-- coords (vector3) - Location of the illegal flight activity

TriggerServerEvent("gfx-pilotjob:server:CallCops", coords)
```

#### `gfx-pilotjob:explodePlane`
Triggered when a plane needs to be destroyed (crash, flying too low, or vehicle health reaches zero).

```lua
-- Parameters:
-- planeNetId (number) - Network ID of the plane entity

TriggerServerEvent('gfx-pilotjob:explodePlane', planeNetId)
```

#### `gfx-pilotjob:deleteVehicle`
Triggered when a mission vehicle needs to be cleaned up (e.g. player disconnect).

```lua
-- Parameters:
-- vehicleNetId (number) - Network ID of the vehicle entity

TriggerEvent('gfx-pilotjob:deleteVehicle', vehicleNetId)
```

#### `gfx:server:UpdateCountAndGiveReward`
Triggered when a player completes a mission. Increments flight count and pays the reward.

```lua
-- Parameters:
-- key (number) - Mission index from GFX.Missions table

TriggerServerEvent("gfx:server:UpdateCountAndGiveReward", key)
```

---

## Commands

*No commands are registered by this script.*

---

## Features

- **Multi-level progression system** -- 4 mission levels unlocked by cumulative flight count (0, 50, 100, 150 flights)
- **Legal and illegal mission types** -- Illegal missions alert online police players with a blip and notification
- **Checkpoint-based flight paths** -- Players follow a series of 3D checkpoints through the sky
- **Round-trip missions** -- After reaching the destination, checkpoints reverse and the player flies back to the starting point
- **Cargo pickup timer** -- NUI-based countdown timer at the destination point before the return trip
- **Altitude enforcement** -- Flying too low during descent triggers mission failure and plane destruction
- **Plane health monitoring** -- If the aircraft is destroyed, the mission automatically fails
- **JSON-based player data** -- Flight counts are stored in `database.json` (no SQL dependency)
- **NUI menu** -- Interactive UI to view current level, flight count, progress toward next level, and select missions
- **Map blip** -- "Flight Mission" blip placed at the NPC location (LSIA)
- **NPC interaction** -- Pilot ped at the job location with proximity-based `[E]` prompt
- **Camera system** -- Cinematic camera focused on the aircraft during the cargo pickup phase
- **Dual framework support** -- Works with both QBCore and ESX via configurable hook files
- **Police integration** -- Illegal flights trigger alerts via chat message and optionally via qb-phone
- **Vehicle key integration** -- Spawned aircraft automatically receive vehicle key ownership
- **Player disconnect cleanup** -- Mission vehicles are deleted when players disconnect

---

## Troubleshooting

| Problem | Cause | Solution |
|---|---|---|
| NPC does not appear | Ped model failed to load or coordinates are wrong | Verify `GFX.StartWork` coordinates. Check server console for model loading errors. |
| Menu does not open | NUI page not loading or draw distance too low | Ensure `nui/` folder is included. Check `GFX.DrawDistance` value. Press `[E]` within range. |
| "Mission failed because the plane exploded" | Aircraft health reached zero or player flew below altitude threshold | Fly higher and avoid collisions. The script enforces a minimum altitude relative to checkpoints. |
| Player does not receive reward | `GFX.MoneyType` does not match framework account type, or `AddMoney` in `server_hook.lua` is not configured | Set `GFX.MoneyType` to a valid account type. For ESX, verify `addAccountMoney` usage in `server_hook.lua`. |
| Police not receiving alerts | No players have the `"police"` job online, or job name does not match | Ensure police job name is exactly `"police"`. Check `GetJob()` in `server_hook.lua` for your framework. |
| Vehicle keys not working | `vehiclekeys` resource not installed or event name differs | Edit `AddVehicleKey()` in `client_hook.lua` to match your vehicle key system's event/export. |
| Missions are locked | Player has not completed enough flights | Check `requiredJob` values in `GFX.Missions`. Mission 2 requires 50 flights, mission 3 requires 100, mission 4 requires 150. |
| Flight data not saving | `database.json` missing or unwritable | Ensure `database.json` exists in the resource root with at least `{}` as content. Check file permissions. |
| ESX framework errors | Hook functions reference QBCore-specific methods | Review `server_hook.lua` and `client_hook.lua`. Ensure ESX-specific branches are correctly configured for your version. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-pilotjob
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
