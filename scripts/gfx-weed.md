# Gfx Weed

## Installation

### 1. Copy Files
```bash
# Copy gfx-weed folder to your resources directory
cp -r gfx-weed /path/to/resources/
```

### 2. server.cfg
```cfg
ensure gfx-weed
```

### 3. Dependencies
- ox_inventory or ox_lib (detected)

---

## Configuration

### client_config.lua

```lua
Config = {
    PlayerLoadedEvent = "playerSpawned",
    Theme = {
        ["primary"] = '#ff4f22',
        ["primary-content"] = '#900000',
        ["primary-opacity"] = "rgba(255, 47, 47, 0.2)",
        ["secondary"] = "#FF2F2F",
        ["secondary-content"] = '#900000',
        ["secondary-opacity"] = "rgba(255, 47, 47, 0.2)",
    },
    
    -- Notify = function(source, message)
        
    -- end, -- Uncomment this line and paste your export to enable custom notifications
    backpackprop = "sf_prop_sf_backpack_01a",
    WaterItem = "water_bottle",
    TrimmerItem = "scissors",
    FertilizerItem = "fertilizer",
    Decrease_Player_Alpha = true, -- Decrease player alpha when dragging objects
    EnableSelling = true, -- Enable selling weed
    Table_Display_Distance = 10.0,
    Table_Types = {
        ['joint_table'] = {
            prop = 'bkr_prop_weed_table_01b',
            objects = {
                {
                    prop = 'ex_mp_h_lit_lamptable_02',
                    offset = vector3(-0.975, 0.45, 0.825),
                    rotation = vector3(0.0, 5.0, 150.0),
                },
                {
                    prop = 'ex_mp_h_lit_lamptable_02',
                    offset = vector3(0.975, -0.45, 0.825),
                    rotation = vector3(0.0, 5.0, 320.0),
                },
            },
            cam = {
                offset = vector3(0.0, -0.15, 2.23),
            },
            grids = {
                bud_grid = {
                    startOffset = vector3(-0.9, 0.35, 0.0),
                    startRotation = vector3(0.0, 0.0, 270.0),
                    rowGap = 0.075,
                    colGap = 0.075,
                    maxCol = 8,
                    maxRow = 10,
                },
                paper_grid = {
                    startOffset = vector3(-0.9, -0.325, 0.0),
                    startRotation = vector3(0.0, 0.0, 270.0),
                    rowGap = 0.04,
                    colGap = 0.085,
                    maxCol = 2,
                    maxRow = 20,
                },
            },
        },
    },
    Tables = {
        {
            id = 1,
            name = 'Table 1',
            coords = vector3(935.94, -1521.67, 31.08),
            heading = 180.01,
            type = 'joint_table',
        },
        {
            id = 2,
            name = 'Table 2',
            coords = vector3(941.40, -1513.09, 31.19),
            heading = 92.01,
            type = 'joint_table',
        },
    },
    
    Plant_Cam_Settings = {
        offset = vector3(0.0, 1.25, 2.5),
        cam_offset = vector3(0.0, 0.0, 1.0),
    },

    MudObject = `mud_decal_farming`,

    PlantObjects = {
        [1] = `bkr_prop_weed_01_small_01a`,
        [2] = `bkr_prop_weed_01_small_01b`,
        [3] = `bkr_prop_weed_med_01a`,
        [4] = `bkr_prop_weed_med_01b`,
        [5] = `bkr_prop_weed_lrg_01a`,
        [6] = `bkr_prop_weed_lrg_01b`
    },

    MaterialQualities = {
        [`ROCK_9`] = { min = 40, max = 60 },
        [`ROCK_MOSSY_10`] = { min = 40, max = 60 },
        [`STONE_11`] = { min = 40, max = 60 },
        [`COBBLESTONE_12`] = { min = 40, max = 60 },
        [`SANDSTONE_SOLID_16`] = { min = 40, max = 60 },
        [`SANDSTONE_BRITTLE_17`] = { min = 40, max = 60 },
        [`SAND_LOOSE_18`] = { min = 40, max = 60 },
        [`SAND_COMPACT_19`] = { min = 40, max = 60 },
        [`SAND_WET_20`] = { min = 40, max = 60 },
        [`SAND_TRACK_21`] = { min = 40, max = 60 },
        [`SAND_DRY_DEEP_23`] = { min = 40, max = 60 },
        [`SAND_WET_DEEP_24`] = { min = 40, max = 60 },
        [`ICE_24`] = { min = 40, max = 60 },
        [`SNOW_LOOSE_26`] = { min = 40, max = 60 },
        [`SNOW_COMPACT_27`] = { min = 40, max = 60 },
        [`SNOW_DEEP_28`] = { min = 40, max = 60 },
        [`GRAVEL_SMALL_31`] = { min = 40, max = 60 },
        [`GRAVEL_LARGE_32`] = { min = 40, max = 60 },
        [`GRAVEL_DEEP_33`] = { min = 40, max = 60 },
        [`DIRT_TRACK_35`] = { min = 40, max = 60 },
        [`MUD_HARD_36`] = { min = 40, max = 60 },
        [`MUD_SOFT_38`] = { min = 40, max = 60 },
        [`MUD_DEEP_40`] = { min = 40, max = 60 },
        [`MARSH_41`] = { min = 40, max = 60 },
        [`MARSH_DEEP_42`] = { min = 40, max = 60 },
        [`SOIL_43`] = { min = 40, max = 60 },
        [`CLAY_HARD_44`] = { min = 40, max = 60 },
        [`CLAY_SOFT_45`] = { min = 40, max = 60 },
        [`GRASS_LONG_46`] = { min = 40, max = 60 },
        [`GRASS_47`] = { min = 40, max = 60 },
        [`GRASS_SHORT_4`] = { min = 40, max = 60 },
    },
}

Citizen.CreateThread(function()
    Citizen.Wait(1)
    SendReactMessage('setConfig', Config)
end)
```

