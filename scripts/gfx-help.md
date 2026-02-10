# GFX Help

An in-game help and support ticket system for FiveM with a NUI interface. Players can browse categorized FAQ sections, search for answers, and create live support tickets that staff members can respond to in real time. Includes Steam profile picture integration and optional Discord logging.

## Info

| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-help` |
| **Frameworks** | Standalone (no framework required) |
| **Escrow** | Yes (only `config.lua` is open) |

## Dependencies

| Resource | Required | Notes |
|----------|----------|-------|
| `gfx-logs` | No | Optional; used for Discord logging of ticket messages when `Config.DiscordLog` is enabled |

## Installation

### 1. Copy Files
Place the `gfx-help` folder into your server's resources directory.

### 2. server.cfg
```cfg
ensure gfx-help
```

### 3. Configure FAQ Content
Edit the `nui/help.json` file to customize FAQ categories and questions/answers for your server.

### 4. Configure Staff Access
Add staff Steam identifiers to `Config.allowedToResponseTicket` in `config.lua` so they can view and respond to all tickets.

## Configuration

All configuration is done in `config.lua` (server-side).

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.MenuCommand` | `string` | `"help"` | The command players use to open the help menu |
| `Config.allowedToResponseTicket` | `table` | See below | Table of Steam identifiers allowed to view and respond to all support tickets (staff members) |
| `Config.DiscordLog` | `boolean` | `false` | Enable or disable Discord logging of ticket messages via `gfx-logs` |
| `Config.ServerName` | `string` | `"GFX"` | Server name displayed in the help UI and ticket responses |
| `Config.ServerLogo` | `string` | URL | Server logo image URL displayed in ticket responses |
| `Config.NoImage` | `string` | URL | Fallback image URL used when a player's Steam profile picture cannot be retrieved |

### Staff Permissions Example
```lua
Config.allowedToResponseTicket = {
    ["steam:110000109a07edc"] = true,
    ["steam:110000112345678"] = true,
}
```

### FAQ Content (nui/help.json)
The FAQ is defined in `nui/help.json` with categories. Each category has a label, icon, and an array of question/answer pairs:

```json
{
    "faq": {
        "menuData": {
            "label": "F.A.Q.",
            "icon": "img/faq-icon.png"
        },
        "qna": [
            {
                "q": "How can I craft an item?",
                "a": "You need to find a workbench for this"
            }
        ]
    }
}
```

The `ticket` category is special and handles the live support ticket system. Other categories (e.g., `faq`, `tab`, `lspd`, `LSMS`, `items`) are purely informational Q&A sections.

## Exports

This script does not create any exports.

## Events

This script does not expose any public API events for external use. All events are internal client-server communication within the resource.

## Commands

| Command | Permission | Description |
|---------|------------|-------------|
| `/{MenuCommand}` (default: `/help`) | Everyone | Opens the help and support ticket menu |

## Features

- **NUI Help Interface** -- Full-screen styled NUI menu with categorized FAQ sections and a live ticket system
- **Categorized FAQ** -- Multiple customizable categories (FAQ, Inventory, LSPD, LSMS, Items, etc.), each with its own icon, label, and question/answer pairs
- **Search Functionality** -- Global search bar that filters questions and answers across all categories in real time
- **Live Support Tickets** -- Players can create a support ticket and chat with staff in real time through the help menu
- **Staff Ticket Management** -- Staff members (configured by Steam identifier) can see all open tickets, respond to players, and close tickets
- **One Ticket Per Player** -- Players are limited to one open ticket at a time to prevent spam
- **Ticket Close by Double-Click** -- Both ticket owners and staff can close tickets by double-clicking the close button
- **Steam Profile Pictures** -- Player avatars are fetched from Steam's XML API and displayed in ticket conversations
- **Server Branding** -- Configurable server name and logo shown in the UI and staff responses
- **Discord Logging** -- Optional integration with `gfx-logs` to log all ticket messages to Discord
- **ESC to Close** -- Press Escape to close the help menu at any time
- **Message Cooldown** -- 500ms cooldown between ticket messages to prevent spam
- **Chat-Style Ticket UI** -- Ticket conversations are displayed in a chat bubble format with sender identification

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Help menu does not open | Verify the command name in `Config.MenuCommand` matches what you are typing. Ensure the resource is started in `server.cfg` |
| Staff cannot see tickets | Make sure the staff member's Steam identifier is added to `Config.allowedToResponseTicket` in `config.lua`. The identifier must be in the format `steam:XXXXXXXXXXXXXXX` |
| Player profile picture not showing | The player must be connected via Steam. Non-Steam players will see the fallback image defined in `Config.NoImage` |
| FAQ categories are empty or wrong | Edit `nui/help.json` to customize categories and Q&A content. Restart the resource after changes |
| Discord logging not working | Set `Config.DiscordLog` to `true` in `config.lua` and ensure the `gfx-logs` resource is started and properly configured |
| Ticket messages not sending | Ensure you have an open ticket. Staff members cannot create tickets, they can only respond to existing ones |
| Cannot close a ticket | Double-click the close button. A single click will not close the ticket |
