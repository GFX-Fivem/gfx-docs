# Gfx Trade

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-trade klasörünü resources/ dizinine kopyalayın
cp -r gfx-trade /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-trade
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-trade:client:TradeRequest
TriggerEvent('gfx-trade:client:TradeRequest', ...)

-- gfx-trade:CloseMenu
TriggerEvent('gfx-trade:CloseMenu', ...)

-- gfx-trade:Open
TriggerEvent('gfx-trade:Open', ...)

-- gfx-trade:SetReadyStatus
TriggerEvent('gfx-trade:SetReadyStatus', ...)

-- gfx-trade:TradeAccepted
TriggerEvent('gfx-trade:TradeAccepted', ...)

-- gfx-trade:UpdateSelectedItems
TriggerEvent('gfx-trade:UpdateSelectedItems', ...)

```

### Server Events

```lua
-- gfx-trade:CloseMenu
TriggerServerEvent('gfx-trade:CloseMenu', ...)

-- gfx-trade:server:TradeResponse
TriggerServerEvent('gfx-trade:server:TradeResponse', ...)

```

---

## Exports

```lua
exports['gfx-trade']:es_extended(...)
exports['gfx-trade']:gfx-inventory(...)
exports['gfx-trade']:qb-core(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/getidentifier` | - |
| `/trade` | - |
| `/tradea` | - |
| `/traded` | - |

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-trade
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
