# gfx-weed

A comprehensive weed farming, processing, and selling system for FiveM. Players can plant seeds, grow plants with a genetics system, water and fertilize them, harvest buds or seeds, roll joints on processing tables, and sell joints to NPCs on the street.

---

## Info

| Key | Value |
|-----|-------|
| **Author** | GFX Development |
| **Version** | 1.0.0 |
| **FX Version** | Cerulean |
| **Lua 5.4** | Yes |
| **Games** | GTA5, RDR3 |
| **UI** | Yes (React NUI) |
| **Framework** | ESX / QBCore (auto-detected) |
| **Database** | oxmysql / ghmattimysql / mysql-async (auto-detected) |
| **Inventory** | qb-inventory, ox_inventory, qs-inventory, ps-inventory, codem-inventory, gfx-inventory, esx_inventoryhud (auto-detected) |

---

## Dependencies

- **Framework:** `es_extended` (ESX) or `qb-core` (QBCore)
- **Database:** `oxmysql`, `ghmattimysql`, or `mysql-async`
- **Inventory:** One of: `qb-inventory`, `ox_inventory`, `qs-inventory`, `ps-inventory`, `codem-inventory`, `gfx-inventory`, `esx_inventoryhud`
- **Discord Bot Token** (optional, for player avatar fetching)

---

## Installation

### 1. Import SQL

Import the `planted_weeds.sql` file into your database:

```sql
CREATE TABLE IF NOT EXISTS `planted_weeds` (
  `id` varchar(50) DEFAULT NULL,
  `grower` varchar(50) DEFAULT NULL,
  `coords` longtext DEFAULT NULL,
  `plantTime` int(11) DEFAULT NULL,
  `stage` int(11) DEFAULT 1,
  `health` float DEFAULT 100,
  `water` float DEFAULT 100,
  `ground` float DEFAULT 100,
  `quality` float DEFAULT 100,
  `drying` float DEFAULT 100,
  `growth` float DEFAULT 100,
  `genetics` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
```

### 2. Copy Files

Copy the `gfx-weed` folder into your server's resources directory.

### 3. server.cfg

```cfg
ensure gfx-weed
```

### 4. Add Items to Your Inventory

Make sure the following items exist in your inventory system:

| Item Name | Purpose | Config Key |
|-----------|---------|------------|
| `weed_skunk_seed` | Planting seeds | `Config.Seed_Item` |
| `crack_baggy` | Harvested weed buds | `Config.Bud_Item` |
| `rolling_paper` | Rolling papers for joints | `Config.Paper_Item` |
| `joint` | Finished joint product | `Config.Joint_Item` |
| `water_bottle` | Watering plants | `Config.WaterItem` |
| `scissors` | Trimming / harvesting plants | `Config.TrimmerItem` |
| `fertilizer` | Fertilizing plants | `Config.FertilizerItem` |

---

## Configuration

### Client Config (`config/client_config.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PlayerLoadedEvent` | string | `"playerSpawned"` | Event triggered when player loads |
| `Theme` | table | _see below_ | NUI color theme settings (primary, secondary colors with opacity) |
| `Notify` | function/nil | `nil` | Custom notification function. Uncomment and set your own export to override framework notifications |
| `backpackprop` | string | `"sf_prop_sf_backpack_01a"` | Prop model for the backpack on rolling tables |
| `WaterItem` | string | `"water_bottle"` | Item name for watering plants |
| `TrimmerItem` | string | `"scissors"` | Item name for trimming/harvesting plants |
| `FertilizerItem` | string | `"fertilizer"` | Item name for fertilizing plants |
| `Decrease_Player_Alpha` | boolean | `true` | Makes the player semi-transparent when interacting with plants/tables |
| `EnableSelling` | boolean | `true` | Enable or disable the NPC selling system |
| `Table_Display_Distance` | float | `10.0` | Distance at which processing tables render |
| `Table_Types` | table | _see config_ | Define table types with props, camera, and grid layout for rolling |
| `Tables` | table | _see config_ | List of processing table locations (id, name, coords, heading, type) |
| `Plant_Cam_Settings` | table | `offset: (0, 1.25, 2.5)` | Camera position offsets when interacting with a plant |
| `MudObject` | hash | `mud_decal_farming` | Decal prop used as water indicator under plants |
| `PlantObjects` | table | _6 stages_ | Prop models for each growth stage (1-6) |
| `MaterialQualities` | table | _see config_ | Ground material types and their quality ranges (min/max). Only surfaces listed here allow planting |

