# Gfx Crafting Aty

## Installation

### 1. Copy Files
```bash
# Copy gfx-crafting_aty folder to your resources directory
cp -r gfx-crafting_aty /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-crafting_aty
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- aty_crafting:client:updatePlayerData
TriggerEvent('aty_crafting:client:updatePlayerData', ...)

-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- QBCore:Client:OnJobUpdate
TriggerEvent('QBCore:Client:OnJobUpdate', ...)

```

### Server Events

```lua
-- aty_crafting:server:craftEnded
TriggerServerEvent('aty_crafting:server:craftEnded', ...)

```

---

## Exports

```lua
exports['gfx-crafting_aty']:ghmattimysql(...)
exports['gfx-crafting_aty']:mysql-async(...)
exports['gfx-crafting_aty']:oxmysql(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/purchase_made_for_crafting` | - |

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-crafting_aty
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
