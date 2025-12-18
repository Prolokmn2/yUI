local TweenUtils = require(script.Parent.Parent.utils.TweenUtils)
local Slider = {}
Slider.__index = Slider

function Slider.new(parent, text, min, max, default, callback)
    local self = setmetatable({}, Slider)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,200,0,40)
    frame.Position = UDim2.new(0,10,0,#parent:GetChildren()*50)
    frame.BackgroundColor3 = Color3.fromRGB(50,50,70)
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0.4,0)
    label.Text = text.." "..tostring(default)
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1,0,0.3,0)
    bar.Position = UDim2.new(0,0,0.6,0)
    bar.BackgroundColor3 = Color3.fromRGB(100,100,150)
    bar.Parent = frame
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0,5)

    local handle = Instance.new("Frame")
    handle.Size = UDim2.new((default-min)/(max-min),0,1,0)
    handle.BackgroundColor3 = Color3.fromRGB(255,255,255)
    handle.Parent = bar
    Instance.new("UICorner", handle).CornerRadius = UDim.new(0,5)

    local dragging = false
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X, 0, 1)
            handle.Size = UDim2.new(rel,0,1,0)
            if callback then callback(min + rel*(max-min)) end
            label.Text = text.." "..math.floor(min + rel*(max-min))
        end
    end)

    self.Instance = frame
    return self
end

return Slider
