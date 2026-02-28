# the rotector api
very cool and cute libary for your roblox game


# documents
comming soon :3

# quick example :

```luau
-- simple script detecting accounts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RotectorAPI = require(ReplicatedStorage.RotectorAPI) -- depends for where you store is. for best store the package at ReplicatedStorage/RotectorAPI
RotectorAPI.Init()

Players.PlayerAdded:Connect(function(player)
	local response = RotectorAPI.Core.fetchUser(player.UserId)
	
	if response and response.success and response.data.flagType ~= 0 then
		player:Kick("yo watch your behaviours")
        -- you can do a lot more! (etc punishment them by sending something scary to their gui)
	end
end)
```

# Please donate to the Rotector Team! (No pressure)
If you think Rotector is doing the right thing, consider donate to them! AI API calls are high nowdays, you can help the Rotector Team by donating to them!

https://ko-fi.com/jaxron

(This is myself telling you to donate. no one forced me to do all of this)
