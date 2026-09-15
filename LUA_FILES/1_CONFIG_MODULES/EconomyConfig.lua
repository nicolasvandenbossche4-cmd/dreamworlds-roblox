-- EconomyConfig.lua
-- Economy and currency configuration
-- Place in: ReplicatedStorage/DreamWorlds/Shared/Config/EconomyConfig

local EconomyConfig = {}

-- CURRENCY TYPES
EconomyConfig.Currencies = {
    DREAMCOINS = "dreamcoins",
    DREAMGEMS = "dreamgems",
}

-- DREAMCOINS REWARDS
EconomyConfig.DreamCoinsRewards = {
    PlaceObject = 10,
    MoveObject = 5,
    RotateObject = 5,
    DeleteObject = 2,
    DuplicateObject = 15,
    CompleteQuest = 100,
    VisitPlot = 20,
    LikePlot = 5,
    ContestWin = 500,
    ContestParticipant = 50,
    DailyLogin = 100,
    LevelUp = 50,
    AchievementUnlock = 30,
}

-- XP REWARDS
EconomyConfig.XPRewards = {
    PlaceObject = 10,
    CompleteQuest = 100,
    LevelUp = 0,
    ContestWin = 200,
    VisitPlot = 10,
    LikePlot = 5,
}

-- LEVEL PROGRESSION
EconomyConfig.LevelProgression = {
    MaxLevel = 50,
    XPPerLevel = 1000,
    BonusXPPerLevel = 50,
}

-- PLOT IMPROVEMENT COSTS
EconomyConfig.PlotImprovements = {
    SizeIncrease = {
        CostBase = 1000,
        CostPerLevel = 500,
    },
    HeightIncrease = {
        CostBase = 500,
        CostPerLevel = 250,
    },
    ObjectLimitIncrease = {
        CostBase = 2000,
        CostPerLevel = 1000,
    },
}

-- DAILY REWARDS
EconomyConfig.DailyRewards = {
    BaseCoins = 100,
    DayMultiplier = {
        [1] = 1.0,
        [2] = 1.1,
        [3] = 1.2,
        [4] = 1.3,
        [5] = 1.4,
        [6] = 1.5,
        [7] = 2.0,
    },
    ResetHour = 0,
}

return EconomyConfig