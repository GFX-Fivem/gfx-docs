# Gfx Deathcam

## Installation

### 1. Copy Files
```bash
cp -r gfx-deathcam /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-deathcam
```

---

## Configuration

*No configuration file found*

---

## Exports

Exports that other scripts can call:

```lua
-- Export: GetConfig
local result = exports['gfx-deathcam']:GetConfig()

-- Export: GetIdentifier
local result = exports['gfx-deathcam']:GetIdentifier(source, type)

```

---

## Events

Events that this script triggers (you can listen to these):

*No public events found*

---

## Commands

| Command | Description |
|---------|-------------|
| `/kill` | - |

---

## Callbacks

Server callbacks you can trigger:

```lua
-- Callback: getPlayerPP", function(source, id
TriggerCallback('getPlayerPP", function(source, id', function(result)
    -- Handle result
end)

```

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-deathcam
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
