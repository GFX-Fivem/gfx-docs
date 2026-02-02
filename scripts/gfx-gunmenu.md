# Gfx Gunmenu

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-gunmenu klasörünü resources/ dizinine kopyalayın
cp -r gfx-gunmenu /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-gunmenu
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
-- gfx-gunmenu:openMenu
TriggerEvent('gfx-gunmenu:openMenu', ...)

```

---

## Exports

```lua
exports['gfx-gunmenu']:es_extended(...)
exports['gfx-gunmenu']:gfx-inventory(...)
exports['gfx-gunmenu']:ox_inventory(...)
exports['gfx-gunmenu']:qb-core(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/checkgun` | - |
| `/openmenu` | - |

---

## Callbacks

```lua
-- gfx-gun:validItem
TriggerCallback('gfx-gun:validItem', function(result)
    -- handle result
end)

-- gfx-mdt:buyWeapon
TriggerCallback('gfx-mdt:buyWeapon', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-gunmenu
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
