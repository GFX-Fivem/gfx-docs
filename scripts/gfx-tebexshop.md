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

Server callbacks you can trigger from client:

```lua
-- Callback: gfx-tebexshop:buyBoost
TriggerCallback('gfx-tebexshop:buyBoost', function(result)
    -- Parameters to send:  cardData
    -- Handle result
end,  cardData)

-- Callback: gfx-tebexshop:buySkin
TriggerCallback('gfx-tebexshop:buySkin', function(result)
    -- Parameters to send:  skinId
    -- Handle result
end,  skinId)

-- Callback: gfx-tebexshop:buyTier
TriggerCallback('gfx-tebexshop:buyTier', function(result)
    -- Parameters to send:  id
    -- Handle result
end,  id)

-- Callback: gfx-tebexshop:claimCode
TriggerCallback('gfx-tebexshop:claimCode', function(result)
    -- Parameters to send:  code
    -- Handle result
end,  code)

-- Callback: gfx-tebexshop:equipSkin
TriggerCallback('gfx-tebexshop:equipSkin', function(result)
    -- Parameters to send:  skinId
    -- Handle result
end,  skinId)

-- Callback: gfx-tebexshop:getPlayerSkins
TriggerCallback('gfx-tebexshop:getPlayerSkins', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:getTransactions
TriggerCallback('gfx-tebexshop:getTransactions', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:getUserData
TriggerCallback('gfx-tebexshop:getUserData', function(result)
    -- Handle result
end)

-- Callback: gfx-tebexshop:refundTransaction
TriggerCallback('gfx-tebexshop:refundTransaction', function(result)
    -- Parameters to send:  transactionId
    -- Handle result
end,  transactionId)

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
