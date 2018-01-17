----------------------------------------------------
-- Interrupt Bar by Kollektiv
----------------------------------------------------

InterruptBarDB = InterruptBarDB or { scale = 1, hidden = false, lock = false, }
local abilities
local order
local locale = GetLocale()
local band = bit.band

if locale == "enUS" or locale == "enGB" then
	abilities = {
		["Pummel"] = {icon="Interface\\Icons\\INV_Gauntlets_04", duration = 10},
		["Counterspell - Silenced"] = {icon="Interface\\Icons\\Spell_Frost_IceShock",duration = 24},
		["Spell Lock"] = {icon="Interface\\Icons\\Spell_Shadow_MindRot",duration = 24},
		["Feral Charge Effect"] = {icon="Interface\\Icons\\Ability_Hunter_Pet_Bear",duration = 15},
		["Kick"] = {icon="Interface\\Icons\\Ability_Kick",duration = 10},
	}
	order = {"Counterspell - Silenced","Spell Lock", "Pummel", "Kick", "Feral Charge Effect"}
elseif locale == "koKR" then
	abilities = {
		["자루 공격"] = {icon="Interface\\Icons\\INV_Gauntlets_04", duration = 10},
		["마법 차단 - 침묵"] = {icon="Interface\\Icons\\Spell_Frost_IceShock",duration = 24},
		["주문 잠금"] = {icon="Interface\\Icons\\Spell_Shadow_MindRot",duration = 24},
		["야성의 돌진"] = {icon="Interface\\Icons\\Ability_Hunter_Pet_Bear",duration = 15},
		["발차기"] = {icon="Interface\\Icons\\Ability_Kick",duration = 10},
	}
	order = {"마법 차단 - 침묵","주문 잠금", "자루 공격", "발차기", "야성의 돌진"}

elseif locale == "deDE" then
	abilities = {
		["Zuschlagen"] = {icon="Interface\\Icons\\INV_Gauntlets_04", duration = 10},
		["Gegenzauber - zum Schweigen gebracht"] = {icon="Interface\\Icons\\Spell_Frost_IceShock",duration = 24},
		["Zaubersperre"] = {icon="Interface\\Icons\\Spell_Shadow_MindRot",duration = 24},
		["Wilde Attacke - Effekt"] = {icon="Interface\\Icons\\Ability_Hunter_Pet_Bear",duration = 15},
		["Tritt"] = {icon="Interface\\Icons\\Ability_Kick",duration = 10},
	}
	order = {"Gegenzauber - zum Schweigen gebracht","Zaubersperre", "Zuschlagen", "Tritt", "Wilde Attacke - Effekt"}

elseif locale == "frFR" then
	abilities = {
		["Volée de coups"] = {icon="Interface\\Icons\\INV_Gauntlets_04", duration = 10},
		["Contresort - Silencieux"] = {icon="Interface\\Icons\\Spell_Frost_IceShock",duration = 24},
		["Verrou magique"] = {icon="Interface\\Icons\\Spell_Shadow_MindRot",duration = 24},
		["Effet de Charge farouche"] = {icon="Interface\\Icons\\Ability_Hunter_Pet_Bear",duration = 15},
		["Coup de pied"] = {icon="Interface\\Icons\\Ability_Kick",duration = 10},
	}
	order = {"Contresort - Silencieux","Verrou magique", "Volée de coups", "Coup de pied", "Effet de Charge farouche"}
elseif locale == "esES" then
	abilities = {
		["Zurrar"] = {icon="Interface\\Icons\\INV_Gauntlets_04", duration = 10},
		["Contrahechizo: silenciado"] = {icon="Interface\\Icons\\Spell_Frost_IceShock",duration = 24},
		["Bloqueo de hechizo"] = {icon="Interface\\Icons\\Spell_Shadow_MindRot",duration = 24},
		["Efecto de Carga feral"] = {icon="Interface\\Icons\\Ability_Hunter_Pet_Bear",duration = 15},
		["Patada"] = {icon="Interface\\Icons\\Ability_Kick",duration = 10},
	}
	order = {"Contrahechizo: silenciado","Bloqueo de hechizo", "Zurrar", "Patada", "Efecto de Carga feral"}
else
	ChatFrame1:AddMessage("InterruptBar: 지원하지 않는 언어입니다.")
--	ChatFrame1:AddMessage("InterruptBar: Unsupported language")
	return
end

local frame
local bar

local GetTime = GetTime
local ipairs = ipairs
local pairs = pairs
local select = select
local floor = floor
local band = bit.band
local GetSpellInfo = GetSpellInfo

local GROUP_UNITS = bit.bor(0x00000010, 0x00000400)

local activetimers = {}

local size = 0
local function getsize()
	size = 0
	for k in pairs(activetimers) do
		size = size + 1
	end
end

