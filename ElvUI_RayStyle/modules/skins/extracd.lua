--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local S = E:GetModule("Skins")

local function SkinExtraCD()
	local ExtraCD = ExtraCD

	hooksecurefunc(ExtraCD, "CreateIcon", function(self, order, bar)
		local btn = bar[order]

		local backdrop = btn:GetBackdrop()
		local icon = backdrop.bgFile

		if not btn.icon then
			btn.icon = btn:CreateTexture(nil, "BORDER")
			btn.icon:SetInside()
			btn.icon:SetTexCoord(.08, .92, .08, .92)
		end
		btn.icon:SetTexture(icon)
		btn:SetBackdrop(nil)
		btn:CreateBackdrop("Default")
		btn.backdrop:SetAllPoints()
		btn:StyleButton()
	end)
	ExtraCD:ResetAllIcons()
end

S:RegisterSkin("ExtraCD", SkinExtraCD)