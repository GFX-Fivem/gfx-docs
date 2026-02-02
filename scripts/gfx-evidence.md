# Gfx Evidence

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-evidence klasörünü resources/ dizinine kopyalayın
cp -r gfx-evidence /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-evidence
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- esx:setJob
TriggerEvent('esx:setJob', ...)

-- gfx-evidence:client:analyze
TriggerEvent('gfx-evidence:client:analyze', ...)

-- gfx-evidence:client:dropBlood
TriggerEvent('gfx-evidence:client:dropBlood', ...)

-- gfx-evidence:client:dropBulletCore
TriggerEvent('gfx-evidence:client:dropBulletCore', ...)

-- gfx-evidence:client:dropCasing
TriggerEvent('gfx-evidence:client:dropCasing', ...)

-- gfx-evidence:client:removeEvidence
TriggerEvent('gfx-evidence:client:removeEvidence', ...)

-- QBCore:Client:OnJobUpdate
TriggerEvent('QBCore:Client:OnJobUpdate', ...)

```

---

## Exports

```lua
exports['gfx-evidence']:es_extended(...)
exports['gfx-evidence']:ghmattimysql(...)
exports['gfx-evidence']:oxmysql(...)
exports['gfx-evidence']:qb-core(...)
exports['gfx-evidence']:qb-weapons(...)
```

---

## Komutlar

*Komut bulunamadı*

---

## Callbacks

```lua
-- gfx-evidence:AddPreviousAnalyze
TriggerCallback('gfx-evidence:AddPreviousAnalyze', function(result)
    -- handle result
end)

-- gfx-evidence:getPreviousAnalyzes
TriggerCallback('gfx-evidence:getPreviousAnalyzes', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-evidence
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
