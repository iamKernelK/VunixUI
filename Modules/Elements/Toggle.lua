-- [[ PandaUI Element | Animated Switch Toggle ]]
return function(Parent, toggleName, defaultState, callback, Theme, Utils, AllElements)
    local State = defaultState or false
    
    local ToggleBg = Instance.new("TextButton", Parent)
    ToggleBg.Size = UDim2.new(1, -10, 0, 42)
    ToggleBg.BackgroundColor3 = Theme.ElementBg
    ToggleBg.Text = ""
    ToggleBg.AutoButtonColor = false
    Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 6)
    
    local ToggleStroke = Instance.new("UIStroke", ToggleBg)
    ToggleStroke.Color = Color3.fromRGB(45, 45, 55)

    local Label = Instance.new("TextLabel", ToggleBg)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = toggleName
    Label.TextColor3 = Theme.Text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SwitchBg = Instance.new("Frame", ToggleBg)
    SwitchBg.Size = UDim2.fromOffset(36, 20)
    SwitchBg.Position = UDim2.new(1, -48, 0.5, -10)
    SwitchBg.BackgroundColor3 = State and Theme.Accent or Color3.fromRGB(40, 40, 45)
    Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

    local Ball = Instance.new("Frame", SwitchBg)
    Ball.Size = UDim2.fromOffset(14, 14)
    Ball.Position = State and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    Ball.BackgroundColor3 = Theme.Text
    Instance.new("UICorner", Ball).CornerRadius = UDim.new(1, 0)

    ToggleBg.MouseEnter:Connect(function() Utils.Tween(ToggleBg, {BackgroundColor3 = Theme.ElementHover}) end)
    ToggleBg.MouseLeave:Connect(function() Utils.Tween(ToggleBg, {BackgroundColor3 = Theme.ElementBg}) end)

    ToggleBg.MouseButton1Click:Connect(function()
        State = not State
        Utils.Tween(SwitchBg, {BackgroundColor3 = State and Theme.Accent or Color3.fromRGB(40, 40, 45)}, 0.2)
        Utils.Tween(Ball, {Position = State and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)}, 0.2)
        if callback then pcall(callback, State) end
    end)

    table.insert(AllElements, {Name = toggleName, Obj = ToggleBg, ParentPage = Parent})
    return ToggleBg
end
