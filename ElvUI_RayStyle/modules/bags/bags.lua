--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local B = E:GetModule("Bags")
local RS = E:GetModule("RayStyle")
local LSM = LibStub("LibSharedMedia-3.0")

local armor = GetAuctionItemClasses()
local weapon = select(2,GetAuctionItemClasses())

local function UpdateSlot(self, bagID, slotID)
	if (self.Bags[bagID] and self.Bags[bagID].numSlots ~= GetContainerNumSlots(bagID)) or not self.Bags[bagID] or not self.Bags[bagID][slotID] then		
		return
	end
	local slot, _ = self.Bags[bagID][slotID], nil
	local clink = GetContainerItemLink(bagID, slotID)

	if not slot.ilvl then
		slot.ilvl = slot:CreateFontString(nil, "OVERLAY")
		slot.ilvl:FontTemplate(nil, 11, "THINOUTLINE")
		slot.ilvl:SetPoint("TOPLEFT", 0, 0)
		slot.ilvl:SetShadowColor(0, 0)
		slot.ilvl:SetShadowOffset(1, -1)
	end

	slot.ilvl:SetText("")

	if clink then
		local _, _, _, itemLevel, _, itemType = GetItemInfo(clink)
		if itemType == armor or itemType == weapon and itemLevel > 1 then
			slot.ilvl:SetTextColor(RS:GetItemLevelColor(itemLevel))
			slot.ilvl:SetText(itemLevel)
		end
	end
end
hooksecurefunc(B, "UpdateSlot", UpdateSlot)

local slots = {"BackSlot", "ChestSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "HandsSlot", "HeadSlot", "LegsSlot", "MainHandSlot", "NeckSlot", "SecondaryHandSlot", "ShoulderSlot", "Trinket0Slot", "Trinket1Slot", "WaistSlot", "WristSlot"}
local function UpdateCharacterSlot(unit)
	for _, slot in pairs(slots) do
		local slotid = GetInventorySlotInfo(slot)
		if unit == "player" then
			slot = _G["Character"..slot]
		else
			slot = _G["Inspect"..slot]
		end
		if not slot.ilvl then
			slot.ilvl = slot:CreateFontString(nil, "OVERLAY")
			slot.ilvl:FontTemplate(nil, 11, "THINOUTLINE")
			slot.ilvl:SetPoint("TOPLEFT", 0, 0)
			slot.ilvl:SetShadowColor(0, 0)
			slot.ilvl:SetShadowOffset(1, -1)
		end
		slot.ilvl:SetText("")
		local id = GetInventoryItemID(unit, slotid)
		if id then
			local _, _, _, itemLevel = GetItemInfo(id)
			if itemLevel and itemLevel > 1 then
				slot.ilvl:SetTextColor(RS:GetItemLevelColor(itemLevel))
				slot.ilvl:SetText(itemLevel)
			end
		end
	end
end
local f = CreateFrame("Frame")
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self, event, addon)
	if event == "UNIT_INVENTORY_CHANGED" then
		UpdateCharacterSlot("player")
	elseif event == "PLAYER_ENTERING_WORLD" then
		UpdateCharacterSlot("player")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end)