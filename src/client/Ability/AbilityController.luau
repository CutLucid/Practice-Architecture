-- local AbilityController = {}

-- AbilityController.__index = AbilityController

-- -- [[ Variables ]] --
-- local AbilityStateChanged: RBXScriptSignal = game.ReplicatedStorage.Shared.Events.AbilityStateChanged


-- function AbilityController.new()
--     local self = setmetatable({}, AbilityController)
--     -- Initialize any properties or state for the AbilityController here
--     self.abilities = {"Fireball", "IceBlast", "LightningStrike"} -- Example abilities
--     self.canUse = true
--     return self
-- end

-- function AbilityController:Init()
--     -- State change for ability usage
--     AbilityStateChanged.OnClientEvent:Connect(function(state: boolean, abilities: {string}, message: string)
--         -- Server will return the true state of the ability usage and the abilities that can be used
--         -- to prevent exploits, the server will handle the actual ability usage and cooldowns
--         self.canUse = state
--         self.abilities = abilities
--         print(message)
--     end)
-- end

-- function AbilityController:Use(abilityName: string)
--     -- Check if the ability is available and can be used
--     if not self.canUse then
--         print("Ability is on cooldown or cannot be used at the moment.")
--         return
--     end

--     print("Checking if ", abilityName, " is available.")
--     if table.find(self.abilities, abilityName) then
--         print("Using ability:", abilityName)
--         -- Fire the server to use the ability
--         game.ReplicatedStorage.Shared.Events.UseAbility:FireServer(abilityName)
--     else
--         print("Ability is not available.")
--     end
-- end

-- return AbilityController