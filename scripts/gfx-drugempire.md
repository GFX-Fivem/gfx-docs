# GFX Drug Empire

A premium all-in-one drug empire system for FiveM. Players grow weed with real genetics, cook meth using temperature-controlled lab minigames, process cocaine through multi-step chemical workflows, mix custom strains with 15 ingredients, run NPC dealers, capture territory zones, launder dirty money through owned businesses, and manage everything from a burner-phone NUI interface.

---

## Info

| Key | Value |
|-----|-------|
| **Resource name** | `gfx-drugempire` |
| **Frameworks** | ESX / QBCore / Standalone (detected via `gfx-lib`) |
| **Database** | MySQL (oxmysql / mysql-async / ghmattimysql) |
| **Lua version** | 5.4 |
| **Sides** | Client + Server |
| **NUI** | Yes (React + Vite, burner-phone interface) |

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| **gfx-lib** | Framework detection, callbacks, SQL abstraction, inventory, money, notifications |
| **oxmysql** | Default database driver (can be swapped via `gfx-lib` SQL abstraction) |
| `/assetpacks` | FiveM asset pack dependency declared in `fxmanifest.lua` |

---

## Installation

### 1. Import the SQL schema

Run `sql/install.sql` against your database. The script also auto-creates all tables on first start. The following tables are created:

| Table | Purpose |
|-------|---------|
| `drugempire_plants` | Weed plant state (stage, health, water, genetics, etc.) |
| `drugempire_meth_labs` | Meth lab state per location |
| `drugempire_coke_spots` | Coke processing spot state per location |
| `drugempire_dispensaries` | Player-owned dispensary data |
| `drugempire_territories` | Territory control records |
| `drugempire_sales` | Sale history for market analytics and heat tracking |
| `drugempire_recipes` | Player-discovered mixing recipes |
| `drugempire_reputation` | Player empire data (rep, level, heat, dirty money) |
| `drugempire_laundering` | Player-owned laundering business state |
| `drugempire_dealers` | Hired NPC dealer records |
| `drugempire_stashes` | Player-owned stash house records |
| `drugempire_customers` | Customer relationship tracking |

### 2. Copy files

Place the `gfx-drugempire` folder into your server's resources directory.

### 3. server.cfg

```cfg
ensure gfx-lib
ensure gfx-drugempire
```

`gfx-lib` must start before `gfx-drugempire`.

### 4. Configure

Edit `config/client.lua` and `config/server.lua` for item names, lab coordinates, pricing, heat values, and territory zones. See the Configuration section below.

---

## Configuration

Configuration is split across four files:

- `config/shared.lua` — `SharedConfig`: drug types, genetics, plant stages, quality tiers, mixing ingredients, effects, reputation levels, laundering businesses
- `config/client.lua` — `Config`: UI theme, weed interaction settings, lab/location props, selling/heat display, empire interaction coords
- `config/server.lua` — `ServerConfig`: yields, prices, server-side timing, order generation, dealer AI, dispensary economy
- `config/locale.lua` — `Locale.Strings`: all displayed text strings

### config/client.lua — General

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.PlayerLoadedEvent` | string | `"playerSpawned"` | Event name that signals the player has spawned and the resource should sync |
| `Config.Decrease_Player_Alpha` | boolean | `true` | Reduce player transparency during certain interactions |
| `Config.Debug` | boolean | `false` | Enable client-side debug prints |
| `Config.Theme` | table | see below | NUI color theme (primary, secondary, opacity variants) |

### Config.Theme

| Key | Default |
|-----|---------|
| `primary` | `'#E91E63'` (pink) |
| `primary-content` | `'#880E4F'` |
| `primary-opacity` | `"rgba(233, 30, 99, 0.2)"` |
| `secondary` | `"#9C27B0"` |
| `secondary-content` | `'#4A148C'` |
| `secondary-opacity` | `"rgba(156, 39, 176, 0.2)"` |

### Config.Weed (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `SeedItem` | string | `"weed_seed"` | Inventory item name for seeds |
| `BudItem` | string | `"weed_bud"` | Inventory item name for harvested buds |
| `WaterItem` | string | `"water_bottle"` | Item required to water plants |
| `FertilizerItem` | string | `"fertilizer"` | Item required to fertilize plants |
| `TrimmerItem` | string | `"scissors"` | Item required to trim plants |
| `PaperItem` | string | `"rolling_paper"` | Item required to roll joints |
| `JointItem` | string | `"joint"` | Rolled joint item name |
| `DriedBudItem` | string | `"dried_weed"` | Dried bud item name |
| `Plant_Detect_Distance` | number | `30.0` | Distance (units) at which plants render/despawn |
| `Plant_Interact_Distance` | number | `2.5` | Distance (units) at which the interact prompt shows |
| `MaterialQualities` | table | see source | Surface material hash → quality range `{ min, max }` for planting |

### Config.Meth (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PseudoItem` | string | `"pseudoephedrine"` | Pseudoephedrine item name |
| `MethylamineItem` | string | `"methylamine"` | Methylamine item name |
| `AcidItem` | string | `"muriatic_acid"` | Muriatic acid item name |
| `CrystalItem` | string | `"meth_crystal"` | Raw crystal item name |
| `BagItem` | string | `"meth_bag"` | Packaged meth item name |
| `OptimalTemp` | number | `185` | Optimal cooking temperature (°C) for crystal formation |
| `TempTolerance` | number | `15` | Allowed ±°C deviation from optimal |
| `OverheatTemp` | number | `220` | Temperature at which the batch is ruined |
| `ExplosionTemp` | number | `260` | Temperature that causes an explosion |
| `CookTime` | number | `30` | Duration (seconds) of the cooking phase |
| `Labs` | table | 2 entries | Lab spawn locations (`{ id, name, coords, heading }`) |