### server_config.lua

```lua
Config = {
    PhotoType = "steam",
    NoImage = "https://cdn.discordapp.com/attachments/736562375062192199/995301291976831026/noimage.png",
    DiscordBotToken = "YOUR_DISCORD_BOT_TOKEN",
    -- Notify = function(source, message)
        
    -- end, -- Uncomment this line and paste your export to enable custom notifications

    Seed_Item = "weed_skunk_seed",
    Bud_Item = "crack_baggy",
    Paper_Item = "rolling_paper",
    Joint_Item = "joint",

    Joint_Price = 50, -- the amount of moeny to earn on sell


    GrowthMultiplier = 1, -- the growth rate of the plant

    PedChances = {
        -- if ped does not exist it definetely will not buy and call cops
        -- if ped exists, it will have a chance to buy
        -- if ped exist and dont buy, it wont call cops

        [`g_m_y_ballaeast_01`] = 90,
        [`g_m_y_ballaorig_01`] = 90,
        [`g_m_y_ballasout_01`] = 90,
        [`g_m_y_famca_01`] = 90,
        [`g_m_y_famdnf_01`] = 90,
        [`g_m_y_famfor_01`] = 90,
        [`g_m_y_korean_01`] = 90,
        [`g_m_y_korean_02`] = 90,
        [`g_m_y_lost_01`] = 90,
        [`g_m_y_lost_02`] = 90,
        [`g_m_y_lost_03`] = 90,
        [`g_m_y_mexgoon_01`] = 90,
        [`g_m_y_mexgoon_02`] = 90,
        [`g_m_y_mexgoon_03`] = 90,
        [`g_m_y_mexthug_01`] = 90,
        [`g_m_y_mexthug_02`] = 90,
        [`g_m_y_salvaboss_01`] = 90,
        [`g_m_y_salvagoon_01`] = 90,
        [`g_m_y_salvagoon_02`] = 90,
        [`g_m_y_salvagoon_03`] = 90,
        [`g_m_y_strpunk_01`] = 90,
        [`g_m_y_strpunk_02`] = 90,
        [`g_m_y_vagos_01`] = 90,
        [`g_m_y_vagos_02`] = 90,
        [`g_m_y_vagos_03`] = 90,
        [`g_m_y_ballaeast_01`] = 90,
        [`g_m_y_ballaorig_01`] = 90,
        [`g_m_y_ballasout_01`] = 90,
        [`g_m_y_famca_01`] = 90,
        [`g_m_y_famdnf_01`] = 90,
        [`g_m_y_famfor_01`] = 90,
        [`g_m_y_korean_01`] = 90,
        [`g_m_y_korean_02`] = 90,
        [`g_m_y_lost_01`] = 90,
        [`g_m_y_lost_02`] = 90,
    }

}
```

