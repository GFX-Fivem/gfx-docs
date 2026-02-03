# Gfx Pvpshop

## Installation

### 1. Copy Files
```bash
# Copy gfx-pvpshop folder to your resources directory
cp -r gfx-pvpshop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pvpshop
```

### 3. Dependencies
- ox_inventory or ox_lib (detected)

---

## Configuration

*No configuration file found*

---

## Events

*No events found*

---

## Exports

```lua
exports['gfx-pvpshop']:codem-inventory(...)
exports['gfx-pvpshop']:es_extended(...)
exports['gfx-pvpshop']:gfx-inventory(...)
exports['gfx-pvpshop']:gfx-lib(...)
exports['gfx-pvpshop']:ghmattimysql(...)
exports['gfx-pvpshop']:ox_inventory(...)
exports['gfx-pvpshop']:oxmysql(...)
exports['gfx-pvpshop']:ps-inventory(...)
exports['gfx-pvpshop']:qb-core(...)
exports['gfx-pvpshop']:qb-inventory(...)
exports['gfx-pvpshop']:qs-inventory(...)
```

---

## Commands

*No commands found*

---

## Callbacks

```lua
-- buyOrSell
TriggerCallback('buyOrSell', function(result)
    -- handle result
end)

-- getItems
TriggerCallback('getItems', function(result)
    -- handle result
end)

-- getMoney
TriggerCallback('getMoney', function(result)
    -- handle result
end)

-- sellAll
TriggerCallback('sellAll', function(result)
    -- handle result
end)

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
