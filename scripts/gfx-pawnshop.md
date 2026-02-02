# Gfx Pawnshop

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-pawnshop klasörünü resources/ dizinine kopyalayın
cp -r gfx-pawnshop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pawnshop
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- esx:playerLoaded
TriggerEvent('esx:playerLoaded', ...)

-- Jakrino_PawnShop:Client:GetTriflesData
TriggerEvent('Jakrino_PawnShop:Client:GetTriflesData', ...)

-- Jakrino_PawnShop:Client:GetUserData
TriggerEvent('Jakrino_PawnShop:Client:GetUserData', ...)

-- Jakrino_PawnShop:Client:OpenBossMenu
TriggerEvent('Jakrino_PawnShop:Client:OpenBossMenu', ...)

-- Jakrino_PawnShop:Client:OpenSellingMenu
TriggerEvent('Jakrino_PawnShop:Client:OpenSellingMenu', ...)

-- Jakrino_PawnShop:Client:StartUI
TriggerEvent('Jakrino_PawnShop:Client:StartUI', ...)

-- onResourceStart
TriggerEvent('onResourceStart', ...)

-- QBCore:Client:OnPlayerLoaded
TriggerEvent('QBCore:Client:OnPlayerLoaded', ...)

```

### Server Events

```lua
-- Jakrino_PawnShop:Server:BuyPawnShop
TriggerServerEvent('Jakrino_PawnShop:Server:BuyPawnShop', ...)

-- Jakrino_PawnShop:Server:CostEdit
TriggerServerEvent('Jakrino_PawnShop:Server:CostEdit', ...)

-- Jakrino_PawnShop:Server:GetBonus
TriggerServerEvent('Jakrino_PawnShop:Server:GetBonus', ...)

-- Jakrino_PawnShop:Server:MoneyEdit
TriggerServerEvent('Jakrino_PawnShop:Server:MoneyEdit', ...)

-- Jakrino_PawnShop:Server:ShowEdit
TriggerServerEvent('Jakrino_PawnShop:Server:ShowEdit', ...)

```

---

## Exports

```lua
exports['gfx-pawnshop']:es_extended(...)
exports['gfx-pawnshop']:ghmattimysql(...)
exports['gfx-pawnshop']:oxmysql(...)
exports['gfx-pawnshop']:qb-core(...)
exports['gfx-pawnshop']:qb-target(...)
```

---

## Komutlar

*Komut bulunamadı*

---

## Callbacks

```lua
-- GetShopDataForAll
TriggerCallback('GetShopDataForAll', function(result)
    -- handle result
end)

-- GetShopDataForTrifles
TriggerCallback('GetShopDataForTrifles', function(result)
    -- handle result
end)

-- GetUserDataForNpc
TriggerCallback('GetUserDataForNpc', function(result)
    -- handle result
end)

-- ItemEdit
TriggerCallback('ItemEdit', function(result)
    -- handle result
end)

-- SelledItem
TriggerCallback('SelledItem', function(result)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-pawnshop
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
