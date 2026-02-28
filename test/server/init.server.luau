local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local RotectorAPI = require(
    ReplicatedStorage.Shared.RotectorAPI
)

RotectorAPI.Init()

print("Base URL:", RotectorAPI.Core.getBaseURL())

local response = RotectorAPI.Core.fetchUser(1)

print("Response:", HttpService:JSONEncode(response))

local batchResponse = RotectorAPI.Core.User.LookUpUserByBatch({9636217397, 8030486109, 8321477690}, true)

print("Batch Response:", HttpService:JSONEncode(batchResponse))

local communityAccount = RotectorAPI.Core.User.LookUpUserCommunityAccount(9636217397)

print("Community Accounts :", HttpService:JSONEncode(communityAccount))