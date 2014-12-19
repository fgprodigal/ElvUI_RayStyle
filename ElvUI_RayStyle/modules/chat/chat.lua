local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local CH = E:GetModule("Chat")
local RS = E:GetModule("RayStyle")

local function StyleChat()
	for _, frameName in pairs(CHAT_FRAMES) do
		local cf = _G[frameName]
		_G[frameName.."EditBoxLanguage"]:Kill()
	end
end
hooksecurefunc(CH, "StyleChat", StyleChat)