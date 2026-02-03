# Gfx Tabu

## Installation

### 1. Copy Files
```bash
cp -r gfx-tabu /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-tabu
```

---

## Configuration

*No configuration file found*

---

## Exports

Exports that other scripts can call:

```lua
-- Export: GetConfig
local result = exports['gfx-tabu']:GetConfig()

-- Export: GetIdentifier
local result = exports['gfx-tabu']:GetIdentifier(source, type)

```

---

## Events

Events that this script triggers (you can listen to these):

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-tabu:button')
AddEventHandler('gfx-tabu:button', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-tabu:JoinLobby')
AddEventHandler('gfx-tabu:JoinLobby', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-tabu:quitLobby')
AddEventHandler('gfx-tabu:quitLobby', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-tabu:RegisterLobby')
AddEventHandler('gfx-tabu:RegisterLobby', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-tabu:switchTeam')
AddEventHandler('gfx-tabu:switchTeam', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/createtabu` | - |
| `/jointabu` | - |
| `/opentabu` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-tabu
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
