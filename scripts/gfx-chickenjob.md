# GFX Chicken Job

A chicken farming simulation script for FiveM. Players can purchase farms, place eggs, hatch them into chickens, feed and manage chickens, collect eggs produced by chickens, and sell eggs and chickens for profit.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-chickenjob` |
| **Frameworks** | ESX, QBCore |
| **Escrow** | No |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `es_extended` or `qb-core` | Yes | Set via `Config.Framework` (`"esx"` or `"qb"`) |
| `oxmysql` / `mysql-async` / `ghmattimysql` | Yes | Set via `Config.MySQL` (used by the framework, not directly by this script) |

## Installation

### 1. Copy the resource folder
Place the `gfx-chickenjob` folder into your server's resources directory.

### 2. Add to server.cfg
```cfg
ensure gfx-chickenjob
```

### 3. Configure items
Make sure the following items exist in your framework's item list:
- `egg` (or whatever you set `Config.EggItem` to) -- used for placing/collecting eggs
- `chicken-feed` (or whatever you set `Config.ChickenFeedItem` to) -- used for feeding chickens

### 4. Configure the script
Edit `config.lua` to match your server's framework, notification system, farm locations, and pricing.

## Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `MySQL` | string | `"oxmysql"` | MySQL resource name. Options: `"oxmysql"`, `"mysql-async"`, `"ghmattimysql"` |
| `Framework` | string | `"esx"` | Framework to use. Options: `"esx"`, `"qb"` |
| `Locale` | string | `"en"` | Language locale for translations |
| `FarmSellTax` | number | `25` | Tax percentage deducted when selling a farm |
| `FarmNameFormat` | string | `"{defaultname}"` | Farm name format. Placeholders: `{defaultname}`, `{firstname}`, `{lastname}` |
| `ChangeBlipOnPurchase` | boolean | `false` | Whether to change the map blip when a farm is purchased |
| `JobRequirement` | boolean | `false` | Whether a specific job is required to use the egg sell mission |
| `JobName` | string | `"farmer"` | Required job name (only applies if `JobRequirement` is `true`) |
| `EggItem` | string | `"egg"` | Item name for eggs in the inventory system |
| `EggCrackPeriod` | number | `1` | Time in minutes for an egg to finish incubation |
| `EggOvulationPeriod` | number | `1` | Time in minutes for a chicken to produce an egg |
| `ChickenFeedItem` | string | `"chicken-feed"` | Item name for chicken feed in the inventory system |
| `ChickenSellPrice` | number | `1000` | Price received when selling a chicken |
| `CollectingExp` | number | `20` | Experience gained per egg collection |
| `SellerNpc` | string | `"a_m_m_farmer_01"` | Ped model for the egg seller NPC |
| `SellerNpcCoords` | vector3 | `vector3(1912.91, 4931.71, 48.86)` | Coordinates of the egg seller NPC |
| `SellerNpcHeading` | number | `330.0` | Heading direction of the seller NPC |
| `EggSellPrice` | number | `100` | Price per egg when selling via the courier vehicle |
| `VehicleSpawnCoords` | vector4 | `vector4(1791.09, 5029.84, 56.91, 306.08)` | Spawn coordinates for the courier vehicle |
| `VehicleDestination` | vector3 | `vector3(1905.64, 4948.85, 50.90)` | Destination the courier vehicle drives to |
| `ChickenHungerTime` | number | `5` | Interval in minutes at which chicken hunger decreases by 1 |
| `Farms` | table | *(see below)* | Table of farm definitions with coordinates, prices, and chicken points |
| `ClientNotify` | function | *(QBCore notify)* | Client-side notification function. Override for custom notifications |
| `ServerNotify` | function | *(QBCore notify)* | Server-side notification function. Override for custom notifications |

### Farm Definition Structure

Each entry in `Config.Farms` follows this structure:

```lua
{
    DefaultName = "Grapeseed Chicken Farm",          -- Display name before purchase
    Photo = "https://example.com/farm-photo.jpg",    -- Photo URL shown in purchase UI
    Price = 200000,                                  -- Purchase price
    Coords = vector3(2306.42, 4885.97, 41.81),      -- Main interaction coordinates
    Camera = vector4(2182.96, 4910.91, 100.33, 262.45), -- Camera position for purchase preview
    ChickenPoints = {                                -- Chicken/egg spawn positions (max 15)
        vector4(2258.07, 4899.96, 40.81, 225.26),
        vector4(2259.86, 4901.6, 40.81, 203.59)
    }
}
```

### Custom Notification Example

```lua
ClientNotify = function(title, msg, type)
    -- Replace with your notification system
    exports['mythic_notify']:DoHudText(type, msg)
