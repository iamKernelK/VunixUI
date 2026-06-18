-- [[ Kernel UI Library | Ultra Modern Solid Edition ]]
-- [[ Optimized, Memory-Safe, Rounded Elements & PopUps ]]

local KernelLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

-- ثيم عصري صلب جداً (بدون شفافية تخرب التصميم)
local Theme = {
    Background = Color3.fromRGB(18, 18, 24),    -- لون ليلي صلب
    Sidebar = Color3.fromRGB(25, 25, 33),       -- لون جانبي صلب
    ElementBg = Color3.fromRGB(32, 32, 44),     -- لون العناصر صلب
    ElementHover = Color3.fromRGB(45, 45, 60),  -- لون التأشير
    ActiveTabBg = Color3.fromRGB(90, 100, 255), -- لون التاب النشط (أزرق حديث)
    Text = Color3.fromRGB(255, 255, 255),       -- أبيض ناصع
    SubText = Color3.fromRGB(170, 170, 190),    -- رمادي فاتح
    Accent = Color3.fromRGB(90, 100, 255),      -- اللون الأساسي (Accent)
    Danger = Color3.fromRGB(255, 60, 80)        -- أحمر زر الحذف
}

local function GetSafeUIFolder()
    if gethui then 
        local success, result = pcall(gethui)
        if success and result then return result end
    end
    return pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or Player:WaitForChild("PlayerGui")
end

