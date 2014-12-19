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
local MAX_PAGE = 6

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
	SetCVar("scriptErrors", 0)
	SetCVar("buffDurations", 1)
	SetCVar("consolidateBuffs", 0)
	SetCVar("lootUnderMouse", 1)
	SetCVar("autoSelfCast", 1)
	SetCVar("nameplateShowFriends", 0)
	SetCVar("nameplateShowFriendlyPets", 0)
	SetCVar("nameplateShowFriendlyGuardians", 0)
	SetCVar("nameplateShowFriendlyTotems", 0)
	SetCVar("nameplateShowEnemies", 1)
	SetCVar("nameplateShowEnemyPets", 1)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("cameraDistanceMaxFactor", 4)
	SetCVar("autoDismountFlying", 1)
	SetCVar("autoQuestWatch", 1)
	SetCVar("autoQuestProgress", 1)
	SetCVar("guildMemberNotify", 0)
	SetCVar("removeChatDelay", 1)
	SetCVar("showVKeyCastbar", 1)
	SetCVar("colorblindMode", 0)
	SetCVar("autoLootDefault", 1)
	SetCVar("deselectOnClick", 1)
	SetCVar("UnitNameFriendlyGuardianName", 1)
	SetCVar("UnitNameGuildTitle", 1)
	SetCVar("ActionButtonUseKeyDown", 1)
	SetCVar("interactOnLeftClick", 0)
		
	RayStyleInstallStepComplete.message = L["CVars Set"]
	RayStyleInstallStepComplete:Show()
end

