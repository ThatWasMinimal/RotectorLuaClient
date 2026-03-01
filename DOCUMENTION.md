# RotectorAPI Documentation

## Overview
`RotectorAPI` is a Roblox package for querying Rotector safety data for Roblox users and groups.

## Requirements
- Enable `HttpService` in your game settings.
- Require the module from a shared location (commonly `ReplicatedStorage`).
- Call `RotectorAPI.Init()` once during startup.

## Installation and setup
```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RotectorAPI = require(ReplicatedStorage.RotectorAPI)
RotectorAPI.Init()
```

## Recommended usage
Use `Core.User.*` and `Core.Group.*` directly.

```luau
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RotectorAPI = require(ReplicatedStorage.RotectorAPI)
RotectorAPI.Init()

Players.PlayerAdded:Connect(function(player)
    local result = RotectorAPI.Core.User.UserLookUp(player.UserId)

    if result and result.success and result.data and result.data.flagType ~= 0 then
        player:Kick("Account flagged by Rotector")
    end
end)
```

## Public API

### `RotectorAPI`

#### `RotectorAPI.Init()`
Initializes the package and performs an API health check.
- Safe to call more than once (runs once internally).
- Logs status to output.

#### `RotectorAPI.Core`
Main namespace with `User`, `Group`, and `Config`.

### `RotectorAPI.Core.Config`

#### `BaseURL`
Current API base URL string.

#### `Version`
Package version string.

### `RotectorAPI.Core.User`

#### `UserLookUp(userId)`
Returns JSON-decoded lookup data for one Roblox user.

#### `UserFlagStatusLookup(userId)`
Returns plaintext flag status for one Roblox user.

#### `LookUpUserByBatch(userIds, excludeInfo?)`
Batch user lookup.
- `userIds`: array of Roblox user IDs.
- `excludeInfo`: optional boolean (`false` by default).

#### `LookUpUserCommunityAccount(userId)`
Returns linked community-account data for a Roblox user.

### `RotectorAPI.Core.Group`

#### `GroupLookUp(groupId)`
Returns JSON-decoded lookup data for one Roblox group.

#### `GroupFlagStatusLookup(groupId)`
Returns plaintext flag status for one Roblox group.

#### `LookUpGroupByBatch(groupIds, excludeInfo?)`
Batch group lookup.
- `groupIds`: array of Roblox group IDs.
- `excludeInfo`: optional boolean (`false` by default).

#### `LookUpTrackedUsers(groupId)`
Returns tracked users for a Roblox group.

## Deprecated helpers
These still work, but print warnings:
- `RotectorAPI.Core.fetchUser(userId)` -> use `RotectorAPI.Core.User.UserLookUp(userId)`
- `RotectorAPI.Core.fetch(userId)` -> use `RotectorAPI.Core.User.UserLookUp(userId)`
- `RotectorAPI.Core.getBaseURL()` -> use `RotectorAPI.Core.Config.BaseURL`

## Return behavior and error handling
All network calls are wrapped in `pcall`.
- Success: returns decoded JSON table (or plaintext for `*FlagStatusLookup`).
- Failure: returns `nil` and logs a warning.

Recommended guard pattern:
```luau
local data = RotectorAPI.Core.User.UserLookUp(1)
if not data then
    warn("Rotector request failed")
    return
end

if data.success then
    -- handle success
end
```

## Notes
- `src/RotectorAPI/api/community_users` exists but is not exported by `RotectorAPI.Core` in the current build.
- Current config values:
  - `BaseURL = "http://roscoe.rotector.com"`
  - `Version = "1.0.0"`
