# Gfx Trade

## Installation

### 1. Copy Files
```bash
cp -r gfx-trade /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-trade
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
RegisterNetEvent('gfx-trade:CloseMenu')
AddEventHandler('gfx-trade:CloseMenu', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-trade:SelectItem')
AddEventHandler('gfx-trade:SelectItem', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-trade:server:TradeResponse')
AddEventHandler('gfx-trade:server:TradeResponse', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-trade:SetReady')
AddEventHandler('gfx-trade:SetReady', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/getidentifier` | - |
| `/trade` | - |
| `/tradea` | - |
| `/traded` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-trade
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
