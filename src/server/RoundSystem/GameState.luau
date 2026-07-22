local GameState = {}
--=====[[ Remote Events]]=====--
local RemoteManager = require(game.ReplicatedStorage.Shared.RemoteManager)
local StateUpdate = RemoteManager:GetRemoteEvent("StateUpdate")

local states = {
	Waiting = {
		id = 1,
		name = "Waiting"
	},
	Starting = {
		id = 2,
		name = "Starting"
	},
	InProgress = {
		id = 3,
		name = "InProgress"
	},
	Ending = {
		id = 4,
		name = "Ending"
	}
}

-- Ordered array for state progression
local stateOrder = {"Waiting", "Starting", "InProgress", "Ending"}

local CurrentState = states.Waiting;

local function getNumberOfStates() 
	local count = 0
	
	for _ in pairs(states) do
		count += 1
	end
	
	return count
end

function GameState:GetState()
	return CurrentState
end

function GameState:NextState()
	local currentIndex = CurrentState.id
	local nextIndex = currentIndex + 1
	
	if nextIndex <= #stateOrder then
		local nextStateName = stateOrder[nextIndex]
		CurrentState = states[nextStateName]
	else
		CurrentState = states[stateOrder[1]]
	end
	
	-- Fire signals for state changes
	self:FireStateSignal()
end
	
function GameState:FireStateSignal()
	StateUpdate:FireAllClients(CurrentState.name, CurrentState.id)
end

return GameState
