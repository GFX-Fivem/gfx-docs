# gfx-smoothcam

A purely client-side camera transition smoother that replaces GTA V's instant hard cut between third- and first-person (V key) with a cinematic glide. Works on foot and in vehicles, both directions, with no framework dependency.

---

## Info

| Key | Value |
|---|---|
| **Author** | GFX Development |
| **FX Version** | Cerulean |
| **Game** | GTA 5 |
| **Lua** | 5.4 |
| **Side** | Client only |
| **NUI** | None |

---

## Dependencies

*No dependencies. This resource is fully standalone and client-side only. It does not require gfx-lib, a framework, a database, or any inventory system.*

---

## Installation

### 1. Copy the resource
Place the `gfx-smoothcam` folder into your server's resources directory.

### 2. Configure `server.cfg`
```cfg
ensure gfx-smoothcam
```

No SQL import is required. No `gfx-lib` dependency is needed.

---

## Configuration

Configuration is located in `config.lua`:

| Option | Type | Default | Description |
|---|---|---|---|
| `TransTime` | `number` | `700` | Glide duration in milliseconds. Higher values produce a slower, more cinematic transition. The range 600–900 ms feels smooth; the original bbv-betterfp technique ships 1500. |
| `PostBlendDelay` | `number` | `175` | Extra hold time (ms) after the glide finishes, before the view actually switches to first person. Lets the scripted camera fully settle at the head position. 150–200 is recommended. |
| `SkipWhenAiming` | `boolean` | `true` | When `true`, pressing V while free-aiming or holding aim bypasses the smooth glide and lets the vanilla instant switch happen, so combat is never interrupted. |
| `HeadForwardOffset` | `number` | `0.5` | Distance in metres to push the scripted camera forward from the head bone along the ped/vehicle forward vector. Increase this if the back of the head pokes into view while moving. 0.4–0.6 is recommended. |
| `PreFpMode` | `number` | `2` | The third-person follow-ped view mode that comes immediately before first person in the V cycle (on foot). The script only intercepts V at this mode, so all earlier third-person zoom steps cycle normally. Default GTA cycle: 0 → 1 → 2 → first person. |
| `PreFpModeVehicle` | `number` | `2` | Same as `PreFpMode` but used when the player is inside a vehicle. |
| `PostFpMode` | `number` | `0` | The third-person mode to land on when leaving first person (pressing V while in first person, on foot). Default `0` preserves the full vanilla V zoom cycle (first → 0 → 1 → 2 → first). |
| `PostFpModeVehicle` | `number` | `0` | Same as `PostFpMode` but used when the player is inside a vehicle. |

---

## Exports

*No exports are provided by this script.*

---

## Events

*No public API events are provided by this script.*

---

## Commands

*No commands are registered by this script.* The transition is triggered automatically when the player presses the Change View key (default V).

---

## Features

- **Smooth both-direction transition** — the cinematic glide runs third→first AND first→third, not just one way.
- **No first-person arms/animation flash** — the engine view mode stays third-person for the entire glide duration; first person is activated only after the scripted camera finishes and is destroyed.
- **On-foot and in-vehicle support** — separate pre/post mode configuration for ped camera and vehicle follow camera.
- **Vehicle-anchored scripted camera** — when driving, the scripted cam is attached to the vehicle entity (not the ped head bone) to eliminate jitter caused by the head bone moving during vehicle physics.
- **Aim-aware skip** — when `SkipWhenAiming` is enabled, free-aim and held-aim states bypass the glide so combat responsiveness is preserved.
- **Normal V zoom cycle preserved** — only the two boundaries that cross into or out of first person are intercepted; all intermediate third-person zoom steps (0 → 1 → 2) cycle as normal.
- **Resource-stop safety cleanup** — an `onResourceStop` handler immediately tears down any in-progress scripted camera so the player is never left stuck in a black screen or frozen render if the resource is restarted mid-glide.
- **Zero server load** — the entire resource is client-side. No network events, no database queries, no framework calls.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Glide feels too fast or too slow | Adjust `Config.TransTime`. 600–900 ms is smooth for most players; increase toward 1000–1200 for a more cinematic feel, decrease toward 400–500 for snappier transitions. |
| Back of the head pokes into view while moving | Increase `Config.HeadForwardOffset`. Start at 0.6 and go higher in 0.1 steps until the head is no longer visible during the glide. |
| Camera takes over during combat or ADS | Set `Config.SkipWhenAiming = true` (it is `true` by default). If you have set it to `false`, re-enable it. |
| Camera takeover happens at the wrong V cycle step | Your server may have a modified V cycle (e.g. only two zoom levels). Adjust `Config.PreFpMode` / `Config.PreFpModeVehicle` to match the view-mode number that immediately precedes first person on your server. |
| After leaving first person the camera lands on the wrong zoom level | Adjust `Config.PostFpMode` / `Config.PostFpModeVehicle` to the third-person mode you want the player to return to. |
| Conflicts with another first-person or camera resource | `gfx-smoothcam` intercepts the V key control and drives a scripted camera. Running two resources that both do this will cause them to fight. Only one camera-transition resource should be active at a time. |
| Player gets stuck in a black screen after resource restart during a glide | This is handled automatically by the `onResourceStop` cleanup. If it occurs, it is likely caused by a different resource destroying the GTA script camera state. Restart the resource manually. |

---

## Source

- **GitHub:** [gfx-smoothcam](https://github.com/gfx-fivem/gfx-smoothcam)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
