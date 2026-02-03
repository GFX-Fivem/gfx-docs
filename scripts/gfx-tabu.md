# Gfx Tabu

## Installation

### 1. Copy Files
```bash
# Copy gfx-tabu folder to your resources directory
cp -r gfx-tabu /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-tabu
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-tabu:gameFinished
TriggerEvent('gfx-tabu:gameFinished', ...)

-- gfx-tabu:newWord
TriggerEvent('gfx-tabu:newWord', ...)

-- gfx-tabu:pass
TriggerEvent('gfx-tabu:pass', ...)

-- gfx-tabu:standBy
TriggerEvent('gfx-tabu:standBy', ...)

-- gfx-tabu:startGame
TriggerEvent('gfx-tabu:startGame', ...)

-- gfx-tabu:updateNarrating
TriggerEvent('gfx-tabu:updateNarrating', ...)

-- gfx-tabu:updateTeam
TriggerEvent('gfx-tabu:updateTeam', ...)

```

---

## Exports

```lua
exports['gfx-tabu']:es_extended(...)
exports['gfx-tabu']:qb-core(...)
exports['gfx-tabu']:qb-inventory(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/createtabu` | - |
| `/jointabu` | - |
| `/opentabu` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-tabu
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
