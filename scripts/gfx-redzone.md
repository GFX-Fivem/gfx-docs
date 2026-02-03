# Gfx Redzone

## Installation

### 1. Copy Files
```bash
# Copy gfx-redzone folder to your resources directory
cp -r gfx-redzone /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-redzone
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-redzone:CreateZone
TriggerEvent('gfx-redzone:CreateZone', ...)

-- gfx-redzone:Identifier
TriggerEvent('gfx-redzone:Identifier', ...)

-- gfx-redzone:RemoveZone
TriggerEvent('gfx-redzone:RemoveZone', ...)

-- gfx-redzone:UpdateZones
TriggerEvent('gfx-redzone:UpdateZones', ...)

```

---

## Exports

```lua
exports['gfx-redzone']:gfx-inventory(...)
exports['gfx-redzone']:gfx-lib(...)
exports['gfx-redzone']:gfx-points(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/redzone` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-redzone
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
