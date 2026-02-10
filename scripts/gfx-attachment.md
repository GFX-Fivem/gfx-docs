# GFX Attachment

A weapon attachment customization script for FiveM that allows players to equip and remove weapon attachments (clips, scopes, grips, flashlights, suppressors) through an interactive workbench UI with a 3D weapon preview.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-attachment` |
| **Frameworks** | QBCore (qb/newqb), ESX (esx/newesx), Standalone |
| **Escrow** | Yes |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `qb-core` | Yes (if QBCore) | Framework core for QBCore servers |
| `es_extended` | Yes (if ESX) | Framework core for ESX servers |
| `qb-target` | No | Optional targeting system; only needed if `Config.Target.enable = true` |
| SQL resource | Yes (if ESX) | One of: `oxmysql`, `ghmattimysql`, or `mysql-async` -- used to store attachment data for ESX framework |
| Inventory resource | Yes | One of: `qb-inventory`, `esx_inventoryhud`, `qs-inventory`, `codem-inventory`, `gfx-inventory`, `ox_inventory`, `ps-inventory` |

## Installation

### 1. Add the resource files
Copy the `gfx-attachment` folder into your server's resources directory.

### 2. Import the SQL file (ESX only)
If you are using ESX, import `attachment.sql` into your database. This creates the `gfx_attachments` table used to persist attachment data.

```sql
CREATE TABLE IF NOT EXISTS `gfx_attachments` (
  `identifier` varchar(255) DEFAULT NULL,
  `weaponName` varchar(255) DEFAULT NULL,
  `attachmentData` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
```

### 3. Add items to your inventory
Ensure the attachment items exist in your inventory/item system. Default item names used in config:
- `clip_attachment`
- `extendedclip_attachment`
- `drum_attachment`
- `flashlight_attachment`
- `grip_attachment`
- `scope_attachment`
- `suppressor_attachment`

### 4. Place workbench props in your map
The script uses `gr_prop_gr_bench_04b` as the default interaction model. Place this prop in your world or add custom models to `Config.OpenModels`.

### 5. server.cfg
```cfg
ensure gfx-attachment
```

## Configuration

### General

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Framework` | `string` | `"newqb"` | Framework to use. Options: `"esx"`, `"newesx"`, `"qb"`, `"newqb"`, `"standalone"` |
| `OpenModels` | `table` | `{gr_prop_gr_bench_04b}` | List of prop model hashes that act as weapon workbenches |
| `WeaponHeightOffset` | `number` | `1.0` | Vertical offset for the weapon preview object above the workbench |

### Target (qb-target integration)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Target.enable` | `boolean` | `false` | Enable qb-target interaction on workbench models |
| `Target.text` | `string` | `"Modify Weapon"` | Label shown on the target eye |
| `Target.icon` | `string` | `"fas fa-wrench"` | FontAwesome icon for the target option |

### DrawText (3D text interaction)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `DrawText.enable` | `boolean` | `true` | Enable 3D floating text prompt near workbenches |
| `DrawText.text` | `string` | `"Press ~g~[E]~s~ to modify weapon"` | Text displayed above the workbench |
| `DrawText.distance` | `number` | `1.5` | Maximum distance to show the draw text prompt |
| `DrawText.control` | `number` | `46` | Control key ID to open the menu (46 = E) |

### Camera Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `CamOptions.CamCoordOffset` | `vector3` | `vector3(0.0, 0.0, 0.0)` | Offset for the camera position relative to the player |
| `CamOptions.CamPointOffset` | `vector3` | `vector3(0.0, 0.0, 1.025)` | Offset for the camera focus point relative to the workbench |

### Attachments

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Attachments` | `table` | *(see config.lua)* | Nested table mapping weapon names to their available attachment categories, each containing attachment entries with `component`, `label`, and `item` fields |

Each attachment entry has the following structure:

| Field | Type | Description |
|-------|------|-------------|
| `component` | `string` | GTA weapon component hash name (e.g. `"COMPONENT_AT_AR_SUPP_02"`) |
| `label` | `string` | Display name shown in the UI |
| `item` | `string` | Inventory item name required to equip this attachment |
| `image` | `string` | *(Optional)* Custom image filename override for the UI |

Example attachment config entry:

```lua
["weapon_assaultrifle"] = {
    ["clip"] = {
        ["default_clip"] = {
            component = "COMPONENT_ASSAULTRIFLE_CLIP_01",
            label = "Default Clip",
            item = "clip_attachment",
        },
        ["extended_clip"] = {
            component = "COMPONENT_ASSAULTRIFLE_CLIP_02",
            label = "Extended Clip",
            item = "extendedclip_attachment",
        },
    },
    ["silencer"] = {
        ["silencer"] = {
            component = "COMPONENT_AT_AR_SUPP_02",
            label = "Suppressor",
            item = "suppressor_attachment",
        },
    },
}
```

### Weapon Details (ESX only)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `WeaponDetails` | `table` | *(see config.lua)* | Weapon metadata for ESX framework (label, description, image) since ESX does not have shared weapon item data like QBCore |

### Types

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Types` | `table` | *(see config.lua)* | Mapping from GTA bone names to attachment category names. **Do not modify.** |

### Locales

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Locales` | `table` | *(see config.lua)* | Display labels for attachment types and bone names used in the UI |

## Exports

*No exports are created by this script.*

## Events

### `gfx-attachment:client:open`

**Side:** Client

Opens the weapon attachment UI for the player. This event is triggered internally when the player interacts with a workbench (via DrawText or qb-target), but can also be triggered from other scripts to open the attachment menu programmatically.

| Parameter | Type | Description |
|-----------|------|-------------|
| *(none)* | - | This event takes no parameters |

```lua
-- Open the attachment UI from another client script
TriggerEvent("gfx-attachment:client:open")
```

### `gfx-attachment:server:saveWeapon`

**Side:** Server

Saves or removes a weapon attachment for a player. Handles both equipping (removes the attachment item from inventory and saves it to the weapon) and unequipping (returns the item to inventory and removes from weapon data).

| Parameter | Type | Description |
|-----------|------|-------------|
| `action` | `string` | `"equip"` to add an attachment, `"unequip"` to remove one |
| `weaponName` | `string` | The weapon identifier (e.g. `"weapon_assaultrifle"`) |
| `attachmentKey` | `string` | The attachment category (e.g. `"silencer"`, `"clip"`, `"scope"`) |
| `attachmentName` | `string` | The specific attachment key within the category (e.g. `"extended_clip"`) |
| `slot` | `number` | The inventory slot of the weapon (used by QBCore for item metadata updates) |

```lua
-- Equip an attachment from a server script
TriggerServerEvent("gfx-attachment:server:saveWeapon", "equip", "weapon_assaultrifle", "silencer", "silencer", 1)

-- Unequip an attachment from a server script
TriggerServerEvent("gfx-attachment:server:saveWeapon", "unequip", "weapon_assaultrifle", "clip", "extended_clip", 1)
```

## Commands

| Command | Permission | Description |
|---------|------------|-------------|
| `/bench` | None | Debug command. Spawns a workbench prop (`gr_prop_gr_bench_04b`) at a hardcoded coordinate for testing purposes. |
| `/setattachments` | None | Debug command. Applies all configured attachments for `weapon_assaultrifle` to the currently previewed weapon object. |
| `/removeattachments` | None | Debug command. Removes all configured attachments for `weapon_assaultrifle` from the currently previewed weapon object. |

## Features

- Interactive weapon workbench with NUI-based user interface
- 3D weapon preview with rotatable camera (rotate weapon left/right/up/down from UI)
- Visual bone-point indicators showing attachment slots on the weapon model
- Supports multiple interaction methods: 3D DrawText prompt or qb-target
- Equip and unequip attachments with inventory item requirements
- Attachment categories: clips/magazines, scopes, grips, flashlights, suppressors
- Persistent attachment storage -- QBCore uses weapon item metadata, ESX uses a MySQL database table
- Automatic attachment re-application on weapon equip (ESX/standalone)
- Multi-framework support with automatic framework and inventory detection
- Compatible with multiple inventory systems (qb-inventory, ox_inventory, qs-inventory, ps-inventory, codem-inventory, gfx-inventory, esx_inventoryhud)
- Fully configurable weapon and attachment definitions per weapon type
- Escrow-protected with open config for customization

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Workbench prompt not appearing | Verify `Config.DrawText.enable` is `true` and that the `gr_prop_gr_bench_04b` prop (or your custom model) exists in the world. Check that the model hash is in `Config.OpenModels`. |
| Target eye not showing on workbench | Ensure `Config.Target.enable` is `true` and `qb-target` is started before `gfx-attachment`. |
| No weapons shown in the UI | Make sure the player has weapon items in their inventory whose names contain `weapon_`. Verify your inventory resource is running and supported. |
| Attachments not saving (ESX) | Import `attachment.sql` into your database. Ensure one of the supported SQL resources (`oxmysql`, `ghmattimysql`, `mysql-async`) is running. |
| Attachment item not found | Add the attachment item names (e.g. `clip_attachment`, `scope_attachment`) to your inventory/item configuration (QBCore shared items or your inventory system). |
| Framework not detected | Check that `Config.Framework` matches your server setup. Valid values: `"esx"`, `"newesx"`, `"qb"`, `"newqb"`, `"standalone"`. |
| Camera angle looks wrong | Adjust `Config.CamOptions.CamCoordOffset` and `Config.CamOptions.CamPointOffset` to fit your workbench placement. |
| Attachments not re-applied on weapon equip | This auto-apply feature only works on `esx`, `newesx`, and `standalone` frameworks. QBCore stores attachments in item metadata and applies them through its own weapon system. |