### Config.Coke (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `CocaLeafItem` | string | `"coca_leaf"` | Coca leaf item name |
| `GasolineItem` | string | `"gasoline"` | Gasoline item name |
| `CementItem` | string | `"baking_soda"` | Baking soda item name |
| `CokePasteItem` | string | `"coke_paste"` | Intermediate paste item name |
| `CokeBrickItem` | string | `"coke_brick"` | Compressed brick item name |
| `CokeBagItem` | string | `"coke_bag"` | Final packaged product item name |
| `GrindTime` | number | `10` | Seconds to grind coca leaves |
| `WashTime` | number | `15` | Seconds for chemical wash step |
| `DryTime` | number | `20` | Seconds to dry the paste |
| `PressTime` | number | `10` | Seconds to press brick |
| `LeavesPerBatch` | number | `5` | Coca leaves consumed per batch |
| `ProcessingSpots` | table | 2 entries | Processing location coords (`{ id, name, coords, heading }`) |

### Config.Selling (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `HeatDecayRate` | number | `1` | Heat points lost per real minute |
| `MaxHeat` | number | `100` | Maximum heat value before cops auto-dispatch |
| `HeatPerSale` | number | `5` | Heat gained per street sale |
| `CopCallChance` | number | `15` | Percentage chance per delivery that cops are called |
| `Territories` | table | 2 entries | Territory zone definitions (`{ id, name, center, radius, bonus }`) |

### Config.Orders (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `DeliveryDistance` | number | `5.0` | Units the player must be within to complete a delivery |
| `BuyerModels` | table | 10 entries | Ped model hashes used for buyer NPCs at delivery points |
| `DeliveryLocations` | table | 15 entries | Named delivery drop-off coordinates |
| `Blip.sprite` | number | `501` | Map blip sprite index for active deliveries |
| `Blip.color` | number | `5` | Map blip color index |
| `Blip.name` | string | `"Drug Delivery"` | Blip display name |

### Config.Dealers (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `HireCost` | number | `5000` | Cost to hire a new NPC dealer |
| `Locations` | table | 4 entries | Dealer hire NPC spawn locations |

### Config.Mixing (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `MixTime` | number | `10` | Duration (seconds) of the mixing animation |
| `Locations` | table | 2 entries | Mixing station coordinates |
| `IngredientProps` | table | 15 entries | Maps ingredient key → prop model hash for 3D placement |
| `BaseDrugProps` | table | `weed/meth/coke` | Base drug prop model hashes for the mixing table |

### Config.Empire (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PhoneItem` | string | `"burner_phone"` | Item name that opens the burner phone NUI when used |
| `PhoneKey` | number | `288` | Control key index (F1) as alternative phone open keybind |
| `StashProp` | hash | `prop_ld_int_safe_01` | Prop model used to mark stash houses |
| `StashInteractDist` | number | `2.0` | Interaction distance for stash houses |
| `Businesses` | table | 3 entries | Laundering business physical locations |
| `StashHouses` | table | 2 entries | Stash house locations with purchase prices |
| `BribeLocations` | table | 2 entries | Police NPC bribe interaction points |
| `HeatTimecycles` | table | 4 entries | Threshold → timecycle modifier mapping for heat visual effects |

