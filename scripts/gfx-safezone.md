# Gfx Safezone

## Installation

### 1. Copy Files
```bash
cp -r gfx-safezone /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-safezone
```

---

## Configuration

*No configuration file found*

---

## Exports

Exports that other scripts can call:

```lua
-- Export: GetPlayersInZone
local result = exports['gfx-safezone']:GetPlayersInZone(zone)

-- Export: GetPlayerZone
local result = exports['gfx-safezone']:GetPlayerZone(player)

-- Export: InSafeZone
local result = exports['gfx-safezone']:InSafeZone(player)

```

---

## Events

Events that this script triggers (you can listen to these):

*No public events found*

---

## Commands

| Command | Description |
|---------|-------------|
| `/safezone_kick` | - |
| `/safezone_list` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-safezone
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
