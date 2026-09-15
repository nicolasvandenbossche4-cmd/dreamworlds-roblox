-- GameConfig.lua
-- Central game configuration module
-- Place in: ReplicatedStorage/DreamWorlds/Shared/Config/GameConfig

local GameConfig = {}

-- GAME METADATA
GameConfig.NAME = "DreamWorlds"
GameConfig.VERSION = "0.1.0"
GameConfig.MAX_PLAYERS = 100 -- Per server

-- PLAYER SETTINGS
GameConfig.Player = {
    StartingDreamCoins = 500,
    StartingDreamGems = 0,
    StartingLevel = 1,
    StartingXP = 0,
}

-- PLOT SETTINGS
GameConfig.Plot = {
    DefaultSize = Vector3.new(64, 64, 64),
    DefaultMaxHeight = 50,
    DefaultMaxObjects = 500,
    DefaultMaxParts = 5000,
}

-- BUILD SYSTEM LIMITS
GameConfig.Build = {
    MaxObjectsPerPlot = 500,
    MaxPartsPerPlot = 5000,
    MaxPartsPerObject = 250,
    MaxHeight = 256,
    MaxPlotSize = 256,
    MaxBlueprintSize = 100,
    MaxHistoryActions = 100,
    MaxRemoteRequests = 10,
    MaxBatchOperationSize = 50,
    MaxInteractionDistance = 100,
    MaxSavedDataSize = 100000,
}

-- SNAPPING & GRID
GameConfig.Snap = {
    GridSize = 1,
    RotationIncrement = 15,
    MoveIncrement = 1,
    ScaleIncrement = 0.5,
    SnapEnabled = true,
}

-- DEBUGGING
GameConfig.Debug = {
    Enabled = true,
    Logging = true,
    VerboseLogging = false,
}

return GameConfig