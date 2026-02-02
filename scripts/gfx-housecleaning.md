# Gfx Housecleaning

## Kurulum

### 1. Dosyaları Kopyala
```bash
# gfx-housecleaning klasörünü resources/ dizinine kopyalayın
cp -r gfx-housecleaning /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-housecleaning
```

---

## Konfigürasyon

*Konfigürasyon dosyası bulunamadı*

---

## Events

### Client Events

```lua
-- aty_housecleaning:closeMenu
TriggerEvent('aty_housecleaning:closeMenu', ...)

-- aty_housecleaning:deleteSquad
TriggerEvent('aty_housecleaning:deleteSquad', ...)

-- aty_housecleaning:fetchPositions
TriggerEvent('aty_housecleaning:fetchPositions', ...)

-- aty_housecleaning:receiveInvite
TriggerEvent('aty_housecleaning:receiveInvite', ...)

-- aty_housecleaning:refreshSquad
TriggerEvent('aty_housecleaning:refreshSquad', ...)

-- aty_housecleaning:startMission
TriggerEvent('aty_housecleaning:startMission', ...)

```

---

## Exports

*Export bulunamadı*

---

## Komutlar

| Komut | Açıklama |
|-------|----------|
| `/acceptinvite` | - |
| `/myinvites` | - |

---

## Özellikler

- ✅ Client-side
- ✅ Server-side

---

## Kaynak

- **GitHub:** https://github.com/gfx-fivem/gfx-housecleaning
- **Organizasyon:** [GFX-Fivem](https://github.com/gfx-fivem)
