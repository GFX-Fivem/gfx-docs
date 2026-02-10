# GFX Christmas Truck

A seasonal Christmas event script that spawns an AI-driven gift truck which roams the map, periodically dropping collectible gift boxes with rarity-based rewards for players.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-christmastruck` |
| **Frameworks** | ESX / QBCore (legacy and modern versions) |
| **Escrow** | Yes |

## Dependencies

- None (standalone, framework detected via `Config.Framework`)

## Installation

### 1. Copy the resource folder
Place `gfx-christmastruck` into your server's resources directory.

### 2. Add to server.cfg
```cfg
ensure gfx-christmastruck
```

### 3. Configure the framework
Open `config.lua` and set `Config.Framework` to match your server:
- `"esx"` -- Legacy ESX (using `esx:getSharedObject`)
- `"newesx"` -- Modern ESX (using `exports["es_extended"]`)
- `"qb"` -- Legacy QBCore (using `QBCore:GetObject`)
- `"newqb"` -- Modern QBCore (using `exports["qb-core"]`)

### 4. Configure admin Steam IDs
Add authorized admin Steam identifiers to `Config.Admins` so they can spawn the truck.

## Configuration

All configuration is done in `config.lua`.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Framework` | `string` | `"newqb"` | Server framework: `"esx"`, `"newesx"`, `"qb"`, or `"newqb"` |
| `Admins` | `table` | `{}` | List of Steam identifiers allowed to spawn the truck |
| `TruckSpawnCoords` | `table` | 1 location | List of `vector3` coordinates where the truck can spawn (one is chosen randomly) |
| `GiftSpawnInterval` | `table` | `{min=30, max=60}` | Time range in seconds between each gift drop from the trailer |
| `GiftCount` | `number` | `10` | Total number of gifts the truck drops per spawn |
| `Rewards` | `table` | See below | Reward definitions per rarity category |
| `CategoryChances` | `table` | See below | Drop chance percentages per rarity (must sum to 100) |
| `Locales` | `table` | -- | Notification text templates |

### Reward Categories

Each category defines a money range and a list of possible item rewards:

| Category | Chance | Money Range | Example Items |
|----------|--------|-------------|---------------|
| `common` | 50% | $100 - $500 | Pistol, Combat Pistol |
| `uncommon` | 30% | $500 - $1,000 | Whiskey |
| `rare` | 15% | $1,000 - $2,000 | Gold Bar, 10K Gold Chain |
| `epic` | 4% | $2,000 - $5,000 | Rolex, Gold Bar |
| `legendary` | 1% | $5,000 - $10,000 | Carbine Rifle, SMG |

Each item entry supports `name`, `min`, and `max` quantity fields.

### Locale Strings

| Key | Default | Description |
|-----|---------|-------------|
| `picked_reward` | `"You picked up a gift and got %s %s"` | Notification when a player collects a gift. First `%s` = quantity, second `%s` = item name. |

## Exports

*No exports are created by this script.*

## Events

*No public API events. All events are internal communication between the script's own client and server files.*

## Commands

| Command | Scope | Description |
|---------|-------|-------------|
| `/spawnGiftTruck` | Server | Spawns the Christmas gift truck at a random configured location. The truck begins driving around and dropping gifts automatically. Admin-only (controlled via `Config.Admins`, currently commented out in code). |

## Features

- **AI-driven gift truck** -- A Phantom truck with a custom Christmas trailer (`gfx_trailer_new`) spawns and drives randomly around the map with an invincible NPC driver.
- **Automatic gift dropping** -- The trailer doors open at configurable intervals, dropping gift boxes (custom `mertrix_present` model) with firework particle effects behind the truck.
- **Vehicle collection** -- Players must drive over the gift pickups in a vehicle to collect them. Walking over them does not work.
- **Rarity-based reward system** -- Gifts roll a random rarity category (common/uncommon/rare/epic/legendary) with configurable drop chances that must sum to 100%.
- **Dual rewards** -- Each gift can award both money (added as cash) and a random item from the rarity tier.
- **Map blip** -- The truck is marked on the map with a blip labeled "Gift Truck" so all players can locate and follow it.
- **Custom streamed assets** -- Includes a custom trailer model (`gfx_trailer_new`) and gift box model (`mertrix_present`) with textures.
- **Multi-framework support** -- Works with ESX and QBCore, both legacy and modern versions.
- **Clean resource stop** -- All spawned entities (truck, driver, trailer, gifts) are deleted when the resource stops.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Truck does not spawn | Ensure you run `/spawnGiftTruck` in the server console or as an admin in-game. Check that `Config.TruckSpawnCoords` contains valid coordinates on a road. |
| Gifts not collectible | Players must be **inside a vehicle** and drive close to the gift pickup. Walking over gifts does not trigger collection. |
| No items received | Verify that the item names in `Config.Rewards` match your inventory system's registered items. Check server console for errors. |
| Custom trailer/gift not visible | Ensure the `stream/` folder is included in the resource and contains `gfx_trailer_new.yft`, `mertrix_present.ydr`, and related `.ytd` files. |
| Framework not detected | Confirm `Config.Framework` matches your server setup exactly (`"esx"`, `"newesx"`, `"qb"`, or `"newqb"`). |
| Blip not showing | The blip is broadcast to all clients when the truck spawns. If it does not appear, ensure the client received the `addBlipToTruck` event (check for network issues or resource start order). |
