# Gfx Christmastruck

## Installation

### 1. Copy Files
```bash
# Copy gfx-christmastruck folder to your resources directory
cp -r gfx-christmastruck /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-christmastruck
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-christmasgifts:client:addBlipToTruck
TriggerEvent('gfx-christmasgifts:client:addBlipToTruck', ...)

-- gfx-christmasgifts:client:createGift
TriggerEvent('gfx-christmasgifts:client:createGift', ...)

-- gfx-christmasgifts:client:pickupGift
TriggerEvent('gfx-christmasgifts:client:pickupGift', ...)

-- gfx-christmasgifts:client:spawnGiftTruck
TriggerEvent('gfx-christmasgifts:client:spawnGiftTruck', ...)

```

---

## Exports

```lua
exports['gfx-christmastruck']:es_extended(...)
exports['gfx-christmastruck']:qb-core(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/createBox` | - |
| `/spawnGiftTruck` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-christmastruck
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
