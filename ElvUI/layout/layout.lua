local E, L, V, P, G, _ = unpack(select(2, ...)); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local LO = E:NewModule('Layout', 'AceEvent-3.0');

local PANEL_HEIGHT = 22;
local SIDE_BUTTON_WIDTH = 16;

E.Layout = LO;

local function Panel_OnShow(self)
	self:SetFrameLevel(0)
	self:SetFrameStrata('BACKGROUND')
end

function LO:Initialize()
	self:CreateChatPanels()
	self:CreateMinimapPanels()
	self:CreateExtraDataBarPanels()
	
	self.BottomPanel = CreateFrame('Frame', 'ElvUI_BottomPanel', E.UIParent)
	self.BottomPanel:SetTemplate('Default', true)
	self.BottomPanel:Point('BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', -1, -1)
	self.BottomPanel:Point('BOTTOMRIGHT', E.UIParent, 'BOTTOMRIGHT', 1, -1)
	self.BottomPanel:Height(PANEL_HEIGHT)
	self.BottomPanel:SetScript('OnShow', Panel_OnShow)
	E.FrameLocks['ElvUI_BottomPanel'] = true;
	Panel_OnShow(self.BottomPanel)
	self:BottomPanelVisibility()
	
	self.TopPanel = CreateFrame('Frame', 'ElvUI_TopPanel', E.UIParent)
	self.TopPanel:SetTemplate('Default', true)
	self.TopPanel:Point('TOPLEFT', E.UIParent, 'TOPLEFT', -1, 1)
	self.TopPanel:Point('TOPRIGHT', E.UIParent, 'TOPRIGHT', 1, 1)
	self.TopPanel:Height(PANEL_HEIGHT)
	self.TopPanel:SetScript('OnShow', Panel_OnShow)
	Panel_OnShow(self.TopPanel)
	E.FrameLocks['ElvUI_TopPanel'] = true;
	self:TopPanelVisibility()	
end

function LO:BottomPanelVisibility()
	if E.db.general.bottomPanel then
		self.BottomPanel:Show()
	else
		self.BottomPanel:Hide()
	end
end

function LO:TopPanelVisibility()
	if E.db.general.topPanel then
		self.TopPanel:Show()
	else
		self.TopPanel:Hide()
	end
end


local function ChatPanelLeft_OnFade(self)
	LeftChatPanel:Hide()
end

local function ChatPanelRight_OnFade(self)
	RightChatPanel:Hide()
end

local function ChatButton_OnEnter(self, ...)
	if E.db[self.parent:GetName()..'Faded'] then
		self.parent:Show()
		UIFrameFadeIn(self.parent, 0.2, self.parent:GetAlpha(), 1)
		UIFrameFadeIn(self, 0.2, self:GetAlpha(), 1)
	end

	GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 0, 4)
	GameTooltip:ClearLines()
	GameTooltip:AddDoubleLine(L['Left Click:'], L['Toggle Chat Frame'], 1, 1, 1)
	GameTooltip:Show()
end

local function ChatButton_OnLeave(self, ...)
	if E.db[self.parent:GetName()..'Faded'] then
		UIFrameFadeOut(self.parent, 0.2, self.parent:GetAlpha(), 0)
		UIFrameFadeOut(self, 0.2, self:GetAlpha(), 0)
		self.parent.fadeInfo.finishedFunc = self.parent.fadeFunc
	end
	GameTooltip:Hide()
end

local function ChatButton_OnClick(self, btn)
	GameTooltip:Hide()
	
	if E.db[self.parent:GetName()..'Faded'] then
		E.db[self.parent:GetName()..'Faded'] = nil
		UIFrameFadeIn(self.parent, 0.2, self.parent:GetAlpha(), 1)
		UIFrameFadeIn(self, 0.2, self:GetAlpha(), 1)
	else
		E.db[self.parent:GetName()..'Faded'] = true
		UIFrameFadeOut(self.parent, 0.2, self.parent:GetAlpha(), 0)
		UIFrameFadeOut(self, 0.2, self:GetAlpha(), 0)
		self.parent.fadeInfo.finishedFunc = self.parent.fadeFunc
	end
end

function HideLeftChat()
	ChatButton_OnClick(LeftChatToggleButton)
end

function HideRightChat()
	ChatButton_OnClick(RightChatToggleButton)
end

