-- [[ VunixUI | Panda Theme & Highly Optimized Edition 2026 ]]
-- [[ Fully Lag-Free, Feature-Rich & Lightweight ]]

local VunixLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

-- ثيم ألوان الباندا الفخم مع لمسة الخيزران الحيوية
local Theme = {
    Background = Color3.fromRGB(15, 15, 17),       -- أسود الباندا الداكن
    Sidebar = Color3.fromRGB(23, 23, 26),          -- رمادي الفحم الداكن
    ElementBg = Color3.fromRGB(28, 28, 31),        -- خلفية العناصر
    ElementHover = Color3.fromRGB(36, 36, 40),     -- عند مرور الماوس
    ActiveTabBg = Color3.fromRGB(40, 40, 45),      -- التاب النشط
    Text = Color3.fromRGB(255, 255, 255),          -- أبيض صافي
    SubText = Color3.fromRGB(165, 165, 170),       -- رمادي الباندا الفاتح
    Accent = Color3.fromRGB(130, 205, 140),        -- أخضر الخيزران (بامبو) للمسات الإبداعية
    ToggleOn = Color3.fromRGB(130, 205, 140),
    ToggleOff = Color3.fromRGB(55, 55, 60),
    Danger = Color3.fromRGB(255, 85, 85)
}

local function GetSafeUIFolder()
    if gethui then
        local success, result = pcall(gethui)
        if success and result then return result end
    end
    return pcall(function() return CoreGui end) and CoreGui or Player:WaitForChild("PlayerGui")
end

