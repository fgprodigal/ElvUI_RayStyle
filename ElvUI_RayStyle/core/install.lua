--[[--------------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains the installation script.
--	It is a modified version of the installation script found in ElvUI.
--	Only necessary installation choices are kept:
--		- Cvars
--		- Chat
--		- Layout: Tank/Healer/Caster DPS/Physical DPS
--
--	Everything else will need to be configured manually if the user
--	is not satisfied with the default settings set in this edit.
--------------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local RS = E:GetModule("RayStyle")

local format = string.format

local CURRENT_PAGE = 0
local MAX_PAGE = 7

local function SetupChat()
	RayStyleInstallStepComplete.message = L["Chat Set"]
	RayStyleInstallStepComplete:Show()
	local whisperFound
	for i = 1, #CHAT_FRAMES do
		local chatName, _, _, _, _, _, shown = FCF_GetChatWindowInfo(_G["ChatFrame"..i]:GetID())
		if chatName == WHISPER then
			if shown then
				whisperFound = true
			elseif not shown and not whisperFound  then
				_G["ChatFrame"..i]:Show()
				whisperFound = true
			end
		end
	end
	if not whisperFound then
		FCF_OpenNewWindow(WHISPER)
	end
	for i = 1, #CHAT_FRAMES do
		local frame = _G["ChatFrame"..i]
		FCF_SetChatWindowFontSize(nil, frame, 15)
		FCF_SetWindowAlpha(frame , 0)
		local chatName = FCF_GetChatWindowInfo(frame:GetID())
		if chatName == WHISPER then
			ChatFrame_RemoveAllMessageGroups(frame)
			ChatFrame_AddMessageGroup(frame, "WHISPER")
			ChatFrame_AddMessageGroup(frame, "BN_WHISPER")
		end
	end
    ChatFrame1:SetFrameLevel(8)
    FCF_SavePositionAndDimensions(ChatFrame1)
	FCF_SetLocked(ChatFrame1, 1)
	ChangeChatColor("CHANNEL1", 195/255, 230/255, 232/255)
	ChangeChatColor("CHANNEL2", 232/255, 158/255, 121/255)
	ChangeChatColor("CHANNEL3", 232/255, 228/255, 121/255)
	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL6")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL7")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL8")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL9")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL10")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL11")

	FCFDock_SelectWindow(GENERAL_CHAT_DOCK, ChatFrame1)
	
	if E.Chat then
		E.Chat:PositionChat(true)
		if E.db["RightChatPanelFaded"] then
			RightChatToggleButton:Click()
		end
		
		if E.db["LeftChatPanelFaded"] then
			LeftChatToggleButton:Click()
		end		
	end
end

local function SetupCVars()
	-- SetCVar("scriptErrors", 1)
	-- SetCVar("buffDurations", 1)
	-- SetCVar("consolidateBuffs", 0)
	-- SetCVar("lootUnderMouse", 1)
	-- SetCVar("autoSelfCast", 1)
	-- SetCVar("nameplateShowFriends", 0)
	-- SetCVar("nameplateShowFriendlyPets", 0)
	-- SetCVar("nameplateShowFriendlyGuardians", 0)
	-- SetCVar("nameplateShowFriendlyTotems", 0)
	-- SetCVar("nameplateShowEnemies", 1)
	-- SetCVar("nameplateShowEnemyPets", 1)
	-- SetCVar("cameraDistanceMax", 50)
	-- SetCVar("cameraDistanceMaxFactor", 4)
	-- SetCVar("autoDismountFlying", 1)
	-- SetCVar("autoQuestWatch", 1)
	-- SetCVar("autoQuestProgress", 1)
	-- SetCVar("guildMemberNotify", 0)
	-- SetCVar("removeChatDelay", 1)
	-- SetCVar("showVKeyCastbar", 1)
	-- SetCVar("colorblindMode", 0)
	-- SetCVar("autoLootDefault", 1)
	-- SetCVar("bloatthreat", 0)
	-- SetCVar("bloattest", 0)
	-- SetCVar("bloatnameplates", 0)
	-- SetCVar("showTimestamps", "%H:%M:%S ")
	-- SetCVar("deselectOnClick", 1)
	-- SetCVar("UnitNameFriendlyGuardianName", 1)
	-- SetCVar("UnitNameOwn", 1)
	-- SetCVar("UnitNameGuildTitle", 0)
	-- SetCVar("ActionButtonUseKeyDown", 0)
	-- SetCVar("interactOnLeftClick", 0)
		
	RayStyleInstallStepComplete.message = L["CVars Set"]
	RayStyleInstallStepComplete:Show()
end

