
-- [[ Variiables ]] -- 
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventNetworkingManager = require(ReplicatedStorage.Shared.EventNetworkingManager)
local StateUpdate = EventNetworkingManager:GetBindableEvent("StateUpdate")

local RoundService = require(ServerScriptService.Server.RoundSystem.RoundService)


local function OnStartingPhaseStart()
    --local gameStats: GameStats = require(script.Parent.GameStats)
    print("STARTING")
end

local function OnIntermissionPhaseStart()
    print("INTERMISSION")
end

local function OnEndingPhaseStart()
    print("ENDING")
end

local function OnInProgressPhaseStart()
    print("INPROGRESS")
end

-- Phase: Starting

StateUpdate.Event:Connect(function(stateName: string)
    if stateName == "Starting" then
            OnStartingPhaseStart()
        end

        if stateName == "InProgress" then
            OnInProgressPhaseStart()
        end

        if stateName == "Ending" then
            OnEndingPhaseStart()
        end

        if stateName == "Intermission" then
            OnIntermissionPhaseStart()
        end
end)

task.wait(3)
RoundService:StartState()