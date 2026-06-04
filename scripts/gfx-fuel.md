# gfx-fuel

## Info

| Key | Value |
|---|---|
| **Name** | gfx-fuel |
| **Author** | GFX Development |
| **FX Version** | Cerulean |
| **Game** | GTA5 |
| **Lua 5.4** | Yes |
| **Side** | Client + Server |
| **UI** | NUI (React buy/dashboard menu) + DUI pump screen |
| **Escrow** | Yes (with open-source server/client/config) |

## Description

A complete, bridge-wired gas station and fuel system for FiveM roleplay servers. Each vehicle tracks its own fuel level per plate, stored in entity statebags and persisted to the database. Fuel consumption is calculated client-side and validated server-side, scaling with vehicle speed, RPM, weather conditions, terrain incline, and vehicle class. Pulling up to a pump opens a live **DUI screen** on the physical prop that shows the current price, liters dispensed, and running total in real time.

Stations can be owned by players to unlock a stock economy: owners set the per-liter price, monitor a sales dashboard, run tanker supply missions (easy / medium / hard) to restock, and withdraw earnings from the station treasury. Unowned stations always serve fuel at the configured default price with unlimited stock. Wrong fuel damages the engine deterministically. Players can carry a **jerry can** item for emergency roadside refueling. **Electric vehicles** use separate charger props instead of liquid pumps.

Works across ESX, QBCore, and Qbox via gfx-lib — no framework branches in the resource.

---

## Dependencies

| Dependency | Purpose |
|---|---|
| **gfx-lib** | Framework bridge (required — auto-detects ESX / QBCore / Qbox, inventory, notify, target) |
| **oxmysql** | Database (or any SQL resource gfx-lib bridges: ghmattimysql, mysql-async) |
| **ox_target / qb-target** | Optional — pump and manager interaction zones use `Modules.AddCircleZone` if a target script is detected; falls back to an E-prompt 3D text |
| **Any gfx-lib–supported inventory** | Required to hold the `jerrycan` item (ox_inventory, qb-inventory, qs-inventory, etc.) |

---

## Installation

### 1. Import Database Tables

The resource auto-creates all tables on first start via `Modules.ExecuteSql`. No manual SQL import is required. Tables created:

| Table | Purpose |
|---|---|
| `gfx_fuel_vehicles` | Per-plate fuel level and type |
| `gfx_fuel_stations` | Owned-station state (owner, price, stock, treasury, etc.) |
| `gfx_fuel_station_stats` | Aggregate liters sold, revenue, spend per station |
| `gfx_fuel_transactions` | Per-station transaction log (sales, restocks, payouts) |
| `gfx_fuel_pending_payouts` | Offline seller payouts, settled on their next login |
| `gfx_fuel_missions` | Supply mission history |

### 2. Copy Files

Place the `gfx-fuel` folder into your server's resources directory.

### 3. server.cfg

```cfg
ensure gfx-lib
ensure gfx-fuel
```

`gfx-lib` **must** start before `gfx-fuel`.

### 4. Add the Jerry Can Item

Add a `jerrycan` item to your inventory system. The item name is configurable via `Config.JerryCan.Item`. The resource registers it as a usable item automatically via `Modules.RegisterItem`.

### 5. Configure Stations

Edit `config/stations.lua` to match your server's pump prop locations. Each station entry defines the pump world coordinates, economics, and fuel types available. See the Configuration section for the full field list.

### 6. Conflict Warning

`gfx-fuel` registers itself as the authoritative fuel provider via `Config.Fuel.RegisterAsBridgeProvider = true`. Do **not** run LegacyFuel, ox_fuel, or any other resource that writes to the `fuel` statebag alongside gfx-fuel. The `MirrorLegacyStatebag` option (default `true`) writes the value to the `fuel` statebag for HUD compatibility, but those fuel scripts must not be running.

---

## Configuration

### General

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Debug` | `boolean` | `false` | Enables debug commands and extra print output. Keep false in production. |
| `Config.PumpModel` | `hash` | `prop_gas_pump_1d` | The pump prop model this resource reads and overrides the screen of. |
| `Config.UseTarget` | `boolean` | `true` | Prefer `Modules.AddCircleZone` (ox_target / qb-target) when a target script is detected. Falls back to E-prompt. |
| `Config.RenderDist` | `number` | `35.0` | Distance in meters at which active pumps render their DUI screen or 3D text fallback. |
| `Config.PoolSize` | `number` | `6` | Maximum simultaneous per-pump overlay screens (covers one full station). |

### Interaction

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Interact.Key` | `number` | `38` | Fallback interact key control ID (38 = INPUT_PICKUP / E). Used when no target script is present. |
| `Config.Interact.MaxDist` | `number` | `2.2` | Distance in meters to interact with a pump. |
| `Config.Interact.VehicleDist` | `number` | `5.0` | Maximum distance from pump to vehicle for fueling. |

