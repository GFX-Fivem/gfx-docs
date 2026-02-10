# GFX Arena

Team-based PvP arena system where players create or join lobbies, bet money, and compete in round-based team deathmatch across multiple maps with full profile tracking, leaderboards, and match history.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-arena` |
| **Frameworks** | QBCore, QBCore (legacy), ESX, ESX (legacy) |
| **Escrow** | Yes |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `oxmysql` / `ghmattimysql` / `mysql-async` | Yes | One SQL wrapper required. Configured via `Config.SQLScript` |
| `gfx-gunmenu` | Yes | Used for weapon selection at round start |
| Steam Web API Key | Recommended | Set via `steam_webApiKey` convar. Used for player profile pictures |

## Installation

1. Copy the `gfx-arena` folder into your server's resources directory.
2. Import `arena.sql` into your database. This creates two tables:
   - `gfxarena_profile` -- Stores player stats (kills, deaths, wins, losses)
   - `gfxarena_history` -- Stores match history per player
3. Add the resource to your `server.cfg`:
   ```cfg
   ensure gfx-arena
   ```
4. Configure `config.lua` to match your framework and SQL wrapper (see Configuration below).
5. (Recommended) Set your Steam Web API key as a convar in `server.cfg`:
   ```cfg
   set steam_webApiKey "YOUR_STEAM_API_KEY_HERE"
   ```

## Configuration

### config.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `FatalIndex` | `number` | `6` | Index for fatal damage detection in the `CEventNetworkEntityDamage` event data |
| `WeaponChooseTime` | `number` | `7` | Time in seconds players have to choose a weapon at round start (via `gfx-gunmenu`) |
| `FinishCoords` | `vector3` | `vector3(-1008.29, -2978.87, 13.945)` | Coordinates where players are teleported after a match ends |
| `Framework` | `string` | `"newqb"` | Framework to use. Options: `"esx"`, `"newesx"`, `"qb"`, `"newqb"` |
| `SQLScript` | `string` | `"oxmysql"` | SQL wrapper to use. Options: `"oxmysql"`, `"ghmattimysql"`, `"mysql-async"` |
| `SteamAPIKey` | `string` | `GetConvar(...)` | Steam Web API key for fetching player profile pictures |
| `NoImage` | `string` | Discord CDN URL | Fallback image URL when a player's Steam profile picture cannot be retrieved |
| `Open.command.enabled` | `boolean` | `true` | Whether the `/arena` command is enabled |
| `Open.command.name` | `string` | `"arena"` | Command name to open the arena menu |
| `Open.npc.enabled` | `boolean` | `true` | Whether to spawn an NPC that opens the arena menu on interaction |
| `Open.npc.model` | `string` | `"s_m_m_doctor_01"` | Ped model for the arena NPC |
| `Open.npc.text` | `string` | `"[E] - Arena"` | 3D text displayed above the NPC |
| `Open.npc.coords` | `table` | See config | Array of `vector3` positions where NPCs are spawned |
| `Open.npc.heading` | `number` | `340.0` | Heading direction of the NPC |
| `Maps` | `table` | 4 maps | Array of map definitions (see Maps section below) |

### Map Configuration

Each entry in `Config.Maps` has the following structure:

| Option | Type | Description |
|--------|------|-------------|
| `name` | `string` | Display name of the map |
| `image` | `string` | Image path shown in the UI (relative to `nui/`) |
| `coords[1]` | `table` | Array of `vector4` spawn positions for Team 1 |
| `coords[2]` | `table` | Array of `vector4` spawn positions for Team 2 |
| `endMatchScreen.enabled` | `boolean` | Whether to show a cinematic end-match camera |
| `endMatchScreen.pedCoords` | `table` | Array of `vector4` positions where winning players are placed during the end screen |
| `endMatchScreen.camSettings.pos` | `vector3` | Camera position for the end screen |
| `endMatchScreen.camSettings.rot` | `vector3` | Camera rotation for the end screen |
| `endMatchScreen.camSettings.fov` | `number` | Camera field of view for the end screen |

### locale.lua

All user-facing notification strings are defined in `locale.lua` and can be freely edited for localization.

## Exports

### Client Exports

#### `IsPlayerInMatch`

Returns whether the local player is currently in an active arena match.

| Parameter | Type | Description |
|-----------|------|-------------|
| *(none)* | - | - |

**Returns:** `boolean` -- `true` if the player is currently in a match, `false` otherwise.

```lua
local inMatch = exports['gfx-arena']:IsPlayerInMatch()
if inMatch then
    print("Player is in an arena match")
end
```

## Events

*No public API events.* All events in this script are internal (used between the client and server of the resource itself) and are not intended for external use.

## Commands

| Command | Permission | Description |
|---------|------------|-------------|
| `/arena` | Everyone | Opens the arena menu UI. Can be disabled or renamed in config (`Config.Open.command.name`) |

## Features

- Team-based PvP arena with 2 teams per match
- Lobby system: create, join, leave, and configure lobbies
- Configurable bet system using in-game cash (winners receive 2x the bet)
- Round-based matches with configurable round count
- Multiple maps with per-team spawn points (4 maps included by default)
- Weapon selection phase at the start of each round via `gfx-gunmenu`
- Friendly fire protection using relationship groups (teammates cannot damage each other)
- Player profile tracking: kills, deaths, wins, losses, K/D ratio, and win rate
- Rank system based on win rate: Noob, Beginner, Rookie, Pro, Master
- Leaderboard sorted by kills and win/loss ratio (top 5)
- Match history per player (last 4 matches stored)
- Steam profile picture integration for player avatars
- Spectator mode: eliminated players can spectate remaining teammates (left/right arrow to switch)
- Cinematic end-match camera showing winning team
- NPC interaction point to open the arena menu (configurable model and location)
- Automatic lobby cleanup when players disconnect mid-match
- Routing bucket isolation: active matches are placed in separate routing buckets to prevent interference
- Full NUI-based user interface

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Profile pictures not loading | Ensure your Steam Web API key is set via the `steam_webApiKey` convar in `server.cfg` |
| SQL errors on startup | Verify you imported `arena.sql` and that your `Config.SQLScript` matches the SQL wrapper you have installed |
| Players not taking damage in match | Check that the `FatalIndex` config value is correct for your server build (default is `6`) |
| Arena command not working | Verify `Config.Open.command.enabled` is `true` and check the command name in `Config.Open.command.name` |
| NPC not appearing | Ensure `Config.Open.npc.enabled` is `true` and the ped model string is valid |
| "You don't have enough money" error | Players need enough cash (not bank) to cover the lobby bet amount |
| Players stuck after match | The `Config.FinishCoords` may be underground or inaccessible. Adjust to a valid coordinate on your server |
| Weapon menu not opening | Ensure `gfx-gunmenu` is started before `gfx-arena` in your `server.cfg` |
