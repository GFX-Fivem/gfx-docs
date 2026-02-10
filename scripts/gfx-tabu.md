# gfx-tabu

## Info

| Key | Value |
|-----|-------|
| **Name** | gfx-tabu |
| **Type** | Minigame |
| **FX Version** | cerulean |
| **Game** | GTA5 |
| **Frameworks** | ESX, QBCore (old and new versions) |
| **Description** | In-game Taboo word guessing party game. Players create or join lobbies, split into two teams, and take turns describing words without using forbidden (taboo) words. The first team to reach the win point threshold receives rewards. |

---

## Dependencies

| Dependency | Required | Notes |
|------------|----------|-------|
| **ESX** or **QBCore** | Yes | One framework must be active. Supports `esx`, `oldesx`, `qbcore`, `oldqbcore`. |
| **qb-inventory** | Conditional | Required only when using QBCore framework and item rewards are configured. |
| **steam_webApiKey** | Conditional | Server convar required if using Steam profile pictures (`showDiscordPP = false`). |
| **Discord Bot Token** | Conditional | Required only if `showDiscordPP = true` in config. |
| **Node modules** | Yes | `discord-id` and `steamapi` npm packages. Run `npm install` in the resource folder. |

---

## Installation

### 1. Copy the resource
Place the `gfx-tabu` folder into your server's resources directory.

### 2. Install Node dependencies
```bash
cd resources/gfx-tabu
npm install
```

### 3. Add to server.cfg
```cfg
ensure gfx-tabu
```

### 4. Configure framework
Edit `config.lua` and set `Config.Framework` to match your framework (`esx`, `oldesx`, `qbcore`, or `oldqbcore`).

### 5. (Optional) Profile pictures
- **Steam avatars (default):** Set the `steam_webApiKey` convar in your server.cfg.
- **Discord avatars:** Set `showDiscordPP = true` and provide a valid Discord bot token in `svconfig.lua`.

---

## Configuration

### config.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `JoinDistance` | number | `10` | Maximum distance (in game units) from the lobby creator to join a lobby. |
| `Timer` | number | `5` | Turn duration in seconds for each narrator. |
| `WinPoint` | number | `300` | Point threshold a team must exceed to win. |
| `Rewards.money` | number | `1000` | Cash reward given to each member of the winning team. |
| `Rewards.items` | table | `{}` | Item rewards for the winning team. Each entry: `{name = "item_name", count = amount}`. |
| `Framework` | string | `"qbcore"` | Framework to use: `"esx"`, `"oldesx"`, `"qbcore"`, or `"oldqbcore"`. |
| `discordToken` | string | `""` | Discord bot token (client-side config, only used if `showDiscordPP` is true). |
| `showDiscordPP` | boolean | `false` | `true` = use Discord profile pictures, `false` = use Steam profile pictures. |

### Config.Locales

| Key | Default Text |
|-----|-------------|
| `not_enough_player` | "There is not enough players to start the game." |
| `no_lobbies` | "No lobbies in close range." |
| `lobby_owner_cant` | "Lobby owner can't do this." |

### Config.Words

An array of word entries. Each entry defines a word to guess, its point value, and a list of taboo (forbidden) words.

```lua
{
    word = "Water",     -- The word to be guessed
    point = 100,        -- Points awarded for a correct guess (or deducted for taboo violation)
    taboo = {           -- Words the narrator cannot say
        "Drink",
        "Thirst",
        "Ocean",
        "Sea",
    }
}
```

Default words included: Water, Car, House, Dog, Cat, Tree, Phone, Computer, Table, Chair, Bed, Door, Window.

### svconfig.lua

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `discordToken` | string | `""` | Discord bot token (server-side). Required if `showDiscordPP` is enabled. |
| `showDiscordPP` | boolean | `false` | Mirrors the client config setting for server-side avatar fetching. |

---

## Exports

### Server Exports

