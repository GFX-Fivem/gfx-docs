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

Server callbacks you can trigger from client:

```lua
-- Callback: aty_gps:server:getCoords
TriggerCallback('aty_gps:server:getCoords', function(result)
    -- Parameters to send: _, cb, src
    -- Handle result
end, _, cb, src)

-- Callback: aty_gps:server:getData
TriggerCallback('aty_gps:server:getData', function(result)
    -- Parameters to send: src, cb
    -- Handle result
end, src, cb)

-- Callback: aty_gps:server:spectate
TriggerCallback('aty_gps:server:spectate', function(result)
    -- Parameters to send: src, cb, target
    -- Handle result
end, src, cb, target)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-gps
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
