# Gfx Tabu

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-tabu klasörünü resources/ dizinine kopyalayın
cp -r gfx-tabu /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-tabu
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-tabu:gameFinished
TriggerEvent('gfx-tabu:gameFinished', ...)

-- gfx-tabu:newWord
TriggerEvent('gfx-tabu:newWord', ...)

-- gfx-tabu:pass
TriggerEvent('gfx-tabu:pass', ...)

-- gfx-tabu:standBy
TriggerEvent('gfx-tabu:standBy', ...)

-- gfx-tabu:startGame
TriggerEvent('gfx-tabu:startGame', ...)

-- gfx-tabu:updateNarrating
TriggerEvent('gfx-tabu:updateNarrating', ...)

-- gfx-tabu:updateTeam
TriggerEvent('gfx-tabu:updateTeam', ...)

```

---

## Exports

```lua
exports['gfx-tabu']:es_extended(...)
exports['gfx-tabu']:qb-core(...)
exports['gfx-tabu']:qb-inventory(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/createtabu` | - |
| `/jointabu` | - |
| `/opentabu` | - |

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-tabu
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
