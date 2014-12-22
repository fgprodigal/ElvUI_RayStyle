--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local CH = E:GetModule("Chat")
local RS = E:GetModule("RayStyle")

local function StyleChat()
	for _, frameName in pairs(CHAT_FRAMES) do
		local cf = _G[frameName]
		_G[frameName.."EditBoxLanguage"]:Kill()
		_G[frameName.."EditBox"]:SetTemplate("Transparent")
	end
end
hooksecurefunc(CH, "StyleChat", StyleChat)

local function updateFS(self, ...)
	local fstring = self:GetFontString()
	local x = fstring:GetText()
	if x:find("cff") then
		x = x:match("\124cff%w%w%w%w%w%w(.+)\124r")
	end
	if x then
		fstring:SetText(E:RGBToHex(...)..x.."|r")
	end
end

function RS:FaneifyTab(frame)
	local i = frame:GetID()
	if(i == SELECTED_CHAT_FRAME:GetID()) then
		updateFS(frame, .5, 1, 1)
	else
		updateFS(frame, 1, 1, 1)
	end
end

local function StyleGlowTab(self, event, ...)
	if self.glow:IsShown() then
		updateFS(self, 1, 0, 0)
	end
end
hooksecurefunc(CH, "ChatTab_OnUpdate", StyleGlowTab)

local function StyleTabText(self, frame)
	local name = frame:GetName()
	local tab = _G[name.."Tab"]
	tab.text = _G[name.."TabText"]
	hooksecurefunc(tab.text, "SetTextColor", function(self)
		RS:FaneifyTab(tab)
	end)
end
hooksecurefunc(CH, "StyleChat", StyleTabText)

local function OnHyperlinkEnter(self, frame, refString)
	if InCombatLockdown() then return; end
	if GameTooltip:IsShown() and frame:GetParent() then
		GameTooltip:ClearAllPoints()
		if frame:GetParent() == LeftChatPanel then
			GameTooltip:Point("BOTTOMLEFT", LeftChatPanel, "TOPLEFT", 0, 2)
		else
			GameTooltip:Point("BOTTOMRIGHT", RightChatPanel, "TOPRIGHT", 0, 2)
		end
	end
end
hooksecurefunc(CH, "OnHyperlinkEnter", OnHyperlinkEnter)