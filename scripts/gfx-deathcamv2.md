# gfx-deathcamv2

## Info

| Key | Value |
|---|---|
| **Name** | gfx-deathcamv2 |
| **Description** | GFX Deathcam - A cinematic death camera with detailed combat log UI |
| **FX Version** | cerulean |
| **Game** | GTA 5 |
| **Lua 5.4** | Yes |
| **UI** | NUI (HTML/CSS/JS) |
| **Escrow** | Yes (open files: `cl_main.lua`, `sv_main.lua`, `config.lua`) |
| **Framework** | Standalone (no framework dependency) |

---

## Dependencies

- None (fully standalone)

---

## Installation

### 1. Copy the resource folder
Place `gfx-deathcamv2` into your server's resources directory.

### 2. Add to server.cfg
```cfg
ensure gfx-deathcamv2
```

---

## Configuration

All configuration is done in `config.lua`.

### General Settings

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.FatalIndex` | `number` | `6` | Index position for the fatal flag in the damage event args |
| `Config.WeaponIndex` | `number` | `7` | Index position for the weapon hash in the damage event args |
| `Config.duration` | `number` | `5000` | Duration of the death camera in milliseconds |
| `Config.resetDamageTime` | `number` | `15000` | Time in ms after which accumulated damage tracking data is reset |

### Camera Settings (`Config.Cam`)

| Option | Type | Default | Description |
|---|---|---|---|
| `Config.Cam.Fov` | `float` | `50.0` | Field of view for the death camera |
| `Config.Cam.AttachOffsets.x` | `float` | `0.0` | Camera X offset relative to the attacker |
| `Config.Cam.AttachOffsets.y` | `float` | `2.8` | Camera Y offset relative to the attacker |
| `Config.Cam.AttachOffsets.z` | `float` | `0.6` | Camera Z offset relative to the attacker |
| `Config.Cam.EntityOffsets.x` | `float` | `0.0` | Camera point-at X offset on the attacker entity |
| `Config.Cam.EntityOffsets.y` | `float` | `0.0` | Camera point-at Y offset on the attacker entity |
| `Config.Cam.EntityOffsets.z` | `float` | `0.0` | Camera point-at Z offset on the attacker entity |

### Weapon Names (`Config.WeaponNames`)

A table mapping weapon hashes (integers) to display names. Covers all standard GTA V weapons including melee, pistols, SMGs, rifles, shotguns, heavy weapons, and throwables. Add or modify entries to customize weapon names shown in the death screen UI.

### Body Parts (`Config.BodyParts`)

A table mapping body part keys to their display names:

| Key | Display Name |
|---|---|
| `head` | Head |
| `body` | Body |
| `left-arm` | Left Arm |
| `right-arm` | Right Arm |
| `left-leg` | Left Leg |
| `right-leg` | Right Leg |

---

## Exports

*No exports are created by this script.*

---

## Events

*No public API events are exposed by this script.* All events used are internal (callback system between client and server).

---

## Commands

*No commands are registered by this script.*

---

## Features

- **Cinematic Death Camera**: When the player is killed, a scripted camera automatically focuses on the attacker for a configurable duration.
- **Killer Identification**: Displays the killer's player name and their Steam profile picture (fetched via Steam XML API).
- **Weapon Display**: Shows the weapon name used for the killing blow, resolved from a configurable weapon hash table.
- **Fatal Hit Location**: Displays which body part received the killing blow (Head, Body, Left Arm, Right Arm, Left Leg, Right Leg).
- **Combat Damage Log**: Tracks all damage exchanged between the victim and attacker during the fight, showing:
  - Total damage dealt **to you** with hit count
  - Total damage dealt **to enemy** with hit count
- **Body Part Hit Visualization**: The NUI displays a body model with highlighted body parts indicating where the player was hit.
- **Bone-Based Tracking**: Uses GTA V bone IDs to accurately determine which body part was damaged per hit.
- **Automatic Damage Reset**: Accumulated damage tracking resets after a configurable period (`resetDamageTime`) to keep data relevant to the current fight.
- **Standalone**: No framework required. Works on any FiveM server.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Death camera not showing | Verify `Config.FatalIndex` and `Config.WeaponIndex` match your server's OneSync/artifact version. Some builds use different arg indices for `CEventNetworkEntityDamage`. |
| Killer avatar not loading | The script fetches Steam profile pictures. If the killer has no Steam identifier, a default placeholder image is shown. Ensure players connect with Steam. |
| Weapon name shows as a hash number | The weapon is not in `Config.WeaponNames`. Add the missing weapon hash and display name to the table in `config.lua`. |
| UI appears but shows incorrect damage | Damage data resets every `Config.resetDamageTime` ms. If fights last longer than this, earlier hits may not be counted. Increase the value if needed. |
| Camera snaps or looks wrong | Adjust `Config.Cam.Fov`, `Config.Cam.AttachOffsets`, and `Config.Cam.EntityOffsets` to fine-tune the camera angle and distance. |
| Script error on `svconfig.lua` | The `fxmanifest.lua` references `svconfig.lua` in `server_scripts`. Ensure this file exists in the root of the resource (it may contain server-specific overrides or be part of the escrow build). |
