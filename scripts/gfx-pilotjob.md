# Gfx Pilotjob

## Installation

### 1. Copy Files
```bash
# Copy gfx-pilotjob folder to your resources directory
cp -r gfx-pilotjob /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pilotjob
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-pilotjob:client:CallCops
TriggerEvent('gfx-pilotjob:client:CallCops', ...)

-- missionFailed
TriggerEvent('missionFailed', ...)

```

---

## Exports

```lua
exports['gfx-pilotjob']:es_extended(...)
exports['gfx-pilotjob']:qb-core(...)
```

---

## Commands

*No commands found*

---

## Callbacks

```lua
-- gfx:server:getInfos
TriggerCallback('gfx:server:getInfos', function(result)
    -- handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-pilotjob
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
