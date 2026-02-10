# GFX Crew
A full-featured crew/gang management system with an interactive NUI menu, allowing players to create, join, and manage crews with member tracking, kill/death statistics, leaderboards, role-based permissions, crew chat, announcements, and map blips.

## Info
| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-crew` |
| **Frameworks** | Standalone (uses `gfx-lib` for player photo only) |
| **Escrow** | No |

## Dependencies
| Resource | Purpose |
|----------|---------|
| `gfx-lib` | Retrieves player profile photos via `getModules().GetPlayerPhoto()` |
| `oxmysql` / `ghmattimysql` / `mysql-async` | Database driver (configurable in `sv_config.lua`) |

## Installation

### 1. Import the SQL file
Import `crew.sql` into your database. This creates two tables:
- `crews` -- stores crew data (name, members, stats, roles, announcements, chat)
- `crew_users` -- stores per-player previous crew history

### 2. Copy resource files
Place the `gfx-crew` folder into your server's resources directory.

### 3. Configure server.cfg
```cfg
ensure gfx-lib
ensure gfx-crew
```

### 4. Configure the script
Edit `cl_config.lua`, `sv_config.lua`, and `shared_config.lua` to match your server preferences (see Configuration section below).

## Configuration

### Client Config (`cl_config.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `FatalIndex` | `number` | `6` | Index in `CEventNetworkEntityDamage` args that indicates a fatal hit |
| `GamerTags` | `boolean` | `true` | Show GTA Online-style gamer tags (name + health bar) above crew members |
| `FriendlyFire` | `boolean` | `false` | When `false`, crew members cannot damage each other |
| `MemberBlips` | `boolean` | `true` | Show crew member locations on the minimap/map |
| `UseLeaderboard` | `boolean` | `true` | Enable the leaderboard feature in the UI |
| `ShowWeapons` | `boolean` | `true` | Show weapon info on member cards |
| `OpenMenu.command.enable` | `boolean` | `true` | Enable the command to open the crew menu |
| `OpenMenu.command.command` | `string` | `"crew"` | The command name to open the crew menu |

### Server Config (`sv_config.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `SQLScript` | `string` | `"oxmysql"` | Database driver to use. Options: `"oxmysql"`, `"ghmattimysql"`, `"mysql-async"` |
| `NoImage` | `string` | URL | Default image URL when no image is found |
| `LeaderboardRefreshTime` | `number` | `5` | How often (in minutes) the leaderboard data refreshes |
| `Badges` | `table` | See below | Achievement badges awarded based on kill count milestones |
| `AbleToCreate` | `boolean/table` | `false` | When `false`, anyone can create crews. Set to a table of player identifiers to restrict crew creation to specific players |

#### Badges Configuration
```lua
Badges = {
    {
        id = 1,
        image = 'badges/kill10.png',
        label = '10 Kills',
        killCount = 10
    },
    {
        id = 2,
        image = 'badges/kill100.png',
        label = '100 Kills',
        killCount = 100
    },
    -- ...
}
```

### Shared Config (`shared_config.lua`)

Defines weapon hash-to-label/image mappings used for displaying weapon info on member cards:

```lua
Shared = {
    Weapons = {
        [-1569615261] = {
            label = "Fist",
            image = "weapons/fist.webp",
        },
        [`weapon_assaultrifle`] = {
            label = "Pistol",
            image = "weapons/weapon_pistol.webp",
        },
    }
}
```

### Locale (`locale.lua`)

All UI text strings are defined in `locale.lua` and can be fully customized or translated.

## Exports

### Client Exports

#### `IsMenuVisible`
Returns whether the crew NUI menu is currently open.
```lua
local isOpen = exports['gfx-crew']:IsMenuVisible()
-- Returns: boolean
```

#### `GetPlayerCrewData`
Returns the local player's cached crew profile data (populated after opening the menu).
```lua
local data = exports['gfx-crew']:GetPlayerCrewData()
-- Returns: table { id, name, image, rank, rankId, permissions, crewId, stats }
```

### Server Exports

#### `GetPlayerCrewName`
Returns the crew name for a given player source.
```lua
local crewName = exports['gfx-crew']:GetPlayerCrewName(source)
-- @param source: number (player server ID)
-- Returns: string|nil (crew name or nil if not in a crew)
```

