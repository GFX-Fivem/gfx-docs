# GFX Laptop

A placeable laptop that runs a full macOS-style operating system in-world (rendered on the laptop prop via DUI). Mail, Files, Photos, Notes, Maps, Weather, a crypto exchange, a music player, an App Market, Business Mode for shared/work laptops, spatial audio, and a **developer SDK** so other resources can build their own apps.

## Info

| | |
|---|---|
| **Type** | Standalone app / OS |
| **Render** | DUI on the prop (`hei_prop_hst_laptop`), fullscreen NUI fallback |
| **Framework** | Auto-detected via `gfx-lib` (QBCore / ESX) |
| **Item-based** | Placeable laptop item; per-device owner + password |

## Dependencies

- **gfx-lib** (required — framework / inventory / SQL bridge)
- **oxmysql** (or ghmattimysql / mysql-async)
- **lb-phone** (optional — enables the Mail/Chats phone integration)

---

# For Users

## Installation

### 1. Install gfx-lib first
`gfx-lib` must be installed and started **before** gfx-laptop. See [gfx-lib](../core/gfx-lib.md).

### 2. Copy the resource
Extract `gfx-laptop` into your `resources/` folder. The folder name must be exactly `gfx-laptop`.

### 3. server.cfg
```cfg
ensure gfx-lib
ensure gfx-laptop
```
> `gfx-lib` must start **before** gfx-laptop.

### 4. Database
Tables are created automatically on first start (oxmysql). No manual SQL import needed.

### 5. Item
Add the laptop item to your inventory (default item name is set in `config.lua` → `Config.Item`). Give it to a player; **using the item places the laptop** in front of them.

## Configuration
Open `config.lua`:

| Option | Description |
|---|---|
| `Config.Item` | Inventory item that places the laptop |
| `Config.Mail.domain` | Email domain for in-OS mail addresses (`name@<domain>`) |
| `Config.Music.YouTubeApiKey` | YouTube Data API key → enables the **Soundify** music app |
| `Config.Crypto.Source` | `real` (CoinGecko) or `random` market data for **Binix** |
| `Config.Crypto.RefreshHours` | How often crypto prices refresh |
| `Config.DrawText`, `Config.DefaultLanguage`, … | UI / locale options |

## Using the laptop
- **Place:** use the laptop item → it drops in front of you.
- **Open:** target the laptop and use it → the lid opens and the OS boots.
- **Owner & password:** the first user (placer) becomes the owner; a password can be set in Onboarding/Settings. Anyone who enters the password shares the unlocked terminal until the lid shuts.
- **Pick up:** the placer can pick the laptop back up (it keeps its data via the item).

## Business Mode
Turn a laptop into a shared work/shop terminal (Settings → **Business Mode**, owner only):
- Toggle Business Mode on/off (synced — anyone looking at the laptop sees the badge).
- **Allowed apps:** choose which neutral apps staff may use (owner-data apps stay private).
- **Staff:** add staff **by phone number**; registered staff open the laptop **without the password**, limited to the allowed apps. Non-staff are refused.

## Features
- macOS-style desktop: dock, launchpad, spotlight, widgets, notifications (positional sound).
- Apps: Mail, Files (Finder), Photos, Notes, Calendar, Clock, Calculator, Paint, Maps, Weather, **Binix** (crypto), **Soundify** (music), **App Market**, Settings.
- Multi-viewer mirror: bystanders see the live screen on the prop.
- Light / dark theme, 4 languages (EN/TR/DE/FR).

---

# For Developers

gfx-laptop is a small platform — build your own apps and push into a player's laptop. Two surfaces: **Lua exports** (server + client) and the **gfxos JS SDK** (for in-OS iframe apps). Full reference + framework examples live in the resource's `sdk/` folder (`README.md`, `gfxos.js`, `gfxos.mjs`, `gfxos.d.ts`).

`target` = **server id (number)** or **citizenid (string)**.

## Server exports — `exports['gfx-laptop']`

```lua
-- notifications + deeplink
exports['gfx-laptop']:Notify(target, { app = 'mail', title = 'Boss', body = 'Come to work', icon = '...' })
exports['gfx-laptop']:OpenApp(target, 'mail', { compose = { to = 'jane@ls.mail', subject = 'Hi', body = '...' } })
exports['gfx-laptop']:CloseApp(target, 'mail')

-- photos / gallery
exports['gfx-laptop']:AddPhoto(target, { url = 'https://...', label = 'Receipt' })

-- finder / files
exports['gfx-laptop']:ListFiles(target, parentId)        -- parentId optional → { rows }
exports['gfx-laptop']:ReadFile(target, fileId)           -- { id, name, mime, content }
exports['gfx-laptop']:WriteFile(target, { name = 'note.txt', content = 'hi', mime = 'text/plain' })
exports['gfx-laptop']:DeleteFile(target, fileId)

-- mail
exports['gfx-laptop']:SendMail(target, { sender = 'Bank', subject = 'Statement', body = '...' })

-- identity / state
exports['gfx-laptop']:GetUser(target)                    -- { citizenid, name, email }
exports['gfx-laptop']:GetTheme(target)                   -- 'light' | 'dark'
exports['gfx-laptop']:IsLaptopOpen(target)               -- boolean

-- register / unregister your app (shows in the App Market & dock)
exports['gfx-laptop']:RegisterApp({
  id = 'myapp', name = 'My App',
  icon = 'https://.../icon.png',                 -- dock/market icon (fills the slot)
  iconDark = 'https://.../icon-dark.png',         -- optional: adaptive icon used in DARK theme
  iconFit = 'cover',                              -- 'cover' (fill slot, default) | 'contain' (fit with padding)
  url = ('nui://%s/web/index.html'):format(GetCurrentResourceName()),
  store = { developer = 'You', category = 'Tools', price = 0, description = '...' },
})
exports['gfx-laptop']:UnregisterApp('myapp')
```

