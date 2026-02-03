# Gfx Chat

## Installation

### 1. Copy Files
```bash
# Copy gfx-chat folder to your resources directory
cp -r gfx-chat /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-chat
```

---

## Configuration

*No configuration file found*

---

## Events

### Client Events

```lua
-- chat:addMessage
TriggerEvent('chat:addMessage', ...)

-- gfx-chat:addMessage
TriggerEvent('gfx-chat:addMessage', ...)

-- gfx-chat:clear
TriggerEvent('gfx-chat:clear', ...)

```

---

## Exports

```lua
exports['gfx-chat']:gfx-base(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/changechatmode` | - |
| `/clear` | - |
| `/openchat` | - |

---

## Features

- ✅ Client-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-chat
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
