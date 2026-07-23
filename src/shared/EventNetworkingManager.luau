local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(game:GetService("ReplicatedStorage").Shared.util.Promise)

local EventNetworkingManager = {}

function EventNetworkingManager:GetRemoteEvent(eventName: string): RemoteEvent
    if RunService:IsServer() then
        -- Check if the RemoteEvent already exists on the server
        local event = game.ReplicatedStorage.Shared.Events:FindFirstChild(eventName)
        if event and event:IsA("RemoteEvent") then
            return event
        else
            -- Create a new RemoteEvent if it doesn't exist
            local newEvent = Instance.new("RemoteEvent")
            newEvent.Name = eventName
            newEvent.Parent = game.ReplicatedStorage.Shared.Events
            return newEvent
        end
    end
end

function EventNetworkingManager:GetBindableEvent(eventName: string): BindableEvent
     if RunService:IsServer() then
        -- Check if the BindableEvent already exists on the server
        local event = game.ReplicatedStorage.Shared.Events:FindFirstChild(eventName)
        if event and event:IsA("BindableEvent") then
            return event
        else
            -- Create a new RemoteEvent if it doesn't exist
            local newEvent = Instance.new("BindableEvent")
            newEvent.Name = eventName
            newEvent.Parent = game.ReplicatedStorage.Shared.Events
            return newEvent
        end
    end
end

local function remoteEventIsCreated(eventName: string): Promise
    return Promise.fromEvent(ReplicatedStorage.Shared.Events.ChildAdded, function(child)
        return child.Name == eventName and child:IsA("RemoteEvent")
    end)
end

function EventNetworkingManager:GetRemoteEventAsyncClient(eventName: string): Promise
    if RunService:IsClient() then

        return Promise.new(function(resolve, reject)
            local event = ReplicatedStorage.Shared.Events:FindFirstChild(eventName)
            if event and event:IsA("RemoteEvent") then
                resolve(event)
            else
                remoteEventIsCreated(eventName):andThen(function(newEvent: RemoteEvent)
                    resolve(newEvent)
                end):catch(function(err)
                    reject(err)
                end)
            end
        end)

    end
end

return EventNetworkingManager