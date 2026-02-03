# Gfx Vehicleshop

## Installation

### 1. Copy Files
```bash
# Copy gfx-vehicleshop folder to your resources directory
cp -r gfx-vehicleshop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-vehicleshop
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- aty_vehicleshop:client:openMenu
TriggerEvent('aty_vehicleshop:client:openMenu', ...)

-- aty_vehicleshop:client:sendStock
TriggerEvent('aty_vehicleshop:client:sendStock', ...)

-- aty_vehicleshop:setPlate
TriggerEvent('aty_vehicleshop:setPlate', ...)

-- esx:playerLoaded
TriggerEvent('esx:playerLoaded', ...)

-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- QBCore:Client:OnJobUpdate
TriggerEvent('QBCore:Client:OnJobUpdate', ...)

-- QBCore:Client:OnPlayerLoaded
TriggerEvent('QBCore:Client:OnPlayerLoaded', ...)

```

---

## Exports

```lua
exports['gfx-vehicleshop']:es_extended(...)
exports['gfx-vehicleshop']:ghmattimysql(...)
exports['gfx-vehicleshop']:mysql-async(...)
exports['gfx-vehicleshop']:oxmysql(...)
exports['gfx-vehicleshop']:qb-core(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-vehicleshop
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
