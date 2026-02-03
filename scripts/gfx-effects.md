# Gfx Effects

## Installation

### 1. Copy Files
```bash
cp -r gfx-effects /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-effects
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
RegisterNetEvent('gfx-effects:GetPlayerCurrentEffect')
AddEventHandler('gfx-effects:GetPlayerCurrentEffect', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-effects:playerKilled')
AddEventHandler('gfx-effects:playerKilled', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-effects:server:RequestVip')
AddEventHandler('gfx-effects:server:RequestVip', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-effects:SetPtfxData')
AddEventHandler('gfx-effects:SetPtfxData', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/effects` | - |

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-effects
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
