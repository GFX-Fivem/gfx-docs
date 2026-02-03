# Gfx Tebexshop

## Installation

### 1. Copy Files
```bash
# Copy gfx-tebexshop folder to your resources directory
cp -r gfx-tebexshop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-tebexshop
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-tebexshop:updateUserData
TriggerEvent('gfx-tebexshop:updateUserData', ...)

```

---

## Exports

```lua
exports['gfx-tebexshop']:ghmattimysql(...)
exports['gfx-tebexshop']:oxmysql(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/givecoin` | - |
| `/packagebought` | - |
| `/tebexshop` | - |

---

## Callbacks

```lua
-- gfx-tebexshop:buyBoost
TriggerCallback('gfx-tebexshop:buyBoost', function(result)
    -- handle result
end)

-- gfx-tebexshop:buySkin
TriggerCallback('gfx-tebexshop:buySkin', function(result)
    -- handle result
end)

-- gfx-tebexshop:buyTier
TriggerCallback('gfx-tebexshop:buyTier', function(result)
    -- handle result
end)

-- gfx-tebexshop:claimCode
TriggerCallback('gfx-tebexshop:claimCode', function(result)
    -- handle result
end)

-- gfx-tebexshop:equipSkin
TriggerCallback('gfx-tebexshop:equipSkin', function(result)
    -- handle result
end)

-- gfx-tebexshop:getPlayerSkins
TriggerCallback('gfx-tebexshop:getPlayerSkins', function(result)
    -- handle result
end)

-- gfx-tebexshop:getTransactions
TriggerCallback('gfx-tebexshop:getTransactions', function(result)
    -- handle result
end)

-- gfx-tebexshop:getUserData
TriggerCallback('gfx-tebexshop:getUserData', function(result)
    -- handle result
end)

-- gfx-tebexshop:refundTransaction
TriggerCallback('gfx-tebexshop:refundTransaction', function(result)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-tebexshop
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
