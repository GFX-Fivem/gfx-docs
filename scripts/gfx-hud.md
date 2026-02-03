# Gfx Hud

## Installation

### 1. Copy Files
```bash
# Copy gfx-hud folder to your resources directory
cp -r gfx-hud /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-hud
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- esx_status:onTick
TriggerEvent('esx_status:onTick', ...)

-- esx_status:set
TriggerEvent('esx_status:set', ...)

-- esx_status:update
TriggerEvent('esx_status:update', ...)

-- esx:playerLoaded
TriggerEvent('esx:playerLoaded', ...)

-- esx:setAccountMoney
TriggerEvent('esx:setAccountMoney', ...)

-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- gfx_hud:enteredVehicle
TriggerEvent('gfx_hud:enteredVehicle', ...)

-- gfx_hud:leftVehicle
TriggerEvent('gfx_hud:leftVehicle', ...)

-- gfx_hud:updatePlayerCount
TriggerEvent('gfx_hud:updatePlayerCount', ...)

-- hud:client:UpdateNeeds
TriggerEvent('hud:client:UpdateNeeds', ...)

-- QBCore:Client:OnJobUpdate
TriggerEvent('QBCore:Client:OnJobUpdate', ...)

-- QBCore:Client:OnMoneyChange
TriggerEvent('QBCore:Client:OnMoneyChange', ...)

-- QBCore:Client:OnPlayerLoaded
TriggerEvent('QBCore:Client:OnPlayerLoaded', ...)

-- QBCore:Player:SetPlayerData
TriggerEvent('QBCore:Player:SetPlayerData', ...)

```

---

## Exports

```lua
exports['gfx-hud']:es_extended(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/hud` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-hud
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
