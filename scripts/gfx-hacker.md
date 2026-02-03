# Gfx Hacker

## Installation

### 1. Copy Files
```bash
# Copy gfx-hacker folder to your resources directory
cp -r gfx-hacker /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-hacker
```

### 3. Dependencies
- ox_inventory or ox_lib (detected)

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

## Events

*No events found*

---

## Exports

```lua
exports['gfx-hacker']:codem-inventory(...)
exports['gfx-hacker']:es_extended(...)
exports['gfx-hacker']:gfx-inventory(...)
exports['gfx-hacker']:ghmattimysql(...)
exports['gfx-hacker']:ox_inventory(...)
exports['gfx-hacker']:oxmysql(...)
exports['gfx-hacker']:ps-inventory(...)
exports['gfx-hacker']:qb-core(...)
exports['gfx-hacker']:qb-inventory(...)
exports['gfx-hacker']:qs-inventory(...)
```

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

- **GitHub:** https://github.com/gfx-fivem/gfx-hacker
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
