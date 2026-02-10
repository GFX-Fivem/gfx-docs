# gfx-hud_aty

## Info

| Key | Value |
|-----|-------|
| **Author** | atiysu |
| **Framework** | ESX / QBCore |
| **FX Version** | Cerulean |
| **Lua 5.4** | Yes |
| **UI** | NUI (HTML/CSS/JS) |
| **Locales** | English, Turkish, Spanish, German, French, Portuguese |

---

## Dependencies

| Dependency | Required | Notes |
|------------|----------|-------|
| **es_extended** or **qb-core** | Yes | Framework — set via `Config.Framework` (`"esx"` or `"qb"`) |
| **LegacyFuel** (or custom fuel script) | No | Only if `Config.UseCustomFuel = true` — configurable via `Config.CustomFuel` function |
| **InteractSound** | No | Used for nitro sound effect (`InteractSound_SV:PlayOnSource`) |
| **pma-voice** / **SaltyChat** / **mumble-voip** | No | Automatically detected for voice range indicator |

---

## Installation

### 1. Copy the resource folder
```
gfx-hud_aty -> your-server/resources/
```

### 2. Add to server.cfg
```cfg
ensure gfx-hud_aty
```

### 3. If using nitro feature
Add the nitro item to your framework's item list:
- Item name: `nitrous` (configurable via `Config.NitroItem`)

---

## Configuration

All configuration is in `config.lua`.

### General

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Framework` | string | `"qb"` | Framework type: `"esx"` or `"qb"` |
| `Locale` | string | `"en"` | Language: `"en"`, `"tr"`, `"es"`, `"de"`, `"fr"`, `"pt"` |
| `UseInGameTimer` | boolean | `true` | Show in-game time instead of real time |
| `MoneyAsItem` | boolean | `false` | If true, reads cash from an inventory item instead of accounts |
| `MoneyItem` | string | `"cash"` | Item name for cash (only used when `MoneyAsItem = true`) |

### Feature Toggles

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `UseCruiseControl` | boolean | `true` | Enable cruise control system |
| `UseSeatBelt` | boolean | `true` | Enable seatbelt system with ejection |
| `UseNitro` | boolean | `true` | Enable nitro/NOS system |
| `UseStress` | boolean | `true` | Enable stress system |
| `UseMenuKey` | boolean | `true` | Register keybind for HUD settings menu |

### Key Bindings

| Option | Default | Description |
|--------|---------|-------------|
| `CruiseKey` | `"N"` | Cruise control toggle key |
| `SeatBeltKey` | `"K"` | Seatbelt toggle key |
| `NitroKey` | `"X"` | Nitro activation key (hold) |
| `MenuKey` | `"O"` | HUD settings menu key |
| `MenuCommand` | `"hud"` | Command name for opening settings |

### Nitro

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `NitroItem` | string | `"nitrous"` | Inventory item used to fill nitro |
| `NitroForce` | number | `50.0` | Engine power multiplier while nitro is active |
| `RemoveNitroOnMilliseconds` | number | `0.2` | Nitro consumed per 100ms while active |

### Seatbelt

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `MinSpeedToThrowFromVehicle` | number | `100` | Minimum speed (KM/H) to eject player without seatbelt on crash |

### Fuel

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `UseCustomFuel` | boolean | `true` | Use a custom fuel export instead of native fuel level |
| `CustomFuel` | function | LegacyFuel | Function that receives vehicle entity and returns fuel level |

### Stress

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `StressNotify` | boolean | `true` | Notify player when stress is high |
| `MinStressToBlur` | number | `50` | Stress level threshold that triggers screen blur effect |
| `WhitelistedWeaponStress` | table | (see config) | Weapons that do not cause stress when fired |

**Stress gain sources (`AddStress`):**

| Key | Default Chance | Default Min/Max | Notes |
|-----|---------------|-----------------|-------|
| `on_shoot` | 20% | 1-2 | Stress from firing non-whitelisted weapons |
| `on_fastdrive` | 50% | 1-3 | Stress from driving above `minSpeed` (default 110 KM/H) |

**Stress reduction sources (`RemoveStress`):**

| Key | Default Min/Max | Notes |
|-----|-----------------|-------|
| `on_eat` | 5-10 | Eating food (ESX or QBCore consumables) |
| `on_drink` | 5-10 | Drinking (ESX or QBCore consumables) |
| `on_swim` | 5-10 | Swimming |
| `on_run` | 5-10 | Running / sprinting |

### Custom Notification

The `Config.Notify` function can be replaced with your own notification system. By default it triggers the built-in `aty_hud:sendNotify` event.

```lua
Config.Notify = function(title, message, type, length, icon, color)
    TriggerEvent("aty_hud:sendNotify", message, icon, color, length)
end
```

---

## Exports

*No exports are created by this script.*

---

## Events

Public API events that other scripts can trigger to interact with gfx-hud_aty.

### Client Events

#### `aty_hud:sendNotify`
Send a notification through the HUD notification system.

```lua
TriggerEvent("aty_hud:sendNotify", text, icon, color, duration)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `text` | string | Notification message text |
| `icon` | string | FontAwesome icon class (e.g. `"fas fa-car"`) |
| `color` | string | Color name or hex (e.g. `"red"`, `"green"`) |
| `duration` | number | Duration in milliseconds |

