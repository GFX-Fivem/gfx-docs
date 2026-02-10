# GFX Delivery

A delivery job script for FiveM featuring a full NUI interface, contract system, leveling progression, multiple delivery zones, package types with money multipliers, a leaderboard, and profile photo integration (Steam/Discord).

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-delivery` |
| **Frameworks** | QBCore / ESX |
| **Escrow** | Yes |
| **Database** | MySQL (oxmysql, ghmattimysql, or mysql-async) |

## Dependencies

| Resource | Purpose |
|----------|---------|
| `oxmysql` / `ghmattimysql` / `mysql-async` | Database queries (configurable via `Config.SQLScript`) |
| `qb-core` or `es_extended` | Framework support (auto-detected) |
| `qb-target` / `ox_target` (optional) | Target interaction with NPC; can use drawtext instead |
| `LegacyFuel` / `ox_fuel` (optional) | Sets fuel on spawned delivery vehicle |

## Installation

1. Place the `gfx-delivery` folder in your server's resources directory.
2. Import the SQL files into your database:
   - `deliveryjob.sql` -- creates the `gfx_delivery_job` table (player stats, levels, earnings).
   - `deliveryjobcontract.sql` -- creates the `gfx_delivery_job_contract` table (player-created contracts).
3. Add `ensure gfx-delivery` to your `server.cfg` (after your framework and SQL resource).
4. Configure settings in `config.lua`.
5. If using Steam profile photos, make sure `steam_webApiKey` is set in your `server.cfg`.
6. If using Discord profile photos, set `Config.DiscordToken` to your Discord bot token.

## Configuration

Configuration is done in `config.lua` via the `Config` table.

### General Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `SQLScript` | string | `"oxmysql"` | SQL resource to use. Options: `"oxmysql"`, `"ghmattimysql"`, `"mysql-async"` |
| `InteractionKey` | number | `38` (E) | Control key ID for interactions. See [FiveM Controls](https://docs.fivem.net/docs/game-references/controls/) |
| `Target` | string | `"ox-target"` | Interaction method. Options: `"qb-target"`, `"ox-target"`, `"drawtext"` |
| `ProfilePhotoType` | string | `"steam"` | Profile photo source for leaderboard. Options: `"discord"`, `"steam"`, `"none"` |
| `DiscordToken` | string | `""` | Discord bot token (required only if `ProfilePhotoType` is `"discord"`) |
| `NoImage` | string | `"assets/delivery-user.png"` | Fallback image when no profile photo is available |
| `DepositMoney` | number | `1000` | Deposit amount taken from the player when starting a job (refunded on vehicle return) |
| `DeliveryTime` | number | `3000` | Delivery progress bar duration in milliseconds |

### NPC Configuration (`Config.Npc`)

Each NPC entry in the `Config.Npc` table defines a delivery job location.

| Field | Type | Description |
|-------|------|-------------|
| `pos` | vector3 | NPC spawn position |
| `heading` | number | NPC facing direction |
| `model` | string | Ped model name |
| `label` | string | Interaction label shown on target |
| `anim` | table | NPC animation settings (`animLib`, `animName`, `prop`, `bone`, `proppos`) |
| `blipSprite` | number | Map blip sprite ID |
| `blipColor` | number | Map blip color |
| `blipName` | string | Map blip label |
| `blipShortRange` | boolean | Whether the blip is only visible at short range |
| `carLoadCoord` | vector3 | Position where the player loads packages into the vehicle |
| `DeliveryCar` | table | Delivery vehicle settings (see below) |

### Delivery Car Settings (`DeliveryCar`)

| Field | Type | Description |
|-------|------|-------------|
| `model` | string | Vehicle model name |
| `coords` | vector3 | Vehicle spawn position |
| `heading` | number | Vehicle spawn heading |
| `plate` | string | License plate prefix |
| `fuel` | number | Initial fuel level (0-100) |

### Package Types (`Config.DeliveryPackages`)

Three tiers of delivery packages, each with different prop models:

| Type | Description |
|------|-------------|
| `Basic` | Standard packages (cardboxes, bags, etc.) |
| `Advanced` | Larger items (chairs, exercise bikes, etc.) |
| `Illegal` | Contraband items (weed, cocaine, weapons, etc.) |

Each type contains `model` (table of prop names), `propPos` (attachment offsets), and `bone` (ped bone ID).

### Level System (`Config.Level`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `deliveryPoint` | number | `1` | Points earned per completed delivery |
| `secondLevel` | number | `50` | Points required to reach level 2 |
| `thirdLevel` | number | `100` | Points required to reach level 3 |
| `abandonJobTime` | number | `120` | Seconds before a job is auto-abandoned when outside the vehicle |
| `abandonJobPenalty` | number | `5` | Points lost when abandoning a job |

### Money Settings (`Config.Money`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Basic` | number | `1` | Money multiplier for Basic packages |
| `Advanced` | number | `1.5` | Money multiplier for Advanced packages |
| `Illegal` | number | `2` | Money multiplier for Illegal packages |
| `moneyPerPackage` | number | `100` | Base money earned per delivered package |
| `contractMoney` | number | `150` | Contract revenue per use |
| `contractUserIncomePercent` | number | `0.25` | Income bonus percentage for contract users |
| `contractOwnerIncomePercent` | number | `0.4` | Income bonus percentage for contract owners |
| `minContractUserCount` | number | `2` | Minimum number of users allowed on a contract |
| `maxContractUserCount` | number | `5` | Maximum number of users allowed on a contract |
| `creatableMaxContract` | number | `1` | Maximum number of contracts a player can create |

