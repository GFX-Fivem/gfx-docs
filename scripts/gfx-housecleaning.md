# GFX House Cleaning

A cooperative house cleaning job script for FiveM. Players interact with an NPC to create squads, invite other players, accept cleaning missions of varying difficulty, and earn money and experience by cleaning interior shells. Supports multiple house types, team-based gameplay with routing buckets, and a full NUI-based mission interface.

---

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-housecleaning` |
| **Author** | atiysu |
| **FX Version** | Cerulean |
| **Game** | Common |
| **Lua 5.4** | Yes |
| **Map Resource** | Yes (`this_is_a_map`) |
| **Framework** | QBCore / ESX (configurable) |
| **Storage** | JSON file (`database.json`) |
| **UI** | NUI (HTML/CSS/JS) |

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| **qb-core** or **es_extended** | Framework core (player data, money, notifications) |
| **Discord Bot Token** | Used to fetch player avatars from Discord API (configured in `serverconfig.lua`) |

---

## Installation

### 1. Copy Files
Place the `gfx-housecleaning` folder into your server's resources directory.

### 2. Configure Framework
Edit `config.lua` and set the framework:
```lua
Config.Framework = "qb" -- "qb" or "esx"
```

### 3. Configure Discord Bot Token
Edit `serverconfig.lua` and set your Discord bot token for player avatar fetching:
```lua
Config.DiscordBotToken = "YOUR_BOT_TOKEN_HERE"
```

### 4. server.cfg
```cfg
ensure gfx-housecleaning
```

> **Note:** The script includes shell models in the `stream/` folder. The `this_is_a_map` flag in `fxmanifest.lua` ensures they are streamed automatically.

---

## Configuration

All configuration is done in `config.lua`.

### Framework
```lua
Config.Framework = "qb" -- "qb" or "esx"
```

### NPC Ped
Controls the job NPC that players interact with to start missions.

| Option | Type | Description |
|--------|------|-------------|
| `Config.Ped.Model` | `string` | Ped model name (default: `s_m_m_dockwork_01`) |
| `Config.Ped.Position` | `vector3` | NPC world position |
| `Config.Ped.Heading` | `number` | NPC heading direction |
| `Config.Ped.BlipName` | `string` | Map blip label (default: `"House Cleaning Job"`) |

### Notifications
```lua
Config.Notify = function(message, type, length)
    -- Customize notification system here
