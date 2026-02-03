# Gfx Arena

## Installation

### 1. Copy Files
```bash
cp -r gfx-arena /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-arena
```

---

## Configuration

*No configuration file found*

---

## Exports

Exports that other scripts can call:

```lua
-- Export: IsPlayerInMatch
local result = exports['gfx-arena']:IsPlayerInMatch()

```

---

## Events

Events that this script triggers (you can listen to these):

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-arena:playerKilled')
AddEventHandler('gfx-arena:playerKilled', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-arena:SwitchTeam')
AddEventHandler('gfx-arena:SwitchTeam', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-arena:UpdateLobby')
AddEventHandler('gfx-arena:UpdateLobby', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/cancelspec` | - |
| `/getlobbies` | - |
| `/givew` | - |
| `/spec` | - |
| `/testcam` | - |

---

## Callbacks

Server callbacks you can trigger from client:

```lua
-- Callback: getHomepageData
TriggerCallback('getHomepageData', function(result)
    -- Handle result
end)

-- Callback: gfx-arena:CreateLobby
TriggerCallback('gfx-arena:CreateLobby', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: gfx-arena:GetLobbies
TriggerCallback('gfx-arena:GetLobbies', function(result)
    -- Parameters to send:  filter
    -- Handle result
end,  filter)

-- Callback: gfx-arena:JoinLobby
TriggerCallback('gfx-arena:JoinLobby', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: gfx-arena:LeaveLobby
TriggerCallback('gfx-arena:LeaveLobby', function(result)
    -- Handle result
end)

-- Callback: gfx-arena:SetReady
TriggerCallback('gfx-arena:SetReady', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-arena
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