local function InterruptBar_AddIcons()
	local x = -45
	for _,ability in ipairs(order) do
		local btn = CreateFrame("Frame",nil,bar)
		btn:SetWidth(30)
		btn:SetHeight(30)
		btn:SetPoint("CENTER",bar,"CENTER",x,0)
		btn:SetFrameStrata("LOW")
		
		local cd = CreateFrame("Cooldown",nil,btn)
		cd:SetAllPoints(true)
		cd:SetFrameStrata("MEDIUM")
		cd:Hide()
		
		local texture = btn:CreateTexture(nil,"BACKGROUND")
		texture:SetAllPoints(true)
		texture:SetTexture(abilities[ability].icon)
		texture:SetTexCoord(0.07,0.9,0.07,0.90)
	
		local text = cd:CreateFontString(nil,"ARTWORK")
		text:SetFont(STANDARD_TEXT_FONT,18,"OUTLINE")
		text:SetTextColor(1,1,0,1)
		text:SetPoint("LEFT",btn,"LEFT",2,0)
		
		btn.texture = texture
		btn.text = text
		btn.duration = abilities[ability].duration
		btn.cd = cd
		
		bar[ability] = btn
		
		x = x + 30
	end
end

local function InterruptBar_SavePosition()
	local point, _, relativePoint, xOfs, yOfs = bar:GetPoint()
	if not InterruptBarDB.Position then 
		InterruptBarDB.Position = {}
	end
	InterruptBarDB.Position.point = point
	InterruptBarDB.Position.relativePoint = relativePoint
	InterruptBarDB.Position.xOfs = xOfs
	InterruptBarDB.Position.yOfs = yOfs
end

local function InterruptBar_LoadPosition()
	if InterruptBarDB.Position then
		bar:SetPoint(InterruptBarDB.Position.point,UIParent,InterruptBarDB.Position.relativePoint,InterruptBarDB.Position.xOfs,InterruptBarDB.Position.yOfs)
	else
		bar:SetPoint("CENTER", UIParent, "CENTER")
	end
end

local function InterruptBar_UpdateBar()
	bar:SetScale(InterruptBarDB.scale)
	if InterruptBarDB.hidden then
		for _,v in ipairs(order) do bar[v]:Hide() end
	else
		for _,v in ipairs(order) do bar[v]:Show() end
	end
	if InterruptBarDB.lock then
		bar:EnableMouse(false)
	else
		bar:EnableMouse(true)
	end
end

local function InterruptBar_CreateBar()
	bar = CreateFrame("Frame", nil, UIParent)
	bar:SetMovable(true)
	bar:SetWidth(120)
	bar:SetHeight(30)
	bar:SetClampedToScreen(true) 
	bar:SetScript("OnMouseDown",function(self,button) if button == "LeftButton" then self:StartMoving() end end)
	bar:SetScript("OnMouseUp",function(self,button) if button == "LeftButton" then self:StopMovingOrSizing() InterruptBar_SavePosition() end end)
	bar:Show()
	
	InterruptBar_AddIcons()
	InterruptBar_UpdateBar()
	InterruptBar_LoadPosition()
end

local function InterruptBar_UpdateText(text,cooldown)
	if cooldown < 10 then 
		if cooldown <= 0.5 then
			text:SetText("")
		else
			text:SetFormattedText(" %d",cooldown)
		end
	else
		text:SetFormattedText("%d",cooldown)
	end
	if cooldown < 6 then 
		text:SetTextColor(1,0,0,1)
	else 
		text:SetTextColor(1,1,0,1) 
	end
end

local function InterruptBar_StopAbility(ref,ability)
	if InterruptBarDB.hidden then ref:Hide() end
	if activetimers[ability] then activetimers[ability] = nil end
	ref.text:SetText("")
	ref.cd:Hide()
end

local time = 0
local function InterruptBar_OnUpdate(self, elapsed)
	time = time + elapsed
	if time > 0.25 then
		getsize()
		for ability,ref in pairs(activetimers) do
			ref.cooldown = ref.start + ref.duration - GetTime()
			if ref.cooldown <= 0 then
				InterruptBar_StopAbility(ref,ability)
			else 
				InterruptBar_UpdateText(ref.text,floor(ref.cooldown+0.5))
			end
		end
		if size == 0 then frame:SetScript("OnUpdate",nil) end
		time = time - 0.25
	end
end

local function InterruptBar_StartTimer(ref,ability)
	if InterruptBarDB.hidden then
		ref:Show()
	end
	if not activetimers[ability] then
		activetimers[ability] = ref
		ref.cd:Show()
		ref.cd:SetCooldown(GetTime()-0.40,ref.duration)
		ref.start = GetTime()
		InterruptBar_UpdateText(ref.text,ref.duration)
	end
	frame:SetScript("OnUpdate",InterruptBar_OnUpdate)
end

local eventtypes = {["RANGE_DAMAGE"] = 1,["RANGE_MISSED"] = 1,["SPELL_MISSED"] = 1,["SPELL_CAST_SUCCESS"] = 1,["SPELL_INTERRUPT"] = 1,}

