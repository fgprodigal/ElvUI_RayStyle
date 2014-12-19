local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local M = E:GetModule("Misc")
local RS = E:GetModule("RayStyle")

function RS:LoadMisc_Auction()
	if not E.db.RS.misc.auction then return end

	-- Shift + 右键直接一口价
	local MAX_BUYOUT_PRICE = 10000000

	local auction = CreateFrame("Frame")
	auction:RegisterEvent("ADDON_LOADED")
	auction:SetScript("OnEvent", function(self, event, addon)
		if addon ~= "Blizzard_AuctionUI" then return end
		self:UnregisterEvent("ADDON_LOADED")
		for i = 1, 20 do
			local f = _G["BrowseButton"..i]
			if f then
				f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
				f:HookScript("OnClick", function(self, button)
					if button == "RightButton" and IsShiftKeyDown() then
						local index = self:GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame)
						local name, _, _, _, _, _, _, _, _, buyoutPrice = GetAuctionItemInfo("list", index)
						if name then
							if buyoutPrice < MAX_BUYOUT_PRICE then
								PlaceAuctionBid("list", index, buyoutPrice)
							end
						end
					end
				end)
			end
		end
		for i = 1, 20 do
			local f = _G["AuctionsButton"..i]
			if f then
				f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
				f:HookScript("OnClick", function(self, button)
					local index = self:GetID() + FauxScrollFrame_GetOffset(AuctionsScrollFrame)
					if button == "RightButton" and IsShiftKeyDown() then
						local name = GetAuctionItemInfo("owner", index)
						if name then
							CancelAuction(index)
						end
					end
				end)
			end
		end
	end)
end

hooksecurefunc(M, "Initialize", RS.LoadMisc_Auction)