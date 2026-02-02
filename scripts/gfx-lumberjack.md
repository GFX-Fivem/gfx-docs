# Gfx Lumberjack

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-lumberjack klasörünü resources/ dizinine kopyalayın
cp -r gfx-lumberjack /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-lumberjack
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- gfx:client:lumberjack:Notify
TriggerEvent('gfx:client:lumberjack:Notify', ...)

-- gfx:client:LumberjackNui
TriggerEvent('gfx:client:LumberjackNui', ...)

-- gfx:lumberjack:cutTree
TriggerEvent('gfx:lumberjack:cutTree', ...)

```

### Server Events

```lua
-- gfx:server:lumberjack:CuttingTrees
TriggerServerEvent('gfx:server:lumberjack:CuttingTrees', ...)

-- gfx:server:lumberjack:GainContractMoney
TriggerServerEvent('gfx:server:lumberjack:GainContractMoney', ...)

```

---

## Exports

```lua
exports['gfx-lumberjack']:es_extended(...)
exports['gfx-lumberjack']:ghmattimysql(...)
exports['gfx-lumberjack']:oxmysql(...)
exports['gfx-lumberjack']:qb-core(...)
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

- **GitHub:** https://github.com/gfx-fivem/gfx-lumberjack
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
