--[[------------------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains the extra settings added in this edit of ElvUI
--	Positions are set in the install along with tweaks to the healer layout
------------------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local LSM = LibStub("LibSharedMedia-3.0")
local RS = E:GetModule("RayStyle")

P["RS"] = {	
	["general"] = {
		["cdFont"] = "RayStyle RoadWay",
		["numberType"] = 2,
	},

	["actionbar"] = {		
		["bar1"] = {
			["autohide"] = true,
		},
		
		["bar2"] = {
			["autohide"] = true,
		},
		
		["bar3"] = {
			["autohide"] = true,
		},
	},
	
	["datatexts"] = {
		["panels"] = {
			["Bottom_Datatext_Panel"] = {
				["left"] = "Friends",
				["middle"] = "Spell/Heal Power",
				["right"] = "Guild",
			},
		},
	},
	
	["misc"]={
		["anounce"] = true,
		["auction"] = true,
		["quest"] = true,
		["automation"] = true,
	},
}