### Server Config (`config/server_config.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PhotoType` | string | `"steam"` | Player avatar source: `"steam"` or `"discord"` |
| `NoImage` | string | _URL_ | Fallback image URL when avatar is unavailable |
| `DiscordBotToken` | string | `"YOUR_DISCORD_BOT_TOKEN"` | Discord bot token for fetching player avatars |
| `Notify` | function/nil | `nil` | Custom server-side notification function |
| `Seed_Item` | string | `"weed_skunk_seed"` | Item name for weed seeds |
| `Bud_Item` | string | `"crack_baggy"` | Item name for harvested weed buds |
| `Paper_Item` | string | `"rolling_paper"` | Item name for rolling papers |
| `Joint_Item` | string | `"joint"` | Item name for rolled joints |
| `Joint_Price` | number | `50` | Money earned per joint sale |
| `GrowthMultiplier` | number | `1` | Multiplier for plant growth speed (higher = faster) |
| `PedChances` | table | _see config_ | Ped model hashes mapped to buy probability (0-100). Peds not in this list will call cops instead of buying |

### Locale (`config/locale.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Locale` | string | `"en"` | Active language code |
| `Locales` | table | _English strings_ | Translation strings for UI and notifications |

---

## Exports

No exports are created by this script.

---

## Events

### Client Events

#### `gfx-weed:plant:place`
Triggered by the server when a player uses a seed item. Starts the plant placement preview on the client.

```lua
-- Triggered server -> client automatically when seed item is used
-- Parameters:
--   itemData (table) - The item data from inventory, may contain itemData.info.genetics
```

#### `gfx-weed:sync:syncWeed`
Synchronizes plant data from the server to the client for nearby plants.

```lua
-- Triggered server -> client
-- Parameters:
--   data (table) - Table of weed data keyed by plant ID
```

#### `gfx-weed:sync:addWeed`
Notifies all clients that a new plant has been placed.

```lua
-- Triggered server -> all clients
-- Parameters:
--   weed (table) - Full weed data { id, coords, stage, growth, health, water, ground, quality, drying, genetics, plantTime }
```

#### `gfx-weed:sync:deleteWeed`
Notifies all clients that a plant has been removed (harvested, destroyed, or burned).

```lua
-- Triggered server -> all clients
-- Parameters:
--   id (string) - The plant ID to remove
```

#### `gfx-weed:client:openTable`
Opens a processing table interaction. Can be triggered locally or from another script.

```lua
-- Parameters:
--   id (number) - The table ID from Config.Tables
TriggerEvent("gfx-weed:client:openTable", tableId)
```

### Server Events

#### `gfx-weed:server:syncWeed`
Client requests plant data sync from the server for a set of plant IDs.

```lua
-- Triggered client -> server
-- Parameters:
--   requestList (table) - Table of plant IDs mapped to true, e.g. { ["abc123"] = true }
```

---

## Commands

| Command | Description | Access |
|---------|-------------|--------|
| `/cancelsell` | Cancels the current selling interaction with an NPC, clears animations and camera | Player |
| `/weedprint` | Toggles debug printing of plant tick data in server console | Console only (source must be 0) |

---

## Features

### Planting System
- Use the seed item to enter placement mode with a ghost preview object
- The preview shows green (valid) or red (invalid) placement based on ground material
- Ground material type determines initial ground quality (configurable via `MaterialQualities`)
- Plants cannot be placed too close to existing plants (proximity check)
- Planting triggers a gardening animation before the plant is created

