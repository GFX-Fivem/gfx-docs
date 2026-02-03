# Gfx Arena

## Installation

### 1. Copy Files
```bash
# Copy gfx-arena folder to your resources directory
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

## Events

### Client Events

```lua
-- gfx-arena:LeaveLobby
TriggerEvent('gfx-arena:LeaveLobby', ...)

-- gfx-arena:MatchEnd
TriggerEvent('gfx-arena:MatchEnd', ...)

-- gfx-arena:notify
TriggerEvent('gfx-arena:notify', ...)

-- gfx-arena:ReadyTimer
TriggerEvent('gfx-arena:ReadyTimer', ...)

-- gfx-arena:RoundEnd
TriggerEvent('gfx-arena:RoundEnd', ...)

-- gfx-arena:RoundStart
TriggerEvent('gfx-arena:RoundStart', ...)

-- gfx-arena:StartMatch
TriggerEvent('gfx-arena:StartMatch', ...)

-- gfx-arena:UpdateCurrentLobby
TriggerEvent('gfx-arena:UpdateCurrentLobby', ...)

-- gfx-arena:UpdateHud
TriggerEvent('gfx-arena:UpdateHud', ...)

-- gfx-squad:AddRelationShip
TriggerEvent('gfx-squad:AddRelationShip', ...)

-- gfx-squad:RemoveRelationShip
TriggerEvent('gfx-squad:RemoveRelationShip', ...)

```

---

## Exports

```lua
exports['gfx-arena']:es_extended(...)
exports['gfx-arena']:ghmattimysql(...)
exports['gfx-arena']:oxmysql(...)
exports['gfx-arena']:qb-core(...)
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

```lua
-- getHomepageData
TriggerCallback('getHomepageData', function(result)
    -- handle result
end)

-- gfx-arena:CreateLobby
TriggerCallback('gfx-arena:CreateLobby', function(result)
    -- handle result
end)

-- gfx-arena:GetLobbies
TriggerCallback('gfx-arena:GetLobbies', function(result)
    -- handle result
end)

-- gfx-arena:JoinLobby
TriggerCallback('gfx-arena:JoinLobby', function(result)
    -- handle result
end)

-- gfx-arena:LeaveLobby
TriggerCallback('gfx-arena:LeaveLobby', function(result)
    -- handle result
end)

-- gfx-arena:SetReady
TriggerCallback('gfx-arena:SetReady', function(result)
    -- handle result
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
