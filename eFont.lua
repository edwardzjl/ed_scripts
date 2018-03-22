
local NORMAL = "Fonts\\LanTingHei.ttf"
local BOLD = "Fonts\\LanTingHei-bold.ttf"
local SLIM = "Fonts\\LanTingHei-slim.ttf"

local SizeFix = 0.92

local FONTS = {}

local function ApplyFont()
	local G = getfenv(0)
	for k, v in pairs(G) do
		if type(v) == 'table'
			and type(v[0]) == 'userdata'
			and not v.IsForbidden
			and v.GetObjectType
			and v:GetObjectType() == 'Font' then
			tinsert(FONTS, k)
		end
	end

	for _, font in pairs(FONTS) do
		local obj = G[font]
		if obj then
			local name, size, flag = obj:GetFont()
			if font:find('Combat')
				or font:find('Huge')
				or font:find('Large')
				or font:find('Header')
				or font:find('Title')
				or font:find('Highlight')
				or font:find('Enormous') then
				name = BOLD
			else
				name = NORMAL
			end
			obj:SetFont(name, SizeFix and SizeFix*size or size, flag)
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	ApplyFont()
end)
