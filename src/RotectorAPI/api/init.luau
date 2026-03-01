local Core = {}

Core.User = require(script.user)
Core.Group = require(script.groups)
Core.Config = require(script.config)

function Core.getBaseURL()
    warn("[ROTECTOR API] Core.getBaseURL is deprecated. Use Config.BaseURL instead.")
    return Core.Config.BaseURL
end

function Core.fetchUser(userId)
    warn("[ROTECTOR API] Core.fetchUser is deprecated. Use User.UserLookUp instead.")
    return Core.User.UserLookUp(userId)
end

function Core.fetch(userId)
    warn("[ROTECTOR API] Core.fetch is deprecated. Use User.UserLookUp instead.")
    return Core.User.UserLookUp(userId)
end

return Core
