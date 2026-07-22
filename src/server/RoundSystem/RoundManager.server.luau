local GameSettings = require(script.Parent.GameSetting)
local GameState = require(script.Parent.GameState)

local breakLoop = false

local function main()
	local currentState = GameState:GetState()
	local secondsPassed = 0;
	
	GameState:FireStateSignal()
	
	while breakLoop == false do
		task.wait(1)
		
		if secondsPassed >= GameSettings[currentState.name].length then
			GameState:NextState()
			secondsPassed = 0
		else
			secondsPassed += 1
		end
	end 
end

wait(3)
main()