# gfx-giveaway

In-game giveaway system with a full NUI interface. Admins create giveaways with configurable reward types, entry fees, time limits, participant caps, and winner counts. Players join through the UI, and winners are randomly selected and rewarded automatically when the timer ends.

---

## Info

| Key | Value |
|-----|-------|
| **Author** | atiysu |
| **FX Version** | cerulean |
| **Lua 5.4** | Yes |
| **UI** | Yes (NUI) |
| **Framework** | ESX / QBCore |
| **MySQL** | oxmysql / mysql-async / ghmattimysql |

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| **es_extended** or **qb-core** | Framework core (player data, money, inventory) |
| **oxmysql** / **mysql-async** / **ghmattimysql** | Database queries (vehicle reward plate generation) |

---

## Installation

1. Place the `gfx-giveaway` folder in your server's resources directory.
2. Add your Discord identifier to the `Config.Admins` table in `config.lua`.
3. Set the correct `Config.Framework` (`"esx"` or `"qb"`) and `Config.MySQL` in `config.lua`.
4. Add to your `server.cfg`:

```cfg
ensure gfx-giveaway
```

---

## Configuration

**File:** `config.lua`

```lua
Config = {
    Framework = "esx",       -- "esx" or "qb"
    MySQL = "oxmysql",       -- "oxmysql" / "mysql-async" / "ghmattimysql"

    Admins = {
        "discord:1175718817083695199",  -- Discord identifiers with admin access
    },

    Notify = function(msg, title, type)
        -- Notification function, uses framework default notifications
    end,
}
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Framework` | `string` | `"esx"` | Framework to use. Accepts `"esx"` or `"qb"`. |
| `MySQL` | `string` | `"oxmysql"` | MySQL resource name. Accepts `"oxmysql"`, `"mysql-async"`, or `"ghmattimysql"`. |
| `Admins` | `table` | `{}` | List of Discord identifiers (`"discord:XXXX"`) allowed to create giveaways. |
| `Notify` | `function` | Framework default | Notification function called on the client side. Receives `msg`, `title`, and `type` parameters. |

### Reward Configuration

**File:** `rewards.lua`

Rewards are configured when creating the giveaway through the UI. Three reward types are supported:

| Type ID | Reward | Fields Used |
|---------|--------|-------------|
| `1` | Cash | `amount` -- Cash amount given to the winner |
| `2` | Item | `item` (item name), `amount` (quantity) |
| `3` | Vehicle | `item` (vehicle spawn name) -- Vehicle is added to the winner's garage |

---

## Exports

*No exports. This script does not register any exports for external use.*

---

## Events

*No public API events. All events are internal between this script's client and server.*

---

## Commands

| Command | Access | Description |
|---------|--------|-------------|
| `/giveaway` | Admin only | Opens the giveaway creation UI. Only available when no giveaway is currently active. Requires the player's Discord identifier to be listed in `Config.Admins`. |

---

## Features

- **NUI-based giveaway interface** -- Full web UI for creating giveaways and displaying the active giveaway to all players.
- **Admin-only creation** -- Only players whose Discord identifier is in the `Config.Admins` list can start giveaways.
- **Three reward types** -- Cash, items, or vehicles. Vehicle rewards are automatically added to the winner's garage with a unique plate.
- **Entry fee support** -- Giveaways can require a cash entry fee. Money is deducted when a player joins.
- **Participant cap** -- Maximum number of participants can be set per giveaway.
- **Multiple winners** -- Configurable number of winners. If fewer entries than winner slots, all participants can win.
- **Countdown timer** -- Server-side timer broadcasts remaining time to all clients every second.
- **Late join support** -- Players who load in while a giveaway is active will see the ongoing giveaway UI.
- **Disconnect handling** -- If a participant disconnects, they are automatically removed from the entry list.
- **Duplicate entry prevention** -- Players cannot join the same giveaway twice.
- **Multi-framework support** -- Works with both ESX and QBCore.
- **Multi-MySQL support** -- Compatible with oxmysql, mysql-async, and ghmattimysql.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `/giveaway` command does nothing | Verify your Discord identifier is in `Config.Admins`. Format must be `"discord:YOURID"`. Also check that no giveaway is currently active. |
| Player cannot join giveaway | Ensure the player has enough cash for the entry fee. Check that the participant cap has not been reached. |
| Vehicle reward not appearing in garage | Verify the vehicle spawn name is correct and that the database table matches your framework (`player_vehicles` for QBCore, `owned_vehicles` for ESX). |
| Winners not receiving rewards | The winner must be online when the timer ends. Disconnected players are removed from entries and cannot win. |
| NUI not opening | Check browser console (F8) for UI errors. Ensure the `ui/` folder is present with all files (index.html, js/, css/, img/). |
| Notifications not showing | Verify `Config.Framework` matches your actual framework. Customize `Config.Notify` if using a custom notification resource. |

---

## Source

- **GitHub:** [https://github.com/gfx-fivem/gfx-giveaway](https://github.com/gfx-fivem/gfx-giveaway)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