function RS:SetupLayout(layout, noDataReset)
	local classColor = E.myclass == "PRIEST" and E.PriestColors or RAID_CLASS_COLORS[E.myclass]

	--Set up various settings shared across all layouts
	if not noDataReset then
		--general
		E.db.general.bordercolor = { r = 0,g = 0,b = 0 }
		E.db.general.backdropcolor = { r = 0.1,g = 0.1,b = 0.1 }
		E.db.general.backdropfadecolor = { r = .04,g = .04,b = .04, a = 0.7 }
		E.db.general.bottomPanel = false
		
		--chat
		E.db.chat.font = "RayStyle Font"
		E.db.chat.panelTabBackdrop = false
		E.db.chat.panelTabTransparency = false
		E.db.chat.editBoxPosition = "ABOVE_CHAT"
		E.db.chat.tabFont = "RayStyle Font"
		E.db.chat.tabFontSize = 12
		
		--nameplate
		E.db.nameplate.font = "RayStyle Font"
		E.db.nameplate.fontSize = 10
		E.db.nameplate.fontOutline = "OUTLINE"
		E.db.nameplate.reactions.tapped = {r = 0.6, g = 0.6, b = 0.6}
		E.db.nameplate.reactions.friendlyNPC = {r = 0.31, g = 0.45, b = 0.63}
		E.db.nameplate.reactions.friendlyPlayer = {r = 0.2,  g = 1, b = 0.2 }
		E.db.nameplate.reactions.neutral = { r = 1, g = 1, b = 0.2 }
		E.db.nameplate.reactions.enemy = { r = 1, g = 0.2, b = 0.2 }
		E.db.nameplate.buffs.font = "RayStyle Font"
		E.db.nameplate.buffs.fontSize = 10
		E.db.nameplate.buffs.fontOutline = "OUTLINE"
		E.db.nameplate.debuffs.font = "RayStyle Font"
		E.db.nameplate.debuffs.fontSize = 10
		E.db.nameplate.debuffs.fontOutline = "OUTLINE"
		E.db.nameplate.threat.goodColor = { r = 0.2,  g = 1, b = 0.2 }
		E.db.nameplate.threat.badColor = {r = 1, g = 0.2, b = 0.2}

		--unitframe
		E.db.unitframe.statusbar = "RayStyle Normal"
		E.db.unitframe.smoothbars = true
		E.db.unitframe.font = "RayStyle Font"
		E.db.unitframe.fontSize = 12
		E.db.unitframe.fontOutline = "OUTLINE"
		E.db.unitframe.colors.powerclass = true
		E.db.unitframe.colors.castClassColor = true
		E.db.unitframe.colors.transparentHealth = false
		E.db.unitframe.colors.health_backdrop = { r = .1,g = .1,b = .1 }
		E.db.unitframe.colors.castColor = { r = 0.2,g = 1,b = 0.2 }
		E.db.unitframe.colors.castNoInterrupt = { r = 1, g = 0.2, b = 0.2 }
		E.db.unitframe.colors.health = { r = .12,g = .12,b = .12 }
		E.db.unitframe.units.player.width = 220
		E.db.unitframe.units.player.height = 32
		E.db.unitframe.units.player.portrait.enable = true
		E.db.unitframe.units.player.portrait.overlay = true
		E.db.unitframe.units.player.portrait.camDistanceScale = 1
		E.db.unitframe.units.player.castbar.width = 350
		E.db.unitframe.units.player.castbar.height = 7
		E.db.unitframe.units.player.power.height = 3
		E.db.unitframe.units.player.aurabar.enable = false
		E.db.unitframe.units.player.buffs.enable = false
		E.db.unitframe.units.player.debuffs.anchorPoint = "TOPRIGHT"
		E.db.unitframe.units.player.debuffs.perrow = 10
		E.db.unitframe.units.player.debuffs.attachTo = "FRAME"
		E.db.unitframe.units.target.width = 220
		E.db.unitframe.units.target.height = 32
		E.db.unitframe.units.target.portrait.enable = true
		E.db.unitframe.units.target.portrait.overlay = true
		E.db.unitframe.units.target.portrait.camDistanceScale = 1
		E.db.unitframe.units.target.castbar.width = 220
		E.db.unitframe.units.target.power.height = 3
		E.db.unitframe.units.target.aurabar.enable = false
		E.db.unitframe.units.target.debuffs.anchorPoint = "TOPLEFT"
		E.db.unitframe.units.target.debuffs.perrow = 10
		E.db.unitframe.units.target.debuffs.attachTo = "FRAME"
		E.db.unitframe.units.target.buffs.anchorPoint = "BOTTOMLEFT"
		E.db.unitframe.units.target.buffs.perrow = 10
		E.db.unitframe.units.target.buffs.attachTo = "FRAME"
		E.db.unitframe.units.targettarget.height = 32
		E.db.unitframe.units.targettarget.power.height = 3
		E.db.unitframe.units.targettarget.debuffs.anchorPoint = "TOPLEFT"
		E.db.unitframe.units.targettarget.debuffs.attachTo = "FRAME"

		--actionbar
		E.db.actionbar.font = "RayStyle Font"
		E.db.actionbar.fontSize = 12
		E.db.actionbar.fontOutline = "OUTLINE"
		E.db.actionbar.macrotext = true
		E.db.actionbar.bar1.enabled = true
		E.db.actionbar.bar1.buttonsize = 28
		E.db.actionbar.bar1.buttons = 12
		E.db.actionbar.bar2.enabled = true
		E.db.actionbar.bar2.buttonsize = 28
		E.db.actionbar.bar2.buttons = 12
		E.db.actionbar.bar3.enabled = true
		E.db.actionbar.bar3.buttonsize = 28
		E.db.actionbar.bar3.buttons = 12
		E.db.actionbar.bar3.point = "TOPLEFT"
		E.db.actionbar.bar4.enabled = true
		E.db.actionbar.bar4.mouseover = true
		E.db.actionbar.bar4.buttonsize = 28
		E.db.actionbar.bar4.buttons = 12
		E.db.actionbar.bar4.point = "TOPRIGHT"
		E.db.actionbar.bar4.buttonsPerRow = 1
		E.db.actionbar.bar4.backdrop = false
		E.db.actionbar.bar5.enabled = true
		E.db.actionbar.bar5.mouseover = false
		E.db.actionbar.bar5.buttonsize = 28
		E.db.actionbar.bar5.buttons = 12
		E.db.actionbar.bar5.point = "TOPRIGHT"
		E.db.actionbar.bar5.buttonsPerRow = 1

		--auras
		E.db.auras.font = "RayStyle Font"
		E.db.auras.fontSize = 12
		E.db.auras.fontOutline = "OUTLINE"
		E.db.auras.consolidatedBuffs.font = "RayStyle Font"
		E.db.auras.consolidatedBuffs.fontSize = 12
		E.db.auras.consolidatedBuffs.fontOutline = "OUTLINE"

		--datatexts
		E.db.datatexts.font = "RayStyle Font"
		E.db.datatexts.fontSize = 10
		E.db.datatexts.fontOutline = "NONE"
		E.db.datatexts.time24 = true
		E.db.datatexts.panels.LeftChatDataPanel.left = "System"
		E.db.datatexts.panels.LeftChatDataPanel.middle = "Durability"
		E.db.datatexts.panels.LeftChatDataPanel.right = "Talent/Loot Specialization"
		E.db.datatexts.panels.RightChatDataPanel.left = "Call to Arms"
		E.db.datatexts.panels.RightChatDataPanel.middle = "Bags"
		E.db.datatexts.panels.LeftMiniPanel = "Time"
		E.db.datatexts.panels.RightMiniPanel = "Combat/Arena Time"

		RS:SetMoverPosition("ElvUF_PlayerMover", "BOTTOMRIGHT", E.UIParent, "BOTTOM", -80, 390)
		RS:SetMoverPosition("ElvUF_PlayerCastbarMover", "BOTTOM", E.UIParent, "BOTTOM", 0, 305)
		RS:SetMoverPosition("ElvUF_TargetMover", "BOTTOMLEFT", E.UIParent, "BOTTOM", 80, 390)
		RS:SetMoverPosition("ElvUF_TargetCastbarMover", "TOP", ElvUF_Target, "BOTTOM", 0, -22)
		RS:SetMoverPosition("ElvUF_TargetTargetMover", "LEFT", ElvUF_Target, "RIGHT", 10, 0)
		RS:SetMoverPosition("ElvUF_FocusMover", "BOTTOMRIGHT", ElvUF_Player, "TOPLEFT", -20, 20)
		RS:SetMoverPosition("ElvAB_1", "BOTTOM", E.UIParent, "BOTTOM", -90, 235)
		RS:SetMoverPosition("ElvAB_2", "BOTTOM", ElvAB_1, "TOP", 0, -2)
		RS:SetMoverPosition("ElvAB_3", "BOTTOMLEFT", ElvAB_1, "BOTTOMRIGHT", 0, 0)
		RS:SetMoverPosition("ElvAB_4", "RIGHT", E.UIParent, "RIGHT", -35, 0)
		RS:SetMoverPosition("ElvAB_5", "RIGHT", E.UIParent, "RIGHT", -5, 0)
		RS:SetMoverPosition("BossButton", "CENTER", E.UIParent, "BOTTOM", 500, 510)
	end
	
	--Datatexts
	if not noDataReset then
		E.db.RS.datatexts.panels.Bottom_Datatext_Panel.middle = "Spell/Heal Power"
		if layout == "tank" then
			E.db.RS.datatexts.panels.Bottom_Datatext_Panel.middle = "Attack Power"
		elseif layout == "dpsMelee" then
			E.db.RS.datatexts.panels.Bottom_Datatext_Panel.middle = "Attack Power"
		end

		if RayStyleInstallStepComplete then
			RayStyleInstallStepComplete.message = L["Layout Set"]
			RayStyleInstallStepComplete:Show()
		end
	end

	E:UpdateAll(true)
	local DT = E:GetModule("DataTexts")
	DT:LoadDataTexts()
