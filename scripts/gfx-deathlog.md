# Gfx Deathlog

## Installation

### 1. Copy Files
```bash
# Copy gfx-deathlog folder to your resources directory
cp -r gfx-deathlog /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-deathlog
```

### 3. Dependencies
- ox_inventory or ox_lib (detected)

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- rush-deadlog:client:Report
TriggerEvent('rush-deadlog:client:Report', ...)

-- rush-deadlog:client:UpdateDeadLogs
TriggerEvent('rush-deadlog:client:UpdateDeadLogs', ...)

```

### Server Events

```lua
-- rush-deadlog:server:ReportDeadLog
TriggerServerEvent('rush-deadlog:server:ReportDeadLog', ...)

```

---

## Exports

```lua
exports['gfx-deathlog']:codem-inventory(...)
exports['gfx-deathlog']:es_extended(...)
exports['gfx-deathlog']:gfx-inventory(...)
exports['gfx-deathlog']:ghmattimysql(...)
exports['gfx-deathlog']:ox_inventory(...)
exports['gfx-deathlog']:oxmysql(...)
exports['gfx-deathlog']:ps-inventory(...)
exports['gfx-deathlog']:qb-core(...)
exports['gfx-deathlog']:qb-inventory(...)
exports['gfx-deathlog']:qs-inventory(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/deadlog` | - |
| `/report` | - |
| `/reports` | - |
| `/test3131` | - |

---

## Callbacks

```lua
-- getIdent
TriggerCallback('getIdent', function(result)
    -- handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-deathlog
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
