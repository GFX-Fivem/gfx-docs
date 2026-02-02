# Gfx Attachment

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-attachment klasörünü resources/ dizinine kopyalayın
cp -r gfx-attachment /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-attachment
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
-- gfx-attachment:client:open
TriggerEvent('gfx-attachment:client:open', ...)

```

---

## Exports

```lua
exports['gfx-attachment']:codem-inventory(...)
exports['gfx-attachment']:es_extended(...)
exports['gfx-attachment']:gfx-inventory(...)
exports['gfx-attachment']:ghmattimysql(...)
exports['gfx-attachment']:ox_inventory(...)
exports['gfx-attachment']:oxmysql(...)
exports['gfx-attachment']:ps-inventory(...)
exports['gfx-attachment']:qb-core(...)
exports['gfx-attachment']:qb-inventory(...)
exports['gfx-attachment']:qb-target(...)
exports['gfx-attachment']:qs-inventory(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/bench` | - |
| `/removeattachments` | - |
| `/setattachments` | - |

---

## Callbacks

```lua
-- getAttachments
TriggerCallback('getAttachments', function(result)
    -- handle result
end)

-- getWeapons
TriggerCallback('getWeapons', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-attachment
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
