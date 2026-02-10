# GFX Cuff System

A comprehensive handcuff and restraint system for FiveM featuring soft cuffs, hard cuffs, electronic cuffs with GPS tracking and remote shock, head bags, drag/escort mechanics, and vehicle placement for restrained players.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-cuffsystem` |
| **Frameworks** | QBCore (new/old), ESX |
| **Escrow** | Yes (client.lua, config.lua, oncuff.lua, server.lua are open) |

## Dependencies

- A supported framework: **QBCore** (new or old) or **ESX**
- Inventory items registered in your framework: `handcuffs`, `electroniccuff`, `headbag`
- `interactSound` resource (for cuff sound effect)

## Installation

### 1. Copy the resource
Place the `gfx-cuffsystem` folder into your server's resources directory.

### 2. Add to server.cfg
```cfg
ensure gfx-cuffsystem
```

### 3. Configure the framework
Open `config.lua` and set `Config.Framework` to match your server:
```lua
Config.Framework = "new-qb" -- Options: "esx", "new-qb", "old-qb"
```

### 4. Add inventory items
Make sure the following items exist in your framework's item list:
- `handcuffs` -- Used for soft cuff and hard cuff
- `electroniccuff` -- Used for electronic cuff with GPS tracking
- `headbag` -- Used to place a bag over a player's head

## Configuration

All configuration is in `config.lua`.

### Framework
```lua
Config.Framework = "new-qb" -- "esx", "new-qb", "old-qb"
```

### Police Job Names
Defines which jobs can access the electronic cuff management menu:
```lua
Config.PoliceJobNames = {
    ["police"],
    ["sheriff"]
}
```

### Command
The command name used to open the electronic cuff management panel:
```lua
Config.Command = "emenu"
```

### Update Time
How often (in seconds) the server updates electronic cuff data (GPS coordinates, elapsed time):
```lua
Config.UpdateTime = 1
```

### Minigame
Enable or disable a minigame for escaping cuffs. When enabled, you must integrate your own minigame export in `oncuff.lua`:
```lua
Config.Minigame = false
```

### Menu Dialogs
Customize the cuff type selection menu headers and descriptions:
```lua
Config.MenuDialogs = {
    title = "Cuff Type",
    items = {
        [1] = { header = "Soft Cuff / Uncuff", description = "...", callback = "..." },
        [2] = { header = "Hard Cuff / Uncuff", description = "...", callback = "..." },
        [3] = { header = "Drag / Undrag", description = "...", callback = "..." },
        [4] = { header = "Put / Out of Vehicle", description = "...", callback = "..." },
    }
}
```

### Animations
Customize the cuff/uncuff animations for each item type in `Config.Items`. Each type supports `player` and `target` animation dictionaries, animation names, and flags.

### Notifications
Customize notification text strings:
```lua
Config.Notifications = {
    ["cuffedabt"] = "Cuffed about ",
    ["shock"] = "Shock",
    ["uncuff"] = "Uncuff",
    ["gps"] = "GPS",
    ["electroniccuffs"] = "Electronic Cuffs"
}
```

## Exports

### `Handcuffed`
**Side:** Client

Returns whether the local player is currently handcuffed.

```lua
local isCuffed = exports['gfx-cuffsystem']:Handcuffed()
-- Returns: boolean (true if handcuffed, false/nil otherwise)
```

### `ToggleHandcuff`
**Side:** Client

Manually set the handcuff state for the local player.

```lua
exports['gfx-cuffsystem']:ToggleHandcuff(true)  -- Force handcuffed
exports['gfx-cuffsystem']:ToggleHandcuff(false) -- Force uncuffed
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `bool` | boolean | `true` to handcuff, `false` to uncuff |

## Events

### `gfx-cuffsystem:CuffPlayer`
**Side:** Client (incoming)

Triggers the cuff interaction flow for a specific item. When the item is `handcuffs`, it opens the cuff type selection menu. When `electroniccuff`, it applies the electronic cuff. When `headbag`, it toggles the head bag.

| Parameter | Type | Description |
|-----------|------|-------------|
| `playerid` | number | The server ID of the player using the item |
| `item` | string | Item name: `"handcuffs"`, `"electroniccuff"`, or `"headbag"` |
| `animations` | table/nil | Animation data from `Config.Items` for the item |

```lua
TriggerClientEvent("gfx-cuffsystem:CuffPlayer", targetSource, targetSource, "handcuffs", animations)
```

### `gfx-cuffsystem:CuffPlayerClient`
**Side:** Client (incoming)

Applies the handcuff to the target player (plays animation, attaches cuff prop, restricts controls).

| Parameter | Type | Description |
|-----------|------|-------------|
| `cuffer` | number | Server ID of the player performing the cuff |
| `dict` | string | Animation dictionary |
| `anim` | string | Animation name |
| `flag` | number | Animation flag |

### `gfx-cuffsystem:CuffPlayerClientVariable`
**Side:** Client (incoming, broadcast)

Syncs the cuff state of a player to all clients.

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | number | Server ID of the cuffed/uncuffed player |
| `bool` | boolean/nil | Cuff state. If nil, toggles the current state |

### `gfx-cuffsystem:ShockPlayerClient`
**Side:** Client (incoming)

Causes the target player to ragdoll repeatedly for 10 seconds (remote shock from electronic cuff).

*No parameters -- triggered on the target player's client.*

### `gfx-cuffsystem:DragUndragClient`
**Side:** Client (incoming)

