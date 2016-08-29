-- [[------------------------------------------------------------------------
	-- RayStyle, an ElvUI edit by Ray

	-- This file contains changes/additions to the various ElvUI panels
--------------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local LO = E:GetModule("Layout")
local RS = E:GetModule("RayStyle")
local LSM = LibStub("LibSharedMedia-3.0")

local PANEL_HEIGHT = 22

function RS:InitializeLayout()
	-- Create extra panels
	RS:CreateBottomDataBarPanels()
end
hooksecurefunc(LO, "Initialize", RS.InitializeLayout)

function RS:SetDataPanelTransparent()
	LeftChatDataPanel:SetTemplate("Transparent")
	LeftChatDataPanel:SetBackdropBorderColor(0, 0, 0, 0)
	LeftChatDataPanel:SetBackdropColor(0, 0, 0, 0)
	LeftChatToggleButton:SetTemplate("Transparent")
	LeftChatToggleButton:SetBackdropBorderColor(0, 0, 0, 0)
	LeftChatToggleButton:SetBackdropColor(0, 0, 0, 0)
	RightChatDataPanel:SetTemplate("Transparent")
	RightChatDataPanel:SetBackdropBorderColor(0, 0, 0, 0)
	RightChatDataPanel:SetBackdropColor(0, 0, 0, 0)
	RightChatToggleButton:SetTemplate("Transparent")
	RightChatToggleButton:SetBackdropBorderColor(0, 0, 0, 0)
	RightChatToggleButton:SetBackdropColor(0, 0, 0, 0)
	LeftMiniPanel:SetTemplate("Transparent")
	RightMiniPanel:SetTemplate("Transparent")
end

function RS:SetDataPanelStyle()
	RS:SetDataPanelTransparent()
end
hooksecurefunc(LO, "SetDataPanelStyle", RS.SetDataPanelStyle)

function RS:UpdateDTBackdropColors()
	RS:SetDataPanelTransparent()
end
hooksecurefunc(E, "UpdateBackdropColors", RS.UpdateDTBackdropColors)

function RS:CreateBottomDataBarPanels()
	local bottombar = CreateFrame("Frame", "Bottom_Datatext_Panel", E.UIParent)
	bottombar:Point("BOTTOM", E.UIParent, "BOTTOM", 0, 4)
	bottombar:Size(400, PANEL_HEIGHT)
	bottombar:SetTemplate("Transparent")
	E:GetModule("DataTexts"):RegisterPanel(bottombar, 3, "ANCHOR_LEFT", -1, -PANEL_HEIGHT)

	E.FrameLocks["Bottom_Datatext_Panel"] = true
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	RS:SetDataPanelTransparent()
end)
--[[ function RS:CreateAndModifyChatPanels()
	-- Left Chat Tab Separator
	local ltabseparator = CreateFrame('Frame', 'LeftChatTabSeparator', LeftChatPanel)
	ltabseparator:SetFrameStrata('BACKGROUND')
	ltabseparator:SetFrameLevel(LeftChatPanel:GetFrameLevel() + 2)
	ltabseparator:Size(E.db.chat.panelWidth - 10, 1)
	ltabseparator:Point('TOP', LeftChatPanel, 0, -24)
	ltabseparator:SetTemplate('Transparent')
	
	-- Right Chat Tab Separator
	local rtabseparator = CreateFrame('Frame', 'RightChatTabSeparator', RightChatPanel)
	rtabseparator:SetFrameStrata('BACKGROUND')
	rtabseparator:SetFrameLevel(RightChatPanel:GetFrameLevel() + 2)
	rtabseparator:Size(E.db.chat.panelWidth - 10, 1)
	rtabseparator:Point('TOP', RightChatPanel, 0, -24)
	rtabseparator:SetTemplate('Transparent')
	
	-- Left Chat Data Panel Separator
	local ldataseparator = CreateFrame('Frame', 'LeftDataPanelSeparator', LeftChatPanel)
	ldataseparator:SetFrameStrata('BACKGROUND')
	ldataseparator:SetFrameLevel(LeftChatPanel:GetFrameLevel() + 2)
	ldataseparator:Size(E.db.chat.panelWidth - 10, 1)
	ldataseparator:Point('BOTTOM', LeftChatPanel, 0, 24)
	ldataseparator:SetTemplate('Transparent')
	
	-- Right Chat Data Panel Separator
	local rdataseparator = CreateFrame('Frame', 'RightDataPanelSeparator', RightChatPanel)
	rdataseparator:SetFrameStrata('BACKGROUND')
	rdataseparator:SetFrameLevel(RightChatPanel:GetFrameLevel() + 2)
	rdataseparator:Size(E.db.chat.panelWidth - 10, 1)
	rdataseparator:Point('BOTTOM', RightChatPanel, 0, 24)
	rdataseparator:SetTemplate('Transparent')
	
	-- Modify Left Chat Toggle Button font, text and color
	LeftChatToggleButton.text:FontTemplate(LSM:Fetch("font", E.db.datatexts.font), E.db.datatexts.fontSize, E.db.datatexts.fontOutline)
	LeftChatToggleButton.text:SetText('L')
	LeftChatToggleButton.text:SetTextColor(unpack(E["media"].rgbvaluecolor))
	
	-- Modify Right Chat Toggle Button font, text and color
	RightChatToggleButton.text:FontTemplate(LSM:Fetch("font", E.db.datatexts.font), E.db.datatexts.fontSize, E.db.datatexts.fontOutline)
	RightChatToggleButton.text:SetText('R')
	RightChatToggleButton.text:SetTextColor(unpack(E["media"].rgbvaluecolor))
end
hooksecurefunc(LO, "CreateChatPanels", RS.CreateAndModifyChatPanels)

function RS:ModifyMinimapPanels()
	-- Make room for system datatext by shrinking time datatext
	LeftMiniPanel:SetPoint('BOTTOMRIGHT', Minimap, 'BOTTOMLEFT', E.Spacing + E.db.RS.datatexts.leftMinimapPanelSize, -((E.PixelMode and 0 or 3) + PANEL_HEIGHT))
	
	-- Modify ElvUI Config Toggle Button font (requires reload to reflect font changes)
	ElvConfigToggle.text:FontTemplate(LSM:Fetch("font", E.db.datatexts.font), E.db.datatexts.fontSize, E.db.datatexts.fontOutline)
end
hooksecurefunc(LO, "CreateMinimapPanels", RS.ModifyMinimapPanels)

function RS:ToggleDataPanels()
	if E.db.RS.datatexts.bottomDatatextPanel then
		Bottom_Datatext_Panel:Show()
	else
		Bottom_Datatext_Panel:Hide()
	end
	if E.db.RS.datatexts.rightChatTabDatatextPanel then
		ChatTab_Datatext_Panel:Show()
	else
		ChatTab_Datatext_Panel:Hide()
	end
end

function RS:ToggleChatSeparators()
	if E.db.RS.chat.chatTabSeparator == 'SHOWBOTH' then
		LeftChatTabSeparator:Show()
		RightChatTabSeparator:Show()
	elseif E.db.RS.chat.chatTabSeparator == 'HIDEBOTH' then
		LeftChatTabSeparator:Hide()
		RightChatTabSeparator:Hide()
	elseif E.db.RS.chat.chatTabSeparator == 'LEFTONLY' then
		LeftChatTabSeparator:Show()
		RightChatTabSeparator:Hide()
	elseif E.db.RS.chat.chatTabSeparator == 'RIGHTONLY' then
		LeftChatTabSeparator:Hide()
		RightChatTabSeparator:Show()
	end
	
	if E.db.RS.chat.chatDataSeparator == 'SHOWBOTH' then
		LeftDataPanelSeparator:Show()
		RightDataPanelSeparator:Show()
	elseif E.db.RS.chat.chatDataSeparator == 'HIDEBOTH' then
		LeftDataPanelSeparator:Hide()
		RightDataPanelSeparator:Hide()
	elseif E.db.RS.chat.chatDataSeparator == 'LEFTONLY' then
		LeftDataPanelSeparator:Show()
		RightDataPanelSeparator:Hide()
	elseif E.db.RS.chat.chatDataSeparator == 'RIGHTONLY' then
		LeftDataPanelSeparator:Hide()
		RightDataPanelSeparator:Show()
	end
end]]