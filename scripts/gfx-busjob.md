# Gfx Busjob

## Installation

### 1. Copy Files
```bash
# Copy gfx-busjob folder to your resources directory
cp -r gfx-busjob /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-busjob
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- aty_busjob:client:toggleMenu
TriggerEvent('aty_busjob:client:toggleMenu', ...)

-- esx:playerLoaded
TriggerEvent('esx:playerLoaded', ...)

-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- QBCore:Client:OnJobUpdate
TriggerEvent('QBCore:Client:OnJobUpdate', ...)

-- QBCore:Client:OnPlayerLoaded
TriggerEvent('QBCore:Client:OnPlayerLoaded', ...)

```

---

## Exports

```lua
exports['gfx-busjob']:ox_target(...)
exports['gfx-busjob']:qb-target(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-busjob
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
