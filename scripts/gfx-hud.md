# GFX Hud

A full-featured player HUD for FiveM, displaying health, armor, stamina, hunger, thirst, voice proximity, compass/heading, location, and a vehicle speedometer with gear, fuel, and engine health indicators. Includes a player info panel with job, money, server time, player count, and server ID. Supports both QBCore and ESX frameworks.

---

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx-hud` |
| **FX version** | `cerulean` |
| **Game** | `gta5` |
| **Lua 5.4** | Yes |
| **Side** | Client + Server |
| **UI** | NUI (HTML/JS) |

---

## Dependencies

| Dependency | Required | Notes |
|------------|----------|-------|
| **ESX** (`es_extended`) | If using ESX | Set `Config.useQBCore = false` |
| **QBCore** (`qb-core` or custom) | If using QBCore | Set `Config.useQBCore = true` and `Config.coreName` accordingly |
| **pma-voice** | Optional | Auto-detected at runtime for voice proximity and radio indicators |
| **saltychat** | Optional | Auto-detected at runtime as alternative voice system |
| **bs:voice** | Optional | Auto-detected via event listeners for voice proximity and radio |
| **baseevents** | Optional | Only needed if `Config.useBaseevents = true` for vehicle enter/exit detection |

---

## Installation

### 1. Copy Files

Place the `gfx-hud` folder into your server's resources directory.

### 2. server.cfg

```cfg
ensure gfx-hud
```

> **Note:** If using ESX, ensure `es_extended` starts before `gfx-hud`. If using QBCore, ensure your core resource starts first.

### 3. Configure

Edit `config.lua` to match your framework and preferences (see Configuration section below).

---

## Configuration

All options are set in `config.lua`:

### Player Status Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `statusTick` | `number` | `250` | How often to update player status (health, armor, stamina) in milliseconds |
| `compassDirections` | `table` | `{"N","NE","E","SE","S","SW","W","NW","N"}` | Compass direction labels displayed on the HUD |

### Vehicle Speedometer Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `useMph` | `boolean` | `false` | Use MPH instead of KM/H for speed display |
| `unitText` | `string` | `"km/h"` | Speed unit label shown on the speedometer |
| `useBaseevents` | `boolean` | `false` | Use baseevents resource for vehicle enter/exit detection instead of a polling loop. If the speedometer does not appear, try setting this to `false` |
| `speedoTick` | `number` | `350` | How often to update the speedometer in milliseconds |

### Player Info Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `showPlayerInfo` | `boolean` | `true` | Show player info panel (job, ID, time, etc.) |
| `moneyCurrency` | `string` | `"USD"` | Currency code displayed next to money values |
| `serverLogo` | `string` | *(URL)* | URL to the server logo image displayed on the info panel |
| `displayLocation` | `boolean` | `true` | Show street name and zone on the HUD. Adds minor resmon usage (~0.03-0.06 ms) |
| `displayTime` | `boolean` | `true` | Show in-game time on the info panel |
| `displayPlayerCount` | `boolean` | `true` | Show online player count on the info panel |
| `displayPlayerMoney` | `boolean` | `true` | Show player bank/cash balance on the info panel |
| `displayPlayerJob` | `boolean` | `true` | Show player job on the info panel |
| `displayPlayerId` | `boolean` | `true` | Show player server ID on the info panel |

### Framework Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `useQBCore` | `boolean` | `true` | Set to `true` for QBCore, `false` for ESX |
| `coreName` | `string` | `"qb-core"` | Resource name of your QBCore core. Ignored when using ESX |
| `useOldQBCore` | `boolean` | `false` | Enable if using an older QBCore version that does not support the new export method. Ignored when using ESX |

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events are exposed by this script for external use.*

All registered events are internal (framework callbacks, NUI communication, and inter-script vehicle/player count sync).

---

## Commands

| Command | Description |
|---------|-------------|
| `/hud` | Opens the HUD preferences/settings panel |

---

## Features

### Player Status HUD
- **Health** -- real-time health percentage bar
- **Armor** -- real-time armor percentage bar
- **Stamina** -- sprint stamina indicator (inverted: shows fatigue)
- **Hunger & Thirst** -- framework-provided needs (ESX via `esx_status`, QBCore via player metadata)
- **Voice Proximity** -- displays current voice range level
- **Voice Activity** -- indicators for microphone active and radio transmitting
- **Compass** -- camera-heading-based compass direction (N, NE, E, etc.)
- **Heading** -- numeric heading in degrees (0-360)
- **Location** -- current street name and zone label

### Player Info Panel
- **Server Logo** -- configurable logo image
- **Player ID** -- server-side player source ID
- **Job** -- current job name and grade
- **Money** -- bank and cash balances with configurable currency
- **Player Count** -- online/max players (updated every 5 seconds from server)
- **In-Game Time** -- formatted HH:MM clock from the game world

### Vehicle Speedometer
- **Speed** -- current vehicle speed in KM/H or MPH
- **Top Speed** -- derived from vehicle handling data
- **Gear** -- current gear number, with N (neutral) and R (reverse) indicators
- **Fuel Level** -- current vehicle fuel level
- **Engine Health** -- current engine health value
- Aircraft detection (planes and helicopters recognized)

### Voice System Support
Automatically integrates with the following voice resources (no configuration needed):
- **pma-voice** -- proximity mode changes and radio activity
- **saltychat** -- voice range changes and radio traffic state
- **bs:voice** -- proximity, transmission started/finished events

### General
- Auto-hides HUD when pause menu is active
- Configurable update intervals for performance tuning
- Supports both polling-based and baseevents-based vehicle detection
- NUI-based UI with HTML/JS frontend

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Speedometer not appearing | Set `Config.useBaseevents = false` in `config.lua` to use polling-based vehicle detection |
| Hunger/thirst not showing | Ensure your framework's needs system is running (`esx_status` for ESX, or QBCore metadata) |
| Player info not updating | Verify that `Config.showPlayerInfo = true` and your framework resource starts before `gfx-hud` |
| Voice indicators not working | Ensure `pma-voice`, `saltychat`, or `bs:voice` is started. No config change needed -- detection is automatic |
| HUD not appearing at all | Check that the resource started without errors. For ESX, ensure `es_extended` is in `shared_script`. For QBCore, verify `Config.coreName` matches your core resource name |
| Location display causing performance issues | Set `Config.displayLocation = false` to disable street/zone updates |
| Old QBCore compatibility | Set `Config.useOldQBCore = true` if your QBCore version does not support the export-based initialization |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-hud
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
