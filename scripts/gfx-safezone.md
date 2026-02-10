# gfx-safezone

| Key | Value |
|-----|-------|
| **Author** | GFX Development |
| **Version** | cerulean |
| **Game** | GTA5 |
| **Side** | Client & Server |
| **Framework** | Standalone (no framework required) |

---

## Dependencies

None. This script is fully standalone with no external dependencies.

---

## Installation

### 1. Copy Files
Place the `gfx-safezone` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-safezone
```

---

## Configuration

All configuration is done in `config.lua`.

### Security Settings

```lua
Config.Security = {
    enableAntiCheat = true,              -- Enable anti-cheat checks
    enableServerValidation = true,       -- Enable server-side zone validation
    enableRateLimiting = true,           -- Enable rate limiting on server events
    maxRequestsPerSecond = 10,           -- Max event requests per second per player
    validationTolerance = 5.0,           -- Distance tolerance for server validation (lag compensation)
    teleportDetectionDistance = 50.0,     -- Distance threshold for teleport detection
    weaponCheckInterval = 50,            -- Weapon check interval in ms
    damageCheckInterval = 100,           -- Damage check interval in ms
    zoneCheckInterval = 100,             -- Zone proximity check interval in ms
}
```

### Zone Definition

Each zone is defined with a unique key inside `Config.Zones`. You can add as many zones as needed.

```lua
Config.Zones = {
    ["zone_name"] = {
        coords = vector3(x, y, z),       -- Center coordinates of the zone
        radius = 70.0,                    -- Zone radius

        blipOptions = {
            active = true,                -- Show blip on map
            color = 2,                    -- Blip color (GTA blip color ID)
            scale = 1.0,                  -- Blip scale
            name = "Safezone Name"        -- Blip label on map
        },

        options = {
            mergePlayers = true,           -- Disable collision between players
            mergeVehicles = true,          -- Disable collision between vehicles
            mergePlayerAndVehicles = true,  -- Disable collision between players and vehicles
            disableDamagePlayer = true,    -- Make players invincible inside zone
            disableMelee = true,           -- Block melee attacks (fists, bats, knives, etc.)
            disableShooting = true,        -- Disable friendly fire (bullets deal no damage)
            disableWeapons = false,        -- If true, prevents weapon equipping entirely
            disableExplosions = true,      -- Block explosion damage
            disableVehicleDamage = true,   -- Make vehicles invincible inside zone
            forceHeal = true,              -- Continuously heal player to full HP
            forceRepairVehicles = true,    -- Continuously repair vehicles
        }
    }
}
```

### Locale Strings

```lua
Locales = {
    ["entered_zone"] = "~g~Entered Safezone.",
    ["left_zone"] = "~r~You left Safezone."
}
```

---

## Exports

### Client-side Exports

#### `GetClosestZone`
Returns the closest safezone to the player, regardless of whether the player is inside it.

```lua
local zoneName, distance = exports['gfx-safezone']:GetClosestZone()
-- zoneName: string   - Config key of the closest zone (e.g. "main_zone")
-- distance: number   - Distance in game units from the player to the zone center
```

#### `GetCurrentZone`
Returns the zone the player is currently in, or `false` if not in any zone.

```lua
local zone = exports['gfx-safezone']:GetCurrentZone()
-- zone: string|false  - Zone config key if in a safezone, false otherwise
```

#### `InSafeZone`
Returns whether the local player is currently inside any safezone.

```lua
local isInZone = exports['gfx-safezone']:InSafeZone()
-- isInZone: boolean
```

### Server-side Exports

#### `GetPlayersInZone`
Returns a table of all player server IDs currently in the specified zone.

```lua
local players = exports['gfx-safezone']:GetPlayersInZone("main_zone")
-- players: table  - Array of player server IDs, e.g. {1, 5, 12}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `zone` | string | The zone config key to query (e.g. `"main_zone"`) |

