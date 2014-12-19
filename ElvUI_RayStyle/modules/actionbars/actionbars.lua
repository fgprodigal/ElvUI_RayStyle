local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local AB = E:GetModule("ActionBars")
local RS = E:GetModule("RayStyle")

local function StyleButton(self, button)
	if button.backdrop then
		button.backdrop:Hide()
		button.backdrop = nil
		button:CreateBackdrop("Transparent")
		button.backdrop:SetAllPoints()
	end
end
hooksecurefunc(AB, "StyleButton", StyleButton)