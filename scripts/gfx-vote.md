# gfx-vote

In-game voting/poll system with NUI interface. Admins create polls with custom questions and options, players vote through a UI panel, and results are automatically posted to Discord via webhook when the poll ends.

---

## Info

| Key | Value |
|---|---|
| **Version** | 1.0.0 |
| **Framework** | QBCore / ESX |
| **Side** | Client + Server |
| **UI** | NUI (HTML/CSS/JS) |
| **Escrow** | Supported (config files excluded) |

---

## Dependencies

- QBCore (`qb-core`) **or** ESX (`es_extended`)

---

## Installation

### 1. Copy Files
Place the `gfx-vote` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-vote
```

### 3. Configure
Edit `config.lua` to set your framework, commands, allowed jobs, and admin identifiers. Edit `serverconfig.lua` to set your Discord webhook URL.

---

## Configuration

### config.lua (shared)

```lua
Config = {
    Framework = "qbcore",          -- "qbcore" or "esx"
    VoteCommand = "vote",          -- Command to open the voting panel
    CreateCommand = "createvote",  -- Command to open the poll creation panel (admin only)
    Jobs = {                       -- Target audiences available when creating a poll
        {value = "all", label = "All"},
        {value = "police", label = "Police"},
        {value = "ambulance", label = "Ambulance"},
    },
    Admins = {                     -- Identifier-based admin whitelist (fallback if framework check is not used)
        ["identifier"] = true
    }
}
```

| Option | Type | Description |
|---|---|---|
| `Framework` | `string` | Framework to use: `"qbcore"` or `"esx"` |
| `VoteCommand` | `string` | Chat command for players to open the vote panel |
| `CreateCommand` | `string` | Chat command for admins to create a new poll |
| `Jobs` | `table` | List of job/community options shown in poll creation. `"all"` targets all players |
| `Admins` | `table` | Map of player identifiers to `true` for admin access (used as fallback) |

### Locales (config.lua)

```lua
Locales = {
    ["already_voting"]  = "There is already a vote in progress.",
    ["discord_text"]    = "Best Option: %s with %s vote\nTotal Vote Used: %s",
    ["creator"]         = "Poll creator: %s",
    ["no_active_poll"]  = "No polls active!",
    ["results"]         = "Poll Results",
    ["stats"]           = "Poll Stats",
    ["votecreated"]     = "New vote created! /vote",
}
```

### serverconfig.lua (server only)

```lua
SVConfig = {
    Webhook = "https://discord.com/api/webhooks/...",  -- Discord webhook URL for results
    WebhookName = "GFX Poll",                          -- Webhook display name
    WebhookImage = "https://...",                       -- Webhook avatar image URL
    WebhookColor = 15548997                             -- Embed color (decimal)
}
```

| Option | Type | Description |
|---|---|---|
| `Webhook` | `string` | Discord webhook URL where poll results are posted |
| `WebhookName` | `string` | Display name for the webhook bot |
| `WebhookImage` | `string` | Avatar image URL for the webhook bot |
| `WebhookColor` | `number` | Embed sidebar color in decimal format |

---

## Exports

*No exports are registered by this script.*

---

## Events

*No public API events for external scripts. All events are internal (client-server communication within the resource).*

---

## Commands

| Command | Default | Permission | Description |
|---|---|---|---|
| Vote command | `/vote` | Everyone | Opens the voting panel to cast a vote on the active poll |
| Create command | `/createvote` | Admin only | Opens the poll creation panel (question, options, target audience, duration) |

Both command names are configurable via `Config.VoteCommand` and `Config.CreateCommand`.

---

## Features

- **Admin poll creation** -- Admins create polls with a custom question, multiple options, target audience (all players or specific job), and a time limit
- **NUI voting interface** -- Clean browser-based UI for both creating polls and casting votes
- **Job/community targeting** -- Polls can be sent to all players or restricted to a specific job group
- **Duplicate vote prevention** -- Each player can only vote once per poll (tracked by identifier)
- **Automatic poll expiration** -- Polls automatically end after the configured duration
- **Discord webhook results** -- When a poll ends, results with percentages, best option, and total votes are posted to Discord
- **Multi-framework support** -- Works with both QBCore and ESX
- **Configurable locales** -- All user-facing strings are customizable

---

## Troubleshooting

| Problem | Solution |
|---|---|
| `/vote` says "No polls active!" | No poll is currently running. An admin needs to create one with `/createvote` first |
| `/createvote` does nothing | Ensure you have admin permissions. For QBCore the check is always `true` by default; for ESX you need the `admin` group; otherwise your identifier must be in `Config.Admins` |
| Poll results not appearing on Discord | Verify the webhook URL in `serverconfig.lua` is correct and the webhook has not been deleted |
| Players from a specific job cannot see the poll | Make sure the job name in `Config.Jobs` matches the exact job name in your framework |
| NUI panel does not open | Check the browser console (F8) for errors. Ensure the `nui/` folder and all its files are present |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-vote
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