end
```

### Missions
Each mission is a table in `Config.Missions` with the following fields:

| Field | Type | Description |
|-------|------|-------------|
| `Name` | `string` | Mission display name |
| `HouseType` | `string` | House shell type key (must match a key in `Config.HouseTypes`) |
| `Description` | `string` | Mission description shown in UI |
| `Image` | `string` | Image filename for the mission card |
| `Salary` | `number` | Cash reward on completion |
| `Exp` | `number` | Experience points earned |
| `Level` | `number` | Minimum player level required (0-based) |
| `MinMembers` | `number` | Minimum squad members to start |
| `MaxMembers` | `number` | Maximum squad members allowed |
| `Difficulty` | `number` | Difficulty tier (1, 2, or 3) -- affects number of cleaning spots |
| `HouseEntrance` | `vector3` | World coordinates for the house entrance marker |

**Default Missions:**

| Mission | House Type | Salary | Exp | Level | Min/Max Members | Difficulty |
|---------|-----------|--------|-----|-------|----------------|------------|
| Small House | `small` | $1,000 | 10 | 0 | 1-2 | 1 |
| Non Used House | `medium` | $1,200 | 10 | 1 | 1-3 | 2 |
| Medium House | `medium_l` | $1,000 | 10 | 1 | 1-4 | 2 |
| Medium House 2 | `medium_l2` | $1,300 | 20 | 2 | 1-4 | 2 |
| Office | `office` | $1,500 | 10 | 3 | 1-2 | 2 |
| Medium House 3 | `medium_l3` | $2,000 | 20 | 3 | 1-4 | 3 |
| Air BnB | `big` | $3,500 | 30 | 4 | 2-5 | 3 |

### House Types
Each house type in `Config.HouseTypes` defines:

| Field | Type | Description |
|-------|------|-------------|
| `StreamName` | `string` | Model name of the shell (streamed from `stream/`) |
| `SpawnAt` | `vector4` | Interior spawn position and heading |
| `CleaningPositions` | `table` | Array of cleaning spot definitions |

Each cleaning position has:
- `coords` (`vector3`) -- World coordinates of the spot
- `type` (`string`) -- Cleaning type: `"trash"`, `"mop"`, or `"wipe"`

**Available House Shells:**

| Key | Shell Model | Positions |
|-----|-------------|-----------|
| `small` | `modernhotel_shell` | 12 |
| `medium` | `furnitured_midapart` | 16 |
| `medium_l` | `shell_trevor` | 10 |
| `medium_l2` | `shell_frankaunt` | 10 |
| `medium_l3` | `shell_lester` | 8 |
| `office` | `shell_office1` | 9 |
| `big` | `shell_michael` | 21 |

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events for external scripts. All events are internal to the resource.*

---

## Commands

| Command | Arguments | Description |
|---------|-----------|-------------|
| `/acceptinvite` | `[invite_id]` | Accept a squad invite by its ID. The invite ID is shown in the notification when you receive an invite. |
| `/myinvites` | None | Display a list of all pending squad invites you have received. Invites expire after 60 seconds. |

---

## Features

### Core Gameplay
- **Cooperative squad system** -- Create squads, invite players by server ID, and complete missions together
- **7 pre-configured missions** with different house types, difficulties, and rewards
- **3 cleaning task types** -- Pick up trash (carry to door), mop floors, wipe dust -- each with unique animations and props
- **Level progression** -- Players earn EXP that unlocks higher-level missions
- **Difficulty scaling** -- Higher difficulty missions spawn more cleaning spots from the available positions

### Technical
- **NUI interface** for squad management, mission selection, and player profiles
- **Routing bucket isolation** -- Squad members are moved to a private routing bucket when entering a house, ensuring instance separation
- **Discord avatar integration** -- Player profile images are fetched from Discord via bot API
- **JSON-based storage** -- Player data (name, license, exp, invite preferences, avatar) stored in `database.json`
- **Map blips** -- NPC location blip and dynamic mission waypoint/blip
- **Shell streaming** -- 7 unique interior shell models included in the `stream/` folder
- **Invite system** -- Invites auto-expire after 60 seconds; players can toggle invite reception on/off
- **Squad leader controls** -- Only the leader can start missions and kick members
- **Clean resource stop** -- All entities and blips are properly cleaned up on resource stop

### Cleaning Workflow
1. Approach the NPC and press `E` to open the mission menu
2. Create a squad (automatically become leader)
3. Optionally invite other players by their server ID
4. Select and start a mission (must meet minimum member and level requirements)
5. Travel to the house entrance (waypoint set automatically)
6. Enter the house (screen fades, teleport to shell interior)
7. Clean all marked spots -- trash must be carried back to the entrance door
8. Leave the house after all spots are cleaned
9. Salary and EXP are awarded to all squad members

---

## Locales

All player-facing text strings are defined in `locales.lua` via the `Translates` table. Override any string to change the language or wording.

| Key | Default Text |
|-----|-------------|
| `start_mission` | Press ~INPUT_PICKUP~ to start a mission |
| `enter_house` | Press ~INPUT_PICKUP~ to enter the house |
| `leave_house` | Press ~INPUT_PICKUP~ to leave the house |
| `throw_trash` | Press ~INPUT_PICKUP~ to throw out the trash |
| `pickup_trash` | Press ~INPUT_PICKUP~ to pick up the trash |
| `mop_floor` | Press ~INPUT_PICKUP~ to mop the floor |
| `wipe` | Press ~INPUT_PICKUP~ to wipe the dust |
| `sent_invite` | You have sent an invite |
| `minimum_member` | You need at least %s members to start this mission |
| `mission_started` | The mission has started, go to the house. |
| `cleared_house` | You have cleared the house, leave the house to finish the mission. |
| `received_invite` | You have received a squad invite, invite id: %s. To see your invites type /myinvites. |

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| NPC not spawning | Verify `Config.Ped.Model` is a valid ped model and the coordinates are correct |
| House shell not loading / timeout | Ensure all `.ydr`, `.ytd`, `.ytyp`, and `.ymap` files are present in the `stream/` folder. Check that `this_is_a_map 'yes'` is set in `fxmanifest.lua` |
| Player avatars not loading | Verify the Discord bot token in `serverconfig.lua` is valid and the bot has access to the Discord API |
| "Error creating squad" notification | Check server console for errors; ensure the framework is configured correctly in `config.lua` |
| Mission won't start | Ensure the squad meets the `MinMembers` requirement for the selected mission |
| Players can't see each other in the house | All squad members must enter the house; they are placed in a shared routing bucket |
| Invites not received | The target player may have invites toggled off in the UI, or the invite may have expired (60s timeout) |
| `database.json` errors | Ensure the file exists in the resource root and contains valid JSON (at minimum `{}`) |
| Cleaning spots not appearing | Verify the `HouseType` in the mission matches a key in `Config.HouseTypes` and that cleaning positions are defined |
| Framework not detected | Ensure `Config.Framework` is set to exactly `"qb"` or `"esx"` and the corresponding core resource is started before this one |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-housecleaning
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
