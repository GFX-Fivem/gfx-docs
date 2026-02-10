# GFX Airdrop

Automated airdrop system that spawns loot crates at random map locations on a configurable timer. Includes an admin NUI panel for creating, viewing, and deleting airdrops, with Discord webhook logging and a chance-based item reward system.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-airdrop` |
| **Frameworks** | ESX / QBCore (auto-detected) |
| **Escrow** | Yes |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `es_extended` or `qb-core` | Yes | One framework must be running; auto-detected at startup |
| An inventory resource | Yes | Supports: `qb-inventory`, `esx_inventoryhud`, `qs-inventory`, `codem-inventory`, `gfx-inventory`, `ox_inventory`, `ps-inventory` |

## Installation

1. Place the `gfx-airdrop` folder into your server's resources directory.
2. Add the following to your `server.cfg`:
   ```cfg
   ensure gfx-airdrop
   ```
3. Configure the files inside `config/` and the `cl-config.lua` / `sv-config.lua` files to match your server's setup.
4. (Optional) Set the Discord webhook URL in `server/utils.lua` (`DiscordWebhook` variable) to enable Discord logging.
5. (Optional) Set your Discord bot token in `config/server_config.lua` if you want Discord avatar support.

## Configuration

### config/locale.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Locale` | string | `"en"` | Active locale key. Supported: `"en"`, `"fr"` |
| `Locales` | table | see file | Translation strings keyed by locale code |

### config/client_config.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.Theme["primary"]` | string | `"#ff4f22"` | Primary UI color |
| `Config.Theme["primary-content"]` | string | `"#900000"` | Primary content color |
| `Config.Theme["primary-opacity"]` | string | `"rgba(255, 47, 47, 0.2)"` | Primary color with opacity |
| `Config.Theme["secondary"]` | string | `"#FF2F2F"` | Secondary UI color |
| `Config.Theme["secondary-content"]` | string | `"#900000"` | Secondary content color |
| `Config.Theme["secondary-opacity"]` | string | `"rgba(255, 47, 47, 0.2)"` | Secondary color with opacity |

### config/server_config.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.PhotoType` | string | `"steam"` | Player photo source. Options: `"steam"`, `"discord"` |
| `Config.NoImage` | string | URL | Fallback image when no player photo is found |
| `Config.DiscordBotToken` | string | `"YOUR_DISCORD_BOT_TOKEN"` | Discord bot token for fetching player avatars (only needed if `PhotoType` is `"discord"`) |

### client/cl-config.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.InteractionKey` | number | `38` | Key control ID for interacting with airdrops (38 = E). See [FiveM Controls](https://docs.fivem.net/docs/game-references/controls/) |
| `Config.playerLoadedEvent` | string | `"rush_core:playerLoaded"` | Event name triggered when a player loads. Change to match your framework (e.g. `"esx:playerLoaded"` or `"QBCore:Client:OnPlayerLoaded"`) |
| `Config.AirDropSettings.airDropModel` | string | `"prop_mb_cargo_04a"` | Prop model used for the airdrop crate |
| `Config.AirDropSettings.blipsetting[1]` | table | see below | First blip displayed at the airdrop location (signal blip) |
| `Config.AirDropSettings.blipsetting[1].blipSprite` | number | `161` | Blip sprite ID |
| `Config.AirDropSettings.blipsetting[1].blipColor` | number | `1` | Blip color ID |
| `Config.AirDropSettings.blipsetting[1].blipScale` | number | `0.8` | Blip scale |
| `Config.AirDropSettings.blipsetting[1].blipText` | string | `"AirDrop Signal"` | Blip label on the map |
| `Config.AirDropSettings.blipsetting[2]` | table | see below | Second blip displayed at the airdrop location (crate blip) |
| `Config.AirDropSettings.blipsetting[2].blipSprite` | number | `842` | Blip sprite ID |
| `Config.AirDropSettings.blipsetting[2].blipColor` | number | `46` | Blip color ID |
| `Config.AirDropSettings.blipsetting[2].blipScale` | number | `1.1` | Blip scale |
| `Config.AirDropSettings.blipsetting[2].blipText` | string | `"AirDrop Crate"` | Blip label on the map |
| `Config.AirDropSettings.areaBlipSettings.areaBlipColor` | number | `6` | Color of the radius area blip |
| `Config.AirDropSettings.areaBlipSettings.areaBlipRadius` | number | `80.0` | Radius (in game units) of the area blip around the airdrop |

### server/sv-config.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `SvConfig.AirDropItems` | table | see file | Array of possible airdrop reward items. Each entry has `item` (spawn name), `label` (display name), `count` (quantity), `chance` (drop weight), and `color` (hex color for UI) |
| `SvConfig.AirDropLocations` | table | 13 vectors | Predefined `vector3` coordinates where airdrops can spawn |
| `SvConfig.TimeSettings.dropdeleteCountdown` | number | `180` | Seconds before an uncollected (opened) airdrop is automatically deleted |
| `SvConfig.TimeSettings.dropCollectTime` | number | `420` | Seconds after spawn before the airdrop becomes openable (lock time) |
| `SvConfig.TimeSettings.AirDropCoolDown` | number | `30` | Cooldown in **minutes** between automatic airdrop spawns |
| `SvConfig.AirdropSettings.minPlayerCount` | number | `20` | Minimum online player count required for automatic airdrops |
| `SvConfig.AirdropSettings.maxAirdropcount` | number | `3` | Maximum number of active airdrops at the same time |

## Exports

This script does not create any exports.

## Events

### Client Events

