# Gfx Squad

## Installation

### 1. Copy Files
```bash
cp -r gfx-squad /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-squad
```

---

## Configuration

*No configuration file found*

---

## Exports

Exports that other scripts can call:

```lua
-- Export: GetSquad
local result = exports['gfx-squad']:GetSquad(squadid)

-- Export: GetSquadId
local result = exports['gfx-squad']:GetSquadId(source)

-- Export: GetSquadMembers
local result = exports['gfx-squad']:GetSquadMembers(source)

```

---

## Events

Events that this script triggers (you can listen to these):

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-squad:Create')
AddEventHandler('gfx-squad:Create', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-squad:CreateMarker')
AddEventHandler('gfx-squad:CreateMarker', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-squad:Delete')
AddEventHandler('gfx-squad:Delete', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-squad:GetSquads')
AddEventHandler('gfx-squad:GetSquads', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-squad:JoinSquad')
AddEventHandler('gfx-squad:JoinSquad', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-squad:Kick')
AddEventHandler('gfx-squad:Kick', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-squad:Leave')
AddEventHandler('gfx-squad:Leave', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-squad:PrivateStatus')
AddEventHandler('gfx-squad:PrivateStatus', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/marker` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-squad
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
