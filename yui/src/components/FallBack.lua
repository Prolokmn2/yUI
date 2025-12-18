local FallBack = {}
FallBack.__index = FallBack

function FallBack.new(parent)
    local self = setmetatable({}, FallBack)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0,200,0,40)
    lbl.Text = "Component Missing!"
    lbl.TextColor3 = Color3.fromRGB(255,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Parent = parent
    self.Instance = lbl
    return self
end

return FallBack
