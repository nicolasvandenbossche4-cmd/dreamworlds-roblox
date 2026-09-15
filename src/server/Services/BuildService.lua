-- BuildService.lua
-- Server-side build system validation and execution

local BuildService = {}
local DataService = nil
local PlotService = nil
local EconomyService = nil

-- Configuration
local MAX_OBJECTS_PER_PLOT = 500
local MAX_PARTS_PER_PLOT = 5000
local MAX_HEIGHT = 256
local GRID_SIZE = 1

-- Validate build operation parameters
function BuildService:ValidateOperation(userId, operationType, operationData)
    if not userId or not operationType or not operationData then
        return false, "Invalid operation parameters"
    end
    
    local plot = PlotService:GetPlot(userId)
    if not plot then
        return false, "No plot allocated"
    end
    
    if operationType == "PLACE" then
        return self:ValidatePlacement(userId, plot, operationData)
    elseif operationType == "MOVE" then
        return self:ValidateMovement(userId, plot, operationData)
    elseif operationType == "ROTATE" then
        return self:ValidateRotation(userId, plot, operationData)
    elseif operationType == "DELETE" then
        return self:ValidateDeletion(userId, plot, operationData)
    end
    
    return false, "Unknown operation type"
end

-- Validate placement
function BuildService:ValidatePlacement(userId, plot, data)
    local itemId = data.ItemId
    local position = data.Position
    local rotation = data.Rotation or Vector3.new(0, 0, 0)
    
    -- Check if item exists
    if not itemId or itemId == "" then
        return false, "Invalid item ID"
    end
    
    -- Check if item is unlocked
    local playerData = DataService:GetPlayerData(userId)
    local isUnlocked = false
    for _, unlockedId in ipairs(playerData.UnlockedItems) do
        if unlockedId == itemId then
            isUnlocked = true
            break
        end
    end
    
    if not isUnlocked then
        return false, "Item not unlocked"
    end
    
    -- Check position validity
    if not position or not position.X or not position.Y or not position.Z then
        return false, "Invalid position"
    end
    
    -- Check if position is within plot bounds
    local relativePos = position - plot.Position
    if relativePos.X < 0 or relativePos.Z < 0 or 
       relativePos.X > plot.Size.X or relativePos.Z > plot.Size.Z then
        return false, "Position out of plot bounds"
    end
    
    -- Check height limit
    if position.Y > plot.Position.Y + MAX_HEIGHT then
        return false, "Position exceeds maximum height"
    end
    
    -- Check object count limit
    if #plot.Objects >= MAX_OBJECTS_PER_PLOT then
        return false, "Plot is full"
    end
    
    return true, "Valid placement"
end

-- Validate movement
function BuildService:ValidateMovement(userId, plot, data)
    local objectId = data.ObjectId
    local newPosition = data.NewPosition
    
    if not objectId or not newPosition then
        return false, "Invalid movement parameters"
    end
    
    local relativePos = newPosition - plot.Position
    if relativePos.X < 0 or relativePos.Z < 0 or 
       relativePos.X > plot.Size.X or relativePos.Z > plot.Size.Z then
        return false, "New position out of bounds"
    end
    
    return true, "Valid movement"
end

-- Validate rotation
function BuildService:ValidateRotation(userId, plot, data)
    local objectId = data.ObjectId
    local newRotation = data.NewRotation
    
    if not objectId or not newRotation then
        return false, "Invalid rotation parameters"
    end
    
    -- Check for NaN or Infinity
    if newRotation.X ~= newRotation.X or newRotation.Y ~= newRotation.Y or newRotation.Z ~= newRotation.Z then
        return false, "Invalid rotation value (NaN)"
    end
    
    if math.abs(newRotation.X) > 360 or math.abs(newRotation.Y) > 360 or math.abs(newRotation.Z) > 360 then
        -- Normalize if needed
    end
    
    return true, "Valid rotation"
end

-- Validate deletion
function BuildService:ValidateDeletion(userId, plot, data)
    local objectId = data.ObjectId
    
    if not objectId then
        return false, "Invalid object ID"
    end
    
    -- Check if object exists in plot
    for _, obj in ipairs(plot.Objects) do
        if obj.ObjectId == objectId then
            return true, "Valid deletion"
        end
    end
    
    return false, "Object not found in plot"
end

-- Execute placement
function BuildService:PlaceObject(userId, itemId, position, rotation)
    local isValid, reason = self:ValidateOperation(userId, "PLACE", {
        ItemId = itemId,
        Position = position,
        Rotation = rotation,
    })
    
    if not isValid then
        return false, reason
    end
    
    local objectId = "obj_" .. userId .. "_" .. tostring(os.time() * 1000)
    local objectData = {
        ObjectId = objectId,
        ItemId = itemId,
        Position = position,
        Rotation = rotation or Vector3.new(0, 0, 0),
        Color = Color3.new(1, 1, 1),
        Material = "Plastic",
        CreatedAt = os.time(),
    }
    
    PlotService:AddObjectToPlot(userId, objectData)
    DataService:AddXP(userId, 10) -- Reward for placing
    DataService:AddCurrency(userId, 10, "DreamCoins")
    
    print("[BuildService] Placed object " .. objectId .. " for user " .. userId)
    return true, objectId, objectData
end

-- Execute deletion
function BuildService:DeleteObject(userId, objectId)
    local isValid, reason = self:ValidateOperation(userId, "DELETE", {
        ObjectId = objectId,
    })
    
    if not isValid then
        return false, reason
    end
    
    PlotService:RemoveObjectFromPlot(userId, objectId)
    DataService:AddXP(userId, 5)
    
    print("[BuildService] Deleted object " .. objectId .. " for user " .. userId)
    return true, "Object deleted"
end

-- Initialize BuildService
function BuildService:Init(dataService, plotService, economyService)
    print("[BuildService] Initializing...")
    DataService = dataService
    PlotService = plotService
    EconomyService = economyService
    print("[BuildService] Initialized successfully")
    return true
end

return BuildService
