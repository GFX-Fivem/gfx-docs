# Gfx Pilotjob

## Installation

### 1. Copy Files
```bash
cp -r gfx-pilotjob /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pilotjob
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

### Client Events

```lua
-- Listen to this event
RegisterNetEvent('gfx-pilotjob:deleteVehicle')
AddEventHandler('gfx-pilotjob:deleteVehicle', function(...)
    -- Handle event
end)

```

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-pilotjob:explodePlane')
AddEventHandler('gfx-pilotjob:explodePlane', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-pilotjob:server:CallCops')
AddEventHandler('gfx-pilotjob:server:CallCops', function(...)
    -- Handle event
end)

```

---

## Commands

*No commands found*

---

## Callbacks

Server callbacks you can trigger from client:

```lua
-- Callback: gfx:server:getInfos
TriggerCallback('gfx:server:getInfos', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-pilotjob
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
