-- [[ PandaUI Element | Precision Slider ]]
local UserInputService = game:GetService("UserInputService")

return function(Parent, slConfig, Theme, Utils, AllElements)
    local Min = slConfig.Min or 0
    local Max = slConfig.Max or 100
    local Default = slConfig.Default or Min
    local callback = slConfig.Callback

    local SlBg = Instance.new("Frame", Parent)
    SlBg.Size = UDim2.new(1, -10, 0, 60)
    SlBg.BackgroundColor3 = Theme.ElementBg
    Instance.new("UICorner", SlBg).CornerRadius = UDim.new(0, 6)
    local SlStroke = Instance.new("UIStroke", SlBg)
    SlStroke.Color = Color3.fromRGB(45, 45, 55)

    local Title = Instance.new("TextLabel", SlBg)
    Title.Size = UDim2.new(1, -80, 0, 20)
    Title.Position = UDim2.new(0, 12, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = slConfig.Name
    Title.TextColor3 = Theme.Text
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local ValueLabel = Instance.new("TextLabel", SlBg)
    ValueLabel.Size = UDim2.new(0, 60, 0, 20)
    ValueLabel.Position = UDim2.new(1, -72, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(Default)
    ValueLabel.TextColor3 = Theme.Accent
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 12
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

    local TrackBg = Instance.new("Frame", SlBg)
    TrackBg.Size = UDim2.new(1, -24, 0, 8)
    TrackBg.Position = UDim2.new(0, 12, 0, 38)
    TrackBg.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Instance.new("UICorner", TrackBg).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame", TrackBg)
    Fill.Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0)
    Fill.BackgroundColor3 = Theme.Accent
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local Dragging = false
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(Min + ((Max - Min) * pos))
        ValueLabel.Text = tostring(value)
        Utils.Tween(Fill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.1)
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
    
    table.insert(AllElements, {Name = slConfig.Name, Obj = SlBg, ParentPage = Parent})
    return SlBg
end
