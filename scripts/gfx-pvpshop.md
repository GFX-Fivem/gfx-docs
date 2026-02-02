# Gfx Pvpshop

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-pvpshop klasörünü resources/ dizinine kopyalayın
cp -r gfx-pvpshop /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-pvpshop
```

### 3. Bağımlılıklar
- ox_inventory veya ox_lib (tespit edildi)

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

*Event bulunamadı*

---

## Exports

```lua
exports['gfx-pvpshop']:codem-inventory(...)
exports['gfx-pvpshop']:es_extended(...)
exports['gfx-pvpshop']:gfx-inventory(...)
exports['gfx-pvpshop']:gfx-lib(...)
exports['gfx-pvpshop']:ghmattimysql(...)
exports['gfx-pvpshop']:ox_inventory(...)
exports['gfx-pvpshop']:oxmysql(...)
exports['gfx-pvpshop']:ps-inventory(...)
exports['gfx-pvpshop']:qb-core(...)
exports['gfx-pvpshop']:qb-inventory(...)
exports['gfx-pvpshop']:qs-inventory(...)
```

---

## Komutlar

*Komut bulunamadı*

---

## Callbacks

```lua
-- buyOrSell
TriggerCallback('buyOrSell', function(result)
    -- handle result
end)

-- getItems
TriggerCallback('getItems', function(result)
    -- handle result
end)

-- getMoney
TriggerCallback('getMoney', function(result)
    -- handle result
end)

-- sellAll
TriggerCallback('sellAll', function(result)
    -- handle result
end)

```

---

## Özellikler

- ✅ NUI Arayüzü
- ✅ Client-side
- ✅ Server-side
- ✅ Shared modül

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-pvpshop
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
