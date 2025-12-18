local yUI = require(game.ReplicatedStorage:WaitForChild("yUI"))

-- make a window
local win = yUI.Components.Window.new({
    windowName = "Fire Window",
    transparent = 0.8,
    color = Color3.fromRGB(40,40,60),
    size = UDim2.new(0,500,0,350),
    draggable = true,
    minimize = true,
    close = true
})

-- add buttons
win:AddButton("Press Me", function()
    yUI.Components.Debug.log("Button pressed!")
end)

-- add slider
win:AddSlider("Volume", 0, 100, 50, function(val)
    yUI.Components.Debug.log("Slider value: "..math.floor(val))
end)

-- add toggle
win:AddToggle("God Mode", false, function(state)
    yUI.Components.Debug.log("God Mode: "..tostring(state))
end)

-- add label
local Label = require(yUI.Components.Label)
Label.new(win.Content, "This is yUI v1 Fire Edition!")
