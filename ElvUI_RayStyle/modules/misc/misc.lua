--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local M = E:GetModule("Misc")
local RS = E:GetModule("RayStyle")

local hideStatic = false
local f = CreateFrame("Frame")
f:RegisterEvent("PARTY_INVITE_REQUEST")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:SetScript("OnEvent", function(self, event)
	if event == "PARTY_INVITE_REQUEST" then
		if QueueStatusMinimapButton:IsShown() then return end
		if IsInGroup() then return end
		hideStatic = true
	elseif event == "GROUP_ROSTER_UPDATE" and hideStatic == true then
		StaticPopup_Hide("PARTY_INVITE")
		StaticPopup_Hide("PARTY_INVITE_XREALM")
		hideStatic = false
	end
end)

local function MiscOptions()
	E.Options.args.RS.args.config.args.misc = {
		order = 1,
		type = "group",
		name = L["杂项"],
		args = {
			header = {
				order = 1,
				type = "header",
				name = RS:ColorStr(L["杂项"]),
			},
			general = {
				order = 2,
				type = "group",
				name = L["General"],
				guiInline = true,
				get = function(info)
					return E.db.RS.misc[ info[#info] ]
				end,
				set = function(info, value)
					E.db.RS.misc[ info[#info] ] = value
					E:StaticPopup_Show("CONFIG_RL")
				end,
				args = {
					automation = {
						order = 1,
						type = "toggle",
						name = L["自动交接任务"],
						desc = L["自动交接任务，按shift点npc则不自动交接"],
					},
				},
			},
		},
	}
end
RS.configs["misc"] = MiscOptions