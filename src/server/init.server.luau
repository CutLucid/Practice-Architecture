local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteManager = require(ReplicatedStorage.Shared.RemoteManager)

task.wait(3)
local greetEvent = RemoteManager:GetRemoteEvent("GreetEvent")
local farewellEvent = RemoteManager:GetRemoteEvent("FarewellEvent")
local comebackEvent = RemoteManager:GetRemoteEvent("ComebackEvent")

local greetEventFromClient = RemoteManager:GetRemoteEvent("GreetEventFromClient")


greetEvent:FireAllClients("Hello from the server!")

farewellEvent:FireAllClients("Goodbye from the server!")

comebackEvent:FireAllClients("Welcome back from the server!")

greetEventFromClient.OnServerEvent:Connect(function(player, message)
    print(player.Name .. " says: " .. message)
end)