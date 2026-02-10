# GFX Bus Job

A bus driver job script that allows players to pick routes, drive a bus along predefined stops, pick up and drop off NPC passengers, and earn money through ticket sales and route salaries. Features an interactive NUI menu, leveling system, crash fines, and live worker tracking.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-busjob` |
| **Frameworks** | ESX / ESX Legacy / QBCore |
| **Escrow** | No |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `es_extended` or `qb-core` | Yes | Core framework for player data, money, and callbacks |
| `ox_target` or `qb-target` | No | Optional targeting system; set `Config.Target` to `"ox"`, `"qb"`, or `"none"` |

## Installation

1. Place the `gfx-busjob` folder into your server's resources directory.
2. Add the following to your `server.cfg`:
```cfg
ensure gfx-busjob
```
3. Open `config.lua` and set `Config.Framework` to your framework (`"esx"`, `"oldesx"`, or `"qb"`).
4. Open `serverconfig.lua` and set `Config.DiscordBotToken` to your Discord bot token (used for fetching player avatar images).
5. Configure routes, stops, NPC location, vehicle model, and other options in `config.lua`.

## Configuration

### General Settings (`config.lua`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Framework` | `string` | `"esx"` | Framework to use: `"esx"`, `"oldesx"`, or `"qb"` |
| `Locale` | `string` | `"en"` | Language locale. Supported: `"en"`, `"tr"`, `"es"`, `"de"`, `"ru"` |
| `DebugStreet` | `boolean` | `false` | Prints street names to console for route building |
| `Target` | `string` | `"none"` | Targeting system: `"qb"`, `"ox"`, or `"none"` (uses proximity `[E]` key) |
| `JobRequirement` | `boolean` | `true` | Whether the player must have a specific job to use the bus job |
| `Job` | `string` | `"police"` | Required job name when `JobRequirement` is `true` |
| `Menu` | `vector3` | `vector3(468.89, -577.03, 29.49)` | Coordinates of the job menu interaction point |
| `Vehicle` | `string` | `"bus"` | Vehicle model spawn name |
| `SpamProtectionTime` | `number` | `2000` | Cooldown between menu opens in milliseconds |
| `TimeToGetInVehicle` | `number` | `30` | Seconds the player has to return to the bus before the job is cancelled |
| `CrashFine` | `number` | `100` | Cash amount deducted when the bus is damaged |

### NPC Settings (`config.lua` - `Config.NPC`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `hash` | `string` | `"a_m_y_business_02"` | Ped model hash for the job NPC |
| `coords` | `vector3` | `vector3(468.89, -577.03, 28.49)` | NPC spawn coordinates |
| `heading` | `number` | `172.13` | NPC heading direction |
| `blip.sprite` | `number` | `513` | Map blip sprite ID |
| `blip.color` | `number` | `4` | Map blip color |
| `blip.scale` | `number` | `0.6` | Map blip scale |
| `blip.name` | `string` | `"Bus Driver Job"` | Map blip display name |

### Route Configuration (`config.lua` - `Config.Routes`)

Each route is a table entry in the `Config.Routes` array with the following structure:

| Option | Type | Description |
|--------|------|-------------|
| `RouteName` | `string` | Display name of the route |
| `Salary` | `number` | Money paid to the player's bank when a full route loop is completed |
| `Level` | `number` | Minimum driver level required to select this route |
| `TicketPrice` | `number` | Price per passenger ticket (paid per stop in cash) |
| `Exp` | `number` | Experience points awarded per stop |

Each route contains a `Stops` array, where each stop has:

| Option | Type | Description |
|--------|------|-------------|
| `Preview` | `string` | Image URL displayed in the NUI menu |
| `StopName` | `string` | Display name of the bus stop |
| `Level` | `number` | Minimum driver level to unlock this stop |
| `StopCoords` | `vector3` | Bus stop marker coordinates |
| `PassengerWaitCoords` | `vector4` | Coordinates and heading where NPC passengers spawn |
| `MaxPassengers` | `number` | Maximum number of passengers that can spawn at this stop |
| `MinPassengers` | `number` | Minimum number of passengers that spawn at this stop |
| `StopBlip` | `table` | Blip configuration with `Sprite`, `Color`, `Scale`, and `Text` |

### Parking Lots (`config.lua` - `Config.ParkingLots`)

Array of `vector4` positions where the bus can be spawned. The script finds the first unoccupied lot.

### Passenger Peds (`config.lua` - `Config.PassengerPeds`)

Array of ped model hash strings used to randomly spawn NPC passengers at stops.

### Custom Functions (`config.lua`)

| Function | Description |
|----------|-------------|
| `Config.Notify(msg, type, length)` | Override to use a custom notification system |
| `Config.SetFuel(vehicle)` | Override to integrate with a fuel system (e.g., LegacyFuel) |

### Server Configuration (`serverconfig.lua`)

| Option | Type | Description |
|--------|------|-------------|
| `DiscordBotToken` | `string` | Discord bot token used to fetch player avatar images via the Discord API |

## Exports

*No exports are created by this script.*

## Events

*No public API events are exposed by this script.* All events are internal to the resource.

## Commands

*No commands are registered by this script.* Interaction is done through the NPC or target system.

## Features

- Interactive NUI menu to browse available routes, view stops with preview images, and see active workers
- Leveling system based on accumulated experience -- higher levels unlock new routes and stops
- Multiple predefined routes with configurable stops (2 routes included: "Airport" and "Movie Star Way")
- NPC passengers spawn at stops with randomized count, board the bus, and exit at random stops
- GPS multi-route navigation to each stop with map blips
- Camera cinematic when passengers are boarding/exiting
- Crash fine system that deducts cash when the bus takes damage
- Route completion salary paid to the player's bank account
- Ticket sales income paid in cash per stop based on passenger count
- Abandon timer -- if the player leaves the bus, they have a configurable time window to return before the job is cancelled
- Parking lot system with automatic empty lot detection
- Active worker tracking visible to all players in the NUI menu
- Discord avatar integration for player profile images
- Target system support (ox_target, qb-target) or fallback proximity interaction with `[E]` key
- Multi-language support (English, Turkish, Spanish, German, Russian)
- Player data persistence via `database.json` (stores experience, mission history, and avatar)

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Menu does not open | Ensure `Config.JobRequirement` is set correctly. If `true`, verify the player has the job specified in `Config.Job`. |
| NPC or blip not appearing | Check that `Config.NPC.coords` is a valid location and the ped model hash exists. |
| Bus not spawning | Make sure `Config.ParkingLots` coordinates are not blocked by other vehicles. Verify the vehicle model in `Config.Vehicle` is valid and available on your server. |
| "No empty parking lot" error | All parking lot positions are occupied. Clear the area or add more positions to `Config.ParkingLots`. |
| Passengers not boarding | Verify `Config.PassengerPeds` contains valid ped model hashes. Ensure stop coordinates are accessible by NPCs. |
| Player avatars not loading | Check that `Config.DiscordBotToken` in `serverconfig.lua` is a valid Discord bot token with permission to access user data. |
| Crash fine not working | Ensure the player has enough cash. The fine is only deducted if the player's cash balance is greater than or equal to `Config.CrashFine`. |
| Framework not detected | Verify `Config.Framework` matches your server's framework (`"esx"`, `"oldesx"`, or `"qb"`) and that the framework resource is started before `gfx-busjob`. |
| Target interaction not working | Confirm `Config.Target` matches your installed target resource (`"ox"` or `"qb"`). Set to `"none"` to use default proximity-based interaction. |