---

## Events

### Client Events

```lua
-- gfx-weed:client:openTable
TriggerEvent('gfx-weed:client:openTable', ...)

-- gfx-weed:plant:place
TriggerEvent('gfx-weed:plant:place', ...)

-- gfx-weed:sync:addWeed
TriggerEvent('gfx-weed:sync:addWeed', ...)

-- gfx-weed:sync:deleteWeed
TriggerEvent('gfx-weed:sync:deleteWeed', ...)

-- gfx-weed:sync:syncWeed
TriggerEvent('gfx-weed:sync:syncWeed', ...)

```

### Server Events

```lua
-- gfx-weed:server:syncWeed
TriggerServerEvent('gfx-weed:server:syncWeed', ...)

```

---

## Exports

```lua
exports['gfx-weed']:codem-inventory(...)
exports['gfx-weed']:es_extended(...)
exports['gfx-weed']:gfx-inventory(...)
exports['gfx-weed']:ghmattimysql(...)
exports['gfx-weed']:ox_inventory(...)
exports['gfx-weed']:oxmysql(...)
exports['gfx-weed']:ps-inventory(...)
exports['gfx-weed']:qb-core(...)
exports['gfx-weed']:qb-inventory(...)
exports['gfx-weed']:qs-inventory(...)
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/cancelsell` | - |
| `/clearWeeds` | - |
| `/dbgweed` | - |
| `/obj` | - |
| `/weed` | - |
| `/weedprint` | - |

---

## Callbacks

```lua
-- gfx-weed:debug:setWeedValue
TriggerCallback('gfx-weed:debug:setWeedValue', function(result)
    -- handle result
end)

-- gfx-weed:destroy
TriggerCallback('gfx-weed:destroy', function(result)
    -- handle result
end)

-- gfx-weed:fertilize
TriggerCallback('gfx-weed:fertilize', function(result)
    -- handle result
end)

-- gfx-weed:harvest
TriggerCallback('gfx-weed:harvest', function(result)
    -- handle result
end)

-- gfx-weed:harvest:seeds
TriggerCallback('gfx-weed:harvest:seeds', function(result)
    -- handle result
end)

-- gfx-weed:HasEnoughWeed
TriggerCallback('gfx-weed:HasEnoughWeed', function(result)
    -- handle result
end)

-- gfx-weed:hasItem
TriggerCallback('gfx-weed:hasItem', function(result)
    -- handle result
end)

-- gfx-weed:plant
TriggerCallback('gfx-weed:plant', function(result)
    -- handle result
end)

-- gfx-weed:RequestSell
TriggerCallback('gfx-weed:RequestSell', function(result)
    -- handle result
end)

-- gfx-weed:server:getBudAmount
TriggerCallback('gfx-weed:server:getBudAmount', function(result)
    -- handle result
end)

-- gfx-weed:server:getPaperAmount
TriggerCallback('gfx-weed:server:getPaperAmount', function(result)
    -- handle result
end)

-- gfx-weed:server:rollJoint
TriggerCallback('gfx-weed:server:rollJoint', function(result)
    -- handle result
end)

-- gfx-weed:sync:getCoords
TriggerCallback('gfx-weed:sync:getCoords', function(result)
    -- handle result
end)

-- gfx-weed:water
TriggerCallback('gfx-weed:water', function(result)
    -- handle result
end)

```

---

## Features

- ✅ NUI Interface
- ✅ Client-side
- ✅ Server-side

---

## Source

- **GitHub:** https://github.com/gfx-fivem/gfx-weed
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