local function Tween(obj, props, time)
    local tween = TweenService:Create(obj, TweenInfo.new(time or 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

function KernelLib:CreateWindow(Config)
    local hubName = Config.Title or "Kernel Hub"
    local ScreenGuiParent = GetSafeUIFolder()
    
    if ScreenGuiParent:FindFirstChild("KernelHubUI") then 
        ScreenGuiParent.KernelHubUI:Destroy() 
    end

    local ScreenGui = Instance.new("ScreenGui", ScreenGuiParent)
    ScreenGui.Name = "KernelHubUI"
    ScreenGui.ResetOnSpawn = false

    -- جدول لحفظ الأحداث (Events) لتنظيف الذاكرة لاحقاً
    local ConnectionCache = {}
    local function AddConnection(conn)
        table.insert(ConnectionCache, conn)
    end

    -- الواجهة الرئيسية
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.fromOffset(680, 480)
    Main.Position = UDim2.new(0.5, -340, 0.5, -240)
    Main.BackgroundColor3 = Theme.Background
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Color = Theme.Accent
    MainStroke.Thickness = 1.5

    -- أنميشن الدخول
    Main.Size = UDim2.fromOffset(0, 0)
    Tween(Main, {Size = UDim2.fromOffset(680, 480)}, 0.5)

    -- نظام البوب أب (Pop-Up)
    local PopupOverlay = Instance.new("Frame", ScreenGui)
    PopupOverlay.Size = UDim2.new(1, 0, 1, 0)
    PopupOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    PopupOverlay.BackgroundTransparency = 1
    PopupOverlay.Visible = false
    PopupOverlay.ZIndex = 100

    local PopupFrame = Instance.new("Frame", PopupOverlay)
    PopupFrame.Size = UDim2.fromOffset(300, 220)
    PopupFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
    PopupFrame.BackgroundColor3 = Theme.Sidebar
    PopupFrame.ZIndex = 101
    Instance.new("UICorner", PopupFrame).CornerRadius = UDim.new(0, 12)
    
    local PopStroke = Instance.new("UIStroke", PopupFrame)
    PopStroke.Color = Theme.Accent
    PopStroke.Thickness = 2

    local PopTitle = Instance.new("TextLabel", PopupFrame)
    PopTitle.Size = UDim2.new(1, 0, 0, 40)
    PopTitle.BackgroundTransparency = 1
    PopTitle.Text = "Title"
    PopTitle.TextColor3 = Theme.Text
    PopTitle.Font = Enum.Font.GothamBold
    PopTitle.TextSize = 18
    PopTitle.ZIndex = 102

    local PopDesc = Instance.new("TextLabel", PopupFrame)
    PopDesc.Size = UDim2.new(1, -30, 0, 40)
    PopDesc.Position = UDim2.new(0, 15, 0, 40)
    PopDesc.BackgroundTransparency = 1
    PopDesc.Text = "Description"
    PopDesc.TextColor3 = Theme.SubText
    PopDesc.Font = Enum.Font.GothamMedium
    PopDesc.TextSize = 13
    PopDesc.TextWrapped = true
    PopDesc.ZIndex = 102

    -- أزرار البوب أب (واحد فوق الثاني)
    local PopBtnContainer = Instance.new("Frame", PopupFrame)
    PopBtnContainer.Size = UDim2.new(1, -40, 0, 100)
    PopBtnContainer.Position = UDim2.new(0, 20, 0, 100)
    PopBtnContainer.BackgroundTransparency = 1
    
    local PopLayout = Instance.new("UIListLayout", PopBtnContainer)
    PopLayout.FillDirection = Enum.FillDirection.Vertical
    PopLayout.Padding = UDim.new(0, 10)
    PopLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function CreatePopBtn(text, bgColor)
        local btn = Instance.new("TextButton", PopBtnContainer)
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.BackgroundColor3 = bgColor
        btn.Text = text
        btn.TextColor3 = Theme.Text
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.ZIndex = 102
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        return btn
    end

    local BtnTop = CreatePopBtn("Confirm", Theme.Accent)
    local BtnBottom = CreatePopBtn("Cancel", Theme.ElementBg)

    local function ShowPopup(title, desc, topText, topCb, bottomText, bottomCb)
        PopTitle.Text = title
        PopDesc.Text = desc
        BtnTop.Text = topText
        BtnBottom.Text = bottomText

        local tConn, bConn
        tConn = BtnTop.MouseButton1Click:Connect(function()
            tConn:Disconnect(); bConn:Disconnect()
            Tween(PopupOverlay, {BackgroundTransparency = 1}, 0.2)
            local t = Tween(PopupFrame, {Size = UDim2.fromOffset(0,0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.2)
            t.Completed:Wait()
            PopupOverlay.Visible = false
            if topCb then topCb() end
        end)

        bConn = BtnBottom.MouseButton1Click:Connect(function()
            tConn:Disconnect(); bConn:Disconnect()
            Tween(PopupOverlay, {BackgroundTransparency = 1}, 0.2)
            local t = Tween(PopupFrame, {Size = UDim2.fromOffset(0,0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.2)
            t.Completed:Wait()
            PopupOverlay.Visible = false
            if bottomCb then bottomCb() end
        end)

        PopupOverlay.Visible = true
        PopupFrame.Size = UDim2.fromOffset(0, 0)
        PopupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        Tween(PopupOverlay, {BackgroundTransparency = 0.6}, 0.3)
        Tween(PopupFrame, {Size = UDim2.fromOffset(300, 220), Position = UDim2.new(0.5, -150, 0.5, -110)}, 0.3)
    end

    -- الشريط العلوي (TopBar)
    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundColor3 = Theme.Sidebar
    TopBar.BorderSizePixel = 0
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)
    
    local BottomSquare = Instance.new("Frame", TopBar)
    BottomSquare.Size = UDim2.new(1, 0, 0, 12)
    BottomSquare.Position = UDim2.new(0, 0, 1, -12)
    BottomSquare.BackgroundColor3 = Theme.Sidebar
    BottomSquare.BorderSizePixel = 0

    local HubTitle = Instance.new("TextLabel", TopBar)
    HubTitle.Size = UDim2.new(0, 300, 1, 0)
    HubTitle.Position = UDim2.new(0, 20, 0, 0)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = hubName
    HubTitle.TextColor3 = Theme.Text
    HubTitle.Font = Enum.Font.GothamBold
    HubTitle.TextSize = 18
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.fromOffset(30, 30)
    CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
    CloseBtn.BackgroundColor3 = Theme.ElementBg
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Theme.Danger
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

    CloseBtn.MouseButton1Click:Connect(function()
        ShowPopup(
            "Close Kernel",
            "Are you sure you want to completely destroy the UI?",
            "Yes, Destroy", function()
                -- أنميشن الحذف الخرافي وتنظيف الذاكرة
                local destructTween = TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = UDim2.fromOffset(0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                })
                destructTween:Play()
                destructTween.Completed:Connect(function()
                    for _, conn in pairs(ConnectionCache) do
                        conn:Disconnect() -- تنظيف الذاكرة بالكامل هنا
                    end
                    ScreenGui:Destroy()
                end)
            end,
            "Cancel", function() end
        )
    end)

    -- نظام السحب (Dragging) سلس
    local dragging, dragStart, startPos
    AddConnection(TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = Main.Position
        end
    end))
    AddConnection(TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end))
    AddConnection(UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end))

    -- القائمة الجانبية والمحتوى
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 180, 1, -60)
    Sidebar.Position = UDim2.new(0, 10, 0, 50)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

    local TabsScroll = Instance.new("ScrollingFrame", Sidebar)
    TabsScroll.Size = UDim2.new(1, -10, 1, -10)
    TabsScroll.Position = UDim2.new(0, 5, 0, 5)
    TabsScroll.BackgroundTransparency = 1
    TabsScroll.ScrollBarThickness = 0
    
    local TabsLayout = Instance.new("UIListLayout", TabsScroll)
    TabsLayout.Padding = UDim.new(0, 6)
    TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabsScroll.CanvasSize = UDim2.new(0, 0, 0, TabsLayout.AbsoluteContentSize.Y + 10)
    end)

    local ContentContainer = Instance.new("Frame", Main)
    ContentContainer.Size = UDim2.new(1, -210, 1, -60)
    ContentContainer.Position = UDim2.new(0, 200, 0, 50)
    ContentContainer.BackgroundTransparency = 1

    local WindowObj = {}
    local ActiveTab = nil

    function WindowObj:CreateTab(tabName)
        local TabBtn = Instance.new("TextButton", TabsScroll)
        TabBtn.Size = UDim2.new(1, -4, 0, 38)
        TabBtn.BackgroundColor3 = Theme.ElementBg
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Theme.SubText
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 13
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8) -- زوايا مستديرة للتابات

        local TabPage = Instance.new("ScrollingFrame", ContentContainer)
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.ScrollBarThickness = 2
        TabPage.ScrollBarImageColor3 = Theme.Accent
        TabPage.Visible = false
        
        local PageLayout = Instance.new("UIListLayout", TabPage)
        PageLayout.Padding = UDim.new(0, 10)
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            if ActiveTab then
                ActiveTab.Page.Visible = false
                Tween(ActiveTab.Btn, {BackgroundColor3 = Theme.ElementBg, TextColor3 = Theme.SubText}, 0.2)
            end
            ActiveTab = {Page = TabPage, Btn = TabBtn}
            TabPage.Visible = true
            Tween(TabBtn, {BackgroundColor3 = Theme.ActiveTabBg, TextColor3 = Theme.Text}, 0.2)
        end)

        local Elements = {}

        -- تصميم Slider احترافي وناعم
        function Elements:CreateSlider(name, min, max, default, callback)
            local SlBg = Instance.new("Frame", TabPage)
            SlBg.Size = UDim2.new(1, -10, 0, 60)
            SlBg.BackgroundColor3 = Theme.ElementBg
            Instance.new("UICorner", SlBg).CornerRadius = UDim.new(0, 8)

            local Title = Instance.new("TextLabel", SlBg)
            Title.Size = UDim2.new(1, -20, 0, 25)
            Title.Position = UDim2.new(0, 10, 0, 5)
            Title.BackgroundTransparency = 1
            Title.Text = name
            Title.TextColor3 = Theme.Text
            Title.Font = Enum.Font.GothamBold
            Title.TextSize = 13
            Title.TextXAlignment = Enum.TextXAlignment.Left

            local ValLabel = Instance.new("TextLabel", SlBg)
            ValLabel.Size = UDim2.new(0, 50, 0, 25)
            ValLabel.Position = UDim2.new(1, -60, 0, 5)
            ValLabel.BackgroundTransparency = 1
            ValLabel.Text = tostring(default)
            ValLabel.TextColor3 = Theme.Accent
            ValLabel.Font = Enum.Font.GothamBold
            ValLabel.TextSize = 13
            ValLabel.TextXAlignment = Enum.TextXAlignment.Right

            local Track = Instance.new("Frame", SlBg)
            Track.Size = UDim2.new(1, -20, 0, 8)
            Track.Position = UDim2.new(0, 10, 0, 38)
            Track.BackgroundColor3 = Theme.Sidebar
            Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

            local Fill = Instance.new("Frame", Track)
            Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Theme.Accent
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

            local dragging = false
            local function move(input)
                local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                local val = math.floor(min + ((max - min) * pos))
                ValLabel.Text = tostring(val)
                Tween(Fill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.1)
                if callback then pcall(callback, val) end
            end

            AddConnection(Track.InputBegan:Connect(function(inp) 
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; move(inp) end 
            end))
            AddConnection(UserInputService.InputEnded:Connect(function(inp) 
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end 
            end))
            AddConnection(UserInputService.InputChanged:Connect(function(inp) 
                if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then move(inp) end 
            end))
        end

        -- Dropdown صلب وناعم بدون مربعات
        function Elements:CreateDropdown(name, options, callback)
            local DropBg = Instance.new("Frame", TabPage)
            DropBg.Size = UDim2.new(1, -10, 0, 45)
            DropBg.BackgroundColor3 = Theme.ElementBg
            DropBg.ClipsDescendants = true
            Instance.new("UICorner", DropBg).CornerRadius = UDim.new(0, 8)

            local DropBtn = Instance.new("TextButton", DropBg)
            DropBtn.Size = UDim2.new(1, 0, 0, 45)
            DropBtn.BackgroundTransparency = 1
            DropBtn.Text = "  " .. name .. " : Select"
            DropBtn.TextColor3 = Theme.Text
            DropBtn.Font = Enum.Font.GothamBold
            DropBtn.TextSize = 13
            DropBtn.TextXAlignment = Enum.TextXAlignment.Left

            local DropList = Instance.new("UIListLayout", DropBg)
            DropList.Padding = UDim.new(0, 5)
            DropList.HorizontalAlignment = Enum.HorizontalAlignment.Center

            local isOpen = false
            DropBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                local targetSize = isOpen and (DropList.AbsoluteContentSize.Y + 10) or 45
                Tween(DropBg, {Size = UDim2.new(1, -10, 0, targetSize)}, 0.3)
            end)

            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton", DropBg)
                OptBtn.Size = UDim2.new(1, -16, 0, 35)
                OptBtn.BackgroundColor3 = Theme.Sidebar
                OptBtn.Text = opt
                OptBtn.TextColor3 = Theme.SubText
                OptBtn.Font = Enum.Font.GothamMedium
                OptBtn.TextSize = 12
                Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 6)

                OptBtn.MouseEnter:Connect(function() Tween(OptBtn, {BackgroundColor3 = Theme.ElementHover, TextColor3 = Theme.Text}, 0.2) end)
                OptBtn.MouseLeave:Connect(function() Tween(OptBtn, {BackgroundColor3 = Theme.Sidebar, TextColor3 = Theme.SubText}, 0.2) end)

                OptBtn.MouseButton1Click:Connect(function()
                    DropBtn.Text = "  " .. name .. " : " .. opt
                    isOpen = false
                    Tween(DropBg, {Size = UDim2.new(1, -10, 0, 45)}, 0.3)
                    if callback then pcall(callback, opt) end
                end)
            end
        end

        return Elements
    end

    return WindowObj
end

return KernelLib