end

function RS:SetupAddon(addon)
	if addon == "DBM" then
		if IsAddOnLoaded("DBM-Profiles") then
			RS:Print(L["A profile for 'DBM-Profiles' has been created."])
			RayStyleInstallStepComplete.message = L["DBM-Profiles Profile Created"]
			RayStyleInstallStepComplete:Show()
			DeadlyBossModsDB["namespaces"]["DeadlyBarTimers"]["profiles"]["RayStyle"] = {
				["DBM"] = {
					["FillUpBars"] = false,
					["IconLeft"] = true,
					["IconRight"] = false,
					["FontSize"] = 8,
					["Height"] = 20,
					["EnlargeBarsTime"] = 15,
					["Style"] = "DBM",
					["ExpandUpwards"] = true,
					["Texture"] = "Interface\\AddOns\\ElvUI\\media\\textures\\normTex2.tga",
					["Width"] = 361,
					["Scale"] = 1,
					["TimerPoint"] = "BOTTOMLEFT",
					["TimerX"] = 208,
					["TimerY"] = 182,
					["BarXOffset"] = 0,
					["BarYOffset"] = 5,
					["HugeWidth"] = 230,
					["HugeScale"] = 1,
					["HugeTimerPoint"] = "RIGHT",
					["HugeTimerX"] = -425,
					["HugeTimerY"] = -50,
					["HugeBarXOffset"] = 0,
					["HugeBarYOffset"] = 0,
					["StartColorR"] = 0,
					["StartColorG"] = 0.7,
					["StartColorB"] = 1,
					["EndColorR"] = 0,
					["EndColorG"] = 0.7,
					["EndColorB"] = 1,
				},
			}
			DeadlyBossModsDB["profiles"]["RayStyle"] = {
				["SpecialWarningFontSize"] = 16,
				["SpecialWarningFont"] = "Interface\\AddOns\\ElvUI_RayStyle\\media\\fonts\\pf_tempesta_seven_extended_bold.ttf",
				["WarningIconLeft"] = false,
				["WarningIconRight"] = false,
				["WarningIconChat"] = false,
				["DontShowPT"] = false,
				["DontShowPTNoID"] = true,
				["PTCountThreshold"] = 11,
				["EnableModels"] = false,
				["ModelSoundValue"] = "",
				["InfoFramePoint"] = "RIGHT",
				["InfoFrameX"] = -123,
				["InfoFrameY"] = -120,
				["InfoFrameLocked"] = true,
				["RangeFramePoint"] = "BOTTOMRIGHT",
				["RangeFrameX"] = -237,
				["RangeFrameY"] = 207,
				["RangeFrameRadarPoint"] = "BOTTOMRIGHT",
				["RangeFrameRadarX"] = -261,
				["RangeFrameRadarY"] = 225,
				["RangeFrameLocked"] = true,
				["HPFramePoint"] = "BOTTOMRIGHT",
				["HPFrameX"] = -221,
				["HPFrameY"] = 185,
				["HealthFrameWidth"] = 275,
				["HealthFrameGrowUp"] = true,
				["DontShowHealthFrame"] = true,
				["MovieFilter"] = "AfterFirst",
				["SpamBlockBossWhispers"] = true,
				["ShowFlashFrame"] = false,
				["WarningColors"] = {
					{
						["r"] = 0,
						["g"] = 0.7,
						["b"] = 1,
					}, --[1]
					{
						["r"] = 0,
						["g"] = 0.7,
						["b"] = 1,
					}, --[2]
					{
						["r"] = 0,
						["g"] = 0.7,
						["b"] = 1,
					}, --[3]
					{
						["r"] = 0,
						["g"] = 0.7,
						["b"] = 1,
					}, --[4]
				},
				["SpecialWarningFontCol"] = {
					0, --[1]
					0.7, --[2]
					1, --[3]
				},
				["SpecialWarningFlashCol1"] = {
					0, --[1]
					0.7, --[2]
					1, --[3]
				},
				["SpecialWarningFlashCol2"] = {
					0, --[1]
					0.7, --[2]
					1, --[3]
				},
				["SpecialWarningFlashCol3"] = {
					0, --[1]
					0.7, --[2]
					1, --[3]
				},
			}
		else
			RS:Print(L["The AddOn 'DBM-Profiles' is not enabled. Profile not created."])
			RayStyleInstallStepComplete.message = L["DBM-Profiles is not enabled, aborting."]
			RayStyleInstallStepComplete:Show()
		end
	elseif addon == "Skada" then
		if IsAddOnLoaded("Skada") then
			RS:Print(L["A profile for 'Skada' has been created."])
			RayStyleInstallStepComplete.message = L["Skada Profile Created"]
			RayStyleInstallStepComplete:Show()
			SkadaDB["profiles"]["RayStyle"] = {
				["feed"] = "Damage: Raid DPS",
				["icon"] = {
					["hide"] = true,
				},
				["columns"] = {
					["Threat_Threat"] = true,
					["Damage_Percent"] = true,
					["Threat_TPS"] = false,
					["Threat_Percent"] = false,
				},
				["tooltiprows"] = 5,
				["showranks"] = false,
				["hidedisables"] = false,
				["tooltippos"] = "topleft",
				["modulesBlocked"] = {
					["Debuffs"] = true,
					["CC"] = true,
					["Interrupts"] = false,
					["TotalHealing"] = false,
					["Power"] = true,
					["Dispels"] = false,
				},
				["windows"] = {
					{
						["titleset"] = false,
						["barmax"] = 8,
						["classicons"] = false,
						["barslocked"] = true,
						["background"] = {
							["borderthickness"] = 3,
							["height"] = 144,
						},
						["barfont"] = "2002",
						["name"] = "Threat",
						["classcolortext"] = true,
						["barcolor"] = {
							["a"] = 0,
							["b"] = 0.1568627450980392,
							["g"] = 0.1568627450980392,
							["r"] = 0.1568627450980392,
						},
						["barfontsize"] = 10,
						["mode"] = "Threat",
						["spark"] = false,
						["buttons"] = {
							["report"] = false,
							["menu"] = false,
							["mode"] = false,
							["segment"] = false,
							["reset"] = false,
						},
						["barwidth"] = 124.0000305175781,
						["barspacing"] = 1,
						["barbgcolor"] = {
							["a"] = 0,
							["b"] = 0.1647058823529412,
							["g"] = 0.1647058823529412,
							["r"] = 0.1647058823529412,
						},
						["enabletitle"] = false,
						["classcolorbars"] = false,
						["baraltcolor"] = {
							["r"] = 0.8431372549019608,
							["g"] = 0.8431372549019608,
							["b"] = 0.8431372549019608,
						},
						["bartexture"] = "Armory",
						["enablebackground"] = true,
						["title"] = {
							["menubutton"] = false,
							["font"] = "PF T 7 Bold",
							["fontsize"] = 8,
							["fontflags"] = "OUTLINEMONOCHROME",
							["texture"] = "Armory",
						},
					}, -- [1]
					{
						["classcolortext"] = true,
						["titleset"] = false,
						["barheight"] = 15,
						["barfontsize"] = 10,
						["scale"] = 1,
						["barcolor"] = {
							["a"] = 0,
							["b"] = 0.1647058823529412,
							["g"] = 0.1647058823529412,
							["r"] = 0.1647058823529412,
						},
						["mode"] = "Damage",
						["returnaftercombat"] = false,
						["clickthrough"] = false,
						["classicons"] = false,
						["barslocked"] = true,
						["snapto"] = true,
						["barorientation"] = 1,
						["enabletitle"] = false,
						["wipemode"] = "",
						["name"] = "Skada",
						["background"] = {
							["borderthickness"] = 0,
							["color"] = {
								["a"] = 0.2000000476837158,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0.5019607843137255,
							},
							["height"] = 144,
							["bordertexture"] = "None",
							["margin"] = 0,
							["texture"] = "Solid",
						},
						["bartexture"] = "Armory",
						["spark"] = false,
						["set"] = "current",
						["barwidth"] = 246.0000305175781,
						["barspacing"] = 1,
						["hidden"] = false,
						["reversegrowth"] = false,
						["buttons"] = {
							["segment"] = false,
							["menu"] = false,
							["mode"] = false,
							["report"] = true,
							["reset"] = false,
						},
						["barfont"] = "2002",
						["title"] = {
							["color"] = {
								["a"] = 0.800000011920929,
								["r"] = 0.1019607843137255,
								["g"] = 0.1019607843137255,
								["b"] = 0.3019607843137255,
							},
							["bordertexture"] = "None",
							["font"] = "PF T 7 Ext. Bold",
							["borderthickness"] = 2,
							["fontsize"] = 8,
							["fontflags"] = "",
							["height"] = 10,
							["margin"] = 0,
							["texture"] = "Armory",
						},
						["classcolorbars"] = false,
						["display"] = "bar",
						["modeincombat"] = "",
						["barfontflags"] = "",
						["barbgcolor"] = {
							["a"] = 0,
							["b"] = 0.1647058823529412,
							["g"] = 0.1647058823529412,
							["r"] = 0.1647058823529412,
						},
					}, -- [2]
				},
			}
		else
			RS:Print(L["The AddOn 'Skada' is not enabled. Profile not created."])
			RayStyleInstallStepComplete.message = L["Skada is not enabled, aborting."]
			RayStyleInstallStepComplete:Show()
		end
	end
