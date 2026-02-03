# Gfx Help

## Installation

### 1. Copy Files
```bash
cp -r gfx-help /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-help
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
RegisterNetEvent('gfx-help:closeTicket')
AddEventHandler('gfx-help:closeTicket', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-help:updateTicket')
AddEventHandler('gfx-help:updateTicket', function(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-help
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
