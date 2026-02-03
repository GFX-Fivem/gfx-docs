# Gfx Pvpchat

## Installation

### 1. Copy Files
```bash
cp -r gfx-pvpchat /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pvpchat
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
}

Citizen.CreateThread(function()
    Citizen.Wait(1)
    SendReactMessage('setConfig', Config)
end)

local crewScript = GetResourceState("gfx-crew") == "started" and "gfx-crew"
function GetCrewId()
    if crewScript == "gfx-crew" then
        local crewData = exports["gfx-crew"]:GetPlayerCrewData()
        return crewData and crewData.crewId
    else
        return nil -- you can put your crew exports and logic here
    end
end
  
function GetSquadId()
    return 1
end
  
function IsAdmin()
    return IsAceAllowed("admin")
end
```

### server_config.lua

```lua
Config = {
    PhotoType = "steam",
    NoImage = "https://cdn.discordapp.com/attachments/736562375062192199/995301291976831026/noimage.png",
    DiscordBotToken = "YOUR_DISCORD_BOT_TOKEN",
}
```

---

## Exports

Exports that other scripts can call:

```lua
-- Export: GetPlayerColor
local result = exports['gfx-pvpchat']:GetPlayerColor()

-- Export: GetPlayerColor
local result = exports['gfx-pvpchat']:GetPlayerColor(player)

```

---

## Events

Events that this script triggers (you can listen to these):

*No public events found*

---

## Commands

| Command | Description |
|---------|-------------|
| `/changeMode` | - |
| `/chat` | - |
| `/testseend` | - |

---

## Callbacks

Server callbacks you can trigger:

```lua
-- Callback: getUsers', function(source
TriggerCallback('getUsers', function(source', function(result)
    -- Handle result
end)

-- Callback: chat:mutePlayer', function(source, data
TriggerCallback('chat:mutePlayer', function(source, data', function(result)
    -- Handle result
end)

-- Callback: chat:unmutePlayer', function(source, data
TriggerCallback('chat:unmutePlayer', function(source, data', function(result)
    -- Handle result
end)

-- Callback: getColor', function(source, target
TriggerCallback('getColor', function(source, target', function(result)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-pvpchat
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