#### `GetPlayerZone`
Returns the zone name a specific player is currently in, or `nil` if not in any zone.

```lua
local zone = exports['gfx-safezone']:GetPlayerZone(playerId)
-- zone: string|nil  - Zone config key, or nil
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `player` | number | Player server ID |

#### `InSafeZone`
Returns whether a specific player is currently in any safezone.

```lua
local isInZone = exports['gfx-safezone']:InSafeZone(playerId)
-- isInZone: boolean
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `player` | number | Player server ID |

#### `IsPlayerInSafeZone`
Alias for `InSafeZone`. Returns whether a specific player is in any safezone.

```lua
local isInZone = exports['gfx-safezone']:IsPlayerInSafeZone(playerId)
-- isInZone: boolean
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `playerId` | number | Player server ID |

#### `BlockDamageEvents`
Checks whether damage events should be blocked for a player (returns `true` if the player is in a safezone).

```lua
local shouldBlock = exports['gfx-safezone']:BlockDamageEvents(playerId)
-- shouldBlock: boolean  - true if player is in a safezone, false otherwise
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `playerId` | number | Player server ID |

#### `BlockWeaponEvents`
Checks whether weapon damage events should be blocked for a player (returns `true` if the player is in a safezone).

```lua
local shouldBlock = exports['gfx-safezone']:BlockWeaponEvents(playerId)
-- shouldBlock: boolean  - true if player is in a safezone, false otherwise
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `playerId` | number | Player server ID |

---

## Events

*No public API events.* All events are internal between client and server.

---

## Commands

| Command | Access | Description |
|---------|--------|-------------|
| `/safezone_kick [id]` | Console only | Kicks a player from their current safezone by server ID |
| `/safezone_list` | Console only | Lists all players currently inside safezones with their names and zone names |

---

## Features

- **Radius-based safezones** -- Define unlimited circular zones with configurable center and radius
- **Map blips** -- Optional radius blips displayed on the map for each zone
- **Player invincibility** -- Players inside a safezone are made invincible with full entity proofs
- **Continuous healing** -- Player health is continuously restored to maximum inside zones
- **Vehicle protection** -- Vehicles inside safezones are made invincible and continuously repaired
- **Melee blocking** -- Melee weapon controls are disabled while holding melee weapons in a zone
- **Friendly fire control** -- Friendly fire is disabled so bullets deal no damage to other players
- **Explosion blocking** -- Server-side explosion events from safezone players are cancelled
- **Entity collision merging** -- Players, vehicles, and player-vehicle collisions can be toggled off per zone
- **Server-side validation** -- Player zone positions are validated server-side with distance tolerance
- **Rate limiting** -- Server events are rate-limited per player to prevent spam/abuse
- **Anti-cheat integration** -- Distance mismatch detection with automatic safezone force-exit
- **Per-zone options** -- Each zone has its own independent configuration for all protection features
- **Notification system** -- GTA native notifications on zone enter/exit with configurable locale strings

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Players still take damage inside safezone | Ensure `disableDamagePlayer` is set to `true` in the zone options. Check server console for validation failure messages. |
| Blip not showing on map | Verify `blipOptions.active` is `true` for the zone. Check that `coords` are correct. |
| Players can still melee attack | Ensure `disableMelee` is `true`. Note that melee is only blocked when the player has a melee weapon equipped. |
| Players get kicked from safezone randomly | The server-side validation may be too strict. Increase `Config.Security.validationTolerance` (default 5.0). |
| Rate limit exceeded messages in console | A player is sending too many events. Increase `Config.Security.maxRequestsPerSecond` if legitimate, or investigate the player for exploiting. |
| Vehicles still take damage | Ensure `disableVehicleDamage` is `true` and `forceRepairVehicles` is `true` in zone options. |
| Players can still shoot and deal damage | `disableShooting` disables friendly fire so bullets go through players. Weapons are not removed unless `disableWeapons` is `true`. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-safezone
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