Toggles drag/escort state on the target player, attaching or detaching them from the dragger.

| Parameter | Type | Description |
|-----------|------|-------------|
| `dragger` | number | Server ID of the player doing the dragging |

### `gfx-cuffsystem:PutOutOfVehicleClient`
**Side:** Client (incoming)

If the target player is in a vehicle, forces them out. If they are cuffed/dragged and near a vehicle, places them into the nearest available seat.

*No parameters -- triggered on the target player's client.*

### `gfx-cuffsystem:HeadBagClient`
**Side:** Client (incoming)

Toggles a head bag prop on the target player and activates a blackout screen via NUI.

| Parameter | Type | Description |
|-----------|------|-------------|
| `headbag` | boolean | `true` to apply head bag, `false` to remove |

### `gfx-cuffsystem:UpdateCuffData`
**Side:** Client (broadcast)

Sends the current electronic cuff data to all clients for the management UI.

| Parameter | Type | Description |
|-----------|------|-------------|
| `cuffeds` | table | Table of all active electronic cuffs with player info, coords, elapsed time |

### `gfx-cuffsystem:OpenMenu`
**Side:** Client (incoming)

Opens the electronic cuff management NUI panel for police officers.

| Parameter | Type | Description |
|-----------|------|-------------|
| `cuffeds` | table | Table of all active electronic cuffs |

## Commands

### `/emenu`
Opens the electronic cuff management panel (NUI). Only accessible to players with a job listed in `Config.PoliceJobNames`. The command name is configurable via `Config.Command`.

**Features of the panel:**
- View all electronically cuffed players
- See GPS coordinates and set waypoints
- See online/offline status
- See elapsed cuff time
- Remote shock a cuffed player
- Remote uncuff a cuffed player

### `/deleteobject`
Debug command that deletes the local player's attached electronic cuff prop. No permission restriction.

## Features

- **Soft Cuff / Uncuff** -- Restrains the nearest player with a soft cuff animation. Uses the `handcuffs` inventory item. Player can walk but most actions are disabled.
- **Hard Cuff / Uncuff** -- Restrains the nearest player with a hard cuff animation. Uses the `handcuffs` inventory item with a more forceful paired animation.
- **Electronic Cuff** -- Applies a trackable electronic cuff device (custom `gfx_electro` prop) to the nearest player. Uses the `electroniccuff` inventory item. Data persists to `data.json` across restarts.
- **Electronic Cuff Management Panel** -- NUI interface for police to monitor all electronically cuffed players in real time, including GPS tracking, elapsed time, remote shock, and remote uncuff.
- **Remote Shock** -- Police can shock an electronically cuffed player through the management panel, causing them to ragdoll for 10 seconds.
- **GPS Tracking** -- Police can set a waypoint to any electronically cuffed player's live location.
- **Head Bag** -- Places a sack prop over a player's head and blacks out their screen via NUI. Uses the `headbag` inventory item. Toggles on/off.
- **Drag / Escort** -- Attaches a cuffed player to the officer, allowing them to be dragged around.
- **Vehicle Placement** -- Places a cuffed/dragged player into the nearest vehicle's available seat, or forces them out if already in a vehicle.
- **Control Restrictions** -- While cuffed, players cannot attack, aim, jump, reload, use phone, access inventory, steer vehicles, or exit vehicles. Voice chat remains enabled.
- **Cuff Animation Loop** -- Cuffed players are kept in the arrest idle animation automatically.
- **Cuff Prop** -- A handcuff model (`p_cs_cuffs_02_s`) is attached to the player's wrists when cuffed.
- **Cuff Type Selection Menu** -- NUI-based menu with arrow key navigation when using handcuffs, allowing the officer to choose between soft cuff, hard cuff, drag, or vehicle placement.
- **Minigame Support** -- Optional minigame integration point in `oncuff.lua` for cuff escape mechanics.
- **Persistent Electronic Cuff Data** -- Electronic cuff records are saved to `data.json` and restored on resource start.
- **Multi-Framework** -- Works with QBCore (new and old export styles) and ESX.
- **Custom Stream Assets** -- Includes custom `gfx_electro` model for the electronic cuff device and `gfx_rope` model.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Items do not work when used | Make sure `handcuffs`, `electroniccuff`, and `headbag` are registered as useable items in your framework's shared items/item list. |
| Electronic menu does not open | Verify your job name is listed in `Config.PoliceJobNames` and the command matches `Config.Command`. |
| Cuff prop not visible | Ensure the `stream/` folder is included with the resource and contains `gfx_electro.ydr`, `gfx_electro.ytyp`, `gfx_rope.ydr`, `gfx_rope.ytyp`. |
| No cuff sound plays | The script triggers `interactSound` for the cuff sound. Make sure you have an `interactSound` resource installed with a `Cuff` sound file. |
| Framework not detected | Double-check `Config.Framework` is set to exactly `"esx"`, `"new-qb"`, or `"old-qb"`. |
| Electronic cuff data lost on restart | Verify the resource has write permissions to its own folder so `data.json` can be saved. |
| Player stuck in cuff animation after uncuff | Use the `ToggleHandcuff` export to force-reset the state: `exports['gfx-cuffsystem']:ToggleHandcuff(false)` |
| `/deleteobject` not removing prop | This only removes the electronic cuff prop. Regular handcuff props are removed automatically on uncuff. |

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-cuffsystem
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
