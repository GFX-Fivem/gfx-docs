# Gfx Squad Remake

## Installation

### 1. Copy Files
```bash
cp -r gfx-squad-remake /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-squad-remake
```

---

## Configuration

### client_config.lua

```lua
Config = {
    FriendlyFire = false,
    HudInterval = 5000,
    Theme = {
        ["primary"] = '#FF2F2F',
        ["primary-content"] = '#900000',
        ["primary-opacity"] = "rgba(255, 47, 47, 0.2)";
    }
}
```

### server_config.lua

```lua
local modules = exports["gfx-lib"]:getModules()

Config = {
    DiscordBotToken = "",
    Notify = function(source, message)
        modules.Notify(source, message)
    end, -- you can change your notify function here

}
```

---

## Exports

Exports that other scripts can call:

```lua
-- Export: GetSquadData
local result = exports['gfx-squad-remake']:GetSquadData(source)

-- Export: GetSquadId
local result = exports['gfx-squad-remake']:GetSquadId(source)

-- Export: GetSquadMembers
local result = exports['gfx-squad-remake']:GetSquadMembers(source)

-- Export: HasMemberGotASquad
local result = exports['gfx-squad-remake']:HasMemberGotASquad(source)

```

---

## Events

Events that this script triggers (you can listen to these):

*No public events found*

---

## Commands

| Command | Description |
|---------|-------------|
| `/cm` | - |
| `/squad` | - |

---

## Callbacks

Server callbacks you can trigger:

```lua
-- Callback: removeInvite', function(source, id
TriggerCallback('removeInvite', function(source, id', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getMemberCoords', function(source, member
TriggerCallback('gfx-crew:getMemberCoords', function(source, member', function(result)
    -- Handle result
end)

-- Callback: getInvites', function(source, data
TriggerCallback('getInvites', function(source, data', function(result)
    -- Handle result
end)

-- Callback: inviteMember', function(source, data
TriggerCallback('inviteMember', function(source, data', function(result)
    -- Handle result
end)

-- Callback: checkSquadName", function(source, data
TriggerCallback('checkSquadName", function(source, data', function(result)
    -- Handle result
end)

-- Callback: getSquads", function(source, data
TriggerCallback('getSquads", function(source, data', function(result)
    -- Handle result
end)

-- Callback: createSquad", function(source, data
TriggerCallback('createSquad", function(source, data', function(result)
    -- Handle result
end)

-- Callback: sendMessage', function(source, data
TriggerCallback('sendMessage', function(source, data', function(result)
    -- Handle result
end)

-- Callback: getMessages', function(source, data
TriggerCallback('getMessages', function(source, data', function(result)
    -- Handle result
end)

-- Callback: getMembers", function(source, data
TriggerCallback('getMembers", function(source, data', function(result)
    -- Handle result
end)

-- Callback: joinSquad", function(source, data
TriggerCallback('joinSquad", function(source, data', function(result)
    -- Handle result
end)

-- Callback: leaveSquad", function(source, data
TriggerCallback('leaveSquad", function(source, data', function(result)
    -- Handle result
end)

-- Callback: deleteSquad", function(source, data
TriggerCallback('deleteSquad", function(source, data', function(result)
    -- Handle result
end)

-- Callback: getSquadSettings", function(source
TriggerCallback('getSquadSettings", function(source', function(result)
    -- Handle result
end)

-- Callback: updateSquadSettings", function(source, data
TriggerCallback('updateSquadSettings", function(source, data', function(result)
    -- Handle result
end)

-- Callback: getPlayers", function(source
TriggerCallback('getPlayers", function(source', function(result)
    -- Handle result
end)

-- Callback: kickMember', function(source, data
TriggerCallback('kickMember', function(source, data', function(result)
    -- Handle result
end)

-- Callback: getSquadSettings', function(source
TriggerCallback('getSquadSettings', function(source', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-squad-remake
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
