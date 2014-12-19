--[[------------------------------------------------------------
--	RayStyle, an ElvUI edit by Ray
--
--	This file contains initialization code for RayStyle
------------------------------------------------------------]]--
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local LO = E:GetModule("Layout")
local DT = E:GetModule("DataTexts")
local RS = E:GetModule("RayStyle")

local PANEL_HEIGHT = 22;

function RS:LoadDataTexts()
	local db = E.db.RS.datatexts

	for panelName, panel in pairs(DT.RegisteredPanels) do
		for i=1, panel.numPoints do
			local pointIndex = DT.PointLocation[i]
			
			--Register Panel to Datatext
			for name, data in pairs(DT.RegisteredDataTexts) do
				for option, value in pairs(db.panels) do
					if value and type(value) == "table" then
						if option == panelName and db.panels[option][pointIndex] and db.panels[option][pointIndex] == name then
							DT:AssignPanelToDataText(panel.dataPanels[pointIndex], data)
						end
					elseif value and type(value) == "string" and value == name then
						if db.panels[option] == name and option == panelName then
							DT:AssignPanelToDataText(panel.dataPanels[pointIndex], data)
						end
					end
				end
			end
		end
	end
end
hooksecurefunc(DT, "LoadDataTexts", RS.LoadDataTexts)

--Datatext Options
local function DatatextOptions()
	E.Options.args.RS.args.config.args.datatexts = {
		order = 1,
		type = "group",
		name = L["Datatexts"],
		args = {
			header = {
				order = 1,
				type = "header",
				name = RS:ColorStr(L["Datatexts"]),
			},
			panels = {
				order = 3,
				type = "group",
				name = L["Panels"],
				guiInline = true,
				args = {},
			},
		},
	}
	
	local datatexts = {}
	for name, _ in pairs(DT.RegisteredDataTexts) do
		datatexts[name] = name
	end
	datatexts[''] = NONE
	
	local table = E.Options.args.RS.args.config.args.datatexts.args.panels.args
	local i = 0
	for pointLoc, tab in pairs(P.RS.datatexts.panels) do
		i = i + 1
		if not _G[pointLoc] then table[pointLoc] = nil; return; end
		if type(tab) == 'table' then
			table[pointLoc] = {
				type = 'group',
				args = {},
				name = L[pointLoc] or pointLoc,
				guiInline = true,
				order = i,
			}			
			for option, value in pairs(tab) do
				table[pointLoc].args[option] = {
					type = 'select',
					name = L[option] or option:upper(),
					values = datatexts,
					get = function(info) return E.db.RS.datatexts.panels[pointLoc][ info[#info] ] end,
					set = function(info, value) E.db.RS.datatexts.panels[pointLoc][ info[#info] ] = value; DT:LoadDataTexts() end,									
				}
			end
		elseif type(tab) == 'string' then
			table[pointLoc] = {
				type = 'select',
				name = L[pointLoc] or pointLoc,
				values = datatexts,
				get = function(info) return E.db.RS.datatexts.panels[pointLoc] end,
				set = function(info, value) E.db.RS.datatexts.panels[pointLoc] = value; DT:LoadDataTexts() end,
			}						
		end
	end
end
RS.configs['datatexts'] = DatatextOptions