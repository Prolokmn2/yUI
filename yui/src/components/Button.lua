local Button = {}
Button.__index = Button

function Button.new(parent, text, callback)
    local self = setmetatable({}, Button)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Position = UDim2.new(0,10,0,#parent:GetChildren()*50)
    btn.Text = text or "Button"
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(70,70,90)
    btn.Parent = parent
    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    self.Instance = btn
    return self
end

return Button
