local WindowModule = {}
local TweenService = game:GetService("TweenService")

-- لاحظ أن الدالة تستقبل Theme و Utils وباقي الملفات
function WindowModule.new(Config, Theme, Utils, Draggable, TabModule, ElementsFolder)
    local ScreenGuiParent = Utils.GetSafeUIFolder()
    local ScreenGui = Instance.new("ScreenGui", ScreenGuiParent)
    ScreenGui.Name = "PandaHub"

    local Main = Instance.new("CanvasGroup", ScreenGui)
    Main.Size = UDim2.fromOffset(660, 460)
    Main.Position = UDim2.new(0.5, -330, 0.5, -230)
    Main.BackgroundColor3 = Theme.Background -- استخدام الثيم

    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundTransparency = 1
    
    -- تفعيل السحب
    Draggable(Main, TopBar)

    local TabsScroll = Instance.new("ScrollingFrame", Main)
    TabsScroll.Size = UDim2.new(0, 190, 1, -65)
    TabsScroll.Position = UDim2.new(0, 12, 0, 50)
    TabsScroll.BackgroundTransparency = 1

    local ContentContainer = Instance.new("Frame", Main)
    ContentContainer.Size = UDim2.new(1, -225, 1, -65)
    ContentContainer.Position = UDim2.new(0, 215, 0, 50)
    ContentContainer.BackgroundTransparency = 1

    local ActiveTabTracker = { Value = nil }
    local AllElements = {}

    local WindowObj = {}
    
    function WindowObj:CreateCategory(catName)
        -- تمرير الموديولات للتابات (هذا هو الدمج)
        return TabModule.new(TabsScroll, ContentContainer, catName, Theme, Utils, ElementsFolder, AllElements, ActiveTabTracker)
    end

    return WindowObj
end