function HideBothChat()
	ChatButton_OnClick(LeftChatToggleButton)
	ChatButton_OnClick(RightChatToggleButton)
end

function LO:ToggleChatPanels()
	LeftChatDataPanel:ClearAllPoints()
	RightChatDataPanel:ClearAllPoints()
	local SPACING = (E.PixelMode and 3 or 5)
	
	if E.db.datatexts.leftChatPanel then
		LeftChatDataPanel:Show()
		LeftChatToggleButton:Show()
	else
		LeftChatDataPanel:Hide()
		LeftChatToggleButton:Hide()
	end
	
	if E.db.datatexts.rightChatPanel then
		RightChatDataPanel:Show()
		RightChatToggleButton:Show()
	else
		RightChatDataPanel:Hide()
		RightChatToggleButton:Hide()
	end	
	
	if E.db.chat.panelBackdrop == 'SHOWBOTH' then
		LeftChatPanel.backdrop:Show()
		LeftChatTab:Show()
		RightChatPanel.backdrop:Show()
		RightChatTab:Show()		
		LeftChatDataPanel:Point('BOTTOMLEFT', LeftChatPanel, 'BOTTOMLEFT', SPACING + SIDE_BUTTON_WIDTH, SPACING)
		LeftChatDataPanel:Point('TOPRIGHT', LeftChatPanel, 'BOTTOMRIGHT', -SPACING, (SPACING + PANEL_HEIGHT))		
		RightChatDataPanel:Point('BOTTOMLEFT', RightChatPanel, 'BOTTOMLEFT', SPACING, SPACING)
		RightChatDataPanel:Point('TOPRIGHT', RightChatPanel, 'BOTTOMRIGHT', -(SPACING + SIDE_BUTTON_WIDTH), SPACING + PANEL_HEIGHT)		
		LeftChatToggleButton:Point('BOTTOMLEFT', LeftChatPanel, 'BOTTOMLEFT', SPACING, SPACING)
		RightChatToggleButton:Point('BOTTOMRIGHT', RightChatPanel, 'BOTTOMRIGHT', -SPACING, SPACING)
	elseif E.db.chat.panelBackdrop == 'HIDEBOTH' then
		LeftChatPanel.backdrop:Hide()
		LeftChatTab:Hide()
		RightChatPanel.backdrop:Hide()
		RightChatTab:Hide()		
		LeftChatDataPanel:Point('BOTTOMLEFT', LeftChatPanel, 'BOTTOMLEFT', SIDE_BUTTON_WIDTH, 0)
		LeftChatDataPanel:Point('TOPRIGHT', LeftChatPanel, 'BOTTOMRIGHT', 0, PANEL_HEIGHT)		
		RightChatDataPanel:Point('BOTTOMLEFT', RightChatPanel, 'BOTTOMLEFT')
		RightChatDataPanel:Point('TOPRIGHT', RightChatPanel, 'BOTTOMRIGHT', -SIDE_BUTTON_WIDTH, PANEL_HEIGHT)		
		LeftChatToggleButton:Point('BOTTOMLEFT', LeftChatPanel, 'BOTTOMLEFT')
		RightChatToggleButton:Point('BOTTOMRIGHT', RightChatPanel, 'BOTTOMRIGHT')
	elseif E.db.chat.panelBackdrop == 'LEFT' then
		LeftChatPanel.backdrop:Show()
		LeftChatTab:Show()
		RightChatPanel.backdrop:Hide()
		RightChatTab:Hide()		
		LeftChatDataPanel:Point('BOTTOMLEFT', LeftChatPanel, 'BOTTOMLEFT', SPACING + SIDE_BUTTON_WIDTH, SPACING)
		LeftChatDataPanel:Point('TOPRIGHT', LeftChatPanel, 'BOTTOMRIGHT', -SPACING, (SPACING + PANEL_HEIGHT))			
		RightChatDataPanel:Point('BOTTOMLEFT', RightChatPanel, 'BOTTOMLEFT')
		RightChatDataPanel:Point('TOPRIGHT', RightChatPanel, 'BOTTOMRIGHT', -SIDE_BUTTON_WIDTH, PANEL_HEIGHT)			
		LeftChatToggleButton:Point('BOTTOMLEFT', LeftChatPanel, 'BOTTOMLEFT', SPACING, SPACING)
		RightChatToggleButton:Point('BOTTOMRIGHT', RightChatPanel, 'BOTTOMRIGHT')
	else
		LeftChatPanel.backdrop:Hide()
		LeftChatTab:Hide()
		RightChatPanel.backdrop:Show()
		RightChatTab:Show()		
		LeftChatDataPanel:Point('BOTTOMLEFT', LeftChatPanel, 'BOTTOMLEFT', SIDE_BUTTON_WIDTH, 0)
		LeftChatDataPanel:Point('TOPRIGHT', LeftChatPanel, 'BOTTOMRIGHT', 0, PANEL_HEIGHT)			
		RightChatDataPanel:Point('BOTTOMLEFT', RightChatPanel, 'BOTTOMLEFT', SPACING, SPACING)
		RightChatDataPanel:Point('TOPRIGHT', RightChatPanel, 'BOTTOMRIGHT', -(SPACING + SIDE_BUTTON_WIDTH), SPACING + PANEL_HEIGHT)		
		LeftChatToggleButton:Point('BOTTOMLEFT', LeftChatPanel, 'BOTTOMLEFT')
		RightChatToggleButton:Point('BOTTOMRIGHT', RightChatPanel, 'BOTTOMRIGHT', -SPACING, SPACING)
	end
