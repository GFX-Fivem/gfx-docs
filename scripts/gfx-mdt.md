# gfx-mdt

## Info

| Key | Value |
|---|---|
| **Name** | gfx-mdt |
| **Author** | GFX Development |
| **FX Version** | Cerulean |
| **Game** | GTA5 |
| **Lua 5.4** | Yes |
| **Side** | Client + Server |
| **UI** | NUI (React + Vite) |
| **Escrow** | Yes (with open-source server/client/config/locale) |

## Description

A full-featured Mobile Data Terminal (MDT) for FiveM law enforcement roleplay. Officers open a tablet interface to manage criminal records, wanted lists, fines, department bans, live map, CCTV cameras, dispatch alerts, and in-MDT messaging. The tablet prop and holding animation play automatically when the MDT is opened. Supports ESX (current and legacy) and QBCore (current and legacy). All database tables are created automatically on first resource start — no manual SQL import is required.

---

## Dependencies

| Dependency | Purpose |
|---|---|
| **QBCore** or **ESX** | Framework (configured via `Config.Framework`) |
| **oxmysql** / **ghmattimysql** / **mysql-async** | Database queries (configured via `Config.SQLScript`) |
| **screenshot-basic** | In-MDT photo capture (uploads to Discord webhook) |

---

## Installation

### 1. Database Tables

The resource calls `EnsureMDTTables()` on startup and creates all required tables automatically. No manual SQL import is needed. On QBCore the following columns are also added to the default framework tables if absent:

- `players.ranks` (longtext)
- `players.evidences` (longtext)
- `player_vehicles.image` (longtext)

### 2. Copy Files

Place the `gfx-mdt` folder into your server's resources directory.

### 3. server.cfg

```cfg
ensure gfx-mdt
```

Make sure your framework (`qb-core` or `es_extended`), SQL resource, and `screenshot-basic` start before this resource.

### 4. QBCore Only: Add Tablet Item

If `Config.Open.item.enable` is `true`, add the `tablet` item to your QBCore shared items so players can use it from their inventory:

```lua
tablet = { name = "tablet", label = "Tablet", weight = 500, type = "item", image = "tablet.png", unique = true, useable = true, shouldClose = true, description = "MDT Tablet" },
```

### 5. Discord Webhook

Set `Config.discordWebhook` to a valid Discord webhook URL. This is required for the in-MDT photo capture feature (`screenshot-basic` uploads screenshots to this channel).

### 6. Configure

Edit `config.lua` to match your server's framework, SQL resource, jobs, department info, crime tags, and CCTV cameras.

---

## Configuration

All configuration is in `config.lua`.

### Open Method

| Option | Type | Default | Description |
|---|---|---|---|
| `Open.command.enable` | `boolean` | `true` | Enables the `/mdt` chat command |
| `Open.command.name` | `string` | `"mdt"` | The command name (without `/`) |
| `Open.item.enable` | `boolean` | `true` | Enables opening via a usable item |
| `Open.item.name` | `string` | `"tablet"` | Inventory item name that opens the MDT |

### General Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `MoneySymbol` | `string` | `"$"` | Currency symbol shown next to fine amounts in the UI |
| `Framework` | `string` | `"newqb"` | Framework: `"esx"`, `"oldesx"`, `"qb"`, `"newqb"` |
| `SQLScript` | `string` | `"oxmysql"` | SQL resource: `"oxmysql"`, `"ghmattimysql"`, `"mysql-async"` |
| `discordWebhook` | `string` | — | Discord webhook URL for screenshot uploads |
| `DefaultAvatar` | `string` | — | Fallback avatar image URL for officers/offenders |
| `DefaultVehicleAvatar` | `string` | — | Fallback image URL for vehicles |
| `Prefix` | `string` | `"!"` | Prefix prepended to officer map blip labels (set `""` to disable) |

### Department Info

Displayed on the Department page of the MDT.

