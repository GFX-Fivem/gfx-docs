# Gfx Airdrop

## Kurulum

### 1. Dosyaları Kopyala
```
gfx-airdrop klasörünü resources/ dizinine kopyalayın
```

### 2. server.cfg
```cfg
ensure gfx-airdrop
```

---

## Konfigürasyon

### Client Config

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

### Server Config

```lua
Config = {
    PhotoType = "steam",
    NoImage = "https://cdn.discordapp.com/attachments/736562375062192199/995301291976831026/noimage.png",
    DiscordBotToken = "YOUR_DISCORD_BOT_TOKEN",
}
```

---

## Özellikler

- NUI arayüzü
- Client-side işlemler
- Server-side işlemler

---

## Notlar

Detaylı konfigürasyon ve events için kaynak kodunu inceleyiniz:
- GitHub: https://github.com/gfx-fivem/gfx-airdrop
