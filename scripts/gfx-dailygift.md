# Gfx Dailygift

## Installation

### 1. Copy Files
```bash
cp -r gfx-dailygift /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-dailygift
```

---

## Configuration

*No configuration file found*

---

## Exports

Exports that other scripts can call:

*No exports found*

---

## Events

Events that this script triggers (you can listen to these):

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-dailygift:getItemTable')
AddEventHandler('gfx-dailygift:getItemTable', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-dailygift:GetReward')
AddEventHandler('gfx-dailygift:GetReward', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-dailygift:open')
AddEventHandler('gfx-dailygift:open', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/createDailyData` | - |
| `/resetdaily` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-dailygift
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
