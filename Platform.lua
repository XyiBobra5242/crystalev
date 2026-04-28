-- CrystalLev Platform
if getgenv().CrystalLevPlatform then return end
getgenv().CrystalLevPlatform = {}

local BASE = "https://raw.githubusercontent.com/XyiBobra5242/crystalev/main/"

local function loadModule(path)
    local s, r = pcall(function()
        return loadstring(game:HttpGet(BASE .. path))()
    end)
    if not s then
        warn("[CrystalLev] Error loading: " .. path)
    end
    return r
end

loadModule("core/Services.lua")
loadModule("core/Util.lua")
loadModule("core/Theme.lua")
loadModule("core/Components.lua")
loadModule("core/Generator.lua")
loadModule("ui/Main.lua")
loadModule("ui/TabEditor.lua")
loadModule("ui/ScriptEditor.lua")
loadModule("api/Export.lua")

print("[CrystalLev] Platform loaded!")
