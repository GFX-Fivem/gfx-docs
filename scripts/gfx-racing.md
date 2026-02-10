# GFX Racing

A comprehensive street racing system with a full NUI interface for creating, managing, and participating in races. Features include route creation with map-based waypoints, real-time leaderboards, player name tags during races, checkpoint markers, a countdown system, distance tracking, and a persistent global leaderboard with win/loss statistics.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-racing` |
| **Version** | `1.0.0` |
| **Author** | HSN |
| **Frameworks** | QBCore (new/old), ESX |
| **Escrow** | Yes |

## Dependencies

| Dependency | Required | Notes |
|------------|----------|-------|
| `gfx-lib` | Yes | Framework detection and player photo module |
| `oxmysql` | Yes (default) | Database driver; also supports `ghmattimysql` and `mysql-async` |
| QBCore (`qb-core`) or ESX (`es_extended`) | Yes | One framework required |
| FiveM Asset Packs (`/assetpacks`) | Yes | Required by fxmanifest |

## Installation

1. Download and extract the resource to your server's `resources` folder.
2. Import the required SQL tables into your database:
   - `races` -- stores race definitions (name, reward, route, players, schedule)
   - `gfx_racing` -- stores player racing statistics (wins, losses, distance, routes, history)
3. Add `ensure gfx-racing` to your `server.cfg` (after `gfx-lib`, `oxmysql`, and your framework).
4. Configure `config.lua` with your framework and preferences.
5. Optionally configure `server/server-config.lua` with your Discord bot token if using Discord avatars.

## Configuration

### Main Config (`config.lua`)

```lua
Config = {}

-- Database driver: "oxmysql", "ghmattimysql", or "mysql-async"
Config.Database = "oxmysql"

-- Framework: "new-qb", "old-qb", or "esx"
Config.Framework = "new-qb"

-- Server name displayed in the racing UI
Config.ServerName = "GFX"

-- Player photo source: "steam" or "discord"
Config.ImageType = "steam"

-- Minimum wait time (minutes) between race participation
Config.PlayerWaitTime = 1

-- Minimum number of players required to start a race
Config.MinPlayersForStart = 2

-- Enable/disable vehicle collision between racers
-- When true, racers cannot collide with each other (ghosting)
Config.VehicleCollision = true

-- Show player name tags above other racers during a race
Config.ShowPlayerNamesInRace = true

-- Blip configuration (empty by default, customizable)
Config.BlipConfig = {}

-- Maximum number of route waypoints allowed per race
Config.MaximumRouteCount = 200

-- Minimum number of waypoints required to create a route
Config.MinimumRouteCountForAddRoute = 5

-- 3D Marker settings for race checkpoints
Config.MarkerSettings = {
    ["finishStartMarker"] = {
        ["type"] = 4,                           -- Marker type (4 = upside-down cone)
        ["size"] = vector3(10.0, 10.0, 5.0),    -- Marker dimensions
        ["color"] = vector4(255, 255, 255, 200), -- RGBA color
        ["bobUpAndDown"] = true,                 -- Floating animation
        ["faceCamera"] = true,                   -- Always face the player
    },
    ["routeMarker"] = {
        ["type"] = 2,                           -- Marker type (2 = cylinder)
        ["size"] = vector3(5.0, 5.0, 3.0),
        ["color"] = vector4(255, 0, 0, 200),    -- Red
        ["bobUpAndDown"] = true,
        ["faceCamera"] = true,
    },
}