#### `GetPlayerCrewData`
Returns the full crew data table for a given player source.
```lua
local crewData = exports['gfx-crew']:GetPlayerCrewData(source)
-- @param source: number (player server ID)
-- Returns: table|nil { name, description, shortName, bannerImage, crewImage, maxMember, isPrivate, members, stats, roles, announcements, chat }
```

#### `GetPlayerCrewMembers`
Returns the members table of the crew the given player belongs to.
```lua
local members = exports['gfx-crew']:GetPlayerCrewMembers(source)
-- @param source: number (player server ID)
-- Returns: table|nil (array of member objects)
```

#### `GetPlayerCrewMembersForMarker`
Returns an array of server source IDs for all online members in the player's crew. Useful for marker/blip systems.
```lua
local sources = exports['gfx-crew']:GetPlayerCrewMembersForMarker(source)
-- @param source: number (player server ID)
-- Returns: table (array of server source IDs of online crew members)
```

#### `AddBadgeToMember`
Manually awards a badge to a player by badge ID.
```lua
exports['gfx-crew']:AddBadgeToMember(source, badgeId)
-- @param source: number (player server ID)
-- @param badgeId: number (badge ID from Config.Badges)
-- Returns: boolean|nil (true if successful)
```

## Events

There are no public API events intended for external script use. All events in this resource are internal (NUI callbacks, member sync, stat updates) and should not be relied upon by other scripts. Use the exports above for integration.

## Commands

| Command | Description | Permission |
|---------|-------------|------------|
| `/crew` | Opens the crew management NUI menu | All players (configurable in `cl_config.lua`) |

The command name is configurable via `Config.OpenMenu.command.command` and can be disabled by setting `Config.OpenMenu.command.enable` to `false`.

## Features

- **Crew Creation & Management** -- Create crews with a name, short name/tag, description, banner image, crew image, and configurable max member count
- **Public & Private Crews** -- Set crew visibility; public crews appear in a browse list, private crews require an invite
- **Role-Based Permissions** -- Customizable roles (Leader, Member, and custom ranks) with granular permissions: kick, invite, edit, delete, announce
- **Member Management** -- Invite players, kick members, set roles, view member profiles with stats
- **Kill/Death Tracking** -- Automatic PvP kill and death tracking for crew members with crew-wide stat aggregation
- **Achievement Badges** -- Configurable badge milestones awarded automatically when a member reaches kill count thresholds
- **Leaderboard** -- Server-wide leaderboard ranking both crews and individual members by kills and deaths
- **Crew Chat** -- In-game real-time text chat between crew members via the NUI interface
- **Announcements** -- Leaders can broadcast announcements to all crew members
- **Gamer Tags** -- GTA Online-style overhead name tags with color-coded health bars for nearby crew members
- **Friendly Fire Protection** -- Optional relationship group system that prevents crew members from damaging each other
- **Map Blips** -- Crew member positions displayed on the minimap with name labels
- **Previous Crew History** -- Tracks the last crew a player was in, visible on member profiles
- **OneSync Support** -- Enhanced member data (health, armor, weapon, coordinates) when OneSync is enabled
- **NUI Interface** -- Full React-based web UI for all crew management operations
- **Multi-Database Support** -- Works with oxmysql, ghmattimysql, or mysql-async
- **Fully Localizable** -- All UI strings defined in `locale.lua`

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Menu does not open | Verify `Config.OpenMenu.command.enable` is `true` in `cl_config.lua`. Check the F8 console for errors. |
| Database errors on startup | Ensure you have imported `crew.sql` and that your database driver matches `Config.SQLScript` in `sv_config.lua`. |
| Friendly fire still works between crew members | Set `Config.FriendlyFire` to `false` in `cl_config.lua`. Note this uses relationship groups and may conflict with other scripts that modify ped relationships. |
| Member blips not showing | Confirm `Config.MemberBlips` is `true` in `cl_config.lua`. Blips refresh every 5 seconds. |
| Gamer tags not appearing | Confirm `Config.GamerTags` is `true` in `cl_config.lua`. Tags only appear when the target player is within 100 units. |
| Player photos not loading | Ensure `gfx-lib` is started before `gfx-crew` and is functioning correctly. |
| "No permission" when creating a crew | If `Config.AbleToCreate` in `sv_config.lua` is set to a table, only listed player identifiers can create crews. Set it to `false` to allow everyone. |
| Leaderboard data is stale | The leaderboard refreshes on an interval set by `Config.LeaderboardRefreshTime` (default 5 minutes). Adjust this value for more frequent updates. |
