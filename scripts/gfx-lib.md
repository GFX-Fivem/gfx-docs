# gfx-lib

## Info

| Key | Value |
|---|---|
| **Name** | gfx-lib |
| **Version** | 1.1.0 |
| **Author** | atiysu |
| **Description** | Shared utility library for all GFX scripts. Handles framework detection, inventory bridging, target system abstraction, vehicle properties, player data, and common helper functions. |
| **Side** | Client & Server |
| **Framework** | ESX / QBCore (auto-detected) |
| **Lua 5.4** | Yes |
| **Discord** | https://discord.gg/gfxscripts |

---

## Dependencies

**Required (one of each category):**

| Category | Supported Scripts |
|---|---|
| **Framework** | `es_extended` (ESX), `qb-core` (QBCore) |
| **SQL** | `oxmysql`, `ghmattimysql`, `mysql-async` |

**Optional (auto-detected):**

| Category | Supported Scripts |
|---|---|
| **Inventory** | `qb-inventory`, `esx_inventoryhud`, `qs-inventory`, `codem-inventory`, `gfx-inventory`, `ox_inventory`, `ps-inventory`, `tgiann-inventory` |
| **Skin/Appearance** | `esx_skin`, `qb-clothing`, `skinchanger`, `illenium-appearance`, `fivem-appearance`, `tgiann-clothing`, `crm-appearance`, `rcore_clothing`, `bl_appearance` |
| **Target** | `ox_target`, `qb-target` |
| **Fuel** | `LegacyFuel`, `ox_fuel`, `lc_fuel`, `sna-fuel` / `esx-sna-fuel`, `okokGasStation`, `ti_fuel`, `cdn-fuel`, `ps-fuel` |
| **Vehicle Keys** | `qb-vehiclekeys`, `qs-vehiclekeys`, `okokGarage`, `tgiann-hotwire`, `cd_garage`, `Renewed-Vehiclekeys`, `wasabi_carlock` |
| **Notifications** | `QBCore`, `ESX`, `okokNotify`, `infinity-notify`, `ox_lib`, `t-notify` |

---

## Installation

1. Place the `gfx-lib` folder in your server's `resources` directory.
2. Add `ensure gfx-lib` to your `server.cfg` **before** any other `gfx-*` scripts.
3. Edit `config.lua` to match your server setup.
4. Edit `serverconfig.lua` to set your Discord bot token (required for Discord avatar feature).

---

## Configuration

