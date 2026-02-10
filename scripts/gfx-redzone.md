# GFX Redzone

Dynamic PvP redzone system that creates rotating combat zones on the map. Players inside zones are tracked with kill/death stats, a leaderboard UI, kill leader blips, and configurable rewards for both per-kill and end-of-round leaders.

---

## Info

| Key | Value |
|-----|-------|
| Resource Name | `gfx-redzone` |
| Framework | Auto-detected via `gfx-lib` (ESX / QBCore / Qbox) |
| Side | Client & Server |
| Escrow | Yes (client.lua, server.lua are protected) |
| UI | NUI-based leaderboard overlay |
| Streaming | `gfx_logo.ytd`, `dz_logo.ytd` |

---

## Dependencies

| Dependency | Required | Purpose |
|------------|----------|---------|
| `gfx-lib` | Yes | Framework detection, player identifiers, AddItem, AddMoney |
| `gfx-inventory` | No | If running, items are given through gfx-inventory instead of the framework default |
| `gfx-points` | No | If `gfx_points` is enabled in reward config, points are given via gfx-points |

---

## Installation

### 1. Copy the resource
Place `gfx-redzone` into your server's resources directory.

### 2. Add to server.cfg
```cfg
ensure gfx-lib
ensure gfx-redzone
```

Make sure `gfx-lib` starts **before** `gfx-redzone`.

---

## Configuration

All configuration is in `config.lua` (not escrowed).

### Zone Rotation

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `ChangeZonesInterval` | number | `60` | Minutes between zone relocations |
| `ZoneCount` | number | `2` | Number of zones active simultaneously |

### Zone Locations

```lua
ZoneLocations = {
    { coords = vector3(410.72, -982.00, 29.26), radius = 160.0 },
    { coords = vector3(-62.00, -1103.99, 26.32), radius = 130.0 },
    { coords = vector3(1336.32, -1615.03, 52.50), radius = 220.0 },
}
```

Each entry defines a possible zone center and its radius. When zones rotate, `ZoneCount` random locations are picked from this list.

### Reward on Zone Finish (leader reward when zones rotate)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `RewardOnFinish.gfx_points` | boolean | `false` | `true` to give gfx-points instead of money |
| `RewardOnFinish.giveAllItems` | boolean | `true` | `true` gives all items in the list, `false` gives one random item |
| `RewardOnFinish.money` | number | `1000` | Money/points amount (0 to disable) |
| `RewardOnFinish.items` | table | see below | Item rewards for the zone leader |

### Reward on Kill

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `RewardOnKill.gfx_points` | boolean | `true` | `true` to give gfx-points instead of money |
| `RewardOnKill.giveAllItems` | boolean | `true` | `true` gives all items, `false` gives one random item |
| `RewardOnKill.money` | number | `1000` | Money/points per kill (0 to disable) |
| `RewardOnKill.items` | table | see below | Item rewards per kill |

### Item Reward Format

```lua
items = {
    { name = "deluxo", count = 1, label = "Deluxo" },
}
```

### Locales

```lua
Locales = {
    ["zones_changed"] = "Redzone locations has changed",
    ["got_reward"]    = "You got %sx %s for being the leader of a redzone!",
    ["points"]        = "Points",
    ["money"]         = "Money",
}
```

### Notification Function

The `Notify(target, message)` function in `config.lua` can be customized. By default it uses `chat:addMessage`. The server-side `server_shared.lua` uses framework-native notifications (ESX/QBCore).

---

## Exports

### Client

#### `IsPlayerInRedZone`

Returns whether the local player is currently inside any active redzone.

```lua
local inZone = exports['gfx-redzone']:IsPlayerInRedZone()
-- Returns: boolean
```

### Server

#### `IsPlayerInRedZone`

Returns whether the given player is currently inside any active redzone.

```lua
local inZone = exports['gfx-redzone']:IsPlayerInRedZone(source)
-- Parameters:
--   source (number) - Server ID of the player
-- Returns: boolean
```

---

## Events

This script does not expose public API events intended for external use. All events are internal for client-server synchronization.

---

## Commands

| Command | Permission | Description |
|---------|------------|-------------|
| `/redzone` | ACE restricted | Re-syncs zone data and blips for the player who runs it. Useful if the UI or blips desync. |

---

## Features

- **Rotating PvP Zones** -- Multiple zones activate simultaneously, cycling to new random locations on a configurable timer.
- **Live Leaderboard UI** -- NUI overlay showing player kills, deaths, rankings, and the current kill leader while inside a zone.
- **Kill Leader Blip** -- A map blip tracks the current kill leader's position in each zone, with detailed info panel (leader name, kills, total zone kills) using custom blip info display.
- **Per-Kill Rewards** -- Configurable money, gfx-points, and/or items awarded on each kill inside a zone.
- **Zone Leader Rewards** -- The kill leader of each zone receives rewards when zones rotate.
- **Zone Radius Blips** -- Red radius blips on the map show active zone boundaries.
- **Auto Player Tracking** -- Players entering/exiting zones are automatically tracked with kill/death statistics.
- **Death Detection via gfx-lib** -- Uses the `gfx-lib:server:onDeath` event for reliable kill attribution.
- **Framework Agnostic** -- Works with ESX, QBCore, and Qbox through gfx-lib auto-detection.
- **Custom Streaming Assets** -- Includes `gfx_logo.ytd` and `dz_logo.ytd` for blip info panel imagery.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Zones not appearing on the map | Ensure `gfx-lib` is started before `gfx-redzone` in your server.cfg. |
| Kill tracking not working | Kill detection relies on `gfx-lib:server:onDeath`. Make sure `gfx-lib` is up to date and running. |
| Rewards not being given | Check `config.lua` reward settings. If using `gfx_points = true`, ensure `gfx-points` is running. If using items, ensure `gfx-inventory` or framework inventory is configured. |
| UI not showing inside zone | Run `/redzone` command to force resync. Check browser console (F8) for NUI errors. |
| Blip info panel not displaying | The `gfx_logo` texture dict must load. Ensure `stream/gfx_logo.ytd` exists and the resource is streaming properly. |
| Notifications not appearing | The server uses framework-specific notifications via `server_shared.lua`. Verify your framework is detected correctly by `gfx-lib`. |
| `ZoneCount` higher than `ZoneLocations` entries | This will cause an infinite loop. Always keep `ZoneCount` less than or equal to the number of entries in `ZoneLocations`. |
