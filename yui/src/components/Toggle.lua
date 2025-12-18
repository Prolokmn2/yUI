local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(parent, text, default, callback)
    local self = setmetatable({}, Toggle)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,200,0,40)
    frame.Position = UDim2.new(0,10,0,#parent:GetChildren()*50)
    frame.BackgroundColor3 = Color3.fromRGB(50,50,70)
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7,0,1,0)
    label.Text = text
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.Parent = frame

    local box = Instance.new("TextButton")
    box.Size = UDim2.new(0.3,0,1,0)
    box.Position = UDim2.new(0.7,0,0,0)
    box.Text = default and "ON" or "OFF"
    box.BackgroundColor3 = default and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
    box.TextColor3 = Color3.new(1,1,1)
    box.Parent = frame
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

    local state = default or false
    box.MouseButton1Click:Connect(function()
        state = not state
        box.Text = state and "ON" or "OFF"
        box.BackgroundColor3 = state and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
        if callback then callback(state) end
    end)

    self.Instance = frame
    return self
end

return Toggle
