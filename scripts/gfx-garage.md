# Gfx Garage

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-garage klasörünü resources/ dizinine kopyalayın
cp -r gfx-garage /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-garage
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- gfx-garage:client:openGarage
TriggerEvent('gfx-garage:client:openGarage', ...)

-- QBCore:Player:SetPlayerData
TriggerEvent('QBCore:Player:SetPlayerData', ...)

```

---

## Exports

```lua
exports['gfx-garage']:es_extended(...)
exports['gfx-garage']:gfx-base(...)
exports['gfx-garage']:qb-core(...)
exports['gfx-garage']:qb-target(...)
```

---

## Komutlar

*Komut bulunamadı*

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-garage
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
