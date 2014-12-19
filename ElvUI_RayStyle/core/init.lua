--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local RS = E:NewModule("RayStyle", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0")
local DT = E:GetModule("DataTexts")
local EP = LibStub("LibElvUIPlugin-1.0")
local addon, ns = ...

E.RS = {}
RS.version = GetAddOnMetadata("ElvUI_RayStyle", "Version")
RS.versionMinE = 7.0
RS.configs = {}
RS.title = "|cff00b3ffRayStyle|r"

E.PopupDialogs["RS_WARNINGVERSION"] = {
	text = L["Your version of ElvUI is older than recommended for use with %s. Please update ElvUI at your earliest convenience."],
	button1 = CLOSE,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

E.PopupDialogs["RS_NEWFEATURE1"] = {
	text = L["It is now possible to create pre-configured profiles for certain addons in order to match the look of %s seen in screenshots.\n\nIf interested then open the %s Install and see page 5 and 6. Do that now?"],
	button1 = L["Yes, thank you!"],
	button2 = L["No, I will do it later."],
	OnAccept = function(self)
		RS:RunSetup()
		E.db.RS.newfeature1_warned = true
	end,
	OnCancel = function(self)
		E.db.RS.newfeature1_warned = true
	end,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

function RS:InsertOptions()
	--Main GUI group
	E.Options.args.RS = {
		order = 100,
		type = "group",
		name = RS.title,
		args = {
			header1 = {
				order = 1,
				type = "header",
				name = format("%s version %s by Ray", RS.title, RS:ColorStr(RS.version)),
			},		
			description1 = {
				order = 2,
				type = "description",
				name = format("%s is an external edit of ElvUI. Any options provided by this edit can be found in the '%s' group on the left.", RS.title, "Options"),
			},
			spacer1 = {
				order = 3,
				type = "description",
				name = "\n\n\n",
			},
			header2 = {
				order = 4,
				type = "header",
				name = RS:ColorStr("Installation"),
			},
			description2 = {
				order = 5,
				type = "description",
				name = format("The installation guide should pop up automatically after you have completed the ElvUI installation. If you wish to re-run the installation process for %s then please click the button below.", RS.title),
			},
			spacer2 = {
				order = 6,
				type = "description",
				name = "",
			},
			install = {
				order = 7,
				type = "execute",
				name = L["Install"],
				desc = L["Run the installation process."],
				func = function() RS:RunSetup(); E:ToggleConfig(); end,
			},
			config = {
				order = 20,
				type = "group",
				name = "Options",
				childGroups = "tab",
				args = {},
			},
		},
	}
	
	--Insert the rest of the configs
	for _, func in pairs(RS.configs) do func() end;
end

function RS:Initialize()
	--Warn about ElvUI version being too low
	if tonumber(E.version) and (tonumber(E.version) < tonumber(RS.versionMinE)) then E:StaticPopup_Show("RS_WARNINGVERSION", RS.title) end

	if E.private.install_complete and E.db.RS.install_version == nil then RS:RunSetup() end
	--Register plugin so options are properly inserted when config is loaded
	EP:RegisterPlugin(addon, RS.InsertOptions)
end

E:RegisterModule(RS:GetName())