local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Get the StateUpdate RemoteEvent
local RemoteManager = require(ReplicatedStorage.Shared.RemoteManager)

-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TimerDisplayGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local textLabel = Instance.new("TextLabel")
textLabel.Name = "StateDisplay"
textLabel.Size = UDim2.new(0, 300, 0, 60)
textLabel.Position = UDim2.new(0.5, -150, 0, 20)
textLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
textLabel.BackgroundTransparency = 0.3

textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextSize = 24
textLabel.Font = Enum.Font.GothamBold
textLabel.Text = "Waiting for state..."

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = textLabel

textLabel.Parent = screenGui

-- State tracking
local currentStateName = "Unknown"
local currentStateId = ""
local stateStartTime = 0
local isTracking = false

-- Update display text
local function updateDisplay()
	local secondsPassed = 0
	if isTracking then
		secondsPassed = math.floor(tick() - stateStartTime)
	end
	textLabel.Text = string.format("%s | %d seconds", currentStateName, secondsPassed)
end

-- Listen for state updates from server
RemoteManager:GetRemoteEventAsyncClient("StateUpdate"):andThen(function(event: RemoteEvent)
    event.OnClientEvent:Connect(function(stateName: string, stateId: string)
        print("State update received:", stateName, stateId)
        currentStateName = stateName or "Unknown"
        currentStateId = stateId or ""
        stateStartTime = tick()
        isTracking = true
        updateDisplay()
    end)
end):catch(function(err)
    warn("Failed to get StateUpdate: " .. err)
end)

-- Continuously update the seconds counter
RunService.Heartbeat:Connect(function()
	if isTracking then
		updateDisplay()
	end
end)