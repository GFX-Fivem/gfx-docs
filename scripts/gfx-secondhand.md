# Gfx Secondhand

## Installation

### 1. Copy Files
```bash
# Copy gfx-secondhand folder to your resources directory
cp -r gfx-secondhand /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-secondhand
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- esx:playerLoaded
TriggerEvent('esx:playerLoaded', ...)

-- Jakrino:Client:DeleteVehicle
TriggerEvent('Jakrino:Client:DeleteVehicle', ...)

-- Jakrino:Client:OpenSellingPopUp
TriggerEvent('Jakrino:Client:OpenSellingPopUp', ...)

-- Jakrino:Client:UpdateSecondHand
TriggerEvent('Jakrino:Client:UpdateSecondHand', ...)

-- Jakrino:Client:UpdateVehicles
TriggerEvent('Jakrino:Client:UpdateVehicles', ...)

-- Jakrino:Client:UpdateVehiclesData
TriggerEvent('Jakrino:Client:UpdateVehiclesData', ...)

-- Jakrino:Client:ViewVehicle
TriggerEvent('Jakrino:Client:ViewVehicle', ...)

-- onResourceStart
TriggerEvent('onResourceStart', ...)

-- QBCore:Client:OnPlayerLoaded
TriggerEvent('QBCore:Client:OnPlayerLoaded', ...)

```

### Server Events

```lua
-- Jakrino:Server:SaveVehicle
TriggerServerEvent('Jakrino:Server:SaveVehicle', ...)

```

---

## Exports

```lua
exports['gfx-secondhand']:es_extended(...)
exports['gfx-secondhand']:gfx-secondhand(...)
exports['gfx-secondhand']:ghmattimysql(...)
exports['gfx-secondhand']:oxmysql(...)
exports['gfx-secondhand']:qb-core(...)
exports['gfx-secondhand']:qb-target(...)
```

---

## Commands

*No commands found*

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-secondhand
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
