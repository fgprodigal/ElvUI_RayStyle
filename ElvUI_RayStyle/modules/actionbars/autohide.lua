local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local AB = E:GetModule("ActionBars")
local RS = E:GetModule("RayStyle")
local AH = RS:NewModule("AutoHide", "AceEvent-3.0", "AceHook-3.0")

local hider = CreateFrame("Frame", "ActionBarHider", UIParent)
hider:Hide()
RegisterStateDriver(hider, "visibility", "[combat][@target,exists][vehicleui]show")

local function pending()
	if UnitAffectingCombat("player") then return true end
	if UnitExists("target") then return true end
	if UnitInVehicle("player") then return true end
	if SpellBookFrame:IsShown() then return true end
	if IsAddOnLoaded("Blizzard_MacroUI") and MacroFrame:IsShown() then return true end
	if HoverBind and HoverBind.active then return true end
end

local function FadeOutActionButton()
	local fadeInfo = {}
	fadeInfo.mode = "OUT"
	fadeInfo.timeToFade = 1
	fadeInfo.finishedFunc = function()
		if InCombatLockdown() or pending() then return end
		ActionBarHider:Hide()
	end
	fadeInfo.startAlpha = ActionBarHider:GetAlpha()
	fadeInfo.endAlpha = 0
	E:UIFrameFade(ActionBarHider, fadeInfo)
end

local function FadeInActionButton()
	if not InCombatLockdown() then
		ActionBarHider:Show()
	end
	E:UIFrameFadeIn(ActionBarHider, 1, ActionBarHider:GetAlpha(), 1)
end

function AH:OnAutoHideEvent(event, addon)
	if event == "ADDON_LOADED" then
		if addon == "Blizzard_MacroUI" then
			self:UnregisterEvent("ADDON_LOADED")
			MacroFrame:HookScript("OnShow", function(self, event)
				FadeInActionButton()
			end)
			MacroFrame:HookScript("OnHide", function(self, event)
				if not pending() then
					FadeOutActionButton()
				end
			end)
		end
	end
	if pending() then
		FadeInActionButton()
	else
		FadeOutActionButton()
	end
end

local function FixActionButtonCooldown(button)
	if not button then return end
	if not button.cooldown then return end
	local name = button:GetName()
	local cooldown = button.cooldown
	local start, duration, enable, charges, maxCharges
	if button.GetCooldown then
		start, duration, enable, charges, maxCharges = button:GetCooldown()
	elseif button.action and button.action > 0 then
		start, duration, enable, charges, maxCharges = GetActionCooldown(button.action)
	end
	if start then
		CooldownFrame_SetTimer(cooldown, start, duration, enable, charges, maxCharges)
	end
end

function AH:EnableAutoHide()
	AH:RegisterEvent("PLAYER_REGEN_ENABLED", "OnAutoHideEvent")
	AH:RegisterEvent("PLAYER_REGEN_DISABLED", "OnAutoHideEvent")
	AH:RegisterEvent("PLAYER_TARGET_CHANGED", "OnAutoHideEvent")
	AH:RegisterEvent("UNIT_ENTERED_VEHICLE", "OnAutoHideEvent")
	AH:RegisterEvent("UNIT_EXITED_VEHICLE", "OnAutoHideEvent")
	AH:RegisterEvent("ADDON_LOADED", "OnAutoHideEvent")

	SpellBookFrame:HookScript("OnShow", function(self, event)
		FadeInActionButton()
	end)

	SpellBookFrame:HookScript("OnHide", function(self, event)
		if not pending() then
			FadeOutActionButton()
		end
	end)
	
	for i = 1, 6 do
		if E.db.RS["actionbar"]["bar"..i] and E.db.RS["actionbar"]["bar"..i].autohide then
			_G["ElvUI_Bar"..i]:SetParent(ActionBarHider)
		end
	end
	
	hooksecurefunc(ActionBarHider, "Show", function(self,alpha)
		for button in pairs(AB["handledbuttons"]) do
			if button then
				FixActionButtonCooldown(button)
			else
				AB["handledbuttons"][button] = nil
			end
		end
	end)
end

hooksecurefunc(AB, "Initialize", AH.EnableAutoHide)