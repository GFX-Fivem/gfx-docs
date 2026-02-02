# Gfx Redzone

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-redzone klasörünü resources/ dizinine kopyalayın
cp -r gfx-redzone /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-redzone
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-redzone:CreateZone
TriggerEvent('gfx-redzone:CreateZone', ...)

-- gfx-redzone:Identifier
TriggerEvent('gfx-redzone:Identifier', ...)

-- gfx-redzone:RemoveZone
TriggerEvent('gfx-redzone:RemoveZone', ...)

-- gfx-redzone:UpdateZones
TriggerEvent('gfx-redzone:UpdateZones', ...)

```

---

## Exports

```lua
exports['gfx-redzone']:gfx-inventory(...)
exports['gfx-redzone']:gfx-lib(...)
exports['gfx-redzone']:gfx-points(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/redzone` | - |

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-redzone
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
