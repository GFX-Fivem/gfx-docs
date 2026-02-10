# gfx-propspawner

## Info

| Key | Value |
|-----|-------|
| **Name** | gfx-propspawner |
| **Type** | Prop/Object Spawning System |
| **Side** | Client & Server |
| **Framework** | ESX / New ESX / QB / New QB |
| **UI** | WarMenu (native menu) |
| **Escrow** | No (fully open source) |

---

## Dependencies

| Resource | Required | Purpose |
|----------|----------|---------|
| `oxmysql` | Yes | MySQL library (loaded in fxmanifest) |
| `es_extended` **or** `qb-core` | Yes | Framework core (ESX or QBCore) |

---

## Installation

### 1. Copy Files
Place the `gfx-propspawner` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure oxmysql
ensure es_extended  # or qb-core
ensure gfx-propspawner
```

### 3. Configure Framework
Open `config.lua` and set the `Framework` value to match your server:
```lua
Config.Framework = "newqb" -- Options: "esx", "newesx", "qb", "newqb"
```

---

## Configuration

All configuration is in `config.lua`.

### General Settings

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Framework` | `string` | `"newqb"` | Framework type. Accepts `"esx"`, `"newesx"`, `"qb"`, `"newqb"`. |
| `OnlyOwnerRemove` | `boolean` | `true` | If `true`, only the player who spawned an object can remove it. |
| `RemoveAndAddItem` | `boolean` | `true` | If `true`, placing an object removes the item from inventory and deleting the object gives it back. Only applies to props that have `item.enabled = true`. |

### Locales

| Key | Default | Description |
|-----|---------|-------------|
| `you_cant_remove` | `"You can't remove this object!"` | Shown when a player tries to remove someone else's object (when `OnlyOwnerRemove` is enabled). |
| `you_cant_spawn` | `"You can't spawn this object!"` | Shown when a player does not have the required job to spawn the object. |
| `you_dont_have_item` | `"You don't have the item to spawn this object!"` | Shown when the required item is missing from the player's inventory. |

### PropList (Prop Definitions)

Each entry in `Config.PropList` is keyed by the GTA model hash and contains:

| Field | Type | Description |
|-------|------|-------------|
| `label` | `string` | Display name shown in the spawn menu. |
| `item.enabled` | `boolean` | If `true`, the player must have the specified item in their inventory to spawn this prop. |
| `item.name` | `string` | The inventory item name required to spawn (only checked when `item.enabled` is `true`). |
| `listOnMenu` | `boolean` | If `true`, the prop appears in the WarMenu spawn list. |
| `job` | `string` | Job name required to spawn. Set to `"all"` to allow all players. |

**Example prop entry:**
```lua
[`prop_roadcone01a`] = {
    label = "Road Cone 1",
    item = {
        enabled = false,
        name = "cone",
    },
    listOnMenu = true,
    job = "all",
},
```

**Default props included:** Barriers (9 variants), Road Cones (6 variants), Road Poles.

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events for external scripts.* All events used by this script (`gfx-object:StartObjectPlacementLoop`, `gfx-object:objectCreated`, `gfx-object:objectDeleted`) are internal.

---

## Commands

| Command | Description |
|---------|-------------|
| `/spawmenu` | Opens the prop spawner WarMenu. Lists all configured props for selection and placement. |
| `/removeobject` | Enters remove mode. Aim at a spawned object and press `E` to delete it. Objects are highlighted with a red outline when targeted. |

---

## Features

### Prop Placement
- Select a prop from the WarMenu and enter placement mode.
- A semi-transparent green-outlined preview follows the player's camera via raycast (10m range).
- **Left Click** to confirm placement.
- **Right Click** to cancel placement.
- Full rotation control while placing:
  - **Q / Cover** -- Rotate Z-axis (left/right yaw)
  - **Arrow Up / Arrow Down** -- Rotate X-axis (pitch)
  - **Arrow Left / Arrow Right** -- Rotate Y-axis (roll)

### Prop Removal
- Enter remove mode via the menu ("Remove Object" button) or `/removeobject` command.
- Aim at a spawned object -- it highlights with a red outline.
- Press **E** to delete it.
- If `OnlyOwnerRemove` is enabled, only the player who placed the prop can remove it.

### Job Restrictions
- Each prop can be restricted to a specific job. Set `job = "all"` to make it available to everyone.
- Players without the required job see an error notification when attempting to spawn.

### Item Integration
- Props can require an inventory item to spawn (`item.enabled = true`).
- When `RemoveAndAddItem` is enabled:
  - Placing a prop removes 1x of the item from the player's inventory (server-side).
  - Deleting a prop adds 1x of the item back to the player's inventory (server-side).

### Usable Items (Server-side)
- If a prop has `item.enabled = true`, the server automatically registers it as a usable item via the framework (`ESX.RegisterUsableItem` or `QBCore.Functions.CreateUseableItem`).
- Using the item triggers prop placement directly (bypasses the menu).

### Cleanup
- All spawned objects are automatically deleted when the resource stops.

---

## Troubleshooting

| Problem | Possible Cause | Solution |
|---------|---------------|----------|
| Menu does not open with `/spawmenu` | WarMenu library issue or script not started | Ensure `gfx-propspawner` is running (`ensure gfx-propspawner`). Check F8 console for errors. |
| "You can't spawn this object!" | Player does not have the required job | Set `job = "all"` in the prop config, or ensure the player has the correct job. |
| "You don't have the item to spawn this object!" | Item requirement enabled but player lacks the item | Give the player the item, or set `item.enabled = false` for the prop. |
| "You can't remove this object!" | `OnlyOwnerRemove` is `true` and another player placed it | Set `Config.OnlyOwnerRemove = false` to allow anyone to remove objects, or have the original placer remove it. |
| Props not appearing in menu | `listOnMenu` is set to `false` | Set `listOnMenu = true` for the prop in `Config.PropList`. |
| Item not consumed/returned on place/delete | `RemoveAndAddItem` is `false` or `item.enabled` is `false` | Enable both `Config.RemoveAndAddItem` and `item.enabled` for the target prop. |
| Usable item not working | Framework mismatch or item not registered in inventory system | Verify `Config.Framework` matches your server. Ensure the item exists in your framework's item registry. |
| Objects persist after resource restart | Objects are only cleaned up on `onResourceStop` | Restart the resource (`restart gfx-propspawner`) to clean up all spawned objects. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-propspawner
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