### Config.DeadDrop (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `BagProp` | hash | `prop_cs_heist_bag_02` | Prop spawned at dead drop pickup locations |
| `InteractDist` | number | `2.0` | Interaction distance for dead drop bags |
| `Blip.sprite` | number | `478` | Map blip sprite for dead drop locations |
| `Locations` | table | 10 entries | Secret dead drop pickup coordinates |

### Config.Dispensary (client.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Products` | table | 2 entries | Items for sale in the dispensary (`{ item, price, label }`) |
| `Upgrades` | table | 3 entries | Available upgrades: storage, security, display (each with price and maxLevel 3) |
| `CustomerInterval` | table | `{ min=60, max=180 }` | Seconds between NPC customer visits |
| `CustomerSpendMin` | number | `50` | Minimum cash an NPC customer spends |
| `CustomerSpendMax` | number | `200` | Maximum cash an NPC customer spends |
| `Locations` | table | 2 entries | Dispensary physical locations |

### ServerConfig.Weed (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `GrowthMultiplier` | number | `1.0` | Global plant growth speed multiplier |
| `MaxPlantsPerPlayer` | number | `20` | Maximum plants a single player can have active |
| `TickInterval` | number | `1500` | Growth tick interval in milliseconds |
| `BudYieldMin` / `BudYieldMax` | number | `1` / `5` | Bud harvest yield range |
| `SeedYieldMin` / `SeedYieldMax` | number | `1` / `3` | Seed harvest yield range |
| `CrossbreedDistance` | number | `1.5` | Distance (units) at which plants can crossbreed genetics |
| `GeneticsLength` | number | `6` | Number of allele slots in a genetics string |
| `QualityThresholds` | table | 4 entries | Quality bands mapping percentage range → label and price multiplier |

### ServerConfig.Meth (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `IngredientsPerCook` | table | 3 entries | Items and counts consumed per cook |
| `BaseYield` | number | `3` | Minimum product per cook |
| `MaxYield` | number | `8` | Maximum product per cook |
| `PurityFactors` | table | — | Weight of temperature, timing, and ingredient order on purity calculation |
| `Prices` | table | 4 entries | Sale price per quality grade (Low=50, Mid=100, High=200, Crystal Blue=400) |

### ServerConfig.Coke (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `IngredientsPerBatch` | table | 3 entries | Items and counts consumed per batch |
| `PastePerBatch` | number | `2` | Paste items produced per batch |
| `BricksPerPress` | number | `1` | Bricks produced per press |
| `BagsPerBrick` | number | `4` | Bags produced per brick |
| `Prices` | table | 4 entries | Sale price per quality grade (Street=80, Standard=150, Premium=300, Pure=500) |

### ServerConfig.Selling (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `BasePrices` | table | 4 entries | Base sale prices per drug item (`joint`=50, `dried_weed`=100, `meth_bag`=200, `coke_bag`=250) |
| `PriceVariation` | number | `0.2` | ±20% random price variation per sale |
| `PoliceAlertChance` | number | `10` | Percentage chance of police dispatch per delivery |
| `PoliceResponseTime` | number | `60` | Seconds before police arrive after alert |

### ServerConfig.Orders (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `GenerationInterval` | number | `120` | Seconds between order generation attempts |
| `MaxPendingOrders` | number | `3` | Maximum unresponded orders per player |
| `OrderRateByLevel` | table | 5 entries | Order frequency and count per reputation level |
| `DemandWeights` | table | 4 entries | Relative demand weight per drug type |
| `QuantityRange` | table | 4 entries | Min/max quantity per order per drug type |
| `PhonePriceMultiplier` | number | `1.3` | Price premium applied to phone orders over base price |
| `DeliveryTimeout` | number | `600` | Seconds before an accepted delivery expires (10 minutes) |
| `DeliveryDistance` | number | `5.0` | Units player must be within to confirm delivery |
| `DeliveryRepGain` | table | `{ min=5, max=15 }` | Reputation earned per completed delivery |
| `HeatPerDelivery` | number | `3` | Heat added per completed delivery |

### ServerConfig.Mixing (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `MaxIngredientsPerMix` | number | `4` | Maximum ingredients that can be added per mix |
| `BasePrices` | table | `weed/meth/coke` | Base sell prices for mixed products |
| `RarityBonus` | table | 5 tiers | Price multiplier bonus per ingredient rarity (`common`=0, `legendary`=+0.35) |
| `IngredientItems` | table | 15 entries | Ingredient key → inventory item name |
| `MixedItems` | table | 3 entries | Mixed output item names per drug type |

