-- [[ PandaUI Component | Categories & Tabs Handler ]]
local TabModule = {}

function TabModule.new(TabsScroll, ContentContainer, catName, Theme, Utils, ElementsFolder, AllElements, ActiveTabTracker)
    local CatFrame = Instance.new("Frame", TabsScroll)
    CatFrame.Size = UDim2.new(1, -16, 0, 36)
    CatFrame.BackgroundTransparency = 1
    CatFrame.ClipsDescendants = true

    local CatFrameStroke = Instance.new("UIStroke", CatFrame)
    CatFrameStroke.Color = Color3.fromRGB(40, 40, 50)
    CatFrameStroke.Thickness = 1

    local CatBtn = Instance.new("TextButton", CatFrame)
    CatBtn.Size = UDim2.new(1, 0, 0, 36)
    CatBtn.BackgroundTransparency = 1
    CatBtn.Text = "  ▼  " .. catName
    CatBtn.TextColor3 = Theme.SubText
    CatBtn.Font = Enum.Font.GothamBold
    CatBtn.TextSize = 12
    CatBtn.TextXAlignment = Enum.TextXAlignment.Left

    local SubTabsLayout = Instance.new("UIListLayout", CatFrame)
    SubTabsLayout.Padding = UDim.new(0, 4)
    SubTabsLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local Expanded = false
    CatBtn.MouseButton1Click:Connect(function()
        Expanded = not Expanded
        local targetHeight = Expanded and (SubTabsLayout.AbsoluteContentSize.Y + 10) or 36
        Utils.Tween(CatFrame, {Size = UDim2.new(1, -16, 0, targetHeight)})
        CatBtn.Text = Expanded and ("  ▲  " .. catName) or ("  ▼  " .. catName)
        Utils.Tween(CatBtn, {TextColor3 = Expanded and Theme.Accent or Theme.SubText})
    end)

    local CatObj = {}

    function CatObj:CreateTab(tabConfig)
        local tabName = tabConfig.Name
        local tabIcon = tabConfig.Icon

        local TabBtn = Instance.new("TextButton", CatFrame)
        TabBtn.Size = UDim2.new(1, -10, 0, 32)
        TabBtn.BackgroundColor3 = Theme.ElementBg
        TabBtn.BackgroundTransparency = 0.3
        TabBtn.Text = ""
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
        
        local TabBtnStroke = Instance.new("UIStroke", TabBtn)
        TabBtnStroke.Color = Color3.fromRGB(45, 45, 55)
        TabBtnStroke.Thickness = 1

        local TabLabel = Instance.new("TextLabel", TabBtn)
        TabLabel.Size = UDim2.new(1, -35, 1, 0)
        TabLabel.Position = UDim2.new(0, tabIcon and 32 or 12, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = tabName
        TabLabel.TextColor3 = Theme.Text
        TabLabel.Font = Enum.Font.GothamMedium
        TabLabel.TextSize = 12
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left

        if tabIcon then
            local IconImg = Instance.new("ImageLabel", TabBtn)
            IconImg.Size = UDim2.fromOffset(14, 14)
            IconImg.Position = UDim2.new(0, 10, 0.5, -7)
            IconImg.BackgroundTransparency = 1
            IconImg.Image = tabIcon
        end

        local TabPage = Instance.new("ScrollingFrame", ContentContainer)
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.ScrollBarThickness = 3
        TabPage.Visible = false
        
        local PageLayout = Instance.new("UIListLayout", TabPage)
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            if ActiveTabTracker.Value then
                ActiveTabTracker.Value.Page.Visible = false
                ActiveTabTracker.Value.Btn.BackgroundColor3 = Theme.ElementBg
                ActiveTabTracker.Value.Stroke.Color = Color3.fromRGB(45, 45, 55)
                ActiveTabTracker.Value.Stroke.Thickness = 1
            end
            
            ActiveTabTracker.Value = {Page = TabPage, Btn = TabBtn, Stroke = TabBtnStroke}
            TabPage.Visible = true
            TabBtn.BackgroundColor3 = Theme.ActiveTabBg
            TabBtnStroke.Color = Theme.Accent
            TabBtnStroke.Thickness = 1.5
        end)

        local Elements = {}

        function Elements:CreateSection(title)
            local SecLabel = Instance.new("TextLabel", TabPage)
            SecLabel.Size = UDim2.new(1, 0, 0, 25)
            SecLabel.BackgroundTransparency = 1
            SecLabel.Text = "— " .. title
            SecLabel.TextColor3 = Theme.Accent
            SecLabel.Font = Enum.Font.GothamBold
            SecLabel.TextSize = 13
            SecLabel.TextXAlignment = Enum.TextXAlignment.Left
            return SecLabel
        end

        function Elements:CreateButton(name, callback)
            return require(ElementsFolder:WaitForChild("Button"))(TabPage, name, callback, Theme, Utils, AllElements)
        end

        function Elements:CreateSlider(config)
            return require(ElementsFolder:WaitForChild("Slider"))(TabPage, config, Theme, Utils, AllElements)
        end

        function Elements:CreateToggle(name, defaultState, callback)
            return require(ElementsFolder:WaitForChild("Toggle"))(TabPage, name, defaultState, callback, Theme, Utils, AllElements)
        end

        function Elements:CreateSelector(name, options, callback)
            return require(ElementsFolder:WaitForChild("Dropdown"))(TabPage, name, options, callback, Theme, Utils, AllElements)
        end

        function Elements:CreateTextbox(name, placeholder, callback)
            return require(ElementsFolder:WaitForChild("Textbox"))(TabPage, name, placeholder, callback, Theme, Utils, AllElements)
        end

        return Elements
    end
    return CatObj
end

return TabModule
