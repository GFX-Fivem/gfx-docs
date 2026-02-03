# Gfx Evidence

## Installation

### 1. Copy Files
```bash
cp -r gfx-evidence /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-evidence
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
RegisterNetEvent('gfx-evidence:server:analyze')
AddEventHandler('gfx-evidence:server:analyze', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-evidence:server:dropBlood')
AddEventHandler('gfx-evidence:server:dropBlood', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-evidence:server:dropBulletCore')
AddEventHandler('gfx-evidence:server:dropBulletCore', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-evidence:server:dropCasing')
AddEventHandler('gfx-evidence:server:dropCasing', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-evidence:server:dropFingerPrint')
AddEventHandler('gfx-evidence:server:dropFingerPrint', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-evidence:server:takeEvidence')
AddEventHandler('gfx-evidence:server:takeEvidence', function(...)
    -- Handle event
end)

```

---

## Commands

*No commands found*

---

## Callbacks

Server callbacks you can trigger from client:

```lua
-- Callback: gfx-evidence:AddPreviousAnalyze
TriggerCallback('gfx-evidence:AddPreviousAnalyze', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: gfx-evidence:getPreviousAnalyzes
TriggerCallback('gfx-evidence:getPreviousAnalyzes', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-evidence
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
