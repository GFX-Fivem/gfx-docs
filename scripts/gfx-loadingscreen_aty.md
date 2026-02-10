# GFX Loading Screen ATY

## Info

| Key | Value |
|---|---|
| **Resource Name** | `gfx-loadingscreen_aty` |
| **Author** | atiysu |
| **Type** | Loading Screen (NUI) |
| **FX Version** | Cerulean |
| **Game** | GTA 5 |
| **Lua 5.4** | Yes |
| **Framework** | Standalone (no framework required) |
| **Sides** | Client-side only (NUI) |

---

## Dependencies

This script has **no dependencies** on other FiveM resources. It is fully standalone.

External CDN libraries loaded by the UI:
- [jQuery 3.7.1](https://code.jquery.com/jquery-3.7.1.min.js)
- [Howler.js 2.2.4](https://cdnjs.cloudflare.com/ajax/libs/howler/2.2.4/howler.min.js) (included in HTML but audio uses native `Audio` API)
- [YouTube IFrame API](https://www.youtube.com/iframe_api) (for background video)

---

## Installation

### 1. Copy Files
Place the `gfx-loadingscreen_aty` folder into your server's resources directory:
```
resources/[gfx]/gfx-loadingscreen_aty/
```

### 2. server.cfg
Add the following line to your `server.cfg`. Loading screen resources must be ensured **before** any other resources:
```cfg
ensure gfx-loadingscreen_aty
```

### 3. Customize
Edit `ui/js/config.js` to set your server's staff, updates, news, gallery images, background video, and music playlist.

---

## Configuration

All configuration is done in `ui/js/config.js`. There is no Lua config file since this is a pure NUI loading screen.

### `Config.BgVideo`
| Type | Default |
|---|---|
| `string` | `"7ExgFMvN9TY?si=uqaKVLv-1QOe4f0_"` |

YouTube video ID (with optional parameters) used as the fullscreen background video. The video is embedded via an iframe, set to autoplay and loop, and is muted by default.

### `Config.Staffs`
| Type | Default |
|---|---|
| `array` | 8 sample entries |

Array of staff member objects displayed in the "Project Staff" panel on the left side. Each entry has:

| Property | Type | Description |
|---|---|---|
| `name` | `string` | Display name of the staff member |
| `rank` | `string` | Rank key, one of: `owner`, `developer`, `staff`. Controls the color styling |
| `rankLabel` | `string` | Display label shown next to the name (e.g., "Owner", "Developer", "Staff") |
| `profilePicture` | `string` | Filename of the profile picture located in `ui/assets/` |

**Rank colors:**
- `owner` - Red (#FF0039)
- `developer` - Orange (#FF6B00)
- `staff` - Green (#CF0)

### `Config.Updates`
| Type | Default |
|---|---|
| `array` | 3 sample entries |

Array of update entries displayed in the "Updates" panel on the right side. Each entry has:

| Property | Type | Description |
|---|---|---|
| `date` | `string` | Date string shown as subtitle (e.g., `"02.02.2024 / 16:17"`) |
| `title` | `string` | Title of the update |
| `text` | `string` | Description/body text of the update |

### `Config.News`
| Type | Default |
|---|---|
| `array` | 2 sample entries |

Array of news entries displayed in the "News" panel on the right side (below Updates). Same structure as `Config.Updates`:

| Property | Type | Description |
|---|---|---|
| `date` | `string` | Date string shown as subtitle |
| `title` | `string` | Title of the news item |
| `text` | `string` | Description/body text |

### `Config.Gallery`
| Type | Default |
|---|---|
| `array` | `["1.png", "2.png", "3.png", "4.png", "1.png"]` |

Array of image filenames for the gallery section at the bottom. Images must be placed in `ui/assets/gallery/`. Clicking an image opens it in a fullscreen lightbox overlay.

### `Config.Musics`
| Type | Default |
|---|---|
| `array` | 2 sample entries |

Array of music tracks for the built-in music player. Each entry has:

| Property | Type | Description |
|---|---|---|
| `title` | `string` | Display title of the track |
| `image` | `string` | Path to the cover art image (relative to `ui/`, e.g., `"../musics/music1.png"`) |
| `audio` | `string` | Path to the audio file (relative to `ui/`, e.g., `"../musics/music1.mp3"`) |

Music files should be placed in the `musics/` folder at the root of the resource.

---

## Exports

*No exports found.* This is a standalone NUI loading screen with no Lua exports.

---

## Events

*No public events found.* This script only listens to the built-in FiveM `loadProgress` NUI message to update the loading percentage.

---

## Commands

*No commands found.*

---

## Features

### Fullscreen YouTube Background Video
A YouTube video is embedded as the fullscreen background using the IFrame API. The video auto-plays in a loop and is muted to avoid audio conflicts with the music player.

### Circular Loading Progress Indicator
A circular SVG progress bar in the center of the screen displays the current loading percentage. It updates in real-time via FiveM's built-in `loadProgress` event, showing both a visual stroke animation and a numeric percentage.

### Music Player
A fully interactive music player with:
- **Play / Pause** controls
- **Next / Previous** track navigation
- **Volume slider** with visual feedback
- **Track progress bar** with seek support (drag to jump to position)
- **Track info** display (title, cover art, current time / duration)
- Automatically starts playing the first track on load
- Loops through the playlist when reaching the end

### Staff Panel
Displays server staff members with:
- Profile picture in a polygon-clipped frame
- Name and rank label
- Color-coded rank styling (owner/developer/staff)
- Scrollable list for many staff members

### Updates Panel
Scrollable list of server update entries, each with a date, title, and description. Styled with a left-border accent on the description text.

### News Panel
Scrollable list of server news entries with the same layout as updates, displayed below the updates panel.

### Image Gallery
A horizontal scrollable gallery at the bottom of the screen with:
- Left/right arrow navigation buttons
- Click-to-expand lightbox (click any image to view fullscreen, click again to close)

### Date and Time Display
Shows the current day of the week, time, and date at the top center of the screen, calculated from the player's local system time.

### Cursor Support
The loading screen has cursor support enabled (`loadscreen_cursor 'yes'`), allowing players to interact with all UI elements (music player, gallery, sliders) while loading.

---

## File Structure

```
gfx-loadingscreen_aty/
  fxmanifest.lua          -- Resource manifest
  musics/
    music1.mp3            -- Audio track 1
    music1.png            -- Cover art for track 1
    music2.mp3            -- Audio track 2
    music2.jpg            -- Cover art for track 2
  ui/
    index.html            -- Main loading screen HTML
    css/
      style.css           -- Compiled CSS
      style.css.map       -- Source map
      style.scss          -- SCSS source
    js/
      config.js           -- Configuration (staff, updates, news, gallery, music)
      main.js             -- Main application logic
    assets/
      bg-1.png            -- Panel background (staff)
      bg-2.png            -- Panel background (updates)
      bg-3.png            -- Panel background (news/music)
      bg-4.png            -- Panel background (gallery)
      overlay.png         -- Main overlay texture
      loading-vector-1.png -- Loading circle decoration
      default.png         -- Default profile picture
      default-music.png   -- Default music cover art
      owner.png           -- Owner rank badge
      developer.png       -- Developer rank badge
      staff.png           -- Staff rank badge
      polygon.png         -- Profile picture frame
      update-icon.png     -- Update entry icon
      news-icon.png       -- News entry icon
      gallery/
        1.png             -- Gallery image 1
        2.png             -- Gallery image 2
        3.png             -- Gallery image 3
        4.png             -- Gallery image 4
```

---

## Troubleshooting

### Loading screen not showing
- Ensure `gfx-loadingscreen_aty` is ensured in `server.cfg` **before** other resources
- Verify the `loadscreen 'ui/index.html'` directive in `fxmanifest.lua` is correct
- Check for F8 console errors related to the resource

### YouTube background video not playing
- The video ID in `Config.BgVideo` must be valid and the video must allow embedding
- Some videos have regional or embedding restrictions that may prevent playback
- The player is muted by default; this is intentional to comply with browser autoplay policies

### Music not playing
- Verify that audio files exist in the `musics/` folder and match the paths in `Config.Musics`
- Supported audio formats: MP3 (recommended)
- Check that the file paths use `../musics/` prefix since they are relative to the `ui/` directory

### Staff profile pictures not showing
- Images must be placed in `ui/assets/` and the `profilePicture` value must match the exact filename
- Default image is `default.png`

### Gallery images not appearing
- Images must be placed in `ui/assets/gallery/` and filenames must match the entries in `Config.Gallery`

### Cursor not working
- The `loadscreen_cursor 'yes'` directive in `fxmanifest.lua` enables cursor interaction. Do not remove this line.

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-loadingscreen_aty
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
