# Gfx Hud Aty

## Installation

### 1. Copy Files
```bash
# Copy gfx-hud_aty folder to your resources directory
cp -r gfx-hud_aty /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-hud_aty
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- aty_hud:client:toggleSeatBelt
TriggerEvent('aty_hud:client:toggleSeatBelt', ...)

-- aty_hud:sendNotify
TriggerEvent('aty_hud:sendNotify', ...)

-- aty_hud:setupNitro
TriggerEvent('aty_hud:setupNitro', ...)

-- aty_hud:stress:add
TriggerEvent('aty_hud:stress:add', ...)

-- aty_hud:stress:decrease
TriggerEvent('aty_hud:stress:decrease', ...)

-- aty_hud:toggle
TriggerEvent('aty_hud:toggle', ...)

-- consumables:client:Drink
TriggerEvent('consumables:client:Drink', ...)

-- consumables:client:Eat
TriggerEvent('consumables:client:Eat', ...)

-- esx_status:add
TriggerEvent('esx_status:add', ...)

-- mumble:SetVoiceData
TriggerEvent('mumble:SetVoiceData', ...)

-- pma-voice:setTalkingMode
TriggerEvent('pma-voice:setTalkingMode', ...)

-- SaltyChat_TalkStateChanged
TriggerEvent('SaltyChat_TalkStateChanged', ...)

-- SaltyChat_VoiceRangeChanged
TriggerEvent('SaltyChat_VoiceRangeChanged', ...)

```

---

## Exports

```lua
exports['gfx-hud_aty']:es_extended(...)
exports['gfx-hud_aty']:qb-core(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/-togglenitro` | - |
| `/+togglenitro` | - |
| `/togglecruisecontrol` | - |
| `/toggleseatbelt` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-hud_aty
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
