# GFX Banking
Advanced multi-account banking system with NUI interface, ATM integration, account-to-account transfers, and transaction history tracking.

## Info
| Key | Value |
|-----|-------|
| **Resource Name** | `gfx-banking` |
| **Frameworks** | QBCore |
| **Escrow** | Yes |

## Dependencies
| Resource | Required | Notes |
|----------|----------|-------|
| `qb-core` | Yes | Core framework, player data, callbacks, DrawText UI |
| `oxmysql` | Yes | Database queries for account generation, transfers, and migration |
| `qb-target` | Yes | ATM interaction targeting |

## Installation

### 1. Copy the resource
Place the `gfx-banking` folder into your server's resources directory.

### 2. Database
This script stores bank accounts and transaction history inside the existing QBCore `players` table (`money` and `metadata` columns). No additional SQL file is needed.

### 3. Migrate existing bank balances
If your server already has players with standard QBCore single-account bank balances, run the following command **from the server console** (source 0) to migrate them to the multi-account format:

```
transfertonewbank
```

This creates a new account ID for each player and moves their existing bank balance into it.

### 4. server.cfg
```cfg
ensure oxmysql
ensure qb-core
ensure qb-target
ensure gfx-banking
```

## Configuration
| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `MaxTransactionHistoryCount` | number | `20` | Maximum number of transactions stored per account before the oldest are removed |
| `MaxAccountCount` | number | `3` | Maximum number of bank accounts a player can own |
| `InteractKey` | number | `46` (E) | Control key ID used to interact with the bank NPC |
| `NoImage` | string | `"assets/whois-icon.png"` | Fallback image when a player's profile picture is unavailable |
| `NewAcount.NPC.model` | hash | `` `ig_bankman` `` | Ped model spawned at bank locations for creating new accounts |
| `NewAcount.NPC.coords` | table | `vector4(247.17, 225.35, 106.29, 152.46)` | Coordinates (vector4) where bank NPCs are spawned |
| `NewAcount.textData.display` | boolean | `true` | Enable/disable the proximity draw text system entirely |
| `NewAcount.textData.uiText` | boolean | `true` | Use QBCore DrawText UI instead of 3D world text |
| `NewAcount.textData.farDistance` | number | `7.5` | Distance at which the far text becomes visible |
| `NewAcount.textData.closeDistance` | number | `6.0` | Distance at which the close/interaction text appears and interaction is allowed |
| `NewAcount.textData.farText` | string | `"Create New Bank Account ($5000)"` | Text shown when player is within far distance |
| `NewAcount.textData.closeText` | string | `"E - Create New Bank Account ($5000)"` | Text shown when player is within close/interaction distance |
| `NewAcount.price` | number | `5000` | Cash cost to create a new bank account |
| `ATMModels` | table | `prop_atm_01`, `prop_atm_02`, `prop_atm_03`, `prop_fleeca_atm` | Prop models registered as ATM targets via qb-target |
| `Locales` | table | *(see config.lua)* | Notification messages for account creation, deposits, withdrawals, and transfers |

## Exports
This script does not create any exports.

## Events

### `gfx-banking:Open` (Client)
Opens the banking NUI for the player. Used by qb-target on ATM models and can be triggered from other scripts.

| Parameter | Type | Description |
|-----------|------|-------------|
| `data` | table or nil | Optional. If `nil`, the UI populates from the player's current data automatically. |

```lua
-- Open the banking UI for a player from another client script
TriggerEvent('gfx-banking:Open')
```

### `gfx-banking:client:Update` (Client)
Sent from the server to update the banking NUI after a transaction (deposit, withdraw, transfer, or account switch). Other scripts can trigger this to refresh the banking UI.

| Parameter | Type | Description |
|-----------|------|-------------|
| `data.transactions` | table | Updated transaction history for the current account |
| `data.accounts` | table or nil | Updated list of player accounts (optional) |
| `data.bool` | boolean or nil | If `true`, resets the selected account in the UI |

```lua
-- Server-side: force-refresh a player's banking UI
TriggerClientEvent('gfx-banking:client:Update', targetSource, {
    transactions = transactionTable,
    accounts = accountsTable,
    bool = true
})
```

## Commands
| Command | Permission | Description |
|---------|------------|-------------|
| `openbank` | None | Opens the banking NUI (client-side command) |
| `transfertonewbank` | Server console only | Migrates all existing player bank balances to the multi-account format. **Run once during initial setup.** |

## Features
- **Multi-account banking** -- Players can own up to a configurable number of separate bank accounts, each with its own balance and transaction history.
- **NUI interface** -- Full HTML/JS banking interface with account switching, deposit, withdraw, and transfer views.
- **ATM integration** -- All standard ATM prop models are registered via qb-target for quick access to banking.
- **Bank NPC** -- Configurable NPC ped at bank locations allows players to create new accounts for a cash fee.
- **Account-to-account transfers** -- Players can search for other accounts by ID and transfer money, even to offline players.
- **Transaction history** -- Each account tracks its own transaction log (deposits, withdrawals, transfers) with configurable max history size.
- **Profile pictures** -- Fetches Steam profile pictures for the banking UI display.
- **Offline transfer support** -- Transfers to offline players are written directly to the database and available when they log in.
- **Draw text options** -- Supports both QBCore DrawText UI and 3D world text for NPC interaction prompts.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Banking UI does not open at ATMs | Ensure `qb-target` is started before `gfx-banking` in your server.cfg. Verify ATM model names in `Config.ATMModels` match your server's props. |
| "You don't have enough money" when creating account | The player needs the configured cash amount (`Config.NewAcount.price`, default $5000) in hand cash, not bank balance. |
| Player has no accounts after migration | Run `transfertonewbank` from the **server console** (not in-game). It only runs when `source == 0`. |
| Profile pictures not loading | The script fetches Steam profile pictures via HTTP. Ensure your server can reach `steamcommunity.com`. If Steam is unreachable, the fallback image (`Config.NoImage`) is used. |
| Transaction history missing after transfer to offline player | Verify `oxmysql` is running and the `players` table is accessible. Check server console for SQL errors. |
| NPC not spawning at bank | Check that `Config.NewAcount.NPC.coords` has valid vector4 entries and the model hash resolves correctly. |
| Max account limit not working | `Config.MaxAccountCount` controls the limit. Ensure it is set to a number greater than 0. |

## Customization (Hook Files)

The following files are **not escrowed** and can be freely edited:

- **`client/hook.lua`** -- Contains `Notify_Client`, `Draw3DText`, `UiText`, and `RemoveUI` functions. Edit these to replace qb-target, change notification style, or swap the DrawText system.
- **`server/hook.lua`** -- Contains `Notify_Server` and `GetPhoto` functions. Edit `GetPhoto` to change how player profile pictures are retrieved (e.g., use Discord avatar instead of Steam).
- **`config.lua`** -- All configuration options and locale strings.
