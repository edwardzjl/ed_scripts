
local addonName, addon = ...
local cfg = addon.cfg


--[隐藏动作条两边鹰]
MainMenuBarLeftEndCap:Hide()
MainMenuBarRightEndCap:Hide()

--[超出距离技能栏变红]
hooksecurefunc("ActionButton_OnUpdate", function(self, elapsed)
   if (self.rangeTimer == TOOLTIP_UPDATE_TIME and self.action) then
      local range = false
      if (IsActionInRange(self.action) == false) then
         getglobal(self:GetName().."Icon"):SetVertexColor(1, 0, 0)
         getglobal(self:GetName().."NormalTexture"):SetVertexColor(1, 0, 0)
         range = true
      end;
      if (self.range ~= range and range == false) then
         ActionButton_UpdateUsable(self)
      end;
      self.range = range
   end
end)

--[浮动战斗信息设置]
if LoadAddOn("Blizzard_CombatText") then
	COMBAT_TEXT_SCROLLSPEED = 1.9
	COMBAT_TEXT_FADEOUT_TIME = 1.3
	CombatText:SetScale(0.8)
	--[移动]
	hooksecurefunc("CombatText_UpdateDisplayedMessages", function ()
	COMBAT_TEXT_LOCATIONS = {
		startX = 300,
		startY = 400 * COMBAT_TEXT_Y_SCALE,
		endX = 300,
		endY = 500 * COMBAT_TEXT_Y_SCALE
	}
	end)
end

--[调整目标debuff大小]
-- local function UpdateTargetAuraPositions(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX)
--     local AURA_OFFSET_Y = 3;
--     local LARGE_AURA_SIZE = 27;
--     local SMALL_AURA_SIZE = 20;
--     local size;
--     local offsetY = AURA_OFFSET_Y;
--     local rowWidth = 0;
--     local firstBuffOnRow = 1;
--     for i = 1, numAuras do
--         if ( largeAuraList[i] ) then
--             size = LARGE_AURA_SIZE;
--             offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y;
--         else
--             size = SMALL_AURA_SIZE;
--         end
--         if ( i == 1 ) then
--             rowWidth = size;
--             self.auraRows = self.auraRows + 1;
--         else
--             rowWidth = rowWidth + size + offsetX;
--         end
--         if ( rowWidth > maxRowWidth ) then
--             updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY);
--             rowWidth = size;
--             self.auraRows = self.auraRows + 1;
--             firstBuffOnRow = i;
--             offsetY = AURA_OFFSET_Y;
--         else
--             updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY);
--         end
--     end;
-- end;
-- hooksecurefunc("TargetFrame_UpdateAuraPositions", UpdateTargetAuraPositions)


--[法术ID及释放者、物品ID]
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
	local id = select(11,UnitBuff(...))
	local caster = select(8,UnitBuff(...)) and UnitName(select(8,UnitBuff(...)))
	self:AddLine(id and ' ')
	self:AddDoubleLine(id, caster)
	self:Show()
end)
hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
	local id = select(11,UnitDebuff(...))
	local caster = select(8,UnitDebuff(...)) and UnitName(select(8,UnitDebuff(...)))
	self:AddLine(id and ' ')
	self:AddDoubleLine(id, caster)
	self:Show()
end)
hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
	local id = select(11,UnitAura(...))
	local caster = select(8,UnitAura(...)) and UnitName(select(8,UnitAura(...)))
	self:AddLine(id and ' ')
	self:AddDoubleLine(id, caster)
	self:Show()
end)
hooksecurefunc("SetItemRef", function(link)
	if link then
		local _, id = strsplit(":", link)
		ItemRefTooltip:AddLine(id and ' ')
		ItemRefTooltip:AddLine(id)
		ItemRefTooltip:Show()
	end
end)
GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	if self.GetSpell then
		local _, _, id = self:GetSpell()
		self:AddLine(id and ' ')
		self:AddLine(id)
		self:Show()
	end
end)


--[去除失控转圈]
hooksecurefunc('CooldownFrame_Set', function(self)
	if self.currentCooldownType == COOLDOWN_TYPE_LOSS_OF_CONTROL then
		self:SetCooldown(0,0)
	end
end)

--[arena plates]
hooksecurefunc("CompactUnitFrame_UpdateName", function(F)
	if IsActiveBattlefieldArena() and F.unit:find("nameplate") then
		for i = 1, 5 do
			if UnitIsUnit(F.unit, "arena"..i) then
				F.name:SetText(i)
				F.name:SetTextColor(1, 1, 0)
				break
			end
		end
	end
end)