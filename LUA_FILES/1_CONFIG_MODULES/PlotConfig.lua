-- PlotConfig.lua
-- Plot system configuration
-- Place in: ReplicatedStorage/DreamWorlds/Shared/Config/PlotConfig

local PlotConfig = {}

-- PLOT STATES
PlotConfig.States = {
    VACANT = "vacant",
    OCCUPIED = "occupied",
    RESERVED = "reserved",
    LOCKED = "locked",
}

-- PLOT PERMISSIONS
PlotConfig.Permissions = {
    VISIT = "visit",
    LIKE = "like",
    BUILD = "build",
    MOVE_OBJECTS = "move_objects",
    DELETE_OBJECTS = "delete_objects",
    USE_TOOLS = "use_tools",
}

-- DEFAULT PERMISSION LEVELS
PlotConfig.PermissionLevels = {
    PRIVATE = {
        OWNER = {
            VISIT = true,
            LIKE = true,
            BUILD = true,
            MOVE_OBJECTS = true,
            DELETE_OBJECTS = true,
            USE_TOOLS = true,
        },
        OTHERS = {
            VISIT = false,
            LIKE = false,
            BUILD = false,
            MOVE_OBJECTS = false,
            DELETE_OBJECTS = false,
            USE_TOOLS = false,
        },
    },
    FRIENDS = {
        OWNER = {
            VISIT = true,
            LIKE = true,
            BUILD = true,
            MOVE_OBJECTS = true,
            DELETE_OBJECTS = true,
            USE_TOOLS = true,
        },
        FRIENDS = {
            VISIT = true,
            LIKE = true,
            BUILD = false,
            MOVE_OBJECTS = false,
            DELETE_OBJECTS = false,
            USE_TOOLS = false,
        },
        OTHERS = {
            VISIT = false,
            LIKE = false,
            BUILD = false,
            MOVE_OBJECTS = false,
            DELETE_OBJECTS = false,
            USE_TOOLS = false,
        },
    },
    PUBLIC = {
        OWNER = {
            VISIT = true,
            LIKE = true,
            BUILD = true,
            MOVE_OBJECTS = true,
            DELETE_OBJECTS = true,
            USE_TOOLS = true,
        },
        OTHERS = {
            VISIT = true,
            LIKE = true,
            BUILD = false,
            MOVE_OBJECTS = false,
            DELETE_OBJECTS = false,
            USE_TOOLS = false,
        },
    },
}

return PlotConfig