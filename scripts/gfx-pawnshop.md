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

Server callbacks you can trigger from client:

```lua
-- Callback: GetShopDataForAll
TriggerCallback('GetShopDataForAll', function(result)
    -- Parameters to send:  index
    -- Handle result
end,  index)

-- Callback: GetShopDataForTrifles
TriggerCallback('GetShopDataForTrifles', function(result)
    -- Parameters to send:  index
    -- Handle result
end,  index)

-- Callback: GetUserDataForNpc
TriggerCallback('GetUserDataForNpc', function(result)
    -- Handle result
end)

-- Callback: ItemEdit
TriggerCallback('ItemEdit', function(result)
    -- Parameters to send:  itemIndex, shopIndex, selectType
    -- Handle result
end,  itemIndex, shopIndex, selectType)

-- Callback: SelledItem
TriggerCallback('SelledItem', function(result)
    -- Parameters to send:  itemIndex, shopIndex
    -- Handle result
end,  itemIndex, shopIndex)

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