### config.lua (Shared)

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.DrawText` | `number` | `3` | Draw text mode: `1` = 3D Text, `2` = GTA 5 Notification, `3` = Modern Floating Help Text |
| `Config.Debug` | `boolean` | `true` | Enable/disable debug prints in console |
| `Config.OldESX` | `boolean` | `false` | Set to `true` if using ESX 1.2 or earlier |
| `Config.LicenseType` | `string` | `"license"` | Player identifier type. Options: `"license"`, `"xbl"`, `"discord"`, `"steam"`, `"live"`, `"fivem"` |
| `Config.PhotoType` | `string` | `"steam"` | Player avatar source. Options: `"steam"`, `"discord"`, `"none"` |
| `Config.NoImage` | `string` | `"https://avatar.iran.liara.run/public/1"` | Fallback image URL when player avatar cannot be retrieved |

### serverconfig.lua (Server)

| Option | Type | Default | Description |
|---|---|---|---|
| `ServerConfig.DiscordBotToken` | `string` | `"YOUR_DISCORD_BOT_TOKEN"` | Discord bot token used for fetching Discord profile pictures |

---

## Exports

### Client Exports

#### `getModules`
Returns the client-side modules table containing all utility functions.

```lua
local modules = exports['gfx-lib']:getModules()
```

**Returns:** `table` -- The modules table with all client utility functions (see Features > Client Modules below).

---

#### `getUtils`
Returns the client-side Utils table containing detected framework info and bridge functions.

```lua
local utils = exports['gfx-lib']:getUtils()
```

**Returns:** `table` -- Table with keys: `Framework` (string), `FrameworkObject`, `FrameworkShared`, `SkinScript` (string), `TargetScript` (string).

---

#### `getShared`
Returns the shared utility table with fuel, notification, and vehicle key functions.

```lua
local shared = exports['gfx-lib']:getShared()
```

**Returns:** `table` -- Table with functions: `SetFuel`, `GetFuel`, `Notify`, `KeyExport`, `RemoveKeyExport`.

---

### Server Exports

#### `getModules`
Returns the server-side modules table containing all utility functions.

```lua
local modules = exports['gfx-lib']:getModules()
```

**Returns:** `table` -- The modules table with all server utility functions (see Features > Server Modules below).

---

#### `getUtils`
Returns the server-side Utils table containing detected framework and dependency info.

```lua
local utils = exports['gfx-lib']:getUtils()
```

**Returns:** `table` -- Table with keys: `Framework` (string), `FrameworkObject`, `FrameworkShared`, `InventoryName` (string), `SkinScript` (string), `SQLScript` (string).

---

#### `getShared`
Returns the shared utility table (same as client) with fuel, notification, and vehicle key functions.

```lua
local shared = exports['gfx-lib']:getShared()
```

**Returns:** `table` -- Table with functions: `SetFuel`, `GetFuel`, `Notify`, `KeyExport`, `RemoveKeyExport`.

---

## Events

### Server Events

#### `gfx-lib:server:onDeath`
Triggered from the client death detection system when a player dies. Can be listened to by other scripts for death-related logic (death logs, kill feeds, etc.).

```lua
RegisterNetEvent('gfx-lib:server:onDeath', function(data)
    -- data.victimId      (number) - Server ID of the player who died
    -- data.killerServerId (number) - Server ID of the killer (0 if no player killer)
    -- data.weaponHash    (number) - Weapon hash that caused the death
    -- data.deathCoords   (table)  - { x = number, y = number, z = number }
end)
```

| Parameter | Type | Description |
|---|---|---|
| `data.victimId` | `number` | Server ID of the dead player |
| `data.killerServerId` | `number` | Server ID of the killer player, `0` if killed by NPC or environment |
| `data.weaponHash` | `number` | Hash of the weapon/cause of death |
| `data.deathCoords` | `table` | Coordinates where the death occurred (`x`, `y`, `z`) |

---

## Commands

This script does not register any commands.

---

## Features

### Auto-Detection System

On startup, `gfx-lib` automatically detects and initializes:

- **Framework** -- ESX or QBCore
- **Inventory** -- Whichever supported inventory is running (server only)
- **Skin/Appearance Script** -- Whichever supported appearance script is running
- **Target Script** -- ox_target or qb-target (client only)
- **SQL Script** -- oxmysql, ghmattimysql, or mysql-async (server only)

Detected results are printed to the server console on startup.

---

### Client Modules

Access via `exports['gfx-lib']:getModules()`. All functions are on the returned table.

| Function | Parameters | Description |
|---|---|---|
| `prin(...)` | `...` -- any values | Debug print (respects `Config.Debug`) |
| `table_copy(obj, seen)` | `obj` table, `seen` optional | Deep copy a table |
| `TriggerCallback(name, ...)` | `name` string, `...` args | Trigger a server callback registered with `RegisterCallback`, returns result synchronously (5s timeout) |
| `GetClosestPedToPlayer()` | -- | Returns `ped, distance` of nearest non-player ped |
| `GetClosestVehicleToPlayer()` | -- | Returns `vehicle, distance` of nearest vehicle |
| `LoadAnimDict(dict)` | `dict` string | Loads an animation dictionary and yields until loaded |
| `LoadModel(dict)` | `dict` string/hash | Loads a model (5s timeout). Returns `boolean` |
| `LoadObject(dict)` | `dict` string/hash | Loads an object model (5s timeout). Returns `boolean` |
| `LoadPtfxAsset(asset)` | `asset` string | Loads a particle effect asset (5s timeout). Returns `boolean` |
| `CreatePedOnCoord(x, y, z, w, model, network, freeze, invincible)` | coords, heading, model string/hash, booleans | Creates a ped at given coords. Auto-tracked for cleanup on resource stop. Returns `ped` |
| `SetPedSkin(ped, skin)` | `ped` entity, `skin` table | Applies skin data to a ped using the detected appearance script |
| `CreateBlipOnCoords(x, y, z, sprite, color, text)` | coords, sprite number, color number, text string | Creates a map blip. Auto-tracked for cleanup on resource stop. Returns `blip` |
| `table_size(t)` | `t` table | Returns the number of entries in a table (works for non-sequential tables) |
| `DrawText3D(x, y, z, text)` | coords, text string | Draws text in the world using the mode set in `Config.DrawText` |
| `ShowNotification(text)` | `text` string | Shows a native GTA notification |
| `PlayAnimationWithEntity(entity, dict, anim, flags, length)` | entity, dict string, anim string, flags number, length number | Loads anim dict and plays animation on entity |
| `ClearTableKeys(t)` | `t` table | Converts a keyed table to a sequential array |
| `Round(value, numDecimalPlaces)` | `value` number, `numDecimalPlaces` number or nil | Rounds a number to given decimal places |
| `GetVehicleProperties(vehicle)` | `vehicle` entity | Returns a full table of vehicle properties (mods, colors, health, extras, etc.) |
| `SetVehicleProperties(vehicle, props)` | `vehicle` entity, `props` table | Applies a properties table to a vehicle (as returned by `GetVehicleProperties`) |
| `StringArrayToArray(str)` | `str` string | Parses a `{key:value, ...}` formatted string into a table |
| `RemoveSpaces(str)` | `str` string | Trims and collapses whitespace in a string |
| `AddCircleZone(options)` | `options` table | Creates a target circle zone (ox_target or qb-target). Auto-tracked for cleanup. Options: `name`, `coords`, `radius`, `label`, `icon`, `distance`, `onSelect` |
| `RemoveZone(id)` | `id` string | Removes a target zone by ID |
| `GetPlayerData()` | -- | Returns the local player's data from the framework |
| `GetPlayerLicense()` | -- | Returns the local player's citizenid (QB) or identifier (ESX) |
| `GetPlayerJob()` | -- | Returns the local player's job data |

---

### Server Modules

Access via `exports['gfx-lib']:getModules()`. All functions are on the returned table.

| Function | Parameters | Description |
|---|---|---|
| `prin(...)` | `...` -- any values | Debug print (respects `Config.Debug`) |
| `table_copy(obj, seen)` | `obj` table, `seen` optional | Deep copy a table |
| `RemoveSpaces(str)` | `str` string | Trims and collapses whitespace |
| `RegisterCallback(name, cb)` | `name` string, `cb` function(source, ...) | Registers a server callback that clients can trigger via `TriggerCallback` |
| `ExecuteSql(query, parameters, cb)` | `query` string, `parameters` table, `cb` optional function | Executes a SQL query using the detected SQL resource. Returns result synchronously |
| `RegisterItem(item, handler)` | `item` string, `handler` function | Registers a useable item in the framework |
| `GetPlayerSkinData(id, includeModel)` | `id` string or number, `includeModel` boolean | Retrieves player skin/appearance data from the database. Returns `{ skin = table, model = string or nil }` |
| `AddItem(source, item, count, slot, metadata)` | source number, item string, count number, slot optional, metadata optional | Adds an item to a player's inventory |
| `RemoveItem(source, item, count, slot, metadata)` | source number, item string, count number, slot optional, metadata optional | Removes an item from a player's inventory |
| `GetInventory(source)` | `source` number | Returns the player's full inventory. Normalizes `amount`/`count` fields |
| `GetItemCount(source, item)` | `source` number, `item` string | Returns the count of a specific item in the player's inventory |
| `HasItem(source, item, count)` | `source` number, `item` string, `count` number | Returns `boolean` whether the player has at least `count` of the item |
| `GetMoney(source, moneyType)` | `source` number, `moneyType` string (`"cash"`, `"bank"`) | Returns the player's money of the given type |
| `AddMoney(source, amount, type)` | `source` number, `amount` number, `type` string | Adds money to a player |
| `RemoveMoney(source, amount, type)` | `source` number, `amount` number, `type` string | Removes money from a player |
| `HasMoney(source, amount, type)` | `source` number, `amount` number, `type` string | Returns `boolean` whether the player has enough money |
| `AddVehicleToPlayer(source, vehicle, props)` | `source` number, `vehicle` string (model), `props` table | Inserts a vehicle into the database for the player |
| `GetPlayerPhoto(source)` | `source` number | Returns the player's avatar URL (Steam or Discord, based on `Config.PhotoType`) |
| `GetPlayer(source)` | `source` number | Returns the framework player object (xPlayer for ESX, Player for QB) |
| `GetPlayerFromIdentifier(identifier)` | `identifier` string | Returns the framework player object by identifier/citizenid |
| `GetPlayerFromCharacterId(charId)` | `charId` string | Returns the framework player object by character ID |
| `GetIdentifier(source)` | `source` number | Returns the player's identifier (ESX) or citizenid (QBCore) |
| `GetPlayerNameBySource(source)` | `source` number | Returns the player's in-game character name |
| `GetPlayerLicense(source, idType)` | `source` number, `idType` optional string | Returns a player's identifier of the given type (defaults to `Config.LicenseType`) |
| `GeneratePlate()` | -- | Generates a unique random 8-character license plate (checks DB for duplicates) |
| `GetDiscordProfilePicture(source)` | `source` number | Fetches the player's Discord avatar URL |
| `GetSteamProfilePicture(source)` | `source` number | Fetches the player's Steam avatar URL |
| `GetIDFromSource(Type, CurrentID)` | `Type` string, `CurrentID` string | Extracts an ID of a given type from a FiveM identifier string |
| `stringsplit(input, seperator)` | `input` string, `seperator` string | Splits a string by a separator |

---

### Shared Functions

Access via `exports['gfx-lib']:getShared()`. Works on both client and server.

| Function | Parameters | Description |
|---|---|---|
| `SetFuel(vehicle, fuel)` | `vehicle` entity, `fuel` number | Sets vehicle fuel using the detected fuel script |
| `GetFuel(vehicle)` | `vehicle` entity | Gets vehicle fuel level. Returns `number` |
| `Notify(msg, type, source)` | `msg` string, `type` string, `source` optional number | Sends a notification using the detected notification system. Pass `source` for server-to-client |
| `KeyExport(vehicle, plate)` | `vehicle` entity, `plate` string | Gives vehicle keys to the player using the detected key system |
| `RemoveKeyExport(plate, model)` | `plate` string, `model` optional | Removes vehicle keys from the player |

---

### Callback System

`gfx-lib` provides a lightweight client-to-server callback system.

**Server -- Register a callback:**
```lua
local modules = exports['gfx-lib']:getModules()

