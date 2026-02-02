# Gfx Christmastruck

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-christmastruck klasörünü resources/ dizinine kopyalayın
cp -r gfx-christmastruck /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-christmastruck
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-christmasgifts:client:addBlipToTruck
TriggerEvent('gfx-christmasgifts:client:addBlipToTruck', ...)

-- gfx-christmasgifts:client:createGift
TriggerEvent('gfx-christmasgifts:client:createGift', ...)

-- gfx-christmasgifts:client:pickupGift
TriggerEvent('gfx-christmasgifts:client:pickupGift', ...)

-- gfx-christmasgifts:client:spawnGiftTruck
TriggerEvent('gfx-christmasgifts:client:spawnGiftTruck', ...)

```

---

## Exports

```lua
exports['gfx-christmastruck']:es_extended(...)
exports['gfx-christmastruck']:qb-core(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/createBox` | - |
| `/spawnGiftTruck` | - |

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-christmastruck
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
