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

Server callbacks you can trigger from client:

```lua
-- Callback: gfx-crew:addRank
TriggerCallback('gfx-crew:addRank', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: gfx-crew:createCrew
TriggerCallback('gfx-crew:createCrew', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: gfx-crew:deleteCrew
TriggerCallback('gfx-crew:deleteCrew', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:deleteRank
TriggerCallback('gfx-crew:deleteRank', function(result)
    -- Parameters to send:  id
    -- Handle result
end,  id)

-- Callback: gfx-crew:fetchProfileData
TriggerCallback('gfx-crew:fetchProfileData', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getActiveMemberData
TriggerCallback('gfx-crew:getActiveMemberData', function(result)
    -- Parameters to send:  id
    -- Handle result
end,  id)

-- Callback: gfx-crew:getAnnouncements
TriggerCallback('gfx-crew:getAnnouncements', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getBadgeCount
TriggerCallback('gfx-crew:getBadgeCount', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getCrewInvites
TriggerCallback('gfx-crew:getCrewInvites', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getCrewStats
TriggerCallback('gfx-crew:getCrewStats', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getFirstCrewAndMember
TriggerCallback('gfx-crew:getFirstCrewAndMember', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getLeaderboardData
TriggerCallback('gfx-crew:getLeaderboardData', function(result)
    -- Parameters to send:  isCrew
    -- Handle result
end,  isCrew)

-- Callback: gfx-crew:getMemberCoords
TriggerCallback('gfx-crew:getMemberCoords', function(result)
    -- Parameters to send:  member
    -- Handle result
end,  member)

-- Callback: gfx-crew:getMembers
TriggerCallback('gfx-crew:getMembers', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getMembersForLoop
TriggerCallback('gfx-crew:getMembersForLoop', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getMembersWithPrevCrew
TriggerCallback('gfx-crew:getMembersWithPrevCrew', function(result)
    -- Parameters to send:  id
    -- Handle result
end,  id)

-- Callback: gfx-crew:getMessages
TriggerCallback('gfx-crew:getMessages', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getPlayers
TriggerCallback('gfx-crew:getPlayers', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getPublicCrews
TriggerCallback('gfx-crew:getPublicCrews', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getRoles
TriggerCallback('gfx-crew:getRoles', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:getSettings
TriggerCallback('gfx-crew:getSettings', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:hasCrew
TriggerCallback('gfx-crew:hasCrew', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:joinCrew
TriggerCallback('gfx-crew:joinCrew', function(result)
    -- Parameters to send:  crewId, isInvite
    -- Handle result
end,  crewId, isInvite)

-- Callback: gfx-crew:kickMember
TriggerCallback('gfx-crew:kickMember', function(result)
    -- Parameters to send:  id
    -- Handle result
end,  id)

-- Callback: gfx-crew:leaveCrew
TriggerCallback('gfx-crew:leaveCrew', function(result)
    -- Handle result
end)

-- Callback: gfx-crew:savePerms
TriggerCallback('gfx-crew:savePerms', function(result)
    -- Parameters to send:  permissions, roleId
    -- Handle result
end,  permissions, roleId)

-- Callback: gfx-crew:saveSettings
TriggerCallback('gfx-crew:saveSettings', function(result)
    -- Parameters to send:  settings
    -- Handle result
end,  settings)

-- Callback: gfx-crew:sendAnnouncement
TriggerCallback('gfx-crew:sendAnnouncement', function(result)
    -- Parameters to send:  message
    -- Handle result
end,  message)

-- Callback: gfx-crew:sendInvite
TriggerCallback('gfx-crew:sendInvite', function(result)
    -- Parameters to send:  inviteList
    -- Handle result
end,  inviteList)

-- Callback: gfx-crew:sendMessage
TriggerCallback('gfx-crew:sendMessage', function(result)
    -- Parameters to send:  message
    -- Handle result
end,  message)

-- Callback: gfx-crew:setRole
TriggerCallback('gfx-crew:setRole', function(result)
    -- Parameters to send:  id, role
    -- Handle result
end,  id, role)

-- Callback: gfx-crew:setStatus
TriggerCallback('gfx-crew:setStatus', function(result)
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
