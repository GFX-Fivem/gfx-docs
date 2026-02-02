# Gfx Crafting Aty

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-crafting_aty klasörünü resources/ dizinine kopyalayın
cp -r gfx-crafting_aty /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-crafting_aty
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- aty_crafting:client:updatePlayerData
TriggerEvent('aty_crafting:client:updatePlayerData', ...)

-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- QBCore:Client:OnJobUpdate
TriggerEvent('QBCore:Client:OnJobUpdate', ...)

```

### Server Events

```lua
-- aty_crafting:server:craftEnded
TriggerServerEvent('aty_crafting:server:craftEnded', ...)

```

---

## Exports

```lua
exports['gfx-crafting_aty']:ghmattimysql(...)
exports['gfx-crafting_aty']:mysql-async(...)
exports['gfx-crafting_aty']:oxmysql(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/purchase_made_for_crafting` | - |

---

## Özellikler

- ✅ NUI Arayüzü
- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-crafting_aty
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
