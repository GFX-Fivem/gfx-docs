# gfx-interact

## Info

| Key | Value |
|---|---|
| **Name** | gfx-interact |
| **Type** | Client-side interaction system |
| **Framework** | Standalone (no framework required) |
| **Escrow** | Yes (server/sv_main.lua is escrowed) |
| **Lua 5.4** | Yes |

## Dependencies

- FiveM asset packs (`dependency '/assetpacks'`)
- No framework dependency (fully standalone)

## Installation

### 1. Copy Files

Copy the `gfx-interact` folder into your server's resources directory.

### 2. server.cfg

```cfg
ensure gfx-interact
```

> **Note:** No additional configuration file is needed. The script works out of the box.

## Configuration

This script has no external configuration file (`config.lua`). All behavior is controlled through the export API when creating interactions.

### Supported Keys

The following key bindings are available for interaction options:

| Key | FiveM Control ID |
|---|---|
| `E` | 38 |
| `F` | 23 |
| `G` | 47 |
| `H` | 74 |
| `L` | 182 |
| `M` | 244 |
| `N` | 249 |
| `R` | 45 |
| `Y` | 246 |
| `Z` | 20 |

### Color Formats

Colors can be specified in the following formats:
- **HEX:** `"#FF0000"` or `"#FF0000FF"` (with alpha)
- **RGB:** `"rgb(255, 0, 0)"`
- **RGBA:** `"rgba(255, 0, 0, 255)"`

Default color: `rgb(0, 253, 139)` (green)

## Exports

### NewInteraction

Creates a new interaction point in the world.

```lua
exports["gfx-interact"]:NewInteraction(type, group, interactionData)
```

**Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `type` | `string` | Interaction type: `"coords"` for static position, `"entity"` for entity-attached |
| `group` | `vector3` or `table` | For `"coords"`: a `vector3` position. For `"entity"`: a table containing the entity handle, e.g. `{ entityHandle }` |
| `interactionData` | `table` | Interaction configuration (see below) |

**interactionData fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | `string` | Yes | Unique identifier for this interaction |
| `title` | `string` | No | Title displayed above options (used with multi-option interactions) |
| `bgColor` | `string` | No | Background color (hex/rgb/rgba). Default: `rgb(0, 253, 139)` |
| `bgColorActive` | `string` | No | Background color when key is pressed. Default: `rgb(0, 253, 139)` |
| `onInteract` | `function` | No | Callback function called on interaction. Receives the interaction object as argument |
| `options` | `table` | Yes | Array of option tables (see below) |

**Option fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `text` | `string` | Yes | Display text for the option |
| `key` | `string` | No | Key binding for this option (only used for single-option interactions). Default: `"E"` |
| `id` | `string` | No | Unique identifier for the option |
| `event` | `string` | No | Client event to trigger when this option is selected |
| `context` | `table` | No | Custom context data passed to the event. If not provided, defaults to `{ id, options, entity/coords }` |

**Returns:** The interaction object.

**Example - Single option (coords):**

```lua
exports["gfx-interact"]:NewInteraction("coords", vector3(100.0, 200.0, 30.0), {
    id = "my-door",
    bgColor = "rgb(10, 196, 255)",
    options = {
        {
            text = "Open Door",
            key = "E",
            event = "door:open",
        }
    }
})
```

**Example - Multiple options (coords):**

```lua
exports["gfx-interact"]:NewInteraction("coords", vector3(100.0, 200.0, 30.0), {
    id = "kitchen-door",
    title = "Kitchen Door",
    options = {
        {
            text = "Open Door",
            id = "open",
        },
        {
            text = "Lock Door",
            id = "lock",
        },
        {
            text = "Knock",
            id = "knock",
        },
    }
})
```

**Example - Entity interaction:**

```lua
exports["gfx-interact"]:NewInteraction("entity", { pedHandle }, {
    id = "ped-shopkeeper",
    title = "Shopkeeper",
    options = {
        {
            text = "Talk",
            id = "talk",
            event = "shop:talk",
        },
        {
            text = "Browse Items",
            id = "browse",
            event = "shop:browse",
        },
    }
})
```

---

### UpdateInteraction

Updates properties of an existing interaction.

```lua
exports["gfx-interact"]:UpdateInteraction(id, updateData)
```

**Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `id` | `string` | The unique identifier of the interaction to update |
| `updateData` | `table` | Table of fields to update |

