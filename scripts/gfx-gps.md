# Gfx Gps

## Installation

### 1. Copy Files
```bash
cp -r gfx-gps /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-gps
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

*No public events found*

---

## Commands

*No commands found*

---

## Callbacks

Server callbacks you can trigger:

```lua
-- Callback: aty_gps:server:spectate", function(src, cb, target
TriggerCallback('aty_gps:server:spectate", function(src, cb, target', function(result)
    -- Handle result
end)

-- Callback: aty_gps:server:getData", function(src, cb
TriggerCallback('aty_gps:server:getData", function(src, cb', function(result)
    -- Handle result
end)

-- Callback: aty_gps:server:getCoords", function(_, cb, src
TriggerCallback('aty_gps:server:getCoords", function(_, cb, src', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-gps
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
