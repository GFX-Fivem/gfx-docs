# Gfx Giveaway

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-giveaway klasörünü resources/ dizinine kopyalayın
cp -r gfx-giveaway /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-giveaway
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- aty_giveaway:client:finished
TriggerEvent('aty_giveaway:client:finished', ...)

-- aty_giveaway:client:notify
TriggerEvent('aty_giveaway:client:notify', ...)

-- aty_giveaway:client:open
TriggerEvent('aty_giveaway:client:open', ...)

-- aty_giveaway:client:refreshPlayers
TriggerEvent('aty_giveaway:client:refreshPlayers', ...)

-- aty_giveaway:client:startGiveaway
TriggerEvent('aty_giveaway:client:startGiveaway', ...)

-- aty_giveaway:client:updateTime
TriggerEvent('aty_giveaway:client:updateTime', ...)

```

### Server Events

```lua
-- aty_giveaway:server:joinGiveaway
TriggerServerEvent('aty_giveaway:server:joinGiveaway', ...)

-- aty_giveaway:server:startGiveaway
TriggerServerEvent('aty_giveaway:server:startGiveaway', ...)

-- esx:playerLoaded
TriggerServerEvent('esx:playerLoaded', ...)

-- QBCore:Server:OnPlayerLoaded
TriggerServerEvent('QBCore:Server:OnPlayerLoaded', ...)

```

---

## Exports

*Export bulunamadı*

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/focus` | - |
| `/giveaway` | - |

---

## Özellikler

- ✅ NUI Arayüzü
- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-giveaway
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
