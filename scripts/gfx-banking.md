# Gfx Banking

## Installation

### 1. Copy Files
```bash
# Copy gfx-banking folder to your resources directory
cp -r gfx-banking /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-banking
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-banking:client:Update
TriggerEvent('gfx-banking:client:Update', ...)

-- gfx-banking:Open
TriggerEvent('gfx-banking:Open', ...)

-- qb-core:UpdateAccounts
TriggerEvent('qb-core:UpdateAccounts', ...)

-- QBCore:Player:SetPlayerData
TriggerEvent('QBCore:Player:SetPlayerData', ...)

```

---

## Exports

```lua
exports['gfx-banking']:gfx-base(...)
exports['gfx-banking']:qb-core(...)
exports['gfx-banking']:qb-target(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/debugmoney` | - |
| `/openbank` | - |
| `/transfertonewbank` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-banking
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
