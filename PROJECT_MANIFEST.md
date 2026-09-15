# 🎮 DREAMWORLDS — PROJECT MANIFEST

**Slogan:** "Build what you imagine."

---

## 📋 PROJECT INFORMATION

| Field | Value |
|-------|-------|
| **Project Name** | DreamWorlds |
| **Platform** | Roblox Studio |
| **Repository** | `nicolasvandenbossche4-cmd/dreamworlds-roblox` |
| **Visibility** | Public |
| **Created** | 2026-09-15 |
| **Status** | PHASE 0 — AUDIT |

---

## 🎯 CURRENT PHASE

**PHASE 0 — AUDIT DU PROJET ACTUEL**

- [ ] Inspection du projet Roblox Studio existant
- [ ] Identification de la structure Explorer
- [ ] Inventaire des scripts, services, et systèmes
- [ ] Détection des doublons et inefficacités
- [ ] Création du manifeste détaillé
- [ ] Checkpoint initial

---

## 🏗️ ARCHITECTURE STATUS

### Target Architecture Structure

```
ReplicatedStorage
└── DreamWorlds
    ├── Shared
    │   ├── Config
    │   ├── Types
    │   ├── Utilities
    │   └── Constants
    ├── Remotes
    └── Assets

ServerScriptService
└── DreamWorlds
    ├── Services
    │   ├── PlayerService
    │   ├── DataService
    │   ├── EconomyService
    │   ├── PlotService
    │   ├── BuildService
    │   ├── InventoryService
    │   ├── QuestService
    │   ├── VotingService
    │   ├── DiscoveryService
    │   ├── ContestService
    │   ├── ShopService
    │   ├── AchievementService
    │   ├── SocialService
    │   ├── MonetizationService
    │   ├── WeatherService
    │   └── NotificationService
    └── ServerMain

ServerStorage
└── DreamWorlds
    ├── BuildAssets
    ├── PlotTemplates
    └── ServerOnlyAssets

StarterPlayer
└── StarterPlayerScripts
    └── DreamWorlds
        ├── Controllers
        ├── BuildController
        ├── UIController
        ├── CameraController
        └── InputController

StarterGui
└── DreamWorldsUI

Workspace
└── DreamWorlds
    ├── Hub
    ├── Plots
    ├── Environment
    ├── Spawn
    └── Temporary
```

### Current Architecture Status

- **Status**: NOT YET INSPECTED (awaiting project access)
- **Existing Services**: UNKNOWN
- **Existing Scripts**: UNKNOWN
- **Existing Configs**: UNKNOWN
- **Reusable Components**: UNKNOWN

---

## 📦 SYSTEMS INVENTORY

### CREATED

*(None yet — PHASE 0 in progress)*

### EXISTING

*(Awaiting inspection)*

### MODIFIED

*(None yet)*

### BLOCKED

- **Roblox Studio Project Access**: Cannot inspect actual .rbxl file structure without direct access
- **ACTION REQUIRED**: Provide project file or describe existing structure

---

## 📊 DEVELOPMENT PHASES ROADMAP

| Phase | Name | Status | Priority |
|-------|------|--------|----------|
| 0 | Audit | 🔄 IN PROGRESS | CRITICAL |
| 1 | Foundations | ⏳ PENDING | CRITICAL |
| 2 | Plot System | ⏳ PENDING | CRITICAL |
| 3 | Build Core | ⏳ PENDING | CRITICAL |
| 4 | Build Advanced | ⏳ PENDING | HIGH |
| 5 | Inventory + Catalog | ⏳ PENDING | HIGH |
| 6 | Economy + Progression | ⏳ PENDING | HIGH |
| 7 | DataStore | ⏳ PENDING | CRITICAL |
| 8 | Quests + Rewards | ⏳ PENDING | HIGH |
| 9 | Social + Visits | ⏳ PENDING | MEDIUM |
| 10 | Discovery | ⏳ PENDING | MEDIUM |
| 11 | Contests | ⏳ PENDING | MEDIUM |
| 12 | UI/UX Advanced | ⏳ PENDING | HIGH |
| 13 | Environment | ⏳ PENDING | LOW |
| 14 | Blueprints | ⏳ PENDING | MEDIUM |
| 15 | DreamMarket | ⏳ PENDING | LOW |
| 16 | Monetization | ⏳ PENDING | LOW |
| 17 | Optimization | ⏳ PENDING | HIGH |
| 18 | Security Audit | ⏳ PENDING | CRITICAL |
| 19 | Final Acceptance Tests | ⏳ PENDING | CRITICAL |

---

## 🔧 CONFIGURATION MODULES

| Config | Location | Status | Purpose |
|--------|----------|--------|---------|
| GameConfig | `ReplicatedStorage/DreamWorlds/Shared/Config` | ⏳ PENDING | Core game settings |
| BuildConfig | `ReplicatedStorage/DreamWorlds/Shared/Config` | ⏳ PENDING | Build system parameters |
| PlotConfig | `ReplicatedStorage/DreamWorlds/Shared/Config` | ⏳ PENDING | Plot settings & limits |
| EconomyConfig | `ReplicatedStorage/DreamWorlds/Shared/Config` | ⏳ PENDING | Economy & currency |
| ItemsConfig | `ReplicatedStorage/DreamWorlds/Shared/Config` | ⏳ PENDING | Catalog & items |
| QuestConfig | `ReplicatedStorage/DreamWorlds/Shared/Config` | ⏳ PENDING | Quests & rewards |
| UIConfig | `ReplicatedStorage/DreamWorlds/Shared/Config` | ⏳ PENDING | UI settings |

