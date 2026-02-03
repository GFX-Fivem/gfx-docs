# Gfx Chat

## Installation

### 1. Copy Files
```bash
cp -r gfx-chat /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-chat
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

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-chat:adminAction')
AddEventHandler('gfx-chat:adminAction', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-chat:DiscordLog')
AddEventHandler('gfx-chat:DiscordLog', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/changechatmode` | - |
| `/clear` | - |
| `/openchat` | - |

---

## Features

- ✅ Client-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-chat
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
