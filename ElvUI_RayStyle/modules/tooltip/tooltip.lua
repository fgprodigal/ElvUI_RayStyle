--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local TT = E:GetModule("Tooltip")
local RS = E:GetModule("RayStyle")

local TalentFrame = CreateFrame("Frame", nil)
TalentFrame:Hide()

local TALENTS_PREFIX = TALENTS
local NO_TALENTS = NONE..TALENTS
local CACHE_SIZE = 25
local INSPECT_DELAY = 0.2
local INSPECT_FREQ = 2

local gcol = {.35, 1, .6}
local pgcol = {1, .12, .8}

local talentcache = {}
local ilvcache = {}
local talentcurrent = {}
local ilvcurrent = {}
local highestilvl = 600

local lastInspectRequest = 0

local function IsInspectFrameOpen()
	return (InspectFrame and InspectFrame:IsShown()) or (Examiner and Examiner:IsShown())
end

local function GetPlayerScore(unit)
	local unitilvl = 0
	local ilvl, ilvlAdd, equipped = 0, 0, 0
	if (UnitIsPlayer(unit)) then
		for i = 1, 18 do
			if (i ~= 4) then
				local iLink = GetInventoryItemLink(unit, i)
				if (iLink) then
					ilvlAdd = RS:GetItemScore(iLink)
					if ilvlAdd then
						ilvl = ilvl + ilvlAdd
					end
					equipped = equipped + 1
				end
			end
		end
	end
	-- ClearInspectPlayer()
	return floor(ilvl / equipped)
end

