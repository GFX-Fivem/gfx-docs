# Gfx Tebexshop

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-tebexshop klasörünü resources/ dizinine kopyalayın
cp -r gfx-tebexshop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-tebexshop
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-tebexshop:updateUserData
TriggerEvent('gfx-tebexshop:updateUserData', ...)

```

---

## Exports

```lua
exports['gfx-tebexshop']:ghmattimysql(...)
exports['gfx-tebexshop']:oxmysql(...)
```

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/givecoin` | - |
| `/packagebought` | - |
| `/tebexshop` | - |

---

## Callbacks

```lua
-- gfx-tebexshop:buyBoost
TriggerCallback('gfx-tebexshop:buyBoost', function(result)
    -- handle result
end)

-- gfx-tebexshop:buySkin
TriggerCallback('gfx-tebexshop:buySkin', function(result)
    -- handle result
end)

-- gfx-tebexshop:buyTier
TriggerCallback('gfx-tebexshop:buyTier', function(result)
    -- handle result
end)

-- gfx-tebexshop:claimCode
TriggerCallback('gfx-tebexshop:claimCode', function(result)
    -- handle result
end)

-- gfx-tebexshop:equipSkin
TriggerCallback('gfx-tebexshop:equipSkin', function(result)
    -- handle result
end)

-- gfx-tebexshop:getPlayerSkins
TriggerCallback('gfx-tebexshop:getPlayerSkins', function(result)
    -- handle result
end)

-- gfx-tebexshop:getTransactions
TriggerCallback('gfx-tebexshop:getTransactions', function(result)
    -- handle result
end)

-- gfx-tebexshop:getUserData
TriggerCallback('gfx-tebexshop:getUserData', function(result)
    -- handle result
end)

-- gfx-tebexshop:refundTransaction
TriggerCallback('gfx-tebexshop:refundTransaction', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ NUI Arayüzü
- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-tebexshop
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
