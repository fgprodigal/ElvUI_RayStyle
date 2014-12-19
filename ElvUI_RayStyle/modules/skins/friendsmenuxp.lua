local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule("Skins")

local function SkinFriendsMenuXP()
	if FriendsMenuXPSecure then
		FriendsMenuXPSecureMenuBackdrop:StripTextures()
		FriendsMenuXPSecureMenuBackdrop:SetTemplate("Transparent")
	end
	if FriendsMenuXP then
		FriendsMenuXPMenuBackdrop:StripTextures()
		FriendsMenuXPMenuBackdrop:SetTemplate("Transparent")
	end
end

S:RegisterSkin("ElvUI", SkinFriendsMenuXP)
