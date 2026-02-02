# Gfx Gps

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-gps klasörünü resources/ dizinine kopyalayın
cp -r gfx-gps /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-gps
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- aty_gps:client:disableGps
TriggerEvent('aty_gps:client:disableGps', ...)

-- aty_gps:client:notify
TriggerEvent('aty_gps:client:notify', ...)

-- aty_gps:client:refresh
TriggerEvent('aty_gps:client:refresh', ...)

-- aty_gps:client:usedGps
TriggerEvent('aty_gps:client:usedGps', ...)

-- esx:playerLoaded
TriggerEvent('esx:playerLoaded', ...)

-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- QBCore:Client:OnJobUpdate
TriggerEvent('QBCore:Client:OnJobUpdate', ...)

-- QBCore:Client:OnPlayerLoaded
TriggerEvent('QBCore:Client:OnPlayerLoaded', ...)

```

### Server Events

```lua
-- aty_gps:server:openGps
TriggerServerEvent('aty_gps:server:openGps', ...)

-- aty_gps:server:saveCode
TriggerServerEvent('aty_gps:server:saveCode', ...)

-- esx:setJob
TriggerServerEvent('esx:setJob', ...)

-- QBCore:Server:OnJobUpdate
TriggerServerEvent('QBCore:Server:OnJobUpdate', ...)

```

---

## Exports

*Export bulunamadı*

---

## Komutlar

*Komut bulunamadı*

---

## Callbacks

```lua
-- aty_gps:server:getCoords
TriggerCallback('aty_gps:server:getCoords', function(result)
    -- handle result
end)

-- aty_gps:server:getData
TriggerCallback('aty_gps:server:getData', function(result)
    -- handle result
end)

-- aty_gps:server:spectate
TriggerCallback('aty_gps:server:spectate', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-gps
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
