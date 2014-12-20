--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local AB = E:GetModule("ActionBars")
local RS = E:GetModule("RayStyle")

local function StyleActionButton(button)
	if button.backdrop then
		button.backdrop:Hide()
		button.backdrop = nil
		button:CreateBackdrop("Transparent")
		button.backdrop:SetAllPoints()
	end
end

function RS:StyleActionButton(button)
	StyleActionButton(button)
end
hooksecurefunc(AB, "StyleButton", RS.StyleActionButton)

local function SetupExtraButton()
	local button = DraenorZoneAbilityFrame.SpellButton
	if button then
		button.NormalTexture:Kill()
		button.Style:SetDrawLayer("BACKGROUND")
	end
end
hooksecurefunc(AB, "SetupExtraButton", SetupExtraButton)