# gfx-dailygift

A daily gift/reward system for FiveM servers. Players interact with an NPC to claim sequential daily rewards on a 24-hour cooldown. Supports item, money, and vehicle rewards with a NUI interface. After claiming all rewards, the cycle resets.

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx-dailygift` |
| **Frameworks** | QBCore, ESX |
| **Side** | Client + Server |
| **Database** | MySQL (oxmysql) |
| **UI** | NUI (HTML/CSS/JS) |

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| [oxmysql](https://github.com/overextended/oxmysql) | Database queries |
| [gfx-base](https://github.com/gfx-fivem/gfx-base) | Framework abstraction (player data, inventory, notifications) |

---

## Installation

### 1. Import the SQL file

Run the included `dailygifts.sql` in your database to create the required table:

```sql
CREATE TABLE IF NOT EXISTS `dailygifts` (
  `identifier` longtext DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  `collected` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 2. Add the resource to your server

Copy the `gfx-dailygift` folder into your server's resources directory.

### 3. Configure server.cfg

```cfg
ensure oxmysql
ensure gfx-base
ensure gfx-dailygift
```

Make sure `gfx-base` and `oxmysql` start before `gfx-dailygift`.

---

## Configuration

All configuration is done in `config.lua`.

### General Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `MenuCommand` | `string` | `"dailygift"` | Chat command to open the daily gift menu |
| `Parking` | `boolean` | `true` | Whether to include parking data when inserting vehicles (ESX only) |
| `InventoryImagePath` | `string` | `"qb-inventory/html/images"` | Path to inventory item images for the NUI |

### NPC / Ped Settings

Configured under `Config.Ped`:

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Coords` | `vector4` | `-1037.61, -2737.55, 19.17, 325.42` | NPC spawn position and heading |
| `Ped` | `string` | `"a_m_m_skater_01"` | Ped model name |
| `Text` | `string` | `"Press ~INPUT_CONTEXT~ to open the daily gift menu."` | Help text shown when near the NPC |
| `Blip.Sprite` | `number` | `480` | Blip sprite ID on the map |
| `Blip.Color` | `number` | `0` | Blip color ID |
| `Blip.Label` | `string` | `"Daily Gift"` | Blip label on the map |
| `Blip.Scale` | `number` | `0.8` | Blip size on the map |

### Reward Items

Configured under `Config.Items` as a sequential numbered table. Each entry represents one day in the reward cycle. After all items are claimed, the cycle resets to day 1.

```lua
Config.Items = {
    [1] = {
        item = "armor",       -- Item name or vehicle spawn name
        label = "Armor",      -- Display label in UI
        image = "armor.png",  -- Image filename (from InventoryImagePath)
        count = 3,            -- Amount to give
        -- type = "vehicle",  -- Optional: set to "vehicle" for vehicle rewards
    },
    -- ...
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `item` | `string` | Yes | Item name for inventory items, or vehicle spawn name for vehicles |
| `label` | `string` | Yes | Display name shown in the NUI |
| `image` | `string` | Yes | Image filename for the NUI (loaded from `InventoryImagePath`) |
| `count` | `number` | Yes | Quantity to give (use `1` for vehicles) |
| `type` | `string` | No | Set to `"vehicle"` to give a vehicle instead of an item |

### Locales

Configured under `Config.Locales`:

| Key | Default | Description |
|-----|---------|-------------|
| `you_got_reward` | `"You got your daily reward!"` | Notification shown after claiming a reward |

---

## Exports

This script does not create any exports.

---

## Events

This script does not expose any public API events for external use. All events are internal to the client-server communication of this resource.

---

## Commands

| Command | Access | Description |
|---------|--------|-------------|
| `/{MenuCommand}` (default: `/dailygift`) | All players | Opens the daily gift NUI menu. Creates player data in the database on first use. |
| `/createDailyData` | Admin only | Resets the executing player's daily gift progress (index and collected timestamp). |

Players can also open the menu by approaching the NPC and pressing **E** (INPUT_CONTEXT).

---

## Features

- **Sequential daily rewards** -- Players progress through a configurable list of rewards, one per day, with a 24-hour cooldown between claims.
- **Automatic cycle reset** -- After claiming the final reward, the cycle resets to day 1.
- **NUI interface** -- Clean HTML/CSS/JS-based reward display showing all available rewards and current progress.
- **NPC interaction** -- A configurable ped is spawned in the world with a map blip. Players walk up and press E to open the menu.
- **Command access** -- The menu can also be opened via a configurable chat command.
- **Vehicle rewards** -- Supports giving vehicles directly to the player's garage (inserted into the database with a generated plate).
- **Item rewards** -- Standard inventory items are added via `gfx-base` utilities.
- **Money rewards** -- Cash can be given using the `"money"` item type.
- **Multi-framework support** -- Works with both QBCore and ESX through `gfx-base` framework detection.
- **ESX parking support** -- Optional parking location field when inserting vehicles on ESX.
- **Persistent progress** -- Player reward progress (current day index and last claim timestamp) is stored in MySQL and persists across server restarts.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| NPC does not spawn | Verify that the ped model in `Config.Ped.Ped` is valid. Check that the coordinates are in a loaded area. |
| Menu does not open | Ensure `gfx-base` is started before `gfx-dailygift`. Check the server console for errors. |
| "attempt to index a nil value" on reward claim | The player may not have a database entry yet. Open the menu via the command first, which auto-creates the entry. |
| Vehicle reward not appearing in garage | Check that the garage name matches your garage system (`pillboxgarage` for QBCore, `SanAndreasAvenue` for ESX with parking). |
| Item images not showing in UI | Verify `Config.InventoryImagePath` points to the correct image directory for your inventory resource. |
| Rewards not resetting after 24 hours | The cooldown is based on server time (`os.time()`). Ensure your server's system clock is correct. |
| SQL table missing error | Import the included `dailygifts.sql` file into your database before starting the resource. |
