# Gfx Evidence

## Installation

### 1. Copy Files
```bash
# Copy gfx-evidence folder to your resources directory
cp -r gfx-evidence /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-evidence
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

-- gfx-evidence:client:analyze
TriggerEvent('gfx-evidence:client:analyze', ...)

-- gfx-evidence:client:dropBlood
TriggerEvent('gfx-evidence:client:dropBlood', ...)

-- gfx-evidence:client:dropBulletCore
TriggerEvent('gfx-evidence:client:dropBulletCore', ...)

-- gfx-evidence:client:dropCasing
TriggerEvent('gfx-evidence:client:dropCasing', ...)

-- gfx-evidence:client:removeEvidence
TriggerEvent('gfx-evidence:client:removeEvidence', ...)

-- QBCore:Client:OnJobUpdate
TriggerEvent('QBCore:Client:OnJobUpdate', ...)

```

---

## Exports

```lua
exports['gfx-evidence']:es_extended(...)
exports['gfx-evidence']:ghmattimysql(...)
exports['gfx-evidence']:oxmysql(...)
exports['gfx-evidence']:qb-core(...)
exports['gfx-evidence']:qb-weapons(...)
```

---

## Commands

*No commands found*

---

## Callbacks

```lua
-- gfx-evidence:AddPreviousAnalyze
TriggerCallback('gfx-evidence:AddPreviousAnalyze', function(result)
    -- handle result
end)

-- gfx-evidence:getPreviousAnalyzes
TriggerCallback('gfx-evidence:getPreviousAnalyzes', function(result)
    -- handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-evidence
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