| Option | Type | Description |
|---|---|---|
| `Department.image` | `string` | Department logo URL |
| `Department.name` | `string` | Department name (e.g. `"LSPD"`) |
| `Department.location` | `string` | Department address string |
| `Department.description` | `string` | Department description (editable in-MDT by authorized officers) |
| `Department.totalPersonal` | `string` | Format string `"%s/750"` — filled automatically with total officer count |
| `Department.totalBans` | `number` | Updated dynamically at runtime |

### Authorized Jobs

Controls which jobs can open and use the MDT. `mapColor` sets the officer's color on the live map (`"blue"`, `"orange"`, `"red"`, or `"purple"`).

```lua
Jobs = {
    ["police"] = { ableToUse = true, mapColor = "blue" },
    ["sheriff"] = { ableToUse = true, mapColor = "orange" },
    ["ambulance"] = { ableToUse = true, mapColor = "red" },
},
```

### Crime Tags

Labels for criminal rank classifications applied to records, wanteds, and offender profiles.

```lua
CrimeTags = {
    [1] = { label = "None" },
    [2] = { label = "Suspect" },
    [3] = { label = "Murderer" },
    [4] = { label = "Smuggler" },
    [5] = { label = "Robber" },
},
```

### Permissions

Role-based restrictions within the MDT for adding/editing messages and fines. Values are job grade name strings.

| Option | Type | Default | Description |
|---|---|---|---|
| `Permissions.addMessage` | `table` | `{'Chief', 'Officer'}` | Grades that can add messages |
| `Permissions.addFines` | `table` | `{'Chief', 'Officer'}` | Grades that can add fines |
| `Permissions.editFines` | `table` | `{'Chief', 'Officer'}` | Grades that can edit fines |

### Panic Button Types

Defines blip appearance and duration for each panic alert level.

| Type | Color | Scale | Duration |
|---|---|---|---|
| `safe` | 18 (green) | 1.5 | 30 seconds |
| `normal` | 5 (yellow) | 1.7 | 45 seconds |
| `emergency` | 1 (red) | 1.9 | 60 seconds |

### License Types

Which license types to display on player profile pages. Default: `{ ["dmv"] = true }`.

### CCTV Cameras

Each entry defines a scripted camera accessible from the Cameras page of the MDT.

| Field | Type | Description |
|---|---|---|
| `id` | `number` | Camera identifier |
| `title` | `string` | Display name in the cameras list |
| `image` | `string` | Preview thumbnail URL |
| `coords` | `vector3` | World coordinates of the camera |
| `rotation` | `vector3` | Initial camera rotation (pitch/roll/yaw) |
| `fov` | `number` | Field of view in degrees |
| `canRotate` | `boolean` | Allow arrow-key rotation while viewing |
| `canMove` | `boolean` | Alias — also controls rotation input |
| `canZoom` | `boolean` | Reserved for future zoom support |

### Automatic Dispatch Events

| Option | Type | Default | Description |
|---|---|---|---|
| `Dispatches.StealVehicle` | `boolean` | `true` | Reserved — dispatch on vehicle theft |
| `Dispatches.GunShot` | `boolean` | `true` | Auto-dispatch when a player fires a weapon (15–30 s cooldown) |

### Job Grades (ESX)

Maps ESX job grade numbers to label strings for rank display.

```lua
JobGrades = {
    [1] = "Officer",
    [2] = "Sergeant"
},
```

---

## Exports

### Client Exports

#### `AddDispatch`

Sends a dispatch alert to all online officers. The alert appears on the live map and in the dispatch list of the MDT.