return WindowModule
            end
        end
    end

    local OpenBtn = Instance.new("ImageButton", ScreenGui)
    OpenBtn.Name = "OpenPanda"
    OpenBtn.Size = UDim2.fromOffset(50, 50)
    OpenBtn.Position = UDim2.new(0, 20, 0, 60)
    OpenBtn.BackgroundColor3 = Color3.new(1, 1, 1)
    OpenBtn.BackgroundTransparency = 0.8
    OpenBtn.Image = "rbxassetid://" .. tostring(logoId)
    OpenBtn.Visible = false
    Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
    Utils.ApplyPremiumGradient(OpenBtn, Theme)
    
    local OpenStroke = Instance.new("UIStroke", OpenBtn)
    OpenStroke.Thickness = 2
    Utils.ApplyPremiumGradient(OpenStroke, Theme)

    local Main = Instance.new("CanvasGroup", ScreenGui)
    Main.Size = UDim2.fromOffset(660, 460)
    Main.Position = UDim2.new(0.5, -330, -0.6, 0)
    Main.BackgroundColor3 = Theme.Background
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)
    
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Thickness = 1.5
    Utils.ApplyPremiumGradient(MainStroke, Theme)

    ToggleBlur(true)
    TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -330, 0.5, -230),
        GroupTransparency = 0
    }):Play()

    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundTransparency = 1

    local LogoImg = Instance.new("ImageLabel", TopBar)
    LogoImg.Size = UDim2.fromOffset(28, 28)
    LogoImg.Position = UDim2.new(0, 15, 0.5, -14)
    LogoImg.BackgroundTransparency = 1
    LogoImg.Image = "rbxassetid://" .. tostring(logoId)

    local HubTitle = Instance.new("TextLabel", TopBar)
    HubTitle.Size = UDim2.new(0, 300, 1, 0)
    HubTitle.Position = UDim2.new(0, 52, 0, 0)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = hubName
    HubTitle.TextColor3 = Theme.Text
    HubTitle.Font = Enum.Font.GothamBold
    HubTitle.TextSize = 18
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left
    Utils.ApplyPremiumGradient(HubTitle, Theme)

    local CloseBtn = Instance.new("ImageButton", TopBar)
    CloseBtn.Size = UDim2.fromOffset(22, 22)
    CloseBtn.Position = UDim2.new(1, -35, 0.5, -11)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Image = "rbxassetid://17829927053"
    Utils.ApplyPremiumGradient(CloseBtn, Theme)

    Draggable(Main, TopBar)

    local ActiveTabTracker = { Value = nil }
    local AllElements = {}

    CloseBtn.MouseButton1Click:Connect(function()
        ToggleBlur(false)
        local closeTween = TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(Main.Position.X.Scale, Main.Position.X.Offset, 1.5, 0),
            GroupTransparency = 1
        })
        closeTween:Play()
        closeTween.Completed:Connect(function() Main.Visible = false; OpenBtn.Visible = true end)
    end)

    OpenBtn.MouseButton1Click:Connect(function()
        OpenBtn.Visible = false
        Main.Position = UDim2.new(0.5, -330, -0.6, 0)
        Main.Visible = true
        ToggleBlur(true)
        TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -330, 0.5, -230),
            GroupTransparency = 0
        }):Play()
    end)

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 190, 1, -105)
    Sidebar.Position = UDim2.new(0, 12, 0, 50)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
    local SidebarStroke = Instance.new("UIStroke", Sidebar)
    SidebarStroke.Color = Color3.fromRGB(35, 35, 45)
    SidebarStroke.Thickness = 1

    local SearchBoxBg = Instance.new("Frame", Sidebar)
    SearchBoxBg.Size = UDim2.new(1, -20, 0, 35)
    SearchBoxBg.Position = UDim2.new(0, 10, 0, 12)
    SearchBoxBg.BackgroundColor3 = Theme.ElementBg
    Instance.new("UICorner", SearchBoxBg).CornerRadius = UDim.new(0, 8)
    local SearchStroke = Instance.new("UIStroke", SearchBoxBg)
    SearchStroke.Color = Color3.fromRGB(45, 45, 55)

    local SearchIcon = Instance.new("ImageLabel", SearchBoxBg)
    SearchIcon.Size = UDim2.fromOffset(16, 16)
    SearchIcon.Position = UDim2.new(0, 10, 0.5, -8)
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Image = "rbxassetid://118685771787843"
    SearchIcon.ImageColor3 = Theme.SubText

    local SearchBox = Instance.new("TextBox", SearchBoxBg)
    SearchBox.Size = UDim2.new(1, -40, 1, 0)
    SearchBox.Position = UDim2.new(0, 35, 0, 0)
    SearchBox.BackgroundTransparency = 1
    SearchBox.Text = ""
    SearchBox.PlaceholderText = "Search features..."
    SearchBox.TextColor3 = Theme.Text
    SearchBox.Font = Enum.Font.GothamMedium
    SearchBox.TextSize = 12
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left

    local TabsScroll = Instance.new("ScrollingFrame", Sidebar)
    TabsScroll.Size = UDim2.new(1, 0, 1, -60)
    TabsScroll.Position = UDim2.new(0, 0, 0, 55)
    TabsScroll.BackgroundTransparency = 1
    TabsScroll.ScrollBarThickness = 0
    local TabsLayout = Instance.new("UIListLayout", TabsScroll)
    TabsLayout.Padding = UDim.new(0, 6)
    TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local ContentContainer = Instance.new("Frame", Main)
    ContentContainer.Size = UDim2.new(1, -225, 1, -115)
    ContentContainer.Position = UDim2.new(0, 215, 0, 55)
    ContentContainer.BackgroundTransparency = 1

    local SearchOverlay = Instance.new("ScrollingFrame", ContentContainer)
    SearchOverlay.Size = UDim2.new(1, 0, 1, 0)
    SearchOverlay.BackgroundTransparency = 1
    SearchOverlay.Visible = false
    SearchOverlay.ZIndex = 50
    SearchOverlay.ScrollBarThickness = 2
    local SearchLayout = Instance.new("UIListLayout", SearchOverlay)
    SearchLayout.Padding = UDim.new(0, 8)

    local Footer = Instance.new("Frame", Main)
    Footer.Size = UDim2.new(1, 0, 0, 50)
    Footer.Position = UDim2.new(0, 0, 1, -50)
    Footer.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    
    local FooterLine = Instance.new("Frame", Footer)
    FooterLine.Size = UDim2.new(1, 0, 0, 1)
    Utils.ApplyPremiumGradient(FooterLine, Theme)

    local PlayerAvatar = Instance.new("ImageLabel", Footer)
    PlayerAvatar.Size = UDim2.fromOffset(32, 32)
    PlayerAvatar.Position = UDim2.new(0, 15, 0.5, -16)
    PlayerAvatar.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    Instance.new("UICorner", PlayerAvatar).CornerRadius = UDim.new(1, 0)
    Utils.ApplyPremiumGradient(Instance.new("UIStroke", PlayerAvatar), Theme)

    local PlayerNameLabel = Instance.new("TextLabel", Footer)
    PlayerNameLabel.Size = UDim2.new(0, 180, 0, 32)
    PlayerNameLabel.Position = UDim2.new(0, 55, 0.5, -16)
    PlayerNameLabel.BackgroundTransparency = 1
    PlayerNameLabel.Text = Player.DisplayName
    PlayerNameLabel.TextColor3 = Theme.Text
    PlayerNameLabel.Font = Enum.Font.GothamMedium
    PlayerNameLabel.TextSize = 12
    PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left

    local StatsContainer = Instance.new("Frame", Footer)
    StatsContainer.Size = UDim2.new(0, 250, 1, 0)
    StatsContainer.Position = UDim2.new(1, -265, 0, 0)
    StatsContainer.BackgroundTransparency = 1

    local TimePlayedLabel = Instance.new("TextLabel", StatsContainer)
    TimePlayedLabel.Size = UDim2.new(1, 0, 0, 20)
    TimePlayedLabel.Position = UDim2.new(0, 0, 0, 6)
    TimePlayedLabel.BackgroundTransparency = 1
    TimePlayedLabel.TextColor3 = Theme.SubText
    TimePlayedLabel.Font = Enum.Font.Gotham
    TimePlayedLabel.TextSize = 11
    TimePlayedLabel.TextXAlignment = Enum.TextXAlignment.Right

    local LocalTimeLabel = Instance.new("TextLabel", StatsContainer)
    LocalTimeLabel.Size = UDim2.new(1, 0, 0, 20)
    LocalTimeLabel.Position = UDim2.new(0, 0, 0, 24)
    LocalTimeLabel.BackgroundTransparency = 1
    LocalTimeLabel.TextColor3 = Theme.Text
    LocalTimeLabel.Font = Enum.Font.GothamBold
    LocalTimeLabel.TextSize = 11
    LocalTimeLabel.TextXAlignment = Enum.TextXAlignment.Right
    Utils.ApplyPremiumGradient(LocalTimeLabel, Theme)

    task.spawn(function()
        while true do
            local duration = math.floor(tick() - StartTime)
            local hours, minutes, seconds = math.floor(duration / 3600), math.floor((duration % 3600) / 60), duration % 60
            TimePlayedLabel.Text = string.format("Time Played: %02d:%02d:%02d", hours, minutes, seconds)
            LocalTimeLabel.Text = "Local Time: " .. os.date("%X")
            task.wait(1)
        end
    end)

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = string.lower(SearchBox.Text)
        if query == "" then
            SearchOverlay.Visible = false
            if ActiveTabTracker.Value then ActiveTabTracker.Value.Page.Visible = true end
        else
            if ActiveTabTracker.Value then ActiveTabTracker.Value.Page.Visible = false end
            SearchOverlay.Visible = true
            for _, item in pairs(AllElements) do
                if string.find(string.lower(item.Name), query) then
                    item.Obj.Parent = SearchOverlay
                    item.Obj.Visible = true
                else
                    item.Obj.Visible = false
                end
            end
        end
    end)

    SearchBox.FocusLost:Connect(function()
        if SearchBox.Text == "" then
            SearchOverlay.Visible = false
            for _, item in pairs(AllElements) do
                item.Obj.Parent = item.ParentPage
                item.Obj.Visible = true
            end
            if ActiveTabTracker.Value then ActiveTabTracker.Value.Page.Visible = true end
        end
    end)

    local WindowObj = {}

    function WindowObj:CreateCategory(catName)
        return TabModule.new(TabsScroll, ContentContainer, catName, Theme, Utils, ElementsFolder, AllElements, ActiveTabTracker)
    end

    return WindowObj
end

return WindowModule
