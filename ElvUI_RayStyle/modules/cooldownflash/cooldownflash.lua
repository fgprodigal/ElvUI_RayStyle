local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local CF = E:NewModule("CooldownFlash", "AceEvent-3.0", "AceHook-3.0")
local RS = E:GetModule("RayStyle")

local cooldowns, animating, watching = { }, { }, { }
local GetTime = GetTime
local testtable

local DCP = CreateFrame("frame", nil, UIParent)
DCP:SetAlpha(0)
DCP:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
DCP.TextFrame = DCP:CreateFontString(nil, "ARTWORK")
DCP.TextFrame:SetPoint("TOP",DCP,"BOTTOM",0,-5)
DCP.TextFrame:SetWidth(185)
DCP.TextFrame:SetJustifyH("CENTER")
DCP.TextFrame:SetTextColor(1,1,1)

local DCPT = DCP:CreateTexture(nil,"BACKGROUND")
DCPT:SetTexCoord(.08, .92, .08, .92)
DCPT:SetAllPoints(DCP)

-----------------------
-- Utility Functions --
-----------------------
local function tcount(tab)
    local n = 0
    for _ in pairs(tab) do
        n = n + 1
    end
    return n
end

local function GetPetActionIndexByName(name)
    for i=1, NUM_PET_ACTION_SLOTS, 1 do
        if (GetPetActionInfo(i) == name) then
            return i
        end
    end
    return nil
end

