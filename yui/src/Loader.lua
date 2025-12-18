local BASE = "https://raw.githubusercontent.com/Prolokmn2/yUI/main/src/"

local function fetch(path)
    return loadstring(game:HttpGet(BASE .. path))()
end

local yUI = {}
yUI.Components = {}
yUI.Utils = {}

-- utils
yUI.Utils.TweenUtils = fetch("utils/TweenUtils.lua")

-- components
yUI.Components.Window   = fetch("components/Window.lua")
yUI.Components.Button   = fetch("components/Button.lua")
yUI.Components.Slider   = fetch("components/Slider.lua")
yUI.Components.Toggle   = fetch("components/Toggle.lua")
yUI.Components.Label    = fetch("components/Label.lua")
yUI.Components.Debug    = fetch("components/Debug.lua")
yUI.Components.FallBack = fetch("components/FallBack.lua")

return yUI
