--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local NP = E:GetModule("NamePlates")
local RS = E:GetModule("RayStyle")

local function SetStyle(self, frame)
	if frame.PowerBar then
		RS:SmoothBar(frame.PowerBar)
	end
	if frame.HealthBar then
		RS:SmoothBar(frame.HealthBar)
	end
end
hooksecurefunc(NP, "ConfigureElement_HealthBar", SetStyle)
hooksecurefunc(NP, "ConfigureElement_PowerBar", SetStyle)

function RS:CreateAuraIcon(self, parent)
	local aura = RS.hooks[NP].CreateAuraIcon(self, parent)
	aura.icon:SetTexCoord(.07, 1-.07, .23, 1-.23)
	aura.cooldown.SizeOverride = 14
	return aura
end
RS:RawHook(NP, "CreateAuraIcon", CreateAuraIcon)