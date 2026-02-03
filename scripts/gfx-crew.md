# Gfx Crew

## Installation

### 1. Copy Files
```bash
cp -r gfx-crew /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-crew
```

---

## Configuration

*No configuration file found*

---

## Exports

Exports that other scripts can call:

```lua
-- Export: AddBadgeToMember
local result = exports['gfx-crew']:AddBadgeToMember(player, badge)

-- Export: GetPlayerCrewData
local result = exports['gfx-crew']:GetPlayerCrewData()

-- Export: GetPlayerCrewData
local result = exports['gfx-crew']:GetPlayerCrewData(source)

-- Export: GetPlayerCrewMembers
local result = exports['gfx-crew']:GetPlayerCrewMembers(source)

-- Export: GetPlayerCrewMembersForMarker
local result = exports['gfx-crew']:GetPlayerCrewMembersForMarker(source)

-- Export: GetPlayerCrewName
local result = exports['gfx-crew']:GetPlayerCrewName(source)

-- Export: IsMenuVisible
local result = exports['gfx-crew']:IsMenuVisible()

```

---

## Events

Events that this script triggers (you can listen to these):

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-crew:playerKilled')
AddEventHandler('gfx-crew:playerKilled', function(...)
    -- Handle event
end)

```

---

## Commands

*No commands found*

---

## Callbacks

Server callbacks you can trigger:

```lua
-- Callback: gfx-crew:hasCrew', function(source
TriggerCallback('gfx-crew:hasCrew', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:createCrew", function(source, data
TriggerCallback('gfx-crew:createCrew", function(source, data', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getPublicCrews", function(source
TriggerCallback('gfx-crew:getPublicCrews", function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:fetchProfileData', function(source
TriggerCallback('gfx-crew:fetchProfileData', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getBadgeCount', function(source
TriggerCallback('gfx-crew:getBadgeCount', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getCrewStats', function(source
TriggerCallback('gfx-crew:getCrewStats', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getMessages', function(source
TriggerCallback('gfx-crew:getMessages', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getMembers', function(source
TriggerCallback('gfx-crew:getMembers', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getLeaderboardData', function(source, isCrew
TriggerCallback('gfx-crew:getLeaderboardData', function(source, isCrew', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getMemberCoords', function(source, member
TriggerCallback('gfx-crew:getMemberCoords', function(source, member', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getFirstCrewAndMember', function(
TriggerCallback('gfx-crew:getFirstCrewAndMember', function(', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getSettings', function(source
TriggerCallback('gfx-crew:getSettings', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getRoles', function(source
TriggerCallback('gfx-crew:getRoles', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:deleteRank', function(source, id
TriggerCallback('gfx-crew:deleteRank', function(source, id', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getMembersWithPrevCrew', function(source, id
TriggerCallback('gfx-crew:getMembersWithPrevCrew', function(source, id', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getAnnouncements', function(source
TriggerCallback('gfx-crew:getAnnouncements', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getActiveMemberData', function(source, id
TriggerCallback('gfx-crew:getActiveMemberData', function(source, id', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:sendAnnouncement', function(source, message
TriggerCallback('gfx-crew:sendAnnouncement', function(source, message', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:savePerms', function(source, permissions, roleId
TriggerCallback('gfx-crew:savePerms', function(source, permissions, roleId', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:addRank', function(source, data
TriggerCallback('gfx-crew:addRank', function(source, data', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:sendMessage', function(source, message
TriggerCallback('gfx-crew:sendMessage', function(source, message', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:setStatus', function(source
TriggerCallback('gfx-crew:setStatus', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:joinCrew', function(source, crewId, isInvite
TriggerCallback('gfx-crew:joinCrew', function(source, crewId, isInvite', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getPlayers', function(source
TriggerCallback('gfx-crew:getPlayers', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:sendInvite', function(source, inviteList
TriggerCallback('gfx-crew:sendInvite', function(source, inviteList', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getCrewInvites', function(source
TriggerCallback('gfx-crew:getCrewInvites', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:saveSettings', function(source, settings
TriggerCallback('gfx-crew:saveSettings', function(source, settings', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:leaveCrew', function(source
TriggerCallback('gfx-crew:leaveCrew', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:kickMember', function(source, id
TriggerCallback('gfx-crew:kickMember', function(source, id', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:deleteCrew', function(source
TriggerCallback('gfx-crew:deleteCrew', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getMembersForLoop', function(source
TriggerCallback('gfx-crew:getMembersForLoop', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:setRole', function(source, id, role
TriggerCallback('gfx-crew:setRole', function(source, id, role', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-crew
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
