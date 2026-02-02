# Gfx Notify

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-notify klasörünü resources/ dizinine kopyalayın
cp -r gfx-notify /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-notify
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-notify:Notify
TriggerEvent('gfx-notify:Notify', ...)

-- gfx-notify:Question
TriggerEvent('gfx-notify:Question', ...)

```

---

## Exports

```lua
exports['gfx-notify']:qb-core(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/mousefornotify` | - |
| `/notifytest` | - |
| `/questiontest` | - |

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-notify
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
