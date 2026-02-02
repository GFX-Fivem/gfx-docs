# Gfx Vote

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-vote klasörünü resources/ dizinine kopyalayın
cp -r gfx-vote /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-vote
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-vote:create
TriggerEvent('gfx-vote:create', ...)

-- gfx-vote:createMenu
TriggerEvent('gfx-vote:createMenu', ...)

-- gfx-vote:reset
TriggerEvent('gfx-vote:reset', ...)

-- gfx-vote:vote
TriggerEvent('gfx-vote:vote', ...)

```

---

## Exports

```lua
exports['gfx-vote']:es_extended(...)
exports['gfx-vote']:qb-core(...)
```

---

## Komutlar

*Komut bulunamadı*

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-vote
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
