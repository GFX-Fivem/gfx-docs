# Gfx Marketplace

## Installation

### 1. Copy Files
```bash
# Copy gfx-marketplace folder to your resources directory
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

## Events

### Client Events

```lua
-- gfx-marketplace:notify
TriggerEvent('gfx-marketplace:notify', ...)

-- gfx-marketplace:openUI
TriggerEvent('gfx-marketplace:openUI', ...)

```

---

## Exports

```lua
exports['gfx-marketplace']:ghmattimysql(...)
exports['gfx-marketplace']:oxmysql(...)
exports['gfx-marketplace']:qb-core(...)
```

---

## Commands

*No commands found*

---

## Callbacks

```lua
-- gfx-marketplace:buyItem
TriggerCallback('gfx-marketplace:buyItem', function(result)
    -- handle result
end)

-- gfx-marketplace:claim
TriggerCallback('gfx-marketplace:claim', function(result)
    -- handle result
end)

-- gfx-marketplace:createOffer
TriggerCallback('gfx-marketplace:createOffer', function(result)
    -- handle result
end)

-- gfx-marketplace:deleteOffer
TriggerCallback('gfx-marketplace:deleteOffer', function(result)
    -- handle result
end)

-- gfx-marketplace:fetchItems
TriggerCallback('gfx-marketplace:fetchItems', function(result)
    -- handle result
end)

-- gfx-marketplace:getCreateOfferPage
TriggerCallback('gfx-marketplace:getCreateOfferPage', function(result)
    -- handle result
end)

-- gfx-marketplace:getMyOffers
TriggerCallback('gfx-marketplace:getMyOffers', function(result)
    -- handle result
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
