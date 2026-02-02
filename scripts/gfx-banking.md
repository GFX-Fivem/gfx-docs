# Gfx Banking

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-banking klasörünü resources/ dizinine kopyalayın
cp -r gfx-banking /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-banking
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-banking:client:Update
TriggerEvent('gfx-banking:client:Update', ...)

-- gfx-banking:Open
TriggerEvent('gfx-banking:Open', ...)

-- qb-core:UpdateAccounts
TriggerEvent('qb-core:UpdateAccounts', ...)

-- QBCore:Player:SetPlayerData
TriggerEvent('QBCore:Player:SetPlayerData', ...)

```

---

## Exports

```lua
exports['gfx-banking']:gfx-base(...)
exports['gfx-banking']:qb-core(...)
exports['gfx-banking']:qb-target(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/debugmoney` | - |
| `/openbank` | - |
| `/transfertonewbank` | - |

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-banking
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
