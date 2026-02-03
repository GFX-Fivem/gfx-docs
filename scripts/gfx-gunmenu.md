# Gfx Gunmenu

## Installation

### 1. Copy Files
```bash
cp -r gfx-gunmenu /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-gunmenu
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

### Client Events

```lua
-- Listen to this event
RegisterNetEvent('gfx-gunmenu:deleteWeapons')
AddEventHandler('gfx-gunmenu:deleteWeapons', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/checkgun` | - |
| `/openmenu` | - |

---

## Callbacks

Server callbacks you can trigger:

```lua
-- Callback: gfx-gun:validItem", function(source, data
TriggerCallback('gfx-gun:validItem", function(source, data', function(result)
    -- Handle result
end)

-- Callback: gfx-mdt:buyWeapon", function(source, data
TriggerCallback('gfx-mdt:buyWeapon", function(source, data', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-gunmenu
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
