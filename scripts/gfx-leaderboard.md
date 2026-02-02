# Gfx Leaderboard

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-leaderboard klasörünü resources/ dizinine kopyalayın
cp -r gfx-leaderboard /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-leaderboard
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- leaderboard:changePed
TriggerEvent('leaderboard:changePed', ...)

-- leaderboard:updateTextInfo
TriggerEvent('leaderboard:updateTextInfo', ...)

```

### Server Events

```lua
-- esx:playerLoaded
TriggerServerEvent('esx:playerLoaded', ...)

```

---

## Exports

```lua
exports['gfx-leaderboard']:fivem-appearance(...)
exports['gfx-leaderboard']:gfx-lib(...)
exports['gfx-leaderboard']:illenium-appearance(...)
exports['gfx-leaderboard']:skinchanger(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/checkleaderboard` | - |
| `/givewep` | - |
| `/leaderboard` | - |
| `/requestlist` | - |
| `/saveleaderboard` | - |
| `/setammo` | - |

---

## Callbacks

```lua
-- leaderboard:getList
TriggerCallback('leaderboard:getList', function(result)
    -- handle result
end)

-- leaderboard:getPlayerSkin
TriggerCallback('leaderboard:getPlayerSkin', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-leaderboard
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
