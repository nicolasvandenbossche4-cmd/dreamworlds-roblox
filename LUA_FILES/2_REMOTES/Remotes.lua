-- Remotes.lua
-- Centralized RemoteEvent/RemoteFunction definitions
-- Place in: ReplicatedStorage/DreamWorlds/Remotes

local Remotes = {}

-- BUILD SYSTEM REMOTES
Remotes.PlaceObject = Instance.new("RemoteEvent")
Remotes.PlaceObject.Name = "PlaceObject"

Remotes.MoveObject = Instance.new("RemoteEvent")
Remotes.MoveObject.Name = "MoveObject"

Remotes.RotateObject = Instance.new("RemoteEvent")
Remotes.RotateObject.Name = "RotateObject"

Remotes.DeleteObject = Instance.new("RemoteEvent")
Remotes.DeleteObject.Name = "DeleteObject"

Remotes.DuplicateObject = Instance.new("RemoteEvent")
Remotes.DuplicateObject.Name = "DuplicateObject"

Remotes.ColorObject = Instance.new("RemoteEvent")
Remotes.ColorObject.Name = "ColorObject"

Remotes.UndoAction = Instance.new("RemoteEvent")
Remotes.UndoAction.Name = "UndoAction"

Remotes.RedoAction = Instance.new("RemoteEvent")
Remotes.RedoAction.Name = "RedoAction"

-- ECONOMY REMOTES
Remotes.RequestBuyItem = Instance.new("RemoteFunction")
Remotes.RequestBuyItem.Name = "RequestBuyItem"

Remotes.RequestClaimDailyReward = Instance.new("RemoteFunction")
Remotes.RequestClaimDailyReward.Name = "RequestClaimDailyReward"

-- VISIT REMOTES
Remotes.LikeObject = Instance.new("RemoteEvent")
Remotes.LikeObject.Name = "LikeObject"

Remotes.VisitPlot = Instance.new("RemoteFunction")
Remotes.VisitPlot.Name = "VisitPlot"

-- QUEST REMOTES
Remotes.CompleteQuest = Instance.new("RemoteFunction")
Remotes.CompleteQuest.Name = "CompleteQuest"

-- CHAT/NOTIFICATION REMOTES
Remotes.SendNotification = Instance.new("RemoteEvent")
Remotes.SendNotification.Name = "SendNotification"

-- DATA REMOTES
Remotes.GetPlayerData = Instance.new("RemoteFunction")
Remotes.GetPlayerData.Name = "GetPlayerData"

Remotes.GetPlotData = Instance.new("RemoteFunction")
Remotes.GetPlotData.Name = "GetPlotData"

function Remotes:WaitForRemote(name)
    while not self[name] do
        wait(0.1)
    end
    return self[name]
end

return Remotes