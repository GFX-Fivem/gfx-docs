# Gfx Effects

## Installation

### 1. Copy Files
```bash
# Copy gfx-effects folder to your resources directory
cp -r gfx-effects /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-effects
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-effect:client:effect
TriggerEvent('gfx-effect:client:effect', ...)

-- gfx-effects:client:GetPlayerCurrentEffect
TriggerEvent('gfx-effects:client:GetPlayerCurrentEffect', ...)

-- gfx-effects:client:SetVip
TriggerEvent('gfx-effects:client:SetVip', ...)

```

### Server Events

```lua
-- gfx-effects:server:RequestVip
TriggerServerEvent('gfx-effects:server:RequestVip', ...)

```

---

## Exports

*No exports found*

---

## Commands

| Command | Description |
|---------|-------------|
| `/effects` | - |

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-effects
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
