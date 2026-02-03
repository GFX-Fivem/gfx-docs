# Gfx Dailygift

## Installation

### 1. Copy Files
```bash
# Copy gfx-dailygift folder to your resources directory
cp -r gfx-dailygift /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-dailygift
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-daily:open
TriggerEvent('gfx-daily:open', ...)

-- gfx-dailygift:setItemTable
TriggerEvent('gfx-dailygift:setItemTable', ...)

-- gfx-dailygift:UpdateUI
TriggerEvent('gfx-dailygift:UpdateUI', ...)

```

### Server Events

```lua
-- gfx-dailygift:open
TriggerServerEvent('gfx-dailygift:open', ...)

```

---

## Exports

```lua
exports['gfx-dailygift']:gfx-base(...)
exports['gfx-dailygift']:ghmattimysq(...)
exports['gfx-dailygift']:ghmattimysql(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/createDailyData` | - |
| `/resetdaily` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-dailygift
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
