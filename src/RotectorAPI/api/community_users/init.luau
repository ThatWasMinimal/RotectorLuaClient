local ComunityUserLookup = {}
local HttpService = game:GetService("HttpService")
local Config = require(script.Parent.config)

function ComunityUserLookup.LookUpCommunityUser(communityId)
    local success, response = pcall(function()
        return HttpService:GetAsync(Config.BaseURL .. "/v1/lookup/discord/user/" .. communityId)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        return data
    else
        warn("[ROTECTOR API] Failed to fetch community user data: " .. tostring(response))
        return nil
    end
end

function ComunityUserLookup.LookUpCommunityUsers(communityIds)
    local body = HttpService:JSONEncode({
        ids = communityIds
    })

    local success, response = pcall(function()
        return HttpService:PostAsync(Config.BaseURL .. "/v1/lookup/discord/user", body, Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        return data
    else
        warn("[ROTECTOR API] Failed to fetch batch community user data: " .. tostring(response))
        return nil
    end
end

return ComunityUserLookup