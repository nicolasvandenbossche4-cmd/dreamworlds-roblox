# DreamWorlds — Architecture Overview

## 🏗️ High-Level Structure

```
DreamWorlds (Root Container)
├── ReplicatedStorage/DreamWorlds/
│   ├── Shared/Config/          (All game configurations)
│   ├── Shared/Types/           (Type definitions)
│   ├── Shared/Utilities/       (Shared helper functions)
│   ├── Shared/Constants/       (Game constants)
│   ├── Remotes/                (RemoteEvents & RemoteFunctions)
│   └── Assets/                 (Shared game assets)
│
├── ServerScriptService/DreamWorlds/
│   ├── Services/               (All server services)
│   │   ├── PlayerService.lua
│   │   ├── DataService.lua
│   │   ├── EconomyService.lua
│   │   ├── PlotService.lua
│   │   ├── BuildService.lua
│   │   ├── InventoryService.lua
│   │   ├── QuestService.lua
│   │   ├── VotingService.lua
│   │   ├── DiscoveryService.lua
│   │   ├── ContestService.lua
│   │   ├── ShopService.lua
│   │   ├── AchievementService.lua
│   │   ├── SocialService.lua
│   │   ├── MonetizationService.lua
│   │   ├── WeatherService.lua
│   │   └── NotificationService.lua
│   └── ServerMain.lua          (Service initializer)
│
├── ServerStorage/DreamWorlds/
│   ├── BuildAssets/            (Server-only build templates)
│   ├── PlotTemplates/          (Plot spawn templates)
│   └── ServerOnlyAssets/       (Private game assets)
│
├── StarterPlayer/StarterPlayerScripts/DreamWorlds/
│   ├── Controllers/
│   │   ├── BuildController.lua
│   │   ├── UIController.lua
│   │   ├── CameraController.lua
│   │   └── InputController.lua
│   └── ClientMain.lua          (Client initializer)
│
├── StarterGui/DreamWorldsUI/   (All UI ScreenGuis)
│   ├── BuildMenu.lua
│   ├── ProfileUI.lua
│   ├── DiscoveryUI.lua
│   ├── etc...
│
└── Workspace/DreamWorlds/
    ├── Hub/                    (Main hub world)
    ├── Plots/                  (Player plots)
    ├── Environment/            (Decorative world)
    ├── Spawn/                  (Spawn area)
    └── Temporary/              (Runtime instances)
```

## 🔀 Data Flow

### Build Action Flow
```
Client Input
    ↓
BuildController (preview)
    ↓
RemoteEvent:PlaceObject → Server
    ↓
BuildService (validation)
    ↓
PlotService (permission check)
    ↓
DataService (persist)
    ↓
Broadcast to clients
    ↓
UI Update
```

### Economy Flow
```
Action (build, quest, visit, etc)
    ↓
Service calculates reward
    ↓
EconomyService processes
    ↓
DataService saves
    ↓
Client notified
```

## 🔐 Authority

**CLIENT CANNOT:**
- Modify economy
- Grant items
- Build on others' plots
- Change permissions
- Create rewards
- Vote for self

**SERVER MUST:**
- Validate all requests
- Maintain authority
- Persist all data
- Calculate rewards
- Check permissions
- Reject invalid operations

## 📡 Service Responsibilities

| Service | Responsibility |
|---------|----------------|
| PlayerService | Player state, joins, leaves |
| DataService | Save/load all player data |
| EconomyService | Currency, rewards, transactions |
| PlotService | Plot allocation, permissions |
| BuildService | Object placement, validation |
| InventoryService | Items, unlocks, collections |
| QuestService | Quest tracking, completion |
| VotingService | Contest votes, anti-cheat |
| DiscoveryService | Ranking, recommendations |
| ContestService | Contest management |
| ShopService | Item selling |
| AchievementService | Achievement tracking |
| SocialService | Follows, favorites, reputation |
| MonetizationService | Developer product handling |
| WeatherService | Environment cycling |
| NotificationService | Player notifications |

## 🚀 Initialization Order

1. DataService (must be first)
2. EconomyService
3. PlotService
4. BuildService
5. InventoryService
6. PlayerService
7. All other services

## 🧪 Testing Points

- Each service independently
- Service interdependencies
- Remote events validation
- Permission checks
- Data persistence
- Multiplayer scenarios
