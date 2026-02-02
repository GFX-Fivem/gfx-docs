# Gfx Radio

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-radio klasörünü resources/ dizinine kopyalayın
cp -r gfx-radio /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-radio
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
-- onResourceStop
TriggerEvent('onResourceStop', ...)

```

---

## Exports

```lua
exports['gfx-radio']:codem-inventory(...)
exports['gfx-radio']:es_extended(...)
exports['gfx-radio']:gfx-inventory(...)
exports['gfx-radio']:ghmattimysql(...)
exports['gfx-radio']:ox_inventory(...)
exports['gfx-radio']:oxmysql(...)
exports['gfx-radio']:ps-inventory(...)
exports['gfx-radio']:qb-core(...)
exports['gfx-radio']:qb-inventory(...)
exports['gfx-radio']:qs-inventory(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/gfx-radio` | - |

---

## Özellikler

- ✅ Client-side
- ✅ Server-side
- ✅ Shared modül

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-radio
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