end

function RS:SetupAddOnSkins(addon)
	if IsAddOnLoaded("AddOnSkins") then
		if addon == "Skada" then
			RS:Print(L["Skada settings for AddOnSkins have been set."])
			RayStyleInstallStepComplete.message = L["Skada settings for AddOnSkins have been set."]
			RayStyleInstallStepComplete:Show()
    		E.private["addonskins"]["EmbedSystem"] = true
			E.private["addonskins"]["TransparentEmbed"] = true
			E.private["addonskins"]["EmbedMain"] = "Skada"
		elseif addon == "DBM" then
			RS:Print(L["DBM settings for AddOnSkins have been set."])
			RayStyleInstallStepComplete.message = L["DBM settings for AddOnSkins have been set."]
			RayStyleInstallStepComplete:Show()
			E.private["addonskins"]["DBMFont"] = "RayStyle Font"
			E.private["addonskins"]["DBMFontSize"] = 10
			E.private["addonskins"]["DBMFontFlag"] = "OUTLINE"
		end
	else
		RS:Print(L["The AddOn 'AddOnSkins' is not enabled. No settings have been changed."])
		RayStyleInstallStepComplete.message = L["AddOnSkins is not enabled, aborting."]
		RayStyleInstallStepComplete:Show()
	end
end

