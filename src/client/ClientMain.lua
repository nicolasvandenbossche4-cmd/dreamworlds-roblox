-- ClientMain.lua
-- Main client script - Initializes client-side systems
-- Place this in StarterPlayer/StarterPlayerScripts

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("\n=== DREAMWORLDS CLIENT STARTING ===")
print("Player: " .. player.Name .. " (" .. player.UserId .. ")\n")

-- Load configs
local GameConfig = require(ReplicatedStorage:WaitForChild("DreamWorlds"):WaitForChild("Shared"):WaitForChild("Config"):WaitForChild("GameConfig"))
local BuildConfig = require(ReplicatedStorage:WaitForChild("DreamWorlds"):WaitForChild("Shared"):WaitForChild("Config"):WaitForChild("BuildConfig"))
local ItemsConfig = require(ReplicatedStorage:WaitForChild("DreamWorlds"):WaitForChild("Shared"):WaitForChild("Config"):WaitForChild("ItemsConfig"))

-- Load remotes
local Remotes = require(ReplicatedStorage:WaitForChild("DreamWorlds"):WaitForChild("Remotes"))

print("[ClientMain] Configs loaded")
print("[ClientMain] Remotes loaded\n")

-- ====================================
-- GET PLAYER DATA FROM SERVER
-- ====================================

print("[ClientMain] Requesting player data from server...\n")
local playerData = Remotes.GetPlayerData:InvokeServer()
if playerData then
    print("[ClientMain] ✓ Player data loaded:")
    print("  - Level: " .. playerData.Level)
    print("  - DreamCoins: " .. playerData.DreamCoins)
    print("  - XP: " .. playerData.XP .. "\n")
else
    error("[ClientMain] Failed to load player data")
end

local plotData = Remotes.GetPlotData:InvokeServer()
if plotData then
    print("[ClientMain] ✓ Plot data loaded:")
    print("  - Plot ID: " .. plotData.PlotId)
    print("  - Position: " .. tostring(plotData.Position))
    print("  - Objects: " .. #plotData.Objects .. "\n")
else
    error("[ClientMain] Failed to load plot data")
end

-- ====================================
-- CLIENT STATE
-- ====================================

local ClientState = {
    CurrentMode = "BUILD", -- BUILD, VISIT, etc
    SelectedObject = nil,
    SelectedObjects = {}, -- For multi-select
    IsBuilding = false,
    BuildHistory = {},
    BuildHistoryIndex = 0,
}

-- ====================================
-- BUILD MODE INITIALIZATION
-- ====================================

print("[ClientMain] Initializing build mode...\n")

-- Create preview object (ghost preview)
local previewPart = Instance.new("Part")
previewPart.Name = "BuildPreview"
previewPart.CanCollide = false
previewPart.Material = Enum.Material.Neon
previewPart.Color = Color3.fromRGB(0, 255, 0)
previewPart.Transparency = 0.3
previewPart.TopSurface = Enum.SurfaceType.Smooth
previewPart.BottomSurface = Enum.SurfaceType.Smooth
previewPart.Size = Vector3.new(1, 1, 1)
previewPart.Parent = workspace

print("[ClientMain] Preview part created\n")

-- ====================================
-- INPUT HANDLING
-- ====================================

local function OnMouseMoved()
    if ClientState.IsBuilding then
        local mouse = player:GetMouse()
        if mouse.Target then
            previewPart.Position = mouse.Hit.Position + Vector3.new(0, 0.5, 0)
        end
    end
end

local function OnLeftMouseClick()
    if ClientState.IsBuilding then
        local mouse = player:GetMouse()
        if mouse.Target then
            -- Send place object request to server
            print("[ClientMain] Placing object at " .. tostring(mouse.Hit.Position))
            Remotes.PlaceObject:FireServer("wall_basic_1x1", mouse.Hit.Position, Vector3.new(0, 0, 0))
        end
    end
end

local function OnKeyPressed(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.B then
        -- Toggle build mode
        ClientState.IsBuilding = not ClientState.IsBuilding
        previewPart.Transparency = ClientState.IsBuilding and 0.3 or 1
        print("[ClientMain] Build mode: " .. (ClientState.IsBuilding and "ON" or "OFF"))
    elseif input.KeyCode == Enum.KeyCode.Delete and ClientState.SelectedObject then
        -- Delete selected object
        print("[ClientMain] Deleting object...")
        Remotes.DeleteObject:FireServer(ClientState.SelectedObject)
    elseif input.KeyCode == Enum.KeyCode.Z and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        -- Undo
        print("[ClientMain] Undo pressed")
        if #ClientState.BuildHistory > 0 and ClientState.BuildHistoryIndex > 1 then
            ClientState.BuildHistoryIndex = ClientState.BuildHistoryIndex - 1
            Remotes.UndoAction:FireServer()
        end
    elseif input.KeyCode == Enum.KeyCode.Y and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        -- Redo
        print("[ClientMain] Redo pressed")
        if ClientState.BuildHistoryIndex < #ClientState.BuildHistory then
            ClientState.BuildHistoryIndex = ClientState.BuildHistoryIndex + 1
            Remotes.RedoAction:FireServer()
        end
    end
end

UserInputService.InputBegan:Connect(OnKeyPressed)
player:GetMouse().Moved:Connect(OnMouseMoved)
player:GetMouse().Button1Down:Connect(OnLeftMouseClick)

print("[ClientMain] Input handlers connected:")
print("  - B: Toggle build mode")
print("  - Click: Place object")
print("  - Delete: Delete selected")
print("  - Ctrl+Z: Undo")
print("  - Ctrl+Y: Redo\n")

-- ====================================
-- REMOTE EVENT LISTENERS
-- ====================================

Remotes.PlaceObject.OnClientEvent:Connect(function(userId, objectId, objectData)
    if userId ~= player.UserId then return end
    print("[ClientMain] Object placed on server: " .. objectId)
end)

Remotes.DeleteObject.OnClientEvent:Connect(function(userId, objectId)
    if userId ~= player.UserId then return end
    print("[ClientMain] Object deleted on server: " .. objectId)
end)

Remotes.SendNotification.OnClientEvent:Connect(function(title, message, duration)
    print("[ClientMain] Notification: " .. title .. " - " .. message)
    -- TODO: Display notification UI
end)

print("\n=== DREAMWORLDS CLIENT READY ===")
print("Build Mode: Press 'B' to toggle")
print("Ready to build!\n")

-- Keep client alive
while true do
    wait(1)
end
