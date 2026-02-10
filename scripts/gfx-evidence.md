# gfx-evidence

## Info

| Key | Value |
|---|---|
| **Name** | gfx-evidence |
| **Author** | GFX Development |
| **FX Version** | Cerulean |
| **Game** | GTA5 |
| **Lua 5.4** | Yes |
| **Side** | Client + Server |
| **UI** | NUI (HTML/CSS/JS) |
| **Escrow** | Yes (with open-source server/client/config) |

## Description

A forensic evidence system for FiveM roleplay servers. When players take damage, fire weapons, or interact with the world, evidence is automatically dropped at the scene (blood, casings, bullet cores, fingerprints). Authorized law enforcement can discover evidence using flashlights, collect it into evidence bags, and analyze samples at forensic lab stations. The script includes a full NUI tablet interface for reviewing analyzed evidence with 3D model previews. Supports both ESX and QBCore frameworks.

---

## Dependencies

| Dependency | Purpose |
|---|---|
| **QBCore** or **ESX** | Framework (configured via `Config.Framework`) |
| **oxmysql** / **mysql-async** / **ghmattimysql** | Database queries (configured via `Config.SQLScript`) |
| **qb-weapons** | Weapon serial number retrieval (QBCore only, used for casing/bullet core data) |

---

## Installation

### 1. Import Database Table

The script requires a `gfx_evidences` table. Create it in your database:

```sql
CREATE TABLE IF NOT EXISTS `gfx_evidences` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `evidenceId` INT NOT NULL,
    `evidenceData` LONGTEXT NOT NULL
);
```

### 2. Copy Files

Place the `gfx-evidence` folder into your server's resources directory.

### 3. server.cfg

```cfg
ensure gfx-evidence
```

Make sure your framework (`qb-core` or `es_extended`) and SQL resource (`oxmysql`, `mysql-async`, or `ghmattimysql`) start before this resource.

### 4. QBCore Only: Add Evidence Bag Item

If using QBCore, add the `filled_evidence_bag` item to your shared items:

```lua
filled_evidence_bag = { name = "filled_evidence_bag", label = "Evidence Bag", weight = 100, type = "item", image = "filled_evidence_bag.png", unique = true, useable = true, shouldClose = true, description = "A sealed evidence bag" },
```

---

## Configuration

All configuration is in `config.lua`:

### General Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `Framework` | `string` | `"qb"` | Framework to use: `"esx"` or `"qb"` |
| `SQLScript` | `string` | `"oxmysql"` | SQL resource: `"oxmysql"`, `"mysql-async"`, or `"ghmattimysql"` |
| `BloodDropInterval` | `number` | `5` | Seconds between health checks for blood drop detection |
| `InteractKey` | `number` | `46` | Control key for interaction (46 = E) |
| `MustCheckWithFlashlight` | `boolean` | `true` | If true, players must have a flashlight on to see evidence markers |

### Authorized Jobs

Controls which jobs can see and collect evidence:

```lua
AuthorizedJobs = {
    ["police"] = true,
    ["ambulance"] = true,
},
```

### Evidence Dropping for Authorized Jobs

Controls whether authorized job players also leave evidence behind:

```lua
AuthorizedJobsShouldDrop = {
    blood = true,       -- Police can leave blood drops
    casing = true,      -- Police can leave casings
    bulletcore = true,   -- Police can leave bullet cores
},
```

### Lab Coordinates

Define forensic analysis stations. Each lab type can only analyze matching evidence:

- **ballistic** -- Analyzes `casing` and `bulletcore` evidence
- **fingerprint** -- Analyzes `fingerprint` evidence
- **dna** -- Analyzes `blood` and `fingerprint` evidence

```lua
LabCoords = {
    ["ballistic"] = {
        coords = { vector3(437.6529, -994.524, 30.689) },
        label = "Ballistic Examination",
        distance = 1.5,
    },
    ["fingerprint"] = {
        coords = { vector3(437.2374, -990.759, 30.689) },
        label = "Fingerprint Examination",
        distance = 1.5,
    },
    ["dna"] = {
        coords = { vector3(441.2716, -995.982, 30.689) },
        label = "DNA Examination",
        distance = 1.5,
    },
},
```

### Evidence Database Menu Coordinates

Locations where authorized players can open the evidence database tablet:

