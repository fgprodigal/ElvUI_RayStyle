--[[----------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains changes/additions to the ElvUI Unitframes
----------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local UF = E:GetModule("UnitFrames")
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
	if ElvUF_Player then
		EnableFader(ElvUF_Player)
	end
end)