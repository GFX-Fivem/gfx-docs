# Gfx Garage

## Installation

### 1. Copy Files
```bash
cp -r gfx-garage /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-garage
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
RegisterNetEvent('gfx-garage:server:SpawnVehicle')
AddEventHandler('gfx-garage:server:SpawnVehicle', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-garage:takeOutVehicle')
AddEventHandler('gfx-garage:takeOutVehicle', function(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-garage
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
