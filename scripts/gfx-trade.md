# Gfx Trade

## Installation

### 1. Copy Files
```bash
# Copy gfx-trade folder to your resources directory
cp -r gfx-trade /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-trade
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- gfx-trade:client:TradeRequest
TriggerEvent('gfx-trade:client:TradeRequest', ...)

-- gfx-trade:CloseMenu
TriggerEvent('gfx-trade:CloseMenu', ...)

-- gfx-trade:Open
TriggerEvent('gfx-trade:Open', ...)

-- gfx-trade:SetReadyStatus
TriggerEvent('gfx-trade:SetReadyStatus', ...)

-- gfx-trade:TradeAccepted
TriggerEvent('gfx-trade:TradeAccepted', ...)

-- gfx-trade:UpdateSelectedItems
TriggerEvent('gfx-trade:UpdateSelectedItems', ...)

```

### Server Events

```lua
-- gfx-trade:CloseMenu
TriggerServerEvent('gfx-trade:CloseMenu', ...)

-- gfx-trade:server:TradeResponse
TriggerServerEvent('gfx-trade:server:TradeResponse', ...)

```

---

## Exports

```lua
exports['gfx-trade']:es_extended(...)
exports['gfx-trade']:gfx-inventory(...)
exports['gfx-trade']:qb-core(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/getidentifier` | - |
| `/trade` | - |
| `/tradea` | - |
| `/traded` | - |

---

## Features

- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-trade
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
