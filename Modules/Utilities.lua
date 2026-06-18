-- [[ PandaUI | Global Service Functions ]]
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Utils = {}

function Utils.GetSafeUIFolder()
    if gethui then
        local success, result = pcall(gethui)
        if success and result then return result end
    end
    return pcall(function() return CoreGui end) and CoreGui or Player:WaitForChild("PlayerGui")
end

function Utils.Tween(obj, props, time)
    local t = TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

function Utils.ApplyPremiumGradient(parent, Theme)
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.GradientStart),
        ColorSequenceKeypoint.new(1, Theme.Accent)
    })
    Gradient.Rotation = 45
    Gradient.Parent = parent
    return Gradient
end

return Utils
