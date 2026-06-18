-- [[ PandaUI | Pro Bundle Edition ]]
-- تجميع شامل للمكتبة (الثيم + المحرك + الحماية)

local PandaUI = {}
PandaUI.__index = PandaUI

-- [1] الثيم (المدمج مباشرة)
PandaUI.Theme = {
    Background = Color3.fromRGB(12, 12, 14),
    Sidebar = Color3.fromRGB(18, 18, 22),
    ElementBg = Color3.fromRGB(24, 24, 28),
    ElementHover = Color3.fromRGB(35, 35, 40),
    ActiveTabBg = Color3.fromRGB(45, 45, 52),
    Text = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(0, 255, 255),
    GradientStart = Color3.fromRGB(140, 0, 255),
    SubText = Color3.fromRGB(160, 160, 170)
}

-- [2] الخدمات والأدوات الأساسية
local TS = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local function GetSafeUIFolder()
    if gethui then
        local success, result = pcall(gethui)
        if success and result then return result end
    end
    return CoreGui or Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- [3] محرك إنشاء النافذة
function PandaUI.CreateWindow(Config)
    local self = setmetatable({}, PandaUI)
    
    local Folder = GetSafeUIFolder()
    if Folder:FindFirstChild("PandaUI_Main") then Folder.PandaUI_Main:Destroy() end

    local ScreenGui = Instance.new("ScreenGui", Folder)
    ScreenGui.Name = "PandaUI_Main"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.fromOffset(600, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = PandaUI.Theme.Background
    
    local UIList = Instance.new("UIListLayout", MainFrame)
    UIList.Padding = UDim.new(0, 5)

    self.Gui = ScreenGui
    self.Container = MainFrame
    return self
end

-- [4] إضافة عناصر للمكتبة (مثال للزر)
function PandaUI:AddButton(name, callback)
    local Btn = Instance.new("TextButton", self.Container)
    Btn.Size = UDim2.new(1, -20, 0, 40)
    Btn.BackgroundColor3 = PandaUI.Theme.ElementBg
    Btn.Text = name
    Btn.TextColor3 = PandaUI.Theme.Text
    Btn.Font = Enum.Font.GothamBold
    
    Btn.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
    end)
    
    return Btn
end

return PandaUI
