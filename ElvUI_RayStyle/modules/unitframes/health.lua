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

local function ColorGradient(perc, color1, color2, color3)
	local r1,g1,b1 = 1, 0, 0
	local r2,g2,b2 = .85, .8, .45
	local r3,g3,b3 = .12, .12, .12

	if perc >= 1 then
		return r3, g3, b3
	elseif perc <= 0 then
		return r1, g1, b1
	end

	local segment, relperc = math.modf(perc*(3-1))
	local offset = (segment*3)+1

	-- < 50% > 0%
	if(offset == 1) then
		return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
	end
	-- < 99% > 50%
	return r2 + (r3-r2)*relperc, g2 + (g3-g2)*relperc, b2 + (b3-b2)*relperc
end

local function PostUpdateHealth(self, unit, min, max)
	local parent = self:GetParent()
	local colors = E.db["unitframe"]["colors"]
	local curhealth, maxhealth
	if colors.colorhealthbyvalue and not colors.healthclass then
		self.colorSmooth = false
		if not curhealth then
			curhealth, maxhealth = UnitHealth(unit), UnitHealthMax(unit)
		end
		local r, g, b = ColorGradient(curhealth/maxhealth)

		if b then
			self:SetStatusBarColor(r, g, b, 1)
		end
		if UnitIsDeadOrGhost(unit) or (not UnitIsConnected(unit)) then
			self:SetStatusBarColor(.5, .5, .5)
			if self.bg then
				self.bg:SetVertexColor(.5, .5, .5)
			end
		else
			if self.bg then
				self.bg:SetVertexColor(r*.25, g*.25, b*.25)
			end
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	for _, unit in pairs(units) do
		if unit == "Player" or unit == "Target" or unit == "Focus" then
			local unitframe = _G["ElvUF_"..unit];
			local health = unitframe and unitframe.Health
			if health then
				hooksecurefunc(health, "PostUpdate", PostUpdateHealth)
			end
		end
	end

	for i = 1, 5 do
		local health = _G["ElvUF_Arena"..i].Health
		if health then
			hooksecurefunc(health, "PostUpdate", PostUpdateHealth)
		end
	end

	for i = 1, MAX_BOSS_FRAMES do
		local health = _G["ElvUF_Boss"..i].Health
		if health then
			hooksecurefunc(health, "PostUpdate", PostUpdateHealth)
		end
	end
end)