#### `gfx-airdrop:CreateAirDrop`
Triggered by the server to all clients when a new airdrop is created. Spawns the crate object, blips, and particle effects on the client.

| Parameter | Type | Description |
|-----------|------|-------------|
| `airdropTable` | table | Airdrop data containing `id`, `coords` (vector3), `canOpen` (bool), `clock` (timestamp), `opencooldown` (number), `includeItems` (table), `createdTime` (timestamp) |

```lua
-- Example: Listen for new airdrop creation
RegisterNetEvent('gfx-airdrop:CreateAirDrop')
AddEventHandler('gfx-airdrop:CreateAirDrop', function(airdropTable)
    print("New airdrop created with ID: " .. airdropTable.id)
end)
```

#### `gfx-airdrop:RemoveDrop`
Triggered by the server to all clients when an airdrop is removed (collected, expired, or admin-deleted). Cleans up the crate entity, blips, and particle effects.

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | number | The unique ID of the airdrop to remove |

```lua
RegisterNetEvent('gfx-airdrop:RemoveDrop')
AddEventHandler('gfx-airdrop:RemoveDrop', function(id)
    print("Airdrop " .. id .. " has been removed")
end)
```

#### `gfx-airdrop:update`
Triggered by the server to all clients when an airdrop's lock timer expires and it becomes openable.

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | number | The unique ID of the airdrop that is now openable |

```lua
RegisterNetEvent('gfx-airdrop:update')
AddEventHandler('gfx-airdrop:update', function(id)
    print("Airdrop " .. id .. " is now open for collection")
end)
```

#### `gfx-airdrop:Announce`
Triggered by the server to display a notification announcement to players (e.g., incoming airdrop).

| Parameter | Type | Description |
|-----------|------|-------------|
| `text` | string | The announcement text |

```lua
RegisterNetEvent('gfx-airdrop:Announce')
AddEventHandler('gfx-airdrop:Announce', function(text)
    print("Announcement: " .. text)
end)
```

#### `gfx-airdrop:Notify`
Triggered by the server to show a notification to a specific player.

| Parameter | Type | Description |
|-----------|------|-------------|
| `text` | string | The notification text |

```lua
RegisterNetEvent('gfx-airdrop:Notify')
AddEventHandler('gfx-airdrop:Notify', function(text)
    print("Notification: " .. text)
end)
```

### Server Events

#### `gfx-airdrop:server:OpenAirDrop`
Triggered by a client when a player interacts with an openable airdrop. Gives items to the player, logs to Discord, and removes the crate.

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | number | The unique ID of the airdrop to open |

```lua
-- Example: Trigger from client side
TriggerServerEvent('gfx-airdrop:server:OpenAirDrop', airdropId)
```

## Commands

| Command | Permission | Description |
|---------|------------|-------------|
| `/airdrops` | Admin | Opens the NUI admin panel to view, create, and delete active airdrops |
| `/airdrop` | Admin | Creates a new airdrop at a random predefined location with random items |
| `/airdropdelete` | Admin | Deletes all active airdrops from the map |
| `/cmddrop` | Console only | Creates a new airdrop from the server console (source must be 0) |
| `/getdrops` | None | Debug command that prints all active airdrop data to the client console |

## Features

- Automatic airdrop spawning on a configurable timer when minimum player count is met
- Chance-based random item selection with configurable drop weights
- Lock timer system: airdrops must "unlock" before players can collect them
- Auto-deletion of uncollected airdrops after a configurable timeout
- Dual map blips per airdrop (signal blip + crate blip) with a colored area radius blip
- Flare particle effect at crate location for visual identification
- 3D floating text showing countdown timer and interaction prompt
- Sound alert when a player is within 30 units of an airdrop
- NUI-based admin panel for creating airdrops at specific coordinates, selecting items, and managing active drops
- Admin panel supports setting waypoints to airdrop locations
- Discord webhook logging for airdrop creation, collection, and expiration
- Player avatar support (Steam or Discord) for the NUI panel
- Multi-framework support: auto-detects ESX or QBCore
- Multi-inventory support: works with 7 different inventory systems
- Coordinate deduplication to prevent multiple airdrops spawning at the same location
- Configurable UI theme colors for the NUI panel
- Localization support with `_L()` translation function

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Airdrops never spawn automatically | Check that `SvConfig.AirdropSettings.minPlayerCount` is not higher than your usual player count. Lower the value or ensure enough players are online. |
| Crate model not appearing | Ensure the model name in `Config.AirDropSettings.airDropModel` is valid. If using a custom model like `"mertrix_airdrop"`, make sure the stream asset is installed. Default `"prop_mb_cargo_04a"` is a built-in GTA V prop. |
| "Airdrop is not ready to open yet" message | The airdrop has a lock time (`SvConfig.TimeSettings.dropCollectTime`). Wait for the countdown timer shown in the 3D text above the crate to reach zero. |
| Discord avatars not loading | Verify that `Config.DiscordBotToken` in `config/server_config.lua` is set to a valid bot token, and that the bot has access to the Discord API. |
| Discord webhook logs not sending | Set the `DiscordWebhook` variable in `server/utils.lua` to your Discord webhook URL. |
| Admin commands not working | Admin permission is checked via framework. For QBCore, the player needs `admin`, `superadmin`, or `god` permission. For ESX, the player must have `admin` or `superadmin` group. |
| Items not being given on airdrop open | Ensure your inventory system is supported and running. Check that the item names in `SvConfig.AirDropItems` match the item names registered in your inventory/framework. |
| Interaction key not working | Player must be within 3.0 units of the crate to open it (within 30.0 units to see the prompt). Check `Config.InteractionKey` matches your desired control. |