-- UI text strings and command/key configuration
Config.Texts = {
    ["inracealready"] = "You're already in a race!",
    ["maxplayers"] = "Max Players",
    ["creatednewrace"] = "Your race has been created!",
    ["notatlocation"] = "You are not in the race location and kicked!",
    ["racestartin"] = "Your race startin' within 30 seconds please get in the car and get ready!",
    ["racedeactivated"] = "Your race has been deactivated!",
    ["finishrace"] = "You finished the race ",
    ["needmoreroute"] = "You need to add some more routes!",
    ["maxroute"] = "Max Route!",
    ["nomoney"] = "You don't have enough money!",
    ["startinrace"] = "Race startin' within ",
    ["createrace"] = "A new race released click to join",

    -- Command and keybind to open the racing UI
    ["openui"] = {
        key = "g",              -- Keybind key
        text = "Open Racing UI",-- Keybind description
        command = "OpenRace",   -- Command name
        item = "burger"         -- Item that opens the UI (set to false to disable)
    },
}
```

### Server Config (`server/server-config.lua`)

```lua
SERVERCONFIG = {
    -- Discord bot token for fetching player avatars
    -- Only needed if Config.ImageType is "discord"
    DISCORDTOKEN = ""
}
```

The server config also registers a useable item. If `Config.Texts["openui"].item` is set to an item name (e.g., `"burger"`), using that item from inventory will open the racing UI. Set it to `false` to disable item-based opening.

## Exports

This script does not register any exports.

## Events

This script does not expose public API events intended for external use. All events listed below are internal to the resource's client-server communication.

### Client Events (Internal)

| Event | Parameters | Description |
|-------|-----------|-------------|
| `applytest` | `data, activeraces, LeaderBoard, incomingrace, favouritecar, bankmoney` | Opens the racing NUI with full player/race data |
| `gfx-racing:updatenui` | `data, activeraces, LeaderBoard, incomingrace, favouritecar, bankmoney` | Updates the NUI with refreshed data without reopening |
| `gfx-racing:StartRace` | `racedata, userlist, estcoord` | Initiates the race sequence (30s prep, 10s countdown, start) |
| `gfx-racing:Client:FinishRace` | `rank` | Notifies the client that the race is finished |
| `gfx-racing:SetRaceLeaderBoard` | `leaderboard` | Updates the in-race leaderboard overlay |
| `gfx-racing:NewRaceNotf` | `text` | Shows a NUI notification that a new race is available |
| `gfx-racing:notify` | `text, time` | Displays an in-UI notification (default 4000ms) |
| `gfx-racing:SetMarker` | `coordtable` | Sets a GPS waypoint to coordinates `{x, y}` |
| `gfx-racing:UpdateRacers` | `id` | Removes a player from the active racers list by server ID |
| `gfx-racing:RemoveRacing` | `id` | Removes a race entry from the NUI |
| `gfx-racing-client:RefreshActiveRaces` | `activeraces` | Refreshes the active races list in the NUI |
| `gfx-racing-client:CreateRace` | `data, route, id, text` | Adds a new race to the NUI active list with announcement |

### Server Events (Internal)

| Event | Parameters | Description |
|-------|-----------|-------------|
| `gfx-racing-ServerOpenNUI` | _(none)_ | Opens the racing UI for the requesting player |
| `gfx-racing-server:AddRoute` | `routeData, Streets` | Saves a new race route to the player's profile |
| `gfx-racing-server:CreateRace` | `data` | Creates a new race (checks funds, deducts reward, announces) |
| `gfx-racing-server:JoinRace` | `id` | Adds the player to a race lobby |
| `gfx-racing-server:leaverace` | `from` | Removes the player from a race |
| `gfx-racing-FinishRace` | `racedata` | Processes race completion (ranking, rewards, stats update) |
| `gfx-racing-SetRaceLeaderBoard` | `id, checkstatus, km, distancenewwaypoint` | Updates the server-side leaderboard for a race |
| `gfx-racing:Server:DeleteRoute` | `id` | Deletes a saved race route from the player's profile |
| `gfx-racing:ClearRaceData` | `id` | Removes an active race entirely |
| `gfx-racing:SetFavCar` | `vehlabel` | Records the player's vehicle model for favourite car stats |
| `gfx-racing:setInterval` | `timediff` | Updates race timing interval data |

## Commands

| Command | Description | Keybind | Access |
|---------|-------------|---------|--------|
| `OpenRace` | Opens the racing UI | `G` (default) | All players |

Both the command name and keybind key are configurable via `Config.Texts["openui"]`. The command is registered with `RegisterKeyMapping`, so players can rebind it in GTA V's key settings.

If `Config.Texts["openui"].item` is set, using that inventory item also opens the racing UI.

## Features

- Full NUI-based racing interface with map view for route creation
- Create custom race routes by placing waypoints on the map (5-200 checkpoints)
- Schedule races with a specific date/time; automatic start when the time arrives
- Real-time in-race leaderboard updating every 3 seconds
- 10-second countdown with vehicle freeze before race start
- Sequential checkpoint system with numbered blips and 3D markers
- Player must be within 100 meters of the start point when the race begins
- Vehicle collision ghosting between racers (configurable)
- Player name tags rendered above other racers during the race
- Distance tracking (miles traveled) per race and cumulative
- Global persistent leaderboard with wins, losses, distance, character name, and profile photo
- Favourite car tracking based on most-used vehicle in races
- Race history per player stored in the database
- Race reward system using bank money (winner takes the prize)
- Race creator pays the reward amount upfront from their bank
- Automatic race cleanup on player disconnect or resource stop
- Player data auto-saved on disconnect and resource stop
- Support for Steam and Discord profile photos
- Multi-framework support (QBCore new/old, ESX)
- Multi-database support (oxmysql, ghmattimysql, mysql-async)
- Useable item support to open the UI from inventory
- All notification text strings are configurable

## How It Works

### Race Creation
1. Open the racing UI with `/OpenRace` or the configured key (default `G`).
2. Use the map interface to place waypoints for the race route (minimum 5, maximum 200).
3. Save the route with a name. Routes are stored per-player in the database.
4. Set race parameters (name, reward amount, max players, scheduled time) and create the race.
5. The reward amount is deducted from the creator's bank account.
6. The race is saved to the database and announced to all connected players.

### Joining a Race
1. Open the racing UI to see active/upcoming races.
2. Click to join a race lobby.
3. Players receive waypoint markers and notifications as the race time approaches (5, 4, 3, 2, 1 minute warnings).
4. Players must be within 100 meters of the first checkpoint when the race starts, or they are automatically kicked.

### Race Flow
1. **Pre-Race** -- Players gather at the start location. A 30-second preparation period begins.
2. **Countdown** -- A 10-second visual countdown freezes all vehicles in place.
3. **Racing** -- Vehicles are unfrozen. Checkpoint blips appear one at a time, guiding racers through the route.
4. **Checkpoints** -- Players must pass through each checkpoint in order (40-unit radius detection zone). Passing a checkpoint reveals the next one and removes the previous blip.
5. **Finish** -- Reaching the final checkpoint ends the race for that player. Rankings are calculated based on checkpoint progress and distance to the next checkpoint.
6. **Rewards** -- The first-place finisher receives the bank money reward. Win/loss stats are recorded to the database for all participants.

### Database Tables

**`races`** -- Active race definitions:
- `id`, `owner`, `name`, `reward`, `date`, `maxplayers`, `route` (JSON), `players` (JSON), `luadate`

**`gfx_racing`** -- Player statistics:
- `identifier`, `charname`, `playerphoto`, `win`, `lose`, `distance`, `routes` (JSON), `racehistory` (JSON), `favouritecar` (JSON), `incomingrace`, `lastrace`

## Troubleshooting

**Q: The racing UI does not open.**
A: Ensure `gfx-lib` is started before `gfx-racing` in your `server.cfg`. Verify the command name matches `Config.Texts["openui"].command`. If using an item, make sure the item exists in your framework's item list.

**Q: Database errors on startup.**
A: Import the required SQL tables (`races`, `gfx_racing`) into your database. Ensure `oxmysql` (or your chosen database driver) is started before this resource.

**Q: "You are not in the race location and kicked!" when the race starts.**
A: Players must be within 100 meters of the first route waypoint when the race begins. Use the waypoint/GPS marker that appears before the race to navigate to the start location.

**Q: Race does not start.**
A: Races start automatically when the scheduled time arrives. Ensure the scheduled time has passed and that enough players have joined (minimum `Config.MinPlayersForStart`, default 2).

**Q: Route creation says "You need to add some more routes!"**
A: At least 5 checkpoints are required by default. This is configurable via `Config.MinimumRouteCountForAddRoute`.

**Q: Player photos show a default image.**
A: Check `Config.ImageType`. For `"steam"`, players need Steam identifiers connected to their FiveM. For `"discord"`, set `SERVERCONFIG.DISCORDTOKEN` in `server/server-config.lua` with a valid Discord bot token.

**Q: Money rewards are not given to the winner.**
A: Verify that the framework is correctly configured in `Config.Framework`. The script uses bank account operations. Check the server console for errors related to money functions.

**Q: Vehicle collision ghosting does not work.**
A: Ensure `Config.VehicleCollision = true` in your config. The script uses `SetEntityNoCollisionEntity` which requires both vehicles to exist on the client side. High player counts or streaming distance may affect this.

**Q: Player data is not saving.**
A: Data is saved on player disconnect and resource stop. Ensure `oxmysql` is running and the `gfx_racing` table exists with the correct columns. Check the server console for SQL errors.
