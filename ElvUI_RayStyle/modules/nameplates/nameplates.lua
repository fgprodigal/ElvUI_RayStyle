--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local NP = E:GetModule("NamePlates")
local RS = E:GetModule("RayStyle")

local function SetStyle(self, frame)
	RS:SmoothBar(NP.CreatedPlates[frame].healthBar)
end
hooksecurefunc(NP, "CreatePlate", SetStyle)