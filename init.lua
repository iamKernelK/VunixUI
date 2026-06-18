local PandaUI = {}

local Modules = script:WaitForChild("Modules")
local Components = script:WaitForChild("Components")
local ElementsFolder = Modules:WaitForChild("Elements")

local Theme = require(Modules:WaitForChild("Theme"))
local Utils = require(Modules:WaitForChild("Utilities"))
local Draggable = require(Modules:WaitForChild("Draggable"))
local WindowModule = require(Components:WaitForChild("Window"))
local TabModule = require(Components:WaitForChild("Tab"))

function PandaUI:CreateWindow(Config)
    -- هنا يحدث الدمج الأكبر: نمرر كل شيء للنافذة
    return WindowModule.new(Config, Theme, Utils, Draggable, TabModule, ElementsFolder)
end

return PandaUI
