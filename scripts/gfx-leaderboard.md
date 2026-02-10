# GFX Leaderboard

A kill/death leaderboard system for FiveM with an in-game NUI scoreboard, 3D podium pedestals displaying the top players as peds with their skins, real-time stat tracking, per-weapon statistics, and profile cards.

---

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx-leaderboard` |
| **Frameworks** | ESX / QBCore / Standalone (detected via `gfx-lib`) |
| **Database** | MySQL (oxmysql or mysql-async) |
| **Lua version** | 5.4 |
| **Sides** | Client + Server |
| **NUI** | Yes |
| **Streaming** | Yes (custom platform props) |

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| **gfx-lib** | Framework detection, callbacks, SQL abstraction, ped skin handling, player identity/photo |
| **oxmysql** | Database driver (default). Can be switched to `mysql-async` by uncommenting in `fxmanifest.lua` |
| One of the supported skin scripts (see Configuration) | Applying player skins to podium peds |

---

## Installation

### 1. Import the SQL table

The script auto-creates the `gfx_leaderboard` table on first start. Alternatively, you can import it manually:

```sql
CREATE TABLE IF NOT EXISTS `gfx_leaderboard` (
  `id` VARCHAR(255) NOT NULL PRIMARY KEY,
  `name` longtext DEFAULT NULL,
  `kills` int(11) DEFAULT NULL,
  `deaths` int(11) DEFAULT NULL,
  `gunskill` longtext DEFAULT NULL,
  `gunsdeath` longtext DEFAULT NULL,
  `image` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
```

### 2. Copy Files

Place `gfx-leaderboard` into your resources folder.

### 3. server.cfg

```cfg
ensure gfx-lib
ensure gfx-leaderboard
```

Make sure `gfx-lib` starts before `gfx-leaderboard`.

---

## Configuration

All configuration is in `config.lua`.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Framework` | string | `"newqb"` | Framework identifier: `esx`, `newesx`, `qb`, `newqb`, or `standalone` |
| `SQLScript` | string | `"oxmysql"` | SQL driver. Use `"mysql-async"` and uncomment the corresponding line in `fxmanifest.lua` if needed |
| `SkinScript` | string | `"qb-clothes"` | Skin script for applying player appearance to podium peds. Options: `qb-clothes`, `esx_skin`, `skinchanger`, `fivem-appearance`, `illenium-appearance` |
| `_3DTextZoffset` | number | `1.5` | Z-axis offset for 3D floating text above peds |
| `SaveInterval` | number | `30` | Auto-save interval in minutes |
| `NPCIncluded` | boolean | `true` | Whether NPC kills/deaths are tracked |
| `WeaponIndex` | number | `7` | Index of the weapon in the `gameEventTriggered` event data |
| `FatalIndex` | number | `6` | Index of the fatal boolean in the `gameEventTriggered` event data |
| `NoImage` | string | URL | Fallback image when no player photo is found |
| `PicturePlatform` | string | `"steam"` | Platform for player profile pictures: `steam` or `discord` |
| `SteamAPIKey` | string | convar | Steam Web API key (reads from `steam_webApiKey` convar) |
| `DrawText` | number | `3` | Draw text style: `1` = 3D Text, `2` = GTA 5 Notification, `3` = Modern Draw Text |
| `Debug` | boolean | `true` | Enable/disable debug prints |
| `OldESX` | boolean | `false` | Set to `true` if using ESX 1.2 or earlier |
| `LicenseType` | string | `"license"` | Player identifier type: `license`, `xbl`, `discord`, `steam`, `live`, `fivem` |
| `PhotoType` | string | `"steam"` | Photo source type: `steam`, `discord`, `none` |
| `Peds` | table | see below | Configuration for podium platforms and ped positions |
| `WeaponLabels` | table | see below | Display names for weapon hashes |
| `WeaponHash` | table | see below | Mapping of weapon hash keys to weapon names for tracking |

### Peds Configuration

Each entry in `Config.Peds` defines a leaderboard category podium. By default, there are two: `kills` and `deaths`.

```lua
Peds = {
    ["kills"] = {
        enable = true,                          -- Enable/disable this podium
        platformColor = "blue",                 -- Platform prop color suffix
        platformCoords = {
            coords = vector3(335.68, -214.36, 53.15),  -- Platform position
            heading = 112.0                              -- Platform heading
        },
        pedCoords = {                           -- Positions for top 3 peds
            [1] = vector4(...),                 -- 1st place
            [2] = vector4(...),                 -- 2nd place
            [3] = vector4(...),                 -- 3rd place
        }
    },
    ["deaths"] = { ... }
}
```

### Weapon Labels & Hashes

- `WeaponLabels` maps internal weapon names (e.g., `"weapon_pistol"`) to display names (e.g., `"Pistol"`). Used in the profile card to show most-used weapons.
- `WeaponHash` maps GTA weapon hash keys to weapon name strings. Only weapons listed here are tracked per-weapon. Add new entries to track additional weapons.

---

## Exports

### Client Exports

#### `FloatyDraw`
Renders floating 3D text/content on a render target prop at world coordinates. Used internally for podium ped info, but available for other resources.

```lua
exports['gfx-leaderboard']:FloatyDraw(coords, heading, callback)
```

**Parameters:**

| Parameter | Type | Description |
|-----------|------|-------------|
| `coords` | vector3 | World coordinates where the floating display should appear |
| `heading` | number | Heading angle (degrees) for the render target orientation |
| `callback` | function | Draw function called with `(entity, distance)` to render content on the render target |

**Returns:** `nil` on success, or a string error message (`"Not on screen"`, `"Point out of range"`, `"Not a visible angle"`, `"Too many targets!"`, `"Failed callback: ..."`)

**Notes:**
- Maximum 19 simultaneous render targets per frame
- Automatically handles visibility culling (off-screen, distance > 100, wrong angle)
- The render target prop background is transparent

---

## Events

No public API events are exposed for external use.

The script internally listens to `gfx-lib:server:onDeath` (provided by `gfx-lib`) to automatically track kills and deaths. No manual event triggering is required.

---

## Commands

| Command | Side | Access | Description |
|---------|------|--------|-------------|
| `/leaderboard` | Client | All players | Opens/closes the NUI leaderboard scoreboard. Displays rankings, player profile card with K/D ratio, most-used weapons, and pagination. |
| `/saveleaderboard` | Server | Console only | Manually saves all in-memory leaderboard data to the database. Useful before server restarts. |
| `/checkleaderboard` | Server | Console only | Prints debug information about the leaderboard state, including board sizes and all ranked players with their stats. |

---

## Features

- **Real-time kill/death tracking** -- Automatically tracks kills and deaths via `gfx-lib:server:onDeath` event, including weapon identification
- **NUI scoreboard** -- Full-featured browser-based UI with pagination, sorting by kills or deaths, and player profile cards
- **3D podium display** -- Physical in-world platforms with the top 3 players rendered as peds wearing their actual character skins
- **Floating stat text** -- Render-target-based floating text above podium peds showing name, kills, deaths, and K/D ratio
- **Per-weapon statistics** -- Tracks which weapons each player uses most for kills and deaths, displayed on profile cards
- **Player profile photos** -- Fetches player avatars from Steam or Discord for display in the leaderboard
- **Auto-save** -- Periodically saves leaderboard data to the database (configurable interval, default 30 minutes)
- **Save on disconnect** -- Player stats are saved to the database when they leave the server
- **Save on resource stop** -- All data is persisted when the resource stops
- **Auto table creation** -- The database table is created automatically if it does not exist
- **Live rank updates** -- When a player overtakes another in rankings, podium peds are swapped in real-time for all clients
- **Multi-framework support** -- Works with ESX, QBCore, and standalone servers through `gfx-lib`
- **Multiple skin script support** -- Compatible with `qb-clothes`, `esx_skin`, `skinchanger`, `fivem-appearance`, and `illenium-appearance`

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Podium peds not spawning | Verify that the `stream/` folder contains the platform prop files (`gfx_leader_*.ydr`, `gfx_leaderboard.ytyp`). Check that `Config.Peds` entries have `enable = true` and valid coordinates. |
| "Weapon not found" console warning | The weapon hash is not in `Config.WeaponHash`. Add the missing weapon hash and name to the table in `config.lua`. |
| Player photos not loading | Check `Config.PhotoType` and `Config.PicturePlatform`. For Steam photos, ensure `steam_webApiKey` convar is set correctly in `server.cfg`. |
| Skins not applying to podium peds | Verify `Config.SkinScript` matches your installed skin resource name exactly. The skin resource must be started before `gfx-leaderboard`. |
| Leaderboard UI not opening | Ensure NUI files exist in the `html/` folder. Check the F8 console for JavaScript errors. Try restarting the resource. |
| Database errors on startup | Confirm `oxmysql` (or `mysql-async`) is running and properly configured. If using `mysql-async`, uncomment it in `fxmanifest.lua` and comment out `oxmysql`. |
| Stats not saving | Check that `Config.SaveInterval` is set to a reasonable value. Use `/saveleaderboard` from the server console to force a save. Check server console for SQL errors. |
| Floating text not visible | You must be within 15 units of a podium ped and facing it from the correct angle. Ensure `Config._3DTextZoffset` is appropriate for your platform height. |

---

## Source

- **GitHub:** [https://github.com/gfx-fivem/gfx-leaderboard](https://github.com/gfx-fivem/gfx-leaderboard)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