local function InterruptBar_COMBAT_LOG_EVENT_UNFILTERED(...)
	local _, eventtype, srcName, srcFlags, dstName, dstFlags
	local unit, spellID
	local ability
	return function(...)
		_, eventtype, _, srcName, srcFlags, _, dstName, dstFlags = ...
		if (band(srcFlags, 0x00000040) == 0x00000040 and eventtypes[eventtype]) or (eventtype == "SPELL_AURA_APPLIED" and band(dstFlags,GROUP_UNITS) == GROUP_UNITS) then 
			spellID = select(9,...)
		else
			return
		end
		if spellID == 2139 then spellID = 18469 end -- Counterspell -> Counterspell - Silenced
		ability = GetSpellInfo(spellID)
		if abilities[ability] then
			InterruptBar_StartTimer(bar[ability],ability)
		end
	end
end

InterruptBar_COMBAT_LOG_EVENT_UNFILTERED = InterruptBar_COMBAT_LOG_EVENT_UNFILTERED()

local function InterruptBar_ResetAllTimers()
	for _,ability in ipairs(order) do
		InterruptBar_StopAbility(bar[ability])
	end
	active = 0
end

local function InterruptBar_PLAYER_ENTERING_WORLD(self)
	InterruptBar_ResetAllTimers()
end

local function InterruptBar_Reset()
	InterruptBarDB = { scale = 1, hidden = false, lock = false }
	InterruptBar_UpdateBar()
	InterruptBar_LoadPosition()
end

local function InterruptBar_Test()
	for _,ability in ipairs(order) do
		InterruptBar_StartTimer(bar[ability],ability)
	end
end

local cmdfuncs = {
	scale = function(v) InterruptBarDB.scale = v; InterruptBar_UpdateBar() end,
	hidden = function() InterruptBarDB.hidden = not InterruptBarDB.hidden; InterruptBar_UpdateBar() end,
	lock = function() InterruptBarDB.lock = not InterruptBarDB.lock; InterruptBar_UpdateBar() end,
	reset = function() InterruptBar_Reset() end,
	test = function() InterruptBar_Test() end,
}

local cmdtbl = {}
function InterruptBar_Command(cmd)
	for k in ipairs(cmdtbl) do
		cmdtbl[k] = nil
	end
	for v in gmatch(cmd, "[^ ]+") do
  	tinsert(cmdtbl, v)
  end
  local cb = cmdfuncs[cmdtbl[1]] 
  if cb then
  	local s = tonumber(cmdtbl[2])
  	cb(s)
  else
  	ChatFrame1:AddMessage("InterruptBar 옵션 | /ib <옵션>",0,1,0)  	
  	ChatFrame1:AddMessage("-- scale <수치> | 값: " .. InterruptBarDB.scale,0,1,0)
  	ChatFrame1:AddMessage("-- hidden (전환) | 값: " .. tostring(InterruptBarDB.hidden),0,1,0)
  	ChatFrame1:AddMessage("-- lock (전환) | 값: " .. tostring(InterruptBarDB.lock),0,1,0)
  	ChatFrame1:AddMessage("-- test (실행)",0,1,0)
  	ChatFrame1:AddMessage("-- reset (실행)",0,1,0)
--  	ChatFrame1:AddMessage("InterruptBar Options | /ib <option>",0,1,0)  	
--  	ChatFrame1:AddMessage("-- scale <number> | value: " .. InterruptBarDB.scale,0,1,0)
--  	ChatFrame1:AddMessage("-- hidden (toggle) | value: " .. tostring(InterruptBarDB.hidden),0,1,0)
--  	ChatFrame1:AddMessage("-- lock (toggle) | value: " .. tostring(InterruptBarDB.lock),0,1,0)
--  	ChatFrame1:AddMessage("-- test (execute)",0,1,0)
--  	ChatFrame1:AddMessage("-- reset (execute)",0,1,0)
  end
end

local function InterruptBar_OnLoad(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	if not InterruptBarDB.scale then InterruptBarDB.scale = 1 end
	if not InterruptBarDB.hidden then InterruptBarDB.hidden = false end
	if not InterruptBarDB.lock then InterruptBarDB.lock = false end
	InterruptBar_CreateBar()
	
	SlashCmdList["InterruptBar"] = InterruptBar_Command
	SLASH_InterruptBar1 = "/ib"
	
	ChatFrame1:AddMessage("Kollektiv에 의해 만들어진 Interrupt 바 입니다. 옵션에 대해 /ib를 입력하세요.",0,1,0)
--	ChatFrame1:AddMessage("Interrupt Bar by Kollektiv. Type /ib for options.",0,1,0)
end

local eventhandler = {
	["VARIABLES_LOADED"] = function(self) InterruptBar_OnLoad(self) end,
	["PLAYER_ENTERING_WORLD"] = function(self) InterruptBar_PLAYER_ENTERING_WORLD(self) end,
	["COMBAT_LOG_EVENT_UNFILTERED"] = function(self,...) InterruptBar_COMBAT_LOG_EVENT_UNFILTERED(...) end,
}

local function InterruptBar_OnEvent(self,event,...)
	eventhandler[event](self,...)
end

frame = CreateFrame("Frame",nil,UIParent)
frame:SetScript("OnEvent",InterruptBar_OnEvent)
frame:RegisterEvent("VARIABLES_LOADED")