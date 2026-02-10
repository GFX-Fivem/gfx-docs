# gfx-radio

A FiveM radio prop script that attaches an interactive hand radio to the player with a DUI-powered screen, custom camera view, and interactive button support.

## Info

| Key | Value |
|-----|-------|
| **Author** | GFX Development |
| **Version** | 1.0.0 |
| **FX Version** | Cerulean |
| **Lua 5.4** | Yes |
| **Games** | GTA5, RDR3 |
| **Side** | Client + Server |

---

## Dependencies

| Dependency | Required | Notes |
|------------|----------|-------|
| **ESX** or **QBCore** | Yes | Auto-detected at runtime. One framework must be running. |

The script includes a built-in utility layer (`client/utils.lua`, `server/utils.lua`) that automatically detects and initializes the active framework. On the server side, it also auto-detects the active inventory system from the following: `qb-inventory`, `esx_inventoryhud`, `qs-inventory`, `codem-inventory`, `gfx-inventory`, `ox_inventory`, `ps-inventory`.

---

## Installation

### 1. Copy Files

Place the `gfx-radio` folder into your server's resources directory.

### 2. Streaming Assets

The `stream/` folder contains a custom radio prop model (`prop_cs_hand_radio.ydr`) and a texture (`texture_33.jpg`). These are automatically streamed by FiveM when the resource starts.

### 3. server.cfg

```cfg
ensure gfx-radio
```

---

## Configuration

Configuration is defined in `shared/sh_config.lua`.

```lua
Config = {
    prop = {
        model = "prop_cs_hand_radio",    -- Prop model name (streamed)
        screen_texture = "script_rt",     -- Texture name replaced by DUI screen
        animDict = "cellphone@",          -- Animation dictionary
        animName = "cellphone_text_read_base", -- Animation name
        boneIndex = 57005,                -- Ped bone to attach the prop to (right hand)
        offsetX = 0.14,                   -- Attachment X offset
        offsetY = 0.005,                  -- Attachment Y offset
        offsetZ = -0.02,                  -- Attachment Z offset
        rotX = 110.0,                     -- Attachment X rotation
        rotY = 105.0,                     -- Attachment Y rotation
        rotZ = -15.0,                     -- Attachment Z rotation
        buttons = {
            toggle = {
                offset = vector3(0.005, 0.005, 0.055), -- Button 3D offset from prop
                text = "Toggle Radio",                  -- Hover text label
            },
        }
    },
    debugButtons = true, -- Set to true to draw debug markers at button positions
    cam = {
        fov = 45.0,                                -- Camera field of view
        offset = vector3(0.1, 0.25, 0.75),         -- Camera offset from player
        rotation = vector3(-75.0, 10.0, -10.0)     -- Camera rotation
    },
}
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `prop.model` | string | `"prop_cs_hand_radio"` | The prop model name. A custom `.ydr` is streamed. |
| `prop.screen_texture` | string | `"script_rt"` | Texture name on the prop replaced by the DUI screen. |
| `prop.animDict` | string | `"cellphone@"` | Animation dictionary used when holding the radio. |
| `prop.animName` | string | `"cellphone_text_read_base"` | Animation played when holding the radio. |
| `prop.boneIndex` | number | `57005` | Ped bone index for prop attachment (right hand). |
| `prop.offsetX/Y/Z` | number | `0.14 / 0.005 / -0.02` | Position offset for prop attachment. |
| `prop.rotX/Y/Z` | number | `110 / 105 / -15` | Rotation offset for prop attachment. |
| `prop.buttons` | table | See above | Interactive buttons on the radio prop. Each button has an `offset` (vector3) and `text` (string). |
| `debugButtons` | boolean | `true` | Draws red markers at button positions for debugging. Set to `false` in production. |
| `cam.fov` | number | `45.0` | Camera field of view when viewing the radio. |
| `cam.offset` | vector3 | `(0.1, 0.25, 0.75)` | Camera position offset from the player. |
| `cam.rotation` | vector3 | `(-75.0, 10.0, -10.0)` | Camera rotation when viewing the radio. |

### Custom Notification

You can uncomment and define the `Config.Notify` function to override the default framework notification:

```lua
Config.Notify = function(message)
    -- Your custom notification logic
