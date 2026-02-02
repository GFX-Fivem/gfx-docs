# Gfx Dailygift

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-dailygift klasörünü resources/ dizinine kopyalayın
cp -r gfx-dailygift /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-dailygift
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-daily:open
TriggerEvent('gfx-daily:open', ...)

-- gfx-dailygift:setItemTable
TriggerEvent('gfx-dailygift:setItemTable', ...)

-- gfx-dailygift:UpdateUI
TriggerEvent('gfx-dailygift:UpdateUI', ...)

```

### Server Events

```lua
-- gfx-dailygift:open
TriggerServerEvent('gfx-dailygift:open', ...)

```

---

## Exports

```lua
exports['gfx-dailygift']:gfx-base(...)
exports['gfx-dailygift']:ghmattimysq(...)
exports['gfx-dailygift']:ghmattimysql(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/createDailyData` | - |
| `/resetdaily` | - |

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-dailygift
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
