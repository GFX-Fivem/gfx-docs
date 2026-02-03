# Gfx Giveaway

## Installation

### 1. Copy Files
```bash
# Copy gfx-giveaway folder to your resources directory
cp -r gfx-giveaway /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-giveaway
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- aty_giveaway:client:finished
TriggerEvent('aty_giveaway:client:finished', ...)

-- aty_giveaway:client:notify
TriggerEvent('aty_giveaway:client:notify', ...)

-- aty_giveaway:client:open
TriggerEvent('aty_giveaway:client:open', ...)

-- aty_giveaway:client:refreshPlayers
TriggerEvent('aty_giveaway:client:refreshPlayers', ...)

-- aty_giveaway:client:startGiveaway
TriggerEvent('aty_giveaway:client:startGiveaway', ...)

-- aty_giveaway:client:updateTime
TriggerEvent('aty_giveaway:client:updateTime', ...)

```

### Server Events

```lua
-- aty_giveaway:server:joinGiveaway
TriggerServerEvent('aty_giveaway:server:joinGiveaway', ...)

-- aty_giveaway:server:startGiveaway
TriggerServerEvent('aty_giveaway:server:startGiveaway', ...)

-- esx:playerLoaded
TriggerServerEvent('esx:playerLoaded', ...)

-- QBCore:Server:OnPlayerLoaded
TriggerServerEvent('QBCore:Server:OnPlayerLoaded', ...)

```

---

## Exports

*No exports found*

---

## Commands

| Command | Description |
|---------|-------------|
| `/focus` | - |
| `/giveaway` | - |

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-giveaway
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