local function SmoothTween(obj, props, time)
    local tween = TweenService:Create(obj, TweenInfo.new(time or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

-- ════════════════════════════════════════════════
-- نظام الإشعارات (Notifications)
-- ════════════════════════════════════════════════
local NotifyScreen = Instance.new("ScreenGui", GetSafeUIFolder())
NotifyScreen.Name = "VunixNotifications"

local NotifyHolder = Instance.new("Frame", NotifyScreen)
NotifyHolder.Size = UDim2.new(0, 300, 1, 0)
NotifyHolder.Position = UDim2.new(1, -310, 0, 10)
NotifyHolder.BackgroundTransparency = 1

local NotifyLayout = Instance.new("UIListLayout", NotifyHolder)
NotifyLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifyLayout.Padding = UDim.new(0, 8)

function VunixLib:Notification(title, desc, duration)
    local Notif = Instance.new("Frame", NotifyHolder)
    Notif.Size = UDim2.new(1, 0, 0, 60)
    Notif.BackgroundColor3 = Theme.Sidebar
    Notif.BackgroundTransparency = 1
    Instance.new("UICorner", Notif).CornerRadius = UDim.new(0, 6)
    local Stroke = Instance.new("UIStroke", Notif)
    Stroke.Color = Theme.ElementHover
    Stroke.Transparency = 1

    local TitleLbl = Instance.new("TextLabel", Notif)
    TitleLbl.Size = UDim2.new(1, -20, 0, 25)
    TitleLbl.Position = UDim2.fromOffset(10, 5)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = title
    TitleLbl.TextColor3 = Theme.Accent
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.TextSize = 13
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local DescLbl = Instance.new("TextLabel", Notif)
    DescLbl.Size = UDim2.new(1, -20, 0, 25)
    DescLbl.Position = UDim2.fromOffset(10, 25)
    DescLbl.BackgroundTransparency = 1
    DescLbl.Text = desc
    DescLbl.TextColor3 = Theme.Text
    DescLbl.Font = Enum.Font.Gotham
    DescLbl.TextSize = 11
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left

    SmoothTween(Notif, {BackgroundTransparency = 0}, 0.2)
    SmoothTween(Stroke, {Transparency = 0}, 0.2)

    task.delay(duration or 3, function()
        SmoothTween(Notif, {BackgroundTransparency = 1}, 0.2)
        SmoothTween(Stroke, {Transparency = 1}, 0.2)
        task.wait(0.2)
        Notif:Destroy()
    end)
end

-- ════════════════════════════════════════════════
-- إنشاء النافذة الرئيسية
-- ════════════════════════════════════════════════
function VunixLib:CreateWindow(Config)
    local hubName = Config.Title or "Vunix Panda Pro"
    
    local ScreenGuiParent = GetSafeUIFolder()
    if ScreenGuiParent:FindFirstChild("VunixPandaUI") then 
        ScreenGuiParent.VunixPandaUI:Destroy() 
    end

    local ScreenGui = Instance.new("ScreenGui", ScreenGuiParent)
    ScreenGui.Name = "VunixPandaUI"
    ScreenGui.ResetOnSpawn = false

    -- شريط التصغير العلوي (Top Pill)
    local TopPill = Instance.new("TextButton", ScreenGui)
    TopPill.Size = UDim2.fromOffset(200, 36)
    TopPill.Position = UDim2.new(0.5, -100, 0, -50)
    TopPill.BackgroundColor3 = Theme.Background
    TopPill.Text = "🐾  " .. hubName
    TopPill.TextColor3 = Theme.Text
    TopPill.Font = Enum.Font.GothamMedium
    TopPill.TextSize = 13
    TopPill.AutoButtonColor = false
    Instance.new("UICorner", TopPill).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", TopPill).Color = Theme.ElementHover
    
    -- النافذة الأساسية (خفيفة وبدون وزن زائد)
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.fromOffset(600, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.BackgroundColor3 = Theme.Background
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", Main).Color = Theme.ElementHover

    -- شريط التحكم العلوي
    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundTransparency = 1

    local HubTitle = Instance.new("TextLabel", TopBar)
    HubTitle.Size = UDim2.new(0, 300, 1, 0)
    HubTitle.Position = UDim2.new(0, 15, 0, 0)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = "🐼 " .. hubName
    HubTitle.TextColor3 = Theme.Text
    HubTitle.Font = Enum.Font.GothamBold
    HubTitle.TextSize = 14
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left

    local Controls = Instance.new("Frame", TopBar)
    Controls.Size = UDim2.new(0, 100, 1, 0)
    Controls.Position = UDim2.new(1, -110, 0, 0)
    Controls.BackgroundTransparency = 1

    local ControlsLayout = Instance.new("UIListLayout", Controls)
    ControlsLayout.FillDirection = Enum.FillDirection.Horizontal
    ControlsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ControlsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ControlsLayout.Padding = UDim.new(0, 8)

    local function CreateTopButton(iconText, color)
        local btn = Instance.new("TextButton", Controls)
        btn.Size = UDim2.fromOffset(28, 28)
        btn.BackgroundColor3 = Theme.Sidebar
        btn.Text = iconText
        btn.TextColor3 = color or Theme.SubText
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        return btn
    end

    local MinimizeBtn = CreateTopButton("—")
    local CloseBtn = CreateTopButton("✕", Theme.Danger)

    -- نظام سحب سلس ومحسن للأداء
    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- نافذة التأكيد قبل الإغلاق
    local DialogOverlay = Instance.new("Frame", Main)
    DialogOverlay.Size = UDim2.new(1, 0, 1, 0)
    DialogOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    DialogOverlay.BackgroundTransparency = 1
    DialogOverlay.Visible = false
    DialogOverlay.ZIndex = 100

    local DialogBox = Instance.new("Frame", DialogOverlay)
    DialogBox.Size = UDim2.fromOffset(280, 130)
    DialogBox.Position = UDim2.new(0.5, -140, 0.5, -65)
    DialogBox.BackgroundColor3 = Theme.Sidebar
    Instance.new("UICorner", DialogBox).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", DialogBox).Color = Theme.ElementHover

    local DialogTitle = Instance.new("TextLabel", DialogBox)
    DialogTitle.Size = UDim2.new(1, -20, 0, 30)
    DialogTitle.Position = UDim2.fromOffset(10, 10)
    DialogTitle.BackgroundTransparency = 1
    DialogTitle.Text = "Close Script?"
    DialogTitle.TextColor3 = Theme.Text
    DialogTitle.Font = Enum.Font.GothamBold
    DialogTitle.TextSize = 14

    local CancelBtn = Instance.new("TextButton", DialogBox)
    CancelBtn.Size = UDim2.new(0.45, 0, 0, 32)
    CancelBtn.Position = UDim2.new(0, 10, 1, -42)
    CancelBtn.BackgroundColor3 = Theme.ElementBg
    CancelBtn.Text = "Cancel"
    CancelBtn.TextColor3 = Theme.Text
    CancelBtn.Font = Enum.Font.GothamMedium
    Instance.new("UICorner", CancelBtn).CornerRadius = UDim.new(0, 6)

    local ConfirmBtn = Instance.new("TextButton", DialogBox)
    ConfirmBtn.Size = UDim2.new(0.45, 0, 0, 32)
    ConfirmBtn.Position = UDim2.new(1, -135, 1, -42)
    ConfirmBtn.BackgroundColor3 = Theme.Danger
    ConfirmBtn.Text = "Exit"
    ConfirmBtn.TextColor3 = Theme.Text
    ConfirmBtn.Font = Enum.Font.GothamMedium
    Instance.new("UICorner", ConfirmBtn).CornerRadius = UDim.new(0, 6)

    CloseBtn.MouseButton1Click:Connect(function()
        DialogOverlay.Visible = true
        SmoothTween(DialogOverlay, {BackgroundTransparency = 0.5}, 0.2)
    end)
    CancelBtn.MouseButton1Click:Connect(function()
        SmoothTween(DialogOverlay, {BackgroundTransparency = 1}, 0.2).Completed:Connect(function()
            DialogOverlay.Visible = false
        end)
    end)
    ConfirmBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    MinimizeBtn.MouseButton1Click:Connect(function()
        Main.Visible = false
        SmoothTween(TopPill, {Position = UDim2.new(0.5, -100, 0, 15)}, 0.2)
    end)
    TopPill.MouseButton1Click:Connect(function()
        SmoothTween(TopPill, {Position = UDim2.new(0.5, -100, 0, -50)}, 0.2)
        Main.Visible = true
    end)

    -- هيكل القائمة الجانبية والمحتوى
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 150, 1, -55)
    Sidebar.Position = UDim2.new(0, 10, 0, 45)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

    local ContentContainer = Instance.new("Frame", Main)
    ContentContainer.Size = UDim2.new(1, -180, 1, -55)
    ContentContainer.Position = UDim2.new(0, 170, 0, 45)
    ContentContainer.BackgroundTransparency = 1

    local TabsScroll = Instance.new("ScrollingFrame", Sidebar)
    TabsScroll.Size = UDim2.new(1, 0, 1, -10)
    TabsScroll.Position = UDim2.new(0, 0, 0, 5)
    TabsScroll.BackgroundTransparency = 1
    TabsScroll.ScrollBarThickness = 0
    local TabsLayout = Instance.new("UIListLayout", TabsScroll)
    TabsLayout.Padding = UDim.new(0, 4)

    local WindowObj = {}
    local ActiveTab = nil

    function WindowObj:CreateTab(tabName)
        local TabBtn = Instance.new("TextButton", TabsScroll)
        TabBtn.Size = UDim2.new(1, -12, 0, 34)
        TabBtn.Position = UDim2.new(0, 6, 0, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = "  " .. tabName
        TabBtn.TextColor3 = Theme.SubText
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextSize = 12
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local Indicator = Instance.new("Frame", TabBtn)
        Indicator.Size = UDim2.new(0, 3, 0, 0)
        Indicator.Position = UDim2.new(0, 2, 0.5, 0)
        Indicator.BackgroundColor3 = Theme.Accent
        Indicator.AnchorPoint = Vector2.new(0, 0.5)
        Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

        local TabPage = Instance.new("ScrollingFrame", ContentContainer)
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.ScrollBarThickness = 2
        TabPage.Visible = false
        
        local PageLayout = Instance.new("UIListLayout", TabPage)
        PageLayout.Padding = UDim.new(0, 6)
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            if ActiveTab then
                ActiveTab.Page.Visible = false
                ActiveTab.Btn.BackgroundTransparency = 1
                ActiveTab.Btn.TextColor3 = Theme.SubText
                SmoothTween(ActiveTab.Indicator, {Size = UDim2.new(0, 3, 0, 0)}, 0.1)
            end
            ActiveTab = {Page = TabPage, Btn = TabBtn, Indicator = Indicator}
            TabPage.Visible = true
            TabBtn.BackgroundTransparency = 0
            TabBtn.BackgroundColor3 = Theme.ActiveTabBg
            TabBtn.TextColor3 = Theme.Text
            SmoothTween(Indicator, {Size = UDim2.new(0, 3, 0, 16)}, 0.1)
        end)

        if not ActiveTab then
            ActiveTab = {Page = TabPage, Btn = TabBtn, Indicator = Indicator}
            TabPage.Visible = true
            TabBtn.BackgroundTransparency = 0
            TabBtn.BackgroundColor3 = Theme.ActiveTabBg
            TabBtn.TextColor3 = Theme.Text
            Indicator.Size = UDim2.new(0, 3, 0, 16)
        end

        local Elements = {}

        -- 1. عنوان جانبي لتنظيم العناصر (Section)
        function Elements:CreateSection(title)
            local SecLabel = Instance.new("TextLabel", TabPage)
            SecLabel.Size = UDim2.new(1, 0, 0, 25)
            SecLabel.BackgroundTransparency = 1
            SecLabel.Text = "— " .. title
            SecLabel.TextColor3 = Theme.Accent
            SecLabel.Font = Enum.Font.GothamBold
            SecLabel.TextSize = 11
            SecLabel.TextXAlignment = Enum.TextXAlignment.Left
        end

        -- 2. زر المتبدل السلس (Toggle)
        function Elements:CreateToggle(title, defaultState, callback)
            local State = defaultState or false
            local ToggleBg = Instance.new("TextButton", TabPage)
            ToggleBg.Size = UDim2.new(1, 0, 0, 38)
            ToggleBg.BackgroundColor3 = Theme.ElementBg
            ToggleBg.Text = ""
            Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 6)

            local TitleLabel = Instance.new("TextLabel", ToggleBg)
            TitleLabel.Size = UDim2.new(1, -60, 1, 0)
            TitleLabel.Position = UDim2.new(0, 12, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Track = Instance.new("Frame", ToggleBg)
            Track.Size = UDim2.fromOffset(34, 16)
            Track.Position = UDim2.new(1, -46, 0.5, -8)
            Track.BackgroundColor3 = State and Theme.ToggleOn or Theme.ToggleOff
            Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

            local Knob = Instance.new("Frame", Track)
            Knob.Size = UDim2.fromOffset(12, 12)
            Knob.Position = State and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
            Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

            ToggleBg.MouseButton1Click:Connect(function()
                State = not State
                SmoothTween(Track, {BackgroundColor3 = State and Theme.ToggleOn or Theme.ToggleOff}, 0.15)
                SmoothTween(Knob, {Position = State and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)}, 0.15)
                if callback then pcall(callback, State) end
            end)
        end

        -- 3. زر عادي (Button)
        function Elements:CreateButton(title, callback)
            local BtnBg = Instance.new("TextButton", TabPage)
            BtnBg.Size = UDim2.new(1, 0, 0, 38)
            BtnBg.BackgroundColor3 = Theme.ElementBg
            BtnBg.Text = ""
            Instance.new("UICorner", BtnBg).CornerRadius = UDim.new(0, 6)

            local TitleLabel = Instance.new("TextLabel", BtnBg)
            TitleLabel.Size = UDim2.new(1, 0, 1, 0)
            TitleLabel.Position = UDim2.new(0, 12, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            BtnBg.MouseEnter:Connect(function() SmoothTween(BtnBg, {BackgroundColor3 = Theme.ElementHover}, 0.15) end)
            BtnBg.MouseLeave:Connect(function() SmoothTween(BtnBg, {BackgroundColor3 = Theme.ElementBg}, 0.15) end)
            BtnBg.MouseButton1Click:Connect(function() if callback then pcall(callback) end end)
        end

        -- 4. منزلق خفيف (Slider)
        function Elements:CreateSlider(title, min, max, default, callback)
            local SliderBg = Instance.new("Frame", TabPage)
            SliderBg.Size = UDim2.new(1, 0, 0, 46)
            SliderBg.BackgroundColor3 = Theme.ElementBg
            Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 6)

            local TitleLabel = Instance.new("TextLabel", SliderBg)
            TitleLabel.Size = UDim2.new(1, -80, 0, 20)
            TitleLabel.Position = UDim2.new(0, 12, 0, 6)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ValueLabel = Instance.new("TextLabel", SliderBg)
            ValueLabel.Size = UDim2.new(0, 50, 0, 20)
            ValueLabel.Position = UDim2.new(1, -62, 0, 6)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(default)
            ValueLabel.TextColor3 = Theme.Accent
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.TextSize = 12
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

            local TrackBg = Instance.new("Frame", SliderBg)
            TrackBg.Size = UDim2.new(1, -24, 0, 4)
            TrackBg.Position = UDim2.new(0, 12, 0, 32)
            TrackBg.BackgroundColor3 = Theme.ToggleOff
            Instance.new("UICorner", TrackBg).CornerRadius = UDim.new(1, 0)

            local Fill = Instance.new("Frame", TrackBg)
            Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Theme.Accent
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

            local Dragging = false
            local function UpdateSlider(input)
                local pos = math.clamp((input.Position.X - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + ((max - min) * pos))
                ValueLabel.Text = tostring(value)
                Fill.Size = UDim2.new(pos, 0, 1, 0)
                if callback then pcall(callback, value) end
            end

            TrackBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true; UpdateSlider(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then Dragging = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(input)
                end
            end)
        end

        -- 5. قائمة منسدلة مطورة (Dropdown)
        function Elements:CreateDropdown(title, list, callback)
            local Expanded = false
            local DropBg = Instance.new("Frame", TabPage)
            DropBg.Size = UDim2.new(1, 0, 0, 38)
            DropBg.BackgroundColor3 = Theme.ElementBg
            DropBg.ClipsDescendants = true
            Instance.new("UICorner", DropBg).CornerRadius = UDim.new(0, 6)

            local MainBtn = Instance.new("TextButton", DropBg)
            MainBtn.Size = UDim2.new(1, 0, 0, 38)
            MainBtn.BackgroundTransparency = 1
            MainBtn.Text = ""

            local TitleLabel = Instance.new("TextLabel", MainBtn)
            TitleLabel.Size = UDim2.new(1, -40, 1, 0)
            TitleLabel.Position = UDim2.new(0, 12, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Indicator = Instance.new("TextLabel", MainBtn)
            Indicator.Size = UDim2.new(0, 30, 1, 0)
            Indicator.Position = UDim2.new(1, -35, 0, 0)
            Indicator.BackgroundTransparency = 1
            Indicator.Text = "▼"
            Indicator.TextColor3 = Theme.SubText
            Indicator.Font = Enum.Font.Gotham
            Indicator.TextSize = 10

            local OptionsContainer = Instance.new("Frame", DropBg)
            OptionsContainer.Size = UDim2.new(1, -10, 0, #list * 30)
            OptionsContainer.Position = UDim2.new(0, 5, 0, 38)
            OptionsContainer.BackgroundTransparency = 1
            local OptionLayout = Instance.new("UIListLayout", OptionsContainer)
            OptionLayout.Padding = UDim.new(0, 2)

            for _, option in ipairs(list) do
                local OptBtn = Instance.new("TextButton", OptionsContainer)
                OptBtn.Size = UDim2.new(1, 0, 0, 28)
                OptBtn.BackgroundColor3 = Theme.Sidebar
                OptBtn.Text = tostring(option)
                OptBtn.TextColor3 = Theme.SubText
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextSize = 11
                Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 4)

                OptBtn.MouseButton1Click:Connect(function()
                    TitleLabel.Text = title .. " : " .. tostring(option)
                    Expanded = false
                    SmoothTween(DropBg, {Size = UDim2.new(1, 0, 0, 38)}, 0.15)
                    Indicator.Text = "▼"
                    if callback then pcall(callback, option) end
                end)
            end

            MainBtn.MouseButton1Click:Connect(function()
                Expanded = not Expanded
                local targetHeight = Expanded and (42 + (#list * 30)) or 38
                SmoothTween(DropBg, {Size = UDim2.new(1, 0, 0, targetHeight)}, 0.15)
                Indicator.Text = Expanded and "▲" or "▼"
            end)
        end

        -- 6. صندوق إدخال نصوص (TextBox)
        function Elements:CreateTextBox(title, placeholder, callback)
            local BoxBg = Instance.new("Frame", TabPage)
            BoxBg.Size = UDim2.new(1, 0, 0, 38)
            BoxBg.BackgroundColor3 = Theme.ElementBg
            Instance.new("UICorner", BoxBg).CornerRadius = UDim.new(0, 6)

            local TitleLabel = Instance.new("TextLabel", BoxBg)
            TitleLabel.Size = UDim2.new(0.5, 0, 1, 0)
            TitleLabel.Position = UDim2.new(0, 12, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Theme.Text
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local InputBox = Instance.new("TextBox", BoxBg)
            InputBox.Size = UDim2.new(0.4, 0, 0, 26)
            InputBox.Position = UDim2.new(1, -152, 0.5, -13)
            InputBox.BackgroundColor3 = Theme.Sidebar
            InputBox.Text = ""
            InputBox.PlaceholderText = placeholder or "Type here..."
            InputBox.TextColor3 = Theme.Text
            InputBox.PlaceholderColor3 = Theme.SubText
            InputBox.Font = Enum.Font.Gotham
            InputBox.TextSize = 11
            Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 4)
            Instance.new("UIStroke", InputBox).Color = Theme.ElementHover

            InputBox.FocusLost:Connect(function(enterPressed)
                if callback then pcall(callback, InputBox.Text) end
            end)
        end

        return Elements
    end

    return WindowObj
end

return VunixLib