### ServerConfig.Empire (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `DirtyMoneyEnabled` | boolean | `true` | If true, sales produce dirty money that must be laundered; if false, clean money is given directly |
| `ProcessingInterval` | number | `60` | Seconds between laundering processing ticks |
| `ProcessingRate` | number | `500` | Base dirty money processed per tick per business |
| `ProcessingTierMultiplier` | table | `1.0 / 2.0 / 3.5` | Processing rate multiplier per business tier |
| `DirtyMoneyType` | string | `"black_money"` | Dirty money type identifier passed to gfx-lib money functions |
| `CleanMoneyType` | string | `"cash"` | Clean money type identifier |
| `HeatDecayRate` | number | `1` | Heat points lost per real minute |
| `HeatDecayBonusLayLow` | number | `5` | Additional heat decay when no sales for 30 minutes |
| `BribeCost` | table | 3 tiers | Heat reduction and cost per bribe tier |
| `RepGain` | table | 9 actions | Reputation range gained per action type |
| `RepLoss` | table | 3 events | Reputation lost per negative event (arrested, lab explosion, dealer lost) |
| `StashMaxSlots` | number | `50` | Maximum item slots per stash house |
| `LaunderUpgradeCost` | table | tier 2/3 | Multiplier of base price for upgrading business tier |
| `LaunderLimitMultiplier` | table | tier 1/2/3 | Daily laundering limit multiplier per tier |

### ServerConfig.Market (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `RestockInterval` | number | `3600` | Seconds between automatic market restocks |
| `Items` | table | 14 entries | Market items (`id, category, label, price, maxStock, requiredLevel, item, giveAmount`) |

Categories: `seeds`, `chemicals`, `equipment`, `supplies`. Required level ranges from 1–3.

### ServerConfig.Dealers (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `PromotionCost` | number | `5000` | Cost to promote a customer to a dealer |
| `SellInterval` | number | `120` | Seconds between each dealer sell attempt |
| `BaseSellChance` | number | `60` | Base percentage chance per sell attempt |
| `EarningRange` | table | `{ min=30, max=80 }` | Base earnings per dealer sale |
| `HeatPerSale` | number | `1` | Heat added per dealer sale |
| `BustChance` | number | `2` | Percentage per cycle that a dealer gets busted |
| `MaxSkill` | number | `5` | Maximum dealer skill level |

### ServerConfig.Customers (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `RelationshipPerDelivery` | table | `{ min=10, max=25 }` | Relationship points gained per successful delivery |
| `DealerOfferThreshold` | number | `100` | Minimum relationship score before dealer promotion offer can trigger |
| `DealerOfferChance` | number | `15` | Percentage chance per delivery once threshold is met |
| `MaxCustomers` | number | `30` | Maximum tracked customers per player |
| `ReturningCustomerChance` | number | `70` | Percentage chance to reuse an existing customer for new orders |

### ServerConfig.Dispensary (server.lua)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `StoragePerLevel` | table | `{ 50, 100, 200 }` | Dispensary storage capacity per upgrade level |
| `RobberyChanceReduction` | table | `{ 10, 25, 50 }` | Robbery chance reduction (%) per security upgrade level |
| `CustomerBonus` | table | `{ 0, 15, 30 }` | Increased customer frequency (%) per display upgrade level |
| `TaxRate` | number | `0.1` | Tax rate (10%) on dispensary earnings |
| `MaxStoredEarnings` | number | `50000` | Maximum earnings stored before forced collection |

### SharedConfig (shared.lua)

| Option | Type | Description |
|--------|------|-------------|
| `DrugTypes` | table | Constants: `WEED`, `METH`, `COKE` |
| `GeneticAlleles` | table | 5 alleles: G (Growth), Y (Yield), H (Hardiness), P (Potency), X (Null) — each with name and UI color |
| `PlantStages` | table | 6 stages: Seedling → Harvest, each with display name and GTA prop model |
| `MethQualities` | table | 4 quality tiers with purity ranges (0–100%) |
| `CokeQualities` | table | 4 quality tiers with purity ranges (0–100%) |
| `Ingredients` | table | 15 mixing ingredients with rarity and base effects |
| `Effects` | table | 28 effect definitions with price multipliers and types (positive/negative/special) |
| `ChainReactions` | table | 5 bonus combo effects from specific ingredient pairings |
| `BadCombinations` | table | 1 combination that destroys the product |
| `ReputationLevels` | table | 5 levels: Street Dealer → Cartel Boss (min rep, max dealers, max stash, launder slots) |
| `LaunderingBusinesses` | table | 3 business types: car_wash / restaurant / nightclub (price, daily limit, commission, risk) |

