# Gfx Lowrider

## Installation

### 1. Copy Files
```bash
cp -r gfx-lowrider /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-lowrider
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
RegisterNetEvent('gfx-lowrider:UpdatePoints')
AddEventHandler('gfx-lowrider:UpdatePoints', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-lowriders:JoinDuel')
AddEventHandler('gfx-lowriders:JoinDuel', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-lowriders:LeaveDuel')
AddEventHandler('gfx-lowriders:LeaveDuel', function(...)
    -- Handle event
end)

```

---

## Commands

*No commands found*

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-lowrider
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
