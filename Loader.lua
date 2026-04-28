if getgenv().CrystalLevPlatform then return end
getgenv().CrystalLevPlatform = {}

local BASE = "https://raw.githubusercontent.com/XyiBobra524/crystalev/main/"

local function require(path)
    return loadstring(game:HttpGet(BASE .. path))()
end

require("core/Services.lua")
require("core/Util.lua")
require("core/Theme.lua")
require("core/Components.lua")
require("core/Generator.lua")
require("ui/Main.lua")
require("ui/TabEditor.lua")
require("ui/ScriptEditor.lua")
require("api/Export.lua")

getgenv().CrystalLevPlatform.Loaded = true
