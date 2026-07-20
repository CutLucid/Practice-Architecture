-- local AbilityService = {}

-- -- [[ Variables ]] --
-- local UseAbility: RemoteEvent = game.ReplicatedStorage.Shared.Events.UseAbility
-- local AbilityStateChanged: RemoteEvent = game.ReplicatedStorage.Shared.Events.AbilityStateChanged


-- local cache: {
--     [Player]: {abilities: {string}, canUse: boolean}
-- } = {}

-- function AbilityService:Init()
--     -- Listen for ability usage from clients
--     UseAbility.OnServerEvent:Connect(function(player: Player, abilityName: string)
--         -- Check if the player can use abilities and if the ability is available
--         local playerData = cache[player]
--         if playerData and playerData.canUse and table.find(playerData.abilities, abilityName) then
--             -- Handle ability usage logic here (e.g., apply effects, start cooldowns, etc.)
--             print("Server verified ability usage for player:", player.Name, " Ability:", abilityName)
--             -- Update the player's ability state and notify them
--             playerData.canUse = false -- Example: set canUse to false to simulate cooldown
--             AbilityStateChanged:FireClient(player, playerData.canUse, playerData.abilities, "Ability used successfully.")
--         else
--             AbilityStateChanged:FireClient(player, false, playerData and playerData.abilities or {}, "Cannot use this ability.")
--         end
--     end)
-- end

-- return AbilityService