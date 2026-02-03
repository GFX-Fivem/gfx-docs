# Gfx Attachment Remake

## Installation

### 1. Copy Files
```bash
# Copy gfx-attachment-remake folder to your resources directory
cp -r gfx-attachment-remake /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-attachment-remake
```

### 3. Dependencies
- ox_inventory or ox_lib (detected)

---

## Configuration

*No configuration file found*

---

## Events

*No events found*

---

## Exports

```lua
exports['gfx-attachment-remake']:codem-inventory(...)
exports['gfx-attachment-remake']:es_extended(...)
exports['gfx-attachment-remake']:gfx-inventory(...)
exports['gfx-attachment-remake']:ghmattimysql(...)
exports['gfx-attachment-remake']:ox_inventory(...)
exports['gfx-attachment-remake']:oxmysql(...)
exports['gfx-attachment-remake']:ps-inventory(...)
exports['gfx-attachment-remake']:qb-core(...)
exports['gfx-attachment-remake']:qb-inventory(...)
exports['gfx-attachment-remake']:qs-inventory(...)
```

---

## Commands

*No commands found*

---

## Callbacks

```lua
-- getAttachments
TriggerCallback('getAttachments', function(result)
    -- handle result
end)

-- getWeapons
TriggerCallback('getWeapons', function(result)
    -- handle result
end)

-- saveWeapon
TriggerCallback('saveWeapon', function(result)
    -- handle result
end)

```

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side
- ✅ Shared module

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-attachment-remake
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
