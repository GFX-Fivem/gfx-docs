# Gfx Banking

## Installation

### 1. Copy Files
```bash
cp -r gfx-banking /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-banking
```

---

## Configuration

*No configuration file found*

---

## Exports

Exports that other scripts can call:

*No exports found*

---

## Events

Events that this script triggers (you can listen to these):

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-banking:CreateNewAccount')
AddEventHandler('gfx-banking:CreateNewAccount', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-banking:Deposit')
AddEventHandler('gfx-banking:Deposit', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-banking:SwitchAccount')
AddEventHandler('gfx-banking:SwitchAccount', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-banking:Transfer')
AddEventHandler('gfx-banking:Transfer', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-banking:transferSearch')
AddEventHandler('gfx-banking:transferSearch', function(...)
    -- Handle event
end)

-- Listen to this event on server
RegisterNetEvent('gfx-banking:Withdraw')
AddEventHandler('gfx-banking:Withdraw', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/debugmoney` | - |
| `/openbank` | - |
| `/transfertonewbank` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-banking
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
