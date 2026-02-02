# Gfx Killfeed

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-killfeed klasörünü resources/ dizinine kopyalayın
cp -r gfx-killfeed /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-killfeed
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

*Event bulunamadı*

---

## Exports

```lua
exports['gfx-killfeed']:codem-inventory(...)
exports['gfx-killfeed']:es_extended(...)
exports['gfx-killfeed']:gfx-inventory(...)
exports['gfx-killfeed']:ghmattimysql(...)
exports['gfx-killfeed']:ox_inventory(...)
exports['gfx-killfeed']:oxmysql(...)
exports['gfx-killfeed']:ps-inventory(...)
exports['gfx-killfeed']:qb-core(...)
exports['gfx-killfeed']:qb-inventory(...)
exports['gfx-killfeed']:qs-inventory(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/boiler` | - |

---

## Özellikler

- ✅ NUI Arayüzü
- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-killfeed
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