end

function LO:CreateChatPanels()
	local SPACING = (E.PixelMode and 3 or 5)
	
	--Left Chat
	local lchat = CreateFrame('Frame', 'LeftChatPanel', E.UIParent)
	lchat:SetFrameStrata('BACKGROUND')
	lchat:Size(E.db.chat.panelWidth, E.db.chat.panelHeight)		
	lchat:Point('BOTTOMLEFT', E.UIParent, 4, 4)
	lchat:CreateBackdrop('Transparent')
	lchat.backdrop:SetAllPoints()
	E:CreateMover(lchat, "LeftChatMover", "Left Chat")
	
	
	--Background Texture
	lchat.tex = lchat:CreateTexture(nil, 'OVERLAY')
	lchat.tex:SetInside()
	lchat.tex:SetTexture(E.db.chat.panelBackdropNameLeft)
	lchat.tex:SetAlpha(E.db.general.backdropfadecolor.a - 0.7 > 0 and E.db.general.backdropfadecolor.a - 0.7 or 0.5)
	
	--Left Chat Tab
	local lchattab = CreateFrame('Frame', 'LeftChatTab', LeftChatPanel)
	lchattab:Point('TOPLEFT', lchat, 'TOPLEFT', SPACING, -SPACING)
	lchattab:Point('BOTTOMRIGHT', lchat, 'TOPRIGHT', -SPACING, -(SPACING + PANEL_HEIGHT))
	lchattab:SetTemplate('Default', true)
	
	--Left Chat Data Panel
	local lchatdp = CreateFrame('Frame', 'LeftChatDataPanel', LeftChatPanel)
	lchatdp:Point('BOTTOMLEFT', lchat, 'BOTTOMLEFT', SPACING + SIDE_BUTTON_WIDTH, SPACING)
	lchatdp:Point('TOPRIGHT', lchat, 'BOTTOMRIGHT', -SPACING, (SPACING + PANEL_HEIGHT))
	lchatdp:SetTemplate('Default', true)
	
	E:GetModule('DataTexts'):RegisterPanel(lchatdp, 3, 'ANCHOR_TOPLEFT', -17, 4)
	
	--Left Chat Toggle Button
	local lchattb = CreateFrame('Button', 'LeftChatToggleButton', E.UIParent)
	lchattb.parent = LeftChatPanel
	LeftChatPanel.fadeFunc = ChatPanelLeft_OnFade
	lchattb:Point('TOPRIGHT', lchatdp, 'TOPLEFT', -(E.PixelMode and -1 or 1), 0)
	lchattb:Point('BOTTOMLEFT', lchat, 'BOTTOMLEFT', SPACING, SPACING)
	lchattb:SetTemplate('Default', true)
	lchattb:SetScript('OnEnter', ChatButton_OnEnter)
	lchattb:SetScript('OnLeave', ChatButton_OnLeave)
	lchattb:SetScript('OnClick', ChatButton_OnClick)
	lchattb.text = lchattb:CreateFontString(nil, 'OVERLAY')
	lchattb.text:FontTemplate()
	lchattb.text:SetPoint('CENTER')
	lchattb.text:SetJustifyH('CENTER')
	lchattb.text:SetText('<')
	
	--Right Chat
	local rchat = CreateFrame('Frame', 'RightChatPanel', E.UIParent)
	rchat:SetFrameStrata('BACKGROUND')
	rchat:Size(E.db.chat.panelWidth, E.db.chat.panelHeight)
	rchat:Point('BOTTOMRIGHT', E.UIParent, -4, 4)
	rchat:CreateBackdrop('Transparent')
	rchat.backdrop:SetAllPoints()
	E:CreateMover(rchat, "RightChatMover", "Right Chat")
	
	--Background Texture
	rchat.tex = rchat:CreateTexture(nil, 'OVERLAY')
	rchat.tex:SetInside()
	rchat.tex:SetTexture(E.db.chat.panelBackdropNameRight)
	rchat.tex:SetAlpha(E.db.general.backdropfadecolor.a - 0.7 > 0 and E.db.general.backdropfadecolor.a - 0.7 or 0.5)	
	
	--Right Chat Tab
	local rchattab = CreateFrame('Frame', 'RightChatTab', RightChatPanel)
	rchattab:Point('TOPRIGHT', rchat, 'TOPRIGHT', -SPACING, -SPACING)
	rchattab:Point('BOTTOMLEFT', rchat, 'TOPLEFT', SPACING, -(SPACING + PANEL_HEIGHT))
	rchattab:SetTemplate('Default', true)
	
	--Right Chat Data Panel
	local rchatdp = CreateFrame('Frame', 'RightChatDataPanel', RightChatPanel)
	rchatdp:Point('BOTTOMLEFT', rchat, 'BOTTOMLEFT', SPACING, SPACING)
	rchatdp:Point('TOPRIGHT', rchat, 'BOTTOMRIGHT', -(SPACING + SIDE_BUTTON_WIDTH), SPACING + PANEL_HEIGHT)
	rchatdp:SetTemplate('Default', true)
	E:GetModule('DataTexts'):RegisterPanel(rchatdp, 3, 'ANCHOR_TOPRIGHT', 17, 4)
	
	--Right Chat Toggle Button
	local rchattb = CreateFrame('Button', 'RightChatToggleButton', E.UIParent)
	rchattb.parent = RightChatPanel
	RightChatPanel.fadeFunc = ChatPanelRight_OnFade
	rchattb:Point('TOPLEFT', rchatdp, 'TOPRIGHT', (E.PixelMode and -1 or 1), 0)
	rchattb:Point('BOTTOMRIGHT', rchat, 'BOTTOMRIGHT', -SPACING, SPACING)
	rchattb:SetTemplate('Default', true)
	rchattb:RegisterForClicks('AnyUp')
	rchattb:SetScript('OnEnter', ChatButton_OnEnter)
	rchattb:SetScript('OnLeave', ChatButton_OnLeave)
	rchattb:SetScript('OnClick', ChatButton_OnClick)
	rchattb.text = rchattb:CreateFontString(nil, 'OVERLAY')
	rchattb.text:FontTemplate()
	rchattb.text:SetPoint('CENTER')
	rchattb.text:SetJustifyH('CENTER')
	rchattb.text:SetText('>')
	
	--Load Settings
	if E.db['LeftChatPanelFaded'] then
		LeftChatToggleButton:SetAlpha(0)
		LeftChatPanel:Hide()
	end	
	
	if E.db['RightChatPanelFaded'] then
		RightChatToggleButton:SetAlpha(0)
		RightChatPanel:Hide()
	end		
	
	self:ToggleChatPanels()
