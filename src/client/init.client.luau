-- local AbilityController = require(script.Ability.AbilityController)
-- local userInputService = game:GetService("UserInputService")

-- local abilityController = AbilityController.new()

-- abilityController:Init()

-- -- [[ When player presses 'E' key, use the ability if available ]] --
-- userInputService.InputBegan:Connect(function(input, gameProcessed)
--     if gameProcessed then return end -- Ignore if the game has already processed the input

--     if input.KeyCode == Enum.KeyCode.E then
--         abilityController:Use("Fireball")
--     end
-- end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteManager = require(ReplicatedStorage.Shared.RemoteManager)


RemoteManager:GetRemoteEventAsyncClient("GreetEvent"):andThen(function(event: RemoteEvent)
    event.OnClientEvent:Connect(function(message: string)
        print(message)
    end)
end):catch(function(err)
    warn("Failed to get GreetEvent: " .. err)
end)

RemoteManager:GetRemoteEventAsyncClient("FarewellEvent"):andThen(function(event: RemoteEvent)
    event.OnClientEvent:Connect(function(message: string)
        print(message) 
    end)
end):catch(function(err)
    warn("Failed to get GreetEvent: " .. err)
end)

RemoteManager:GetRemoteEventAsyncClient("ComebackEvent"):andThen(function(event: RemoteEvent)
    event.OnClientEvent:Connect(function(message: string)
        print(message) 
    end)
end):catch(function(err)
    warn("Failed to get GreetEvent: " .. err)
end)

RemoteManager:GetRemoteEventAsyncClient("GreetEventFromClient"):andThen(function(event: RemoteEvent)
    event:FireServer("Hello from the client!")
end):catch(function(err)
    warn("Failed to get GreetEvent: " .. err)
end)
