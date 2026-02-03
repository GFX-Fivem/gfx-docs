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

Server callbacks you can trigger:

```lua
-- Callback: getHomepageData", function(source
TriggerCallback('getHomepageData", function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-arena:CreateLobby", function(source, data
TriggerCallback('gfx-arena:CreateLobby", function(source, data', function(result)
    -- Handle result
end)

-- Callback: gfx-arena:JoinLobby", function(source, data
TriggerCallback('gfx-arena:JoinLobby", function(source, data', function(result)
    -- Handle result
end)

-- Callback: gfx-arena:LeaveLobby", function(source
TriggerCallback('gfx-arena:LeaveLobby", function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-arena:SetReady", function(source
TriggerCallback('gfx-arena:SetReady", function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-arena:GetLobbies", function(source, filter
TriggerCallback('gfx-arena:GetLobbies", function(source, filter', function(result)
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