### Fuel (consumption + persistence)

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Fuel.TankCapacity` | `number` | `100.0` | Stored fuel ceiling in percent (0–100). Statebags hold this value. |
| `Config.Fuel.TankLiters` | `number` | `65.0` | Real tank size in liters. Used to convert percent to liters for pricing. |
| `Config.Fuel.LitersPerSec` | `number` | `8.0` | Fill rate while holding the pump (liters/sec). |
| `Config.Fuel.ConsumeInterval` | `number` | `2.5` | Seconds between client-side consumption ticks. |
| `Config.Fuel.BaseConsumption` | `number` | `0.05` | Base tank-percent consumed per second at idle-cruise. |
| `Config.Fuel.SpeedDivisor` | `number` | `240.0` | `speed_kmh / SpeedDivisor` → speed factor multiplier. |
| `Config.Fuel.RpmWeight` | `number` | `0.35` | `1 + rpm * RpmWeight` → RPM multiplier (hard acceleration costs more). |
| `Config.Fuel.MaxConsumePerTick` | `number` | `6.0` | Anti-cheat ceiling: server rejects consume deltas above this % per tick. |
| `Config.Fuel.PersistThreshold` | `number` | `1.0` | Write to DB when fuel has changed by at least this many % since the last write. |
| `Config.Fuel.PersistInterval` | `number` | `60` | Seconds between debounced DB flush cycles. |
| `Config.Fuel.StaleDays` | `number` | `14` | Purge vehicle rows not updated within this many days on boot. |
| `Config.Fuel.RegisterAsBridgeProvider` | `boolean` | `true` | Register gfx-fuel as the gfx-lib fuel provider. |
| `Config.Fuel.MirrorLegacyStatebag` | `boolean` | `true` | Also write to the `fuel` statebag for LegacyFuel-compatible HUDs. |
| `Config.Fuel.ClassMult` | `table` | *(per class)* | Per-vehicle-class consumption multiplier (index = `GetVehicleClass()`). |
| `Config.Fuel.WeatherMult` | `table` | *(per weather)* | Consumption multiplier per weather name (e.g. `SNOW=1.3`). |
| `Config.Fuel.TerrainMult` | `table` | road/offroad/incline | Consumption multiplier per terrain type (`road=1.0`, `offroad=1.25`, `incline=1.2`). |

### Wrong Fuel Damage

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Damage.BlockWrongFuel` | `boolean` | `false` | If true, refuse to dispense the wrong fuel entirely (no damage path). |
| `Config.Damage.WrongFuel` | `number` | `12.0` | Engine health lost per liter of wrong fuel dispensed. |
| `Config.Damage.Deterministic` | `boolean` | `true` | Contaminated vehicle stalls and stays stalled until the tank is drained and correct fuel is added. |

### Fuel Leak

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Leak.Enabled` | `boolean` | `true` | Enable fuel leak when driving off while a pump nozzle is still connected. |
| `Config.Leak.WastePct` | `number` | `0.4` | Fraction of the in-progress liters step wasted (charged but not delivered) on a yank. |
| `Config.Leak.Decal` | `boolean` | `true` | Spawn a petrol decal at the spill location. |

### Electric Vehicles

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.EV.ChargeRatePerSec` | `number` | `3.0` | kWh charged per second (slower than liquid fueling). |
| `Config.EV.PricePerKwh` | `number` | `0.45` | Fallback price per kWh when the station has no `evPrice` set. |
| `Config.EV.RequireEngineOff` | `boolean` | `true` | Vehicle engine must be off before charging begins. |
| `Config.EV.BatteryKwh` | `number` | `60.0` | Reference battery size for converting percent to kWh. |

