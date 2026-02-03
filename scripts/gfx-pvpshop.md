# Gfx Pvpshop

## Installation

### 1. Copy Files
```bash
cp -r gfx-pvpshop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pvpshop
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
-- Callback: buyOrSell
TriggerCallback('buyOrSell', function(result)
    -- Parameters to send:  data, ActiveShop
    -- Handle result
end,  data, ActiveShop)

-- Callback: getItems
TriggerCallback('getItems', function(result)
    -- Parameters to send:  k
    -- Handle result
end,  k)

-- Callback: getMoney
TriggerCallback('getMoney', function(result)
    -- Handle result
end)

-- Callback: sellAll
TriggerCallback('sellAll', function(result)
    -- Parameters to send:  ActiveShop
    -- Handle result
end,  ActiveShop)

```

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side
- ✅ Shared module

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-pvpshop
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