local function InstallComplete()
	E.db.RS.install_version = RS.version
	
	if GetCVarBool("Sound_EnableMusic") then
		StopMusic()
	end
	
	ReloadUI()
end

local function ResetAll()
	RayStyleInstallNextButton:Disable()
	RayStyleInstallPrevButton:Disable()
	RayStyleInstallOption1Button:Hide()
	RayStyleInstallOption1Button:SetScript("OnClick", nil)
	RayStyleInstallOption1Button:SetText("")
	RayStyleInstallOption2Button:Hide()
	RayStyleInstallOption2Button:SetScript("OnClick", nil)
	RayStyleInstallOption2Button:SetText("")
	RayStyleInstallOption3Button:Hide()
	RayStyleInstallOption3Button:SetScript("OnClick", nil)
	RayStyleInstallOption3Button:SetText("")	
	RayStyleInstallOption4Button:Hide()
	RayStyleInstallOption4Button:SetScript("OnClick", nil)
	RayStyleInstallOption4Button:SetText("")
	RayStyleInstallFrame.SubTitle:SetText("")
	RayStyleInstallFrame.Desc1:SetText("")
	RayStyleInstallFrame.Desc2:SetText("")
	RayStyleInstallFrame.Desc3:SetText("")
end

local function SetPage(PageNum)
	CURRENT_PAGE = PageNum
	ResetAll()
	RayStyleInstallStatus:SetValue(PageNum)
	
	local f = RayStyleInstallFrame
	
	if PageNum == MAX_PAGE then
		RayStyleInstallNextButton:Disable()
	else
		RayStyleInstallNextButton:Enable()
	end
	
	if PageNum == 1 then
		RayStyleInstallPrevButton:Disable()
	else
		RayStyleInstallPrevButton:Enable()
	end

	if PageNum == 1 then
		f.SubTitle:SetText(format(L["Welcome to %s version %s, \nfor ElvUI version %s and above."], RS.title, RS:ColorStr(RS.version), RS:ColorStr(RS.versionMinE)))
		f.Desc1:SetText(L["This installation process will guide you through a few steps and apply settings to your current ElvUI profile.\nIf you want to be able to go back to your original settings, create a new ElvUI profile (/ec -> Profiles) before going through this installation process."])
		f.Desc2:SetText(format(L["Options provided by this edit can be found in the %s category of the ElvUI Config (/ec)."], RS.title))
		f.Desc3:SetText(L["Please press the continue button if you wish to go through the installation process, otherwise click the 'Skip Process' button."])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", InstallComplete)
		RayStyleInstallOption1Button:SetText(L["Skip Process"])
	elseif PageNum == 2 then
		f.SubTitle:SetText(L["CVars"])
		f.Desc1:SetText(format(L["This step changes a few World of Warcraft default options. These options are tailored to the needs of the author of %s and are not necessary for this edit to function."], RS.title))
		f.Desc2:SetText(L["Please click the button below to setup your CVars."])
		f.Desc3:SetText(L["Importance: |cffFF0000Low|r"])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", SetupCVars)
		RayStyleInstallOption1Button:SetText(L["Setup CVars"])
	elseif PageNum == 3 then
		f.SubTitle:SetText(L["Chat"])
		f.Desc1:SetText(format(L["This step changes your chat windows and positions them all in the left chat panel. These changes are tailored to the needs of the author of %s and are not necessary for this edit to function."], RS.title))
		f.Desc2:SetText(L["Please click the button below to setup your chat windows."])
		f.Desc3:SetText(L["Importance: |cffFF0000Low|r"])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", SetupChat)
		RayStyleInstallOption1Button:SetText(L["Setup Chat"])					
	elseif PageNum == 4 then
		f.SubTitle:SetText(L["Layout"])
		f.Desc1:SetText(format(L["This step allows you to apply different settings and positions of elements based on the role of your character. This step will change various settings for all ElvUI modules. You need to complete this step if you want your UI to look similar to previews of %s."], RS.title))
		f.Desc2:SetText(L["Please click any one button below to apply the layout of your choosing."])
		f.Desc3:SetText(L["Importance: |cff07D400High|r"])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", function() RS:SetupLayout("tank") end)
		RayStyleInstallOption1Button:SetText(L["Tank"])
		RayStyleInstallOption2Button:Show()
		RayStyleInstallOption2Button:SetScript("OnClick", function() RS:SetupLayout("healer") end)
		RayStyleInstallOption2Button:SetText(L["Healer"])
		RayStyleInstallOption3Button:Show()
		RayStyleInstallOption3Button:SetScript("OnClick", function() RS:SetupLayout("dpsMelee") end)
		RayStyleInstallOption3Button:SetText(L["Physical DPS"])
		RayStyleInstallOption4Button:Show()
		RayStyleInstallOption4Button:SetScript("OnClick", function() RS:SetupLayout("dpsCaster") end)
		RayStyleInstallOption4Button:SetText(L["Caster DPS"])
	elseif PageNum == 5 then
		f.SubTitle:SetText(L["AddOns"])
		f.Desc1:SetFormattedText(L["This step allows you to apply pre-configured settings to various AddOns in order to make their appearance match %s."], RS.title)
		f.Desc2:SetFormattedText(L["Please click any button below to apply the pre-configured settings for that particular AddOn. A new profile named %s will be created for that particular addon, which you will have to select manually."], RS.title)
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", function() RS:SetupAddon("Skada") end)
		RayStyleInstallOption1Button:SetText("Skada")
		RayStyleInstallOption2Button:Show()
		RayStyleInstallOption2Button:SetScript("OnClick", function() RS:SetupAddon("DBM") end)
		RayStyleInstallOption2Button:SetText("Deadly Boss Mods")
		RayStyleInstallOption1Button:SetWidth(140)
		RayStyleInstallOption2Button:SetWidth(140)
	elseif PageNum == 6 then
		f.SubTitle:SetText(L["AddOnSkins Configuration"])
		f.Desc1:SetFormattedText(L["This step allows you to apply pre-configured settings to AddOnSkins in order to make certain AddOns match %s."], RS.title)
		f.Desc2:SetText(L["Please click any button below to apply the pre-configured settings for that particular AddOn to the AddOnSkins settings."])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", function() RS:SetupAddOnSkins("Skada") end)
		RayStyleInstallOption1Button:SetText("Skada")
		RayStyleInstallOption2Button:Show()
		RayStyleInstallOption2Button:SetScript("OnClick", function() RS:SetupAddOnSkins("DBM") end)
		RayStyleInstallOption2Button:SetText("Deadly Boss Mods")
		RayStyleInstallOption1Button:SetWidth(140)
		RayStyleInstallOption2Button:SetWidth(140)
	elseif PageNum == 7 then
		f.SubTitle:SetText(L["Installation Complete"])
		f.Desc1:SetText(L["You have completed the installation process.\nIf you need help or wish to report a bug, please go to http://tukui.org"])
		f.Desc2:SetText(L["Please click the button below in order to finalize the process and automatically reload your UI."])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", InstallComplete)
		RayStyleInstallOption1Button:SetText(L["Finished"])
	end