end

function LO:CreateMinimapPanels()
	local lminipanel = CreateFrame('Frame', 'LeftMiniPanel', Minimap)
	lminipanel:Point('TOPLEFT', Minimap, 'BOTTOMLEFT', -E.Border, (E.PixelMode and 0 or -3))
	lminipanel:Point('BOTTOMRIGHT', Minimap, 'BOTTOM', -(E.Spacing+20), -((E.PixelMode and 0 or 3) + PANEL_HEIGHT))
	lminipanel:SetTemplate('Default', true)
	E:GetModule('DataTexts'):RegisterPanel(lminipanel, 1, 'ANCHOR_BOTTOMLEFT', lminipanel:GetWidth() * 2, -4)
	
	local rminipanel = CreateFrame('Frame', 'RightMiniPanel', Minimap)
	rminipanel:Point('TOPRIGHT', Minimap, 'BOTTOMRIGHT', E.Border, (E.PixelMode and 0 or -3))
	rminipanel:Point('BOTTOMLEFT', lminipanel, 'BOTTOMRIGHT', (E.PixelMode and -1 or 1), 0)
	rminipanel:SetTemplate('Default', true)
	E:GetModule('DataTexts'):RegisterPanel(rminipanel, 1, 'ANCHOR_BOTTOM', 0, -4)
	
	if E.db.datatexts.minimapPanels then
		LeftMiniPanel:Show()
		RightMiniPanel:Show()
	else
		LeftMiniPanel:Hide()
		RightMiniPanel:Hide()
	end
	
	local configtoggle = CreateFrame('Button', 'ElvConfigToggle', Minimap)
	configtoggle:Point('TOPLEFT', rminipanel, 'TOPRIGHT', (E.PixelMode and -1 or 1), 0)
	configtoggle:Point('BOTTOMLEFT', rminipanel, 'BOTTOMRIGHT', (E.PixelMode and -1 or 1), 0)
	configtoggle:RegisterForClicks('AnyUp')
	configtoggle:Width(E.ConsolidatedBuffsWidth)
	configtoggle:SetTemplate('Default', true)
	configtoggle.text = configtoggle:CreateFontString(nil, 'OVERLAY')
	configtoggle.text:FontTemplate()
	configtoggle.text:SetText('C')
	configtoggle.text:SetPoint('CENTER')
	configtoggle.text:SetJustifyH('CENTER')
	configtoggle:SetScript('OnClick', function(self, btn) 
		if btn == 'LeftButton' then
			E:ToggleConfig()
		else
			E:BGStats()
		end
	end)
	configtoggle:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMRIGHT', 0, -4)
		GameTooltip:ClearLines()
		GameTooltip:AddDoubleLine(L['Left Click:'], L['Toggle Configuration'], 1, 1, 1)
		
		if E.db.datatexts.battleground then
			GameTooltip:AddDoubleLine(L['Right Click:'], L['Show BG Texts'], 1, 1, 1)	
		end
		GameTooltip:Show()
	end)
	configtoggle:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)
