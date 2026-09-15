-- DataService.lua
-- Server-side data persistence service
-- CRITICAL: Must be loaded FIRST before any other service

local DataService = {}
local DataStore = game:GetService("DataStoreService")
local Players = game:GetService("Players")

-- Configuration
local DATA_STORE_NAME = "DreamWorlds_PlayerData"
local AUTO_SAVE_INTERVAL = 30 -- seconds
local LOAD_TIMEOUT = 5 -- seconds

-- In-memory player data cache
local playerDataCache = {}

-- Default player data structure
local function CreateDefaultPlayerData(userId)
    return {
        UserId = userId,
        Version = 1,
        CreatedAt = os.time(),
        LastSave = os.time(),
        
        -- Economy
        DreamCoins = 500,
        DreamGems = 0,
        
        -- Progression
        Level = 1,
        XP = 0,
        TotalXPEarned = 0,
        
        -- Plot data
        PlotId = nil,
        PlotObjects = {}, -- Serialized objects
        PlotPermissions = "PRIVATE",
        
        -- Inventory
        Inventory = {},
        UnlockedItems = {
            "wall_basic_1x1",
            "wall_brick_1x2",
            "floor_wood_2x2",
            "chair_basic",
            "table_basic",
            "plant_small",
        },
        
        -- Social
        Friends = {},
        Followers = {},
        Following = {},
        
        -- Achievements
        Achievements = {},
        
        -- Daily login
        LastDailyClaimTime = 0,
        DailyStreak = 0,
        
        -- Quests
        ActiveQuests = {},
        CompletedQuests = {},
        
        -- Statistics
        Stats = {
            ObjectsPlaced = 0,
            ObjectsDeleted = 0,
            TimesVisited = 0,
            LikesReceived = 0,
            ConteststEntered = 0,
        },
    }
end

-- Load player data from DataStore
function DataService:LoadPlayerData(userId)
    local success, data = pcall(function()
        return DataStore:GetDataStore(DATA_STORE_NAME):GetAsync(tostring(userId))
    end)
    
    if success then
        if data then
            print("[DataService] Loaded data for user " .. userId)
            playerDataCache[userId] = data
            return data
        else
            print("[DataService] No data found for user " .. userId .. ", creating default")
            local defaultData = CreateDefaultPlayerData(userId)
            playerDataCache[userId] = defaultData
            return defaultData
        end
    else
        warn("[DataService] Error loading data for user " .. userId .. ": " .. tostring(data))
        return nil
    end
end

-- Save player data to DataStore
function DataService:SavePlayerData(userId)
    local playerData = playerDataCache[userId]
    if not playerData then
        warn("[DataService] No data to save for user " .. userId)
        return false
    end
    
    playerData.LastSave = os.time()
    
    local success, err = pcall(function()
        DataStore:GetDataStore(DATA_STORE_NAME):SetAsync(tostring(userId), playerData)
    end)
    
    if success then
        print("[DataService] Saved data for user " .. userId)
        return true
    else
        warn("[DataService] Error saving data for user " .. userId .. ": " .. tostring(err))
        return false
    end
end

-- Get player data from cache
function DataService:GetPlayerData(userId)
    return playerDataCache[userId]
end

-- Update a specific field in player data
function DataService:UpdatePlayerData(userId, key, value)
    local playerData = playerDataCache[userId]
    if playerData then
        playerData[key] = value
        return true
    end
    return false
end

-- Add currency to player
function DataService:AddCurrency(userId, amount, currencyType)
    currencyType = currencyType or "DreamCoins"
    local playerData = playerDataCache[userId]
    if playerData then
        playerData[currencyType] = (playerData[currencyType] or 0) + amount
        print(string.format("[DataService] Added %d %s to user %d. New total: %d", 
            amount, currencyType, userId, playerData[currencyType]))
        return true
    end
    return false
end

-- Subtract currency from player
function DataService:SubtractCurrency(userId, amount, currencyType)
    currencyType = currencyType or "DreamCoins"
    local playerData = playerDataCache[userId]
    if playerData then
        if playerData[currencyType] >= amount then
            playerData[currencyType] = playerData[currencyType] - amount
            print(string.format("[DataService] Subtracted %d %s from user %d. New total: %d", 
                amount, currencyType, userId, playerData[currencyType]))
            return true
        else
            warn("[DataService] Insufficient " .. currencyType .. " for user " .. userId)
            return false
        end
    end
    return false
end

-- Add XP to player
function DataService:AddXP(userId, amount)
    local playerData = playerDataCache[userId]
    if playerData then
        playerData.XP = playerData.XP + amount
        playerData.TotalXPEarned = playerData.TotalXPEarned + amount
        print(string.format("[DataService] Added %d XP to user %d. Total: %d", 
            amount, userId, playerData.XP))
        return true
    end
    return false
end

-- Unlock an item for player
function DataService:UnlockItem(userId, itemId)
    local playerData = playerDataCache[userId]
    if playerData then
        local alreadyUnlocked = false
        for _, id in ipairs(playerData.UnlockedItems) do
            if id == itemId then
                alreadyUnlocked = true
                break
            end
        end
        
        if not alreadyUnlocked then
            table.insert(playerData.UnlockedItems, itemId)
            print("[DataService] Unlocked item " .. itemId .. " for user " .. userId)
            return true
        end
    end
    return false
end

-- Auto-save loop
function DataService:StartAutoSave()
    spawn(function()
        while true do
            wait(AUTO_SAVE_INTERVAL)
            for userId in pairs(playerDataCache) do
                self:SavePlayerData(userId)
            end
        end
    end)
end

-- Handle player leaving and save their data
function DataService:OnPlayerLeaving(player)
    local userId = player.UserId
    print("[DataService] Player " .. player.Name .. " (" .. userId .. ") leaving, saving data...")
    self:SavePlayerData(userId)
    playerDataCache[userId] = nil
end

-- Initialize DataService
function DataService:Init()
    print("[DataService] Initializing...")
    
    -- Connect to player leaving event
    Players.PlayerRemoving:Connect(function(player)
        self:OnPlayerLeaving(player)
    end)
    
    -- Start auto-save
    self:StartAutoSave()
    
    print("[DataService] Initialized successfully")
    return true
end

return DataService
