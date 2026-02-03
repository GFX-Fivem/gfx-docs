# Gfx Crew

## Installation

### 1. Copy Files
```bash
# Copy gfx-crew folder to your resources directory
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

## Events

### Client Events

```lua
-- gameEventTriggered
TriggerEvent('gameEventTriggered', ...)

-- gfx-crew:AddRelationShip
TriggerEvent('gfx-crew:AddRelationShip', ...)

-- gfx-crew:fetchProfileData
TriggerEvent('gfx-crew:fetchProfileData', ...)

-- gfx-crew:hasCrew
TriggerEvent('gfx-crew:hasCrew', ...)

-- gfx-crew:receiveAnnouncement
TriggerEvent('gfx-crew:receiveAnnouncement', ...)

-- gfx-crew:receiveMessage
TriggerEvent('gfx-crew:receiveMessage', ...)

-- gfx-crew:RemoveRelationShip
TriggerEvent('gfx-crew:RemoveRelationShip', ...)

-- gfx-crew:UpdateMembers
TriggerEvent('gfx-crew:UpdateMembers', ...)

-- gfx-crew:UpdateStats
TriggerEvent('gfx-crew:UpdateStats', ...)

-- gfx-deleteCrewBackUp
TriggerEvent('gfx-deleteCrewBackUp', ...)

```

### Server Events

```lua
-- gfx-crew:playerKilled
TriggerServerEvent('gfx-crew:playerKilled', ...)

```

---

## Exports

```lua
exports['gfx-crew']:gfx-lib(...)
exports['gfx-crew']:ghmattimysql(...)
exports['gfx-crew']:oxmysql(...)
```

---

## Commands

*No commands found*

---

## Callbacks

```lua
-- gfx-crew:addRank
TriggerCallback('gfx-crew:addRank', function(result)
    -- handle result
end)

-- gfx-crew:createCrew
TriggerCallback('gfx-crew:createCrew', function(result)
    -- handle result
end)

-- gfx-crew:deleteCrew
TriggerCallback('gfx-crew:deleteCrew', function(result)
    -- handle result
end)

-- gfx-crew:deleteRank
TriggerCallback('gfx-crew:deleteRank', function(result)
    -- handle result
end)

-- gfx-crew:fetchProfileData
TriggerCallback('gfx-crew:fetchProfileData', function(result)
    -- handle result
end)

-- gfx-crew:getActiveMemberData
TriggerCallback('gfx-crew:getActiveMemberData', function(result)
    -- handle result
end)

-- gfx-crew:getAnnouncements
TriggerCallback('gfx-crew:getAnnouncements', function(result)
    -- handle result
end)

-- gfx-crew:getBadgeCount
TriggerCallback('gfx-crew:getBadgeCount', function(result)
    -- handle result
end)

-- gfx-crew:getCrewInvites
TriggerCallback('gfx-crew:getCrewInvites', function(result)
    -- handle result
end)

-- gfx-crew:getCrewStats
TriggerCallback('gfx-crew:getCrewStats', function(result)
    -- handle result
end)

-- gfx-crew:getFirstCrewAndMember
TriggerCallback('gfx-crew:getFirstCrewAndMember', function(result)
    -- handle result
end)

-- gfx-crew:getLeaderboardData
TriggerCallback('gfx-crew:getLeaderboardData', function(result)
    -- handle result
end)

-- gfx-crew:getMemberCoords
TriggerCallback('gfx-crew:getMemberCoords', function(result)
    -- handle result
end)

-- gfx-crew:getMembers
TriggerCallback('gfx-crew:getMembers', function(result)
    -- handle result
end)

-- gfx-crew:getMembersForLoop
TriggerCallback('gfx-crew:getMembersForLoop', function(result)
    -- handle result
end)

-- gfx-crew:getMembersWithPrevCrew
TriggerCallback('gfx-crew:getMembersWithPrevCrew', function(result)
    -- handle result
end)

-- gfx-crew:getMessages
TriggerCallback('gfx-crew:getMessages', function(result)
    -- handle result
end)

-- gfx-crew:getPlayers
TriggerCallback('gfx-crew:getPlayers', function(result)
    -- handle result
end)

-- gfx-crew:getPublicCrews
TriggerCallback('gfx-crew:getPublicCrews', function(result)
    -- handle result
end)

-- gfx-crew:getRoles
TriggerCallback('gfx-crew:getRoles', function(result)
    -- handle result
end)

-- gfx-crew:getSettings
TriggerCallback('gfx-crew:getSettings', function(result)
    -- handle result
end)

-- gfx-crew:hasCrew
TriggerCallback('gfx-crew:hasCrew', function(result)
    -- handle result
end)

-- gfx-crew:joinCrew
TriggerCallback('gfx-crew:joinCrew', function(result)
    -- handle result
end)

-- gfx-crew:kickMember
TriggerCallback('gfx-crew:kickMember', function(result)
    -- handle result
end)

-- gfx-crew:leaveCrew
TriggerCallback('gfx-crew:leaveCrew', function(result)
    -- handle result
end)

-- gfx-crew:savePerms
TriggerCallback('gfx-crew:savePerms', function(result)
    -- handle result
end)

-- gfx-crew:saveSettings
TriggerCallback('gfx-crew:saveSettings', function(result)
    -- handle result
end)

-- gfx-crew:sendAnnouncement
TriggerCallback('gfx-crew:sendAnnouncement', function(result)
    -- handle result
end)

-- gfx-crew:sendInvite
TriggerCallback('gfx-crew:sendInvite', function(result)
    -- handle result
end)

-- gfx-crew:sendMessage
TriggerCallback('gfx-crew:sendMessage', function(result)
    -- handle result
end)

-- gfx-crew:setRole
TriggerCallback('gfx-crew:setRole', function(result)
    -- handle result
end)

-- gfx-crew:setStatus
TriggerCallback('gfx-crew:setStatus', function(result)
    -- handle result
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
