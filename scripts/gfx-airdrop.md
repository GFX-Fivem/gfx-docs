# Gfx Airdrop

## Installation

### 1. Copy Files
```bash
cp -r gfx-airdrop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-airdrop
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

*No exports found*

---

## Events

Events that this script triggers (you can listen to these):

### Server Events

```lua
-- Listen to this event on server
RegisterNetEvent('gfx-airdrop:server:OpenAirDrop')
AddEventHandler('gfx-airdrop:server:OpenAirDrop', function(...)
    -- Handle event
end)

```

---

## Commands

| Command | Description |
|---------|-------------|
| `/admindrop` | - |
| `/airdrop` | - |
| `/airdropdelete` | - |
| `/airdrops` | - |
| `/cmddrop` | - |
| `/getdrops` | - |
| `/table` | - |
| `/test` | - |

---

## Callbacks

Server callbacks you can trigger from client:

```lua
-- Callback: gfx-airdrop:server:CreateAirDrop
TriggerCallback('gfx-airdrop:server:CreateAirDrop', function(result)
    -- Parameters to send:  data
    -- Handle result
end,  data)

-- Callback: gfx-airdrop:server:DeleteAirDrop
TriggerCallback('gfx-airdrop:server:DeleteAirDrop', function(result)
    -- Parameters to send:  id
    -- Handle result
end,  id)

-- Callback: gfx-airdrop:server:GetAirDropItems
TriggerCallback('gfx-airdrop:server:GetAirDropItems', function(result)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-airdrop
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
