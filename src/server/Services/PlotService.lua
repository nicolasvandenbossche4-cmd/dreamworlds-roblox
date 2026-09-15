-- PlotService.lua
-- Server-side plot management service

local PlotService = {}
local DataService = nil -- Will be set during initialization

-- Plot allocation
local allocatedPlots = {}
local plotTemplates = {}

-- Configuration
local PLOT_SIZE = Vector3.new(64, 64, 64)
local PLOT_SPAWN_HEIGHT = 5
local MAX_PLOTS = 100

-- Create a new plot for a player
function PlotService:AllocatePlot(userId, player)
    if allocatedPlots[userId] then
        warn("[PlotService] User " .. userId .. " already has a plot")
        return allocatedPlots[userId]
    end
    
    local plotId = "plot_" .. userId
    local plotNumber = 0
    for _ in pairs(allocatedPlots) do
        plotNumber = plotNumber + 1
    end
    
    local plotPosition = self:CalculatePlotPosition(plotNumber)
    
    local plotData = {
        PlotId = plotId,
        UserId = userId,
        PlayerName = player.Name,
        Position = plotPosition,
        Size = PLOT_SIZE,
        CreatedAt = os.time(),
        State = "OCCUPIED",
        Permissions = "PRIVATE",
        Objects = {},
    }
    
    allocatedPlots[userId] = plotData
    
    -- Update DataService
    if DataService then
        DataService:UpdatePlayerData(userId, "PlotId", plotId)
    end
    
    print(string.format("[PlotService] Allocated plot %s to player %s (%d) at position %s",
        plotId, player.Name, userId, tostring(plotPosition)))
    
    return plotData
end

-- Calculate plot position based on plot number
function PlotService:CalculatePlotPosition(plotNumber)
    local pagesPerRow = 5
    local plotSpacing = 80
    local x = (plotNumber % pagesPerRow) * plotSpacing
    local z = math.floor(plotNumber / pagesPerRow) * plotSpacing
    return Vector3.new(x, PLOT_SPAWN_HEIGHT, z)
end

-- Get plot data
function PlotService:GetPlot(userId)
    return allocatedPlots[userId]
end

-- Get plot by ID
function PlotService:GetPlotById(plotId)
    for userId, plotData in pairs(allocatedPlots) do
        if plotData.PlotId == plotId then
            return plotData
        end
    end
    return nil
end

-- Add object to plot
function PlotService:AddObjectToPlot(userId, objectData)
    local plot = self:GetPlot(userId)
    if not plot then
        warn("[PlotService] Plot not found for user " .. userId)
        return false
    end
    
    table.insert(plot.Objects, objectData)
    return true
end

-- Remove object from plot
function PlotService:RemoveObjectFromPlot(userId, objectId)
    local plot = self:GetPlot(userId)
    if not plot then
        return false
    end
    
    for i, obj in ipairs(plot.Objects) do
        if obj.ObjectId == objectId then
            table.remove(plot.Objects, i)
            return true
        end
    end
    return false
end

-- Get plot objects
function PlotService:GetPlotObjects(userId)
    local plot = self:GetPlot(userId)
    if plot then
        return plot.Objects
    end
    return {}
end

-- Check if player can build on plot (permissions)
function PlotService:CanPlayerBuildOnPlot(userId, targetUserId)
    if userId == targetUserId then
        return true -- Owner can always build
    end
    
    local targetPlot = self:GetPlot(targetUserId)
    if not targetPlot then
        return false
    end
    
    -- Check permissions (implement full permission system later)
    if targetPlot.Permissions == "PRIVATE" then
        return false
    elseif targetPlot.Permissions == "FRIENDS" then
        -- Check if friends (implement later)
        return false
    elseif targetPlot.Permissions == "PUBLIC" then
        return false -- Can visit but not build
    end
    
    return false
end

-- Free plot when player leaves
function PlotService:FreePlot(userId)
    if allocatedPlots[userId] then
        allocatedPlots[userId] = nil
        print("[PlotService] Freed plot for user " .. userId)
        return true
    end
    return false
end

-- Initialize PlotService
function PlotService:Init(dataService)
    print("[PlotService] Initializing...")
    DataService = dataService
    print("[PlotService] Initialized successfully")
    return true
end

return PlotService
