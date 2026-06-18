-- [[ PandaUI Element | Dynamic Dropdown / Selector ]]
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

return function(Parent, labelText, options, callback, Theme, Utils, AllElements)
    local DropdownActive = false
    local Container = Instance.new("Frame", Parent)
    Container.Size = UDim2.new(1, -10, 0, 42)
    Container.BackgroundColor3 = Theme.ElementBg
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 6)
    local ContainerStroke = Instance.new("UIStroke", Container)
    ContainerStroke.Color = Color3.fromRGB(45, 45, 55)

    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Theme.Text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SelectorBtn = Instance.new("TextButton", Container)
    SelectorBtn.Size = UDim2.new(0.52, 0, 0, 28)
    SelectorBtn.Position = UDim2.new(0.45, 0, 0.5, -14)
    SelectorBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    SelectorBtn.Text = "Select..."
    SelectorBtn.TextColor3 = Theme.SubText
    SelectorBtn.Font = Enum.Font.GothamMedium
    SelectorBtn.TextSize = 12
    Instance.new("UICorner", SelectorBtn).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", SelectorBtn).Color = Color3.fromRGB(55, 55, 65)

    local DropFrame = Instance.new("ScrollingFrame", Parent)
    DropFrame.Size = UDim2.new(1, -10, 0, 0)
    DropFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    DropFrame.Visible = false
    DropFrame.ScrollBarThickness = 2
    Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 6)
    local DropStroke = Instance.new("UIStroke", DropFrame)
    DropStroke.Color = Theme.Accent

    local DropLayout = Instance.new("UIListLayout", DropFrame)
    DropLayout.Padding = UDim.new(0, 4)

    local function RefreshOptions()
        for _, c in ipairs(DropFrame:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        local actualOptions = (options == "Players") and {} or options
        if options == "Players" then
            for _, p in pairs(Players:GetPlayers()) do if p ~= Player then table.insert(actualOptions, p.Name) end end
        end

        for _, optName in ipairs(actualOptions) do
            local LocBtn = Instance.new("TextButton", DropFrame)
            LocBtn.Size = UDim2.new(1, -8, 0, 28)
            LocBtn.BackgroundColor3 = Theme.ElementBg
            LocBtn.Text = optName
            LocBtn.TextColor3 = Theme.Text
            LocBtn.Font = Enum.Font.Gotham
            LocBtn.TextSize = 12
            Instance.new("UICorner", LocBtn).CornerRadius = UDim.new(0, 4)

            LocBtn.MouseButton1Click:Connect(function()
                SelectorBtn.Text = optName
                DropdownActive = false
                Utils.Tween(DropFrame, {Size = UDim2.new(1, -10, 0, 0)}, 0.2)
                task.wait(0.2) DropFrame.Visible = false
                if callback then pcall(callback, optName) end
            end)
        end
    end

    SelectorBtn.MouseButton1Click:Connect(function()
        DropdownActive = not DropdownActive
        if DropdownActive then
            RefreshOptions()
            DropFrame.Visible = true
            Utils.Tween(DropFrame, {Size = UDim2.new(1, -10, 0, math.clamp(DropLayout.AbsoluteContentSize.Y + 6, 40, 120))}, 0.3)
        else
            local tw = TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, 0)})
            tw:Play() tw.Completed:Connect(function() if not DropdownActive then DropFrame.Visible = false end end)
        end
    end)

    table.insert(AllElements, {Name = labelText, Obj = Container, ParentPage = Parent})
    return Container
end
