# gfx-truthordare

## Info

| Key | Value |
|-----|-------|
| **Name** | gfx-truthordare |
| **Type** | Minigame / Social |
| **FX Version** | cerulean |
| **Lua Version** | 5.4 |
| **Game** | GTA5 |
| **Escrow Ignore** | `config.lua` |

A lobby-based **Truth or Dare** minigame for FiveM. Players create or join lobbies, spin a randomizer to pick a questioner and answerer, choose truth or dare, and select a question category. The game runs through a full NUI interface with Discord avatar integration for player profiles.

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| **qb-core** or **es_extended** | Framework for retrieving player RP names (configured via `Config.Framework`) |
| **Discord Bot Token** | Used server-side to fetch player avatars from the Discord API (`Config.BotToken`) |

---

## Installation

### 1. Copy Files
Place the `gfx-truthordare` folder into your server's resources directory.

### 2. Configure
Edit `config.lua`:
- Set `Config.Framework` to `"qb"` (QBCore) or `"esx"` (ESX).
- Set `Config.BotToken` to a valid Discord bot token for avatar fetching.
- Customize the question categories and questions in `Config.Questions`.

### 3. server.cfg
```cfg
ensure gfx-truthordare
```

---

## Configuration

Configuration is done in `config.lua`.

### Config.Framework
- **Type:** `string`
- **Values:** `"qb"` | `"esx"`
- **Description:** Determines which framework is used to retrieve player character names.

### Config.BotToken
- **Type:** `string`
- **Description:** A Discord bot token used server-side to fetch player avatars via the Discord API. Required for avatar display in the UI.

### Config.Questions
- **Type:** `table` (array)
- **Description:** An array of question categories. Each category contains truth and dare questions that are randomly selected during gameplay.

**Category structure:**
```lua
{
    icon = "vector111.png",        -- Icon filename displayed in the UI
    title = "SOFT MODE",           -- Category display name
    description = "...",           -- Category description shown in UI

    truthQuestions = {             -- Array of truth questions
        "Question text here",
        "Another question",
    },

    dareQuestions = {              -- Array of dare questions
        "Dare text here",
        "Another dare",
    }
}
```

**Default categories:** SOFT MODE, LUKEWARM, HOT, EXTRA HOT (4 difficulty tiers).

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events are exposed by this script.* All events are internal between the client and server within the resource.

---

## Commands

| Command | Arguments | Description |
|---------|-----------|-------------|
| `/createtd` | None | Creates a new Truth or Dare lobby. The player becomes the lobby owner. Opens the NUI interface. |
| `/jointd` | `[lobbyId]` (number) | Joins an existing lobby by its numeric ID. Opens the NUI interface. |

---

## Features

- **Lobby System** -- Players create or join lobbies. The lobby owner controls the game flow (start, reset). When the owner leaves, the entire lobby is disbanded. Non-owner players can leave individually.
- **NUI Interface** -- Full HTML/JS/CSS interface for the game. Players interact entirely through the UI once a lobby is open.
- **Multi-Stage Game Flow** -- The game progresses through 5 stages:
  - **Stage 0:** Lobby / waiting for players
  - **Stage 1:** Spin / randomizer selects a questioner and answerer from the lobby
  - **Stage 2:** The answerer picks **Truth** or **Dare**
  - **Stage 3:** The questioner selects a question category (difficulty tier)
  - **Stage 4:** A random question from the chosen category is displayed; owner can reset to play again
- **Discord Avatar Integration** -- Player avatars are fetched from Discord via the bot API using the player's linked Discord identifier. Supports animated (GIF) avatars.
- **RP Name Display** -- Player names shown in the lobby use in-character first and last names from the framework (QBCore charinfo or ESX getName).
- **Question Categories** -- Four default difficulty tiers (Soft Mode, Lukewarm, Hot, Extra Hot), each with separate truth and dare question pools. Fully customizable in config.
- **Random Selection** -- Both player pairing and question selection use Fisher-Yates shuffle / random pick for fairness.
- **Player Drop Handling** -- Players are automatically removed from their lobby when they disconnect from the server.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| UI does not open | Ensure the `ui/` folder is present with `index.html` and all assets. Check F8 console for NUI errors. |
| Player avatars not loading | Verify `Config.BotToken` is a valid Discord bot token. The bot must be in a server or have access to fetch user info. Check server console for HTTP errors. |
| `/jointd` does nothing | Make sure you provide a valid lobby ID number, e.g., `/jointd 1`. The lobby must exist and you must not already be in a lobby. |
| Player names show incorrectly | Confirm `Config.Framework` matches your server framework (`"qb"` or `"esx"`). |
| Game won't start | The lobby owner must press start, and there must be at least 2 players in the lobby. |
| Questions not appearing | Ensure `Config.Questions` has properly structured categories with non-empty `truthQuestions` and `dareQuestions` arrays. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-truthordare
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
