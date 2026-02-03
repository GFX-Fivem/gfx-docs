# Gfx Gunmenu

## Installation

### 1. Copy Files
```bash
# Copy gfx-gunmenu folder to your resources directory
cp -r gfx-gunmenu /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-gunmenu
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
-- gfx-gunmenu:openMenu
TriggerEvent('gfx-gunmenu:openMenu', ...)

```

---

## Exports

```lua
exports['gfx-gunmenu']:es_extended(...)
exports['gfx-gunmenu']:gfx-inventory(...)
exports['gfx-gunmenu']:ox_inventory(...)
exports['gfx-gunmenu']:qb-core(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/checkgun` | - |
| `/openmenu` | - |

---

## Callbacks

```lua
-- gfx-gun:validItem
TriggerCallback('gfx-gun:validItem', function(result)
    -- handle result
end)

-- gfx-mdt:buyWeapon
TriggerCallback('gfx-mdt:buyWeapon', function(result)
    -- handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-gunmenu
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
