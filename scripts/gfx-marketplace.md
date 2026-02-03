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

Server callbacks you can trigger:

```lua
-- Callback: gfx-marketplace:fetchItems", function(source, itemName
TriggerCallback('gfx-marketplace:fetchItems", function(source, itemName', function(result)
    -- Handle result
end)

-- Callback: gfx-marketplace:getCreateOfferPage", function(source, itemName
TriggerCallback('gfx-marketplace:getCreateOfferPage", function(source, itemName', function(result)
    -- Handle result
end)

-- Callback: gfx-marketplace:getMyOffers", function(source, itemName
TriggerCallback('gfx-marketplace:getMyOffers", function(source, itemName', function(result)
    -- Handle result
end)

-- Callback: gfx-marketplace:deleteOffer", function(source, data
TriggerCallback('gfx-marketplace:deleteOffer", function(source, data', function(result)
    -- Handle result
end)

-- Callback: gfx-marketplace:createOffer", function(source, data
TriggerCallback('gfx-marketplace:createOffer", function(source, data', function(result)
    -- Handle result
end)

-- Callback: gfx-marketplace:buyItem", function(source, data
TriggerCallback('gfx-marketplace:buyItem", function(source, data', function(result)
    -- Handle result
end)

-- Callback: gfx-marketplace:claim", function(source,data
TriggerCallback('gfx-marketplace:claim", function(source,data', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-marketplace
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
