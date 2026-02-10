# gfx-lumberjack

A lumberjack job script for FiveM with a full NUI interface, leveling system, axe tier upgrades, contract system, leaderboard, and tutorial mode.

---

## Info

| Key | Value |
|---|---|
| **Author** | Psytion |
| **FX Version** | Cerulean |
| **Game** | GTA5 |
| **Lua 5.4** | Yes |
| **NUI** | Yes |
| **Database** | Yes (2 tables) |
| **Frameworks** | QBCore, ESX |

---

## Dependencies

| Dependency | Required | Notes |
|---|---|---|
| **qb-core** or **es_extended** | Yes | Framework (auto-detected at runtime) |
| **oxmysql** | Yes (default) | SQL adapter. Also supports `mysql-async` and `ghmattimysql` via config |
| **qb-target** or **ox_target** | No | Optional interaction target. Falls back to `drawtext` mode |

---

## Installation

### 1. Import SQL Tables

Import both SQL files into your database:

```sql
-- lumberjack.sql
CREATE TABLE IF NOT EXISTS `gfx_lumberjack`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) DEFAULT NULL,
    `lumberjackName` varchar(50) DEFAULT NULL,
    `cuttingTrees` int(11) DEFAULT 0,
    `level` int(11) DEFAULT 0,
    `total_money` int(11) DEFAULT 0,
    `profile_photo` varchar(250) DEFAULT "",
    PRIMARY KEY (`id`),
    KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

-- lumberjackcontract.sql
CREATE TABLE IF NOT EXISTS `gfx_lumberjack_contract`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) DEFAULT NULL,
    `contractOwner` varchar(50) DEFAULT NULL,
    `treeCount` varchar(50) DEFAULT NULL,
    `percent` int(11) DEFAULT 0,
    `numberOfUses` int(11) DEFAULT 0,
    `profile_photo` varchar(250) DEFAULT "",
    PRIMARY KEY (`id`),
    KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;
```

### 2. Copy Resource

Copy the `gfx-lumberjack` folder into your server's resources directory.

### 3. server.cfg

```cfg
ensure oxmysql
ensure qb-core   # or es_extended
ensure gfx-lumberjack
```

### 4. Steam Web API Key (optional)

If `Config.ProfilePhotoType` is set to `"steam"`, you must have a Steam Web API key configured in your `server.cfg`.

---

## Configuration

All configuration is in `config.lua`.

### General Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.SQLScript` | string | `"oxmysql"` | SQL adapter: `"oxmysql"`, `"mysql-async"`, or `"ghmattimysql"` |
| `Config.target` | string | `"ox_target"` | Interaction method: `"qb-target"`, `"ox_target"`, or `"drawtext"` |
| `Config.interactionKey` | number | `38` (E) | Key control ID for drawtext interaction mode |
| `Config.ProfilePhotoType` | string | `"steam"` | Leaderboard profile photo source: `"discord"`, `"steam"`, or `"none"` |
| `Config.DiscordToken` | string | `""` | Discord bot token (required only if `ProfilePhotoType` is `"discord"`) |
| `Config.NoImage` | string | `"assets/images/default-pp.png"` | Default profile photo fallback |

### Job NPC and Blip

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.lumberjack.pos` | vector3 | `(-552.54, 5348.58, 73.74)` | NPC spawn position |
| `Config.lumberjack.heading` | number | `67.53` | NPC heading |
| `Config.lumberjack.ped` | string | `"s_m_m_lathandy_01"` | NPC ped model |
| `Config.lumberjack.blip.sprite` | number | `77` | Blip sprite ID |
| `Config.lumberjack.blip.color` | number | `2` | Blip color ID |
| `Config.lumberjack.blip.scale` | number | `0.8` | Blip scale |
| `Config.lumberjack.blip.name` | string | `"Lumberjack"` | Blip display name |

### Money and Cutting

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.lumberjack.Money.cuttingTreePerMoney` | number | `100` | Cash earned per tree cut |
| `Config.lumberjack.CuttingTreeTime` | number | `5000` | Cutting animation duration in milliseconds |
| `Config.lumberjack.levelUpLimit` | number | `5` | Number of trees cut required per level |

### Tutorial Section

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.lumberjack.tutorialSection.startPos` | vector3 | `(-507.41, 5256.82, 80.63)` | Log pickup position |
| `Config.lumberjack.tutorialSection.endPos` | vector3 | `(-513.29, 5271.70, 79.55)` | Log delivery position |
| `Config.lumberjack.tutorialSection.moneyPerCarriyngLog` | number | `10` | Cash earned per log carried in tutorial |

### Axe Tiers

Players unlock better axes as they cut more trees. Higher tier axes provide a bonus percentage on earnings.

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.lumberjack.axe.tier1axe` | string | `"w_me_stonehatchet"` | Tier 1 axe prop model (default axe) |
| `Config.lumberjack.axe.tier2axe` | string | `"prop_w_me_hatchet"` | Tier 2 axe prop model |
| `Config.lumberjack.axe.tier2axeUpgradeLimit` | number | `50` | Trees cut to unlock tier 2 |
| `Config.lumberjack.axe.tier2axeBonusPercent` | number | `20` | Bonus percentage for tier 2 (20%) |
| `Config.lumberjack.axe.tier3axe` | string | `"prop_ld_fireaxe"` | Tier 3 axe prop model |
| `Config.lumberjack.axe.tier3axeUpgradeLimit` | number | `100` | Trees cut to unlock tier 3 |
| `Config.lumberjack.axe.tier3axeBonusPercent` | number | `40` | Bonus percentage for tier 3 (40%) |

