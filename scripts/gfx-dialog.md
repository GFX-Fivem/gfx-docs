# gfx-dialog

NPC dialog system with an immersive NUI interface. Spawn configurable NPCs that players can interact with through 3D DrawText or target systems. When a dialog is opened, a scripted camera focuses on the NPC's face while the player selects from configurable response options that can trigger events or run custom functions.

---

## Info

| Key | Value |
|---|---|
| **Resource name** | `gfx-dialog` |
| **Side** | Client + Server |
| **Framework** | Standalone (optional qb-target support) |
| **FiveM asset** | Escrow supported (`escrow_ignore`: config.lua, server/main.lua, client/main.lua) |
| **Lua 5.4** | Yes |

---

## Dependencies

| Dependency | Required | Notes |
|---|---|---|
| **FiveM asset** | Yes | `dependency '/assetpacks'` in fxmanifest |
| **qb-target** | No | Only if `Config.Target.enable = true` |

---

## Installation

### 1. Copy Files
Place the `gfx-dialog` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-dialog
```

---

## Configuration

All configuration is in `config.lua`.

### DrawText (3D floating text interaction)

| Option | Type | Default | Description |
|---|---|---|---|
| `enable` | `boolean` | `true` | Enable 3D DrawText interaction mode. When enabled, a floating text prompt appears above the NPC when the player is within 1.5 units. Press **E** to open dialog. |
| `offset` | `vector3` | `vector3(0.0, 0.0, 1.0)` | Offset for the 3D text position relative to the NPC coordinates. |
| `preText` | `string` | `"E - "` | Text prepended to the NPC title in the floating text (e.g. `"E - Shaquille"`). |

### Target (qb-target interaction)

| Option | Type | Default | Description |
|---|---|---|---|
| `enable` | `boolean` | `true` | Enable target-based interaction mode (uses qb-target). |
| `targetFunction` | `function(ped, index)` | qb-target setup | Custom function to register each NPC ped with your target system. Receives the ped entity and the NPC config index. |

> **Note:** Both DrawText and Target can be enabled simultaneously. If you only want one interaction method, set the other to `enable = false`.

### NPC Configuration (`Config.Npc`)

Each entry in the `Config.Npc` table defines one NPC dialog character:

| Field | Type | Description |
|---|---|---|
| `title` | `string` | NPC display name shown in the dialog UI and DrawText. |
| `model` | `string` | Ped model name (e.g. `"a_m_m_og_boss_01"`). |
| `text` | `string` | Dialog text the NPC "says" when the dialog opens. |
| `coords` | `table of vector4` | Spawn positions for the NPC. Each vector4 is `(x, y, z, heading)`. Multiple entries spawn the same NPC at multiple locations. |
| `camCoords` | `table of vector4` | Camera positions for the dialog camera. Each entry corresponds to the same index in `coords`. The `w` component is the camera heading (rotation Z). |
| `options` | `table` | List of response buttons the player can choose from. |

### NPC Option Structure

Each option in the `options` table has:

| Field | Type | Description |
|---|---|---|
| `label` | `string` | Button text displayed in the dialog UI. |
| `action.event` | `table` or `nil` | Event to trigger when this option is selected. |
| `action.event.type` | `string` | `"client"` or `"server"` - determines if `TriggerEvent` or `TriggerServerEvent` is used. |
| `action.event.name` | `string` | The event name to trigger. |
| `action.event.parameters` | `table` | Parameters passed to the triggered event. |
| `action.func` | `function` or `nil` | A Lua function to execute when this option is selected. Runs after the event (if any). Use `CloseMenu` to close the dialog, or provide a custom function. |

### Example NPC Configuration

```lua
Config.Npc = {
    {
        title = "Shaquille",
        model = "a_m_m_og_boss_01",
        text = "Hello brother! How are you?",
        coords = {
            vector4(5.788, -8.052, 69.136, 255.879)
        },
        camCoords = {
            vector4(5.788, -8.052, 69.136, 255.879)
        },
        options = {
            {
                label = "I'm fine, thanks!",
                action = {
                    event = {
                        type = "client",
                        name = "closeDialog",
                        parameters = {}
                    },
                    func = CloseMenu
                }
            },
            {
                label = "Open a shop",
                action = {
                    event = {
                        type = "server",
                        name = "myShop:open",
                        parameters = { shopId = 1 }
                    },
                    func = function()
                        -- Custom logic after event fires
                    end
                }
            }
        }
    }
}
```

---

## Exports

*This script does not create any exports.*

---

## Events

### `gfx-dialog:openDialog` (Client - Net Event)

Opens the dialog UI for a specific NPC. Can be triggered from the server or other client scripts.

**Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `data.id` | `number` | The index of the NPC in `Config.Npc` table (1-based). |

**Usage from server:**
```lua
TriggerClientEvent("gfx-dialog:openDialog", source, { id = 1 })
```

**Usage from client:**
```lua
TriggerEvent("gfx-dialog:openDialog", { id = 1 })
```

> **Note:** When using this event, the camera will use `camCoords[1]` for the NPC since no coordinate index is provided.

---

## Commands

*This script does not register any commands.*

---

## Features

- **NPC Spawning** -- Automatically spawns peds at configured coordinates on resource start. NPCs are frozen, invincible, and ignore world events.
- **NUI Dialog Interface** -- Clean UI showing the NPC name, dialog text, and clickable response buttons.
- **Immersive Camera** -- Scripted camera that focuses on the NPC's face during dialog. The player ped is hidden while the camera is active.
- **DrawText Interaction** -- 3D floating text above NPCs with E key to interact (configurable prefix and offset).
- **Target System Support** -- Optional qb-target integration with customizable target function. Can be adapted to other target systems by modifying `Config.Target.targetFunction`.
- **Flexible Response Actions** -- Each dialog option can trigger client/server events, run custom Lua functions, or both.
- **Multi-Location NPCs** -- A single NPC config can have multiple `coords` entries to spawn the same character at different locations.
- **Distance Check** -- Button actions are validated with a 1.5 unit distance check to prevent remote exploitation.
- **ESC to Close** -- Players can press Escape to close the dialog at any time.
- **Escrow Support** -- Supports FiveM escrow with `config.lua`, `server/main.lua`, and `client/main.lua` in `escrow_ignore`.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| NPC not spawning | Verify the `model` name is a valid GTA V ped model. Check server console for model loading errors. |
| DrawText not appearing | Ensure `Config.DrawText.enable = true`. Check that you are within 1.5 units of the NPC coords. |
| Target not working | Ensure `Config.Target.enable = true` and that `qb-target` (or your target resource) is started before `gfx-dialog`. |
| Camera stuck / black screen | If the dialog closes unexpectedly, the camera may not be destroyed. Restart the resource or rejoin. |
| Button click does nothing | Verify the `action.event.name` is a registered event. Check that `action.event.type` is `"client"` or `"server"`. |
| Dialog opens but no buttons | Ensure the NPC config has an `options` table with at least one entry containing a `label`. |
| Player visible during dialog | This is handled automatically. The player ped is hidden while the dialog camera is active and restored when closed. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-dialog
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
