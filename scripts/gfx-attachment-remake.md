# Gfx Attachment Remake

## Installation

### 1. Copy Files
```bash
cp -r gfx-attachment-remake /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-attachment-remake
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

*No commands found*

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

-- Callback: saveWeapon
TriggerCallback('saveWeapon', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

```

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side
- ✅ Shared module

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-attachment-remake
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
