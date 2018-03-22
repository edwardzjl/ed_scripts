
--[隐藏宏、快捷键名称]
local r = {"MultiBarBottomLeft", "MultiBarBottomRight", "Action", "MultiBarLeft", "MultiBarRight"}
for b = 1,#r do
	for i = 1,12 do
		_G[r[b].."Button"..i.."Name"]:SetAlpha(0)	--宏名称
		_G[r[b].."Button"..i.."HotKey"]:SetAlpha(0)	--快捷键名称
	end
end
--[[
--[屏蔽红字错误]
UIErrorsFrame:Hide()
UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
]]