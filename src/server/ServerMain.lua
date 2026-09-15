-- ServerMain.lua
-- Main server script - Initializes all services in correct order
-- Place this in ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

print("\n=== DREAMWORLDS SERVER STARTING ===")
print("Loading services...\n")

-- Load all services
local DataService = require(ServerScriptService:WaitForChild("DreamWorlds"):WaitForChild("Services"):WaitForChild("DataService"))
local PlotService = require(ServerScriptService:WaitForChild("DreamWorlds"):WaitForChild("Services"):WaitForChild("PlotService"))
local BuildService = require(ServerScriptService:WaitForChild("DreamWorlds"):WaitForChild("Services"):WaitForChild("BuildService"))
local EconomyService = require(ServerScriptService:WaitForChild("DreamWorlds"):WaitForChild("Services"):WaitForChild("EconomyService"))

-- Load configs
local GameConfig = require(ReplicatedStorage:WaitForChild("DreamWorlds"):WaitForChild("Shared"):WaitForChild("Config"):WaitForChild("GameConfig"))
local BuildConfig = require(ReplicatedStorage:WaitForChild("DreamWorlds"):WaitForChild("Shared"):WaitForChild("Config"):WaitForChild("BuildConfig"))
local ItemsConfig = require(ReplicatedStorage:WaitForChild("DreamWorlds"):WaitForChild("Shared"):WaitForChild("Config"):WaitForChild("ItemsConfig"))

-- Load remotes
local Remotes = require(ReplicatedStorage:WaitForChild("DreamWorlds"):WaitForChild("Remotes"))

print("[ServerMain] GameConfig loaded")
print("[ServerMain] BuildConfig loaded")
print("[ServerMain] ItemsConfig loaded")
print("[ServerMain] Remotes loaded\n")

-- Initialize services in correct order
print("[ServerMain] Initializing services...\n")

local success = DataService:Init()
if not success then
    error("[ServerMain] Failed to initialize DataService")
end

local success = PlotService:Init(DataService)
if not success then
    error("[ServerMain] Failed to initialize PlotService")
end

local success = BuildService:Init(DataService, PlotService, EconomyService)
if not success then
    error("[ServerMain] Failed to initialize BuildService")
end

local success = EconomyService:Init(DataService)
if not success then
    error("[ServerMain] Failed to initialize EconomyService")
end

print("\n[ServerMain] All services initialized successfully!\n")

-- ====================================
-- PLAYER JOIN HANDLER
-- ====================================

local function OnPlayerJoined(player)
    print("\n" .. string.rep("=", 50))
    print("[ServerMain] Player joined: " .. player.Name .. " (" .. player.UserId .. ")")
    print(string.rep("=", 50) .. "\n")
    
    -- Load player data
    local playerData = DataService:LoadPlayerData(player.UserId)
    if not playerData then
        warn("[ServerMain] Failed to load data for " .. player.Name)
        return
    end
    
    -- Allocate plot if not already allocated
    if not playerData.PlotId then
        local plot = PlotService:AllocatePlot(player.UserId, player)
        print("[ServerMain] " .. player.Name .. " received plot: " .. plot.PlotId .. "\n")
    else
        print("[ServerMain] " .. player.Name .. " already has plot: " .. playerData.PlotId .. "\n")
    end
    
    -- Save player data
    DataService:SavePlayerData(player.UserId)
end

-- ====================================
-- REMOTE EVENT HANDLERS
-- ====================================

-- PlaceObject remote
Remotes.PlaceObject.OnServerEvent:Connect(function(player, itemId, position, rotation)
    print("[ServerMain] PlaceObject request from " .. player.Name)
    
    if not itemId or not position then
        print("[ServerMain] Invalid placement parameters")
        return
    end
    
    local success, objectId, objectData = BuildService:PlaceObject(player.UserId, itemId, position, rotation)
    if success then
        print("[ServerMain] ✓ Object placed: " .. objectId)
        -- Broadcast to all clients that object was placed
        Remotes.PlaceObject:FireAllClients(player.UserId, objectId, objectData)
    else
        print("[ServerMain] ✗ Placement failed: " .. objectId)
    end
end)

-- DeleteObject remote
Remotes.DeleteObject.OnServerEvent:Connect(function(player, objectId)
    print("[ServerMain] DeleteObject request from " .. player.Name)
    
    local success, message = BuildService:DeleteObject(player.UserId, objectId)
    if success then
        print("[ServerMain] ✓ Object deleted: " .. objectId)
        Remotes.DeleteObject:FireAllClients(player.UserId, objectId)
    else
        print("[ServerMain] ✗ Deletion failed: " .. message)
    end
end)

-- RequestBuyItem remote function
Remotes.RequestBuyItem.OnServerInvoke = function(player, itemId, itemPrice)
    print("[ServerMain] BuyItem request from " .. player.Name .. " for item " .. itemId)
    
    local success, message = EconomyService:BuyItem(player.UserId, itemId, itemPrice)
    if success then
        print("[ServerMain] ✓ Item purchased: " .. itemId)
        return true, "Item purchased successfully"
    else
        print("[ServerMain] ✗ Purchase failed: " .. message)
        return false, message
    end
end

-- RequestClaimDailyReward remote function
Remotes.RequestClaimDailyReward.OnServerInvoke = function(player)
    print("[ServerMain] ClaimDailyReward request from " .. player.Name)
    
    local success, message = EconomyService:ClaimDailyReward(player.UserId)
    if success then
        print("[ServerMain] ✓ Daily reward claimed")
        return true, message
    else
        print("[ServerMain] ✗ Daily reward claim failed: " .. message)
        return false, message
    end
end

-- GetPlayerData remote function
Remotes.GetPlayerData.OnServerInvoke = function(player)
    local playerData = DataService:GetPlayerData(player.UserId)
    if playerData then
        return playerData
    else
        warn("[ServerMain] Player data not found for " .. player.Name)
        return nil
    end
end

-- GetPlotData remote function
Remotes.GetPlotData.OnServerInvoke = function(player)
    local plot = PlotService:GetPlot(player.UserId)
    if plot then
        return plot
    else
        warn("[ServerMain] Plot data not found for " .. player.Name)
        return nil
    end
end

-- ====================================
-- PLAYER MANAGEMENT
-- ====================================

Players.PlayerAdded:Connect(OnPlayerJoined)

Players.PlayerRemoving:Connect(function(player)
    print("\n" .. string.rep("=", 50))
    print("[ServerMain] Player leaving: " .. player.Name)
    print(string.rep("=", 50) .. "\n")
    DataService:OnPlayerLeaving(player)
end)

-- Handle server shutdown
game:BindToClose(function()
    print("\n[ServerMain] Server shutting down, saving all player data...\n")
    for _, player in ipairs(Players:GetPlayers()) do
        DataService:OnPlayerLeaving(player)
    end
    print("[ServerMain] All data saved. Goodbye!\n")
end)

print("\n=== DREAMWORLDS SERVER READY ===")
print("Waiting for players...\n")

-- Keep server alive
while true do
    wait(60)
end
