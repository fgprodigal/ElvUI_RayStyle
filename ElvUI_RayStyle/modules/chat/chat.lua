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

local function updateFS(self, inc, flags, ...)
	local fstring = self:GetFontString()
	if(...) then
		fstring:SetTextColor(...)
	end

	if (inc or self.ffl) then
		fstring:SetTextColor(1,0,0)
	end

	local x = fstring:GetText()
	if x:find("cff") then
		x = x:match("\124cff%w%w%w%w%w%w(.+)\124r")
	end
	if x then
		fstring:SetText(E:RGBToHex(...)..x.."|r")
	end
end

function RS:FaneifyTab(frame, sel)
	local i = frame:GetID()
	if(i == SELECTED_CHAT_FRAME:GetID()) then
		updateFS(frame,nil, nil, .5, 1, 1)
	else
		updateFS(frame,nil, nil, 1, 1, 1)
	end
end
RS:SecureHook("FCFTab_UpdateColors", "FaneifyTab")

local function test(self, event, ...)
	if self.glow:IsShown() then
		updateFS(self, nil, nil, 1, 0, 0)
	end
end
hooksecurefunc(CH, "ChatTab_OnUpdate", test)