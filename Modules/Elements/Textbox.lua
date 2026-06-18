-- [[ PandaUI Element | Premium Textbox Input ]]
return function(Parent, labelText, placeholder, callback, Theme, Utils, AllElements)
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

    local Input = Instance.new("TextBox", Container)
    Input.Size = UDim2.new(0.52, 0, 0, 28)
    Input.Position = UDim2.new(0.45, 0, 0.5, -14)
    Input.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    Input.PlaceholderText = placeholder
    Input.Text = ""
    Input.TextColor3 = Theme.Accent
    Input.Font = Enum.Font.GothamBold
    Input.TextSize = 12
    Instance.new("UICorner", Input).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", Input).Color = Color3.fromRGB(55, 55, 65)

    Input:GetPropertyChangedSignal("Text"):Connect(function()
        Input.TextTransparency = 0.5
        Utils.Tween(Input, {TextTransparency = 0}, 0.2)
        if callback then pcall(callback, Input.Text) end
    end)

    table.insert(AllElements, {Name = labelText, Obj = Container, ParentPage = Parent})
    return Container
end