```lua
OpenMenuCoords = {
    vector3(437.3485, -996.558, 31.057),
},
```

### Locales

All displayed text strings are configurable:

```lua
Locales = {
    ["blood"] = "DNA Sample",
    ["casing"] = "Casing Sample",
    ["bulletcore"] = "Bullet Core Sample",
    ["fingerprint"] = "Fingerprint Sample",
    ["blood_3dtext"] = "Blood Drop",
    ["casing_3dtext"] = "Casing Drop",
    ["bulletcore_3dtext"] = "Bullet Core",
    ["fingerprint_3dtext"] = "Fingerprint Drop",
    ["interact_3dtext"] = "E - ",
    ["not_authorized"] = "You are not authorized to do this!",
    ["useitem_3dtext"] = "Use evidence bag to ",
    ["openmenu_3dtext"] = "Open evidence database",
    ["already_analyzed"] = "This evidence has already been analyzed!",
},
```

### Weapon Categories

Maps weapon hashes to categories for casing/bullet core identification. Categories: `pistol`, `smg`, `shotgun`, `rifle`, `mg`, `sniper`, `heavy`. The 3D models shown in the analysis UI are determined by these categories.

---

## Exports

### Client Exports

#### `DropFingerPrint`

Drops a fingerprint evidence marker at the player's location or at specified coordinates.

```lua
exports['gfx-evidence']:DropFingerPrint(coords?)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `coords` | `vector3` | No | Coordinates to drop the fingerprint at. Defaults to player position if omitted. |

**Example:**
```lua
-- Drop fingerprint at player's current location
exports['gfx-evidence']:DropFingerPrint()

-- Drop fingerprint at specific coordinates
exports['gfx-evidence']:DropFingerPrint(vector3(100.0, 200.0, 30.0))
```

---

#### `DropBlood`

Drops a blood evidence marker if the player's health has decreased since the last check.

```lua
exports['gfx-evidence']:DropBlood(coords?)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `coords` | `vector3` | No | Coordinates to drop blood at. Defaults to player position if omitted. |

**Note:** This function only creates evidence if the player's current health is lower than the previously recorded health. It is designed to detect damage events.

**Example:**
```lua
-- Trigger a blood drop check at player's position
exports['gfx-evidence']:DropBlood()
```

---

#### `DropCasing`

Drops a weapon casing evidence marker if the player is currently shooting. Includes weapon serial number and category data.