```lua
exports['gfx-mdt']:AddDispatch(title, coords, texts, circleColor?)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `title` | `string` | Yes | Dispatch alert title |
| `coords` | `vector3` | Yes | World coordinates of the incident |
| `texts` | `table` | Yes | Array of info strings shown in the dispatch card |
| `circleColor` | `string` | No | Map marker color (`"red"`, `"white"`, `"orange"`). Defaults to random. |

**Example:**

```lua
-- Send a dispatch from any other resource (e.g. a robbery script)
exports['gfx-mdt']:AddDispatch(
    "Bank Robbery",
    GetEntityCoords(PlayerPedId()),
    { "Bank alarm triggered.", "Fleeca Bank on Forum Drive." },
    "red"
)
```

---

## Events

### Server Events

#### `gfx-mdt:triggerPanic`

Triggers a panic button alert. Broadcast to all online police officers.

```lua
TriggerServerEvent("gfx-mdt:triggerPanic", panicType, coords)
-- panicType: "safe" | "normal" | "emergency"
-- coords: vector3
```

---

#### `gfx-mdt:AddDispatch`

Broadcasts a dispatch alert to all authorized officers.

```lua
TriggerServerEvent("gfx-mdt:AddDispatch", dispatchData)
-- dispatchData = { id, name, position, texts, circleColor }
```

---

#### `gfx-mdt:RemoveDispatch`

Removes a dispatch entry from all clients.

```lua
TriggerServerEvent("gfx-mdt:RemoveDispatch", id)
```

---

#### `gfx-mdt:deleteFine`

Deletes a fine from the fine list.

```lua
TriggerServerEvent("gfx-mdt:deleteFine", id)
```

---

### Client Events

#### `gfx-mdt:client:openMDT`

Opens the MDT tablet on the receiving client (triggered by server after authorization check).

```lua
RegisterNetEvent("gfx-mdt:client:openMDT", function() end)
```

---

#### `gfx-mdt:client:triggerPanic`

Received on all police clients when a panic button is pressed. Creates a timed map blip.

```lua
RegisterNetEvent("gfx-mdt:client:triggerPanic", function(panicType, officerName, coords) end)
```

---

#### `gfx-mdt:client:AddDispatch`

Received on all police clients when a dispatch alert is broadcast.

```lua
RegisterNetEvent("gfx-mdt:client:AddDispatch", function(dispatch) end)
-- dispatch = { id, name, position, texts, circleColor }
```

---

#### `gfx-mdt:client:RemoveDispatch`

Received on all clients when a dispatch entry is removed.

```lua
RegisterNetEvent("gfx-mdt:client:RemoveDispatch", function(id) end)
```

---

#### `gfx-mdt:sendDispatch`

Net event alias for `AddDispatch` — other resources can trigger this directly on the client.

```lua
TriggerEvent("gfx-mdt:sendDispatch", title, coords, texts, circleColor?)
```

---

## Commands

| Command | Side | Description |
|---|---|---|
| `/mdt` | Client | Opens the MDT tablet (requires an authorized job; configurable via `Config.Open.command.name`). Enabled only when `Config.Open.command.enable` is `true`. |

---

## Features

### Access Methods

- Chat command (`/mdt` by default) — configurable name, can be disabled
- Usable inventory item (`tablet` by default) — works with ESX and QBCore item systems, can be disabled

### Tablet Prop and Animation

- A `prop_cs_tablet` prop is attached to the player's hand when the MDT is open
- A seated tablet-holding animation plays automatically (`amb@world_human_seat_wall_tablet@female@base`)
- Prop and animation are removed when the MDT is closed or the resource stops

### Homepage Dashboard

- Daily and total counts for records and wanteds
- Online officer count
- Hot wanted list (wanteds created within the last 3 days)
- On-duty officer list with avatar, rank, location, duty status, and appointment date

### Criminal Records

- Create, view, and delete incident records
- Attach crime tags (configurable severity labels) to records
- Add offenders and responding officers to each record with automated database lookups
- Attach photo evidence (name + image URL) to records
- Write and edit free-text report notes per record
- Permission-based restrictions on editing

### Wanted List

- Create wanted entries for players (by citizenid/identifier) or vehicles (by plate)
- Attach crime tags and photo evidence to wanted entries
- Edit report text per wanted entry
- Delete resolved wanted entries

### Offender Profiles

- Persistent profile created automatically when a player is added as an offender
- View and edit crime tags, evidence, fines, and report notes per offender
- Add/remove individual fines from the offender's profile

### Police Profiles

- Persistent profile created automatically when an officer is added to a record
- View crime tags (for internal use), evidence, and report notes per officer

### Fines Management

- Create, edit, and delete fine templates (name, jail time, jail time type, money amount)
- Apply one or more fine templates to offenders directly from their profile
- Permission-controlled — only configured grades can add or edit fines

### User Lookup

- Search all players (citizens) by name, ID, or phone number
- View player profile: avatar, crime tags, evidence, and license status
- Add or remove crime tags on any player's record
- Change a player's MDT avatar (uploads via screenshot-basic to Discord)

### Vehicle Lookup

- Search registered vehicles by plate, owner name, or citizen ID
- View vehicle info: make/model, plate, owner name, and vehicle image
- Update vehicle image directly from the MDT

### Department Page

- Display department name, logo, location, staff count, and ban count
- Edit department description in-MDT (persisted to database)
- Department ban list: ban and unban officers with reasons

### Live Map

- Real-time positions of all on-duty officers overlaid on a minimap
- Officer markers show avatar, name, and rank
- Active dispatches displayed as map pins with detail cards

### CCTV Cameras

- Access configured camera feeds from within the MDT
- Scripted camera with optional rotation (arrow keys) and scanline visual effect
- Press ESC / Back to exit the camera view

### Dispatch System

- Automatic gunshot dispatch: fires when a player shoots (15–30 s cooldown for regular, 25–30 s for silenced weapons)
- External dispatch API via export and net event for integration with other scripts
- Dispatches show title, info lines, and map marker; can be deleted by officers

### Messaging and Notifications

- In-MDT internal messaging between officers (permission-controlled)
- Notification log of all MDT actions (record added/deleted, fines added, wanteds created, etc.) persisted in the database

### Panic Button

- Three alert levels: Safe, Normal, Emergency
- Creates a timed map blip for all online officers with configurable color and scale
- Blip auto-removes after the configured duration

---

## Troubleshooting

| Problem | Solution |
|---|---|
| `/mdt` command does nothing | Ensure your player's job is listed in `Config.Jobs` with `ableToUse = true`. Check that `Config.Open.command.enable` is `true`. |
| "You are not authorized!" notification | Your player's job is not in `Config.Jobs` or `ableToUse` is `false` for that job. |
| Tablet item does not open MDT | Verify `Config.Open.item.enable` is `true` and the item name matches exactly what is registered in the framework shared items. |
| MDT opens but shows no data | Check server console for SQL errors. Ensure the correct `Config.Framework` and `Config.SQLScript` values are set. |
| Database error on startup | The resource creates tables automatically. If errors occur, verify that the database user has `CREATE TABLE` and `ALTER TABLE` privileges. |
| Photo capture does nothing | `screenshot-basic` must be running. Verify `Config.discordWebhook` is a valid, active Discord webhook URL. |
| Live map shows no officers | Officers must be on-duty (`PlayerData.job.onduty = true` on QBCore; all ESX police are shown). |
| CCTV camera view is black | Check that `coords` in `Config.Cameras` are correct world-space coordinates. Large distances from loaded areas may cause empty renders. |
| Panic button blip does not appear | Ensure the `panicType` string matches one of the keys in `Config.PanicTypes` (`"safe"`, `"normal"`, `"emergency"`). |
| Fines cannot be edited | Confirm the player's job grade name is listed in `Config.Permissions.editFines`. |
| "Searching police/user not found" in search | The search runs against the live database. Ensure `Config.UsersTable` and `Config.VehiclesTable` are correct for your framework. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-mdt
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