end
```

---

## Exports

*No active exports.* All DUI-related exports (`getDui`, `changeDuiUrl`, `releaseDui`, `sendDuiMessage`, `getDuiHandle`) are present in the code but commented out.

---

## Events

*No public API events.* All registered events are internal (framework initialization, callback system, resource cleanup).

---

## Commands

| Command | Description | Parameters |
|---------|-------------|------------|
| `/gfx-radio` | Opens the radio. Attaches the radio prop to the player, activates the scripted camera view, and enables NUI cursor interaction. | None |

---

## Features

- **Interactive Radio Prop** -- Attaches a custom hand radio prop (`prop_cs_hand_radio`) to the player's right hand with a hold animation.
- **DUI Screen** -- The radio prop's texture is replaced at runtime with an HTML-based DUI screen (`html/screen.html`), allowing dynamic content rendering on the prop.
- **Scripted Camera** -- When the radio is opened, a scripted camera is created and hard-attached to the player entity, providing a close-up view of the radio.
- **Interactive Buttons** -- Configurable buttons on the radio prop that are detected via 3D-to-screen coordinate projection. Hovering over a button shows a text label and changes the cursor style.
- **Debug Mode** -- Enable `debugButtons` to draw red markers at button positions for fine-tuning offsets.
- **Cursor Raycasting** -- Screen cursor position is translated to 3D world space for accurate button hit detection on the prop.
- **DUI Pooling** -- The DUI system pools and reuses DUI objects by resolution, reducing overhead when creating/destroying radio screens.
- **Multi-Framework Support** -- Automatically detects ESX or QBCore at startup.
- **Streamed Assets** -- Custom radio prop model and texture are included in the `stream/` folder.
- **Clean Resource Stop** -- Prop and animations are cleaned up on resource stop via `onResourceStop`.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Radio prop not visible | Ensure the `stream/` folder contains `prop_cs_hand_radio.ydr` and the resource is properly started. Check server console for streaming errors. |
| DUI screen is blank or not loading | Verify `html/screen.html` exists. Check that the `files` section in `fxmanifest.lua` includes `html/screen.html`. |
| Button hover not working | Adjust button `offset` values in `Config.prop.buttons`. Enable `debugButtons = true` to see marker positions. |
| Camera position looks wrong | Adjust `Config.cam.offset` and `Config.cam.rotation` values. |
| Animation not playing | Ensure `cellphone@` anim dict is valid and not blocked by another animation. |
| Framework not detected | Make sure `es_extended` or `qb-core` is started before `gfx-radio` in your `server.cfg`. |
| Console debug messages not showing | Set the convar `gfx-radio-debugMode` to `1` in your `server.cfg`: `set gfx-radio-debugMode 1`. |

---

## File Structure

```
gfx-radio/
├── fxmanifest.lua          # Resource manifest
├── shared/
│   └── sh_config.lua       # Configuration (prop, camera, buttons)
├── client/
│   ├── utils.lua           # Client utilities (framework init, helpers)
│   ├── cl_main.lua         # Main client logic (command, camera thread, buttons)
│   ├── cl_cam.lua          # Scripted camera creation/destruction
│   ├── cl_dui.lua          # DUI object management and pooling
│   └── cl_prop.lua         # Radio prop attachment and removal
├── server/
│   └── utils.lua           # Server utilities (framework init, inventory, callbacks)
├── html/
│   └── screen.html         # DUI HTML screen rendered on the radio prop
└── stream/
    ├── prop_cs_hand_radio.ydr  # Custom radio prop model
    └── texture_33.jpg          # Prop texture
```
