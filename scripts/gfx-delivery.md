# Gfx Delivery

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-delivery klasörünü resources/ dizinine kopyalayın
cp -r gfx-delivery /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-delivery
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx:client:openUI
TriggerEvent('gfx:client:openUI', ...)

-- gfx:client:TriggerNotfiy
TriggerEvent('gfx:client:TriggerNotfiy', ...)

```

### Server Events

```lua
-- GFX:DeliveryJob:DeleteContract
TriggerServerEvent('GFX:DeliveryJob:DeleteContract', ...)

-- GFX:DeliveryJob:GainContractMoney
TriggerServerEvent('GFX:DeliveryJob:GainContractMoney', ...)

-- GFX:DeliveryJob:GainMoney
TriggerServerEvent('GFX:DeliveryJob:GainMoney', ...)

-- GFX:DeliveryJob:LevelSave
TriggerServerEvent('GFX:DeliveryJob:LevelSave', ...)

-- GFX:DeliveryJob:Withdrawdeposit
TriggerServerEvent('GFX:DeliveryJob:Withdrawdeposit', ...)

```

---

## Exports

```lua
exports['gfx-delivery']:es_extended(...)
exports['gfx-delivery']:ghmattimysql(...)
exports['gfx-delivery']:ox_target(...)
exports['gfx-delivery']:oxmysql(...)
exports['gfx-delivery']:qb-core(...)
exports['gfx-delivery']:qb-target(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-delivery
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
