# Gfx Deathlog

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-deathlog klasörünü resources/ dizinine kopyalayın
cp -r gfx-deathlog /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-deathlog
```

### 3. Bağımlılıklar
- ox_inventory veya ox_lib (tespit edildi)

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- rush-deadlog:client:Report
TriggerEvent('rush-deadlog:client:Report', ...)

-- rush-deadlog:client:UpdateDeadLogs
TriggerEvent('rush-deadlog:client:UpdateDeadLogs', ...)

```

### Server Events

```lua
-- rush-deadlog:server:ReportDeadLog
TriggerServerEvent('rush-deadlog:server:ReportDeadLog', ...)

```

---

## Exports

```lua
exports['gfx-deathlog']:codem-inventory(...)
exports['gfx-deathlog']:es_extended(...)
exports['gfx-deathlog']:gfx-inventory(...)
exports['gfx-deathlog']:ghmattimysql(...)
exports['gfx-deathlog']:ox_inventory(...)
exports['gfx-deathlog']:oxmysql(...)
exports['gfx-deathlog']:ps-inventory(...)
exports['gfx-deathlog']:qb-core(...)
exports['gfx-deathlog']:qb-inventory(...)
exports['gfx-deathlog']:qs-inventory(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/deadlog` | - |
| `/report` | - |
| `/reports` | - |
| `/test3131` | - |

---

## Callbacks

```lua
-- getIdent
TriggerCallback('getIdent', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-deathlog
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
