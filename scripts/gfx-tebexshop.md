# Gfx Tebexshop

## Installation

### 1. Copy Files
```bash
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

## Exports

Exports that other scripts can call:

```lua
-- Export: GetPlayerCoins
local result = exports['gfx-tebexshop']:GetPlayerCoins()

-- Export: GetPlayerCoins
local result = exports['gfx-tebexshop']:GetPlayerCoins(source)

-- Export: GetPlayerTier
local result = exports['gfx-tebexshop']:GetPlayerTier()

-- Export: GetPlayerTier
local result = exports['gfx-tebexshop']:GetPlayerTier(source)

```

---

## Events

Events that this script triggers (you can listen to these):

*No public events found*

---

## Commands

| Command | Description |
|---------|-------------|
| `/givecoin` | - |
| `/packagebought` | - |
| `/tebexshop` | - |

---

## Callbacks

Server callbacks you can trigger:

```lua
-- Callback: gfx-tebexshop:getPlayerSkins', function(source
TriggerCallback('gfx-tebexshop:getPlayerSkins', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:claimCode', function(source, code
TriggerCallback('gfx-tebexshop:claimCode', function(source, code', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:getUserData", function(source
TriggerCallback('gfx-tebexshop:getUserData", function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:buyBoost', function(source, cardData
TriggerCallback('gfx-tebexshop:buyBoost', function(source, cardData', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:buyTier', function(source, id
TriggerCallback('gfx-tebexshop:buyTier', function(source, id', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:buySkin', function(source, skinId
TriggerCallback('gfx-tebexshop:buySkin', function(source, skinId', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:equipSkin', function(source, skinId
TriggerCallback('gfx-tebexshop:equipSkin', function(source, skinId', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:getTransactions', function(source
TriggerCallback('gfx-tebexshop:getTransactions', function(source', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:refundTransaction', function(source, transactionId
TriggerCallback('gfx-tebexshop:refundTransaction', function(source, transactionId', function(result)
    -- Handle result
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
