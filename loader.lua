local Players = game:GetService("Players")
local player = Players.LocalPlayer

local games = {
    [17245824221] = {
        name = "Cave Diving Experience",
        script = function()
            print(">> Starting Cave Diving Experience Script...")
        end
    }
}

local placeId = game.PlaceId
local currentGame = games[placeId]

local loadingScreen = loadstring(game:HttpGet("", true))()

if currentGame and currentGame.script then
    loadingScreen:Start(currentGame.name or "Unknown Game", currentGame.script)
else
    warn("Unknown Game")
end