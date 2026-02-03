# Gfx Delivery

## Installation

### 1. Copy Files
```bash
# Copy gfx-delivery folder to your resources directory
cp -r gfx-delivery /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-delivery
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx:client:openUI
TriggerEvent('gfx:client:openUI', ...)

-- gfx:client:TriggerNotfiy
TriggerEvent('gfx:client:TriggerNotfiy', ...)

```

### Server Events

```lua
-- GFX:DeliveryJob:DeleteContract
TriggerServerEvent('GFX:DeliveryJob:DeleteContract', ...)

-- GFX:DeliveryJob:GainContractMoney
TriggerServerEvent('GFX:DeliveryJob:GainContractMoney', ...)

-- GFX:DeliveryJob:GainMoney
TriggerServerEvent('GFX:DeliveryJob:GainMoney', ...)

-- GFX:DeliveryJob:LevelSave
TriggerServerEvent('GFX:DeliveryJob:LevelSave', ...)

-- GFX:DeliveryJob:Withdrawdeposit
TriggerServerEvent('GFX:DeliveryJob:Withdrawdeposit', ...)

```

---

## Exports

```lua
exports['gfx-delivery']:es_extended(...)
exports['gfx-delivery']:ghmattimysql(...)
exports['gfx-delivery']:ox_target(...)
exports['gfx-delivery']:oxmysql(...)
exports['gfx-delivery']:qb-core(...)
exports['gfx-delivery']:qb-target(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-delivery
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
