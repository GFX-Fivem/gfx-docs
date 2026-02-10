# GFX Attachment Remake

A weapon attachment bench system for FiveM that allows players to equip and remove weapon attachments through an interactive NUI interface at configurable workbench locations.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-attachment-remake` |
| **Frameworks** | ESX, QBCore |
| **Escrow** | No |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `es_extended` or `qb-core` | Yes | One framework must be running |
| SQL resource (`oxmysql`, `ghmattimysql`, or `mysql-async`) | Yes | Required for database operations when not using inventory-based storage |
| Inventory resource | Yes | Supports: `qb-inventory`, `ox_inventory`, `gfx-inventory`, `esx_inventoryhud`, `qs-inventory`, `codem-inventory`, `ps-inventory` |

## Installation

### 1. Import the SQL file

Import `data.sql` into your database. This creates the `gfx_attachments` table used for storing attachment data when not using inventory-based metadata (e.g., for ESX with basic inventories).

```sql
CREATE TABLE IF NOT EXISTS `gfx_attachments` (
  `identifier` varchar(255) DEFAULT NULL,
  `weaponName` varchar(255) DEFAULT NULL,
  `attachmentData` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
```

### 2. Copy the resource

Copy the `gfx-attachment-remake` folder into your server's resources directory.

### 3. Configure server.cfg

```cfg
ensure gfx-attachment-remake
```

### 4. Configure the script

Edit `shared/config.lua` to define your workbenches, weapons, and attachments. Edit `shared/server_config.lua` for server-side settings (player photo type, Discord bot token).

## Configuration

### shared/config.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `locale` | `string` | `"en"` | Language locale for UI text |
| `Benchs` | `table` | See below | List of workbench definitions (supports `"prop"`, `"coords"`, and `"createProp"` types) |
| `Items` | `table` | See below | Weapon and attachment definitions keyed by weapon hash name |
| `Types` | `table` | See below | Maps weapon component slot types to attachment category keys |

#### Bench Types

| Type | Description | Required Fields |
|------|-------------|----------------|
| `"prop"` | Uses an existing in-world prop model as the bench | `model` |
| `"coords"` | Uses a fixed coordinate position as the bench | `coords` (vector3) |
| `"createProp"` | Spawns a new prop at the specified location | `model`, `coords` (vector4) |

#### Bench Example

```lua
Benchs = {
    {
        type = "prop",
        model = "gr_prop_gr_bench_04a",
    },
    {
        type = "coords",
        coords = vector3(-2131.84, 3267.4, 32.81),
    },
    {
        type = "createProp",
        model = "gr_prop_gr_bench_04b",
        coords = vector4(-2136.1301, 3257.9106, 31.8103, -30.2677),
    }
}
```

#### Weapon / Attachment Example

```lua
Items = {
    ["weapon_assaultrifle"] = {
        label = "Assault Rifle",
        image = "assault_rifle.png",
        Attachments = {
            ["flashlight"] = {
                ["flashlight"] = {
                    component = "COMPONENT_AT_AR_FLSH",
                    label = "Flashlight",
                    item = "flashlight",
                    image = "flashlight.png",
                    description = "Tactical flashlight for better visibility.",
                    damageTag = false,
                    accuracyTag = true,
                    key = "flashlight",
                    name = "flashlight"
                }
            },
        }
    },
}
```

#### Attachment Fields

| Field | Type | Description |
|-------|------|-------------|
| `component` | `string` | GTA weapon component hash name (e.g., `"COMPONENT_AT_AR_FLSH"`) |
| `label` | `string` | Display name shown in the UI |
| `item` | `string` | Inventory item name required to equip this attachment |
| `image` | `string` | Image file name for the UI |
| `description` | `string` | Description text shown in the UI |
| `damageTag` | `boolean` | Whether this attachment affects weapon damage (UI indicator) |
| `accuracyTag` | `boolean` | Whether this attachment affects weapon accuracy (UI indicator) |
| `key` | `string` | Attachment slot category (e.g., `"clip"`, `"flashlight"`, `"grip"`, `"scope"`, `"silencer"`) |
| `name` | `string` | Internal attachment name identifier |

### shared/server_config.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PhotoType` | `string` | `"steam"` | Player avatar source. Options: `"steam"`, `"discord"` |
| `NoImage` | `string` | Discord CDN URL | Fallback image URL when player photo cannot be retrieved |
| `DiscordBotToken` | `string` | `"YOUR_DISCORD_BOT_TOKEN"` | Discord bot token for fetching player avatars (required if `PhotoType` is `"discord"`) |

## Exports

*No exports are created by this script.*

## Events

*No public API events are exposed by this script.* All communication between client and server uses an internal callback system.

## Commands

*No commands are registered by this script.*

## Features

- Interactive NUI-based weapon attachment interface with 3D weapon preview
- Three workbench placement modes: existing world props, fixed coordinates, or dynamically spawned props
- Equip and remove weapon attachments at workbenches
- 3D weapon object preview on the bench with camera focus and rotation controls (rotate weapon via UI directional controls)
- Attachment items are consumed from inventory on equip and returned on removal
- Damage and accuracy stat indicators for each attachment
- Multi-inventory support: `qb-inventory`, `ox_inventory`, `gfx-inventory`, `esx_inventoryhud`, `qs-inventory`, `codem-inventory`, `ps-inventory`
- Multi-SQL support: `oxmysql`, `ghmattimysql`, `mysql-async`
- Database-backed attachment storage for inventories that do not support weapon metadata (uses `gfx_attachments` table)
- Metadata-based attachment storage for inventories that support it (`qb-inventory`, `ox_inventory`, `gfx-inventory`)
- Automatic framework and inventory detection at startup
- Proximity-based interaction markers and help text prompts
- Localization support via `shared/locale.lua`
- Player avatar fetching (Steam or Discord) for UI display

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Workbench marker not appearing | Verify the bench configuration in `Config.Benchs`. For `"prop"` type, ensure the model exists in the game world. For `"createProp"`, check the model name is valid. |
| "Error" printed when opening menu | The `getWeapons` callback failed. Check server console for errors. Ensure your framework and inventory are properly detected (check startup print messages). |
| Attachments not saving | Ensure your SQL resource is running and the `gfx_attachments` table exists in your database. For inventory-based storage, verify your inventory resource is detected. |
| Script not detecting framework | The script auto-detects `es_extended` or `qb-core`. Ensure your framework resource is started before `gfx-attachment-remake` in `server.cfg`. |
| Script not detecting inventory | Ensure your inventory resource is started before this script. Check the server console for the initialization printout showing detected inventory. |
| Discord avatar not loading | Set `Config.DiscordBotToken` to a valid bot token in `shared/server_config.lua`. The bot must be in your Discord server. |
| Weapon preview not showing on bench | This requires the bench to have an object entity (works with `"createProp"` and `"prop"` types). The `"coords"` type may not support the 3D weapon preview camera. |
| Items not returning on attachment removal | Verify the attachment `item` field in `Config.Items` matches the actual item name in your inventory/database. |
