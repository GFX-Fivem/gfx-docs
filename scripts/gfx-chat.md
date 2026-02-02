# Gfx Chat

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-chat klasörünü resources/ dizinine kopyalayın
cp -r gfx-chat /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-chat
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- chat:addMessage
TriggerEvent('chat:addMessage', ...)

-- gfx-chat:addMessage
TriggerEvent('gfx-chat:addMessage', ...)

-- gfx-chat:clear
TriggerEvent('gfx-chat:clear', ...)

```

---

## Exports

```lua
exports['gfx-chat']:gfx-base(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/changechatmode` | - |
| `/clear` | - |
| `/openchat` | - |

---

## Özellikler

- ✅ Client-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-chat
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
