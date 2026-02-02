# Gfx Effects

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-effects klasörünü resources/ dizinine kopyalayın
cp -r gfx-effects /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-effects
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-effect:client:effect
TriggerEvent('gfx-effect:client:effect', ...)

-- gfx-effects:client:GetPlayerCurrentEffect
TriggerEvent('gfx-effects:client:GetPlayerCurrentEffect', ...)

-- gfx-effects:client:SetVip
TriggerEvent('gfx-effects:client:SetVip', ...)

```

### Server Events

```lua
-- gfx-effects:server:RequestVip
TriggerServerEvent('gfx-effects:server:RequestVip', ...)

```

---

## Exports

*Export bulunamadı*

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/effects` | - |

---

## Özellikler

- ✅ NUI Arayüzü
- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-effects
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
