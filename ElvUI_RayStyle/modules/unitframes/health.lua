--[[----------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains changes/additions to the ElvUI Unitframes
----------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local UF = E:GetModule("UnitFrames")
local LSM = LibStub("LibSharedMedia-3.0")
local ElvUF = ElvUI.oUF

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

local function PostUpdateHealPrediction(hp, unit)
	local myIncomingHeal = UnitGetIncomingHeals(unit, 'player') or 0
	local allIncomingHeal = UnitGetIncomingHeals(unit) or 0
	local totalAbsorb = UnitGetTotalAbsorbs(unit) or 0
	local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
	local frame = hp.parent

	if(health + allIncomingHeal > maxHealth * hp.maxOverflow) then
		allIncomingHeal = maxHealth * hp.maxOverflow - health
	end

	if(allIncomingHeal < myIncomingHeal) then
		myIncomingHeal = allIncomingHeal
		allIncomingHeal = 0
	else
		allIncomingHeal = allIncomingHeal - myIncomingHeal
	end

	local overAbsorb = false
	--We don't overfill the absorb bar
	if ( health + myIncomingHeal + allIncomingHeal + totalAbsorb >= maxHealth ) then
		if ( totalAbsorb > 0 ) then
			overAbsorb = true
		end
		totalAbsorb = max(0,maxHealth - (health + myIncomingHeal + allIncomingHeal))
	end

	if totalAbsorb == 0 then
		hp.absorbBar.overlay:Hide()
	else
		local totalWidth, totalHeight = frame.Health:GetSize()
		local totalMax = UnitHealthMax(unit)
		local barSize = (totalAbsorb / totalMax) * totalWidth
		if ( hp.absorbBar.overlay ) then
			hp.absorbBar.overlay:SetWidth(barSize)
			hp.absorbBar.overlay:SetTexCoord(0, barSize / hp.absorbBar.overlay.tileSize, 0, totalHeight / hp.absorbBar.overlay.tileSize)
			hp.absorbBar.overlay:Show()
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	for _, object in pairs(ElvUF.objects) do
		local health = object and object.Health
		if health then
			hooksecurefunc(health, "PostUpdate", PostUpdateHealth)
		end
		if object.HealPrediction and object.HealPrediction.absorbBar and not object.HealPrediction.absorbBar.overlay then
			local abbo = object:CreateTexture(nil, "ARTWORK", 1)
			abbo:SetPoint("TOPLEFT", object.HealPrediction.absorbBar, "TOPLEFT", 0, 0)
			abbo:SetPoint("BOTTOMLEFT", object.HealPrediction.absorbBar, "BOTTOMLEFT", 0, 0)
			abbo:SetTexture([[Interface\RaidFrame\Shield-Overlay]], true, true)
			abbo.tileSize = 32
			object.HealPrediction.absorbBar.overlay = abbo
		end
		if object.HealPrediction and not object.HealPrediction.overAbsorbGlow then
			local oag = object:CreateTexture(nil, "ARTWORK", 1)
			oag:SetWidth(15)
			oag:SetTexture([[Interface\RaidFrame\Shield-Overshield]])
			oag:SetBlendMode("ADD")
			oag:SetPoint("TOPLEFT", object.Health, "TOPRIGHT", -5, 0)
			oag:SetPoint("BOTTOMLEFT", object.Health, "BOTTOMRIGHT", -5, 0)
			object.HealPrediction.overAbsorbGlow = oag
			hooksecurefunc(object.HealPrediction, "PostUpdate", PostUpdateHealPrediction)
		end
		object:UpdateElement("HealPrediction")
	end
end)