#### GetConfig
Returns the full `Config` table.

```lua
local config = exports['gfx-tabu']:GetConfig()
```

**Returns:** `table` -- The Config table containing all settings, locales, and words.

---

#### GetIdentifier
Returns a specific identifier for a player (e.g., `steam`, `discord`, `license`).

```lua
local identifier = exports['gfx-tabu']:GetIdentifier(source, type)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | The player's server ID. |
| `type` | string | The identifier type to search for (e.g., `"steam"`, `"discord"`, `"license"`). |

**Returns:** `string` or `nil` -- The matching identifier string, or nil if not found.

---

#### GrabDiscordPP
Fetches a player's Discord profile picture URL. Defined in `sv_discord.js`.

```lua
local avatarUrl = exports['gfx-tabu']:GrabDiscordPP(source)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | The player's server ID. |

**Returns:** `string` or `nil` -- The Discord avatar URL, or nil if unavailable.

---

#### GrabSteamPP
Fetches a player's Steam profile picture URL (large size). Defined in `sv_discord.js`.

```lua
local avatarUrl = exports['gfx-tabu']:GrabSteamPP(source)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `source` | number | The player's server ID. |

**Returns:** `string` or `nil` -- The Steam avatar URL, or nil if unavailable.

---

## Events

No public API events. All events in this script are internal (used for client-server communication within the resource).

---

## Commands

| Command | Description |
|---------|-------------|
| `/createtabu` | Creates a new Taboo game lobby at the player's current location. The creator becomes the first member of Team A and the initial narrator. |
| `/jointabu` | Joins an existing nearby lobby (must be within `JoinDistance` of the lobby creator). Players are auto-assigned to the team with fewer members (max 4 per team). |
| `/opentabu` | Toggles the Taboo game UI (NUI panel) open or closed. Only works when the player is in a lobby. |

---

## Features

- **Team-based word guessing game** -- Two teams (Team A and Team B) compete to reach the win point threshold first.
- **Lobby system** -- Players create or join lobbies based on proximity. Auto-balances teams on join.
- **Turn rotation** -- Narrators alternate between teams. Within each team, members take turns as the narrator.
- **Pass mechanic** -- Each player gets 3 passes per game to skip difficult words.
- **Taboo violation** -- If the narrator uses a forbidden word, points are deducted from their team.
- **Timed rounds** -- Each narrator has a configurable time limit per turn.
- **Configurable rewards** -- Winning team members receive money and/or items.
- **Profile pictures** -- Supports both Steam and Discord avatars in the UI.
- **Multi-framework support** -- Works with ESX, QBCore, and their legacy versions.
- **NUI-based interface** -- Full web-based UI for the game board, teams, and scoring.
- **Customizable word list** -- Add, remove, or modify words and their taboo terms in `config.lua`.
- **Localization support** -- Notification messages are configurable via `Config.Locales`.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "There is not enough players to start the game" | Both teams must have at least 2 members before the game can start. |
| "No lobbies in close range" | Move closer to a lobby creator. The join distance is set by `Config.JoinDistance` (default: 10 units). |
| "Lobby owner can't do this" | The lobby creator cannot switch teams. Only non-owner members can switch. |
| Steam profile pictures not loading | Ensure the `steam_webApiKey` convar is set in your `server.cfg`. |
| Discord profile pictures not loading | Set `showDiscordPP = true` in both `config.lua` and `svconfig.lua`, and provide a valid Discord bot token. |
| Node module errors on startup | Run `npm install` inside the `gfx-tabu` resource folder to install `discord-id` and `steamapi` packages. |
| Players not receiving rewards | Check that `Config.Framework` matches your active framework. For item rewards, ensure `Config.Rewards.items` entries have valid item names registered in your inventory system. |
| UI not appearing | Make sure the player is in a lobby (use `/createtabu` or `/jointabu` first), then use `/opentabu` to toggle. |
