# Gfx Vehicleshop

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-vehicleshop klasörünü resources/ dizinine kopyalayın
cp -r gfx-vehicleshop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-vehicleshop
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- aty_vehicleshop:client:openMenu
TriggerEvent('aty_vehicleshop:client:openMenu', ...)

-- aty_vehicleshop:client:sendStock
TriggerEvent('aty_vehicleshop:client:sendStock', ...)

-- aty_vehicleshop:setPlate
TriggerEvent('aty_vehicleshop:setPlate', ...)

-- esx:playerLoaded
TriggerEvent('esx:playerLoaded', ...)

-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- QBCore:Client:OnJobUpdate
TriggerEvent('QBCore:Client:OnJobUpdate', ...)

-- QBCore:Client:OnPlayerLoaded
TriggerEvent('QBCore:Client:OnPlayerLoaded', ...)

```

---

## Exports

```lua
exports['gfx-vehicleshop']:es_extended(...)
exports['gfx-vehicleshop']:ghmattimysql(...)
exports['gfx-vehicleshop']:mysql-async(...)
exports['gfx-vehicleshop']:oxmysql(...)
exports['gfx-vehicleshop']:qb-core(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-vehicleshop
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
