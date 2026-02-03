# Gfx Garage

## Installation

### 1. Copy Files
```bash
# Copy gfx-garage folder to your resources directory
cp -r gfx-garage /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-garage
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- gfx-garage:client:openGarage
TriggerEvent('gfx-garage:client:openGarage', ...)

-- QBCore:Player:SetPlayerData
TriggerEvent('QBCore:Player:SetPlayerData', ...)

```

---

## Exports

```lua
exports['gfx-garage']:es_extended(...)
exports['gfx-garage']:gfx-base(...)
exports['gfx-garage']:qb-core(...)
exports['gfx-garage']:qb-target(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-garage
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
