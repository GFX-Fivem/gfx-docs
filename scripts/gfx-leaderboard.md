# Gfx Leaderboard

## Installation

### 1. Copy Files
```bash
# Copy gfx-leaderboard folder to your resources directory
cp -r gfx-leaderboard /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-leaderboard
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- leaderboard:changePed
TriggerEvent('leaderboard:changePed', ...)

-- leaderboard:updateTextInfo
TriggerEvent('leaderboard:updateTextInfo', ...)

```

### Server Events

```lua
-- esx:playerLoaded
TriggerServerEvent('esx:playerLoaded', ...)

```

---

## Exports

```lua
exports['gfx-leaderboard']:fivem-appearance(...)
exports['gfx-leaderboard']:gfx-lib(...)
exports['gfx-leaderboard']:illenium-appearance(...)
exports['gfx-leaderboard']:skinchanger(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/checkleaderboard` | - |
| `/givewep` | - |
| `/leaderboard` | - |
| `/requestlist` | - |
| `/saveleaderboard` | - |
| `/setammo` | - |

---

## Callbacks

```lua
-- leaderboard:getList
TriggerCallback('leaderboard:getList', function(result)
    -- handle result
end)

-- leaderboard:getPlayerSkin
TriggerCallback('leaderboard:getPlayerSkin', function(result)
    -- handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-leaderboard
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
