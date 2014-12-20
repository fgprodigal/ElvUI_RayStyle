--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local A = E:GetModule("Auras")
local RS = E:GetModule("RayStyle")
local LSM = LibStub("LibSharedMedia-3.0")

local function UpdateHeader(self, header)
	local index = 1
	local child = select(index, header:GetChildren())
	while(child) do
		if(child.time) then
			child.time:FontTemplate(LSM:Fetch("font", E.db.RS.general.cdFont), self.db.fontSize, self.db.fontOutline)
			child.count:FontTemplate(LSM:Fetch("font", E.db.RS.general.cdFont), self.db.fontSize, self.db.fontOutline)
		end

		index = index + 1
		child = select(index, header:GetChildren())
	end
end
hooksecurefunc(A, "UpdateHeader", UpdateHeader)

local function StyleIcon(self, button)
	button.time:FontTemplate(LSM:Fetch("font", E.db.RS.general.cdFont), self.db.fontSize, self.db.fontOutline)
	button.count:FontTemplate(LSM:Fetch("font", E.db.RS.general.cdFont), self.db.fontSize, self.db.fontOutline)
end
hooksecurefunc(A, "CreateIcon", StyleIcon)