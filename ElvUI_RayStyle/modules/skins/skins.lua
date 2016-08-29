--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local S = E:GetModule("Skins")
local RS = E:GetModule("RayStyle")
local RSS = E:NewModule("RayStyleSkins", "AceHook-3.0", "AceEvent-3.0")

function RSS:CreateStripesThin(f)
	if not f then return end
	f.stripesthin = f:CreateTexture(nil, "BACKGROUND", nil, 1)
	f.stripesthin:SetAllPoints()
	f.stripesthin:SetTexture([[Interface\AddOns\RayUI\media\StripesThin]], true, true)
	f.stripesthin:SetHorizTile(true)
	f.stripesthin:SetVertTile(true)
	f.stripesthin:SetBlendMode("ADD")
end

function RSS:BlizzardUI_LOD_Skins(event, addon)
	if E.private.skins.blizzard.enable ~= true then return end

	if (event == 'ADDON_LOADED') then
		if addon == 'Blizzard_AchievementUI' and E.private.skins.blizzard.achievement == true then
			local frame = _G["AchievementFrame"]
			RSS:CreateStripesThin(frame)
		end

		if addon == 'Blizzard_ArchaeologyUI' and E.private.skins.blizzard.archaeology == true then
			local frame = _G["ArchaeologyFrame"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_ArtifactUI' and E.private.skins.blizzard.artifact == true then
			local frame = _G["ArtifactFrame"]
			RSS:CreateStripesThin(frame)
			frame.CloseButton:ClearAllPoints()
			frame.CloseButton:SetPoint("TOPRIGHT", ArtifactFrame, "TOPRIGHT", 2, 2)
		end

		if addon == 'Blizzard_AuctionUI' and E.private.skins.blizzard.auctionhouse == true then
			local frame = _G["AuctionFrame"]
			RSS:CreateStripesThin(frame)
			if not _G["AuctionProgressFrame"].stripesthin then
				RSS:CreateStripesThin(_G["AuctionProgressFrame"])
			end
			if not _G["WowTokenGameTimeTutorial"].stripesthin then
				RSS:CreateStripesThin(_G["WowTokenGameTimeTutorial"])
			end
		end
		
		if addon == 'Blizzard_BarbershopUI' and E.private.skins.blizzard.barber == true then
			local frame = _G["BarberShopFrame"]
			RSS:CreateStripesThin(frame)
			RSS:CreateStripesThin(_G["BarberShopAltFormFrame"])
		end
		
		if addon == 'Blizzard_BattlefieldMinimap' and E.private.skins.blizzard.bgmap == true then
			local frame = _G["BattlefieldMinimap"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_BindingUI' and E.private.skins.blizzard.binding == true then
			local frame = _G["KeyBindingFrame"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_BlackMarketUI' and E.private.skins.blizzard.bmah == true then
			local frame = _G["BlackMarketFrame"]
			RSS:CreateStripesThin(frame)
		end

		if addon == 'Blizzard_Calendar' and E.private.skins.blizzard.calendar == true then
			RSS:CreateStripesThin(_G["CalendarFrame"])
			RSS:CreateStripesThin(_G["CalendarViewEventFrame"])
			RSS:CreateStripesThin(_G["CalendarViewHolidayFrame"])
			RSS:CreateStripesThin(_G["CalendarCreateEventFrame"])
			RSS:CreateStripesThin(_G["CalendarContextMenu"])
		end

		if addon == 'Blizzard_Collections' and E.private.skins.blizzard.collections == true then
			local frame = _G["CollectionsJournal"]
			RSS:CreateStripesThin(frame)
		end

		if addon == 'Blizzard_DeathRecap' and E.private.skins.blizzard.deathRecap == true then
			local frame = _G["DeathRecapFrame"]
			RSS:CreateStripesThin(frame)
		end

		if addon == 'Blizzard_GuildBankUI' and E.private.skins.blizzard.gbank == true then
			local frame = _G["GuildBankFrame"]
			RSS:CreateStripesThin(frame)
			for i = 1, 8 do
				local button = _G['GuildBankTab'..i..'Button']
				local texture = _G['GuildBankTab'..i..'ButtonIconTexture']
				if not button.stripesthin then
					RSS:CreateStripesThin(button)
					texture:SetTexCoord(unpack(RS.TexCoords))
				end
			end
		end

		if addon == 'Blizzard_GuildUI' and E.private.skins.blizzard.guild == true then
			local frame = _G["GuildFrame"]
			RSS:CreateStripesThin(frame)
			local GuildFrames = {_G["GuildMemberDetailFrame"], _G["GuildTextEditFrame"], _G["GuildLogFrame"], _G["GuildNewsFiltersFrame"]}
			for _, frame in pairs(GuildFrames) do
				if frame and not frame.stripesthin then
					RSS:CreateStripesThin(frame)
				end
			end
		end

		if addon == 'Blizzard_GuildControlUI' and E.private.skins.blizzard.guildcontrol == true then
			local frame = _G["GuildControlUI"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_InspectUI' and E.private.skins.blizzard.inspect == true then
			local frame = _G["InspectFrame"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_ItemAlterationUI' and E.private.skins.blizzard.transmogrify == true then
			local frame = _G["TransmogrifyFrame"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_ItemUpgradeUI' and E.private.skins.blizzard.itemUpgrade == true then
			local frame = _G["ItemUpgradeFrame"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_ItemSocketingUI' and E.private.skins.blizzard.socket == true then
			local frame = _G["ItemSocketingFrame"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_LookingForGuildUI' and E.private.skins.blizzard.lfguild == true then
			local frame = _G["LookingForGuildFrame"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_MacroUI' and E.private.skins.blizzard.macro == true then
			local frame = _G["MacroFrame"]
			RSS:CreateStripesThin(frame)
		end

		if addon == 'Blizzard_TalentUI' and E.private.skins.blizzard.talent == true then
			local frame = _G["PlayerTalentFrame"]
			RSS:CreateStripesThin(frame)
			for i = 1, 2 do
				local tab = _G['PlayerSpecTab'..i]
				if not tab.stripesthin then
					RSS:CreateStripesThin(tab)
					tab:GetNormalTexture():SetTexCoord(unpack(RS.TexCoords))
					tab:GetNormalTexture():SetInside()
				end
			end
		end

		if addon == 'Blizzard_TradeSkillUI' and E.private.skins.blizzard.trade == true then
			local frame = _G["TradeSkillFrame"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_TrainerUI' and E.private.skins.blizzard.trainer == true then
			local frame = _G["ClassTrainerFrame"]
			RSS:CreateStripesThin(frame)
		end
		
		if addon == 'Blizzard_VoidStorageUI' and E.private.skins.blizzard.voidstorage == true then
			local frame = _G["VoidStorageFrame"]
			RSS:CreateStripesThin(frame)
			for i = 1, 2 do
				local tab = _G["VoidStorageFrame"]["Page"..i]
				if not tab.stripesthin then
					RSS:CreateStripesThin(tab)
					tab:GetNormalTexture():SetTexCoord(unpack(RS.TexCoords))
					tab:GetNormalTexture():SetInside()
				end
			end
		end
	end
	
	if addon == 'Blizzard_EncounterJournal' and E.private.skins.blizzard.encounterjournal == true then
		if not _G["EncounterJournal"].stripesthin then
			RSS:CreateStripesThin(_G["EncounterJournal"])
		end
		RSS:CreateStripesThin(_G["EncounterJournalTooltip"])
		local Tabs = {
			_G["EncounterJournalEncounterFrameInfoBossTab"],
			_G["EncounterJournalEncounterFrameInfoLootTab"],
			_G["EncounterJournalEncounterFrameInfoModelTab"],
			_G["EncounterJournalEncounterFrameInfoOverviewTab"]
		}
		
		for _, Tab in pairs(Tabs) do
			if Tab.backdrop then
				RSS:CreateStripesThin(Tab.backdrop)
			end
		end
	end
	
	if addon == 'Blizzard_TalkingHeadUI' and E.private.skins.blizzard.talkinghead == true then
		local frame = _G["TalkingHeadFrame"]
		if frame then
			frame.BackgroundFrame:StripTextures()
			frame.BackgroundFrame:CreateBackdrop('Transparent')
			frame.BackgroundFrame.backdrop:SetAllPoints()
			frame.MainFrame.Model:SetTemplate('Transparent')
			frame.MainFrame.Model:CreateShadow('Default')
			
			local button = TalkingHeadFrame.MainFrame.CloseButton
			S:HandleCloseButton(button)
			button:ClearAllPoints()
			button:Point('TOPRIGHT', TalkingHeadFrame.BackgroundFrame, 'TOPRIGHT', 0, -2)
			
			RSS:CreateStripesThin(frame.BackgroundFrame)
		end
	end

	if addon == 'Blizzard_QuestChoice' and E.private.skins.blizzard.questChoice == true then
		if not _G["QuestChoiceFrame"].stripesthin then
			RSS:CreateStripesThin(_G["QuestChoiceFrame"])
		end
	end
	
	if addon == 'Blizzard_FlightMap' and E.private.skins.blizzard.taxi == true then
		RSS:CreateStripesThin(_G["FlightMapFrame"])
	end

	if E.private.skins.blizzard.timemanager == true then
		if not _G["TimeManagerFrame"].stripesthin then
			RSS:CreateStripesThin(_G["TimeManagerFrame"])
		end
		
		if not _G["StopwatchFrame"].backdrop.stripesthin then
			RSS:CreateStripesThin(_G["StopwatchFrame"].backdrop)
		end
	end

	if addon == 'Blizzard_PVPUI' and E.private.skins.blizzard.pvp == true then
		if not _G["PVPRewardTooltip"].stripesthin then
			RSS:CreateStripesThin(_G["PVPRewardTooltip"])
		end
	end
end

local MAX_STATIC_POPUPS = 4

local tooltips = {
	FriendsTooltip,
	ItemRefTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
}

-- Blizzard Styles
local function styleFreeBlizzardFrames()
	RSS:CreateStripesThin(ColorPickerFrame)
	RSS:CreateStripesThin(MinimapRightClickMenu)
	
	for _, frame in pairs(tooltips) do
		if frame and not frame.stripesthin then
			RSS:CreateStripesThin(frame)
		end
	end

	if E.private.skins.blizzard.enable ~= true then return end
	
	local db = E.private.skins.blizzard
	
	if db.addonManager then
		RSS:CreateStripesThin(AddonList)
	end
	
	if db.bgscore then
		RSS:CreateStripesThin(WorldStateScoreFrame)
	end
	
	if db.character then
		RSS:CreateStripesThin(GearManagerDialogPopup)
		RSS:CreateStripesThin(PaperDollFrame)
		RSS:CreateStripesThin(ReputationDetailFrame)
		RSS:CreateStripesThin(ReputationFrame)
		RSS:CreateStripesThin(TokenFrame)
		RSS:CreateStripesThin(TokenFramePopup)
	end
	
	if db.dressingroom then
		RSS:CreateStripesThin(DressUpFrame)
	end

	if db.friends then
		RSS:CreateStripesThin(AddFriendFrame)
		RSS:CreateStripesThin(ChannelFrameDaughterFrame.backdrop)
		RSS:CreateStripesThin(FriendsFrame)
		RSS:CreateStripesThin(FriendsFriendsFrame.backdrop)
		RSS:CreateStripesThin(RecruitAFriendFrame)
	end
	
	if db.gossip then
		RSS:CreateStripesThin(GossipFrame)
		RSS:CreateStripesThin(ItemTextFrame)
	end
	
	if db.guildregistrar then
		RSS:CreateStripesThin(GuildRegistrarFrame)
	end

	if db.help then
		RSS:CreateStripesThin(HelpFrame.backdrop)
		RSS:CreateStripesThin(HelpFrameHeader.backdrop)
	end

	if db.lfg then
		RSS:CreateStripesThin(LFGDungeonReadyPopup)
		RSS:CreateStripesThin(LFGDungeonReadyDialog)
		RSS:CreateStripesThin(LFGDungeonReadyStatus)
		RSS:CreateStripesThin(LFGListApplicationDialog)
		RSS:CreateStripesThin(LFGListInviteDialog)
		RSS:CreateStripesThin(PVEFrame.backdrop)
		RSS:CreateStripesThin(PVPReadyDialog)
		RSS:CreateStripesThin(RaidBrowserFrame.backdrop)
	end
	
	if db.loot then
		RSS:CreateStripesThin(LootFrame)
		RSS:CreateStripesThin(MasterLooterFrame)
	end
	
	if db.mail then
		RSS:CreateStripesThin(MailFrame)
		RSS:CreateStripesThin(OpenMailFrame)
	end
	
	if db.merchant then
		RSS:CreateStripesThin(MerchantFrame)
	end
	
	if db.misc then
		RSS:CreateStripesThin(AudioOptionsFrame)
		RSS:CreateStripesThin(BNToastFrame)
		RSS:CreateStripesThin(ChatConfigFrame)
		RSS:CreateStripesThin(ChatMenu)
		RSS:CreateStripesThin(DropDownList1)
		RSS:CreateStripesThin(DropDownList2)
		RSS:CreateStripesThin(EmoteMenu)
		RSS:CreateStripesThin(GameMenuFrame)
		RSS:CreateStripesThin(InterfaceOptionsFrame)
		RSS:CreateStripesThin(LanguageMenu)
		RSS:CreateStripesThin(LFDRoleCheckPopup)
		RSS:CreateStripesThin(QueueStatusFrame)
		RSS:CreateStripesThin(ReadyCheckFrame)
		RSS:CreateStripesThin(ReadyCheckListenerFrame)
		RSS:CreateStripesThin(SideDressUpFrame)
		RSS:CreateStripesThin(SplashFrame.backdrop)
		RSS:CreateStripesThin(StackSplitFrame)
		RSS:CreateStripesThin(StaticPopup1)
		RSS:CreateStripesThin(StaticPopup2)
		RSS:CreateStripesThin(StaticPopup3)
		RSS:CreateStripesThin(StaticPopup4)
		RSS:CreateStripesThin(TicketStatusFrameButton)
		RSS:CreateStripesThin(VideoOptionsFrame)
		RSS:CreateStripesThin(VoiceMacroMenu)
		
		for i = 1, MAX_STATIC_POPUPS do
			local frame = _G["ElvUI_StaticPopup"..i]
			RSS:CreateStripesThin(frame)
		end
	end
	
	if db.nonraid then
		RSS:CreateStripesThin(RaidInfoFrame)
	end
	
	if db.petition then
		RSS:CreateStripesThin(PetitionFrame)
	end
	
	if db.petpattle then
		RSS:CreateStripesThin(FloatingBattlePetTooltip)
	end
	
	if db.quest then
		RSS:CreateStripesThin(QuestFrame.backdrop)
		RSS:CreateStripesThin(QuestLogPopupDetailFrame)
		RSS:CreateStripesThin(QuestNPCModel.backdrop)
	end
	
	if db.stable then
		RSS:CreateStripesThin(PetStableFrame)
	end
	
	if db.spellbook then
		RSS:CreateStripesThin(SpellBookFrame)
	end
	
	if db.tabard then
		RSS:CreateStripesThin(TabardFrame)
	end
	
	if db.taxi then
		RSS:CreateStripesThin(TaxiFrame.backdrop)
	end
	
	if db.trade then
		RSS:CreateStripesThin(TradeFrame)
	end

end

-- SpellBook tabs
local function styleSpellbook()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.spellbook ~= true then return end
	
	hooksecurefunc('SpellBookFrame_UpdateSkillLineTabs', function()
		for i = 1, MAX_SKILLLINE_TABS do
			local tab = _G['SpellBookSkillLineTab'..i]
			if not tab.stripesthin then
				RSS:CreateStripesThin(tab)
			end
		end
	end)
end

-- Alert Frames
local staticAlertFrames = {
	ScenarioLegionInvasionAlertFrame,
	BonusRollMoneyWonFrame,
	BonusRollLootWonFrame,
	GarrisonBuildingAlertFrame,
	GarrisonMissionAlertFrame,
	GarrisonShipMissionAlertFrame,
	GarrisonRandomMissionAlertFrame,
	WorldQuestCompleteAlertFrame,
	GarrisonFollowerAlertFrame,
	LegendaryItemAlertFrame,
}

local function styleAlertFrames()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.alertframes ~= true then return end
	
	local function StyleAchievementAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end
	hooksecurefunc(AchievementAlertSystem, "setUpFunction", StyleAchievementAlert) -- needs testing
	
	local function StyleCriteriaAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
			RSS:CreateStripesThin(frame.Icon.Texture.b)
		end
	end		
	hooksecurefunc(CriteriaAlertSystem, "setUpFunction", StyleCriteriaAlert)
	
	local function StyleDungeonCompletionAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end		
	hooksecurefunc(DungeonCompletionAlertSystem, "setUpFunction", StyleDungeonCompletionAlert)
	
	local function StyleGuildChallengeAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end		
	hooksecurefunc(GuildChallengeAlertSystem, "setUpFunction", StyleGuildChallengeAlert)
	
	local function StyleScenarioAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end		
	hooksecurefunc(ScenarioAlertSystem, "setUpFunction", StyleScenarioAlert)
	
	local function StyleGarrisonFollowerAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end		
	hooksecurefunc(GarrisonFollowerAlertSystem, "setUpFunction", StyleGarrisonFollowerAlert)
	
	local function StyleLegendaryItemAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end	
	hooksecurefunc(LegendaryItemAlertSystem, "setUpFunction", StyleLegendaryItemAlert)
	
	local function StyleLootWonAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end		
	hooksecurefunc(LootAlertSystem, "setUpFunction", StyleLootWonAlert)
	
	local function StyleLootUpgradeAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end	
	hooksecurefunc(LootUpgradeAlertSystem, "setUpFunction", StyleLootUpgradeAlert)
	
	local function StyleMoneyWonAlert(frame)
		if not frame.backdrop.stripesthin then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end
	hooksecurefunc(MoneyWonAlertSystem, "setUpFunction", StyleMoneyWonAlert)
	
	for _, frame in pairs(staticAlertFrames) do
		if frame then
			RSS:CreateStripesThin(frame.backdrop)
		end
	end
end

-- Garrison Style
local fRecruits = {}
local function styleGarrison()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.garrison ~= true then return end
	if (not _G["GarrisonMissionFrame"]) then LoadAddOn("Blizzard_GarrisonUI") end
	
	RSS:CreateStripesThin(_G["GarrisonMissionFrame"].backdrop)
	RSS:CreateStripesThin(_G["GarrisonLandingPage"].backdrop)
	RSS:CreateStripesThin(_G["GarrisonBuildingFrame"].backdrop)
	RSS:CreateStripesThin(_G["GarrisonCapacitiveDisplayFrame"].backdrop)
	RSS:CreateStripesThin(_G["GarrisonBuildingFrame"].BuildingLevelTooltip)
	RSS:CreateStripesThin(_G["GarrisonFollowerAbilityTooltip"])
	_G["GarrisonMissionMechanicTooltip"]:StripTextures()
	_G["GarrisonMissionMechanicTooltip"]:CreateBackdrop('Transparent')
	RSS:CreateStripesThin(_G["GarrisonMissionMechanicTooltip"].backdrop)
	_G["GarrisonMissionMechanicFollowerCounterTooltip"]:StripTextures()
	_G["GarrisonMissionMechanicFollowerCounterTooltip"]:CreateBackdrop('Transparent')
	RSS:CreateStripesThin(_G["GarrisonMissionMechanicFollowerCounterTooltip"].backdrop)
	RSS:CreateStripesThin(_G["FloatingGarrisonFollowerTooltip"])
	RSS:CreateStripesThin(_G["GarrisonFollowerTooltip"])
	
	-- ShipYard
	RSS:CreateStripesThin(_G["GarrisonShipyardFrame"].backdrop)
	-- Tooltips
	RSS:CreateStripesThin(_G["GarrisonShipyardMapMissionTooltip"])
	_G["GarrisonBonusAreaTooltip"]:StripTextures()
	_G["GarrisonBonusAreaTooltip"]:CreateBackdrop('Transparent')
	RSS:CreateStripesThin(_G["GarrisonBonusAreaTooltip"].backdrop)
	RSS:CreateStripesThin(_G["GarrisonMissionMechanicFollowerCounterTooltip"])
	RSS:CreateStripesThin(_G["GarrisonMissionMechanicTooltip"])
	RSS:CreateStripesThin(_G["FloatingGarrisonShipyardFollowerTooltip"])
	RSS:CreateStripesThin(_G["GarrisonShipyardFollowerTooltip"])
	
	-- Garrison Monument
	_G["GarrisonMonumentFrame"]:StripTextures()
	_G["GarrisonMonumentFrame"]:CreateBackdrop('Transparent')
	RSS:CreateStripesThin(_G["GarrisonMonumentFrame"])
	_G["GarrisonMonumentFrame"]:ClearAllPoints()
	_G["GarrisonMonumentFrame"]:Point('CENTER', E.UIParent, 'CENTER', 0, -200)
	_G["GarrisonMonumentFrame"]:Height(70)
	_G["GarrisonMonumentFrame"].RightBtn:Size(25, 25)
	_G["GarrisonMonumentFrame"].LeftBtn:Size(25, 25)
	
	-- Follower recruiting (available at the Inn)
	RSS:CreateStripesThin(_G["GarrisonRecruiterFrame"].backdrop)
	S:HandleDropDownBox(_G["GarrisonRecruiterFramePickThreatDropDown"])
	local rBtn = _G["GarrisonRecruiterFrame"].Pick.ChooseRecruits
	rBtn:ClearAllPoints()
	rBtn:Point('BOTTOM', _G["GarrisonRecruiterFrame"].backdrop, 'BOTTOM', 0, 30)
	S:HandleButton(rBtn)
	
	_G["GarrisonRecruitSelectFrame"]:StripTextures()
	_G["GarrisonRecruitSelectFrame"]:CreateBackdrop('Transparent')
	RSS:CreateStripesThin(_G["GarrisonRecruitSelectFrame"].backdrop)
	S:HandleCloseButton(_G["GarrisonRecruitSelectFrame"].CloseButton)
	S:HandleEditBox(_G["GarrisonRecruitSelectFrame"].FollowerList.SearchBox)

	_G["GarrisonRecruitSelectFrame"].FollowerList:StripTextures()
	S:HandleScrollBar(_G["GarrisonRecruitSelectFrameListScrollFrameScrollBar"])
	_G["GarrisonRecruitSelectFrame"].FollowerSelection:StripTextures()

	_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit1:CreateBackdrop()
	_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit1:ClearAllPoints()
	_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit1:Point('LEFT', _G["GarrisonRecruitSelectFrame"].FollowerSelection, 'LEFT', 6, 0)
	_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit2:CreateBackdrop()
	_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit2:ClearAllPoints()
	_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit2:Point('LEFT', _G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit1, 'RIGHT', 6, 0)
	_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit3:CreateBackdrop()
	_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit3:ClearAllPoints()
	_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit3:Point('LEFT', _G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit2, 'RIGHT', 6, 0)

	for i = 1, 3 do
		fRecruits[i] = CreateFrame('Frame', nil, E.UIParent)
		fRecruits[i]:SetTemplate('Default', true)
		fRecruits[i]:Size(190, 60)
		if i == 1 then
			fRecruits[i]:SetParent(_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit1)
			fRecruits[i]:Point('TOP', _G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit1.backdrop, 'TOP')
			fRecruits[i]:SetFrameLevel(_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit1:GetFrameLevel())
			_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit1.Class:Size(60, 58)
		elseif i == 2 then
			fRecruits[i]:SetParent(_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit2)
			fRecruits[i]:Point('TOP', _G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit2.backdrop, 'TOP')
			fRecruits[i]:SetFrameLevel(_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit2:GetFrameLevel())
			_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit2.Class:Size(60, 58)
		elseif i == 3 then
			fRecruits[i]:SetParent(_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit3)
			fRecruits[i]:Point('TOP', _G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit3.backdrop, 'TOP')
			fRecruits[i]:SetFrameLevel(_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit3:GetFrameLevel())
			_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit3.Class:Size(60, 58)
		end
	end
	S:HandleButton(_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit1.HireRecruits)
	S:HandleButton(_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit2.HireRecruits)
	S:HandleButton(_G["GarrisonRecruitSelectFrame"].FollowerSelection.Recruit3.HireRecruits)
end

-- Objective Tracker Button
local function MinimizeButton_OnClick(self)
	local text = self.Text
	local symbol = text:GetText()
	
	if (symbol and symbol == '-') then
		text:SetText('+')
	else
		text:SetText('-')
	end
end

local function SkinObjeciveTracker()
	local button = _G["ObjectiveTrackerFrame"].HeaderMenu.MinimizeButton
	S:HandleButton(button)
	button:Size(16, 12)
	button.Text = button:CreateFontString(nil, 'OVERLAY')
	button.Text:FontTemplate(E['media'].buiVisitor, 10)
	button.Text:Point('CENTER', button, 'CENTER', 0, 1)
	button.Text:SetJustifyH('CENTER')
	button.Text:SetText('-')
	button:HookScript('OnClick', MinimizeButton_OnClick)
	
	-- Remove textures from Objective tracker
	local otFrames = {_G["ObjectiveTrackerBlocksFrame"].QuestHeader, _G["ObjectiveTrackerBlocksFrame"].AchievementHeader, _G["ObjectiveTrackerBlocksFrame"].ScenarioHeader, _G["BONUS_OBJECTIVE_TRACKER_MODULE"].Header}
	for _, frame in pairs(otFrames) do
		if frame then
			frame:StripTextures()
		end
	end
end

function RSS:RayStyleSkins()

	-- Garrison Style
	styleGarrison()

	-- Objective Tracker Button
	SkinObjeciveTracker()
	
	-- Blizzard Styles
	styleFreeBlizzardFrames()
	
	-- SpellBook tabs
	styleSpellbook()
	
	-- Alert Frames
	styleAlertFrames()

	-- Map styling fix
	local function FixMapStyle()
		if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.worldmap ~= true then return end
		if not _G["WorldMapFrame"].BorderFrame.backdrop.stripesthin then
			RSS:CreateStripesThin(_G["WorldMapFrame"].BorderFrame.backdrop)
		end
		
		if not _G["WorldMapTooltip"].stripesthin then
			RSS:CreateStripesThin(_G["WorldMapTooltip"])
		end

		_G["QuestMapFrame"].QuestsFrame.StoryTooltip:SetTemplate('Transparent')
		if not _G["QuestMapFrame"].QuestsFrame.StoryTooltip.stripesthin then
			RSS:CreateStripesThin(_G["QuestMapFrame"].QuestsFrame.StoryTooltip)
		end
	end
	
	_G["WorldMapFrame"]:HookScript('OnShow', FixMapStyle)
	hooksecurefunc('WorldMap_ToggleSizeUp', FixMapStyle)

	-- AddOn Styles
	if IsAddOnLoaded('ElvUI_LocLite') then
		local framestoskin = {_G["LocationLitePanel"], _G["XCoordsLite"], _G["YCoordsLite"]}
		for _, frame in pairs(framestoskin) do
			if frame then
				RSS:CreateStripesThin(frame)
			end
		end
	end
	
	if IsAddOnLoaded('ElvUI_LocPlus') then
		local framestoskin = {_G["LeftCoordDtPanel"], _G["RightCoordDtPanel"], _G["LocationPlusPanel"], _G["XCoordsPanel"], _G["YCoordsPanel"]}
		for _, frame in pairs(framestoskin) do
			if frame then
				RSS:CreateStripesThin(frame)
			end
		end
	end
	
	if IsAddOnLoaded('ElvUI_SLE') then
		local sleFrames = {_G["SLE_BG_1"], _G["SLE_BG_2"], _G["SLE_BG_3"], _G["SLE_BG_4"], _G["SLE_DataPanel_1"], _G["SLE_DataPanel_2"], _G["SLE_DataPanel_3"], _G["SLE_DataPanel_4"], _G["SLE_DataPanel_5"], _G["SLE_DataPanel_6"], _G["SLE_DataPanel_7"], _G["SLE_DataPanel_8"], _G["RaidMarkerBar"].backdrop, _G["SLE_SquareMinimapButtonBar"], _G["SLE_LocationPanel"], _G["SLE_LocationPanel_X"], _G["SLE_LocationPanel_Y"], _G["SLE_LocationPanel_RightClickMenu1"], _G["SLE_LocationPanel_RightClickMenu2"]}
		for _, frame in pairs(sleFrames) do
			if frame then
				RSS:CreateStripesThin(frame)
			end
		end
	end
	
	if IsAddOnLoaded('SquareMinimapButtons') then
		local smbFrame = _G["SquareMinimapButtonBar"]
		if smbFrame then
			RSS:CreateStripesThin(smbFrame)
		end
	end
	
	if IsAddOnLoaded('ElvUI_Enhanced') then
		if _G["MinimapButtonBar"] then
			RSS:CreateStripesThin(_G["MinimapButtonBar"].backdrop)
		end
		
		if _G["RaidMarkerBar"].backdrop then
			RSS:CreateStripesThin(_G["RaidMarkerBar"].backdrop)
		end
	end
	
	if IsAddOnLoaded('ElvUI_DTBars2') then
		for panelname, data in pairs(E.global.dtbars) do
			if panelname then
				RSS:CreateStripesThin(_G[panelname])
			end
		end
	end
end

function RSS:Initialize()
	self:RegisterEvent('ADDON_LOADED', 'BlizzardUI_LOD_Skins')
	self:RegisterEvent('PLAYER_ENTERING_WORLD', 'RayStyleSkins')
end

E:RegisterModule(RSS:GetName())