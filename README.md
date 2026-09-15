# DreamWorlds Roblox Development Repository

**"Build what you imagine."**

## Overview

DreamWorlds is a comprehensive Roblox building game featuring:
- 🏗️ Advanced build system with placement, rotation, duplication, and more
- 💰 Economy system with DreamCoins and progression
- 📍 Private plot system with permissions
- 🎯 Quests, achievements, and daily rewards
- 🌍 Discovery system and community features
- 🏆 Contests with voting and rankings
- 🔧 Blueprints for save/load building templates
- 🛒 DreamMarket for community sharing
- 📊 Complete progression system
- 🔐 Server-side validation and security

## Quick Start

### For Developers

1. **Read the Project Manifest:**
   ```
   PROJECT_MANIFEST.md
   ```
   This document tracks the entire development status.

2. **Understand the Architecture:**
   ```
   docs/ARCHITECTURE_OVERVIEW.md
   ```

3. **Check Phase 0 Audit:**
   ```
   PHASE0_AUDIT_CHECKLIST.md
   ```

### Current Phase

**PHASE 0 — AUDIT & FOUNDATION**

- [x] Repository created
- [x] Architecture defined
- [x] Core configurations created
- [ ] Roblox project audit completed
- [ ] Checkpoint created

## Repository Structure

```
dreamworlds-roblox/
├── PROJECT_MANIFEST.md              (Development status tracker)
├── PHASE0_AUDIT_CHECKLIST.md        (Audit template)
├── README.md                         (This file)
├── docs/
│   └── ARCHITECTURE_OVERVIEW.md     (High-level architecture)
├── src/
│   ├── shared/
│   │   ├── Config/                  (Centralized game configs)
│   │   ├── Types/                   (Type definitions - TODO)
│   │   ├── Utilities/               (Shared helpers - TODO)
│   │   └── Constants/               (Game constants - TODO)
│   ├── server/
│   │   ├── Services/                (Server services - TODO)
│   │   └── ServerMain.lua           (Initializer - TODO)
│   └── client/
│       ├── Controllers/             (Client controllers - TODO)
│       └── ClientMain.lua           (Client initializer - TODO)
└── tests/
    └── (Test files - TODO)
```

## Configuration Files

All game configurations are centralized:

- **GameConfig.lua** — Global game settings
- **BuildConfig.lua** — Build system parameters
- **PlotConfig.lua** — Plot system settings
- **EconomyConfig.lua** — Currency and rewards
- **ItemsConfig.lua** — Catalog items *(to be created)*
- **QuestConfig.lua** — Quests and tasks *(to be created)*

## Development Rules

### Critical Principles

1. **Server Authority**: Client cannot modify economy, permissions, or persistent data
2. **No Duplicates**: Never create two systems with the same responsibility
3. **Validation First**: Every remote request must be validated server-side
4. **Test Everything**: Features are complete only when tested
5. **Phase Order**: Follow the dependency chain strictly

### Build System Priority

The Build System is the **CORE** of DreamWorlds. It must be:
- ✅ Robust
- ✅ User-friendly
- ✅ Server-validated
- ✅ Performance-optimized
- ✅ Anti-cheat protected

## Phases

| Phase | Name | Status | Priority |
|-------|------|--------|----------|
| 0 | Audit | 🔄 IN PROGRESS | CRITICAL |
| 1 | Foundations | ⏳ PENDING | CRITICAL |
| 2 | Plot System | ⏳ PENDING | CRITICAL |
| 3 | Build Core | ⏳ PENDING | CRITICAL |
| 4 | Build Advanced | ⏳ PENDING | HIGH |
| 5+ | See PROJECT_MANIFEST.md | ⏳ PENDING | VARIES |

## Next Steps

👉 **AWAITING**: Audit of Roblox Studio project

Please describe your current Roblox project state in PHASE0_AUDIT_CHECKLIST.md

## Security Note

🔒 **This project implements strict server-side validation:**
- Client requests are NEVER trusted
- All economy transactions are server-verified
- Build operations are permission-checked
- Rate limiting prevents abuse
- Data is validated before persistence

## License

MIT License - See LICENSE file

---

**Last Updated:** 2026-09-15  
**Current Phase:** PHASE 0 — AUDIT  
**Status:** In Progress
