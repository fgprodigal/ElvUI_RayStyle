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
				name = format("%s %s by Ray", RS.title, RS:ColorStr(RS.version)),
			},
			description1 = {
				order = 2,
				type = "description",
				name = format(L['%s是ElvUI的一个外置美化及功能模块。你可以在左边%s下的"%s"里设置参数。'], RS.title, RS.title, "选项"),
			},
			spacer1 = {
				order = 3,
				type = "description",
				name = "\n\n\n",
			},
			header2 = {
				order = 4,
				type = "header",
				name = RS:ColorStr(L["Install"]),
			},
			description2 = {
				order = 5,
				type = "description",
				name = format(L["这个安装向导会在你完成安装ElvUI后自动启动，如果你想重新运行%s安装程序，请点击下面的按钮."], RS.title),
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
				name = "选项",
				childGroups = "tab",
				args = {},
			},
		},
	}
	
	--Insert the rest of the configs
	for _, func in pairs(RS.configs) do func() end;
end

function RS:Initialize()
	if E.private.install_complete and E.db.RS.install_version == nil then RS:RunSetup() end
	EP:RegisterPlugin(addon, RS.InsertOptions)
end

E:RegisterModule(RS:GetName())