---

## 🎯 CRITICAL BUILD SYSTEM REQUIREMENTS

The Build System is the **ABSOLUTE CORE** of DreamWorlds.

Must Support:
- ✅ Selection (single & multiple)
- ✅ Movement with snapping
- ✅ Rotation (precise modes)
- ✅ Duplication
- ✅ Deletion
- ✅ Resizing (where compatible)
- ✅ Recoloring
- ✅ Material changing
- ✅ Grouping/Ungrouping
- ✅ Copy/Paste
- ✅ Alignment (H/V)
- ✅ Distribution
- ✅ Undo/Redo
- ✅ Server-side validation
- ✅ Ghost preview
- ✅ Red/Green validation
- ✅ Collision detection
- ✅ Terrain boundary checking

---

## 🔐 SECURITY NOTES

**Server Authority Absolute:**
- Client CANNOT modify economy
- Client CANNOT grant itself items
- Client CANNOT build on another player's plot
- Client CANNOT bypass permissions

**Validation Stack:**
```
Client Request → Server Validation → Server Execution → Persistent Result
```

---

## 💾 DATASTORE NOTES

**What Gets Saved:**
- Player currency (DreamCoins, DreamGems)
- Experience & level
- Inventory & unlocks
- Plot data (objects, positions, rotations, colors, materials)
- Permissions
- Achievements
- Statistics
- Blueprint templates

**What Does NOT Get Saved:**
- Temporary instances
- Runtime references
- Computed values
- Client-only state

---

## 📈 PERFORMANCE LIMITS

| Limit | Value | Configurable |
|-------|-------|--------------|
| MaxObjectsPerPlot | TBD | YES |
| MaxPartsPerPlot | TBD | YES |
| MaxPartsPerObject | TBD | YES |
| MaxHeight | TBD | YES |
| MaxPlotSize | TBD | YES |
| MaxBlueprintSize | TBD | YES |
| MaxHistoryActions | TBD | YES |
| MaxRemoteRequests | TBD | YES |
| MaxBatchOperationSize | TBD | YES |
| MaxInteractionDistance | TBD | YES |
| MaxSavedDataSize | TBD | YES |

---

## 🎮 MVP CHECKLIST

Before advanced features, MVP must include:
- [ ] Hub & Spawn
- [ ] Plot attribution
- [ ] Build core (place, move, rotate, delete, duplicate)
- [ ] Undo/Redo
- [ ] Basic catalog
- [ ] Inventory/unlocks
- [ ] DreamCoins & XP
- [ ] Levels
- [ ] Save/Load
- [ ] Permissions
- [ ] Main UI
- [ ] Basic quests
- [ ] Basic discovery
- [ ] Visits
- [ ] Likes/appreciation
- [ ] End-to-end testing

---

## 🧪 TESTING PHASES

| Phase | Scope | Status |
|-------|-------|--------|
| Unit Tests | Individual systems | ⏳ PENDING |
| Integration Tests | System interdependencies | ⏳ PENDING |
| Acceptance Tests | New player flow | ⏳ PENDING |
| Multiplayer Tests | Multiple concurrent players | ⏳ PENDING |
| Security Tests | Exploit attempts | ⏳ PENDING |
| Load Tests | Performance limits | ⏳ PENDING |
| Persistence Tests | SaveLoad cycles | ⏳ PENDING |

---

## 📝 KNOWN ISSUES

*(None documented yet — PHASE 0 in progress)*

---

## ⚙️ DEPENDENCIES

**Critical Dependencies Order:**
1. GameConfig → all systems
2. BuildConfig → Build System
3. PlotConfig → Plot System
4. EconomyConfig → Economy System
5. ItemsConfig → Inventory & Catalog
6. Build System → everything else

---

## 🚀 NEXT STEPS

### IMMEDIATE (Phase 0 - Audit)

1. **Describe current Roblox Studio project state**
   - Is it blank/new?
   - Does it have existing systems?
   - What scripts/services exist?

2. **Update this manifest with findings**

3. **Create detailed inventory**

4. **Identify reusable components**

5. **Create CHECKPOINT_PHASE0.md**

### AFTER AUDIT (Phase 1 - Foundations)

1. Create directory structure in ReplicatedStorage
2. Create GameConfig module
3. Create BuildConfig module
4. Create PlotConfig module
5. Create core Constants
6. Create core Utilities
7. Create Remotes folder structure
8. Initialize server main script
9. Test basic connectivity

---

## 📎 RELATED DOCUMENTS

- `CHECKPOINT_PHASE0.md` *(to be created)*
- `ARCHITECTURE.md` *(to be created)*
- `CONFIGS_REFERENCE.md` *(to be created)*
- `REMOTES_DOCUMENTATION.md` *(to be created)*

---

## 🔄 MANIFEST VERSION

| Version | Date | Change |
|---------|------|--------|
| 0.1 | 2026-09-15 | Initial creation — PHASE 0 |

---

**Last Updated:** 2026-09-15 | **Status:** PHASE 0 IN PROGRESS | **Next Review:** After audit completion
