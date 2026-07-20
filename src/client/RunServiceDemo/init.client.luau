local RunService = game:GetService("RunService")
local localPlayer = game.Players.LocalPlayer

task.wait(3)
-- create a local part
local part = Instance.new("Part")
part.Size = Vector3.new(4, 1, 2)
part.Position = Vector3.new(0, 5, 0)
part.Anchored = true
part.Parent = workspace


local offset = CFrame.new(0, 5, 0) -- Offset from the player's HumanoidRootPart

-- RunService.Heartbeat:Connect(function(deltaTime)
--     part.CFrame = localPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame * offset * CFrame.Angles(0, math.rad(90) * deltaTime, 0)
-- end)

RunService.RenderStepped:Connect(function(deltaTime)
    part.CFrame = localPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame * offset * CFrame.Angles(0, math.rad(90) * deltaTime, 0)
end)