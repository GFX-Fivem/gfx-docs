# Gfx Lumberjack

## Installation

### 1. Copy Files
```bash
# Copy gfx-lumberjack folder to your resources directory
cp -r gfx-lumberjack /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-lumberjack
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx:client:lumberjack:Notify
TriggerEvent('gfx:client:lumberjack:Notify', ...)

-- gfx:client:LumberjackNui
TriggerEvent('gfx:client:LumberjackNui', ...)

-- gfx:lumberjack:cutTree
TriggerEvent('gfx:lumberjack:cutTree', ...)

```

### Server Events

```lua
-- gfx:server:lumberjack:CuttingTrees
TriggerServerEvent('gfx:server:lumberjack:CuttingTrees', ...)

-- gfx:server:lumberjack:GainContractMoney
TriggerServerEvent('gfx:server:lumberjack:GainContractMoney', ...)

```

---

## Exports

```lua
exports['gfx-lumberjack']:es_extended(...)
exports['gfx-lumberjack']:ghmattimysql(...)
exports['gfx-lumberjack']:oxmysql(...)
exports['gfx-lumberjack']:qb-core(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-lumberjack
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