## Client exports (local player's open laptop)
```lua
exports['gfx-laptop']:Notify({ app = 'myapp', title = 'Hi', body = '...' })
exports['gfx-laptop']:OpenApp('mail', { compose = { to = '...' } })
```

## Events
```lua
AddEventHandler('gfx-computer:mailReceived', function(citizenid, mail) ... end)
```

## gfxos JS SDK (iframe apps — any framework)
Your app is a web page rendered in an iframe inside the OS. Register it (`RegisterApp` above), then talk to the OS with the `gfxos` global / module. Ships as **UMD** (`gfxos.js`, `<script>`), **ESM** (`gfxos.mjs`, for Vite/React/Vue/TS) and types (`gfxos.d.ts`). Every call returns a Promise.

```js
// vanilla
const me  = await gfxos.system();          // { citizenid, name, email, theme, locale }
const pic = await gfxos.gallery.pick();     // user picks a photo → { url, id, name } | null
if (pic) await gfxos.storage.set({ avatar: pic.url });
await gfxos.notify({ title: 'My App', body: 'Saved' });
await gfxos.open('finder');                 // deeplink another app
```
```tsx
// React / TS
import gfxos from './gfxos.mjs';
useEffect(() => { gfxos.system().then(setMe); }, []);
const pick = async () => { const p = await gfxos.gallery.pick(); if (p) setAvatar(p.url); };
```

**Full API:** `storage.get/set`, `notify`, `open(appId, params)`, `close`, `system`, `gallery.pick/add`, `fs.list/read/write/del/pick`, `mail.compose`, `on(event, cb)`. See `sdk/README.md` for Vue and more examples.

### Live theme (light / dark)
`gfxos.system()` returns the current `theme`, and the OS **pushes a live `theme` event** when the user switches light/dark in Settings — subscribe to re-theme instantly:
```js
gfxos.system().then(({ theme }) => document.body.dataset.theme = theme);  // initial
gfxos.on('theme', ({ theme }) => document.body.dataset.theme = theme);    // live
```

> Storage is **per-app** and per-user (server-persisted). Money/installs are never exposed to iframes — they stay server-validated via the App Market.

### Keyboard input
The laptop renders on a DUI prop, which receives no real keystrokes — the OS forwards them. **Just include the gfxos SDK** (`gfxos.js` or `gfxos.mjs`) and typing into your app's `<input>`/`<textarea>`/`contentEditable` works automatically; the SDK applies the forwarded keys to your focused field (controlled React inputs included). No setup beyond loading the SDK.

## Widgets

Add a `widget` to `RegisterApp` and your app gets a Notification-Center / desktop widget (an iframe of your widget page). You control the size, the allowed shapes and the default; the user can place it and switch shape (square ↔ rectangle) unless you lock it.

```lua
exports['gfx-laptop']:RegisterApp({
  id = 'myapp', name = 'My App', url = 'nui://my-resource/web/index.html',
  widget = {
    url = 'nui://my-resource/web/widget.html',   -- widget page (defaults to the app url)
    title = 'My App',
    shapes = { 'sm', 'wide' },                   -- sizes the user may pick (default both)
    defaultShape = 'wide',                       -- spawn size: 'sm' (square) | 'wide' (rectangle)
    height = 190,                                -- iframe height in the SQUARE shape
    heightWide = 150,                            -- iframe height in the RECTANGLE shape
  },
})
```

Your widget page reads its current shape and adapts:
```js
if (gfxos.widget.active) document.body.dataset.shape = gfxos.widget.shape;  // 'sm' | 'wide'
```
The widget iframe gets `&widget=1&shape=sm|wide`; changing shape reloads it so your page re-renders. Lock to a rectangle with `shapes = { 'wide' }` (hides the resize toggle), like the built-in Soundify/Binix widgets.

## Troubleshooting
- **App Market shows "no resources found" on Keymaster upload:** manifest must be UTF-8 **no BOM**; zip with 7-Zip (not `Compress-Archive`); bump `version`.
- **Join error "resource.rpf failed / HTTP 500":** the `cache/files/gfx-laptop` was cleared without restarting — run `restart gfx-laptop` on the server.
- **Soundify hidden:** set `Config.Music.YouTubeApiKey` (and enable YouTube Data API v3 on the key).

## Source
Open-source build lists all source in `escrow_ignore`. Escrow build exposes only config/locale, the public `exports(...)` file(s), integration/override, `sql/*.sql` and docs.