--------------------------
-- Cooldown / Animation --
--------------------------
local elapsed = 0
local runtimer = 0
local function OnUpdate(_,update)
    elapsed = elapsed + update
    if (elapsed > 0.05) then
        for i,v in pairs(watching) do
            if (GetTime() >= v[1] + 0.5) then
                local start, duration, enabled, texture, isPet, name
                if (v[2] == "spell") then
                    name = GetSpellInfo(v[3])
                    texture = GetSpellTexture(v[3])
                    start, duration, enabled = GetSpellCooldown(v[3])
                elseif (v[2] == "item") then
                    name = GetItemInfo(i)
                    texture = v[3]
                    start, duration, enabled = GetItemCooldown(i)
                elseif (v[2] == "pet") then
                    texture = select(3,GetPetActionInfo(v[3]))
                    start, duration, enabled = GetPetActionCooldown(v[3])
                    isPet = true
                end
                if (enabled ~= 0) then
                    if (duration and duration > 2.0 and texture) then
                        cooldowns[i] = { start, duration, texture, isPet, name, v[3], v[2] }
                    end
                end
                if (not (enabled == 0 and v[2] == "spell")) then
                    watching[i] = nil
                end
            end
        end
        for i,v in pairs(cooldowns) do
            local start, duration, remaining
            if (v[7] == "spell") then
                start, duration = GetSpellCooldown(v[6])
            elseif (v[7] == "item") then
                start, duration, enabled = GetItemCooldown(i)
            elseif (v[7] == "pet") then
                start, duration, enabled = GetPetActionCooldown(v[6])
            end
            if start == 0 and duration == 0 then
                remaining = 0
            else
                remaining = v[2]-(GetTime()-v[1])
            end
            if (remaining <= 0) then
                tinsert(animating, {v[3],v[4],v[5]})
                cooldowns[i] = nil
            end
        end
        
        elapsed = 0
        if (#animating == 0 and tcount(watching) == 0 and tcount(cooldowns) == 0) then
            DCP:SetScript("OnUpdate", nil)
            return
        end
    end
    
    if (#animating > 0) then
        runtimer = runtimer + update
        if (runtimer > (CF.db.fadeInTime + CF.db.holdTime + CF.db.fadeOutTime)) then
            tremove(animating,1)
            runtimer = 0
			DCP.TextFrame:SetText(nil)
            DCPT:SetTexture(nil)
            DCPT:SetVertexColor(1,1,1)
            DCP:SetAlpha(0)
            DCP:SetSize(CF.db.iconSize, CF.db.iconSize)
        elseif CF.db.enable then
            if (not DCPT:GetTexture()) then
				if (animating[1][3] ~= nil and CF.db.showSpellName) then
					DCP.TextFrame:SetText(animating[1][3])
				end
                DCPT:SetTexture(animating[1][1])
                if animating[1][2] then
                    DCPT:SetVertexColor(unpack(CF.db.petOverlay))
                end
            end
            local alpha = CF.db.maxAlpha
            if (runtimer < CF.db.fadeInTime) then
                alpha = CF.db.maxAlpha * (runtimer / CF.db.fadeInTime)
            elseif (runtimer >= CF.db.fadeInTime + CF.db.holdTime) then
                alpha = CF.db.maxAlpha - ( CF.db.maxAlpha * ((runtimer - CF.db.holdTime - CF.db.fadeInTime) / CF.db.fadeOutTime))
            end
            DCP:SetAlpha(alpha)
            local scale = CF.db.iconSize+(CF.db.iconSize*((CF.db.animScale-1)*(runtimer/(CF.db.fadeInTime+CF.db.holdTime+CF.db.fadeOutTime))))
            DCP:SetWidth(scale)
            DCP:SetHeight(scale)
        end
    end
end

--------------------
-- Event Handlers --
--------------------
function DCP:UNIT_SPELLCAST_SUCCEEDED(unit,spell,rank)
    if (unit == "player") then
        watching[spell] = {GetTime(),"spell",spell.."("..rank..")"}
        self:SetScript("OnUpdate", OnUpdate)
    end
end

function DCP:COMBAT_LOG_EVENT_UNFILTERED(...)
    local _,event,_,_,_,sourceFlags,_,_,_,_,_,spellID = ...
    if (event == "SPELL_CAST_SUCCESS") then
        if (bit.band(sourceFlags,COMBATLOG_OBJECT_TYPE_PET) == COMBATLOG_OBJECT_TYPE_PET and bit.band(sourceFlags,COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
            local name = GetSpellInfo(spellID)
            local index = GetPetActionIndexByName(name)
            if (index and not select(7,GetPetActionInfo(index))) then
                watching[name] = {GetTime(),"pet",index}
            elseif (not index and name) then
                watching[name] = {GetTime(),"spell",name}
            else
                return
            end
            self:SetScript("OnUpdate", OnUpdate)
        end
    end
end

function DCP:PLAYER_ENTERING_WORLD()
    local inInstance,instanceType = IsInInstance()
    if (inInstance and instanceType == "arena") then
        self:SetScript("OnUpdate", nil)
        wipe(cooldowns)
        wipe(watching)
    end
end

function CF:UseAction(slot)
    local actionType,itemID = GetActionInfo(slot)
    if (actionType == "item") then
        local texture = GetActionTexture(slot)
        watching[itemID] = {GetTime(),"item",texture}
        DCP:SetScript("OnUpdate", OnUpdate)
    end
end

function CF:UseInventoryItem(slot)
    local itemID = GetInventoryItemID("player", slot);
    if (itemID) then
        local texture = GetInventoryItemTexture("player", slot)
        watching[itemID] = {GetTime(),"item",texture}
        DCP:SetScript("OnUpdate", OnUpdate)
    end
end

function CF:UseContainerItem(bag,slot)
    local itemID = GetContainerItemID(bag, slot)
    if (itemID) then
        local texture = select(10, GetItemInfo(itemID))
        watching[itemID] = {GetTime(),"item",texture}
        DCP:SetScript("OnUpdate", OnUpdate)
    end
end

function CF:UseItemByName(itemName)
	local itemID
	if itemName then
		itemID = string.match(select(2, GetItemInfo(itemName)), "item:(%d+)")
	end
    if (itemID) then
        local texture = select(10, GetItemInfo(itemID))
        watching[itemID] = {GetTime(),"item",texture}
        DCP:SetScript("OnUpdate", OnUpdate)
    end
end

function CF:EnableCooldownFlash()
    self:SecureHook("UseContainerItem")
    self:SecureHook("UseInventoryItem")
    self:SecureHook("UseAction")
    self:SecureHook("UseItemByName")
    DCP:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    DCP:RegisterEvent("PLAYER_ENTERING_WORLD")
	if self.db.enablePet then
		DCP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end

function CF:DisableCooldownFlash()
    self:Unhook("UseContainerItem")
    self:Unhook("UseInventoryItem")
    self:Unhook("UseAction")
    self:Unhook("UseItemByName")
    DCP:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    DCP:UnregisterEvent("PLAYER_ENTERING_WORLD")
    DCP:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    --DCP:SetScript("OnUpdate", nil)
    --wipe(cooldowns)
    --wipe(watching)
end

function CF:Initialize()
	self.db = E.db.RS.cooldownflash
    DCP:SetSize(CF.db.iconSize, CF.db.iconSize)
    DCP:CreateBackdrop("Default")
    DCP.TextFrame:FontTemplate(nil, 18, "OUTLINE")
	DCP.backdrop:SetAllPoints()
	DCPT:SetInside()
    if self.db.enable then
        self:EnableCooldownFlash()
    end
    DCP:SetPoint("CENTER", UIParent, "CENTER")
	E:CreateMover(DCP, "CooldownFlashMover", L["中部冷却闪光"], true, nil)  
    local spellname, _, icon = GetSpellInfo(16914)
    testtable = { icon, nil, spellname }
end

E:RegisterModule(CF:GetName())

local function CooldownFlashOptions()
	E.Options.args.RS.args.config.args.cooldownflash = {
		order = 1,
		type = "group",
		name = L["中部冷却闪光"],
		args = {
			header = {
				order = 1,
				type = "header",
				name = RS:ColorStr(L["中部冷却闪光"]),
			},
			general = {
				order = 2,
				type = "group",
				name = L["General"],
				guiInline = true,
				get = function(info)
					return E.db.RS.cooldownflash[ info[#info] ]
				end,
				args = {
					enable = {
						order = 4,
						name = L["Enable"],
						type = "toggle",
						set = function(info, v)
							E.db.RS.cooldownflash.enable = v
							if v then
								self:EnableCooldownFlash()
							else
								self:DisableCooldownFlash()
							end
						end
					},
					iconSize = {
						order = 5,
						name = L["图标大小"],
						type = "range",
						min = 30, max = 125, step = 1,
						set = function(info, value) E.db.RS.cooldownflash[ info[#info] ] = value; DCP:SetSize(value, value) end,
						hidden = function() return not E.db.RS.cooldownflash.enable end,
					},
					fadeInTime = {
						order = 6,
						name = L["淡入时间"],
						type = "range",
						min = 0, max = 2.5, step = 0.1,
						get = function(info) return E.db.RS.cooldownflash[ info[#info] ] end,
						set = function(info, value) E.db.RS.cooldownflash[ info[#info] ] = value end,
						hidden = function() return not E.db.RS.cooldownflash.enable end,
					},
					fadeOutTime = {
						order = 7,
						name = L["淡出时间"],
						type = "range",
						min = 0, max = 2.5, step = 0.1,
						get = function(info) return E.db.RS.cooldownflash[ info[#info] ] end,
						set = function(info, value) E.db.RS.cooldownflash[ info[#info] ] = value end,
						hidden = function() return not E.db.RS.cooldownflash.enable end,
					},
					maxAlpha = {
						order = 8,
						name = L["最大透明度"],
						type = "range",
						min = 0, max = 1, step = 0.05,
						isPercent = true,
						get = function(info) return E.db.RS.cooldownflash[ info[#info] ] end,
						set = function(info, value) E.db.RS.cooldownflash[ info[#info] ] = value end,
						hidden = function() return not E.db.RS.cooldownflash.enable end,
					},
					holdTime = {
						order = 9,
						name = L["持续时间"],
						type = "range",
						min = 0, max = 2.5, step = 0.1,
						get = function(info) return E.db.RS.cooldownflash[ info[#info] ] end,
						set = function(info, value) E.db.RS.cooldownflash[ info[#info] ] = value end,
						hidden = function() return not E.db.RS.cooldownflash.enable end,
					},
					animScale = {
						order = 10,
						name = L["动画大小"],
						type = "range",
						min = 0, max = 2, step = 0.1,
						get = function(info) return E.db.RS.cooldownflash[ info[#info] ] end,
						set = function(info, value) E.db.RS.cooldownflash[ info[#info] ] = value end,
						hidden = function() return not E.db.RS.cooldownflash.enable end,
					},
					showSpellName = {
						order = 11,
						name = L["显示法术名称"],
						type = "toggle",
						get = function(info) return E.db.RS.cooldownflash[ info[#info] ] end,
						set = function(info, value) E.db.RS.cooldownflash[ info[#info] ] = value end,
						hidden = function() return not E.db.RS.cooldownflash.enable end,
					},
					enablePet = {
						order = 12,
						name = L["监视宠物技能"],
						type = "toggle",
						get = function(info) return E.db.RS.cooldownflash[ info[#info] ] end,
						set = function(info, value)
							E.db.RS.cooldownflash[ info[#info] ] = value
							if value then
								DCP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
							else
								DCP:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
							end
						end,
						hidden = function() return not E.db.RS.cooldownflash.enable end,
					},
					test = {
						order = 20,
						name = L["测试"],
						type = "execute",
						func = function()
							tinsert(animating,testtable) 
							DCP:SetScript("OnUpdate", OnUpdate) 
						end,
						hidden = function() return not E.db.RS.cooldownflash.enable end,
					}
				},
			},
		},
	}
end

RS.configs["cooldownflash"] = CooldownFlashOptions