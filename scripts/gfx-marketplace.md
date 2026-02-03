# Gfx Marketplace

## Installation

### 1. Copy Files
```bash
cp -r gfx-marketplace /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-marketplace
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

*No public events found*

---

## Commands

*No commands found*

---

## Callbacks

Server callbacks you can trigger from client:

```lua
-- Callback: gfx-marketplace:buyItem
TriggerCallback('gfx-marketplace:buyItem', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: gfx-marketplace:claim
TriggerCallback('gfx-marketplace:claim', function(result)
    -- Parameters to send: data
    -- Handle result
end, data)

-- Callback: gfx-marketplace:createOffer
TriggerCallback('gfx-marketplace:createOffer', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: gfx-marketplace:deleteOffer
TriggerCallback('gfx-marketplace:deleteOffer', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: gfx-marketplace:fetchItems
TriggerCallback('gfx-marketplace:fetchItems', function(result)
    -- Parameters to send:  itemName
    -- Handle result
end,  itemName)

-- Callback: gfx-marketplace:getCreateOfferPage
TriggerCallback('gfx-marketplace:getCreateOfferPage', function(result)
    -- Parameters to send:  itemName
    -- Handle result
end,  itemName)

-- Callback: gfx-marketplace:getMyOffers
TriggerCallback('gfx-marketplace:getMyOffers', function(result)
    -- Parameters to send:  itemName
    -- Handle result
end,  itemName)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-marketplace
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
