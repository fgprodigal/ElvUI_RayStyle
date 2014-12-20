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

local function UnitFramesOptions()
	local group = {}
	for i=1, 6 do
		local name = L["Bar "]..i
		group["bar"..i] = {
			order = i,
			name = name,
			type = "group",
			get = function(info)
				return E.db.RS.actionbar["bar"..i][ info[#info] ]
			end,
			set = function(info, value)
				E.db.RS.actionbar["bar"..i][ info[#info] ] = value
				E:StaticPopup_Show("CONFIG_RL")
			end,
			args = {
				autohide = {
					order = 1,
					type = "toggle",
					name = L["自动隐藏"],
				},
			},
		}
	end
	E.Options.args.RS.args.config.args.actionbar = {
		order = 1,
		type = "group",
		name = L["ActionBars"],
		args = {
			header = {
				order = 1,
				type = "header",
				name = RS:ColorStr(L["ActionBars"]),
			},
			general = {
				order = 2,
				type = "group",
				name = L["General"],
				guiInline = true,
				args = group,
			},
		},
	}
end
RS.configs["actionbar"] = UnitFramesOptions