--[[----------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains changes/additions to the ElvUI Unitframes
----------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local UF = E:GetModule("UnitFrames")
local LSM = LibStub("LibSharedMedia-3.0")
local ElvUF = ElvUI.oUF

local units = {"Player", "Target", "Focus", "Arena", "Boss"}

local function CustomizeCastbar(self)
	self.LatencyTexture:SetVertexColor(1, 0, 0, 0.75)
	self.Text:SetTextColor(1, 1, 1)
	self.Time:SetTextColor(1, 1, 1)
end

local function CustomizePlayerCastbar(self, frame, db)
	if db.castbar.height < 10 then
		local castbar = frame.Castbar
		if castbar then
			if castbar.Icon then
				castbar.Icon.bg:Size(20, 20)
				castbar.Icon.bg:ClearAllPoints()
				castbar.Icon.bg:Point("BOTTOMRIGHT", castbar, "BOTTOMLEFT", -3, -1)
			end
			castbar.Text:Point("BOTTOMLEFT", castbar, "TOPLEFT", 5, -2)
			castbar.Time:Point("BOTTOMRIGHT", castbar, "TOPRIGHT", -5, -2)
		end
	end
end
hooksecurefunc(UF, "Update_PlayerFrame", CustomizePlayerCastbar)

local function PostCastStart(self, unit, name, rank, castid)
	local r, g, b
    if UnitIsPlayer(unit) and UnitIsFriend(unit, "player") and UF.db.colors.castClassColor then
        r, g, b = unpack(ElvUF.colors.class[select(2, UnitClass(unit))])
    elseif self.interrupt then
        r, g, b = unpack(ElvUF.colors.castNoInterrupt)
    else
        r, g, b = unpack(ElvUF.colors.castColor)
    end
	self:SetStatusBarColor(r, g, b)
	UF:ToggleTransparentStatusBar(UF.db.colors.transparentCastbar, self, self.bg, nil, true)
	if self.bg:IsShown() then
		self.bg:SetTexture(r * 0.25, g * 0.25, b * 0.25)
		
		local _, _, _, alpha = self.backdrop:GetBackdropColor()
		self.backdrop:SetBackdropColor(r * 0.58, g * 0.58, b * 0.58, alpha)		
	end	
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	for _, unit in pairs(units) do
		if unit == "Player" or unit == "Target" or unit == "Focus" then
			local unitframe = _G["ElvUF_"..unit]
			local castbar = unitframe and unitframe.Castbar
			if castbar then
				CustomizeCastbar(castbar)
			end
		end
	end
	
	do
		local castbar = _G["ElvUF_Target"].Castbar
		if castbar then
			hooksecurefunc(castbar, "PostCastStart", PostCastStart)
		end
	end

	for i = 1, 5 do
		local castbar = _G["ElvUF_Arena"..i].Castbar
		if castbar then
			CustomizeCastbar(castbar)
		end
	end

	for i = 1, MAX_BOSS_FRAMES do
		local castbar = _G["ElvUF_Boss"..i].Castbar
		if castbar then
			CustomizeCastbar(castbar)
		end
	end
end)