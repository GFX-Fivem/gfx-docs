# Gfx Squad Remake

## Installation

### 1. Copy Files
```bash
# Copy gfx-squad-remake folder to your resources directory
cp -r gfx-squad-remake /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-squad-remake
```

### 3. Dependencies
- ox_inventory or ox_lib (detected)

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

## Events

### Client Events

```lua
-- gfx-squad:AddRelationShip
TriggerEvent('gfx-squad:AddRelationShip', ...)

-- gfx-squad:RemoveRelationShip
TriggerEvent('gfx-squad:RemoveRelationShip', ...)

-- gfx-squad:updateUnseenCount
TriggerEvent('gfx-squad:updateUnseenCount', ...)

-- kicked
TriggerEvent('kicked', ...)

-- memberGone
TriggerEvent('memberGone', ...)

-- newMessage
TriggerEvent('newMessage', ...)

-- setInviteCount
TriggerEvent('setInviteCount', ...)

-- squadDeleted
TriggerEvent('squadDeleted', ...)

-- updateMembers
TriggerEvent('updateMembers', ...)

```

### Server Events

```lua
-- gfx-squad:playerLoaded
TriggerServerEvent('gfx-squad:playerLoaded', ...)

```

---

## Exports

```lua
exports['gfx-squad-remake']:codem-inventory(...)
exports['gfx-squad-remake']:es_extended(...)
exports['gfx-squad-remake']:gfx-inventory(...)
exports['gfx-squad-remake']:gfx-lib(...)
exports['gfx-squad-remake']:ghmattimysql(...)
exports['gfx-squad-remake']:ox_inventory(...)
exports['gfx-squad-remake']:oxmysql(...)
exports['gfx-squad-remake']:ps-inventory(...)
exports['gfx-squad-remake']:qb-core(...)
exports['gfx-squad-remake']:qb-inventory(...)
exports['gfx-squad-remake']:qs-inventory(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/cm` | - |
| `/squad` | - |

---

## Callbacks

```lua
-- checkSquadName
TriggerCallback('checkSquadName', function(result)
    -- handle result
end)

-- createSquad
TriggerCallback('createSquad', function(result)
    -- handle result
end)

-- deleteSquad
TriggerCallback('deleteSquad', function(result)
    -- handle result
end)

-- getInvites
TriggerCallback('getInvites', function(result)
    -- handle result
end)

-- getMembers
TriggerCallback('getMembers', function(result)
    -- handle result
end)

-- getMessages
TriggerCallback('getMessages', function(result)
    -- handle result
end)

-- getPlayers
TriggerCallback('getPlayers', function(result)
    -- handle result
end)

-- getSquads
TriggerCallback('getSquads', function(result)
    -- handle result
end)

-- getSquadSettings
TriggerCallback('getSquadSettings', function(result)
    -- handle result
end)

-- gfx-crew:getMemberCoords
TriggerCallback('gfx-crew:getMemberCoords', function(result)
    -- handle result
end)

-- inviteMember
TriggerCallback('inviteMember', function(result)
    -- handle result
end)

-- joinSquad
TriggerCallback('joinSquad', function(result)
    -- handle result
end)

-- kickMember
TriggerCallback('kickMember', function(result)
    -- handle result
end)

-- leaveSquad
TriggerCallback('leaveSquad', function(result)
    -- handle result
end)

-- removeInvite
TriggerCallback('removeInvite', function(result)
    -- handle result
end)

-- sendMessage
TriggerCallback('sendMessage', function(result)
    -- handle result
end)

-- updateSquadSettings
TriggerCallback('updateSquadSettings', function(result)
    -- handle result
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
