# Gfx Busjob

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-busjob klasörünü resources/ dizinine kopyalayın
cp -r gfx-busjob /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-busjob
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- aty_busjob:client:toggleMenu
TriggerEvent('aty_busjob:client:toggleMenu', ...)

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
exports['gfx-busjob']:ox_target(...)
exports['gfx-busjob']:qb-target(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-busjob
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
