# gfx-notify

## Info

| Key | Value |
|-----|-------|
| **Name** | gfx-notify |
| **Version** | 1.0.0 |
| **Side** | Client |
| **Framework** | Standalone |
| **UI** | NUI (HTML/CSS/JS) |

## Dependencies

- None (standalone script)

## Installation

### 1. Copy Files

Place the `gfx-notify` folder into your server's resources directory.

### 2. server.cfg

```cfg
ensure gfx-notify
```

---

## Configuration

Configuration is done in `config.lua`.

### Default Key

```lua
Config.DefaultKey = "F4"
```

The key used to enable mouse cursor for interacting with notifications (e.g., answering question prompts). Players can rebind this in FiveM keybind settings.

### Settings Command

```lua
Config.SettingsCommand = "notifysettings"
```

The command that opens the in-game notification settings panel.

### Notification Types

Custom notification types are defined in `Config.Types`. Each type has a color theme, icon, default duration, and sound.

```lua
Config.Types = {
    ["police"] = {
        color = "blue",           -- Color theme (blue, yellow, darkblue, orange, purple)
        icon = "assets/icon1.png", -- Icon image path (relative to nui/)
        time = 1000,              -- Default duration in ms
        sound = "NAV",            -- GTA sound name
        soundDirectory = "HUD_AMMO_SHOP_SOUNDSET" -- GTA sound set
    },
    ["ambulance"] = {
        color = "yellow",
        icon = "assets/icon3.png",
        time = 5000,
        sound = "NAV",
        soundDirectory = "HUD_AMMO_SHOP_SOUNDSET"
    },
}
```

#### Available Colors

| Color | CSS Class |
|-------|-----------|
| `blue` | `blue-notif` |
| `yellow` | `yellow-notif` |
| `darkblue` | `darkblue-notif` |
| `orange` | `orange-notif` |
| `purple` | `purple-notif` |

#### Available Icons

| Icon | File |
|------|------|
| Icon 1 | `assets/icon1.png` |
| Icon 2 | `assets/icon2.png` |
| Icon 3 | `assets/icon3.png` |
| Icon 4 | `assets/icon4.png` |

You can add your own icons to the `nui/assets/` folder and reference them in the config.

---

## Exports

### Notify (Client)

Displays a notification on screen.

```lua
exports['gfx-notify']:Notify(type, title, text, duration, icon)
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `type` | string | Yes | Notification type key from `Config.Types` (e.g., `"police"`, `"ambulance"`) |
| `title` | string | Yes | Notification title text |
| `text` | string | Yes | Notification body text |
| `duration` | number | No | Duration in ms (overrides the type's default `time`) |
| `icon` | string | No | Custom icon path (overrides the type's default `icon`) |

**Example:**

```lua
exports['gfx-notify']:Notify("police", "Police Alert", "Suspicious activity reported nearby", 5000)
```

### Question (Client)

Displays an interactive yes/no question prompt. The player can respond via mouse click or keyboard (Y/N) depending on their settings.

```lua
exports['gfx-notify']:Question(text, duration, successCallback, failCallback)
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `text` | string | Yes | The question text to display |
| `duration` | number | Yes | Duration in ms before the question auto-dismisses |
| `successCallback` | function | Yes | Function called when the player clicks "Yes" or presses Y |
| `failCallback` | function | Yes | Function called when the player clicks "No" or presses N |

**Example:**

```lua
exports['gfx-notify']:Question("Do you want to accept this offer?", 10000, function()
    print("Player accepted")
end, function()
    print("Player declined")
end)
```

---

## Events

### gfx-notify:Notify (Client)

Triggers a notification on the target client. Can be called from server-side to send notifications to specific players.

```lua
-- From server-side:
TriggerClientEvent("gfx-notify:Notify", targetSource, type, title, text, duration, icon)

-- From client-side:
TriggerEvent("gfx-notify:Notify", type, title, text, duration, icon)
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `type` | string | Yes | Notification type key from `Config.Types` |
| `title` | string | Yes | Notification title text |
| `text` | string | Yes | Notification body text |
| `duration` | number | No | Duration in ms (overrides type default) |
| `icon` | string | No | Custom icon path (overrides type default) |

**Example (server-side):**

```lua
-- Send to a specific player
TriggerClientEvent("gfx-notify:Notify", source, "police", "Dispatch", "Report to station immediately", 5000)

-- Send to all players
TriggerClientEvent("gfx-notify:Notify", -1, "ambulance", "EMS Alert", "Mass casualty incident reported", 8000)
```

### gfx-notify:Question (Client)

Triggers a question prompt on the target client.

```lua
-- From server-side:
TriggerClientEvent("gfx-notify:Question", targetSource, text, duration, successCallback, failCallback)

-- From client-side:
TriggerEvent("gfx-notify:Question", text, duration, successCallback, failCallback)
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `text` | string | Yes | The question text |
| `duration` | number | Yes | Duration in ms |
| `successCallback` | function | Yes | Called on "Yes" answer |
| `failCallback` | function | Yes | Called on "No" answer |

> **Note:** Callback functions only work when triggered from client-side. When triggering from server-side, callbacks cannot be passed over the network. Use the export instead for callback functionality.

---

## Commands

| Command | Description |
|---------|-------------|
| `/notifysettings` | Opens the notification settings panel (configurable via `Config.SettingsCommand`) |
| `/notifytest [type]` | Sends a test notification. Optional type parameter defaults to `"police"` |
| `/questiontest` | Sends a test yes/no question prompt |

The mouse cursor keybind (default `F4`) is registered via `RegisterKeyMapping` and can be rebound by players in FiveM Settings > Key Bindings > GTA Online.

---

## Features

- **Styled Notifications** -- Multiple color themes (blue, yellow, darkblue, orange, purple) with animated effects
- **Question Prompts** -- Interactive yes/no prompts with mouse and keyboard support (Y/N keys)
- **Settings Panel** -- In-game settings UI where players can:
  - Show/hide notifications
  - Mute/unmute notification sounds
  - Switch question controls between mouse and keyboard
  - Drag to reposition the notification area
  - Change notification stack direction (normal/reverse)
  - Save preferences (persisted in browser localStorage)
  - Restore defaults
- **Sound Effects** -- Configurable GTA native sounds per notification type
- **Custom Icons** -- Each notification type supports its own icon
- **Standalone** -- No framework dependency, works on any FiveM server
- **Escrow Ready** -- All Lua files are in `escrow_ignore`

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Notifications not showing | Check that the notification type exists in `Config.Types`. The console will print `"Invalid notify type: ..."` if the type is not found. |
| No sound playing | Verify the `sound` and `soundDirectory` values in your type config are valid GTA sound names. Also check that the player has not muted sounds in the settings panel. |
| Settings panel not opening | Ensure the command matches `Config.SettingsCommand` (default: `notifysettings`). Type `/notifysettings` in chat. |
| Mouse cursor not appearing for questions | Press the configured key (default `F4`) or check keybind settings. The cursor auto-hides after the question duration expires. |
| Notifications appear but with wrong color | Ensure the `color` value in your type config matches one of the available CSS themes: `blue`, `yellow`, `darkblue`, `orange`, `purple`. |
| Settings not saving | Settings are stored in browser localStorage. Clearing FiveM cache may reset them. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-notify
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
