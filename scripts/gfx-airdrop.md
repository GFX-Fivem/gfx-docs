# Gfx Airdrop

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-airdrop klasörünü resources/ dizinine kopyalayın
cp -r gfx-airdrop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-airdrop
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
-- gfx-airdrop:Announce
TriggerEvent('gfx-airdrop:Announce', ...)

-- gfx-airdrop:client:OpenAirDrop
TriggerEvent('gfx-airdrop:client:OpenAirDrop', ...)

-- gfx-airdrop:client:OpenMenu
TriggerEvent('gfx-airdrop:client:OpenMenu', ...)

-- gfx-airdrop:CreateAirDrop
TriggerEvent('gfx-airdrop:CreateAirDrop', ...)

-- gfx-airdrop:DrawText
TriggerEvent('gfx-airdrop:DrawText', ...)

-- gfx-airdrop:Notify
TriggerEvent('gfx-airdrop:Notify', ...)

-- gfx-airdrop:RemoveDrop
TriggerEvent('gfx-airdrop:RemoveDrop', ...)

-- gfx-airdrop:setData
TriggerEvent('gfx-airdrop:setData', ...)

-- gfx-airdrop:update
TriggerEvent('gfx-airdrop:update', ...)

```

### Server Events

```lua
-- adminairdrop
TriggerServerEvent('adminairdrop', ...)

-- gfx-airdrop:server:OpenAirDrop
TriggerServerEvent('gfx-airdrop:server:OpenAirDrop', ...)

-- rush_eventManager:airdrop:server:AirDropEvent
TriggerServerEvent('rush_eventManager:airdrop:server:AirDropEvent', ...)

-- rush-airdrop:server:AirdropDisableEvent
TriggerServerEvent('rush-airdrop:server:AirdropDisableEvent', ...)

```

---

## Exports

```lua
exports['gfx-airdrop']:chat(...)
exports['gfx-airdrop']:codem-inventory(...)
exports['gfx-airdrop']:es_extended(...)
exports['gfx-airdrop']:gfx-inventory(...)
exports['gfx-airdrop']:ghmattimysql(...)
exports['gfx-airdrop']:ox_inventory(...)
exports['gfx-airdrop']:oxmysql(...)
exports['gfx-airdrop']:ps-inventory(...)
exports['gfx-airdrop']:qb-core(...)
exports['gfx-airdrop']:qb-inventory(...)
exports['gfx-airdrop']:qs-inventory(...)
exports['gfx-airdrop']:rush_base(...)
exports['gfx-airdrop']:rush_core(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
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

```lua
-- gfx-airdrop:server:CreateAirDrop
TriggerCallback('gfx-airdrop:server:CreateAirDrop', function(result)
    -- handle result
end)

-- gfx-airdrop:server:DeleteAirDrop
TriggerCallback('gfx-airdrop:server:DeleteAirDrop', function(result)
    -- handle result
end)

-- gfx-airdrop:server:GetAirDropItems
TriggerCallback('gfx-airdrop:server:GetAirDropItems', function(result)
    -- handle result
end)

-- gfx-airdrop:server:GetAirDrops
TriggerCallback('gfx-airdrop:server:GetAirDrops', function(result)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-airdrop
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
