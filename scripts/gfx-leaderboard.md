# Gfx Leaderboard

## Installation

### 1. Copy Files
```bash
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

## Exports

Exports that other scripts can call:

*No exports found*

---

## Events

Events that this script triggers (you can listen to these):

*No public events found*

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

Server callbacks you can trigger:

```lua
-- Callback: leaderboard:getList", function(source, id, type
TriggerCallback('leaderboard:getList", function(source, id, type', function(result)
    -- Handle result
end)

-- Callback: leaderboard:getPlayerSkin", function(source, type
TriggerCallback('leaderboard:getPlayerSkin", function(source, type', function(result)
    -- Handle result
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
