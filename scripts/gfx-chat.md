# GFX Chat

A custom FiveM chat replacement with NUI interface, featuring multiple chat visibility modes, admin moderation tools (kick/mute from chat), word filtering, spam protection, auto-announcements, and Discord logging.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-chat` |
| **Frameworks** | QBCore / ESX (via `gfx-base` Utils) |
| **Escrow** | Yes (only `config.lua` is open) |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `gfx-base` | Yes | Provides `Utils` API (GetPlayer, IsMod, IsAdmin, callbacks, etc.) |
| `gfx-logs` | No | Optional; used for Discord logging when `Config.DiscordLog` is enabled |

## Installation

### 1. Copy Files
Place the `gfx-chat` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-base
ensure gfx-chat
```

Make sure `gfx-base` starts before `gfx-chat`.

### 3. Remove Default Chat
If you have the default FiveM `chat` resource running, remove or disable it to avoid conflicts:
```cfg
# ensure chat  <-- comment out or remove
```

## Configuration

All configuration is done in `config.lua` (server-side).

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.AutoAnnounce` | `table[]` | See below | List of automatic announcement messages with interval settings |
| `Config.AutoAnnounce[].text` | `string` | — | The announcement message text to broadcast |
| `Config.AutoAnnounce[].minutes` | `number` | — | Interval in minutes between each broadcast of this message |
| `Config.WordFilter` | `string[]` | `{"fword"}` | List of words/patterns to block from chat. Uses Lua pattern matching |
| `Config.DiscordLog` | `boolean` | `true` | Enable or disable Discord logging of chat messages via `gfx-logs` |

### Default AutoAnnounce Example
```lua
Config.AutoAnnounce = {
    {
        text = "discord.gg/54zPNKpHdc",
        minutes = 5
    },
    {
        text = "gfx.tebex.io",
        minutes = 5
    },
}
```

## Exports

This script does not create any exports.

## Events

### Client Events

#### `gfx-chat:addMessage`
Displays a message in the chat UI for a specific player or all players. Triggered from the server side.

| Parameter | Type | Description |
|-----------|------|-------------|
| `msg` | `table` | Message data object |
| `msg.message` | `string` | The message text to display |
| `msg.type` | `string` | Message type: `"message"`, `"alert"`, or `"notify"` |
| `msg.src` | `number` | (For type `"message"`) The sender's server ID |
| `msg.name` | `string` | (For type `"message"`) The sender's player name |
| `msg.admin` | `boolean` | (For type `"message"`) Whether the sender is an admin/mod (enables animated name color) |

```lua
-- Server-side: Send an alert to all players
TriggerClientEvent("gfx-chat:addMessage", -1, {
    message = "Server restart in 5 minutes!",
    type = "alert"
})

-- Server-side: Send a notification to a specific player
TriggerClientEvent("gfx-chat:addMessage", targetSource, {
    message = "You have been warned.",
    type = "notify"
})
```

#### `gfx-chat:clear`
Clears the chat history for a specific player or all players.

No parameters.

```lua
-- Server-side: Clear chat for all players
TriggerClientEvent("gfx-chat:clear", -1)

-- Client-side: Clear your own chat
TriggerEvent("gfx-chat:clear")
```

## Commands

| Command | Permission | Description |
|---------|------------|-------------|
| `/openchat` | Everyone | Opens the chat input. Bound to `T` by default (remappable in FiveM keybind settings) |
| `/changechatmode` | Everyone | Cycles chat visibility mode: `ON_INPUT` -> `VISIBLE` -> `CLOSED`. Bound to `L` by default |
| `/clear` | Everyone | Clears the local player's chat history |
| `/announce <message>` | Admin | Broadcasts an alert-type announcement message to all players |
| `/mute <id> <minutes>` | Mod | Mutes a player for the specified duration in minutes |
| `/unmute <id>` | Mod | Unmutes a previously muted player |
| `/clearall` | Mod | Clears the chat history for all connected players |

## Features

- **Custom NUI Chat Interface** -- Fully replaces the default FiveM chat with a styled HTML/CSS/JS interface
- **Chat Visibility Modes** -- Three modes toggled with `L` key: input-only (appears when typing), always visible, or closed
- **Admin Moderation Panel** -- Admins can toggle mouse mode (F1) to reveal kick/mute buttons next to each message
- **Kick from Chat** -- Admins can double-click the kick button on a message to instantly kick that player
- **Mute from Chat** -- Admins can double-click the mute button to open a time selection popup and mute a player
- **Mute/Unmute Commands** -- Moderators can mute or unmute players via `/mute` and `/unmute` commands
- **Server Announcements** -- Admins can send server-wide alert messages using `/announce`
- **Auto-Announcements** -- Configurable automatic messages broadcast at set intervals (e.g., Discord link, store link)
- **Word Filter** -- Configurable list of blocked words/patterns; messages containing filtered words are silently dropped
- **Spam Protection** -- Players cannot send messages faster than one per second
- **Message Length Limit** -- Messages exceeding 120 characters are rejected
- **HTML Injection Prevention** -- Chat messages containing HTML tags are blocked on the client side
- **Command Suggestions** -- Typing `/` shows autocomplete suggestions for registered commands the player has access to
- **Input History** -- Arrow up/down keys cycle through previously sent messages
- **Emoji Picker** -- Built-in emoji selector accessible from the chat input
- **Admin Name Animation** -- Admin/mod names display with an animated color gradient effect
- **Discord Logging** -- All chat messages and commands can be logged to Discord via `gfx-logs` integration
- **Chat Clear Commands** -- `/clear` for local and `/clearall` for server-wide chat clearing

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Chat does not appear when pressing T | Make sure the default `chat` resource is stopped. Check that `gfx-chat` is started after `gfx-base` in your `server.cfg` |
| Commands not showing in suggestions | Commands only appear if the player has ACE permission for them. Verify ACE permissions in your `server.cfg` |
| Auto-announcements not working | Check that `Config.AutoAnnounce` entries have valid `text` and `minutes` values in `config.lua` |
| Discord logging not working | Ensure `Config.DiscordLog` is set to `true` and the `gfx-logs` resource is started and properly configured |
| Word filter not catching messages | `Config.WordFilter` uses Lua pattern matching. Make sure your patterns are correct (e.g., special characters need `%` escaping) |
| Admin buttons not visible | Press `F1` to enable mouse mode while chat is open. Admin status is determined by `gfx-base` Utils.IsMod |
| Muted player can still see others' messages | Muting only prevents sending messages; muted players can still read chat. This is intended behavior |
