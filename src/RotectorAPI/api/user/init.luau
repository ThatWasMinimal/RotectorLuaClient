local UserFetching = {}
local HttpService = game:GetService("HttpService")
local Config = require(script.Parent.config)

function UserFetching.UserLookUp(userId)
    local success, response = pcall(function()
        return HttpService:GetAsync(Config.BaseURL .. "/v1/lookup/roblox/user/" .. userId)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        return data
    else
        warn("[ROTECTOR API] Failed to fetch user data: " .. tostring(response))
        return nil
    end
end

function UserFetching.UserFlagStatusLookup(userId)
    local success, response = pcall(function()
        return HttpService:GetAsync(Config.BaseURL .. "/v1/lookup/roblox/user/" .. userId .. "/plaintext")
    end)

    if success then
        return response
    else
        warn("[ROTECTOR API] Failed to fetch user flag status: " .. tostring(response))
        return nil
    end
end

function UserFetching.LookUpUserByBatch(userIds, excludeInfo)
    local body = HttpService:JSONEncode({
        ids = userIds,
        excludeInfo = excludeInfo or false
    })

    local success, response = pcall(function()
        return HttpService:PostAsync(Config.BaseURL .. "/v1/lookup/roblox/user", body, Enum.HttpContentType.ApplicationJson)
    end)
    
    if success then
        local data = HttpService:JSONDecode(response)
        return data
    else
        warn("[ROTECTOR API] Failed to fetch batch user data: " .. tostring(response))
        return nil
    end
end

function UserFetching.LookUpUserCommunityAccount(userId)
    local success, response = pcall(function()
        return HttpService:GetAsync(Config.BaseURL .. "/v1/lookup/roblox/user/" .. userId .. "/discord")
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        return data
    else
        warn("[ROTECTOR API] Failed to fetch community account data: " .. tostring(response))
        return nil
    end
end

return UserFetching
