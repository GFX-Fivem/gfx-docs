# Gfx Vote

## Installation

### 1. Copy Files
```bash
cp -r gfx-vote /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-vote
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
RegisterNetEvent('gfx-vote:create')
AddEventHandler('gfx-vote:create', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-vote:vote')
AddEventHandler('gfx-vote:vote', function(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-vote
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