### Delivery Destinations (`Config.DeliveryDestinations`)

Contains delivery zone coordinates grouped by area:

| Zone | Description |
|------|-------------|
| `DownTown` | Los Santos downtown area (21 locations) |
| `SandyShores` | Sandy Shores desert area (21 locations) |
| `PaletoBay` | Paleto Bay northern area (21 locations) |

Each zone has `blipSprite`, `blipColor`, and `blipName` settings for the delivery point markers.

### Notification Texts (`Config.NotifyTexts`)

All player-facing notification messages are configurable. Supports format placeholders (`%s`). Key messages include job start, abandon penalty, delivery progress, money gained, deposit status, and more.

### Customizable Functions

The following functions in `config.lua` can be edited:

| Function | Description |
|----------|-------------|
| `SetFuel(vehicle, fuel)` | Sets vehicle fuel. Supports LegacyFuel and ox_fuel. |
| `Notify(text, type, length)` | Sends framework notifications. Auto-detects QBCore or ESX. |

## Exports

*No exports found.*

This script does not create any exports via `exports()`.

## Events

*No public API events found.*

All events in this script are internal (used for NPC interaction, NUI callbacks, and server-client communication). There are no public events intended for external script integration.

## Commands

*No commands found.*

## Features

- Full NUI interface for job management
- Multi-framework support (QBCore and ESX, auto-detected)
- Three package tiers (Basic, Advanced, Illegal) with different props and pay multipliers
- Contract system: players can create contracts for other players to complete, earning passive income
- Three-tier leveling system based on completed deliveries
- Configurable delivery zones (DownTown, Sandy Shores, Paleto Bay)
- Multiple NPC locations with custom animations and props
- Leaderboard showing top 25 players by deliveries completed
- Profile photo integration (Steam avatar, Discord avatar, or none)
- Deposit system: players pay a deposit when starting a job, refunded on vehicle return
- Auto-abandon timer: jobs are automatically abandoned if the player leaves the vehicle too long
- Point penalty for abandoning jobs
- Package loading mechanic with carry animation before driving
- Vehicle spawn with configurable model, plate, and fuel per NPC location
- Vehicle return point with cleanup
- Blip and checkpoint markers for delivery destinations
- Multiple SQL driver support (oxmysql, ghmattimysql, mysql-async)
- Target system support (qb-target, ox-target) or fallback drawtext interaction
- Offline contract owner payment: contract owners receive income even when offline

## Database

Two SQL tables are required:

### `gfx_delivery_job` (Player Stats)

| Column | Type | Description |
|--------|------|-------------|
| `id` | int | Auto-increment primary key |
| `citizenid` | varchar(255) | Player identifier |
| `player_name` | varchar(50) | Player character name |
| `jobs_done` | int | Total delivery points |
| `level` | int | Current level (1-3) |
| `total_money` | int | Total lifetime earnings |
| `created_contract` | int | Number of active contracts created |
| `profile_photo` | varchar(255) | Profile photo URL |

### `gfx_delivery_job_contract` (Contracts)

| Column | Type | Description |
|--------|------|-------------|
| `id` | int | Auto-increment primary key |
| `citizenid` | varchar(50) | Contract creator identifier |
| `contractOwner` | varchar(50) | Contract creator display name |
| `deliveryZone` | varchar(50) | Delivery zone name |
| `packType` | varchar(50) | Package type (Basic/Advanced/Illegal) |
| `packageCount` | int | Number of packages per run |
| `contractUserCount` | int | Remaining uses before contract expires |

## Troubleshooting

| Problem | Solution |
|---------|----------|
| NPC not appearing | Verify ped model names in `Config.Npc` are valid. Check that coordinates are correct. |
| Target interaction not working | Ensure `Config.Target` matches your installed target resource (`qb-target`, `ox-target`, or `drawtext`). |
| Profile photos not loading | For Steam: ensure `steam_webApiKey` is set in `server.cfg`. For Discord: ensure `Config.DiscordToken` is valid. |
| SQL errors on start | Make sure both `.sql` files have been imported and `Config.SQLScript` matches your SQL resource. |
| Vehicle not spawning | Check that the vehicle model in `Config.Npc[x].DeliveryCar.model` is a valid GTA V vehicle. |
| Deposit not being taken/refunded | Verify the player has enough cash or bank balance. Check that `Config.DepositMoney` is set correctly. |
| Fuel not being set | Ensure `LegacyFuel` or `ox_fuel` is started on your server. |
| Leaderboard empty | Player data is created on first NPC interaction. Players must interact with the NPC at least once. |
| Contract creation fails | Player may have reached `Config.Money.creatableMaxContract` limit. |

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-delivery
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
