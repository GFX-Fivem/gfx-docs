# Framework Support

GFX scripts use `gfx-lib` for automatic framework detection. You don't need to manually set a framework — it's detected at startup.

## Supported Frameworks

| Framework | Resource Name | Supported |
|---|---|---|
| QBCore | `qb-core` | Yes |
| Qbox | `qb-core` (Qbox is QBCore-compatible) | Yes |
| ESX | `es_extended` | Yes |
| ESX Legacy | `es_extended` | Yes |
| Old ESX (1.2-) | `es_extended` | Yes (set `Config.OldESX = true` in gfx-lib) |

## How Detection Works

On startup, `gfx-lib` iterates through known framework resource names and checks `GetResourceState()`. The first one found in a `"started"` state is used.

Detection order: `es_extended` then `qb-core`

Once detected, gfx-lib initializes:
- **`Utils.Framework`** — The framework name string (e.g., `"qb-core"`)
- **`Utils.FrameworkObject`** — The framework's core object (QBCore or ESX object)
- **`Utils.FrameworkShared`** — Shared data (QBCore.Shared or ESX.Config)

## Auto-Detected Dependencies

Beyond the framework, gfx-lib also auto-detects:

### Inventory Systems (Server)

| Inventory | Resource Name |
|---|---|
| QB Inventory | `qb-inventory` |
| ESX Inventory HUD | `esx_inventoryhud` |
| OX Inventory | `ox_inventory` |
| QS Inventory | `qs-inventory` |
| Codem Inventory | `codem-inventory` |
| PS Inventory | `ps-inventory` |
| Tgiann Inventory | `tgiann-inventory` |
| GFX Inventory | `gfx-inventory` |

### Skin/Clothing Scripts (Client + Server)

| Script | Resource Name |
|---|---|
| ESX Skin | `esx_skin` |
| QB Clothing | `qb-clothing` |
| Skinchanger | `skinchanger` |
| Illenium Appearance | `illenium-appearance` |
| FiveM Appearance | `fivem-appearance` |
| Tgiann Clothing | `tgiann-clothing` |
| CRM Appearance | `crm-appearance` |
| RCore Clothing | `rcore_clothing` |
| BL Appearance | `bl_appearance` |

### Target Scripts (Client)

| Script | Resource Name |
|---|---|
| OX Target | `ox_target` |
| QB Target | `qb-target` |

### SQL Resources (Server)

| Script | Resource Name |
|---|---|
| OxMySQL | `oxmysql` |
| GHMatti MySQL | `ghmattimysql` |
| MySQL Async | `mysql-async` |

## Accessing Detected Values

From any GFX script, you can access detected values via the `Utils` table:

```lua
-- Client side
local modules = exports['gfx-lib']:getModules()
local utils = exports['gfx-lib']:getUtils()

print(utils.Framework)      -- "qb-core" or "es_extended"
print(utils.SkinScript)     -- e.g., "illenium-appearance"
print(utils.TargetScript)   -- e.g., "ox_target"

-- Server side
local modules = exports['gfx-lib']:getModules()
local utils = exports['gfx-lib']:getUtils()

print(utils.Framework)      -- "qb-core" or "es_extended"
print(utils.InventoryName)  -- e.g., "ox_inventory"
print(utils.SQLScript)      -- e.g., "oxmysql"
print(utils.SkinScript)     -- e.g., "qb-clothing"
```

## Troubleshooting

| Problem | Solution |
|---|---|
| Framework shows "Not found" | Your framework resource must start **before** `gfx-lib` |
| Inventory shows "Not found" | Your inventory resource must be running when gfx-lib starts |
| Wrong framework detected | Only one framework should be running. If both ESX and QBCore are installed, ESX takes priority |
