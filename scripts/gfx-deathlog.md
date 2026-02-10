# gfx-deathlog

## Info

| Key | Value |
|-----|-------|
| **Name** | gfx-deathlog |
| **Description** | Death log and player report system with NUI interface and Discord webhook integration |
| **FX Version** | cerulean |
| **Game** | GTA 5 |
| **Lua 5.4** | Yes |
| **Sides** | Client, Server, NUI |
| **Escrow Support** | Yes |

---

## Dependencies

- No external resource dependencies required (built-in framework auto-detection for ESX / QBCore)

---

## Installation

### 1. Copy Files
Place the `gfx-deathlog` folder into your server's resources directory.

### 2. Configure Webhook
Edit `server/webhook.lua` and set your Discord webhook URL:
```lua
DISCORD = {
    WEBHOOK = "https://discord.com/api/webhooks/YOUR_WEBHOOK_HERE",
}
```

### 3. server.cfg
```cfg
ensure gfx-deathlog
```

---

## Configuration

Configuration is defined in `config.lua`.

### Config.FatalIndex
```lua
Config.FatalIndex = 6
```
The index position in `CEventNetworkEntityDamage` event data used to determine if damage was fatal. Default is `6`.

### Config.Weapons
A lookup table that maps weapon hashes to their string names. This is used to identify the weapon used in a kill and display the corresponding weapon image in the NUI.

Supported weapon categories:
- **Rifles:** carbinerifle, assaultrifle, compactrifle (including MK2 variants)
- **Machine Guns:** combatmg, mg (including MK2 variants)
- **Snipers:** heavysniper, marksmanrifle, sniperrifle (including MK2 variants)
- **SMGs:** microsmg, minismg, smg, assaultsmg, combatpdw, gusenberg, machinepistol (including MK2 variants)
- **Pistols:** pistol, pistol50, snspistol, stungun, vintagepistol, appistol, combatpistol, doubleaction, flaregun, heavypistol, marksmanpistol, revolver (including MK2 variants)
- **Shotguns:** pumpshotgun, assaultshotgun, bullpupshotgun, dbshotgun, heavyshotgun, musket, sawnoffshotgun, autoshotgun (including MK2 variants)
- **Heavy Weapons:** grenadelauncher, grenadelauncher_smoke, hominglauncher, compactlauncher, minigun, firework, rpg

To add a new weapon, add an entry to the `Config.Weapons` table:
```lua
[`weapon_name`] = "weapon_name",
```
You also need to place a matching weapon image at `nui/assets/weapons/weapon_name.webp`.

---

## Exports

*No exports are created by this script.*

---

## Events

### Client Events

#### `rush-deadlog:client:UpdateDeadLogs`
Sent from the server to the victim client to update their local death log list with new killer data.

| Direction | Trigger |
|-----------|---------|
| Server -> Client | `TriggerClientEvent` |

**Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `killerdata` | `table` | Kill information table (see structure below) |

**killerdata structure:**
```lua
{
    nickname = "PlayerName",   -- Killer's player name
    source = 1,                -- Killer's server ID
    weapon = "weapon_pistol",  -- Weapon name string or false
    identifier = "steam:...",  -- Killer's identifier (absent if self-kill)
    me = true                  -- Present and true only if self-kill
}
```

---

#### `rush-deadlog:client:Report`
Broadcast to all clients when a player report is submitted. Displays a chat notification with report details.

| Direction | Trigger |
|-----------|---------|
| Server -> Client | `TriggerClientEvent` (to all players) |

**Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `reported` | `table` | `{ source = number, name = string }` - The reported player |
| `reporter` | `table` | `{ source = number, name = string }` - The reporting player |

---

### Server Events

#### `rush-deadlog:server:UpdateDeadLogs`
Triggered by the victim's client when they die. The server can process this for logging purposes.

| Direction | Trigger |
|-----------|---------|
| Client -> Server | `TriggerServerEvent` |

**Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `killerData` | `table` | Same killerdata structure as described above |

---

#### `rush-deadlog:server:ReportDeadLog`
Triggered by the client when a player clicks the Report button in the death log NUI. Sends a Discord webhook notification and prevents duplicate reports.

| Direction | Trigger |
|-----------|---------|
| Client -> Server | `TriggerServerEvent` |

**Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| `data` | `table` | `{ killersource = number, killernickname = string, killeridentifier = string }` |

---

## Commands

| Command | Description | Restricted |
|---------|-------------|------------|
| `/deadlog` | Opens the death log NUI panel showing all recorded deaths for the current session | No |
| `/reports` | Opens the reports NUI panel showing all submitted player reports | No |

---

## Features

- **Death Tracking:** Automatically detects when a player is killed and records the killer's name, server ID, weapon used, and timestamp
- **NUI Death Log Panel:** Modern UI panel (`/deadlog`) displaying all deaths with weapon icons, killer names, and timestamps
- **Self-Kill Detection:** Identifies and labels deaths caused by the player themselves (e.g., falling, explosions)
- **Unknown Weapon Handling:** Displays a question mark icon when the weapon used is not in the configured weapon list
- **In-UI Player Reporting:** Players can report their killer directly from the death log panel with a single click
- **Duplicate Report Prevention:** Server-side check prevents a player from reporting the same killer more than once
- **Discord Webhook Integration:** Player reports are sent to a Discord channel via webhook with detailed embed messages including player identifiers (Steam, Discord, License, IP)
- **Report Broadcast:** When a report is submitted, all players receive a chat notification with reporter and reported player info
- **Admin Reports Panel:** The `/reports` command opens a panel listing all submitted reports with reporter, reported player, and reason
- **Synced Scrolling:** Death log timeline and kill entries scroll in sync for easy navigation
- **Framework Auto-Detection:** Built-in server utilities automatically detect ESX or QBCore frameworks
- **Escape to Close:** Press `Escape` to close any open NUI panel

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `/deadlog` shows empty list | Deaths are only tracked for the current session. Reconnecting clears the log. |
| Weapon icon not showing | Ensure the weapon is listed in `Config.Weapons` and a matching `.webp` image exists in `nui/assets/weapons/`. |
| Discord webhook not sending | Verify the `DISCORD.WEBHOOK` URL in `server/webhook.lua` is valid and not empty. |
| Report button not appearing | The report button is hidden for self-kills and for source ID 0 entries. This is intended behavior. |
| NUI not closing | Press `Escape` to close. If stuck, run `SetNuiFocus(false, false)` in the F8 console. |
| "killed by" shows wrong player | This can occur if the killer ped is not properly networked. Ensure all players are within streaming range. |