```lua
exports['gfx-evidence']:DropCasing(coords?)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `coords` | `vector3` | No | Coordinates to drop the casing at. Defaults to player position if omitted. |

**Note:** This function only creates evidence if the player is actively shooting (`IsPedShooting`), the weapon is in the configured `WeaponCategories`, and at least 1 second has passed since the last casing drop. Requires `qb-weapons` for serial number data.

**Example:**
```lua
-- Trigger a casing drop check at player's position
exports['gfx-evidence']:DropCasing()
```

---

## Events

Public API events that other scripts can listen to or trigger.

### Client Events

#### `gfx-evidence:client:dropBlood`

Fired on all authorized clients when a blood evidence drop is created.

```lua
RegisterNetEvent("gfx-evidence:client:dropBlood", function(evidenceData)
    -- evidenceData = { id, userId, coords, time, evidenceType = "blood" }
end)
```

---

#### `gfx-evidence:client:dropCasing`

Fired on all authorized clients when a casing evidence drop is created.

```lua
RegisterNetEvent("gfx-evidence:client:dropCasing", function(evidenceData)
    -- evidenceData = { id, userId, coords, time, weaponData, evidenceType = "casing" }
    -- weaponData = { weaponHash, weaponCategory, serial }
end)
```

---

#### `gfx-evidence:client:dropBulletCore`

Fired on all authorized clients when a bullet core evidence drop is created.

```lua
RegisterNetEvent("gfx-evidence:client:dropBulletCore", function(evidenceData)
    -- evidenceData = { id, userId, coords, time, weaponData, evidenceType = "bulletcore" }
    -- weaponData = { weaponHash, weaponCategory, serial }
end)
```

---

#### `gfx-evidence:client:dropFingerPrint`

Fired on all authorized clients when a fingerprint evidence drop is created.

```lua
RegisterNetEvent("gfx-evidence:client:dropFingerPrint", function(evidenceData)
    -- evidenceData = { id, userId, coords, time, evidenceType = "fingerprint" }
end)
```

---

#### `gfx-evidence:client:removeEvidence`

Fired on all authorized clients when an evidence item is collected from the scene.

```lua
RegisterNetEvent("gfx-evidence:client:removeEvidence", function(evidenceId)
    -- evidenceId = number (the unique ID of the removed evidence)
end)
```

---

#### `gfx-evidence:client:analyze`

Fired on a specific client when they use a `filled_evidence_bag` item near a lab station (QBCore). Opens the analysis UI.

```lua
RegisterNetEvent("gfx-evidence:client:analyze", function(evidenceData, slot)
    -- evidenceData = the evidence data stored in the item
    -- slot = inventory slot number of the evidence bag
end)
```

---

## Commands

*No commands registered.*

---

## Features

### Evidence Types

| Type | Trigger | Data Stored |
|---|---|---|
| **Blood** | Player takes damage (health decreases) | Player ID (citizenid/identifier), coordinates, timestamp |
| **Casing** | Player fires a weapon | Weapon hash, weapon category, serial number, coordinates, timestamp |
| **Bullet Core** | Bullet impacts a surface (not a ped or vehicle) | Weapon hash, weapon category, serial number, impact coordinates, timestamp |
| **Fingerprint** | Triggered via export by other scripts | Player ID (citizenid/identifier), coordinates, timestamp |

### Evidence Discovery

- Authorized job players (police, ambulance by default) can see 3D text markers at evidence locations
- When `MustCheckWithFlashlight` is enabled, evidence markers only appear while the flashlight is active
- Evidence is visible within 10 units, interactable within 2 units
- Press the interact key (E) to collect evidence into an evidence bag

### Evidence Collection

- **QBCore:** Evidence is added as a `filled_evidence_bag` item with evidence data stored in item metadata
- **ESX:** Evidence is stored in a server-side collection table per player identifier

### Forensic Analysis

- Three lab station types: Ballistic, Fingerprint, and DNA
- **Ballistic lab** accepts: casings and bullet cores -- reveals weapon serial number and category
- **DNA lab** accepts: blood and fingerprints -- reveals a hashed DNA identifier
- **Fingerprint lab** accepts: fingerprints -- reveals a hashed DNA identifier
- **QBCore:** Use the `filled_evidence_bag` item while near the correct lab station
- **ESX:** Press E near the lab station to analyze

### Evidence Database (NUI Tablet)

- Accessible at configured `OpenMenuCoords` locations by pressing E
- Displays all previously analyzed evidence with 3D model previews
- Shows evidence ID, type, DNA/serial number, and approximate time range
- Blood/fingerprint analysis displays an MD5-hashed DNA identifier (first 15 characters)
- Casing/bullet core analysis displays the weapon serial number
- 3D models vary by evidence type and weapon category (pistol, rifle, shotgun, etc.)

### Data Persistence

- Analyzed evidence is stored in the `gfx_evidences` database table
- Un-analyzed scene evidence exists only in server memory and is lost on restart

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Evidence markers not showing | Ensure `MustCheckWithFlashlight` is configured correctly. If `true`, equip a weapon with flashlight attachment and turn it on. Also verify your job is in `AuthorizedJobs`. |
| "You are not authorized" notification | Your player's job is not listed in `Config.AuthorizedJobs`. Add it to the config. |
| No casings/bullet cores dropping | Verify the weapon is listed in `Config.WeaponCategories`. Also ensure `qb-weapons` is running (QBCore). |
| "Already analyzed" when using evidence bag | That specific evidence has already been processed. Each evidence can only be analyzed once. |
| Lab not accepting evidence | Make sure you are at the correct lab type. Ballistic labs only accept casings/bullet cores. DNA labs only accept blood/fingerprints. |
| Blood not dropping | Blood drops only occur when a player's health decreases between checks (every `BloodDropInterval` seconds). |
| Database errors on startup | Ensure the `gfx_evidences` table exists and your `Config.SQLScript` matches your SQL resource. |
| NUI tablet not opening | Verify you are within 1.5 units of a configured `OpenMenuCoords` location and your job is authorized. Press ESC to close if stuck. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-evidence
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
