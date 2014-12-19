--[[---------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains the code that registers media
---------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local CNB = E:GetModule("RayStyle")
local LSM = LibStub("LibSharedMedia-3.0")

local FONT_SIZE = 20
local ICON_SIZE = 36
local MIN_SCALE = 0.5

local function UpdateCooldownFont(self, cd)
	local override = cd:GetParent():GetParent().SizeOverride
	if cd.fontScale < MIN_SCALE and not override then
		cd:Hide()
	else
		cd:Show()
		cd.text:FontTemplate(LSM:Fetch("font", E.db.RS.general.cdFont), cd.fontScale * FONT_SIZE, "OUTLINE")
		if cd.enabled then
			self:Cooldown_ForceUpdate(cd)
		end
	end
end

hooksecurefunc(E, "Cooldown_OnSizeChanged", UpdateCooldownFont)
