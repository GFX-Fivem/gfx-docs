# Installation

This guide covers the general installation process for any GFX script.

## Prerequisites

- A working FiveM server
- A supported framework: **QBCore** or **ESX**
- A supported SQL resource: **oxmysql**, **ghmattimysql**, or **mysql-async**
- **gfx-lib** installed and running (required by all GFX scripts)

## Step-by-Step

### 1. Install gfx-lib first

`gfx-lib` is the shared library that all GFX scripts depend on. Install it before any other GFX resource.

1. Download `gfx-lib` from [Tebex](https://gfx.tebex.io/package/7053256)
2. Extract to your `resources/` folder
3. Add `ensure gfx-lib` to your `server.cfg` — **before** any other `gfx-*` resource
4. Configure `config.lua` and `serverconfig.lua` (see [gfx-lib reference](../core/gfx-lib.md))

### 2. Install the script

1. Download the script from Tebex (escrow or open-source version)
2. Extract the folder into your `resources/` directory
3. The folder name should match the resource name (e.g., `gfx-redzone`)

### 3. Add to server.cfg

```cfg
ensure gfx-lib
ensure gfx-redzone  # or whichever script you're installing
```

> **Important:** `gfx-lib` must start **before** any GFX script. Place it above all `gfx-*` entries in your `server.cfg`.

### 4. Configure

Each script has a `config.lua` file. Open it and adjust values to your needs. Many config options follow [common patterns](common-config-patterns.md) shared across scripts.

### 5. Add items (if applicable)

Some scripts require items to be registered in your inventory system. Check the script's documentation for a list of required items and add them to your inventory's item list.

### 6. Import SQL (if applicable)

Some scripts include a `.sql` file. Import it into your database:

```bash
mysql -u root -p your_database < script.sql
```

Or use phpMyAdmin / HeidiSQL to import.

### 7. Restart

Restart your server or use the `ensure` command in your server console.

## Escrow vs Open Source

Every GFX script is available in two versions on Tebex:

| Version | Description |
|---|---|
| **Escrow** | Code is protected via FiveM's Escrow system. Cheaper. Config files are still editable. |
| **Open Source** | Full source code access. You can modify everything. |

Both versions are functionally identical. The escrow version protects files not listed in `escrow_ignore` in the `fxmanifest.lua`.

## Common Issues

| Problem | Solution |
|---|---|
| Script not starting | Check that `gfx-lib` is ensured **before** the script |
| "attempt to index a nil value (Utils)" | `gfx-lib` is not running or started after this script |
| Framework not detected | Make sure your framework (`qb-core` or `es_extended`) starts before `gfx-lib` |
| Items not working | Register the items in your inventory resource's item list |
