# Gfx Attachment Remake

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-attachment-remake klasörünü resources/ dizinine kopyalayın
cp -r gfx-attachment-remake /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-attachment-remake
```

### 3. Bağımlılıklar
- ox_inventory veya ox_lib (tespit edildi)

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

*Event bulunamadı*

---

## Exports

```lua
exports['gfx-attachment-remake']:codem-inventory(...)
exports['gfx-attachment-remake']:es_extended(...)
exports['gfx-attachment-remake']:gfx-inventory(...)
exports['gfx-attachment-remake']:ghmattimysql(...)
exports['gfx-attachment-remake']:ox_inventory(...)
exports['gfx-attachment-remake']:oxmysql(...)
exports['gfx-attachment-remake']:ps-inventory(...)
exports['gfx-attachment-remake']:qb-core(...)
exports['gfx-attachment-remake']:qb-inventory(...)
exports['gfx-attachment-remake']:qs-inventory(...)
```

---

## Komutlar

*Komut bulunamadı*

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

-- saveWeapon
TriggerCallback('saveWeapon', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ NUI Arayüzü
- ✅ Client-side
- ✅ Server-side
- ✅ Shared modül

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-attachment-remake
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
