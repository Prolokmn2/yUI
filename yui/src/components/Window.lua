local TweenUtils = require(script.Parent.Parent.utils:WaitForChild("TweenUtils"))

local Window = {}
Window.__index = Window

-- windowOptions:
-- windowName = string
-- transparent = 0-1
-- color = Color3
-- size = UDim2
-- location = UDim2 or nil
-- draggable = true/false
-- minimize = true/false
-- close = true/false

function Window.new(options)
    local self = setmetatable({}, Window)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = options.windowName or "yUI_Window"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = options.size or UDim2.new(0, 400, 0, 300)
    frame.Position = options.location or UDim2.new(0.5, -200, 0.5, -150)
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.BackgroundColor3 = options.color or Color3.fromRGB(30,30,40)
    frame.BackgroundTransparency = options.transparent or 0.1
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

    -- header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1,0,0,40)
    header.BackgroundTransparency = 0.2
    header.BackgroundColor3 = Color3.fromRGB(50,50,70)
    header.Parent = frame
    Instance.new("UICorner", header).CornerRadius = UDim.new(0,16)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.7,0,1,0)
    titleLabel.Position = UDim2.new(0,0,0,0)
    titleLabel.Text = options.windowName or "Window"
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextScaled = true
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = header

    -- Minimize button
    local minBtn
    if options.minimize ~= false then
        minBtn = Instance.new("TextButton")
        minBtn.Size = UDim2.new(0.15,0,1,0)
        minBtn.Position = UDim2.new(0.7,0,0,0)
        minBtn.Text = "-"
        minBtn.Font = Enum.Font.GothamBold
        minBtn.TextScaled = true
        minBtn.TextColor3 = Color3.new(1,1,1)
        minBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
        minBtn.Parent = header
        Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,8)
    end

    -- Close button
    local closeBtn
    if options.close then
        closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0.15,0,1,0)
        closeBtn.Position = UDim2.new(0.85,0,0,0)
        closeBtn.Text = "X"
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.TextScaled = true
        closeBtn.TextColor3 = Color3.new(1,1,1)
        closeBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
        closeBtn.Parent = header
        Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)
    end

    -- Minimize functionality
    if minBtn then
        local minimized = false
        minBtn.MouseButton1Click:Connect(function()
            minimized = not minimized
            TweenUtils.tween(frame, {Size = minimized and UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset,0,40) or (options.size or UDim2.new(0,400,0,300))})
        end)
    end

    -- Close functionality
    if closeBtn then
        closeBtn.MouseButton1Click:Connect(function()
            screenGui:Destroy()
        end)
    end

    -- Dragging
    if options.draggable ~= false then
        local dragging = false
        local offset = Vector3.new()
        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                local mouse = game.Players.LocalPlayer:GetMouse()
                offset = frame.Position - UDim2.new(0, mouse.X, 0, mouse.Y)
            end
        end)
        header.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mouse = game.Players.LocalPlayer:GetMouse()
                frame.Position = UDim2.new(0, mouse.X + offset.X.Offset, 0, mouse.Y + offset.Y.Offset)
            end
        end)
    end

    self.ScreenGui = screenGui
    self.Frame = frame
    self.Header = header
    self.Title = titleLabel

    -- Child container for buttons/sliders
    self.Content = Instance.new("Frame")
    self.Content.Size = UDim2.new(1,0,1,-40)
    self.Content.Position = UDim2.new(0,0,0,40)
    self.Content.BackgroundTransparency = 1
    self.Content.Parent = frame

    return self
end

-- Add a button
function Window:AddButton(text, callback)
    local Button = require(script.Parent.Button)
    local btn = Button.new(self.Content, text, callback)
    return btn
end

-- Add a slider
function Window:AddSlider(text, min, max, default, callback)
    local Slider = require(script.Parent.Slider)
    local s = Slider.new(self.Content, text, min, max, default, callback)
    return s
end

-- Add a toggle
function Window:AddToggle(text, default, callback)
    local Toggle = require(script.Parent.Toggle)
    local t = Toggle.new(self.Content, text, default, callback)
    return t
end

return Window