modules.RegisterCallback('myScript:getData', function(source, arg1, arg2)
    -- Process and return data
    return { result = true }
end)
```

**Client -- Trigger the callback:**
```lua
local modules = exports['gfx-lib']:getModules()

local result = modules.TriggerCallback('myScript:getData', arg1, arg2)
-- result is the value returned from the server callback (5 second timeout, returns false on timeout)
```

---

### Death Detection System

The client automatically detects player deaths using the `CEventNetworkEntityDamage` game event. When a death is confirmed:

- Identifies the victim and killer (supports vehicle kills)
- Extracts the weapon hash and death coordinates
- Fires `gfx-lib:server:onDeath` to the server with full death data
- Includes a 3-second cooldown to prevent duplicate events
- Cooldown entries are cleaned up every 60 seconds

---

### Automatic Resource Cleanup

When a resource that used `gfx-lib` stops, the library automatically cleans up:

- **Peds** created via `modules.CreatePedOnCoord` are deleted
- **Blips** created via `modules.CreateBlipOnCoords` are removed
- **Target zones** created via `modules.AddCircleZone` are removed

This prevents orphaned entities and map markers after script restarts.

---

### Version Check

On server start, `gfx-lib` checks for updates by comparing the local version against a remote version file on GitHub. The console will display:

- A message if a newer version is available (with changelog)
- A confirmation if the current version is up to date

---

## Troubleshooting

| Problem | Solution |
|---|---|
| `Framework: Not found` in console | Ensure `es_extended` or `qb-core` is started **before** `gfx-lib` in your `server.cfg`. |
| `Inventory: Not found` in console | Ensure your inventory resource is started before `gfx-lib`. Check that your inventory is in the supported list above. |
| `SQLScript: Not found` in console | Ensure `oxmysql`, `ghmattimysql`, or `mysql-async` is started before `gfx-lib`. |
| Exports return nil / hang | `getModules()` and `getUtils()` wait until the framework is fully initialized. If they hang, the framework resource may not be running. |
| Discord avatars not working | Set a valid Discord bot token in `serverconfig.lua`. The bot must be in your Discord server. |
| Steam avatars not working | The player must have a Steam identifier. Ensure Steam is linked in the player's FiveM account. |
| Old ESX compatibility issues | Set `Config.OldESX = true` in `config.lua` if you are running ESX 1.2 or earlier. |
| Death events firing multiple times | The built-in 3-second cooldown should prevent this. If issues persist, check for other scripts triggering the same game event. |
| Target zones not appearing | Ensure `ox_target` or `qb-target` is started before `gfx-lib`. The zone creation waits for the target script to be detected. |
| Draw text not visible | Check `Config.DrawText` value: `1` = 3D world text, `2` = GTA help notification, `3` = modern floating text. |
| `Config.LicenseType` not matching | Ensure the identifier type exists for the player. Common types: `license`, `steam`, `discord`, `fivem`. |