end,

ServerNotify = function(player, title, msg, type)
    TriggerClientEvent('mythic_notify:client:SendAlert', player, {type = type, text = msg})
end
```

## Exports

*No exports are created by this script.*

## Events

*No public API events are exposed by this script.* All events are internal (prefixed with the resource name) and used for client-server communication within the script.

## Commands

*No commands are registered by this script.* All interactions are done via the NUI menu and 3D markers/prompts in the game world.

## Features

- **Farm Purchasing** -- Players can buy chicken farms at configurable locations. A camera preview shows the farm before purchase.
- **Farm Selling** -- Farm owners can sell their farm back at a configurable tax rate (default 25% deduction).
- **Farm Name Customization** -- Farm names can include the owner's first/last name via `FarmNameFormat` placeholders.
- **Egg Management** -- Players place eggs from their inventory into the farm. Eggs have an incubation timer before they can be hatched into chickens.
- **Egg Hatching** -- Once incubation completes, eggs can be broken to hatch a new chicken (with a particle effect).
- **Egg Removal** -- Eggs can be removed from the farm. There is a 50% chance of recovering the egg item; otherwise it breaks.
- **Chicken Management** -- Chickens have hunger and ovulation timers. They gain experience over time which reduces their ovulation period.
- **Chicken Feeding** -- Chickens must be fed using the configured feed item. Hunger decreases over time, and chickens die if hunger reaches 0.
- **Egg Collection** -- When a chicken's ovulation timer completes, the player can collect an egg item from it. This also grants experience to the chicken.
- **Chicken Selling** -- Chickens can be sold for the configured `ChickenSellPrice`.
- **Egg Sell Mission** -- A seller NPC at a configurable location lets players call a courier vehicle. Players load their egg items into the vehicle and sell them at the configured `EggSellPrice` per egg.
- **Job Requirement** -- The egg sell mission can optionally require a specific job (e.g., `"farmer"`).
- **Map Blips** -- Blips are placed on the map for each farm and the egg seller NPC. Blips can optionally change appearance when a farm is purchased.
- **NUI Interface** -- A full HTML/CSS/JS user interface for farm management, egg/chicken interactions, purchase confirmations, and the sell mission.
- **3D Markers & Text** -- Color-coded markers and floating text show chicken hunger, ovulation status, and egg incubation progress in the game world.
- **Notifications** -- Players receive notifications for key events: purchase, egg hatching ready, chicken hungry, chicken death, feeding, and more.
- **Localization** -- Full translation support via locale files (English included by default).
- **Persistent Data** -- Farm ownership, chickens, and eggs are saved to JSON files (`data/chicken_farms.json`, `data/chicken_animals.json`, `data/chicken_eggs.json`) and persist across restarts.
- **Multi-Framework** -- Supports both ESX and QBCore frameworks.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Farm marker not showing | Verify `Config.Farms` coordinates are correct and the resource is started |
| "You need a egg to do this" | Ensure the `Config.EggItem` item (default `"egg"`) exists in your framework's item list |
| Chickens not feeding | Ensure the `Config.ChickenFeedItem` item (default `"chicken-feed"`) exists in your framework's item list |
| Chickens dying too fast | Increase `Config.ChickenHungerTime` (default 5 minutes per hunger tick) |
| Egg sell NPC not appearing | Check `Config.SellerNpcCoords` and ensure the ped model `Config.SellerNpc` is valid |
| Courier vehicle not spawning | Verify `Config.VehicleSpawnCoords` is on a valid road/surface |
| Farm data not persisting | Check that the `data/` folder contains `chicken_farms.json`, `chicken_eggs.json`, and `chicken_animals.json` with valid JSON (at minimum `[]`) |
| Notifications not showing | Override `Config.ClientNotify` and `Config.ServerNotify` to match your server's notification system |
| Job requirement not working | Set `Config.JobRequirement = true` and `Config.JobName` to the correct job name in your framework |
| NUI menu not opening | Ensure the `ui/` folder with `index.html`, `js/main.js`, and `css/style.css` is present and the resource has restarted |
