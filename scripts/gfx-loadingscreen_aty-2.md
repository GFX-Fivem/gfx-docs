# gfx-loadingscreen_aty-2

## Info

| Key | Value |
|---|---|
| **Resource Name** | `gfx-loadingscreen_aty-2` |
| **Author** | atiysu |
| **FX Version** | cerulean |
| **Game** | GTA 5 |
| **Lua 5.4** | Yes |
| **UI Framework** | Vue 3 + Pinia |
| **Side** | Server + NUI |
| **Escrow** | Yes (config.lua, server.lua open) |

---

## Dependencies

- No external script dependencies required.

---

## Installation

### 1. Copy Files
```bash
cp -r gfx-loadingscreen_aty-2 /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-loadingscreen_aty-2
```

> **Note:** The loading screen resource must be started before any other resources that depend on the player connecting flow. It is typically one of the first resources ensured in `server.cfg`.

---

## Configuration

All configuration is done in `config.lua`. The config is passed to the NUI via the `playerConnecting` handover mechanism.

### Config.Staffs
Defines staff members displayed on the loading screen.

| Field | Type | Description |
|---|---|---|
| `id` | `number` | Unique identifier for the staff member |
| `name` | `string` | Display name |
| `role` | `string` | Staff role (e.g. "Developer") |
| `avatar` | `string` | URL to the avatar image |
| `description` | `string` | Short description of the staff member |
| `twitter` | `string` | Twitter username |
| `youtube` | `string` | YouTube username |
| `instagram` | `string` | Instagram username |
| `discord` | `string` | Discord username |

```lua
Config = {
    Staffs = {
        {
            id = 1, -- must be unique
            name = 'Atiysu',
            role = 'Developer',
            avatar = 'https://via.placeholder.com/100',
            description = 'This is the first staff',
            twitter = 'atiysu',
            youtube = 'atiysu',
            instagram = 'atiysu',
            discord = 'atiysu',
        },
    },
}
```

### Config.Updates
Defines server update/news cards shown on the loading screen.

| Field | Type | Description |
|---|---|---|
| `id` | `number` | Unique identifier for the update |
| `title` | `string` | Update card title |
| `description` | `string` | Short description text |
| `thumbnail` | `string` | URL to the thumbnail image |
| `category` | `string` | Category label (e.g. "SERVER UPDATE", "DISCORD UPDATE") |
| `date` | `string` | Date string displayed on the card |

```lua
Updates = {
    {
        id = 1,
        title = 'Content Update!',
        description = 'Lorem ipsum dolor sit amet',
        thumbnail = 'https://example.com/image.jpg',
        category = 'SERVER UPDATE',
        date = '5.28.2024',
    },
},
```

### Config.Keys
Defines keyboard shortcut hints displayed in the "Useful Keys" overlay.

| Field | Type | Description |
|---|---|---|
| `name` | `string` | Key name displayed on the keycap (e.g. "F1") |
| `title` | `string` | Title for the key function |
| `description` | `string` | Description of what the key does |

```lua
Keys = {
    {
        name = 'F1',
        title = 'PHONE',
        description = 'You can open your phone with this key.'
    },
},
```

### Config.Musics
Defines background music tracks available in the music player.

| Field | Type | Description |
|---|---|---|
| `id` | `number` | Unique identifier for the music track |
| `title` | `string` | Track title displayed in the player |
| `thumbnail` | `string` | URL or base64-encoded image for the track thumbnail |
| `source` | `string` | Filename of the audio file (placed in the UI assets) |

```lua
Musics = {
    {
        id = 1,
        title = 'SOUTH ARCADE - DANGER',
        thumbnail = 'https://example.com/thumb.jpg',
        source = 'danger.mp3',
    },
},
```

---

## Exports

*No exports found.*

This script does not create any exports via `exports('name', function)`.

---

## Events

*No public API events found.*

The script uses the built-in FiveM `playerConnecting` event handler internally to pass configuration data to the NUI loading screen via `deferrals.handover()`. This is not a public API event for other scripts.

---

## Commands

*No commands found.*

---

## Features

- **Custom Loading Screen** -- Fully custom NUI-based loading screen replacing the default FiveM loading screen.
- **Staff Members Panel** -- Displays server staff with name, role, avatar, description, and social media links (Twitter, YouTube, Instagram, Discord) with color-coded social icons.
- **Server Updates/News Carousel** -- Horizontally scrolling news cards with thumbnails, titles, descriptions, categories, and dates. Auto-scrolls when more than 3 updates are configured.
- **Music Player** -- Built-in audio player with play/pause, next/previous track, volume slider, progress bar, and track duration display.
- **Useful Keys Overlay** -- Togglable overlay panel showing configurable keyboard shortcuts and their descriptions, activated via a button click.
- **Hide UI Toggle** -- "No View" button that hides the staff members, updates, loading bar, and keys overlay for an unobstructed background view.
- **Animated Loading Bar** -- SVG wave-style loading progress bar displayed at the top of the screen that reflects actual game loading progress.
- **Live Clock** -- Real-time date and time display updated every second (day of week, time, full date).
- **Cursor Support** -- Loading screen cursor is enabled (`loadscreen_cursor 'yes'`) for interacting with UI controls.
- **Escrow Ready** -- `config.lua` and `server.lua` are excluded from escrow, allowing server owners to customize configuration without access to the protected UI code.

---

## Troubleshooting

| Problem | Solution |
|---|---|
| Loading screen not showing | Ensure the resource is `ensure`d in `server.cfg` and that no other resource overrides `loadscreen`. |
| Music not playing | Verify that the audio files referenced in `Config.Musics[].source` exist in the UI assets folder. Browser autoplay policies may also block audio until user interaction. |
| Staff avatars not loading | Check that the avatar URLs in `Config.Staffs` are valid and publicly accessible. |
| Update thumbnails broken | Ensure thumbnail URLs in `Config.Updates` are valid, publicly accessible, and not blocked by CORS. |
| Loading bar not progressing | The loading bar relies on the FiveM `loadProgress` NUI message. If the bar stays at 0%, this is normal until the game begins loading assets. |
| Keys overlay not appearing | Click the "SHORTCUT" button in the controls section at the bottom-left of the screen. |

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-loadingscreen_aty-2
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