end

function LO:CreateExtraDataBarPanels()
	local chattab1 = CreateFrame('Frame', 'ChatTab_Datatext_Panel', E.UIParent)
	chattab1:SetScript('OnShow', function(self)
		chattab1:Point("TOPRIGHT", RightChatTab, "TOPRIGHT", 0, 0)
		chattab1:Point("BOTTOMLEFT", RightChatTab, "BOTTOMLEFT", (E.db.chat.panelWidth / 3), 0)
	end)
	chattab1:Hide()
	E:GetModule('DataTexts'):RegisterPanel(chattab1, 2, 'ANCHOR_BOTTOM', 0, -4)
	
	local bottom_bar = CreateFrame('Frame', 'Bottom_Datatext_Panel', E.UIParent)
	bottom_bar:SetTemplate('Default', true)
	bottom_bar:SetFrameStrata('BACKGROUND')
	bottom_bar:SetScript('OnShow', function(self)
		self:Point("TOPLEFT", ElvUI_Bar1, "BOTTOMLEFT", 0, -E.mult); 
		self:Size(ElvUI_Bar1:GetWidth(), PANEL_HEIGHT); 
		E:CreateMover(self, "BottomBarMover", "Bottom Datatext Frame") 
	end)
	E.FrameLocks['Bottom_Datatext_Panel'] = true
	E:GetModule('DataTexts'):RegisterPanel(Bottom_Datatext_Panel, 3, 'ANCHOR_BOTTOM', 0, -4)
	bottom_bar:Hide()
	
	RightChatTab:HookScript("OnHide", function() 
		chattab1:Hide() 
	end)
	RightChatTab:HookScript("OnShow", function() 
		chattab1:Show() 
		chattab1:SetAlpha(RightChatTab:GetAlpha())
	end)
end

function ExtraDataBarSetup()
	ChatTab_Datatext_Panel:Show()
	if E.private.actionbar.enable then
		Bottom_Datatext_Panel:Show()
	end
end

function LO:PLAYER_ENTERING_WORLD(...)
	ExtraDataBarSetup()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD");
end

LO:RegisterEvent('PLAYER_ENTERING_WORLD')
E:RegisterModule(LO:GetName())