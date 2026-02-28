local GroupLookup = {}
local HttpService = game:GetService("HttpService")
local Config = require(script.Parent.config)

function GroupLookup.GroupLookUp(groupId)
    local success, response = pcall(function()
        return HttpService:GetAsync(Config.BaseURL .. "/v1/lookup/roblox/group/" .. groupId)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        return data
    else
        warn("[ROTECTOR API] Failed to fetch group data: " .. tostring(response))
        return nil
    end
end

function GroupLookup.GroupFlagStatusLookup(groupId)
    local success, response = pcall(function()
        return HttpService:GetAsync(Config.BaseURL .. "/v1/lookup/roblox/group/" .. groupId .. "/plaintext")
    end)

    if success then
        return response
    else
        warn("[ROTECTOR API] Failed to fetch group flag status: " .. tostring(response))
        return nil
    end
end

function GroupLookup.LookUpGroupByBatch(groupIds, excludeInfo)
    local body = HttpService:JSONEncode({
        ids = groupIds,
        excludeInfo = excludeInfo or false
    })

    local success, response = pcall(function()
        return HttpService:PostAsync(Config.BaseURL .. "/v1/lookup/roblox/group", body, Enum.HttpContentType.ApplicationJson)
    end)
    
    if success then
        local data = HttpService:JSONDecode(response)
        return data
    else
        warn("[ROTECTOR API] Failed to fetch batch group data: " .. tostring(response))
        return nil
    end
end

function GroupLookup.LookUpTrackedUsers(groupId)
    local success, response = pcall(function()
        return HttpService:GetAsync(Config.BaseURL .. "/v1/lookup/roblox/group/" .. groupId .. "/tracked-users")
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        return data
    else
        warn("[ROTECTOR API] Failed to fetch tracked users for group: " .. tostring(response))
        return nil
    end
end

return GroupLookup