---

#### `aty_hud:toggle`
Show or hide the entire HUD.

```lua
TriggerEvent("aty_hud:toggle", status)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `status` | boolean | `true` to show, `false` to hide |

---

#### `aty_hud:stress:add`
Add stress to the player. Only works when `Config.UseStress = true`.

```lua
TriggerEvent("aty_hud:stress:add", value)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | number | Amount of stress to add (capped at 100) |

---

#### `aty_hud:stress:decrease`
Remove stress from the player. Only works when `Config.UseStress = true`.

```lua
TriggerEvent("aty_hud:stress:decrease", value)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | number | Amount of stress to remove (floored at 0) |

---

#### `aty_hud:client:toggleSeatBelt`
Programmatically set the seatbelt state. Only works when `Config.UseSeatBelt = true`.

```lua
TriggerClientEvent("aty_hud:client:toggleSeatBelt", source, value)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `value` | boolean | `true` = seatbelt on, `false` = seatbelt off |

---

#### `aty_hud:setupNitro`
Trigger nitro installation on the nearest vehicle (player must be on foot, near a vehicle). Only works when `Config.UseNitro = true`. Removes one `NitroItem` from inventory and fills the vehicle to 100% nitro.

```lua
TriggerClientEvent("aty_hud:setupNitro", source)
```

*No parameters -- uses the player's position to find a nearby vehicle.*

---

## Commands

| Command | Key | Description |
|---------|-----|-------------|
| `hud` | `O` (configurable) | Open HUD settings menu |
| `+togglenitro` / `-togglenitro` | `X` (hold) | Activate nitro while held (requires nitro in vehicle) |
| `togglecruisecontrol` | `N` | Toggle cruise control at current speed |
| `toggleseatbelt` | `K` | Toggle seatbelt on/off |

All key bindings are saved per player via FiveM's key mapping system and can be changed in GTA V Settings > Key Bindings > FiveM.

---

## Features

- **Status HUD** -- Health, armor, hunger, thirst, stamina, oxygen, stress indicators
- **Vehicle HUD** -- Speedometer (KM/H or MPH), RPM, gear, fuel level, engine health, door state, lights, indicators, reversing, handbrake
- **Weapon HUD** -- Current weapon name, clip ammo, total ammo
- **Player Info** -- Server ID, job, cash, bank, ping, online players, in-game time
- **Street Display** -- Current street and road name
- **Custom Minimap** -- Circle-shaped minimap with custom texture, auto-hides on foot (unless always-on is enabled)
- **Cinematic Mode** -- Black bars overlay from the settings menu
- **Cruise Control** -- Lock speed at current velocity (disabled for boats, planes, helicopters)
- **Seatbelt System** -- With vehicle ejection on crash at high speed when unbuckled
- **Nitro/NOS System** -- Item-based nitro installation, hold key to boost with exhaust backfire particles, light trails, screen effects, and engine power multiplier
- **Stress System** -- Gains from shooting and fast driving, reduced by eating, drinking, swimming, running; screen blur at high stress, death resets stress
- **Voice Indicator** -- Supports pma-voice, SaltyChat, and mumble-voip voice range display
- **Notification System** -- Built-in HUD notifications via event API
- **Settings Menu** -- In-game settings panel with key binding display, speed unit toggle, always-on minimap toggle, cinematic mode
- **Pause Menu Detection** -- HUD hides automatically when ESC menu is open
- **Multi-language** -- 6 languages supported via locale system
- **Dual Framework** -- Full ESX and QBCore support

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| HUD not showing after spawn | Ensure the script starts after your framework resource. Check console for NUI load errors. |
| Minimap not appearing | The custom minimap texture (`mapshape`) must be in the `stream/` folder. Verify `ui/` files are present. |
| Hunger/thirst always 0 | **ESX:** Ensure `esx_status` is running. **QBCore:** Ensure `PlayerData.metadata` includes hunger/thirst. |
| Nitro item not working | Verify the item exists in your framework's item list with the exact name from `Config.NitroItem` (default: `"nitrous"`). |
| Fuel always 0 | If `Config.UseCustomFuel = true`, ensure the fuel export (default: LegacyFuel) is available. Set to `false` to use native fuel. |
| Voice indicator not updating | The script listens to pma-voice, SaltyChat, and mumble events. Ensure your voice resource triggers the standard events. |
| Seatbelt ejection not working | Check `Config.MinSpeedToThrowFromVehicle` value. Ejection only triggers during sudden deceleration above that speed. |
| Stress not decreasing | Verify `Config.RemoveStress` entries have `enable = true`. For ESX, `esx_status:add` event must fire. For QBCore, `consumables:client:Eat/Drink` events must fire. |
| Cruise control not activating | Cruise control requires a minimum speed (~18 KM/H). Does not work on boats, planes, or helicopters. |
| Key bindings not responding | Keys are saved per player. Check GTA V Settings > Key Bindings > FiveM for overridden binds. |
