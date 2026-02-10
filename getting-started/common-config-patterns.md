# Common Config Patterns

Many GFX scripts share the same configuration patterns. This page documents them once — individual script docs link here instead of repeating.

## Config.Theme

Controls the color theme of the script's UI elements.

```lua
Config.Theme = {
    Primary = "#ff0000",
    Secondary = "#ffffff",
    Background = "rgba(0, 0, 0, 0.8)",
    Opacity = 0.9
}
```

| Key | Type | Description |
|---|---|---|
| `Primary` | string | Primary accent color (hex) |
| `Secondary` | string | Secondary text/accent color (hex) |
| `Background` | string | Background color (rgba or hex) |
| `Opacity` | number | UI opacity (0.0 - 1.0) |

## Config.DrawText

Controls how 3D interaction text is displayed in the world.

```lua
Config.DrawText = 3
```

| Value | Style | Description |
|---|---|---|
| `1` | 3D World Text | Floating text at coordinates using `World3dToScreen2d` |
| `2` | GTA Notification | Native GTA 5 help text notification |
| `3` | Modern Floating | Modern floating help text with `SetFloatingHelpTextWorldPosition` |

This is set globally in `gfx-lib/config.lua` and applies to all scripts that use `modules.DrawText3D()`.

## Config.Framework

Some scripts include a framework override in their config. In most cases, you should leave this as `"auto"` and let `gfx-lib` handle detection.

```lua
Config.Framework = "auto" -- "auto", "qb-core", "es_extended"
```

## Config.Notify

Some scripts let you override the default notification function:

```lua
Config.Notify = function(msg, type)
    -- Custom notification logic
    exports['mythic_notify']:SendAlert('inform', msg)
end
```

If not set, scripts fall back to `gfx-lib`'s built-in `shared.Notify()`, which auto-detects:
- QBCore notifications
- ESX notifications
- okokNotify
- ox_lib notifications
- t-notify
- infinity-notify

## Config.DiscordBotToken

Set in `gfx-lib/serverconfig.lua` (not per-script). Used by scripts that fetch Discord avatars.

```lua
ServerConfig = {
    DiscordBotToken = "YOUR_DISCORD_BOT_TOKEN"
}
```

Required by scripts that display player avatars sourced from Discord (e.g., killfeed, leaderboard, crew).

## Blip Configuration

Many scripts use a blip config table:

```lua
Config.Blip = {
    Enabled = true,
    Coords = vector3(0.0, 0.0, 0.0),
    Sprite = 1,
    Color = 1,
    Scale = 0.8,
    Text = "My Blip"
}
```

| Key | Type | Description |
|---|---|---|
| `Enabled` | boolean | Whether to show the blip on the map |
| `Coords` | vector3 | World coordinates for the blip |
| `Sprite` | number | [Blip sprite ID](https://docs.fivem.net/docs/game-references/blips/) |
| `Color` | number | [Blip color ID](https://docs.fivem.net/docs/game-references/blips/) |
| `Scale` | number | Blip size on the map |
| `Text` | string | Label shown on the map |

## Locales Table

Scripts with multi-language support use a locales table:

```lua
Config.Locales = {
    ["en"] = {
        title = "Title",
        description = "Description",
    },
    ["tr"] = {
        title = "Baslik",
        description = "Aciklama",
    }
}

Config.Language = "en"
```

| Key | Type | Description |
|---|---|---|
| `Config.Locales` | table | Table of language code to translation table |
| `Config.Language` | string | Active language code |

## Config.Webhook

Scripts that log events to Discord use a webhook URL:

```lua
Config.Webhook = "https://discord.com/api/webhooks/..."
```

## Config.Commands

Scripts with chat commands often use a commands table:

```lua
Config.Commands = {
    open = "scriptname",       -- /scriptname to open
    admin = "scriptadmin",     -- /scriptadmin for admin panel
}
```

## Config.Keybind

Scripts with keybinds:

```lua
Config.Keybind = "F5" -- Key to open the menu
```

Or using FiveM's key mapping system:

```lua
Config.Keybind = {
    Key = "F5",
    Description = "Open Menu"
}
```