### Growth & Genetics System
- Plants grow through 6 stages, each with a different prop model
- Growth is affected by genetics, ground quality, and a configurable growth multiplier
- **Genetics** are a 6-character string using genes: `G` (Growth Rate), `Y` (Yield), `H` (Hardiness), `W` (Water Intake), `X` (Null)
- When multiple plants are close together (within 1 unit), genetics crossbreed using a weighted probability system
- Seeds planted from harvested seeds carry the parent plant's genetics

### Plant Care
- **Watering:** Click the watering can when interacting with a plant. Requires a water item. Adds 70-80 water. Animated with particle effects
- **Fertilizing:** Click the fertilizer bucket. Requires a fertilizer item. Adds 15-25 ground quality. Animated with particle effects
- **Trimming/Harvesting:** Click the trimmer tool
  - If the plant is at stage 3-5, you can harvest seeds (amount based on quality)
  - If the plant is at stage 6 with 85%+ growth, you can harvest buds (yield based on quality, health, growth, drying, and genetics)

### Plant Health
- Water drops over time based on water intake genetics
- If water falls below 30, health decreases (mitigated by hardiness genetics)
- If water stays above 65, quality and health improve
- Plants can be destroyed by nearby fires (fire proximity detection)

### NUI Interface
- Real-time plant status display when looking at a plant (growth, health, water, ground quality, stage, genetics, age)
- Interactive camera system for plant and table interactions
- Configurable color theme
- Dot indicator when looking at NPCs for selling

### Processing Tables
- Pre-configured table locations with weed processing props
- Interactive drag-and-drop system: place a bud on rolling paper, right-click to roll, drag joint into backpack
- Rolling a joint consumes 1 bud + 1 rolling paper, produces 1 joint
- Tables auto-spawn/despawn based on player proximity

### Selling System
- Aim at NPCs on the street while having joints in inventory
- Press the interact key to approach the NPC and initiate a sale
- NPC purchase chance is based on ped model (configured in `PedChances`)
- If the NPC model is not in the list, cops are alerted instead
- Selling plays walk-up and handshake animations with a cinematic camera
- Configurable joint price

### Database Persistence
- All planted weed data is stored in the `planted_weeds` database table
- Plant state is periodically saved to the database (every ~100 seconds)
- Plants persist across server restarts

### Framework Compatibility
- Auto-detects ESX or QBCore framework
- Auto-detects inventory system from 7 supported inventories
- Auto-detects SQL library from 3 supported options
- Custom notification support via config override

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Plants not appearing | Ensure the `planted_weeds` SQL table is imported. Check that your database resource (oxmysql/ghmattimysql/mysql-async) is started before gfx-weed |
| Cannot plant anywhere | Verify that the ground material at the location is listed in `Config.MaterialQualities`. Only surfaces in this table allow planting |
| Items not working | Make sure all 7 items (seed, bud, paper, joint, water, scissors, fertilizer) are registered in your inventory system with the exact names from the config |
| Seed item does nothing | The seed item must be registered as a useable item. The script handles this via `RegisterItem` automatically -- ensure your framework and inventory are detected (check server console for initialization log) |
| Tables not showing | Check that `Config.Tables` coordinates are correct and that you are within `Config.Table_Display_Distance` (default 10 units) |
| NPC selling not working | Verify `Config.EnableSelling` is `true`, you have joints in inventory, and the NPC model hash is in `Config.PedChances` |
| Cops always called when selling | The NPC ped model you are targeting is not in the `PedChances` table. Add the ped model hash with a buy chance percentage |
| Avatars not loading | If using `"discord"` photo type, ensure `Config.DiscordBotToken` is set to a valid bot token |
| Plants not growing | Check that the server-side tick loop is running (no errors in console). Increase `Config.GrowthMultiplier` for faster growth |
| Joint rolling fails | Ensure you have both a bud item and a rolling paper item in your inventory. Drag bud onto paper, right-click to roll, then drag into the backpack |
