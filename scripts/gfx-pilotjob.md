# Gfx Pilotjob

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-pilotjob klasörünü resources/ dizinine kopyalayın
cp -r gfx-pilotjob /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pilotjob
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-pilotjob:client:CallCops
TriggerEvent('gfx-pilotjob:client:CallCops', ...)

-- missionFailed
TriggerEvent('missionFailed', ...)

```

---

## Exports

```lua
exports['gfx-pilotjob']:es_extended(...)
exports['gfx-pilotjob']:qb-core(...)
```

---

## Komutlar

*Komut bulunamadı*

---

## Callbacks

```lua
-- gfx:server:getInfos
TriggerCallback('gfx:server:getInfos', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-pilotjob
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