end

local function NextPage()	
	if CURRENT_PAGE ~= MAX_PAGE then
		CURRENT_PAGE = CURRENT_PAGE + 1
		SetPage(CURRENT_PAGE)
	end
end

local function PreviousPage()
	if CURRENT_PAGE ~= 1 then
		CURRENT_PAGE = CURRENT_PAGE - 1
		SetPage(CURRENT_PAGE)
	end
end

function RS:RunSetup()
	if not RayStyleInstallStepComplete then
		local imsg = CreateFrame("Frame", "RayStyleInstallStepComplete", E.UIParent)
		imsg:Size(418, 72)
		imsg:Point("TOP", 0, -190)
		imsg:Hide()
		imsg:SetScript("OnShow", function(self)
			if self.message then 
				PlaySoundFile([[Sound\Interface\LevelUp.wav]])
				self.text:SetText(self.message)
				UIFrameFadeOut(self, 3.5, 1, 0)
				E:Delay(4, function() self:Hide() end)	
				self.message = nil
				
				if imsg.firstShow == false then
					if GetCVarBool("Sound_EnableMusic") then
						PlayMusic([[Sound\Music\ZoneMusic\DMF_L70ETC01.mp3]])
					end					
					imsg.firstShow = true
				end
			else
				self:Hide()
			end
		end)
		
		imsg.firstShow = false
		
		imsg.bg = imsg:CreateTexture(nil, "BACKGROUND")
		imsg.bg:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.bg:SetPoint("BOTTOM")
		imsg.bg:Size(326, 103)
		imsg.bg:SetTexCoord(0.00195313, 0.63867188, 0.03710938, 0.23828125)
		imsg.bg:SetVertexColor(1, 1, 1, 0.6)
		
		imsg.lineTop = imsg:CreateTexture(nil, "BACKGROUND")
		imsg.lineTop:SetDrawLayer("BACKGROUND", 2)
		imsg.lineTop:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.lineTop:SetPoint("TOP")
		imsg.lineTop:Size(418, 7)
		imsg.lineTop:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)
		
		imsg.lineBottom = imsg:CreateTexture(nil, "BACKGROUND")
		imsg.lineBottom:SetDrawLayer("BACKGROUND", 2)
		imsg.lineBottom:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.lineBottom:SetPoint("BOTTOM")
		imsg.lineBottom:Size(418, 7)
		imsg.lineBottom:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)
		
		imsg.text = imsg:CreateFontString(nil, "ARTWORK", "GameFont_Gigantic")
		imsg.text:Point("BOTTOM", 0, 12)
		imsg.text:SetTextColor(1, 0.82, 0)
		imsg.text:SetJustifyH("CENTER")
	end

	--Create Frame
	if not RayStyleInstallFrame then
		local f = CreateFrame("Button", "RayStyleInstallFrame", E.UIParent)
		f.SetPage = SetPage
		f:Size(650, 450)
		f:SetTemplate("Transparent")
		f:SetPoint("CENTER")
		f:SetFrameStrata("TOOLTIP")
		
		f.Title = f:CreateFontString(nil, "OVERLAY")
		f.Title:FontTemplate(nil, 17, nil)
		f.Title:Point("TOP", 0, -5)
		f.Title:SetText(RS.title.." "..L["Installation"])
		
		f.Next = CreateFrame("Button", "RayStyleInstallNextButton", f, "UIPanelButtonTemplate")
		f.Next:StripTextures()
		f.Next:SetTemplate("Default", true)
		f.Next:Size(110, 25)
		f.Next:Point("BOTTOMRIGHT", -5, 5)
		f.Next:SetText(CONTINUE)
		f.Next:Disable()
		f.Next:SetScript("OnClick", NextPage)
		E.Skins:HandleButton(f.Next, true)
		
		f.Prev = CreateFrame("Button", "RayStyleInstallPrevButton", f, "UIPanelButtonTemplate")
		f.Prev:StripTextures()
		f.Prev:SetTemplate("Default", true)
		f.Prev:Size(110, 25)
		f.Prev:Point("BOTTOMLEFT", 5, 5)
		f.Prev:SetText(PREVIOUS)	
		f.Prev:Disable()
		f.Prev:SetScript("OnClick", PreviousPage)
		E.Skins:HandleButton(f.Prev, true)
		
		f.Status = CreateFrame("StatusBar", "RayStyleInstallStatus", f)
		f.Status:SetFrameLevel(f.Status:GetFrameLevel() + 2)
		f.Status:CreateBackdrop("Default")
		f.Status:SetStatusBarTexture(E["media"].normTex)
		f.Status:SetStatusBarColor(unpack(E["media"].rgbvaluecolor))
		f.Status:SetMinMaxValues(0, MAX_PAGE)
		f.Status:Point("TOPLEFT", f.Prev, "TOPRIGHT", 6, -2)
		f.Status:Point("BOTTOMRIGHT", f.Next, "BOTTOMLEFT", -6, 2)
		f.Status.text = f.Status:CreateFontString(nil, "OVERLAY")
		f.Status.text:FontTemplate()
		f.Status.text:SetPoint("CENTER")
		f.Status.text:SetText(CURRENT_PAGE.." / "..MAX_PAGE)
		f.Status:SetScript("OnValueChanged", function(self)
			self.text:SetText(self:GetValue().." / "..MAX_PAGE)
		end)
		
		f.Option1 = CreateFrame("Button", "RayStyleInstallOption1Button", f, "UIPanelButtonTemplate")
		f.Option1:StripTextures()
		f.Option1:Size(160, 30)
		f.Option1:Point("BOTTOM", 0, 45)
		f.Option1:SetText("")
		f.Option1:Hide()
		E.Skins:HandleButton(f.Option1, true)
		
		f.Option2 = CreateFrame("Button", "RayStyleInstallOption2Button", f, "UIPanelButtonTemplate")
		f.Option2:StripTextures()
		f.Option2:Size(110, 30)
		f.Option2:Point("BOTTOMLEFT", f, "BOTTOM", 4, 45)
		f.Option2:SetText("")
		f.Option2:Hide()
		f.Option2:SetScript("OnShow", function() f.Option1:SetWidth(110); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOMRIGHT", f, "BOTTOM", -4, 45) end)
		f.Option2:SetScript("OnHide", function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45) end)
		E.Skins:HandleButton(f.Option2, true)		
		
		f.Option3 = CreateFrame("Button", "RayStyleInstallOption3Button", f, "UIPanelButtonTemplate")
		f.Option3:StripTextures()
		f.Option3:Size(100, 30)
		f.Option3:Point("LEFT", f.Option2, "RIGHT", 4, 0)
		f.Option3:SetText("")
		f.Option3:Hide()
		f.Option3:SetScript("OnShow", function() f.Option1:SetWidth(100); f.Option1:ClearAllPoints(); f.Option1:Point("RIGHT", f.Option2, "LEFT", -4, 0); f.Option2:SetWidth(100); f.Option2:ClearAllPoints(); f.Option2:Point("BOTTOM", f, "BOTTOM", 0, 45)  end)
		f.Option3:SetScript("OnHide", function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point("BOTTOMLEFT", f, "BOTTOM", 4, 45) end)
		E.Skins:HandleButton(f.Option3, true)			
		
		f.Option4 = CreateFrame("Button", "RayStyleInstallOption4Button", f, "UIPanelButtonTemplate")
		f.Option4:StripTextures()
		f.Option4:Size(100, 30)
		f.Option4:Point("LEFT", f.Option3, "RIGHT", 4, 0)
		f.Option4:SetText("")
		f.Option4:Hide()
		f.Option4:SetScript("OnShow", function() 
			f.Option1:Width(100)
			f.Option2:Width(100)
			
			f.Option1:ClearAllPoints(); 
			f.Option1:Point("RIGHT", f.Option2, "LEFT", -4, 0); 
			f.Option2:ClearAllPoints(); 
			f.Option2:Point("BOTTOMRIGHT", f, "BOTTOM", -4, 45)  
		end)
		f.Option4:SetScript("OnHide", function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point("BOTTOMLEFT", f, "BOTTOM", 4, 45) end)
		E.Skins:HandleButton(f.Option4, true)					

		f.SubTitle = f:CreateFontString(nil, "OVERLAY")
		f.SubTitle:FontTemplate(nil, 15, nil)		
		f.SubTitle:Point("TOP", 0, -40)
		
		f.Desc1 = f:CreateFontString(nil, "OVERLAY")
		f.Desc1:FontTemplate()	
		f.Desc1:Point("TOPLEFT", 20, -75)	
		f.Desc1:Width(f:GetWidth() - 40)
		
		f.Desc2 = f:CreateFontString(nil, "OVERLAY")
		f.Desc2:FontTemplate()	
		f.Desc2:Point("TOPLEFT", 20, -125)		
		f.Desc2:Width(f:GetWidth() - 40)
		
		f.Desc3 = f:CreateFontString(nil, "OVERLAY")
		f.Desc3:FontTemplate()	
		f.Desc3:Point("TOPLEFT", 20, -175)	
		f.Desc3:Width(f:GetWidth() - 40)
		
		local close = CreateFrame("Button", "RayStyleInstallCloseButton", f, "UIPanelCloseButton")
		close:SetPoint("TOPRIGHT", f, "TOPRIGHT")
		close:SetScript("OnClick", function()
			f:Hide()
		end)		
		E.Skins:HandleCloseButton(close)
	end
	
	RayStyleInstallFrame:Show()
	NextPage()
end