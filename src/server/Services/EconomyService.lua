-- EconomyService.lua
-- Server-side economy and currency management

local EconomyService = {}
local DataService = nil

-- Configuration
local PLACE_OBJECT_REWARD = 10
local DELETE_OBJECT_REWARD = 2
local VISIT_PLOT_REWARD = 20
local LIKE_PLOT_REWARD = 5
local DAILY_LOGIN_REWARD = 100

-- Add coins to player
function EconomyService:AddCoins(userId, amount, reason)
    if not DataService then
        warn("[EconomyService] DataService not initialized")
        return false
    end
    
    if amount < 0 then
        return false, "Invalid amount"
    end
    
    local success = DataService:AddCurrency(userId, amount, "DreamCoins")
    if success then
        print(string.format("[EconomyService] Added %d coins to user %d (%s)", amount, userId, reason or "unknown"))
    end
    return success
end

-- Subtract coins from player
function EconomyService:SubtractCoins(userId, amount, reason)
    if not DataService then
        return false
    end
    
    if amount < 0 then
        return false, "Invalid amount"
    end
    
    local playerData = DataService:GetPlayerData(userId)
    if not playerData or playerData.DreamCoins < amount then
        return false, "Insufficient coins"
    end
    
    local success = DataService:SubtractCurrency(userId, amount, "DreamCoins")
    if success then
        print(string.format("[EconomyService] Subtracted %d coins from user %d (%s)", amount, userId, reason or "unknown"))
    end
    return success
end

-- Buy item
function EconomyService:BuyItem(userId, itemId, itemPrice)
    local playerData = DataService:GetPlayerData(userId)
    if not playerData then
        return false, "Player data not found"
    end
    
    if playerData.DreamCoins < itemPrice then
        return false, "Insufficient coins"
    end
    
    local success = self:SubtractCoins(userId, itemPrice, "Buy item " .. itemId)
    if success then
        DataService:UnlockItem(userId, itemId)
        return true, "Item purchased"
    end
    return false, "Purchase failed"
end

-- Claim daily reward
function EconomyService:ClaimDailyReward(userId)
    local playerData = DataService:GetPlayerData(userId)
    if not playerData then
        return false, "Player data not found"
    end
    
    local lastClaimTime = playerData.LastDailyClaimTime or 0
    local currentTime = os.time()
    local secondsSinceLastClaim = currentTime - lastClaimTime
    
    -- Check if 24 hours have passed
    if secondsSinceLastClaim < 86400 then
        local hoursLeft = math.ceil((86400 - secondsSinceLastClaim) / 3600)
        return false, "Daily reward already claimed. Try again in " .. hoursLeft .. " hours"
    end
    
    -- Award daily login reward
    local streak = playerData.DailyStreak or 0
    local multiplier = 1.0
    
    if streak >= 1 and streak <= 6 then
        multiplier = 1.0 + (streak * 0.1)
    elseif streak >= 7 then
        multiplier = 2.0
    end
    
    local reward = math.floor(DAILY_LOGIN_REWARD * multiplier)
    
    DataService:AddCurrency(userId, reward, "DreamCoins")
    DataService:UpdatePlayerData(userId, "LastDailyClaimTime", currentTime)
    DataService:UpdatePlayerData(userId, "DailyStreak", streak + 1)
    
    print(string.format("[EconomyService] User %d claimed daily reward: %d coins (streak: %d)", userId, reward, streak + 1))
    return true, "Daily reward claimed: " .. reward .. " coins"
end

-- Initialize EconomyService
function EconomyService:Init(dataService)
    print("[EconomyService] Initializing...")
    DataService = dataService
    print("[EconomyService] Initialized successfully")
    return true
end

return EconomyService
