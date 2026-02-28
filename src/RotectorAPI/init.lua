local RotectorAPI = {}
local initialized = false
local HttpService = game:GetService("HttpService")

local function initializeFailed()
    print("[ROTECTOR API] Initialization failed.")
end

function RotectorAPI.Init()
    if initialized then return end
    initialized = true

    print("[ROTECTOR API] Checking API")

    local success, response = pcall(function()
        return HttpService:GetAsync("https://roscoe.rotector.com/")
    end)

    if not success then
        warn("[ROTECTOR API] Failed request:", response)
        return initializeFailed()
    end

    local decodeSuccess, data = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    if not decodeSuccess or data.success ~= true then
        warn("[ROTECTOR API] API offline or bad response")
        return initializeFailed()
    end

    print("[ROTECTOR API] API is online")
    print("[ROTECTOR API] Initialization complete")
end

RotectorAPI.Core = require(script.api)

return RotectorAPI