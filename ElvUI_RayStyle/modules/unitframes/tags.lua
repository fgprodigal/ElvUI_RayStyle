--[[----------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains changes/additions to the ElvUI Unitframes
----------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local UF = E:GetModule("UnitFrames")
local ElvUF = ElvUI.oUF

local function Hex(r, g, b)
	if type(r) == "table" then
		if r.r then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
	end
	if not r or type(r) == 'string' then --wtf?
		return '|cffFFFFFF'
	end
	return format("|cff%02x%02x%02x", r*255, g*255, b*255)
end
	
ElvUF.Tags.Events["RayStyle:healthcolor"] = "UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED"
ElvUF.Tags.Methods["RayStyle:healthcolor"] = function(unit)
	local _, class = UnitClass(unit)
    local reaction = UnitReaction(unit, "player")

    if (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
        return Hex(ElvUF.colors.tapped)
    elseif (UnitIsPlayer(unit)) then
        return Hex(ElvUF.colors.class[class])
    elseif reaction then
        return Hex(ElvUF.colors.reaction[reaction])
    else
        return Hex(1, 1, 1)
    end
end