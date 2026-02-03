# Gfx Redzone

## Installation

### 1. Copy Files
```bash
cp -r gfx-redzone /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-redzone
```

---

## Configuration

*No configuration file found*

---

## Exports

Exports that other scripts can call:

```lua
-- Export: IsPlayerInRedZone
local result = exports['gfx-redzone']:IsPlayerInRedZone()

```

---

## Events

Events that this script triggers (you can listen to these):

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-redzone:enteredZone')
AddEventHandler('gfx-redzone:enteredZone', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-redzone:exitedZone')
AddEventHandler('gfx-redzone:exitedZone', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-redzone:playerKilled')
AddEventHandler('gfx-redzone:playerKilled', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-redzone:server:Identifier')
AddEventHandler('gfx-redzone:server:Identifier', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/redzone` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-redzone
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
