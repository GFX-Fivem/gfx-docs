# Gfx Racing

## Installation

### 1. Copy Files
```bash
# Copy gfx-racing folder to your resources directory
cp -r gfx-racing /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-racing
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- applytest
TriggerEvent('applytest', ...)

-- gfx-racing-client:CreateRace
TriggerEvent('gfx-racing-client:CreateRace', ...)

-- gfx-racing-client:RefreshActiveRaces
TriggerEvent('gfx-racing-client:RefreshActiveRaces', ...)

-- gfx-racing:Client:FinishRace
TriggerEvent('gfx-racing:Client:FinishRace', ...)

-- gfx-racing:NewRaceNotf
TriggerEvent('gfx-racing:NewRaceNotf', ...)

-- gfx-racing:notify
TriggerEvent('gfx-racing:notify', ...)

-- gfx-racing:RemoveRacing
TriggerEvent('gfx-racing:RemoveRacing', ...)

-- gfx-racing:SetMarker
TriggerEvent('gfx-racing:SetMarker', ...)

-- gfx-racing:SetRaceLeaderBoard
TriggerEvent('gfx-racing:SetRaceLeaderBoard', ...)

-- gfx-racing:StartRace
TriggerEvent('gfx-racing:StartRace', ...)

-- gfx-racing:StartRaceN
TriggerEvent('gfx-racing:StartRaceN', ...)

-- gfx-racing:updatenui
TriggerEvent('gfx-racing:updatenui', ...)

-- gfx-racing:UpdateRacers
TriggerEvent('gfx-racing:UpdateRacers', ...)

```

### Server Events

```lua
-- gfx-racing:StartServerRace
TriggerServerEvent('gfx-racing:StartServerRace', ...)

```

---

## Exports

```lua
exports['gfx-racing']:es_extended(...)
exports['gfx-racing']:gfx-lib(...)
exports['gfx-racing']:ghmattimysql(...)
exports['gfx-racing']:mysql-async(...)
exports['gfx-racing']:oxmysql(...)
exports['gfx-racing']:qb-core(...)
```

---

## Commands

*No commands found*

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-racing
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