### Contract Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.lumberjack.contractSettings.contractMoney` | number | `100` | Base money per tree for contract jobs |
| `Config.lumberjack.contractSettings.maxTreeCount` | number | `75` | Maximum trees allowed in a contract |
| `Config.lumberjack.contractSettings.maxPercent` | number | `50` | Maximum bonus percentage a contract can offer |
| `Config.lumberjack.contractSettings.contractNumberOfUses` | number | `3` | Number of times a contract can be accepted |
| `Config.lumberjack.contractSettings.makeContractLevel` | number | `5` | Minimum level required to create contracts |

### Tree Locations

`Config.lumberjack.TreeLocations` is an array of `vector3` positions where trees can be cut. The script randomly selects the next tree location from this list (ensuring the player is not sent to their current position). 14 locations are provided by default in the Paleto Forest area.

### Notification Texts

All player-facing notification strings can be customized in `Config.NotifyTexts`:

| Key | Default Text |
|---|---|
| `lumberjackDataNotFound` | `"warning: lumberjack data not found"` |
| `interaction` | `"Press [~g~E~w~] to cut tree"` |
| `earnMoney` | `"You earned $%s"` |
| `levelUp` | `"You're level up! Your Level %s"` |
| `startjob` | `"You have started the job"` |
| `stopjob` | `"You have stopped the job"` |
| `cantmakecontract` | `"You can't make a contract"` |
| `alreadystartjob` | `"You have already started the job"` |
| `completeContract` | `"You have completed the contract"` |

---

## Exports

*No exports found.* This script does not create any exports via `exports()`.

---

## Events

*No public API events found.* All registered events are internal to the script (client-server communication and NUI callbacks) and are not intended for use by external scripts.

---

## Commands

*No commands found.* Interaction with the job is done through the NPC using a target system or drawtext.

---

## Features

### Lumberjack Job
- Interact with the lumberjack NPC to open the job UI
- Start/stop the job at any time through the NUI panel
- Random tree selection with checkpoint and blip navigation
- Cutting animation with player freeze during the action
- Configurable cutting duration

### Tutorial Mode
- Introductory mode where players carry logs between two points instead of cutting trees
- Uses a carry animation with a log prop attached to the player
- Separate start and end checkpoints with blips

### Leveling System
- Players level up by cutting trees (configurable trees-per-level threshold)
- Level tracked in the database and displayed in the UI
- Level gates access to contract creation

### Axe Tier Upgrades
- Three axe tiers unlocked by total trees cut
- Each tier uses a different prop model and provides an earning bonus
- **Tier 1:** Stone hatchet (0% bonus, default)
- **Tier 2:** Hatchet (20% bonus, unlocked at 50 trees)
- **Tier 3:** Fire axe (40% bonus, unlocked at 100 trees)

### Contract System
- Players at the required level can create contracts for others to complete
- Contracts specify a tree count and a bonus percentage
- Contract creators earn money when other players complete their contracts
- Contracts have a limited number of uses before being removed
- Players can only have one active contract at a time
- Offline contract owners receive their earnings directly via database update

### Leaderboard
- NUI leaderboard showing top 30 players
- Displays player name, trees cut, total earnings, and profile photo
- Supports Steam and Discord profile photos

### NUI Interface
- Full HTML/CSS/JS interface for job management
- Real-time work time tracker, trees cut counter, and money earned display
- Pages for: job start/stop, leaderboard, contracts (view/create/take/delete)

### Interaction Methods
- **qb-target:** Target model interaction on the NPC
- **ox_target:** Target model interaction on the NPC
- **drawtext:** 3D text prompt with key press interaction

### Framework Support
- Auto-detects QBCore or ESX at startup
- Framework-specific money handling (AddMoney / addAccountMoney)
- Framework-specific server callbacks

### Database
- Persistent player data (level, trees cut, total money, profile photo)
- Persistent contract data (owner, tree count, percent, uses remaining)
- Supports oxmysql, mysql-async, and ghmattimysql

---

## Troubleshooting

| Problem | Cause | Solution |
|---|---|---|
| "lumberjack data not found" notification | Player has no entry in `gfx_lumberjack` table | This should auto-create on first interaction. Verify the SQL tables were imported correctly |
| NPC not spawning | Ped model not loaded or coordinates misconfigured | Check `Config.lumberjack.ped` is a valid model and `Config.lumberjack.pos` is a valid position |
| Profile photos not loading | Missing Steam Web API key or invalid Discord token | For Steam: add `set steam_webApiKey "YOUR_KEY"` in server.cfg. For Discord: set `Config.DiscordToken` |
| Target interaction not working | Wrong target resource name in config | Set `Config.target` to match your installed target resource exactly: `"qb-target"`, `"ox_target"`, or `"drawtext"` |
| No money received after cutting | Framework not detected or SQL adapter mismatch | Ensure your framework resource starts before this script. Verify `Config.SQLScript` matches your installed SQL resource |
| Contract creation fails | Player level too low or already has a contract | Player must be at least level `Config.lumberjack.contractSettings.makeContractLevel` and must not have an existing contract |
| Trees not appearing on map | Blip/checkpoint not created | Ensure `Config.lumberjack.TreeLocations` has valid vector3 positions in a playable area |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-lumberjack
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