### Jerry Can

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.JerryCan.Item` | `string` | `'jerrycan'` | Inventory item name for the jerry can. |
| `Config.JerryCan.Capacity` | `number` | `20.0` | Maximum liters a can holds. |
| `Config.JerryCan.LeakChance` | `number` | `0.08` | Probability (0–1) of spilling the remaining fuel when using the can. |
| `Config.JerryCan.SingleUse` | `boolean` | `false` | If true, the item is consumed entirely after one use regardless of remaining fuel. |
| `Config.JerryCan.TransferPerSec` | `number` | `4.0` | Liters per second transferred when emptying the can into a vehicle. |

### Manual HUD Badge

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Manual.Key` | `string` | `'F7'` | `RegisterKeyMapping` key to toggle the in-vehicle fuel badge. |
| `Config.Manual.Show3D` | `boolean` | `false` | If false, uses an NUI/HUD overlay; if true, shows 3D text above the vehicle hood. |

### Business / Ownership

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Business.MinPrice` | `number` | `1.0` | Global minimum price per liter (overridable per station). |
| `Config.Business.MaxPrice` | `number` | `8.0` | Global maximum price per liter (overridable per station). |
| `Config.Business.StartStock` | `number` | `10000.0` | Stock (liters) seeded when a station is first purchased (clamped to station `maxStock`). |
| `Config.Business.SystemCut` | `number` | `0.10` | House cut taken from every owned-station sale (10%). Owner receives `1 - SystemCut`. |
| `Config.Business.EnablePassiveDemand` | `boolean` | `true` | Simulate ambient NPC customers while the station is open. Computed lazily on read. |
| `Config.Business.PassiveDemandPerHour` | `number` | `120.0` | Liters drained from stock per hour by ambient demand. |
| `Config.Business.PassiveDemandMargin` | `number` | `0.5` | Fraction of the normal sale margin credited for ambient demand sales. |
| `Config.Business.ManagerPed` | `hash` | `s_m_m_autoshop_01` | Ped model spawned at each station for buy / dashboard interaction. |
| `Config.Business.WithdrawToBank` | `boolean` | `true` | Treasury withdrawals go to bank (else cash). |
| `Config.Business.LogSystemSales` | `boolean` | `false` | Log unowned station sales with actor `'system'` in the transaction table. |
| `Config.MaxTxHistory` | `number` | `20` | Number of recent transactions shown in the owner dashboard. |

### Supply Missions

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Mission.PayFromTreasury` | `boolean` | `true` | Deduct mission cost from the station treasury; otherwise charge the player. |
| `Config.Mission.MaxStockToStart` | `number` | `0.85` | Cannot start a restock if current stock exceeds this fraction of `maxStock`. |
| `Config.Mission.DeliverDist` | `number` | `8.0` | Distance in meters the tanker must be from the station to confirm delivery. |
| `Config.Mission.PickupDepot` | `vector3` | `vec3(2796, 1560, 24.5)` | Global fallback tanker pickup point (per-station `supplyDepot` takes priority). |

**Mission tiers** (`Config.Mission.Tiers`):

| Tier | Liters | Cost | Tanker Model | Time Limit |
|---|---|---|---|---|
| `easy` | 3,000 L | $4,500 | `tanker` | 600 s (10 min) |
| `medium` | 7,000 L | $9,500 | `tanker` | 900 s (15 min) |
| `hard` | 14,000 L | $17,000 | `tanker2` | 1,200 s (20 min) |

### Fuel Types

Defined in `config/vehicles.lua`. Resolution order: explicit model override → class fallback → `Config.DefaultFuelType`.

| Key | Label | Unit |
|---|---|---|
| `gasoline` | 87 Regular | L |
| `premium` | 91 Premium | L |
| `diesel` | Diesel | L |
| `electric` | Electric | kWh |

Use `Config.VehicleFuel` for explicit model overrides (e.g. `['surge'] = 'electric'`) and `Config.ClassFuel` for class-wide defaults (e.g. `[10] = 'diesel'` for industrial).

### Stations (`config/stations.lua`)

Each station entry in `Config.Stations` supports:

