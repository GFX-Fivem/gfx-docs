# GFX Trade

A player-to-player item trading system with a modern NUI interface. Players can send trade requests, select items from their inventories, and complete secure two-party trades with a mutual accept system.

---

## Info

| Key | Value |
|---|---|
| **Resource Name** | `gfx-trade` |
| **Frameworks** | ESX / QBCore |
| **Lua Version** | 5.4 |
| **Escrow** | Yes (`config.lua`, `client/hook.lua`, `server/hook.lua` are open) |

---

## Dependencies

| Dependency | Required | Purpose |
|---|---|---|
| ESX or QBCore | Yes | Framework for player data and inventory access |
| Inventory system | Yes | One of: `gfx-inventory`, ESX built-in inventory, or QBCore built-in inventory |

### Supported Inventory Systems

The script adapts to your framework and inventory setup through the hook layer in `server/hook.lua`:

- **ESX (default)**: Uses `xPlayer.inventory`, `xPlayer.addInventoryItem()`, `xPlayer.removeInventoryItem()`, `xPlayer.getInventoryItem()`
- **QBCore**: Uses `Player.PlayerData.items`, `Player.Functions.AddItem()`, `Player.Functions.RemoveItem()`, `Player.Functions.GetItemByName()`
- **gfx-inventory**: When `Config.GFXInventory = true`, overrides all item operations with `gfx-inventory` exports (`RemoveItem`, `AddItem`, `GetItemByName`, `GetInventory`)

---

## Installation

1. Extract the `gfx-trade` folder into your server's `resources` directory.
2. Add to your `server.cfg`:
   ```cfg
   ensure gfx-trade
   ```
3. Configure `config.lua` with your framework and inventory settings.
4. Restart your server.

---

## Configuration

### Main Config (`config.lua`)

```lua
Config = {
    IdentifierType = "steam",
    QBCoreName = false,
    ESX = true,
    GFXInventory = true,
    NoImage = "https://cdn.discordapp.com/attachments/.../noimage.png",
    itemImagePath = "https://cfx-nui-gfx-inventory/nui/assets/{name}.png",
    MaxInventoryWeight = 120000,
}

Locales = {
    ["player_not_found"] = "There is not a player which has this id!",
}
```

| Option | Type | Default | Description |
|---|---|---|---|
| `IdentifierType` | string | `"steam"` | Identifier type for fetching profile pictures. Must be `"steam"` for Steam avatar support. |
| `QBCoreName` | string/boolean | `false` | Set to `"qb-core"` if using QBCore. Leave as `false` for ESX. |
| `ESX` | boolean | `true` | Set to `true` if using ESX framework. |
| `GFXInventory` | boolean | `true` | Enable `gfx-inventory` integration for all item operations. |
| `NoImage` | string | URL | Fallback profile picture URL when Steam avatar is unavailable. |
| `itemImagePath` | string | URL pattern | URL template for item images in the trade UI. Use `{name}` as a placeholder for the item name. |
| `MaxInventoryWeight` | number | `120000` | Maximum inventory weight in grams, sent to the trade UI. |

### Locales

| Key | Default | Description |
|---|---|---|
| `player_not_found` | `"There is not a player which has this id!"` | Shown when the target player ID does not exist. |

### Hook Files

The script provides two hook files for customization (included in `escrow_ignore`):

- **`client/hook.lua`**: Contains the `Notify(text)` function for client-side notifications. Default implementation prints to console.
- **`server/hook.lua`**: Contains server-side utility functions: `Notify`, `GetName`, `GetIdent`, `GetPlayer`, `GetInventory`. These handle framework detection, player lookups, and inventory access.

---

## Exports

This script does not create any exports.

---

## Events

This script does not expose any public API events for external scripts. All events are internal to the trade system.

---

## Commands

| Command | Permission | Description |
|---|---|---|
| `/trade [playerID]` | All players | Sends a trade request to the specified player by their server ID. |
| `/tradea` | All players | Accepts an incoming trade request. |
| `/traded` | All players | Declines an incoming trade request. |

### Trade Flow

1. **Player A** types `/trade [ID]` to send a request to **Player B**.
2. **Player B** receives a chat notification and types `/tradea` to accept or `/traded` to decline.
3. If accepted, both players see the trade NUI with their inventories displayed side by side.
4. Each player selects up to **5 items** to offer.
5. Both players click "Ready" to confirm their selections.
6. When both players are ready, the trade executes after a **3-second delay**.
7. Items are swapped between the two players' inventories.
8. Either player can close the trade UI at any time, which cancels the trade for both parties.

---

## Features

- **Secure Two-Party Trading**: Both players must accept the request and confirm selections before items are exchanged.
- **Modern NUI Interface**: SCSS-styled trade interface showing both players' inventories side by side.
- **Steam Profile Pictures**: Fetches and displays Steam avatars for both trade participants via the Steam XML API.
- **Item Selection Limit**: Each player can select up to 5 items per trade to keep trades manageable.
- **Ready System**: Live ready count display (0, 1, or 2). Items are only exchanged when both confirm.
- **Trade Cancellation**: Either player can close the trade at any time, automatically closing it for the other player.
- **Multi-Framework Support**: Works with both ESX and QBCore through a unified hook layer.
- **gfx-inventory Integration**: Native support for `gfx-inventory` with automatic item metadata enrichment (labels, images) in the trade UI.
- **Self-Trade Protection**: Players cannot send trade requests to themselves.
- **Player Tracking**: Tracks online players via `playerJoining`/`playerDropped` events for reliable lookups.

---

## Troubleshooting

**Q: The `/trade` command does nothing or says "player not found".**
A: Ensure you are providing a valid server ID. The target player must be online and loaded into the framework. Verify that `Config.ESX` or `Config.QBCoreName` is set correctly.

**Q: Items are not being transferred after the trade.**
A: Verify your inventory system is compatible. If using `gfx-inventory`, set `Config.GFXInventory = true`. The trade uses `addInventoryItem` / `removeInventoryItem` methods which must be available on the player object.

**Q: Steam profile pictures are not loading.**
A: The script requires `Config.IdentifierType = "steam"` and players must have a Steam identifier. If Steam is unavailable, the `Config.NoImage` fallback URL is used instead.

**Q: The trade UI opens but shows no items.**
A: Check that the inventory function returns the correct format. For ESX it uses `xPlayer.inventory`; for QBCore it uses `Player.PlayerData.items`. If using `gfx-inventory`, ensure the resource is started and exports are accessible.

**Q: How many items can be traded at once?**
A: Each player can select up to 5 items per trade.

**Q: Can I customize the notification system?**
A: Yes. Edit `client/hook.lua` for client-side notifications and `server/hook.lua` for server-side notifications. These files are in `escrow_ignore` and are safe to modify.

**Q: The trade auto-cancels or errors out.**
A: If either player disconnects or closes the UI, the trade is cancelled for both parties. Check the server console for error messages related to inventory operations.