**Updatable fields:**

| Field | Type | Description |
|---|---|---|
| `enabled` | `boolean` | Enable/disable the interaction |
| `title` | `string` | Change the title |
| `onInteract` | `function` | Change the callback function |
| `options` | `table` | Replace options array |
| `bgColor` | `string` | Change background color |
| `bgColorHover` | `string` | Change hover color |
| `bgColorActive` | `string` | Change active/pressed color |
| `key` | `string` | Change key binding |
| `pos` | `vector3` | Change position |
| `group` | `table` | Change entity group |
| `type` | `string` | Change interaction type |

**Example:**

```lua
exports["gfx-interact"]:UpdateInteraction("ped-shopkeeper", {
    title = "Closed Shopkeeper",
    bgColor = "#FF0000",
    options = {
        {
            text = "Shop is closed",
            id = "closed",
        }
    }
})
```

---

### RemoveInteraction

Removes an interaction from the world.

```lua
exports["gfx-interact"]:RemoveInteraction(id)
```

**Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `id` | `string` | The unique identifier of the interaction to remove |

**Example:**

```lua
exports["gfx-interact"]:RemoveInteraction("my-door")
```

## Events

### gfx-interact:interacted

Triggered on the client when a player interacts with any interaction point. This event fires regardless of whether the option has its own event defined.

**Parameters:**

| Parameter | Type | Description |
|---|---|---|
| `interactionId` | `string` | The unique ID of the interaction |
| `optionId` | `string` | The ID of the selected option |

**Example:**

```lua
RegisterNetEvent("gfx-interact:interacted", function(interactionId, optionId)
    print("Player interacted with:", interactionId, "Option:", optionId)
end)
```

> **Note:** If an option has an `event` field defined, that event is also triggered separately with the option's `context` data. The `gfx-interact:interacted` event fires in addition to the option-specific event.

### Option Events

When an option has an `event` field, that event is triggered via `TriggerEvent` with the option's `context` table. If no custom `context` is provided, the default context includes:

| Field | Type | Description |
|---|---|---|
| `id` | `string` | The interaction ID |
| `options` | `table` | The full options array |
| `entity` | `number` | The entity handle (only for `"entity"` type interactions) |
| `coords` | `vector3` | The position (only for `"coords"` type interactions) |

**Example:**

```lua
RegisterNetEvent("door:open", function(context)
    print("Opening door at interaction:", context.id)
    print("Entity:", context.entity)     -- if entity type
    print("Coords:", context.coords)     -- if coords type
end)
```

## Commands

This script does not register any commands.

## Features

- Standalone 3D world interaction system (no framework required)
- Two interaction types: static coordinates and entity-attached
- Single-option mode with customizable key binding
- Multi-option mode with scroll selection (mouse wheel up/down)
- Custom color support (HEX, RGB, RGBA) for background, hover, and active states
- Animated fade-in/fade-out based on player distance
- Automatic proximity detection (activates within 25 units, key prompt within 1.5 units)
- Custom font rendering (IstokWeb Bold and Regular via streamed `.gfx` fonts)
- Runtime texture dictionary for UI sprites
- Automatic closest-interaction detection (only one interaction active at a time)
- Full API for creating, updating, and removing interactions at runtime
- Lightweight: no NUI, no framework dependencies, pure GTA native rendering

## Troubleshooting

| Problem | Solution |
|---|---|
| Interaction not appearing | Ensure the `id` is unique. Check the console for `[ERROR] Interaction with ID ... already exists.` |
| Interaction stuck on screen | Call `RemoveInteraction(id)` to properly clean up. Make sure the entity still exists for entity-type interactions. |
| Key not working | Verify the key string is one of the supported keys: `E, F, G, H, L, M, N, R, Y, Z` |
| Colors not applying | Ensure the color string format is correct: `"#RRGGBB"`, `"rgb(R, G, B)"`, or `"rgba(R, G, B, A)"` |
| Multi-option scroll not working | Multi-option menus use mouse wheel (scroll up = control 14, scroll down = control 15). The interact key is always `E` for multi-option menus. |
| Fonts not loading | Ensure the `stream/` folder contains `IstokWeb-Bold.gfx` and `IstokWeb-Regular.gfx` |
| Textures missing | Ensure the `assets/` folder contains all required `.png` files and they are listed in `fxmanifest.lua` under `files` |

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-interact
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