function RS:SetupLayout(layout, noDataReset)
	--Set up various settings shared across all layouts
	if not noDataReset then
		--private
		E.private.general.pixelPerfect = true
		E.private.general.lootRoll = true
		E.private.general.normTex = "RayStyle Normal"
		E.private.general.glossTex = "RayStyle Gloss"
		E.private.general.namefont = "RayStyle Font"
		E.private.general.dmgfont = "RayStyle Combat"
		E.private.general.smallerWorldMap = true

		--general
		E.db.general.font = "RayStyle Font"
		E.db.general.bordercolor = { r = 0,g = 0,b = 0 }
		E.db.general.backdropcolor = { r = 0.1,g = 0.1,b = 0.1 }
		E.db.general.backdropfadecolor = { r = .04,g = .04,b = .04, a = 0.7 }
		E.db.general.valuecolor = { r = 0,g = 0.7,b = 1 }
		E.db.general.bottomPanel = false
		E.db.general.autoRepair = "GUILD"
		E.db.general.autoRoll = true
		E.db.general.vendorGrays = true
		E.db.general.autoAcceptInvite = true
		E.db.general.hideErrorFrame = true
		E.db.general.interruptAnnounce = "NONE"
		E.db.general.minimap.icons.garrison.position = "BOTTOMLEFT"
		E.db.general.minimap.icons.garrison.scale = 0.7
		
		--chat
		E.db.chat.font = "RayStyle Font"
		E.db.chat.panelTabBackdrop = false
		E.db.chat.panelTabTransparency = false
		E.db.chat.editBoxPosition = "ABOVE_CHAT"
		E.db.chat.tabFont = "RayStyle Font"
		E.db.chat.tabFontSize = 12
		E.db.chat.tabFontOutline = "NONE"
		E.db.chat.timeStampFormat = "%H:%M "
		
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
		E.db.nameplate.healthBar.text.enable = true
		E.db.nameplate.healthBar.text.format = "PERCENT"
		E.db.nameplate.castBar.height = 5
		E.db.nameplate.castBar.color = { r = 0,g = 1,b = 0 }
		E.db.nameplate.castBar.noInterrupt = { r = 1,g = 0,b = 0 }

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
		E.db.unitframe.colors.power.MANA = { r = 0,g = .82,b = 1 }
		E.db.unitframe.colors.power.RUNIC_POWER = { r = 0,g = .82,b = 1 }
		E.db.unitframe.colors.power.RAGE = { r = 1,g = 0,b = 0 }
		E.db.unitframe.colors.power.FOCUS = { r = 1,g = .5,b = .25 }
		E.db.unitframe.colors.power.ENERGY = { r = 1,g = 1,b = 0 }
		E.db.unitframe.colors.classResources.DEATHKNIGHT = {
			[1] = {r = 1, g = 0, b = 0},
			[2] = {r = 0, g = 0.5, b = 0},
			[3] = {r = 0, g = 1, b = 1},
			[4] = {r = .9, g = .1, b = 1},	
		}
		E.db.unitframe.colors.classResources.PALADIN = {r = 1,g = 0.42,b = 0.62}
		E.db.unitframe.colors.classResources.MAGE = {r = 0.2,g = 0.76,b = 1}
		E.db.unitframe.colors.classResources.PRIEST = {r = 1,g = 1,b = 1}
		E.db.unitframe.colors.classResources.DRUID = {
			[1] = {r = 0, g = .4, b = 1},
			[2] = {r = 1, g = .6,  b = 0},
		}
		E.db.unitframe.colors.classResources.MONK = {
			[1] = { r = 0,	g = 1,	b = 0.59},
			[2] = { r = 0,	g = 1,	b = 0.59},
			[3] = { r = 0,	g = 1,	b = 0.59},
			[4] = { r = 0,	g = 1,	b = 0.59},
			[5] = { r = 0,	g = 1,	b = 0.59},
			[6] = { r = 0,	g = 1,	b = 0.59},
		}
		E.db.unitframe.colors.classResources.ROGUE = {
			[1] = { r = 1,	g = 0,	b = 0},
			[2] = { r = 1,	g = 0,	b = 0},
			[3] = { r = 1,	g = 1,	b = 0},
			[4] = { r = 1,	g = 1,	b = 0},
			[5] = { r = 0,	g = 1,	b = 0},
		}
		E.db.unitframe.colors.classResources.comboPoints = {
			[1] = { r = 1,	g = 0,	b = 0},
			[2] = { r = 1,	g = 0,	b = 0},
			[3] = { r = 1,	g = 1,	b = 0},
			[4] = { r = 1,	g = 1,	b = 0},
			[5] = { r = 0,	g = 1,	b = 0},
		}
		E.db.unitframe.colors.reaction = {
			["BAD"] = { r = 1, g = 0.2, b = 0.2 },
			["NEUTRAL"] = { r = 1, g = 1, b = 0.2 },
			["GOOD"] = { r = 0.2, g = 1, b = 0.2 },
		}
		E.db.unitframe.colors.healPrediction = {
			["personal"] = {r = 0, g = 1, b = 0.5, a = 0.25},
			["others"] = {r = 0, g = 1, b = 0, a = 0.25},
			["absorbs"] = {r = 0.66, g = 1, b = 1, a = 0.7}
		}
		E.db.unitframe.units.player.width = 220
		E.db.unitframe.units.player.height = 32
		E.db.unitframe.units.player.portrait.enable = true
		E.db.unitframe.units.player.portrait.overlay = true
		E.db.unitframe.units.player.portrait.camDistanceScale = 1
		E.db.unitframe.units.player.castbar.icon = false
		E.db.unitframe.units.player.castbar.width = 350
		E.db.unitframe.units.player.castbar.height = 7
		E.db.unitframe.units.player.power.height = 3
		E.db.unitframe.units.player.aurabar.enable = false
		E.db.unitframe.units.player.buffs.enable = false
		E.db.unitframe.units.player.debuffs.anchorPoint = "TOPRIGHT"
		E.db.unitframe.units.player.debuffs.perrow = 10
		E.db.unitframe.units.player.debuffs.attachTo = "FRAME"
		E.db.unitframe.units.player.debuffs.yOffset = 7
		E.db.unitframe.units.player.classbar.height = 7
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
		E.db.unitframe.units.target.combobar.height = 7
		E.db.unitframe.units.target.combobar.detachFromFrame = true
		E.db.unitframe.units.target.combobar.detachedWidth = 220
		E.db.unitframe.units.targettarget.height = 32
		E.db.unitframe.units.targettarget.power.height = 3
		E.db.unitframe.units.targettarget.debuffs.anchorPoint = "TOPLEFT"
		E.db.unitframe.units.targettarget.debuffs.attachTo = "FRAME"
		E.db.unitframe.units.tank.enable = false
		E.db.unitframe.units.assist.enable = false
		E.db.unitframe.units.raid.enable = true
		E.db.unitframe.units.raid.growthDirection = "RIGHT_UP"
		E.db.unitframe.units.raid.height = 40
		E.db.unitframe.units.raid.power.height = 3
		E.db.unitframe.units.raid40.enable = true
		E.db.unitframe.units.raid40.growthDirection = "RIGHT_UP"
		E.db.unitframe.units.raid40.power.enable = true
		E.db.unitframe.units.raid40.power.height = 3

		--actionbar
		E.db.actionbar.font = "RayStyle Font"
		E.db.actionbar.fontSize = 12
		E.db.actionbar.fontOutline = "OUTLINE"
		E.db.actionbar.macrotext = true
		E.db.actionbar.bar1.enabled = true
		E.db.actionbar.bar1.buttonsize = 28
		E.db.actionbar.bar1.buttons = 12
		E.db.actionbar.bar1.buttonsPerRow = 12
		E.db.actionbar.bar2.enabled = true
		E.db.actionbar.bar2.buttonsize = 28
		E.db.actionbar.bar2.buttons = 12
		E.db.actionbar.bar2.buttonsPerRow = 12
		E.db.actionbar.bar3.enabled = true
		E.db.actionbar.bar3.buttonsize = 28
		E.db.actionbar.bar3.buttons = 12
		E.db.actionbar.bar3.buttonsPerRow = 6
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
		E.db.auras.consolidatedBuffs.fontSize = 10
		E.db.auras.consolidatedBuffs.fontOutline = "OUTLINE"

		--datatexts
		E.db.datatexts.font = "RayStyle Font"
		E.db.datatexts.fontSize = 11
		E.db.datatexts.fontOutline = "NONE"
		E.db.datatexts.time24 = true
		E.db.datatexts.panels.LeftChatDataPanel.left = "System"
		E.db.datatexts.panels.LeftChatDataPanel.middle = "Durability"
		E.db.datatexts.panels.LeftChatDataPanel.right = "Talent/Loot Specialization"
		E.db.datatexts.panels.RightChatDataPanel.left = "Call to Arms"
		E.db.datatexts.panels.RightChatDataPanel.middle = "Bags"
		E.db.datatexts.panels.LeftMiniPanel = "Time"
		E.db.datatexts.panels.RightMiniPanel = "Combat/Arena Time"
		E.db.datatexts.goldCoins = true

		--tooltip
		E.db.tooltip.itemCount = "BOTH"

		RS:SetMoverPosition("ElvUF_PlayerMover", "BOTTOMRIGHT", E.UIParent, "BOTTOM", -80, 390)
		RS:SetMoverPosition("ElvUF_PlayerCastbarMover", "BOTTOM", E.UIParent, "BOTTOM", 0, 305)
		RS:SetMoverPosition("ComboBarMover", "BOTTOMLEFT", ElvUF_Player, "TOPLEFT", 1, 0)
		RS:SetMoverPosition("ElvUF_TargetMover", "BOTTOMLEFT", E.UIParent, "BOTTOM", 80, 390)
		RS:SetMoverPosition("ElvUF_TargetCastbarMover", "TOP", ElvUF_Target, "BOTTOM", 0, -22)
		RS:SetMoverPosition("ElvUF_TargetTargetMover", "LEFT", ElvUF_Target, "RIGHT", 10, 0)
		RS:SetMoverPosition("ElvUF_FocusMover", "BOTTOMRIGHT", ElvUF_Player, "TOPLEFT", -20, 20)
		RS:SetMoverPosition("ElvUF_RaidMover", "BOTTOMLEFT", E.UIParent, "BOTTOMLEFT", 4, 215)
		RS:SetMoverPosition("ElvUF_Raid40Mover", "BOTTOMLEFT", E.UIParent, "BOTTOMLEFT", 4, 215)
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
		if IsAddOnLoaded("DBM-Core") and IsAddOnLoaded("DBM-StatusBarTimers") then
			RS:Print(L["DBM样式应用完成"])
			RayStyleInstallStepComplete.message = L["DBM样式应用完成"]
			RayStyleInstallStepComplete:Show()
			DBT_PersistentOptions = {
				["DBM"] = {
					["EndColorG"] = 0,
					["HugeBarXOffset"] = 0,
					["HugeBarYOffset"] = 6,
					["HugeScale"] = 1,
					["HugeWidth"] = 200,
					["HugeTimerPoint"] = "BOTTOM",
					["HugeTimerX"] = -180,
					["HugeTimerY"] = 650,
					["Scale"] = 1,
					["EnlargeBarsPercent"] = 0.125,
					["StartColorR"] = 1,
					["BarYOffset"] = 6,
					["Texture"] = "Interface\\AddOns\\ElvUI_RayStyle\\media\\statusbar.tga",
					["ExpandUpwards"] = true,
					["TimerPoint"] = "TOPLEFT",
					["StartColorG"] = 0.7,
					["TimerY"] = -230,
					["TimerX"] = 375.,
					["EndColorR"] = 1,
					["Width"] = 200,
					["EnlargeBarsTime"] = 8,
					["StartColorB"] = 0,
					["Height"] = 20,
					["BarXOffset"] = 0,
					["EndColorB"] = 0,
				},
			}
			DBM_SavedOptions = {
				["SpecialWarningFontSize"] = 30,
				["WarningIconLeft"] = true,
				["WarningIconRight"] = false,
				["WarningIconChat"] = true,
				["InfoFramePoint"] = "BOTTOMLEFT",
				["InfoFrameX"] = 500,
				["InfoFrameY"] = 220,
				["InfoFrameLocked"] = true,
				["RangeFramePoint"] = "BOTTOMLEFT",
				["RangeFrameX"] = 500,
				["RangeFrameY"] = 55,
				["RangeFrameRadarPoint"] = "BOTTOMLEFT",
				["RangeFrameRadarX"] = 500,
				["RangeFrameRadarY"] = 55,
				["RangeFrameLocked"] = true,
				["HPFramePoint"] = "RIGHT",
				["HPFrameX"] = -500,
				["HPFrameY"] = 130,
			}
		else
			RS:Print(L["插件DBM未启用"])
			RayStyleInstallStepComplete.message = L["插件DBM未启用"]
			RayStyleInstallStepComplete:Show()
		end
	elseif addon == "Skada" then
		if IsAddOnLoaded("Skada") then
			RS:Print(L["Skada样式应用完成"])
			RayStyleInstallStepComplete.message = L["Skada样式应用完成"]
			RayStyleInstallStepComplete:Show()
			SkadaDB["profiles"]["Default"] = {
				["windows"] = {
					{
						["classicons"] = false,
						["barslocked"] = true,
						["background"] = {
							["height"] = 132,
							["texture"] = "ElvUI Blank",
						},
						["barfont"] = "RayStyle Font",
						["barfontflags"] = "THINOUTLINE",
						["title"] = {
							["font"] = "RayStyle Font",
							["texture"] = "RayStyle Normal",
						},
						["point"] = "TOPRIGHT",
						["barcolor"] = {
							["g"] = 0.3,
							["r"] = 0.3,
						},
						["mode"] = "伤害",
						["spark"] = false,
						["bartexture"] = "RayStyle Normal",
						["barwidth"] = 402,
						["barbgcolor"] = {
							["a"] = 0,
							["r"] = 0.3,
							["g"] = 0.3,
							["b"] = 0.3,
						},
						["barfontsize"] = 12,
					},
				},
				["tooltippos"] = "topleft",
			}
		else
			RS:Print(L["插件Skada未启用"])
			RayStyleInstallStepComplete.message = L["插件Skada未启用"]
			RayStyleInstallStepComplete:Show()
		end
	end
	if IsAddOnLoaded("AddOnSkins") then
		if addon == "Skada" then
    		E.private["addonskins"]["EmbedSystem"] = true
			E.private["addonskins"]["TransparentEmbed"] = true
			E.private["addonskins"]["SkadaBackdrop"] = false
			E.private["addonskins"]["EmbedMain"] = "Skada"
		elseif addon == "DBM" then
			E.private["addonskins"]["DBMFont"] = "RayStyle Font"
			E.private["addonskins"]["DBMFontSize"] = 12
			E.private["addonskins"]["DBMFontFlag"] = "OUTLINE"
		end
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
		f.SubTitle:SetText(format(L["欢迎使用 %s %s, \n基于 ElvUI %s以上。"], RS.title, RS:ColorStr(RS.version), RS:ColorStr(RS.versionMinE)))
		f.Desc1:SetText(L["这个安装向导将通过几个简单步骤引导你安装RayStyle样式的设置。"])
		f.Desc2:SetText(format(L["此扩展美化包的选项设置可以在ElvUI控制台(/ec)的%s分类里找到。"], RS.title))
		f.Desc3:SetText(L["请点击继续按钮。"])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", InstallComplete)
		RayStyleInstallOption1Button:SetText(L["Skip Process"])
	elseif PageNum == 2 then
		f.SubTitle:SetText(L["CVars"])
		f.Desc1:SetText(format(L["这一步将改变一些魔兽世界的默认设置选项。 这些选项是%s建议设置的，但不影响这个扩展包的功能。"], RS.title))
		f.Desc2:SetText(L["请点击下面的按钮应用设置"])
		f.Desc3:SetText(L["Importance: |cffFF0000Low|r"])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", SetupCVars)
		RayStyleInstallOption1Button:SetText(L["Setup CVars"])
	elseif PageNum == 3 then
		f.SubTitle:SetText(L["Chat"])
		f.Desc1:SetText(format(L["这一步会改变聊天栏的文字大小以及颜色等设置。这些选项是%s建议设置的，但不影响这个扩展包的功能。"], RS.title))
		f.Desc2:SetText(L["请点击下面的按钮应用设置"])
		f.Desc3:SetText(L["Importance: |cffFF0000Low|r"])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", SetupChat)
		RayStyleInstallOption1Button:SetText(L["Setup Chat"])					
	elseif PageNum == 4 then
		f.SubTitle:SetText(L["Layout"])
		f.Desc1:SetText(format(L["这一步会改变大部分ElvUI模块的设置。如果你想看起来和%s预览中的界面布局一样你必须完成此项设置。"], RS.title))
		f.Desc2:SetText(L["请点击下面其中一个按钮完成设置。"])
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
		f.SubTitle:SetText(L["插件"])
		f.Desc1:SetFormattedText(L["这一步会改变一些插件的设置以便符合%s的风格。"], RS.title)
		f.Desc2:SetFormattedText(L["请点击下面的按钮来应用插件设置，同时请确认先开启AddOnSkins插件。"], RS.title)
		f.Desc3:SetText(L["Importance: |cff07D400High|r"])
		RayStyleInstallOption1Button:Show()
		RayStyleInstallOption1Button:SetScript("OnClick", function() RS:SetupAddon("Skada") end)
		RayStyleInstallOption1Button:SetText("Skada")
		RayStyleInstallOption2Button:Show()
		RayStyleInstallOption2Button:SetScript("OnClick", function() RS:SetupAddon("DBM") end)
		RayStyleInstallOption2Button:SetText("Deadly Boss Mods")
		RayStyleInstallOption1Button:SetWidth(140)
		RayStyleInstallOption2Button:SetWidth(140)
	elseif PageNum == 6 then
		f.SubTitle:SetText(L["Installation Complete"])
		f.Desc1:SetText(L["你已经完成安装.\n如果你想反馈bug，请登录http://rayui.cn"])
		f.Desc2:SetText(L["请点击下面的按钮来完成安装，这将重载你的界面。"])
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