local TweenService = game:GetService("TweenService")
local TweenUtils = {}

function TweenUtils.tween(instance, props, duration, style, dir)
    TweenService:Create(instance, TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props):Play()
end

return TweenUtils
