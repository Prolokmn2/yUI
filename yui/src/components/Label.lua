local Label = {}
Label.__index = Label

function Label.new(parent, text)
    local self = setmetatable({}, Label)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0,200,0,40)
    lbl.Position = UDim2.new(0,10,0,#parent:GetChildren()*50)
    lbl.Text = text
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextScaled = true
    lbl.BackgroundTransparency = 1
    lbl.Parent = parent
    self.Instance = lbl
    return self
end

return Label
