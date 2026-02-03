# Gfx Attachment

## Installation

### 1. Copy Files
```bash
# Copy gfx-attachment folder to your resources directory
cp -r gfx-attachment /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-attachment
```

### 3. Dependencies
- ox_inventory or ox_lib (detected)

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-attachment:client:open
TriggerEvent('gfx-attachment:client:open', ...)

```

---

## Exports

```lua
exports['gfx-attachment']:codem-inventory(...)
exports['gfx-attachment']:es_extended(...)
exports['gfx-attachment']:gfx-inventory(...)
exports['gfx-attachment']:ghmattimysql(...)
exports['gfx-attachment']:ox_inventory(...)
exports['gfx-attachment']:oxmysql(...)
exports['gfx-attachment']:ps-inventory(...)
exports['gfx-attachment']:qb-core(...)
exports['gfx-attachment']:qb-inventory(...)
exports['gfx-attachment']:qb-target(...)
exports['gfx-attachment']:qs-inventory(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/bench` | - |
| `/removeattachments` | - |
| `/setattachments` | - |

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

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-attachment
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
