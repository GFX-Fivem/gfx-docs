# gfx-effects

Kill effects script that plays particle effects (PTFX) on the victim's body when a player gets a kill. Players can browse, preview, and select their preferred effect through a modern NUI interface. Supports VIP restrictions and job-based access control.

---

## Info

| Key | Value |
|-----|-------|
| **Author** | GFX Development |
| **FX Version** | Cerulean |
| **Game** | GTA 5 |
| **Lua 5.4** | Yes |
| **UI** | NUI (React) |
| **Escrow Ignore** | `config.lua`, `client/client_shared.lua`, `server/server_shared.lua` |

---

## Dependencies

| Dependency | Required | Purpose |
|------------|----------|---------|
| `oxmysql` | Yes | Database queries (referenced in server scripts) |

---

## Installation

### 1. Copy Files
Place the `gfx-effects` folder into your server's resources directory.

### 2. Add to server.cfg
```cfg
ensure oxmysql
ensure gfx-effects
```

### 3. Configure
Edit `config.lua` to set VIP mode, identifier type, allowed jobs, and UI settings.

---

## Configuration

All configuration is in `config.lua`.

### Main Config

```lua
Config = {
    OnlyVIP = false,
    -- Set to a function like: function(source) return IsPlayerAceAllowed(source, "vip") end
    -- or keep false to allow all players

    IdentifierType = "license",
    -- Player identifier type used for database lookups: "license", "steam", etc.

    AllowedJobs = {
        ["police"] = true
        -- Add job names that are allowed to use effects
    }
}
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `OnlyVIP` | `boolean/function` | `false` | When `false`, all players can use effects. Set to `true` or a function to restrict to VIP players only. |
| `IdentifierType` | `string` | `"license"` | The identifier type used to identify players (e.g., `"license"`, `"steam"`). |
| `AllowedJobs` | `table` | `{ ["police"] = true }` | Table of job names that have access to the effects system. |

### UI Config

```lua
Config.UI = {
    PrimaryColor = "#00ffea"
    -- The primary accent color used throughout the NUI interface
}
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PrimaryColor` | `string` | `"#00ffea"` | Hex color code for the UI accent/primary color. |

### Locales

All UI text strings are configurable via the `Locales` table in `config.lua`:

```lua
Locales = {
    ["for_vip"]                = "This feature is only for diamond users!",
    ["ui_effects"]             = "EFFECTS",
    ["ui_menu"]                = "MENU",
    ["ui_subtitle"]            = "Select an effect from the menu.",
    ["ui_kill_effects"]        = "Kill Effects",
    ["ui_favourite_list"]      = "Favourite List",
    ["ui_show_favourites_title"] = "Show favourites",
    ["ui_search_placeholder"]  = "Enter the text...",
    ["ui_empty_title"]         = "No effects found",
    ["ui_empty_desc"]          = "Try adjusting filters or search query.",
    ["ui_in_use"]              = "In use",
    ["ui_apply"]               = "Apply",
    ["ui_close_aria"]          = "Close",
    ["ui_favorite"]            = "Add to favourites",
    ["ui_unfavorite"]          = "Remove from favourites"
}
```

---

## Exports

*No exports found.* This script does not create any callable exports.

---

## Events

Public API events that other resources can interact with:

### Client Events

#### `gfx-effect:client:effect`
Plays a kill effect particle on a specific player. Triggered by the server when a kill occurs.

```lua
-- Trigger from server
TriggerClientEvent("gfx-effect:client:effect", targetSource, victimServerId, effectId)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `victimId` | `number` | Server ID of the victim player (effect plays at their location) |
| `id` | `string` | The particle effect value name (e.g., `"scr_xs_confetti_burst"`) |

> The effect only plays if the local player is within 50 units of the victim.

---

#### `gfx-effects:client:SetVip`
Sets the VIP state for the local player. Sent by the server on join and on request.

```lua
-- Trigger from server
TriggerClientEvent("gfx-effects:client:SetVip", targetSource, state)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `state` | `boolean` | Whether the player has VIP access |

---

### Server Events

#### `gfx-effects:playerKilled`
Triggered by the client when a player kills another player with an active effect selected. The server then broadcasts the effect to relevant clients.

```lua
-- Triggered automatically by the client on kill
TriggerServerEvent("gfx-effects:playerKilled", killerId, victimId, effectValue)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `killerId` | `number` | Server ID of the killer |
| `victimId` | `number` | Server ID of the victim |
| `effectValue` | `string` | The particle effect value name |

---

#### `gfx-effects:server:RequestVip`
Client requests their VIP status from the server. The server responds with `gfx-effects:client:SetVip`.

```lua
TriggerServerEvent("gfx-effects:server:RequestVip")
```

*No parameters.*

---

## Commands

| Command | Description | Access |
|---------|-------------|--------|
| `/effects` | Opens the effects selection NUI menu. If `Config.OnlyVIP` is enabled, only VIP players can open it. | All players (or VIP-only when configured) |

---

## Features

- **90+ Particle Effects** -- Large library of built-in GTA V particle effects including explosions, fireworks, confetti, smoke, fire, lightning, and more.
- **Modern NUI Interface** -- React-based UI with search, filtering, favourites list, and effect preview.
- **Kill Effect System** -- Automatically plays the selected particle effect at the victim's location when a player gets a kill.
- **Effect Preview** -- Players can preview any effect on themselves before applying it.
- **Favourites** -- Players can favourite effects for quick access.
- **VIP Restriction** -- Optionally restrict the effects menu to VIP players only via ACE permissions.
- **Proximity-Based Rendering** -- Effects only render for players within 50 units of the victim for performance.
- **Configurable UI Theme** -- Customizable primary accent color and all UI text strings via config.
- **Localization Support** -- All UI strings are configurable through the `Locales` table.
- **Escrow Ready** -- `config.lua`, `client_shared.lua`, and `server_shared.lua` are excluded from escrow for easy customization.

---

## VIP Setup

The VIP check is defined in `server/server_shared.lua`. By default it uses ACE permissions:

```lua
function IsVIP(source)
    if source == nil then return false end
    local ok = IsPlayerAceAllowed(source, "vip")
    return ok == true
end
```

To use a custom VIP system, modify this function to use your own logic (e.g., check a database field, use a framework export, etc.).

To grant VIP via ACE permissions in `server.cfg`:
```cfg
add_ace identifier.license:xxxxxx vip allow
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Effects menu does not open | Check that `Config.OnlyVIP` is `false` or the player has VIP access. Verify the resource is started. |
| No effect plays on kill | Ensure the player has selected an effect from the menu. The effect must be applied, not just previewed. |
| Effect not visible to nearby players | Effects only render within 50 units of the victim. Move closer to see them. |
| "This feature is only for diamond users!" message | The player does not have VIP access. Grant VIP ACE permission or set `Config.OnlyVIP = false`. |
| NUI not loading | Ensure the `web/build/` folder exists with compiled assets. Check F8 console for NUI errors. |
| oxmysql errors on startup | Ensure `oxmysql` is started before `gfx-effects` in your `server.cfg`. |

---

## Source

- **GitHub:** [gfx-fivem/gfx-effects](https://github.com/gfx-fivem/gfx-effects)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
