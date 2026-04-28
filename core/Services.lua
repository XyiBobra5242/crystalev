getgenv().CrystalLevPlatform.Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    TweenService = game:GetService("TweenService"),
    RunService = game:GetService("RunService"),
    CoreGui = game:GetService("CoreGui"),
    HttpService = game:GetService("HttpService"),
}

local Services = getgenv().CrystalLevPlatform.Services
local Player = Services.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

function getgenv().CrystalLevPlatform.GetContainer()
    local s, r = pcall(function()
        if gethui then return gethui() end
        if syn and syn.protect_gui then syn.protect_gui(PlayerGui); return PlayerGui end
        return Services.CoreGui
    end)
    return (s and r) and r or Services.CoreGui
end

function getgenv().CrystalLevPlatform.Protect(obj)
    pcall(function()
        if syn and syn.protect_gui then syn.protect_gui(obj) end
    end)
end

local GUI = getgenv().CrystalLevPlatform.GetContainer()
for _, v in pairs(GUI:GetChildren()) do
    if v.Name == "CrystalLev_Platform" then v:Destroy() end
end
