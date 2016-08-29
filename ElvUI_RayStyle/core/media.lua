--[[---------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains the code that registers media
---------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local CNB = E:GetModule("RayStyle")
local LSM = LibStub("LibSharedMedia-3.0")

local function UpdateUFColors()
	ElvUF["colors"].class = {
		["DEATHKNIGHT"] = { 0.77,	0.12,		0.23 },
		["DRUID"]       = { 1,		0.49,		0.04 },
		["HUNTER"]      = { 0.58,	0.86,		0.49 },
		["MAGE"]        = { 0.2,	0.76,		1 },
		["PALADIN"]     = { 1,		0.42,		0.62 },
		["PRIEST"]      = { 1,		1,			1 },
		["ROGUE"]       = { 1,		0.91,		0.3 },
		["SHAMAN"]      = { 0.16,	0.31,		0.61 },
		["WARLOCK"]     = { 0.6,	0.47,		0.85 },
		["WARRIOR"]     = { 0.9,	0.65,		0.45 },
		["MONK"]        = { 0,		1,			0.59 },
	}
end
UpdateUFColors()

-- CUSTOM_CLASS_COLORS = {}
-- for class, color in pairs(ElvUF["colors"].class) do
	-- CUSTOM_CLASS_COLORS[class] = { r = color[1], g = color[2], b = color[3] }
-- end

E.TimeColors = {
	[0] = NORMAL_FONT_COLOR_CODE,
	[1] = NORMAL_FONT_COLOR_CODE,
	[2] = NORMAL_FONT_COLOR_CODE,
	[3] = "|cffff0000",
	[4] = "|cffff0000",
}

LSM:Register("statusbar","RayStyle Normal", [[Interface\AddOns\ElvUI_RayStyle\media\statusbar.tga]])
LSM:Register("statusbar","RayStyle Gloss", [[Interface\AddOns\ElvUI_RayStyle\media\gloss.tga]])
LSM:Register("font","RayStyle RoadWay", [[Interface\AddOns\ElvUI_RayStyle\media\roadway.ttf]], 255)
LSM:Register("font","RayStyle Pixel", [[Interface\AddOns\ElvUI_RayStyle\media\pixel.ttf]], 255)
if GetLocale() == "zhCN" then
	LSM:Register("font","RayStyle Font", [[Fonts\ARKai_T.ttf]], 255)
	LSM:Register("font","RayStyle Combat", [[Fonts\ARKai_DB.ttf]], 255)
elseif GetLocale() == "zhTW" then
	LSM:Register("font","RayStyle Font", [[Fonts\bLEI00D.ttf]], 255)
	LSM:Register("font","RayStyle Combat", [[Fonts\bKAI00M.ttf]], 255)
else
	LSM:Register("font","RayStyle Font", [[Fonts\ARIALN.ttf]], 255)
	LSM:Register("font","RayStyle Combat", [[Fonts\Morpheus.ttf]], 255)
end

local UF = E:GetModule("UnitFrames")
hooksecurefunc(UF, "UpdateColors", UpdateUFColors)
