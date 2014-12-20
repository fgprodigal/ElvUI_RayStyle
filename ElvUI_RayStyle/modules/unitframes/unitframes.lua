--[[----------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains changes/additions to the ElvUI Unitframes
----------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local UF = E:GetModule("UnitFrames")
local RS = E:GetModule("RayStyle")
local LSM = LibStub("LibSharedMedia-3.0")
local ElvUF = ElvUI.oUF

local function EnableFader(frame)
	frame.Fader = true
	frame.FadeSmooth = 0.5
	frame.FadeMinAlpha = 0.15
	frame.FadeMaxAlpha = 1
	frame:EnableElement("Fader")
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	if ElvUF_Player and E.db.RS.unitframe.fader then
		EnableFader(ElvUF_Player)
	end
end)

local function UnitFramesOptions()
	E.Options.args.RS.args.config.args.unitframe = {
		order = 1,
		type = "group",
		name = L["UnitFrames"],
		args = {
			header = {
				order = 1,
				type = "header",
				name = RS:ColorStr(L["UnitFrames"]),
			},
			general = {
				order = 2,
				type = "group",
				name = L["General"],
				guiInline = true,
				get = function(info)
					return E.db.RS.unitframe[ info[#info] ]
				end,
				set = function(info, value)
					E.db.RS.unitframe[ info[#info] ] = value
					E:StaticPopup_Show("CONFIG_RL")
				end,
				args = {
					fader = {
						order = 1,
						type = "toggle",
						name = L["头像渐隐"],
						desc = L["开启/关闭头像渐隐"],
					},
				},
			},
		},
	}
end
RS.configs["unitframe"] = UnitFramesOptions