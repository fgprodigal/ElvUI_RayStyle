-- [[----------------------------------------------------------
	-- RayStyle, an ElvUI edit by Ray

	-- This file contains core functions and updates media
------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local RS = E:GetModule("RayStyle")
local LSM = LibStub("LibSharedMedia-3.0")
local LibItemUpgrade = LibStub("LibItemUpgradeInfo-1.0")

local format = string.format

RS["media"] = {}
RS.TexCoords = {.08, 0.92, -.04, 0.92}

function RS.dummy()
	return
end

function RS:Print(msg)
	print("|cff00b3ffRayStyle:|r", msg)
end

-- Copied from ElvUI
local function RGBToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return format("%02x%02x%02x", r*255, g*255, b*255)
end

function RS:ColorStr(str, r, g, b)
	local hex
	local coloredString
	
	if r and g and b then
		hex = RGBToHex(r, g, b)
	else
		hex = RGBToHex(0, 0.7, 1) --Light blue
	end
	
	coloredString = "|cff"..hex..str.."|r"
	return coloredString
end

function RS:SetMoverPosition(mover, point, anchor, secondaryPoint, x, y)
	if not _G[mover] then return end
	local frame = _G[mover]

	frame:ClearAllPoints()
	frame:SetPoint(point, anchor, secondaryPoint, x, y)
	E:SaveMoverPosition(mover)
end

function RS:GetItemUpgradeLevel(iLink)
	if not iLink then
		return 0
	else
		return LibItemUpgrade:GetUpgradedItemLevel(iLink)
	end
end

function RS:ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select("#", ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end

	local num = select("#", ...) / 3
	local segment, relperc = math.modf(perc*(num-1))
	local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

function E:ShortValue(v)
	if E.db.RS.general.numberType == 1 or ( GetLocale()~="zhCN" and GetLocale()~="zhTW" ) then
		if v >= 1e9 then
			return ("%.1fb"):format(v / 1e9):gsub("%.?0+([kmb])$", "%1")
		elseif v >= 1e6 then
			return ("%.1fm"):format(v / 1e6):gsub("%.?0+([kmb])$", "%1")
		elseif v >= 1e3 or v <= -1e3 then
			return ("%.1fk"):format(v / 1e3):gsub("%.?0+([kmb])$", "%1")
		else
			return v
		end
	else
		if v >= 1e8 or v <= -1e8 then
			return ("%.1f" .. SECOND_NUMBER_CAP):format(v / 1e8):gsub("%.?0+([kmb])$", "%1")
		elseif v >= 1e4 or v <= -1e4 then
			return ("%.1f" .. FIRST_NUMBER_CAP):format(v / 1e4):gsub("%.?0+([kmb])$", "%1")
		else
			return v
		end
	end
end

local smoothing = {}
local function Smooth(self, value)
	if value ~= self:GetValue() or value == 0 then
		smoothing[self] = value
	else
		smoothing[self] = nil
	end
end

function RS:SmoothBar(bar)
	if not bar.SetValue_ then
		bar.SetValue_ = bar.SetValue
		bar.SetValue = Smooth
	end
end

local SmoothUpdate = CreateFrame("Frame")
SmoothUpdate:SetScript("OnUpdate", function()
	local rate = GetFramerate()
	local limit = 30/rate

	for bar, value in pairs(smoothing) do
		local cur = bar:GetValue()
		local new = cur + min((value-cur)/3, max(value-cur, limit))
		if new ~= new then
			new = value
		end
		bar:SetValue_(new)
		if (cur == value or math.abs(new - value) < 1) then
			bar:SetValue_(value)
			smoothing[bar] = nil
		end
	end
end)

local GREY = {0.55,0.55,0.55}
local RED = {1,0,0}
local ORANGE = {1,0.7,0}
local YELLOW = {1,1,0}
local GREEN = {0,1,0}

function RS:GetItemLevelColor(ilevel)
	local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
	if ilevel > avgItemLevelEquipped then
		return unpack(RED)
	elseif avgItemLevelEquipped - ilevel < 20 then
		return unpack(ORANGE)
	elseif avgItemLevelEquipped - ilevel < 40 then
		return unpack(YELLOW)
	elseif avgItemLevelEquipped - ilevel < 60 then
		return unpack(GREEN)
	else
		return unpack(GREY)
	end
end
RS.Developer = { "夏琉君", "鏡婲水月", "Divineseraph", "水月君", "夏翎", }

function RS:IsDeveloper()
	for _, name in pairs(RS.Developer) do
		if name == E.myname then
			return true
		end
	end
	return false
end