local Core = {}

Core.User = require(script.user)
Core.Group = require(script.groups)
Core.Config = require(script.config)

function Core.getBaseURL()
    return Core.Config.BaseURL
end

function Core.fetchUser(userId)
    return Core.User.UserLookUp(userId)
end

function Core.fetch(userId)
    warn("[ROTECTOR API] Core.fetch is deprecated. Use Core.fetchUser instead.")
    return Core.User.UserLookUp(userId)
end

return Core