---

## Exports

No public Lua exports are defined. All inter-resource communication uses the `gfx-lib` callback system internally. External scripts can listen to the net events listed below.

---

## Events

### Client-Side Net Events (listen from other resources)

| Event | Payload | Description |
|-------|---------|-------------|
| `gfx-drugempire:weed:sync` | `plantsData` (table) | Full plant list synced to the joining client |
| `gfx-drugempire:weed:update` | `data` (plant table) | Single plant data updated on all clients |
| `gfx-drugempire:weed:delete` | `plantId` (string) | Plant removed from client (died or harvested) |
| `gfx-drugempire:empire:repUpdate` | `rep, level, levelName` | Player reputation and level changed |
| `gfx-drugempire:empire:levelUp` | — | Player reached a new reputation level |
| `gfx-drugempire:empire:heatUpdate` | `heat` (number) | Player heat value changed |
| `gfx-drugempire:empire:launderProcessed` | `{ businessId, processed, received, pending }` | Laundering tick processed dirty money |
| `gfx-drugempire:nui:message` | `{ type, text, time }` | New in-game phone message delivered |
| `gfx-drugempire:dealer:spawn` | dealer data | NPC dealer spawned for the client |
| `gfx-drugempire:dealer:remove` | dealer id | NPC dealer removed from the client |
| `gfx-drugempire:dealer:sync` | dealers table | Full dealer list synced |
| `gfx-drugempire:dealer:busted` | dealer id | Dealer busted notification |
| `gfx-drugempire:order:deliveryStarted` | delivery data | Active delivery started |
| `gfx-drugempire:order:deliveryComplete` | delivery data | Delivery successfully completed |
| `gfx-drugempire:order:deliveryFailed` | `{ orderId, reason }` | Delivery failed or timed out |
| `gfx-drugempire:deadDrop:created` | `{ id, locationIndex, label }` | Dead drop created after market purchase |
| `gfx-drugempire:deadDrop:collected` | `{ id }` | Dead drop bag collected |
| `gfx-drugempire:effect:apply` | effect data | Drug effect applied to the local player |
| `gfx-drugempire:notify` | `msg` (string) | Generic notification forwarded from server |

### Server-Side Net Events

| Event | Trigger | Description |
|-------|---------|-------------|
| `gfx-drugempire:playerLoaded` | Client → Server | Signals that the player has spawned; server syncs plants and empire data |

---

## Commands

No player or console commands are registered.

---

## Features

