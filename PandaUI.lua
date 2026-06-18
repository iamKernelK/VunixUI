-- [[ PandaUI | Pro Bundle Edition ]]
-- Optimized for High Performance & Solid UI Design

local PandaUI = {}
PandaUI.__index = PandaUI -- استخدام الـ Metatables لسرعة استدعاء الدوال

-- [1] الكاش السريع للخدمات (Optimized Services)
-- تعريف الخدمات محلياً يجعل السكربت أسرع بكثير في قراءة البيانات
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- [2] الثيم الصلب (Strict Solid Theme)
local Theme = {
    Background = Color3.fromRGB(12, 12, 14),
    Sidebar = Color3.fromRGB(18, 18, 22),
    ElementBg = Color3.fromRGB(24, 24, 28),
    ElementHover = Color3.fromRGB(35, 35, 40),
    Text = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(0, 255, 255) -- Neon Cyan
}

-- [3] أدوات الحماية والأنميشن (Core Utilities)
local Utils = {}

function Utils.ProtectUI()
    -- نظام حماية متطور للعثور على أفضل مكان آمن للواجهة
    if gethui then
        local success, uiFolder = pcall(gethui)
        if success and uiFolder then return uiFolder end
    end
    return pcall(function() return CoreGui end) and CoreGui or Players.LocalPlayer:WaitForChild("PlayerGui")
end

function Utils.Tween(obj, props, duration)
    local tween = TS:Create(obj, TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

-- [4] محرك العناصر (Elements Engine - OOP Style)
local Elements = {}

function Elements:CreateButton(Parent, name, callback)
    local Btn = Instance.new("TextButton", Parent)
    Btn.Size = UDim2.new(1, -10, 0, 40)
    Btn.BackgroundColor3 = Theme.ElementBg
    Btn.Text = name
    Btn.TextColor3 = Theme.Text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.AutoButtonColor = false
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    -- تفاعل الألوان الصلبة (بدون شفافية)
    Btn.MouseEnter:Connect(function() Utils.Tween(Btn, {BackgroundColor3 = Theme.ElementHover}) end)
    Btn.MouseLeave:Connect(function() Utils.Tween(Btn, {BackgroundColor3 = Theme.ElementBg}) end)
    
    -- حماية الـ Callback بـ pcall لمنع انهيار السكربت إذا كان هناك خطأ في الكود
    Btn.MouseButton1Click:Connect(function()
        Utils.Tween(Btn, {TextSize = 11}, 0.1).Completed:Connect(function()
            Utils.Tween(Btn, {TextSize = 13}, 0.1)
        end)
        if callback then 
            task.spawn(function() -- استخدام task.spawn لتشغيل الدالة بدون تجميد الواجهة
                local success, err = pcall(callback)
                if not success then warn("PandaUI Error in Button:", err) end
            end)
        end
    end)
    return Btn
end

-- [5] دالة بناء الواجهة الرئيسية (The Constructor)
function PandaUI.CreateWindow(Config)
    local self = setmetatable({}, PandaUI) -- إنشاء كائن جديد للنافذة
    
    self.Title = Config.Title or "PandaUI Premium"
    local ParentFolder = Utils.ProtectUI()

    -- تنظيف الواجهات القديمة لمنع تكرار الواجهة (Memory Leak Prevention)
    if ParentFolder:FindFirstChild("PandaHubPro") then
        ParentFolder.PandaHubPro:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui", ParentFolder)
    ScreenGui.Name = "PandaHubPro"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.fromOffset(600, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = Theme.Background
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local ContentArea = Instance.new("ScrollingFrame", MainFrame)
    ContentArea.Size = UDim2.new(1, -20, 1, -50)
    ContentArea.Position = UDim2.new(0, 10, 0, 40)
    ContentArea.BackgroundTransparency = 1
    
    local Layout = Instance.new("UIListLayout", ContentArea)
    Layout.Padding = UDim.new(0, 6)

    -- ربط العناصر بالنافذة مباشرة
    self.Container = ContentArea

    return self
end

-- [6] توجيه إنشاء العناصر داخل النافذة
function PandaUI:AddButton(name, callback)
    -- هنا نستدعي مصنع العناصر ونمرر له الحاوية (Container) الخاصة بالنافذة
    return Elements:CreateButton(self.Container, name, callback)
end

return PandaUI

