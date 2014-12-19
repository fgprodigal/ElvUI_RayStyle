--[[----------------------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains changes/additions to the unitframe & nameplate filters
----------------------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore

local function SpellName(id)
	local name, _, _, _, _, _, _, _, _ = GetSpellInfo(id) 	
	if not name then
		print('|cff1784d1ElvUI:|r SpellID is not valid: '..id..'. Please check for an updated version, if none exists report to ElvUI author.')
		return 'Impale'
	else
		return name
	end
end

local function Defaults(priorityOverride)
	return {['enable'] = true, ['priority'] = priorityOverride or 0}
end

local function DefaultsID(spellID, priorityOverride)
	return {['enable'] = true, ['spellID'] = spellID, ['priority'] = priorityOverride or 0}
end

local blacklist = {
	--Placeholder
}

local whitelist = {
	--Placeholder
}

local whitelistStrict = {
	--Placeholder
}

for _, spellID in pairs(blacklist) do
	G.unitframe.aurafilters['Blacklist']['spells'][SpellName(spellID)] = Defaults()
end

for _, spellID in pairs(whitelist) do
	G.unitframe.aurafilters['Whitelist']['spells'][SpellName(spellID)] = Defaults()
end

for _, spellID in pairs(whitelistStrict) do
	G.unitframe.aurafilters['Whitelist (Strict)']['spells'][SpellName(spellID)] = DefaultsID(spellID)
end