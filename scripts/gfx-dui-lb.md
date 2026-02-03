# Gfx Dui Lb

## Installation

### 1. Copy Files
```bash
cp -r gfx-dui-lb /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-dui-lb
```

---

## Configuration

### client_config.lua

```lua
Config = {
    Theme = {
        ["primary"] = '#ff4f22',
        ["primary-content"] = '#900000',
        ["primary-opacity"] = "rgba(255, 47, 47, 0.2)",
        ["secondary"] = "#FF2F2F",
        ["secondary-content"] = '#900000',
        ["secondary-opacity"] = "rgba(255, 47, 47, 0.2)",
    }
    -- Notify = function(source, message)
        
    -- end, -- Uncomment this line and paste your export to enable custom notifications
}

Citizen.CreateThread(function()
    Citizen.Wait(1)
    SendReactMessage('setConfig', Config)
end)
```

### server_config.lua

```lua
Config = {
    PhotoType = "steam",
    NoImage = "https://cdn.discordapp.com/attachments/736562375062192199/995301291976831026/noimage.png",
    DiscordBotToken = "YOUR_DISCORD_BOT_TOKEN",
    -- Notify = function(source, message)
        
    -- end, -- Uncomment this line and paste your export to enable custom notifications
}
```

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

| Command | Description |
|---------|-------------|
| `/boiler` | - |

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-dui-lb
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
