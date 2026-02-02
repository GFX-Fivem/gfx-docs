# Gfx Spawnselector

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-spawnselector klasörünü resources/ dizinine kopyalayın
cp -r gfx-spawnselector /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-spawnselector
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
    },
    -- Notify = function(source, message)
        
    -- end, -- Uncomment this line and paste your export to enable custom notifications
    WhiteboardModel = `gfx_whiteboard`, -- Harita gösterilecek whiteboard modeli
    WhiteboardCoords = vector4(1096.41, -3102.96, -39.0 - 0.95, 180.0), -- Whiteboard konumu
    CharacterPosition = vector4(1094.89, -3102.45, -39.0, 337.23), -- Karakter konumu
    CameraPosition = vector3(1096.05, -3100.83, -38.50), -- Kamera konumu
    CameraRotation = vector3(-7.5, 0.0, 180.0), -- Kamera rotasyonu
    
    SpawnLocations = {
        {
            name = "Legion Square",
            coords = vector3(213.94, -920.4, 30.69),
            heading = 320.0,
            blipSprite = 1,
            blipColor = 2,
            preview = {
                coords = vector3(213.94, -920.4, 50.69),
                rotation = vector3(-30.0, 0.0, 160.0)
            }
        },
        {
            name = "Sandy Shores",
            coords = vector3(1955.72, 3842.0, 31.99),
            heading = 29.71,
            blipSprite = 1, 
            blipColor = 2,
            preview = {
                coords = vector3(1955.72, 3842.0, 51.99),
                rotation = vector3(-30.0, 0.0, 29.71)
            }
        },
        -- Diğer spawn noktaları buraya eklenebilir
    }
}

Citizen.CreateThread(function()
    Citizen.Wait(1)
    SendReactMessage('setConfig', Config)

    for _, location in ipairs(Config.SpawnLocations) do
        location.description = GetStreetNameFromHashKey(GetStreetNameAtCoord(location.coords.x, location.coords.y, location.coords.z))
    end
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

*Event bulunamadı*

---

## Exports

```lua
exports['gfx-spawnselector']:codem-inventory(...)
exports['gfx-spawnselector']:es_extended(...)
exports['gfx-spawnselector']:gfx-inventory(...)
exports['gfx-spawnselector']:ghmattimysql(...)
exports['gfx-spawnselector']:ox_inventory(...)
exports['gfx-spawnselector']:oxmysql(...)
exports['gfx-spawnselector']:ps-inventory(...)
exports['gfx-spawnselector']:qb-core(...)
exports['gfx-spawnselector']:qb-inventory(...)
exports['gfx-spawnselector']:qs-inventory(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/boiler` | - |
| `/spawnselector` | - |

---

## Özellikler

- ✅ NUI Arayüzü
- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-spawnselector
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
