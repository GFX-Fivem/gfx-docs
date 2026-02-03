# Gfx Pawnshop

## Installation

### 1. Copy Files
```bash
cp -r gfx-pawnshop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pawnshop
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
-- Callback: SelledItem", function(source, itemIndex, shopIndex
TriggerCallback('SelledItem", function(source, itemIndex, shopIndex', function(result)
    -- Handle result
end)

-- Callback: ItemEdit", function(source, itemIndex, shopIndex, selectType
TriggerCallback('ItemEdit", function(source, itemIndex, shopIndex, selectType', function(result)
    -- Handle result
end)

-- Callback: GetUserDataForNpc", function(source
TriggerCallback('GetUserDataForNpc", function(source', function(result)
    -- Handle result
end)

-- Callback: GetShopDataForTrifles", function(source, index
TriggerCallback('GetShopDataForTrifles", function(source, index', function(result)
    -- Handle result
end)

-- Callback: GetShopDataForAll", function(source, index
TriggerCallback('GetShopDataForAll", function(source, index', function(result)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-pawnshop
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
