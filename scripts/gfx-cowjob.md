# GFX Cow Job

A cow farming job script for FiveM that allows players to purchase farms, raise cows, milk them, and sell milk through a courier vehicle system with a full NUI interface.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-cowjob` |
| **Frameworks** | ESX, QBCore |
| **Escrow** | No |

## Dependencies

| Dependency | Purpose |
|------------|---------|
| **es_extended** or **qb-core** | Framework (set via `Config.Framework`) |

## Installation

### 1. Add Items to Your Framework

**For QBCore** -- add the following to your shared items:
```lua
['cow-feed'] = {['name'] = 'cow-feed', ['label'] = 'Cow Feed', ['weight'] = 100, ['type'] = 'item', ['image'] = 'cow-feed.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A feed for cows'},
['milk'] = {['name'] = 'milk', ['label'] = 'Milk', ['weight'] = 100, ['type'] = 'item', ['image'] = 'milk.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Just a milk'},
```

**For ESX** -- run the SQL in `items/items.sql`:
```sql
INSERT INTO items ("milk", "Milk", 1, 0, 1) VALUES("name", "label", "weight", "rare", "can_remove");
INSERT INTO items ("cow-feed", "Cow Feed", 1, 0, 1) VALUES("name", "label", "weight", "rare", "can_remove");
```

### 2. Copy item images from the `items/` folder to your inventory resource's image directory.

### 3. Add to server.cfg
```cfg
ensure gfx-cowjob
```

## Configuration

Configuration is done in `config.lua`.

### General Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Framework` | string | `"esx"` | Framework to use: `"esx"` or `"qb"` |
| `Locale` | string | `"en"` | Language locale |
| `FarmSellTax` | number | `25` | Tax percentage when selling a farm |
| `FarmNameFormat` | string | `"{firstname}'s Farm"` | Farm name format on purchase. Supports `{firstname}` and `{lastname}` placeholders |
| `ChangeBlipOnPurchase` | boolean | `true` | Whether to change the map blip when a farm is purchased |

### Job Requirement

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `JobRequirement` | boolean | `false` | Whether a specific job is required to use farms |
| `JobName` | string | `"farmer"` | Required job name (only applies when `JobRequirement` is `true`) |

### Cow Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `CowBuyPrice` | number | `1000` | Price to buy a new cow |
| `CowSellPrice` | number | `1000` | Price received when selling a cow |
| `CowFeedItem` | string | `"cow-feed"` | Item name used to feed cows |
| `CowMilkPeriod` | number | `10` | Base milking cooldown in minutes |
| `CowMilkItem` | string | `"milk"` | Item name given when milking a cow |
| `MilkingExp` | number | `20` | Experience gained per milking |
| `CowHungerMinute` | number | `5` | Hunger decreases by 1 every X minutes |

### Sell Mission / NPC Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `SellerNpc` | string | `"a_m_m_farmer_01"` | Ped model for the seller NPC |
| `SellerNpcCoords` | vector3 | `vector3(1912.91, 4931.71, 48.86)` | Location of the seller NPC |
| `SellerNpcHeading` | number | `330.0` | Heading direction of the seller NPC |
| `CowMilkSellPrice` | number | `100` | Price per milk item when selling |
| `VehicleSpawnCoords` | vector4 | `vector4(1791.09, 5029.84, 56.91, 306.08)` | Spawn location for the courier vehicle |
| `VehicleDestination` | vector3 | `vector3(1905.64, 4948.85, 50.90)` | Destination the courier vehicle drives to |

### Farm Definitions

Farms are defined in the `Config.Farms` table. Each farm entry has the following structure:

| Field | Type | Description |
|-------|------|-------------|
| `DefaultName` | string | Display name before the farm is purchased |
| `Photo` | string | URL for the farm's preview photo (shown in NUI) |
| `Price` | number | Purchase price of the farm |
| `Coords` | vector3 | Main interaction/menu coordinates |
| `Camera` | vector4 | Camera position used during purchase preview |
| `CowPoints` | table | Array of `vector4` positions where cows can be placed (max 15 per farm) |

### Notifications

Custom notification functions can be set in the config:

```lua
ClientNotify = function(title, msg, type)
    -- Client-side notification
end

ServerNotify = function(source, title, msg, type)
    -- Server-side notification
end
```

## Exports

*No exports are created by this script.*

## Events

*No public API events are exposed by this script. All events are internal.*

## Commands

*No commands are registered by this script.*

## Features

- **Farm Purchasing** -- Players can buy farms at predefined locations. Farm names are automatically generated using the owner's RP name. Farms can also be sold back at a configurable tax rate.
- **Cow Management** -- Buy, sell, feed, and milk cows through an interactive NUI menu. Each farm has a configurable maximum cow capacity based on the number of `CowPoints` defined.
- **Cow Growth System** -- Cows start as babies and grow over time through a hunger/experience system. Baby cows cannot be milked until they reach 1000 experience points.
- **Milking Cooldown** -- Each cow has a milking timer. As cows gain experience, the cooldown decreases. Players receive the configured milk item when milking.
- **Hunger System** -- Cows lose hunger over time. Players must feed them using the configured feed item. If hunger reaches zero, the cow dies and is removed.
- **Milk Selling Mission** -- Players can sell milk by interacting with a seller NPC, calling a courier vehicle (Burrito van), and selling all milk items from inventory at the vehicle's back door.
- **Map Blips** -- Each farm displays a blip on the map. Blip appearance changes when a farm is purchased.
- **NUI Interface** -- Full browser-based UI for farm management, cow interactions, purchase confirmations, and the sell mission.
- **Persistent Data** -- Farm and cow data are saved to JSON files (`cow_farms.json` and `cow_animals.json`) and persist across restarts.
- **Job Restriction** -- Optionally restrict farm usage to a specific job.
- **Multi-Framework** -- Supports both ESX and QBCore frameworks.
- **Localization** -- All UI and notification strings are translatable via locale files in the `locales/` folder.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Cows not spawning | Verify `CowPoints` coordinates in `Config.Farms` are valid ground-level positions. Check server console for errors. |
| "You don't have enough money" when buying | Ensure the player has sufficient cash or bank funds. The script checks cash first, then bank. |
| Milk item not received | Make sure the `milk` item is properly registered in your framework's item list (see Installation). |
| Feed not working | Ensure the `cow-feed` item exists in your framework's items and the player has it in inventory. |
| Farm interactions not showing | If `JobRequirement` is `true`, verify the player has the correct job set in `Config.JobName`. |
| Courier vehicle not appearing | Check that `VehicleSpawnCoords` points to a valid, accessible road location. |
| NUI menu not opening | Ensure the `ui/` folder with `index.html`, `css/`, `js/`, and `img/` is present and not corrupted. |
| Data lost after restart | The script saves data to `cow_farms.json` and `cow_animals.json` in the resource folder. Make sure the resource directory is writable. |
