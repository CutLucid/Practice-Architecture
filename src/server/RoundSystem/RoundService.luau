local RoundService = {}
--=====[[ Remote Events]]=====--
local EventNetworkingManager = require(game.ReplicatedStorage.Shared.EventNetworkingManager)
local StateUpdateRemote = EventNetworkingManager:GetRemoteEvent("StateUpdateRemote")
local StateUpdate = EventNetworkingManager:GetBindableEvent("StateUpdate")

local states = {
	Intermission = {
		id = 1,
		name = "Intermission",
		length = 10;
	},
	Starting = {
		id = 2,
		name = "Starting",
		length = 5
	},
	InProgress = {
		id = 3,
		name = "InProgress",
		length = 10
	},
	Ending = {
		id = 4,
		name = "Ending",
		length = 5
	}
}

-- Ordered array for state progression
local stateOrder = {"Intermission", "Starting", "InProgress", "Ending"}

local currentState = states.Intermission;

local function getNumberOfStates() 
	local count = 0
	
	for _ in pairs(states) do
		count += 1
	end
	
	return count
end

local function StartState()
	local secondsPassed = 1

	
	-- Fire signals for state changes
	RoundService:FireStateSignal()
	
	while secondsPassed <= currentState.length do
		secondsPassed += 1;
		task.wait(1)
	end

	RoundService:NextState()
end

function RoundService:StartState()
	StartState()
end

function RoundService:GetState()
	return currentState
end

function RoundService:NextState()
	local currentIndex = currentState.id
	local nextIndex = currentIndex + 1
	
	if nextIndex <= #stateOrder then
		local nextStateName = stateOrder[nextIndex]
		currentState = states[nextStateName]
	else
		currentState = states[stateOrder[1]]
	end

	self:StartState()
end
	
function RoundService:FireStateSignal()
	StateUpdateRemote:FireAllClients(currentState.name)
	StateUpdate:Fire(currentState.name)
end

return RoundService
