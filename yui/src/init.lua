local yUI = {}
yUI.Components = {}
yUI.Utils = {}

-- Load components
local componentsFolder = script:WaitForChild("components")
for _, module in ipairs(componentsFolder:GetChildren()) do
    if module:IsA("ModuleScript") then
        yUI.Components[module.Name] = require(module)
    end
end

-- Load utils
local utilsFolder = script:WaitForChild("utils")
for _, module in ipairs(utilsFolder:GetChildren()) do
    if module:IsA("ModuleScript") then
        yUI.Utils[module.Name] = require(module)
    end
end

return yUI
