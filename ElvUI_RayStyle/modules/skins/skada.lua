--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local S = E:GetModule("Skins")
local RS = E:GetModule("RayStyle")

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Skada" then return end
	self:UnregisterEvent("ADDON_LOADED")
	hooksecurefunc(Skada, "UpdateDisplay", function(self)
		for _,window in ipairs(self:GetWindows()) do
			for i,v in pairs(window.bargroup:GetBars()) do
				if not v.BarStyled then
					v.label:SetShadowOffset(0, 0)
					v.label.SetShadowOffset = RS.dummy
					v.timerLabel:SetShadowOffset(0, 0)
					v.timerLabel.SetShadowOffset = RS.dummy
					v.BarStyled = true
				end
			end
		end
	end)
end)