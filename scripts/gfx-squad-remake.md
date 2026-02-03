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

Server callbacks you can trigger from client:

```lua
-- Callback: checkSquadName
TriggerCallback('checkSquadName', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: createSquad
TriggerCallback('createSquad', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: deleteSquad
TriggerCallback('deleteSquad', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: getInvites
TriggerCallback('getInvites', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: getMembers
TriggerCallback('getMembers', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: getMessages
TriggerCallback('getMessages', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: getPlayers
TriggerCallback('getPlayers', function(result)
    -- Handle result
end)

-- Callback: getSquads
TriggerCallback('getSquads', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: getSquadSettings
TriggerCallback('getSquadSettings', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getMemberCoords
TriggerCallback('gfx-crew:getMemberCoords', function(result)
    -- Parameters to send:  member
    -- Handle result
end,  member)

-- Callback: inviteMember
TriggerCallback('inviteMember', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: joinSquad
TriggerCallback('joinSquad', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: kickMember
TriggerCallback('kickMember', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: leaveSquad
TriggerCallback('leaveSquad', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: removeInvite
TriggerCallback('removeInvite', function(result)
    -- Parameters to send:  id
    -- Handle result
end,  id)

-- Callback: sendMessage
TriggerCallback('sendMessage', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: updateSquadSettings
TriggerCallback('updateSquadSettings', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

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