local function GatherTalents(isInspect)
	local spec = isInspect and GetInspectSpecialization(talentcurrent.unit) or GetSpecialization()
	if (spec) and (spec > 0) then
		if isInspect then
			local _, specName, _, icon = GetSpecializationInfoByID(spec)
			icon = icon and "|T"..icon..":12:12:0:0:64:64:5:59:5:59|t " or ""
			talentcurrent.format = specName and icon..specName or "n/a"
		else
			local _, specName, _, icon = GetSpecializationInfo(spec)
			icon = icon and "|T"..icon..":12:12:0:0:64:64:5:59:5:59|t " or ""
			talentcurrent.format = specName and icon..specName or "n/a"
		end
	else
		talentcurrent.format = NO_TALENTS
	end

	if (not isInspect) then
		GameTooltip:AddDoubleLine(TALENTS_PREFIX, talentcurrent.format, nil, nil, nil, 1, 1, 1)
	elseif (GameTooltip:GetUnit()) then
		for i = 2, GameTooltip:NumLines() do
			if ((_G["GameTooltipTextLeft"..i]:GetText() or ""):match("^"..TALENTS_PREFIX)) then
				_G["GameTooltipTextRight"..i]:SetText(talentcurrent.format)
				if (not GameTooltip.fadeOut) then
					GameTooltip:Show()
				end
				break
			end
		end
	end

	for i = #talentcache, 1, -1 do
		if (talentcurrent.name == talentcache[i].name) then
			tremove(talentcache,i)
			break
		end
	end
	if (#talentcache > CACHE_SIZE) then
		tremove(talentcache,1)
	end

	if (CACHE_SIZE > 0) then
		talentcache[#talentcache + 1] = CopyTable(talentcurrent)
	end
end

function RS:SetiLV()
	local _, unit = GameTooltip:GetUnit()
	if not (unit) or not (UnitIsPlayer(unit)) or not (CanInspect(unit)) then
		return
	end

	local unitilvl = GetPlayerScore(unit)
	if (unitilvl > 1) then
		local r, g, b  = RS:GetQuality(unitilvl)
		ilvcurrent.format = E:RGBToHex(r, g, b)..unitilvl
		for i = 2, GameTooltip:NumLines() do
			if ((_G["GameTooltipTextLeft"..i]:GetText() or ""):match("^"..STAT_AVERAGE_ITEM_LEVEL)) then
				_G["GameTooltipTextRight"..i]:SetText(E:RGBToHex(r, g, b)..unitilvl)
				break
			end
		end
	end

	for i = #ilvcache, 1, -1 do
		if (ilvcurrent.name == ilvcache[i].name) then
			tremove(ilvcache,i)
			break
		end
	end
	if (#ilvcache > CACHE_SIZE) then
		tremove(ilvcache,1)
	end

	if (CACHE_SIZE > 0) then
		ilvcache[#ilvcache + 1] = CopyTable(ilvcurrent)
	end
end

function RS:GetQuality(ItemScore)
	if ItemScore < highestilvl then
		return 1, 1, 0.1
	else
		return RS:ColorGradient((ItemScore - highestilvl)/100, 1, 1, 0.1, 1, 0.1, 0.1)
	end
end

function RS:iLVSetUnit()
	local GMF = GetMouseFocus()
	local unit = (select(2, GameTooltip:GetUnit())) or (GMF and GMF:GetAttribute("unit"))

	if (not unit) and (UnitExists("mouseover")) then
		unit = "mouseover"
	end
	if not (unit) or not (UnitIsPlayer(unit)) or not (CanInspect(unit)) then
		return
	end

	local cacheLoaded = false
	wipe(ilvcurrent)
	ilvcurrent.unit = unit
	ilvcurrent.name = UnitName(unit)
	ilvcurrent.guid = UnitGUID(unit)

	for _, entry in ipairs(ilvcache) do
		if (ilvcurrent.name == entry.name and entry.format) then
			GameTooltip:AddDoubleLine(STAT_AVERAGE_ITEM_LEVEL, entry.format, nil, nil, nil, 1, 1, 1)
			ilvcurrent.format = entry.format
			cacheLoaded = true
			break
		end
	end
	if UnitIsUnit(unit, "player") then
		local unitilvl = GetPlayerScore("player")
		local r, g, b = RS:GetQuality(unitilvl)
		GameTooltip:AddDoubleLine(STAT_AVERAGE_ITEM_LEVEL, E:RGBToHex(r, g, b)..unitilvl, nil, nil, nil, 1, 1, 1)
	elseif not cacheLoaded then
		GameTooltip:AddDoubleLine(STAT_AVERAGE_ITEM_LEVEL, "...", nil, nil, nil, 1, 1, 1)
	end
end

function RS:INSPECT_READY(event, guid)
	self:UnregisterEvent(event)
	if (guid == talentcurrent.guid) then
		GatherTalents(1)
		self:SetiLV()
	end
end

function RS:GetItemScore(iLink)
	local _, _, itemRarity, itemLevel, _, _, _, _, itemEquip = GetItemInfo(iLink)
	if (IsEquippableItem(iLink)) then
		if not   (itemLevel > 1) and (itemRarity > 1) then
			return 0
		end
	end
	return RS:GetItemUpgradeLevel(iLink)
end

function RS:TalentSetUnit()
	TalentFrame:Hide()
	local GMF = GetMouseFocus()
	local unit = (select(2, GameTooltip:GetUnit())) or (GMF and GMF:GetAttribute("unit"))

	if (not unit) and (UnitExists("mouseover")) then
		unit = "mouseover"
	end
	if (not unit) or (not UnitIsPlayer(unit)) then
		return
	end
	local level = UnitLevel(unit)
	if (level > 9 or level == -1) then
		wipe(talentcurrent)
		talentcurrent.unit = unit
		talentcurrent.name = UnitName(unit)
		talentcurrent.guid = UnitGUID(unit)
		if (UnitIsUnit(unit,"player")) then
			GatherTalents()
			return
		end

		local cacheLoaded = false
		for _, entry in ipairs(talentcache) do
			if (talentcurrent.name == entry.name) then
				GameTooltip:AddDoubleLine(TALENTS_PREFIX, entry.format, nil, nil, nil, 1, 1, 1)
				talentcurrent.format = entry.format
				cacheLoaded = true
				break
			end
		end

		if (CanInspect(unit)) and (not IsInspectFrameOpen()) then
			local lastInspectTime = (GetTime() - lastInspectRequest)
			TalentFrame.nextUpdate = (lastInspectTime > INSPECT_FREQ) and INSPECT_DELAY or (INSPECT_FREQ - lastInspectTime + INSPECT_DELAY)
			TalentFrame:Show()
			if (not cacheLoaded) then
				GameTooltip:AddDoubleLine(TALENTS_PREFIX, "...", nil, nil, nil, 1, 1, 1)
			end
		end
	end
end

TalentFrame:SetScript("OnUpdate", function(self, elapsed)
	self.nextUpdate = (self.nextUpdate or 0 ) - elapsed
	if (self.nextUpdate <= 0) then
		self:Hide()
		if (UnitGUID("mouseover") == talentcurrent.guid) then
			lastInspectRequest = GetTime()
			RS:RegisterEvent("INSPECT_READY")
			if (InspectFrame) then
				InspectFrame.unit = "player"
			end
			NotifyInspect(talentcurrent.unit)
		end
	end
end)

local function CustomizeTooltip(self, tooltip)
	local GMF = GetMouseFocus()
	local unit = (select(2, tooltip:GetUnit())) or (GMF and GMF:GetAttribute("unit"))

	if UnitIsPlayer(unit) then
		local guild, rank = GetGuildInfo(unit)
		local playerGuild = GetGuildInfo("player")
		
		if guild then
			GameTooltipTextLeft2:SetFormattedText("<%s>"..E:RGBToHex(1, 1, 1).." %s|r", guild, rank)
			if IsInGuild() and guild == playerGuild then
				GameTooltipTextLeft2:SetTextColor(pgcol[1], pgcol[2], pgcol[3])
			else
				GameTooltipTextLeft2:SetTextColor(gcol[1], gcol[2], gcol[3])
			end
		end

		if UnitFactionGroup(unit) and UnitFactionGroup(unit) ~= "Neutral" then
			GameTooltipTextLeft1:SetText("|TInterface\\Addons\\ElvUI_RayStyle\\media\\UI-PVP-"..select(1, UnitFactionGroup(unit))..".blp:16:16:0:0:64:64:5:40:0:35|t "..GameTooltipTextLeft1:GetText())
		end
		
		RS:iLVSetUnit()
		RS:TalentSetUnit()
	end
end

DropDownList1MenuBackdrop:Kill()

hooksecurefunc(TT, "GameTooltip_OnTooltipSetUnit", CustomizeTooltip)

local function SetStyle(self, tt)
	if not tt.backdrop then
		tt:CreateBackdrop("Transparent")
		tt.backdrop:SetInside()

		local getBackdrop = function()
			return tt.backdrop:GetBackdrop()
		end

		local getBackdropColor = function()
			return unpack(E.media.backdropfadecolor)
		end

		local getBackdropBorderColor = function()
			return unpack(E.media.bordercolor)
		end

		tt.GetBackdrop = getBackdrop
		tt.GetBackdropColor = getBackdropColor
		tt.GetBackdropBorderColor = getBackdropBorderColor
	end
	tt:SetBackdrop(nil)
	tt:SetBackdropColor(E.media.backdropfadecolor)
	local item
	if tt.GetItem then
		item = select(2, tt:GetItem())
	end
	if item then
		local quality = select(3, GetItemInfo(item))
		if quality and quality > 1 then
			local r, g, b = GetItemQualityColor(quality)
			tt.backdrop:SetBackdropBorderColor(r, g, b)
		else
			tt.backdrop:SetBackdropBorderColor(0, 0, 0)
		end
	else
		tt.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
	end
end
hooksecurefunc(TT, "SetStyle", SetStyle)