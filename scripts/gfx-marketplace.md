# Gfx Marketplace

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-marketplace klasörünü resources/ dizinine kopyalayın
cp -r gfx-marketplace /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-marketplace
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx-marketplace:notify
TriggerEvent('gfx-marketplace:notify', ...)

-- gfx-marketplace:openUI
TriggerEvent('gfx-marketplace:openUI', ...)

```

---

## Exports

```lua
exports['gfx-marketplace']:ghmattimysql(...)
exports['gfx-marketplace']:oxmysql(...)
exports['gfx-marketplace']:qb-core(...)
```

---

## Komutlar

*Komut bulunamadı*

---

## Callbacks

```lua
-- gfx-marketplace:buyItem
TriggerCallback('gfx-marketplace:buyItem', function(result)
    -- handle result
end)

-- gfx-marketplace:claim
TriggerCallback('gfx-marketplace:claim', function(result)
    -- handle result
end)

-- gfx-marketplace:createOffer
TriggerCallback('gfx-marketplace:createOffer', function(result)
    -- handle result
end)

-- gfx-marketplace:deleteOffer
TriggerCallback('gfx-marketplace:deleteOffer', function(result)
    -- handle result
end)

-- gfx-marketplace:fetchItems
TriggerCallback('gfx-marketplace:fetchItems', function(result)
    -- handle result
end)

-- gfx-marketplace:getCreateOfferPage
TriggerCallback('gfx-marketplace:getCreateOfferPage', function(result)
    -- handle result
end)

-- gfx-marketplace:getMyOffers
TriggerCallback('gfx-marketplace:getMyOffers', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-marketplace
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
