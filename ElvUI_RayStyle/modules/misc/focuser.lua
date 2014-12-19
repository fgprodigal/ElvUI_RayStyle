local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local M = E:GetModule("Misc")
local RS = E:GetModule("RayStyle")

function RS:LoadMisc_Focuser()
	local modifier = "shift" -- shift, alt or ctrl
	local mouseButton = "1" -- 1 = left, 2 = right, 3 = middle, 4 and 5 = thumb buttons if there are any
	local waitforHook = {}
	local FocuserButton = CreateFrame("CheckButton", "FocuserButton", UIParent, "SecureActionButtonTemplate")
	FocuserButton:SetAttribute("type1","macro")
	FocuserButton:SetAttribute("macrotext","/focus mouseover")
	SetOverrideBindingClick(FocuserButton, true, modifier.."-BUTTON"..mouseButton, "FocuserButton")

	local function SetFocusHotkey(frame)
		if InCombatLockdown() then
			if not frame.FocuserHooked then
				waitforHook[frame] = true
			end
		else
			if not frame.FocuserHooked then
				frame:SetAttribute(modifier.."-type"..mouseButton,"focus")
				frame.FocuserHooked = true
			end
			waitforHook[frame] = nil
		end
	end

	local function HookOuf()
		for _, object in pairs(ElvUF.objects) do
			SetFocusHotkey(object)
		end
	end

	local eventFrame = CreateFrame("Frame", nil)
	eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
	eventFrame:SetScript("OnEvent", function(self, event)
		if event == "GROUP_ROSTER_UPDATE" then
			HookOuf()
		end
		if not InCombatLockdown() then
			for frame in pairs(waitforHook) do
				SetFocusHotkey(frame)
			end
		end
	end)
	HookOuf()
end

hooksecurefunc(M, "Initialize", RS.LoadMisc_Focuser)