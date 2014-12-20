-- [[----------------------------------------------------------
	-- RayStyle, an ElvUI edit by Ray

	-- This file contains core functions and updates media
------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local RS = E:GetModule("RayStyle")
local LSM = LibStub("LibSharedMedia-3.0")

local format = string.format

RS["media"] = {}

function RS.dummy()
	return
end

local ItemUpgrade = setmetatable ({
	[1]   =  8, -- 1/1
	[373] =  4, -- 1/2
	[374] =  8, -- 2/2
	[375] =  4, -- 1/3
	[376] =  4, -- 2/3
	[377] =  4, -- 3/3
	[378] =  7, -- 1/1
	[379] =  4, -- 1/2
	[380] =  4, -- 2/2
	[445] =  0, -- 0/2
	[446] =  4, -- 1/2
	[447] =  8, -- 2/2
	[451] =  0, -- 0/1
	[452] =  8, -- 1/1
	[453] =  0, -- 0/2
	[454] =  4, -- 1/2
	[455] =  8, -- 2/2
	[456] =  0, -- 0/1
	[457] =  8, -- 1/1
	[458] =  0, -- 0/4
	[459] =  4, -- 1/4
	[460] =  8, -- 2/4
	[461] = 12, -- 3/4
	[462] = 16, -- 4/4
	[465] =  0, -- 0/2
	[466] =  4, -- 1/2
	[467] =  8, -- 2/2
	[468] =  0, -- 0/4
	[469] =  4, -- 1/4
	[470] =  8, -- 2/4
	[471] = 12, -- 3/4
	[472] = 16, -- 4/4
	[476] =  0, -- 0/2
	[477] =  4, -- 1/2
	[478] =  8, -- 2/2
	[479] =  0, -- 0/1
	[480] =  8, -- 1/1
	[491] =  0, -- 0/2
	[492] =  4, -- 1/2
	[493] =  8, -- 2/2
	[494] =  0, -- 0/4
	[495] =  4, -- 1/4
	[496] =  8, -- 2/4
	[497] = 12, -- 3/4
	[498] = 16, -- 4/4
	[504] = 12, -- thanks Dridzt
	[505] = 16,
	[506] = 20,
	[507] = 24,
},{__index=function() return 0 end})

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
		local _, _, itemRarity, itemLevel, _, _, _, _, itemEquip = GetItemInfo(iLink)
		local code = string.match(iLink, ":(%d+):%d:%d|h")
		if not itemLevel then return 0 end
		return itemLevel + ItemUpgrade[tonumber(code)]
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

RS.Developer = { "夏琉君", "鏡婲水月", "Divineseraph", "水月君", "夏翎", }

function RS:IsDeveloper()
	for _, name in pairs(RS.Developer) do
		if name == E.myname then
			return true
		end
	end
	return false
end