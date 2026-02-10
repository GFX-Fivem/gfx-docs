# gfx-squad

A FiveM squad/party system that allows players to create, join, and manage squads with up to 4 members. Includes member blips on the map, GamerTag name displays, world markers, friendly fire protection, and a HUD showing squad member health/armor status.

---

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-squad` |
| **FX Version** | `cerulean` |
| **Game** | `gta5` |
| **Lua 5.4** | Yes |
| **NUI** | Yes (`nui/index.html`) |
| **Escrow Ignore** | `config.lua`, `client/hook.lua`, `server/hook.lua` |

---

## Dependencies

None. This script is standalone and does not require any framework (QBCore, ESX, etc.).

---

## Installation

### 1. Copy the resource folder
Place `gfx-squad` into your server's resources directory.

### 2. Add to server.cfg
```cfg
ensure gfx-squad
```

### 3. Configure
Edit `config.lua` to customize squad behavior (see Configuration section below).

---

## Configuration

All configuration is in `config.lua`:

```lua
Config = {
    MenuCommand = "squad",      -- Command name to open the squad menu
    FriendlyFire = false,       -- false = squad members cannot damage each other
    MemberBlips = true,         -- Show blips for squad members on the minimap
    GamerTags = true,           -- Show GamerTag names above squad members' heads
    MarkerTimer = 3,            -- Marker display duration (seconds)
    NoImage = "https://...",    -- Fallback avatar URL when Steam profile picture is unavailable
    MarkerType = 1              -- Marker type ID
}
```

### Locales

Notification messages can be customized in the `Locales` table inside `config.lua`:

| Key | Default | Description |
|-----|---------|-------------|
| `squad_full` | "You can't join this squad! The squad has reached the maximum member amount!" | Shown when trying to join a full squad |
| `leader_cant_leave` | "You are leader you can not leave!" | Shown when the squad leader tries to leave instead of deleting |
| `squad_deleted` | "Your squad has deleted by owner!" | Shown to members when the leader deletes the squad |

---

## Exports

All exports are **server-side**.

### GetSquadId

Returns the squad ID for a given player.

```lua
-- Server-side
local squadId = exports['gfx-squad']:GetSquadId(source)
-- @param source number - The player's server ID
-- @return number|nil - The squad ID, or nil if the player is not in a squad
```

### GetSquad

Returns the full squad data for a given squad ID.

```lua
-- Server-side
local squad = exports['gfx-squad']:GetSquad(squadId)
-- @param squadId number - The squad ID
-- @return table|nil - Squad data table containing: owner (identifier), private (bool), members (table)
```

**Returned squad structure:**
```lua
{
    owner = "steam:xxxxx",   -- Identifier of the squad leader
    private = false,         -- Whether the squad is private (not joinable)
    members = {
        [1] = {
            name = "PlayerName",
            image = "https://...",  -- Steam profile picture URL
            source = 1              -- Player server ID
        },
        -- ...
    }
}
```

### GetSquadMembers

Returns a list of server IDs of all members in the player's squad.

```lua
-- Server-side
local members = exports['gfx-squad']:GetSquadMembers(source)
-- @param source number - The player's server ID
-- @return table|nil - Array of server IDs of squad members, or nil if player has no squad
```

**Example:**
```lua
local members = exports['gfx-squad']:GetSquadMembers(source)
if members then
    for _, memberId in ipairs(members) do
        print("Squad member server ID:", memberId)
    end
end
```

---

## Events

This script does not expose any public API events intended for external use. All events are internal to the resource's client-server communication.

---

## Commands

| Command | Key Bind | Description |
|---------|----------|-------------|
| `/squad` | `J` | Opens the squad menu UI (create, join, manage squads) |
| `/marker` | `H` | Places a world marker at the location you are looking at (visible to squad members only) |

Both commands have default key bindings that players can rebind through FiveM's key binding settings.

---

## Features

- **Squad Creation** -- Create a squad that other players can find and join (up to 4 members).
- **Public/Private Toggle** -- Squad leaders can toggle the squad between public (joinable) and private (invite only).
- **Member Management** -- Squad leaders can kick members. Members can leave at any time.
- **Member Blips** -- Squad members appear on each other's minimap with directional blips showing heading.
- **GamerTags** -- Floating name tags with health bars displayed above squad members' heads, color-coded by health level (green > 66%, yellow > 33%, red below).
- **World Markers** -- Squad members can place temporary markers in the world (via raycast) visible to all squad members, showing distance and the marker owner's name.
- **Friendly Fire Protection** -- When enabled, squad members cannot damage each other (uses relationship groups).
- **HUD** -- NUI-based HUD displaying squad members' names, health, and armor in real time.
- **Steam Avatars** -- Automatically fetches Steam profile pictures for squad member display.
- **Auto Cleanup** -- When a player disconnects, they are automatically removed from their squad. If the leader disconnects, the squad is deleted.

---

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Squad menu does not open | Command may be conflicting | Check if `/squad` command or `J` key is bound to another resource |
| Member blips not showing | `MemberBlips` is disabled | Set `Config.MemberBlips = true` in `config.lua` |
| GamerTags not appearing | `GamerTags` is disabled | Set `Config.GamerTags = true` in `config.lua` |
| Players can still damage squad members | `FriendlyFire` is set to true | Set `Config.FriendlyFire = false` in `config.lua` to enable damage protection |
| Steam profile pictures not loading | Player does not have a Steam identifier | The script falls back to the `Config.NoImage` URL |
| Markers not working | Player not in a squad | Markers are only shared with squad members; player must join or create a squad first |
| Max squad size too small | Hardcoded to 4 members | The member limit (4) is set in `server/main.lua` inside `JoinSquad()` |
