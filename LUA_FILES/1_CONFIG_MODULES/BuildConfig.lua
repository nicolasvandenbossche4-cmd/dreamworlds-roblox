-- BuildConfig.lua
-- Build system specific configuration
-- Place in: ReplicatedStorage/DreamWorlds/Shared/Config/BuildConfig

local BuildConfig = {}

-- BUILD OPERATIONS
BuildConfig.Operations = {
    PLACE = "place",
    MOVE = "move",
    ROTATE = "rotate",
    SCALE = "scale",
    DELETE = "delete",
    DUPLICATE = "duplicate",
    COLOR = "color",
    MATERIAL = "material",
    LOCK = "lock",
    UNLOCK = "unlock",
    GROUP = "group",
    UNGROUP = "ungroup",
    ALIGN = "align",
    DISTRIBUTE = "distribute",
    MIRROR = "mirror",
    COPY = "copy",
    PASTE = "paste",
}

-- BUILD MODES
BuildConfig.Modes = {
    NORMAL = "normal",
    PRECISE = "precise",
    FREEFORM = "freeform",
}

-- VALIDATION STATES
BuildConfig.ValidationStates = {
    VALID = "valid",
    OUT_OF_BOUNDS = "out_of_bounds",
    COLLISION = "collision",
    LOCKED = "locked",
    LIMIT_REACHED = "limit_reached",
    NOT_UNLOCKED = "not_unlocked",
    PERMISSION_DENIED = "permission_denied",
}

-- PLACEMENT TYPES
BuildConfig.PlacementTypes = {
    FREEFORM = "freeform",
    ON_GROUND = "on_ground",
    ON_SURFACE = "on_surface",
    GRID_LOCKED = "grid_locked",
}

-- ROTATION DEFAULTS
BuildConfig.RotationPresets = {
    0,
    45,
    90,
    180,
    270,
}

-- COLOR PRESETS
BuildConfig.ColorPresets = {
    RED = Color3.fromRGB(255, 0, 0),
    GREEN = Color3.fromRGB(0, 255, 0),
    BLUE = Color3.fromRGB(0, 0, 255),
    WHITE = Color3.fromRGB(255, 255, 255),
    BLACK = Color3.fromRGB(0, 0, 0),
    YELLOW = Color3.fromRGB(255, 255, 0),
}

-- MATERIAL PRESETS
BuildConfig.MaterialPresets = {
    "Plastic",
    "Wood",
    "Slate",
    "Concrete",
    "Metal",
    "Neon",
    "Glass",
    "Cobblestone",
    "Brick",
    "Sand",
    "Fabric",
    "Granite",
    "Marble",
}

return BuildConfig