# Gfx Pvpchat

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-pvpchat klasörünü resources/ dizinine kopyalayın
cp -r gfx-pvpchat /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pvpchat
```

### 3. Bağımlılıklar
- ox_inventory veya ox_lib (tespit edildi)

---

## Konfigürasyon

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

## Events

### Client Events

```lua
-- chat:addMessage
TriggerEvent('chat:addMessage', ...)

-- chat:addSuggestions
TriggerEvent('chat:addSuggestions', ...)

-- chat:server:addSuggestions
TriggerEvent('chat:server:addSuggestions', ...)

-- chat:server:playerMuted
TriggerEvent('chat:server:playerMuted', ...)

-- chat:server:unMutePlayer
TriggerEvent('chat:server:unMutePlayer', ...)

-- gfx-crew:receiveMessage
TriggerEvent('gfx-crew:receiveMessage', ...)

-- newMessage
TriggerEvent('newMessage', ...)

```

---

## Exports

```lua
exports['gfx-pvpchat']:codem-inventory(...)
exports['gfx-pvpchat']:es_extended(...)
exports['gfx-pvpchat']:gfx-crew(...)
exports['gfx-pvpchat']:gfx-inventory(...)
exports['gfx-pvpchat']:ghmattimysql(...)
exports['gfx-pvpchat']:ox_inventory(...)
exports['gfx-pvpchat']:oxmysql(...)
exports['gfx-pvpchat']:ps-inventory(...)
exports['gfx-pvpchat']:qb-core(...)
exports['gfx-pvpchat']:qb-inventory(...)
exports['gfx-pvpchat']:qs-inventory(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/changeMode` | - |
| `/chat` | - |
| `/testseend` | - |

---

## Callbacks

```lua
-- chat:mutePlayer
TriggerCallback('chat:mutePlayer', function(result)
    -- handle result
end)

-- chat:unmutePlayer
TriggerCallback('chat:unmutePlayer', function(result)
    -- handle result
end)

-- getColor
TriggerCallback('getColor', function(result)
    -- handle result
end)

-- getUsers
TriggerCallback('getUsers', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ NUI Arayüzü
- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-pvpchat
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
