--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local S = E:GetModule("Skins")
local RS = E:GetModule("RayStyle")

local function SetFontStyle(self, font, size, flag)
	self:SetShadowOffset(0, 0)
	if flag ~= "OUTLINE" then self:SetFont(font, size, "OUTLINE") end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Skada" then return end
	self:UnregisterEvent("ADDON_LOADED")
	hooksecurefunc(Skada, "UpdateDisplay", function(self)
		for _,window in ipairs(self:GetWindows()) do
			for i,v in pairs(window.bargroup:GetBars()) do
				if not v.BarStyled then
					local font, size = v.label:GetFont()
					v.label:SetFont(font, size, "OUTLINE")
					hooksecurefunc(v.label, "SetFont", SetFontStyle)
					local font, size = v.timerLabel:GetFont()
					v.timerLabel:SetFont(font, size, "OUTLINE")
					hooksecurefunc(v.timerLabel, "SetFont", SetFontStyle)
					v.BarStyled = true
				end
			end
		end
	end)

	for _, window in ipairs(Skada:GetWindows()) do
		window:UpdateDisplay()
	end
end)