# GFX Multichar

A multicharacter selection system for FiveM that allows players to create and switch between multiple characters. Features a custom NUI interface for character listing, selection, and creation. Ships in two variants: `gfx_multichar` for ESX and `gfx_multichar_qb` for QBCore.

---

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx_multichar` / `gfx_multichar_qb` |
| **FX version** | `cerulean` |
| **Game** | `gta5` |
| **Lua 5.4** | Yes |
| **Author** | atiysu & frosty |
| **Side** | Client + Server |
| **UI** | NUI (HTML/JS/CSS) |

---

## Dependencies

### ESX Variant (`gfx_multichar`)

| Dependency | Required | Notes |
|------------|----------|-------|
| **es_extended** | Yes | Core ESX framework |
| **oxmysql** | Yes (default) | Set `Config.MySQL = "oxmysql"` |
| **mysql-async** | Alternative | Set `Config.MySQL = "mysql-async"` if using this instead |
| **skinchanger** | Yes | Used for loading player skin on spawn |
| **esx_skin** | Yes | Opens the saveable skin menu for new characters |

### QBCore Variant (`gfx_multichar_qb`)

| Dependency | Required | Notes |
|------------|----------|-------|
| **qb-core** | Yes | Core QBCore framework |
| **qb-apartment** | Yes | Handles apartment spawn UI after login/creation |
| **oxmysql** | Yes (default) | Set `Config.MySQL = "oxmysql"` |
| **mysql-async** | Alternative | Set `Config.MySQL = "mysql-async"` if using this instead |
| **qb-clothing** | Yes | Loads player clothing after character selection |
| **qb-houses** | Optional | House config is loaded on login if available |
| **qb-garages** | Optional | Garage config is loaded on login if available |
| **qb-weathersync** | Optional | Weather sync is enabled on new character creation |

---

## Installation

### 1. Choose Your Variant

- **ESX servers:** Use the `gfx_multichar` folder.
- **QBCore servers:** Use the `gfx_multichar_qb` folder.

### 2. Copy Files

Place the chosen folder into your server's resources directory.

### 3. server.cfg

For ESX:
```cfg
ensure es_extended
ensure oxmysql
ensure skinchanger
ensure esx_skin
ensure gfx_multichar
```

For QBCore:
```cfg
ensure qb-core
ensure oxmysql
ensure qb-apartment
ensure qb-clothing
ensure gfx_multichar_qb
```

> **Note:** Ensure all dependencies start before `gfx_multichar` / `gfx_multichar_qb`.

### 4. Configure

Edit `config.lua` in the chosen variant folder (see Configuration section below).

---

## Configuration

All options are set in `config.lua`:

### General

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.MySQL` | `string` | `"oxmysql"` | MySQL library to use. Supported values: `"oxmysql"` or `"mysql-async"` |

### Spawn Location

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.Spawn.x` | `number` | `-284.2856` | X coordinate for character spawn location |
| `Config.Spawn.y` | `number` | `562.4627` | Y coordinate for character spawn location |
| `Config.Spawn.z` | `number` | `172.9182` | Z coordinate for character spawn location |
| `Config.Spawn.heading` | `number` | `19.9895` | Heading (direction the player faces) at spawn |

### Default Appearance

| Option | Type | Description |
|--------|------|-------------|
| `Config.Default["m"]` | `table` | Full ped appearance preset for new male characters. Includes face shape (mom, dad, blend weights), facial features (nose, cheeks, jaw, chin), hair style/color, clothing components, accessories, and overlays. |
| `Config.Default["f"]` | `table` | Full ped appearance preset for new female characters. Same structure as male with different default values. |

The default appearance tables contain the following categories of properties:

- **Heritage:** `mom`, `dad`, `face_md_weight`, `skin_md_weight`
- **Facial features:** `nose_1`-`nose_6`, `cheeks_1`-`cheeks_3`, `lip_thickness`, `jaw_1`-`jaw_2`, `chin_1`-`chin_4`, `neck_thickness`, `eye_squint`
- **Hair:** `hair_1`, `hair_2`, `hair_color_1`, `hair_color_2`
- **Clothing:** `tshirt`, `torso`, `arms`, `pants`, `shoes`, `mask`, `bproof`, `chain`, `helmet`, `glasses`, `watches`, `bracelets`, `bags`, `decals`, `ears` (each with `_1` and `_2` variants)
- **Overlays:** `eyebrows`, `makeup`, `lipstick`, `beard`, `age`, `blemishes`, `blush`, `complexion`, `sun`, `moles`, `chest`, `bodyb` (each with numeric suffixes)
- **Other:** `eye_color`

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events for external scripts.* All events used (`gfx_multichar:login`, `gfx_multichar:create`, `gfx_multichar:getMyInfo`, `gfx_multichar:getSkin`) are internal to the script's own client-server communication.

---

## Commands

*No user-facing commands.*

> **Note (ESX only):** A `/test` debug command exists in the client that opens the `esx_skin` saveable menu. This is for development use only and should not be relied upon in production.

---

## Features

- **Multi-character support:** Players can own and switch between multiple characters on the same account.
- **NUI character selection UI:** Custom HTML/JS/CSS interface for browsing, selecting, and creating characters.
- **Character info display:** Shows character details (name, job, salary, money) in the selection screen.
- **New character creation flow:**
  - **ESX:** Applies a default skin preset based on gender, then opens the `esx_skin` appearance editor.
  - **QBCore:** Triggers the `qb-clothes` first character creation flow and apartment spawn setup.
- **Starter items (QBCore):** Automatically gives new characters the configured starter items from `QBCore.Shared.StarterItems` (including pre-filled ID card and driver license metadata).
- **House & garage loading (QBCore):** Loads house locations and garage data from the database on login.
- **Dual MySQL support:** Compatible with both `oxmysql` and `mysql-async`.
- **Escrow support:** `config.lua` and `locales/en.lua` are excluded from escrow encryption.
- **License-based identification:** Characters are linked to the player's FiveM license identifier.

---

## Database

### ESX Variant

Uses the standard ESX `users` and `job_grades` tables:
- `users` -- queried by `identifier` (license) to list characters
- `job_grades` -- queried to fetch salary info for each character's job

### QBCore Variant

Uses the standard QBCore `players` and `playerskins` tables:
- `players` -- queried by `license` to list characters, stores `charinfo`, `money`, `job` as JSON
- `playerskins` -- queried by `citizenid` and `active = 1` to load character skin/model
- `houselocations` -- queried to load house config data on login

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Character list is empty | Verify that the `users` (ESX) or `players` (QBCore) table has entries matching the player's license identifier. Check server console for MySQL errors. |
| Screen stays black after selecting a character | Ensure `skinchanger` (ESX) or `qb-clothing` (QBCore) is running and started before this resource. |
| NUI does not open | Check that the `ui/` folder contains `index.html`, `js/main.js`, `css/style.css`, and `assets/` images. Verify `ui_page` and `files` in `fxmanifest.lua`. |
| MySQL errors on startup | Confirm `Config.MySQL` matches your installed MySQL library (`"oxmysql"` or `"mysql-async"`). Ensure the MySQL resource starts before this one. |
| New character has no skin editor (ESX) | Make sure `esx_skin` and `skinchanger` are both started. The skin editor is triggered via `esx_skin:openSaveableMenu`. |
| Apartments error on QBCore | Ensure `qb-apartment` is running and `@qb-apartments/config.lua` is accessible. The script loads apartment config from this shared file. |
| `/test` command not working | This is an ESX-only debug command. It is not available in the QBCore variant. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-multichar
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