- **Weed growing with genetic system** — Plants have 6-allele genetics strings (Growth, Yield, Hardiness, Potency, Null); adjacent plants crossbreed automatically; surface material affects starting quality
- **6-stage plant lifecycle** — Seedling → Sprout → Vegetative → Mature → Flowering → Harvest; plants die without water and fertilizer
- **Proximity-based plant render** — Plants spawn/despawn based on player distance (configurable detect radius); server growth loop runs continuously
- **Joint rolling minigame** — Drag bud onto rolling paper at dedicated joint-rolling tables; interactive camera-locked NUI workflow
- **Meth cooking with temperature control** — Real-time temperature management; cook within ±15°C of optimal (185°C) for highest purity; overheating ruins the batch; reaching explosion threshold causes an in-world explosion
- **Multi-step cocaine processing** — Grind → wash → dry → press → cut → package; each step has an individual timer and item requirement
- **Ingredient mixing system** — Combine any base drug with up to 4 ingredients out of 15 available (common through legendary rarity); effects influence the final sell price via multipliers (0.6× to 3.0×); chain reactions trigger bonus effects from specific ingredient pairings; bad combinations destroy the batch
- **Player recipe book** — Each unique ingredient combination is saved per player in the database; the NUI phone shows the player's discovered recipes
- **Phone order delivery system** — Server generates drug orders from named NPC customers on a configurable interval; orders arrive as in-game phone messages; accepting spawns a GPS blip and a buyer NPC at the delivery point; 10-minute delivery timer; hand-off animation on completion
- **NPC dealer network** — Hire up to 5 NPC dealers (at Cartel Boss level); dealers auto-sell from their location every 2 minutes; they gain skill and loyalty; can be busted by police; earnings collected in-person
- **Customer relationship system** — Repeat buyers build a relationship score; high-relationship customers can be promoted to dealers
- **Territory control** — Capture configurable territory zones for a percentage bonus on all sales within the zone; zones can be contested and lost
- **5-tier reputation/level system** — Street Dealer → Supplier → Lab Owner → Distributor → Cartel Boss; unlocks more dealer slots, stash houses, and launder slots; lost on arrests and lab explosions
- **Heat system** — Sales, deliveries, and dealer activity generate heat (0–100); high heat triggers timecycle visual effects and police dispatch chance; lays low for 30 minutes for accelerated decay; bribe NPCs to reduce heat
- **Dirty money laundering** — When enabled, sales produce dirty money instead of clean cash; buy car washes, restaurants, or nightclubs to launder it gradually; commission taken per business type; upgradeable to 3 tiers with higher daily limits and processing rates
- **Dead drop supply market** — Purchase seeds, chemicals, and equipment from a burner-phone market; items are delivered to a random secret dead-drop location rather than given directly
- **Stash houses** — Purchase persistent stash locations to store product; ownership checked server-side
- **Dispensary system** — Own a public dispensary that sells joints and dried bud; NPC customers arrive automatically; upgrade storage, security, and display; collect earnings
- **Burner phone NUI** — Full React/TypeScript phone interface: Dashboard, Messages, Market, Recipes, Launder status, Leaderboard; opened by the configured item or F1 key
- **Plant scanner** — Phone scanner screen uses a camera raycast to identify and display genetics/stats of the nearest plant
- **In-game leaderboard** — Top 15 players ranked by reputation displayed in the phone NUI; shows the local player's rank even outside top 15
- **Auto-save and persistence** — Plants saved every ~10 growth ticks and on resource stop; empire data saved on disconnect and every 5 minutes; market stock resets on a configurable interval
- **Framework-agnostic** — Uses `gfx-lib` for all framework calls; compatible with ESX, QBCore, and standalone servers

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Plants not appearing in-world | Verify `Config.Weed.Plant_Detect_Distance` is large enough and that the plant's `health` is above 0. Check the F8 console for errors on plant spawn. |
| Plants not growing | Confirm `gfx-lib` started before `gfx-drugempire` and that the growth loop is running (check server console for `[GFX-DrugEmpire] Started successfully`). Also verify `ServerConfig.Weed.TickInterval` is not set to 0. |
| Meth explosion on startup | Temperature exceeded `Config.Meth.ExplosionTemp` (260°C). Adjust heat more carefully during cooking; aim for ±15°C of the 185°C optimal. |
| Phone not opening | Ensure you have the `burner_phone` item in inventory (configurable via `Config.Empire.PhoneItem`), or press the configured `Config.Empire.PhoneKey` (default F1 = 288). |
| Dead drop bag not spawning | The bag prop may have failed to load. Check that `/assetpacks` is running and that `Config.DeadDrop.BagProp` model exists in the base game. |
| Dirty money not laundering | Check `ServerConfig.Empire.DirtyMoneyEnabled = true`. Ensure you own the business and that its daily limit has not been reached. Wait for the next processing tick (`ServerConfig.Empire.ProcessingInterval` seconds). |
| Delivery order not generating | Ensure `ServerConfig.Orders.GenerationInterval` is reasonable and that the player has fewer than `ServerConfig.Orders.MaxPendingOrders` (default 3) pending orders. |
| Dealer busted immediately | Reduce `ServerConfig.Dealers.BustChance`. Dealers with higher loyalty have a lower bust rate; promote loyalty by keeping dealers hired for longer. |
| Database tables missing | Run `sql/install.sql` manually, or restart the resource — tables are auto-created on startup via `EnsureTables()`. Ensure your SQL driver is running and `gfx-lib` SQL abstraction is configured. |
| Mixing recipe not saving | Verify `drugempire_recipes` table exists. Check for a `UNIQUE KEY` conflict in the server console — the same ingredient combination will not be re-saved. |
| Territory zones not showing | Confirm `Config.Selling.Territories` entries have valid `center` vectors and a non-zero `radius`. Territory capture requires being within the zone. |

---

## Source

- **GitHub:** [https://github.com/gfx-fivem/gfx-drugempire](https://github.com/gfx-fivem/gfx-drugempire)
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
