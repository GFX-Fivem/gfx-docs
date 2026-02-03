# Gfx Attachment

## Installation

### 1. Copy Files
```bash
cp -r gfx-attachment /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-attachment
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
RegisterNetEvent('gfx-attachment:server:saveWeapon')
AddEventHandler('gfx-attachment:server:saveWeapon', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/bench` | - |
| `/removeattachments` | - |
| `/setattachments` | - |

---

## Callbacks

Server callbacks you can trigger from client:

```lua
-- Callback: getAttachments
TriggerCallback('getAttachments', function(result)
    -- Parameters to send:  weaponName
    -- Handle result
end,  weaponName)

-- Callback: getWeapons
TriggerCallback('getWeapons', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-attachment
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