| Field | Type | Description |
|---|---|---|
| `label` | `string` | Display name shown in UI and notifications. |
| `blip` | `table` | Map blip (`sprite`, `color`, `scale`). |
| `buyPrice` | `number` | One-time purchase price to own the station. |
| `defaultPrice` | `number` | Fuel price per liter when unowned (and the owner's starting price). |
| `maxStock` | `number` | Maximum liters the station can hold when owned. |
| `minPrice` / `maxPrice` | `number\|nil` | Per-station price band; falls back to `Config.Business.MinPrice/MaxPrice`. |
| `fuelTypes` | `table` | List of fuel type keys this station dispenses (e.g. `{'gasoline','premium','diesel'}`). |
| `ev` | `boolean` | Whether this station has EV chargers. |
| `evPrice` | `number\|nil` | Per-station kWh price; falls back to `Config.EV.PricePerKwh`. |
| `pumps` | `table` | List of `vec3` world coordinates for `prop_gas_pump_1d` props. |
| `chargers` | `table` | List of `vec3` world coordinates for EV charger props. |
| `supplyDepot` | `vector3` | Tanker pickup location for this station's supply runs. |

---

## Exports

### Client Exports

#### `GetFuel`

Returns the current fuel level (percent 0–100) of a vehicle read from its statebag.

```lua
local fuel = exports['gfx-fuel']:GetFuel(veh)
-- veh: entity handle; defaults to the player's current vehicle if nil
-- returns: number (0.0 – 100.0)
```

#### `GetFuelType`

Returns the fuel type key string for a vehicle (`'gasoline'`, `'premium'`, `'diesel'`, `'electric'`).

```lua
local fuelType = exports['gfx-fuel']:GetFuelType(veh)
-- returns: string (defaults to Config.DefaultFuelType)
```

#### `SetFuel`

Sets a vehicle's fuel level. The call is driver-gated and round-trips through the server; the calling client must be the vehicle's driver.

```lua
local ok = exports['gfx-fuel']:SetFuel(veh, value)
-- value: number (0.0 – 100.0 percent)
-- returns: boolean (false if the vehicle is not networked)
```

#### `AddFuel`

Adds fuel to a vehicle. Same driver-gate and server round-trip as `SetFuel`.

```lua
local ok = exports['gfx-fuel']:AddFuel(veh, amount)
-- amount: number (percent to add)
-- returns: boolean
```

**HUD integration example** (read the statebag directly — no export call needed for a HUD):

```lua
-- Fastest path: read the replicated statebag from any client
local fuel     = Entity(vehicle).state.gfxFuel     -- number 0–100, or nil
local fuelType = Entity(vehicle).state.gfxFuelType -- string
local isBad    = Entity(vehicle).state.gfxFuelBad  -- true = wrong-fuel contamination
```

---

### Server Exports

#### `GetVehicleFuel`

Returns the authoritative fuel level for a plate from the server store.

```lua
local fuel = exports['gfx-fuel']:GetVehicleFuel(plate)
-- plate: string (exact plate text, trailing spaces stripped automatically)
-- returns: number | nil (nil if the vehicle has not been loaded yet)
```

#### `SetVehicleFuel`

Sets a vehicle's fuel level by network ID (server-authoritative).

```lua
local ok = exports['gfx-fuel']:SetVehicleFuel(netId, value)
-- netId: number, value: number (percent)
-- returns: boolean
```

#### `AddVehicleFuel`

Adds fuel to a vehicle by network ID.

```lua
local ok = exports['gfx-fuel']:AddVehicleFuel(netId, amount)
-- returns: boolean
```

#### `GetVehicleFuelType`

Returns the stored fuel type for a plate.

```lua
local fuelType = exports['gfx-fuel']:GetVehicleFuelType(plate)
-- returns: string | nil
```

#### `IsStationOwned`

Returns whether a station is currently owned.

```lua
local owned = exports['gfx-fuel']:IsStationOwned('ls_grove')
-- returns: boolean
```

#### `GetStationPrice`

Returns the effective fuel price for a station (owner's price if owned, `defaultPrice` otherwise).

```lua
local price = exports['gfx-fuel']:GetStationPrice('ls_grove')
-- returns: number
```

#### `GetTreasury`

Returns the station treasury balance in whole currency units.

```lua
local balance = exports['gfx-fuel']:GetTreasury('ls_grove')
-- returns: integer (0 if unowned)
```

#### `GetStation`

Returns a public snapshot table of a station's state.

```lua
local station = exports['gfx-fuel']:GetStation('ls_grove')
-- returns: table {
--   id, label, owned, price, open, forSale,
--   buyPrice (if unowned),
--   stock, maxStock, balance, salePrice (if owned)
-- }
```

---

## Events

### Server Events (incoming from clients)

| Event | Description |
|---|---|
| `gfx-fuel:server:consume` | Driver client sends a clamped fuel-consume delta; server validates and applies. |
| `gfx-fuel:server:ensureVehicle` | Driver reports first sight of a vehicle; server loads its fuel from DB if needed. |
| `gfx-fuel:server:setFuelRequest` | Client `SetFuel` export routes here (driver-gated). |
| `gfx-fuel:server:addFuelRequest` | Client `AddFuel` export routes here (driver-gated). |
| `gfx-fuel:server:drainTank` | Drain the nearest vehicle's tank to zero (recovery from wrong-fuel contamination). |
| `gfx-fuel:server:buyStation` | Player purchases an unowned station. |
| `gfx-fuel:server:buyCompany` | Player purchases a station that is listed for sale by another player. |
| `gfx-fuel:server:setPrice` | Owner sets the per-liter fuel price for their station. |
| `gfx-fuel:server:toggleOpen` | Owner opens or closes their station. |
| `gfx-fuel:server:withdraw` | Owner withdraws funds from the station treasury. |
| `gfx-fuel:server:listForSale` | Owner lists/unlists their station for player-to-player sale. |
| `gfx-fuel:server:startMission` | Owner initiates a supply run (difficulty: `easy`/`medium`/`hard`). |
| `gfx-fuel:server:deliverMission` | Owner confirms tanker delivery at the station. |
| `gfx-fuel:server:failMission` | Client reports mission failure (timeout or tanker destroyed). |
| `gfx-fuel:server:fillJerryCan` | Player fills a jerry can at a pump (server validates stock, money, range). |
| `gfx-fuel:server:useJerryCan` | Player uses the jerry can item on a vehicle (server reads real can contents). |
| `gfx-fuel:server:requestPumps` | Client requests the current pump-state table on join or resource restart. |
| `gfx-fuel:server:playerReady` | Client signals framework data is ready; server settles any pending sale payouts. |

### Client Events (incoming from server)

| Event | Description |
|---|---|
| `gfx-fuel:client:syncPumps` | Full pump-state table sent on join/restart. |
| `gfx-fuel:client:pumpUpdated` | Single pump-state delta (claim / release). |
| `gfx-fuel:client:outOfFuel` | Server tells the driver client to cut the engine (tank reached zero). |
| `gfx-fuel:client:stationUpdated` | Server broadcasts a refreshed public station snapshot after any ownership/price/stock change. |
| `gfx-fuel:client:startMission` | Server sends mission parameters to the initiating owner (depot coords, tanker model, time limit). |
| `gfx-fuel:client:missionDone` | Server confirms successful delivery. |
| `gfx-fuel:client:useJerryCan` | Server instructs the client to begin the jerry can use flow (target vehicle selection). |

### Callbacks (gfx-lib `Modules.RegisterCallback`)

| Name | Description |
|---|---|
| `gfx-fuel:getStationData` | Returns the public station snapshot for a given `stationId`. |
| `gfx-fuel:getDashboard` | Returns full dashboard data (station snapshot + stats + recent transactions) for the owner. |
| `gfx-fuel:canFuel` | Returns `{ ok, reason, price, owned }` — whether an owned station can currently serve. |

---

## Commands

| Command | Side | Description |
|---|---|---|
| `/draintank` | Client | Drains the nearest vehicle's tank to zero. Use near a contaminated vehicle after filling with the wrong fuel type, then refuel correctly to clear the contamination. |
| `gfxfuel_manual` (keybind) | Client | Toggles the in-vehicle fuel badge (default key: F7). Displays vehicle name, fuel type, and percent in the top-center HUD. |

**Debug commands** (only when `Config.Debug = true`):

| Command | Description |
|---|---|
| `/pumpdraw` | Toggle live DUI texture draw on screen to verify rendering. |
| `/pumpspawn` | Spawn a test pump prop in front of the player. |
| `/pumpmsg <price> <status>` | Push a test message to the global pump DUI screen. |
| `/pumpcal` | Toggle the UV calibration grid on the pump screen. |
| `/pumpfit <x> <y> <w> <h>` | Live-tune the texture sub-region the pump screen fills. |
| `/fuelinfo` | Print the current vehicle's fuel, type, and plate to the console. |
| `/setfuel <value>` | Set the current vehicle's fuel via the client export. |

---

## Features

- **Per-vehicle fuel persistence** — each vehicle's fuel and type are keyed by plate, stored via statebags and persisted to the database with a debounced write queue (no DB spam).
- **Server-authoritative consumption** — only the driver computes consumption; the server validates each delta and rejects values above `MaxConsumePerTick` (anti-cheat).
- **Live DUI pump screen** — the physical `prop_gas_pump_1d` prop's texture is replaced at runtime with a DUI page showing live price, liters dispensed, and total cost while pumping.
- **4 fuel types** — `gasoline`, `premium`, `diesel`, and `electric`, resolved per vehicle by model override, class fallback, or default.
- **Wrong-fuel engine damage** — dispensing the wrong type damages engine health by `Config.Damage.WrongFuel` per liter and flags the vehicle with the `gfxFuelBad` statebag, causing a deterministic stall until the tank is drained and correct fuel is added via `/draintank` + refuel.
- **Fuel leak** — driving off while the nozzle is connected wastes a configurable fraction of the in-progress fill and spawns a petrol particle effect.
- **EV charging** — electric vehicles use separate charger props; no stock consumed; EV sales credit the owner treasury. Liquid pumps reject EVs and vice versa.
- **Jerry can item** — usable `jerrycan` item that holds up to 20 L (configurable); supports partial fills, metadata-backed remaining fuel, leak chance, and wrong-fuel contamination from mismatched can contents.
- **Station ownership** — buy any station to activate its stock economy; set a per-liter price within the configured band; open/close the station; watch passive demand drain stock over time.
- **Owner dashboard** — React NUI panel showing current stock, treasury balance, recent transactions, lifetime stats (liters sold, revenue, spend), and supply mission controls.
- **Player-to-player station sale** — owner lists the station at a chosen price; another player buys it via the manager; the seller is paid online or via a pending payout on next login.
- **Supply missions (3 tiers)** — owner drives a tanker from a depot to the station within a time limit to restock; cost deducted from treasury or charged to the player; tanker is client-spawned and fails on disconnect or destruction.
- **Lazy passive demand** — ambient NPC customer sales are computed from elapsed time on read, not via a ticking timer, so there is zero server-side overhead while the station is idle.
- **HUD integration via statebags** — any HUD script reads `Entity(veh).state.gfxFuel`, `gfxFuelType`, and `gfxFuelBad` without calling any export; the `fuel` statebag is also mirrored for LegacyFuel-compatible HUDs.
- **gfx-lib bridge** — works on ESX, QBCore, and Qbox; abstracts inventory, money, notify, target, and SQL.
- **Target + fallback** — uses `ox_target`/`qb-target` when detected; falls back to an E-prompt with 3D text if no target script is present.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| `gfx-lib` not started error on boot | Ensure `ensure gfx-lib` appears **before** `ensure gfx-fuel` in `server.cfg`. |
| Database tables not created | gfx-fuel auto-bootstraps tables on start. Check that `oxmysql` (or your SQL resource) is running and that `gfx-lib` resolved it correctly. Check server console for SQL errors. |
| Pump screen is blank or shows no price | The DUI page loads from `web/pump/index.html`. Ensure the `files {}` block in `fxmanifest.lua` is intact. Try `/pumpdraw` (Debug mode) to verify the texture is rendering. The DSEG7 font referenced in the pump page must be present in `web/pump/`. |
| Fuel not decreasing while driving | The consumption thread only runs for the vehicle **driver** of a networked vehicle. Bicycles (class 13) are excluded. Verify the vehicle is networked and the player is in the driver seat (seat -1). |
| Vehicle stalls after wrong fuel | This is intended deterministic behavior. Use `/draintank` near the vehicle to empty the tank, then refuel with the correct fuel type to clear contamination. If `Config.Damage.BlockWrongFuel = true`, wrong fuel is refused entirely (no damage path). |
| Station shows as unowned but no buy option | The station must have a `buyPrice` set in `Config.Stations`. Stations without `buyPrice` cannot be purchased. |
| Jerry can fills but empties immediately | Inventory metadata support is required. Systems that do not support item metadata (e.g. basic esx_inventoryhud) will always read the can as full capacity. Switch to an inventory that supports metadata (ox_inventory, qb-inventory, qs-inventory). |
| EV vehicle at a liquid pump shows wrong message | Verify the vehicle's fuel type is resolving to `'electric'` via `Config.VehicleFuel` or `Config.ClassFuel`. Use `/fuelinfo` (Debug mode) to inspect the resolved type. |
| Supply mission fails instantly on start | The tanker model must be valid and streamable. The default uses `tanker` and `tanker2` (vanilla GTA models). Custom tanker models require streaming. Also verify the depot coordinates are accessible. |
| Another fuel resource is conflicting | Do **not** run LegacyFuel, ox_fuel, or any resource that writes the `fuel` statebag alongside gfx-fuel. Set `Config.Fuel.MirrorLegacyStatebag = false` if HUD compatibility is not needed and another resource is reading that statebag. |
| Station treasury not crediting | Ensure `Config.Business.SystemCut` is below 1.0. For EV sales, confirm the station has `ev = true` and at least one entry in `chargers`. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-fuel
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
