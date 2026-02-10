# gfx-lootbag

## Info

| Key | Value |
|---|---|
| **Name** | gfx-lootbag |
| **Description** | Death lootbag system -- drops a lootbag containing the player's inventory on death, allowing other players (or the same player) to pick it up |
| **FX Version** | Cerulean |
| **Game** | GTA5 |
| **Lua** | 5.4 |
| **Escrow** | Yes (`client.lua`, `server.lua` are escrowed; `config.lua`, `client_shared.lua`, `server_shared.lua` are open) |

---

## Dependencies

| Resource | Required | Purpose |
|---|---|---|
| `gfx-lib` | Yes | Framework detection, inventory helpers (`GetInventory`, `GetPlayer`, `AddItem`) |
| `gfx-aio` | No | Optional all-in-one inventory integration -- if running, bags are managed through `gfx-aio` inventory system instead of direct item transfer |

---

## Installation

### 1. Add Files
Place the `gfx-lootbag` folder in your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-lib
ensure gfx-lootbag
```

> Make sure `gfx-lib` starts before `gfx-lootbag`.

### 3. Configure Shared Files
Edit the customizable functions in `client_shared.lua` and `server_shared.lua` to match your server setup (death detection, safezone check, ban system). See the [Customizable Functions](#customizable-functions) section below.

---

## Configuration

All configuration is in `config.lua`:

```lua
Config = {
    InteractKey = 46,                -- Key to pick up bag (default: E / INPUT_CONTEXT)
    BagHash = `prop_big_bag_01`,     -- Prop model hash for the lootbag
    RemoveTimer = 300,               -- Seconds before the bag despawns automatically
    BlipTimer = 5,                   -- Seconds the death blip stays on the map
    DeathAnimation = false,          -- true: use custom death script export; false: use health check
    DisabledBuckets = {},            -- Routing bucket IDs where lootbag is disabled, e.g. {1, 2}
    Settings = {
        distance = 5                 -- Maximum interaction distance (units) to pick up a bag
    },
    Locales = {
        ["open_bag"] = "Press E to open the bag"  -- 3D text prompt shown near bags
    },
}
```

### Config Options

| Option | Type | Default | Description |
|---|---|---|---|
| `InteractKey` | `number` | `46` | Control ID for the interact key (46 = E) |
| `BagHash` | `hash` | `prop_big_bag_01` | Model hash for the bag prop |
| `RemoveTimer` | `number` | `300` | Time in seconds before a bag auto-despawns |
| `BlipTimer` | `number` | `5` | Time in seconds the death blip remains visible on the minimap |
| `DeathAnimation` | `boolean` | `false` | If `true`, uses an external death script export to detect death instead of native health check |
| `DisabledBuckets` | `table` | `{}` | List of routing bucket IDs where lootbag creation is disabled |
| `Settings.distance` | `number` | `5` | Max distance (in GTA units) to interact with a bag |
| `Locales.open_bag` | `string` | `"Press E to open the bag"` | 3D text shown above a lootbag when in range |

---

## Customizable Functions

These functions are in the open (non-escrowed) shared files and are meant to be edited for your server.

### Client-Side (`client_shared.lua`)

| Function | Purpose | Default Behavior |
|---|---|---|
| `IsDead()` | Returns whether the local player is considered dead (used as a gate before creating a bag) | Returns `true` -- replace with your death system export |
| `IsPlayerDead(ped)` | Checks if a ped is dead, supports custom death animation scripts | If `Config.DeathAnimation` is `false`, uses `GetEntityHealth(ped) <= 0`; if `true`, calls a custom export (must be configured) |
| `InSafezone()` | Returns whether the player is currently in a safezone (bags are not created in safezones) | Returns `false` -- replace with your safezone export |
| `CreateBlip(coords)` | Creates and configures the minimap blip when a bag spawns | Creates a red blip (sprite 440) labeled "Death" |

### Server-Side (`server_shared.lua`)

| Function | Purpose | Default Behavior |
|---|---|---|
| `banPlayer(source)` | Called when a player attempts to claim a bag from too far away (anti-cheat) | Empty function -- add your ban system export/event |
| `AddItem(player, itemName, count)` | Adds an item to a player's inventory when claiming a bag | Uses `modules.AddItem()` from `gfx-lib` |

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events. All events are internal to the script.*

---

## Commands

*No commands registered.*

---

## Features

- **Automatic Lootbag on Death** -- When a player dies (outside safezones), a lootbag containing their full inventory drops at the death location as a visible prop.
- **Bag Pickup** -- Any player can approach a lootbag and press the interact key to claim all items inside.
- **Auto-Despawn Timer** -- Bags automatically despawn after a configurable time (`RemoveTimer`), preventing permanent world clutter.
- **Death Blip** -- A temporary minimap blip marks the death/bag location, disappearing after `BlipTimer` seconds.
- **Routing Bucket Support** -- Lootbag creation can be disabled in specific routing buckets via `DisabledBuckets`.
- **Safezone Protection** -- Bags are not created if the player dies inside a safezone (requires custom `InSafezone()` implementation).
- **Anti-Cheat** -- Server-side distance validation on bag creation and claiming. Players attempting to claim bags from an invalid distance trigger the `banPlayer()` function.
- **gfx-aio Integration** -- If `gfx-aio` is running, bag inventory is managed through its inventory UI instead of direct item transfer.
- **Custom Death Script Support** -- Configurable death detection via `DeathAnimation` flag and custom exports in `client_shared.lua`.
- **3D Text Prompt** -- Shows a floating text prompt with the bag's ID when a player is within interaction range.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Bag does not spawn on death | Verify `IsDead()` and `IsPlayerDead()` in `client_shared.lua` return correct values for your death system. Check that `InSafezone()` is not returning `true`. Ensure the player's routing bucket is not in `DisabledBuckets`. |
| Cannot pick up bag | Check that `Config.Settings.distance` is large enough. Ensure the interact key (`Config.InteractKey`) matches your keybind setup. Verify the player is alive (dead players cannot pick up bags). |
| Bag prop not visible | Ensure the model `prop_big_bag_01` (or your custom `BagHash`) is valid and streamable. Check for model loading errors in the F8 console. |
| Items not added when claiming | Verify `AddItem()` in `server_shared.lua` works with your inventory system. Check `gfx-lib` is started and `modules.AddItem` is functional. |
| Bags disappear too quickly | Increase `Config.RemoveTimer` (value is in seconds, default 300 = 5 minutes). |
| Blip stays on map too long / disappears too fast | Adjust `Config.BlipTimer` (value is in seconds, default 5). |
| Players getting banned when picking up bags | The `banPlayer()` function triggers when a claim is attempted from beyond `Config.Settings.distance`. Increase the distance if legitimate players are affected, or check for desync issues. |
| Script not working in certain lobbies | Check if the routing bucket ID is listed in `Config.DisabledBuckets`. |
| `gfx-aio` inventory not opening | Ensure `gfx-aio` is started before `gfx-lootbag` in your `server.cfg`. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-lootbag
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
