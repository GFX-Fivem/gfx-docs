# Gfx Racing

## Installation

### 1. Copy Files
```bash
cp -r gfx-racing /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-racing
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
RegisterNetEvent('gfx-racing-FinishRace')
AddEventHandler('gfx-racing-FinishRace', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing-server:AddRoute')
AddEventHandler('gfx-racing-server:AddRoute', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing-server:CreateRace')
AddEventHandler('gfx-racing-server:CreateRace', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing-server:JoinRace')
AddEventHandler('gfx-racing-server:JoinRace', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing-server:leaverace')
AddEventHandler('gfx-racing-server:leaverace', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing-ServerOpenNUI')
AddEventHandler('gfx-racing-ServerOpenNUI', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing-SetRaceLeaderBoard')
AddEventHandler('gfx-racing-SetRaceLeaderBoard', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing:ClearRaceData')
AddEventHandler('gfx-racing:ClearRaceData', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing:Server:DeleteRoute')
AddEventHandler('gfx-racing:Server:DeleteRoute', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing:SetFavCar')
AddEventHandler('gfx-racing:SetFavCar', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing:setInterval')
AddEventHandler('gfx-racing:setInterval', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-racing:StartServerRace')
AddEventHandler('gfx-racing:StartServerRace', function(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-racing
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
