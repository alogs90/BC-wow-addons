Gladdy = LibStub("AceAddon-3.0"):NewAddon("Gladdy", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0", "AceComm-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("Gladdy", true)

local db, lastInstance, auras
local arenaUnits = {}
local arenaSpecs = {}
local arenaGUID = {}

local DRTIME = 15

local DRINK_SPELL = GetSpellInfo(46755)
local RESURRECTION_SPELLS = {
	[GetSpellInfo(20770)] = true,
	[GetSpellInfo(20773)] = true,
	[GetSpellInfo(20777)] = true,
}

_G["PowerBarColor"] = setmetatable({
    [0] = {r = 0.18, g = .44, b = .75, a = 1},
    [1] = {r = 1, g = 0, b = 0, a = 1},
    [3] = {r = 1, g = 1, b = 0, a = 1},
},{
    __index = function(self, key)
        return self[0]
    end
})

function Gladdy:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("GladdyDB", self:GetDefaults(), "Default")
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	db = self.db.profile

	self.buttons = {}
	self.currentBracket = nil
	self.currentUnit = 1

	for i=1, 5 do
		arenaUnits["arena" .. i] = "playerUnit"
	end

	if ( db.cliqueSupport and IsAddOnLoaded("Clique") ) then
		for i=1, 5 do
			self.buttons["arena" .. i] = self:CreateButton(i)
		end

		ClickCastFrames = ClickCastFrames or {}
		ClickCastFrames[GladdyButton1] = true
		ClickCastFrames[GladdyButton2] = true
		ClickCastFrames[GladdyButton3] = true
		ClickCastFrames[GladdyButton4] = true
		ClickCastFrames[GladdyButton5] = true
	end
    
    BINDING_HEADER_GLADDY = L["Gladdy"]
    BINDING_NAME_GLADDYTRINKET1 = L["Trinked used enemy #1"]
    BINDING_NAME_GLADDYTRINKET2 = L["Trinked used enemy #2"]
    BINDING_NAME_GLADDYTRINKET3 = L["Trinked used enemy #3"]
    BINDING_NAME_GLADDYTRINKET4 = L["Trinked used enemy #4"]
    BINDING_NAME_GLADDYTRINKET5 = L["Trinked used enemy #5"]

	self.specBuffs = self:GetSpecBuffList()
	self.specSpells = self:GetSpecSpellList()

	self.drSpells = self:GetDRList()
	self.drSpellIds = {}
	self.drSpellTextures = {}
	for spellId, spellType in pairs(self.drSpells) do
      	local spellName, _, texture = GetSpellInfo(spellId)
      	self.drSpellIds[spellName] = spellType
      	self.drSpellTextures[spellName] = texture
	end
	self.drTime = setmetatable({ "1/2", "1/4", "0" },{
        __index = function() return "1/2" end
    })

	self:SetupOptions()
end

function Gladdy:OnProfileChanged()
	db = self.db.profile
	self:HideFrame()
	self:ToggleFrame(5)
end

function Gladdy:OnEnable()
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
    
    self:RegisterComm("Gladdy")

	if (not db.locked and db.x == 0 and db.y == 0) then
		self:Print(L["Welcome to Gladdy!"])
		self:Print(L["First launch detected, displaying test frame"])
		self:Print(L["Valid slash commands are:"])
		self:Print("/gladdy ui")
		self:Print("/gladdy test1-5")
        self:Print("/gladdy trinket")
		self:Print("/gladdy hide")
		self:Print(L["If it not first launch, then move or lock frame"])
		self:OnProfileChanged()
	end
end

function Gladdy:ZONE_CHANGED_NEW_AREA()
	self:ClearAllUnits()

	local zone = select(2, IsInInstance())
	if (zone == "arena") then
		self:JoinedArena()
	elseif (zone ~= "arena" and lastInstance == zone) then
	 	self:LeftArena()
	end
	lastInstance = zone
end

function Gladdy:ClearAllUnits()
    for k, v in pairs(self.buttons) do
		if ( v.trinketFrame ) then
			v.trinketFrame:SetScript("OnUpdate", nil)
		end
        
		CooldownFrame_SetTimer(v.cooldownFrame, 1, 1, 1)
			
		v.gridTrinket:SetBackdropColor(0,1,0,1)
			
		v.trinket:SetText("")
    
		v.GUID = nil
		v.enemyAnnounced = false
		v.spells = {}
		v.diminishingReturn = {}
		v:SetAlpha(0)
		
		v.leaderBorder:Hide()
		
		v.click = false		
		for _, click in pairs(db.attributes) do
			local attr = click.modifier .. "macrotext" .. click.button
			v.secure:SetAttribute(attr, "")
		end

        for i=1, 16 do
            local DrIcon= v.drCooldownFrame["icon" .. i] 
            DrIcon:SetAlpha(0)
			if (DrIcon.text:GetText()) then
				DrIcon.text:SetText("")
			end
            if (DrIcon.timeLeftText:GetText()) then
                DrIcon.timeLeftText:SetText("")
            end
        end
	end

	arenaGUID = {}
	for i=1,5 do arenaSpecs["arena" .. i] = nil end

	self.currentBracket = nil
    self.currentUnit = 1
end

function Gladdy:ConvertAuraList()
	auras = {}
	for _, aura in pairs(self.db.profile.auras) do
		if ( not aura.deleted ) then
			auras[aura.name] = aura.priority
		end
	end
end

function Gladdy:LeftArena()
	self:HideFrame()
    self:CancelAllTimers()
end

function Gladdy:JoinedArena()
    self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_HEALTH")
    self:RegisterEvent("UNIT_MANA", "UNIT_POWER")
    self:RegisterEvent("UNIT_RAGE", "UNIT_POWER")
    self:RegisterEvent("UNIT_ENERGY", "UNIT_POWER")
    self:RegisterEvent("UNIT_DISPLAYPOWER")
    self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_STOP")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_DELAYED")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_STOP")
	
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_FOCUS_CHANGED")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("UNIT_TARGET")

	self:ScheduleRepeatingTimer("RefreshFrame", 0.1, self)
    self:ScheduleRepeatingTimer("Sync", 1, self)

	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, _, _, _, _, teamSize = GetBattlefieldStatus(i)
		if (status == "active" and teamSize > 0) then
			self.currentBracket = teamSize
			break
		end
	end

	for i=1, (self.currentBracket or 5) do
		local unit = "arena" .. i
		local button = self.buttons[unit]

		if (not button) then
			button = self:CreateButton(i)
			self.buttons[unit] = button
		end
	end

	self.frame.testing = false
	self:UpdateFrame()
	self:UpdateBindings()
	self.frame:Show()
end

function Gladdy:Test()
    for i=1, self.currentBracket do
		local unit = "arena" .. i
		if (not self.buttons[unit]) then
			self.buttons[unit] = self:CreateButton(i)
		end
	end
    
    for i=1, self.currentBracket do
        local unit = "arena" .. i
		local button = self.buttons[unit]
		
		local class, race, sex, classLoc, raceLoc, health, mana, manaMax, manaPercentage, healthMax, healthActual
		if (i == 1) then
		
			arenaGUID[UnitGUID("player")] = "arena1"
			
			classLoc, class = UnitClass("player")
			raceLoc, race = UnitRace("player")
			sex = UnitSex("player")
			button.GUID = UnitGUID("player")
			button.name = UnitName("player")
			button.powerType = UnitPowerType("player")
			button.classLoc = classLoc
			button.class = class
			button.raceLoc = raceLoc
			self:UpdateAttributes("arena1")
			health = math.floor((UnitHealth("player")/UnitHealthMax("player")) * 100)
			healthMax = UnitHealthMax("player")
			healthActual = UnitHealth("player")
			manaMax = UnitManaMax("player")
			mana = UnitMana("player")
			manaPercentage = math.floor((UnitMana("player")/UnitManaMax("player")) * 100)
		else
			class, race, sex = "DRUID", "TAUREN", 2
			classLoc, raceLoc = "Druid", "Tauren"	
			button.name = L["Arena "] .. i
			button.GUID = "testframe"
			button.powerType = 0
			button.classLoc = classLoc
			button.class = class
			button.raceLoc = raceLoc
			manaMax = 13000
			health, mana = 100-(i^2 * 2), manaMax-(i^5)
			healthMax = 20000
			healthActual = healthMax * health/100
			manaPercentage = math.floor((mana/manaMax) * 100)
		end
        
        if ( db.enemyAnnounce ) then
			self:SendAnnouncement(button.name .. " - " .. classLoc, RAID_CLASS_COLORS[class])
		end
        
        button.manaMax = manaMax
		button.manaActual = mana
		button.manaPercentage = manaPercentage
		
		button.healthPercentage = health
		button.healthActual = healthActual
		button.healthMax = healthMax
		
		button.castBar:SetMinMaxValues(0,i)
		button.castBar:SetValue(i-0.5)
		button.castBar.spellText:SetText("Example Spell (Rank " .. i .. ")")
		button.castBar.timeText:SetText(i-0.5)
		button.castBar.icon:SetTexture(select(3, GetSpellInfo(1)))
        
        self:AuraGain("arena1", GetSpellInfo(45438), select(3, GetSpellInfo(45438)), 10, 3)
        
        button.text:SetText(button.name)
		button.health:SetValue(health)
		button.mana:SetValue(manaPercentage)
        
        if (not db.classText and not db.specText) then
			button.classText:Hide()
		end
		
		if (not db.manaText) then
			button.manaText:Hide()
		end
        
        if (button.powerType == 0 and not db.manaDefault) then
			button.mana:SetStatusBarColor(db.manaColor.r, db.manaColor.g, db.manaColor.b, db.manaColor.a)
		elseif (button.powerType == 1 and not db.rageDefault) then
			button.mana:SetStatusBarColor(db.rageColor.r, db.rageColor.g, db.rageColor.b, db.rageColor.a)
		elseif (button.powerType == 3 and not db.energyDefault) then
			button.mana:SetStatusBarColor(db.energyColor.r, db.energyColor.g, db.energyColor.b, db.energyColor.a)
		else
			button.mana:SetStatusBarColor(PowerBarColor[button.powerType].r, PowerBarColor[button.powerType].g, PowerBarColor[button.powerType].b)
		end
        
        if (db.healthBarClassColor) then
            button.health:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b, 1.0)
        else
            button.health:SetStatusBarColor(db.healthBarColor.r, db.healthBarColor.g, db.healthBarColor.b)
        end
        
        button.classIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
		button.classIcon:SetTexCoord(unpack(CLASS_BUTTONS[class]))
		button.classIcon:SetAlpha(1)
		button:SetAlpha(1)
    end
end

function Gladdy:SendAnnouncement(text, color)
    local color = color or { r = 1, g = 1, b = 1 }
	local dest = dest or db.announceType
	
	if (dest == "self") then
        self:Print(text)
    end
	
	if( dest == "rw" and not IsRaidLeader() and not IsRaidOfficer() and GetRealNumRaidMembers() > 0 ) then
		dest = "party"
	end
	
	-- party chat
	if ( dest == "party" and (GetRealNumPartyMembers() > 0 or GetRealNumRaidMembers() > 0) ) then
		SendChatMessage(text, "PARTY")
	
	-- say
	elseif ( dest == "say" ) then
		SendChatMessage(text, "SAY")
		
	-- raid warning
	elseif ( dest == "rw" ) then
		SendChatMessage(text, "RAID_WARNING")
		
	-- floating combat text
	elseif ( dest == "fct" and IsAddOnLoaded("Blizzard_CombatText") ) then
		CombatText_AddMessage(text, COMBAT_TEXT_SCROLL_FUNCTION, color.r, color.g, color.b)
		
	-- MikScrollingBattleText	
	elseif ( dest == "msbt" and IsAddOnLoaded("MikScrollingBattleText") ) then 
		MikSBT.DisplayMessage(text, MikSBT.DISPLAYTYPE_NOTIFICATION, true, color.r * 255, color.g * 255, color.b * 255)
		
	-- Scrolling Combat Text
	elseif ( dest == "sct" and IsAddOnLoaded("sct") ) then
		SCT:DisplayText(text, color, true, "event", 1)
	
	-- Parrot
	elseif ( dest == "parrot" and IsAddOnLoaded("parrot") ) then
        Parrot:ShowMessage(text, "Notification", true, color.r, color.g, color.b)
	
    -- SpellAlert
    elseif ( dest == "sa" and IsAddOnLoaded("SpellAlert") ) then
        SpellAlert:DisplayText(text, color)
    end
end

function Gladdy:UNIT_AURA(event, uid)
    local unit = arenaGUID[UnitGUID(uid)]
	if (arenaUnits[unit] == "playerUnit") then
		local button = self.buttons[unit]
		if (not button) then return end

		local aura = button.auraFrame
		local index = 1
		local priority = 0
		local auraName, auraIcon, auraExpTime

		while (true) do
        	local name, _, icon, _, _, expTime = UnitBuff(uid, index)
        	if (not name) then break end

        	if (auras[name] and auras[name] >= priority) then
        		auraName = name
        		auraIcon = icon
        		auraExpTime = expTime or 0
        		priority = auras[name]
        	end

        	self:DetectSpec(unit, self.specBuffs[name])

        	if ( name == DRINK_SPELL and db.drinkAnnounce and ( not button.drinkThrottle or GetTime() > button.drinkThrottle )) then
				self:SendAnnouncement(string.format(L["DRINKING: %s (%s)"], button.name, button.classLoc), RAID_CLASS_COLORS[button.class])
				button.drinkThrottle = GetTime() + 3 -- limit the spamming of announcements
			end

        	index = index + 1
		end

		index = 1

		while (true) do
        	local name, _, icon, _, _, _, expTime = UnitDebuff(uid, index)
        	if (not name) then break end

        	if (auras[name] and auras[name] >= priority) then
        		auraName = name
        		auraIcon = icon
        		auraExpTime = expTime or 0
        		priority = auras[name]
        	end

        	index = index + 1
		end

		if ( auraName ) then -- Aura found?
            -- Buff check
            if ( self:IsBuff(auraName) and ( self.buttons[unit].auraFrame.name ~= auraName ) ) then
                auraExpTime = self:GetDuration(auraName)
            end
            
            -- Display it!
			self:AuraGain(unit, auraName, auraIcon, auraExpTime, priority) 
		elseif ( not auraName and aura.auraActive ) then -- No aura found and one is active?
			self:AuraFades(aura) -- Have it fade.
		end
	end
end

function Gladdy:UNIT_HEALTH(event, uid)
    local unit = arenaGUID[UnitGUID(uid)]
    
    local button = self.buttons[unit]
		if(not button) then return end
		
		if(not UnitIsDeadOrGhost(uid)) then
			local currentHealth, maxHealth = UnitHealth(uid), UnitHealthMax(uid)
			local healthPercent = math.floor((currentHealth / maxHealth) * 100)
			local healthText
			
			if ( db.healthActual ) then
				healthText = db.shortHpMana and currentHealth > 9999 and string.format("%.1fk", (currentHealth / 1000)) or currentHealth  
			end
			
			if ( db.healthMax ) then
				local text = db.shortHpMana and maxHealth > 9999 and string.format("%.1fk", (maxHealth / 1000)) or maxHealth
				if ( healthText ) then
					healthText = string.format("%s/%s", healthText, text)
				else
					healthText = text
				end
			end
			
			if ( db.healthPercentage) then
				if ( healthText ) then
					healthText = string.format("%s (%d%%)", healthText, healthPercent)
				else
					healthText = string.format("%d%%", healthPercent)
				end		
			end
		
			button.healthText:SetText(healthText)
			button.health:SetValue(healthPercent)
            
            -- For Sync() method
            button.__currentHealth = currentHealth
            button.__maxHealth = maxHealth
			
			-- display low health announcement
			if ( db.lowHealthAnnounce and healthPercent <= db.lowHealthPercentage and not button.lowHealth and (not button.healthThrottle or GetTime() > button.healthThrottle) and button.name ) then
				local text = string.format(L["LOW HEALTH: %s"], button.name)
				self:SendAnnouncement(text, RAID_CLASS_COLORS[button.class])
				button.lowHealth = true
				button.healthThrottle = GetTime() + 5
			end
			
			-- reset the lowHealth announcement
			if ( button.lowHealth and healthPercent > db.lowHealthPercentage ) then
				button.lowHealth = false
			end
		else
			button.healthText:SetText("DEAD")
			button.health:SetValue(0)
			button:SetAlpha(0.5)
		end
end

function Gladdy:UNIT_POWER(event, uid)
    local unit = arenaGUID[UnitGUID(uid)]
    
    if ( arenaUnits[unit] == "playerUnit" and not UnitIsDeadOrGhost(uid) ) then
		local button = self.buttons[unit]		
		if(not button) then return end
		
		local currentMana, maxMana = UnitMana(uid), UnitManaMax(uid)
		local manaPercent = math.floor((currentMana/maxMana) * 100)
		local manaText
        
        -- For Sync() method
        button.__currentMana = currentMana
        button.__maxMana = maxMana
		
		if ( db.manaActual ) then
			manaText = db.shortHpMana and currentMana > 9999 and string.format("%.1fk", (currentMana / 1000)) or currentMana  
		end
		
		if ( db.manaMax ) then
			local text = db.shortHpMana and maxMana > 9999 and string.format("%.1fk", (maxMana / 1000)) or maxMana
			if ( manaText ) then
				manaText = string.format("%s/%s", manaText, text)
			else
				manaText = text
			end
		end
		
		if ( db.manaPercentage ) then
			if ( manaText ) then
				manaText = string.format("%s (%d%%)", manaText, manaPercent)
			else
				manaText = string.format("%d%%", manaPercent)
			end		
		end
		
		button.manaText:SetText(manaText)
		button.mana:SetValue(manaPercent)
	end
end

function Gladdy:UNIT_DISPLAYPOWER(event, uid)
    local unit = arenaGUID[UnitGUID(uid)]
    
    if (arenaUnits[unit] == "playerUnit") then
		local button = self.buttons[unit]		
		if(not button) then return end
		
		button.powerType = UnitPowerType(uid)
		if (button.powerType == 0 and not db.manaDefault) then
			button.mana:SetStatusBarColor(db.manaColor.r, db.manaColor.g, db.manaColor.b, db.manaColor.a)
		elseif (button.powerType == 1 and not db.rageDefault) then
			button.mana:SetStatusBarColor(db.rageColor.r, db.rageColor.g, db.rageColor.b, db.rageColor.a)
		elseif (button.powerType == 3 and not db.energyDefault) then
			button.mana:SetStatusBarColor(db.energyColor.r, db.energyColor.g, db.energyColor.b, db.energyColor.a)
		elseif (button.powerType == 6 and not db.rpDefault) then
			button.mana:SetStatusBarColor(db.rpColor.r, db.rpColor.g, db.rpColor.b, db.rpColor.a)
		else
			button.mana:SetStatusBarColor(PowerBarColor[button.powerType].r, PowerBarColor[button.powerType].g, PowerBarColor[button.powerType].b)
		end
        
        self:UNIT_POWER(nil, uid)
	end
end

function Gladdy:UNIT_SPELLCAST_START(event, uid)
    local unit = arenaGUID[UnitGUID(uid)]
    
    local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(uid)
	if (arenaUnits[unit] == "playerUnit" and spell) then
		local button = self.buttons[unit]	
		if(not button) then return end
	
		local castBar = button.castBar
		castBar.isCasting = true
		castBar.value = (GetTime() - (startTime / 1000))
		castBar.maxValue = (endTime - startTime) / 1000
		castBar:SetMinMaxValues(0, castBar.maxValue)
		castBar:SetValue(castBar.value)
		castBar.timeText:SetText(maxValue)
		castBar.icon:SetTexture(icon)
		
		if( rank ~= "" ) then
			castBar.spellText:SetFormattedText("%s (%s)", spell, rank)
		else
			castBar.spellText:SetText(spell)
		end
		
		-- Spec detection
		self:DetectSpec(unit, self.specSpells[spell])
		
		-- Resurrection alert
		if(RESURRECTION_SPELLS[spell] and db.resAnnounce) then
			self:SendAnnouncement(string.format(L["RESURRECTING: %s (%s)"], UnitName(uid), UnitClass(uid)), RAID_CLASS_COLORS[button.class])
		end
	end
end

function Gladdy:UNIT_SPELLCAST_CHANNEL_START(event, uid)
    local unit = arenaGUID[UnitGUID(uid)]
    
    local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(uid)	
	if (arenaUnits[unit] == "playerUnit" and spell) then
		local button = self.buttons[unit]	
		if(not button) then return end
		
		local castBar = self.buttons[unit].castBar
		castBar.isChanneling = true
		castBar.value = ((endTime / 1000) - GetTime())
		castBar.maxValue = (endTime - startTime) / 1000
		castBar:SetMinMaxValues(0, castBar.maxValue)
		castBar:SetValue(castBar.value)
		castBar.timeText:SetText(maxValue)
		castBar.icon:SetTexture(icon)

		if( rank ~= "" ) then
			castBar.spellText:SetFormattedText("%s (%s)", spell, rank)
		else
			castBar.spellText:SetText(spell)
		end
	end	
end

function Gladdy:UNIT_SPELLCAST_SUCCEEDED(event, uid, spell)
    local unit = arenaGUID[UnitGUID(uid)]
    if ( arenaUnits[unit] == "playerUnit" or ( self.frame.testing and uid == "player" )) then
		if ( uid == "player" ) then unit = "arena1" end
		
		-- Spec detection for instant cast spells
		self:DetectSpec(unit, self.specSpells[spell])
    end 
end

function Gladdy:UNIT_SPELLCAST_STOP(event, uid)
    local unit = arenaGUID[UnitGUID(uid)]
    
    if (arenaUnits[unit] == "playerUnit") then
		local button = self.buttons[unit]	
		if(not button) then return end
		
		self:CastEnd(button.castBar)
	end
end

function Gladdy:UNIT_SPELLCAST_DELAYED(event, uid)
    local unit = arenaGUID[UnitGUID(uid)]
    
    if (arenaUnits[unit] == "playerUnit") then
		local spell, rank, displayName, icon, startTime, endTime, isTradeSkill
		if (event == "UNIT_SPELLCAST_DELAYED") then
			spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(uid)
		else
			spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(uid)
		end
		
		if startTime == nil then return end
		
		local bar = self.buttons[unit].castBar
		bar.value = (GetTime() - (startTime / 1000))
		bar.maxValue = (endTime - startTime) / 1000
		bar:SetMinMaxValues(0, bar.maxValue)
	end
end

function Gladdy:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
    local spellId, spellName = ...

	if ((eventType == "PARTY_KILL" or eventType == "UNIT_DIED" or eventType == "UNIT_DESTROYED") and bit.band(destGUID, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE) then
		self:UnitDeath(destGUID)

	elseif (eventType == "SPELL_AURA_APPLIED") then
		local unit = arenaGUID[destGUID]
		local button = self.buttons[unit]
		if (not button) then return end

		local key = string.join("-", ...)

		if (arenaGUID[destGUID] and self.drSpellIds[spellName]) then
			self:DRGain(arenaGUID[destGUID], self.drSpellIds[spellName])
		end

		if (auras[spellName] and auras[spellName] >= (button.auraFrame.priority or 1)) then
			local category, factor = self.drSpellIds[spellName], 1
			if (category) then
				factor = button.diminishingReturn[category]
			end
			local duration = self:GetDuration(spellName) / factor
			self:AuraGain(unit, spellName, select(3, GetSpellInfo(spellId)), duration, auras[spellName])

			button.spells[key] = string.format("%.1f", GetTime())
		end

	elseif (eventType == "SPELL_AURA_REFRESH") then
		local unit = arenaGUID[destGUID]
		local button = self.buttons[unit]
		if (not button) then return end

		local key = string.join("-", ...)

		if (button.spells[key] and string.format("%.1f", GetTime()) > button.spells[key] and arenaGUID[destGUID] and self.drSpellIds[spellName]) then
			self:DRFades(arenaGUID[destGUID], spellName)
			self:DRGain(arenaGUID[destGUID], self.drSpellIds[spellName])
		end

		if (button.spells[key] and string.format("%.1f", GetTime()) > button.spells[key] and auras[spellName] and auras[spellName] >= (button.auraFrame.priority or 1)) then
			local category, factor = self.drSpellIds[spellName], 1
			if (category) then
				factor = button.diminishingReturn[category]
			end
			local duration = self:GetDuration(spellName) / factor
			self:AuraGain(unit, spellName, select(3, GetSpellInfo(spellId)), duration, auras[spellName])

			button.spells[key] = string.format("%.1f", GetTime())
		end

	elseif (eventType == "SPELL_AURA_REMOVED") then
		local unit = arenaGUID[destGUID]
		local button = self.buttons[unit]
		if (not button) then return end

		local key = string.join("-", ...)
		button.spells[key] = nil

		if (button.auraFrame.name == spellName) then
			self:AuraFades(button.auraFrame)
		end

		if (arenaGUID[destGUID] and self.drSpellIds[spellName]) then
         	self:DRFades(arenaGUID[destGUID], spellName)
		end

	elseif (eventType == "SPELL_CAST_START") then
		local unit = arenaGUID[sourceGUID]
		local button = self.buttons[unit]
		if (not button) then return end
        
        self:DetectSpec(unit, self.specSpells[spellName])

		if (RESURRECTION_SPELLS[spellName] and db.resAnnounce) then
			self:SendAnnouncement(string.format(L["RESURRECTING: %s (%s)"], button.name, button.classLoc), RAID_CLASS_COLORS[button.class])
		end
        
        local time = select(7, GetSpellInfo(spellId)) / 1000
        
        button.castBar.isCasting = true
		button.castBar.value = 0
		button.castBar.maxValue = time
		button.castBar:SetMinMaxValues(0, time)
		button.castBar:SetValue(0)
		button.castBar.timeText:SetText(time)
        button.castBar.spellText:SetText(spellName)
		button.castBar.icon:SetTexture(select(3, GetSpellInfo(spellId)))
        
	elseif (eventType == "SPELL_CAST_SUCCESS") then
    	local unit = arenaGUID[sourceGUID]

		self:DetectSpec(unit, self.specSpells[spellName])
        
    elseif (eventType == "SPELL_CAST_FAILED") then
        local unit = arenaGUID[sourceGUID]
		local button = self.buttons[unit]
		if (not button) then return end
        
        self:CastEnd(button.castBar)
	end
end

function Gladdy:UnitDeath(GUID)
    local unit = arenaGUID[GUID]
	if (arenaUnits[unit] == "playerUnit") then
		local button = self.buttons[unit]		
		if(not button) then return end
		
		button.health:SetValue(0)
		button.healthText:SetText("DEAD")
		button.mana:SetValue(0)
		button.manaText:SetText("0%")
		button.classIcon:SetAlpha(0.33)
		button.trinket:SetText("")
		button.drCooldownFrame:Hide()
		self:AuraFades(button.auraFrame)
        self:CastEnd(button.castBar)
	end
end

function Gladdy:PLAYER_TARGET_CHANGED()
    self:CheckUnit("target")
    
    local target = UnitGUID("target")
	for _, button in pairs(self.buttons) do
		if( button.GUID == target ) then
			if (db.highlight) then
				button.highlight:Show()
			end
			if (db.selectedBorder) then
				button.selected:Show()
			end
		else
			button.highlight:Hide()
			button.selected:Hide()
		end
	end	
end

function Gladdy:PLAYER_FOCUS_CHANGED()
    self:CheckUnit("focus")

    local focus = UnitGUID("focus")
	for _, button in pairs(self.buttons) do
		if( button.GUID == focus ) then
			if (db.focusBorder) then
				button.focusBorder:Show()
			end
		else
			button.focusBorder:Hide()
		end
	end
end

function Gladdy:UPDATE_MOUSEOVER_UNIT()
    self:CheckUnit("mouseover")
end

function Gladdy:UNIT_TARGET(event, uid)
    if (UnitIsPartyLeader(uid) == 1 and UnitGUID(uid) ~= UnitGUID("player")) then
        local assist = UnitGUID(uid .. "target")
        for _, button in pairs(self.buttons) do
            if(button.GUID == assist) then
                if (db.leaderBorder) then
                    button.leaderBorder:Show()
                end
            else
               button.leaderBorder:Hide()
            end
         end
    end
end

function Gladdy:RefreshFrame()
    for k, v in pairs(self.buttons) do
		if (arenaGUID[v.GUID] == k) then
			if (not v.click and not InCombatLockdown()) then
				self:UpdateAttributes(k)
				v.click = 1
			end

			if (v.click) then
				v:SetAlpha(1)
				v.text:SetText(v.name)
			else
				v:SetAlpha(0.66)
				v.text:SetText("**" .. v.name .. "**")
			end
		end
	end
end

function Gladdy:CheckUnit(uid)
    if (not self:Valid(uid)) then return end
    
    if (not arenaGUID[UnitGUID(uid)]) then
        local unit = "arena" .. self.currentUnit
        self.currentUnit = self.currentUnit + 1
        arenaGUID[UnitGUID(uid)] = unit
        
        local button = self.buttons[unit]
        if (not button) then return end
        
        local name, server = UnitName(uid)
		local classLoc, class = UnitClass(uid)
		local raceLoc, race = UnitRace(uid)
        
        button.name = name
		button.class = class
		button.classLoc = classLoc
        button.raceLoc = raceLoc
		button.GUID = UnitGUID(uid)
		button.text:SetText(name)
		
		--Announce the enemy if enabled and a name exists.
		if ( db.enemyAnnounce and not button.enemyAnnounced and name ~= L["Unknown"] ) then
			self:SendAnnouncement(name .. " - " .. classLoc, RAID_CLASS_COLORS[class])
			button.enemyAnnounced = true
		end
        
        button.diminishingReturn = {}
        
        if (not db.trinketStatus or (db.trinketDisplay ~= "nameText" and db.trinketDisplay ~= "nameIcon")) then
			button.trinket:SetText("")
		else
			local text = db.trinketDisplay == "nameText" and " (t)" or self:GetTrinketIcon(uid, true)
			local alpha = db.trinketDisplay == "nameText" and 1 or 0.5
			button.trinket:SetText(text)
			button.trinket:SetAlpha(alpha)
		end
		
		if (db.trinketDisplay == "bigIcon" and db.trinketStatus) then
			button.bigTrinket:SetTexture(self:GetTrinketIcon(uid, false))
		elseif (db.trinketDisplay == "smallIcon" and db.trinketStatus) then
			button.smallTrinket:SetTexture(self:GetTrinketIcon(uid, false))
		elseif (db.trinketDisplay == "overrideIcon" and db.trinketStatus) then
			button.overrideTrinket:SetTexture(self:GetTrinketIcon(uid, false))
		end
		
        button.raceText:SetText("")
		if (db.raceText) then
			button.raceText:SetText(raceLoc)
		end
		
		if (db.specText and arenaSpecs[unit]) then
			if (button.raceText:GetText()) then
				button.raceText:SetFormattedText("%s %s", arenaSpecs[unit], button.raceText:GetText())
			else
				button.raceText:SetText(arenaSpecs[unit])
			end
		end
		
		if (not db.raceText and not db.specText) then
			button.raceText:Hide()
		end
        
        --health bar class color
        if (db.healthBarClassColor) then
            button.health:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b, 1.0)
        else
            button.health:SetStatusBarColor(db.healthBarColor.r, db.healthBarColor.g, db.healthBarColor.b)
        end
		
		--class icon
		button.classIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
		button.classIcon:SetTexCoord(unpack(CLASS_BUTTONS[class]))
		button.classIcon:SetAlpha(1)
        
        self:UNIT_AURA(nil, uid)
        self:UNIT_HEALTH(nil, uid)
        self:UNIT_DISPLAYPOWER(nil, uid)
        self:PLAYER_TARGET_CHANGED(nil)
		self:PLAYER_FOCUS_CHANGED(nil)
        self:CastEnd(button.castBar)
        
        -- SHOW
        button:SetAlpha(1)
    else
        self:UNIT_AURA(nil, uid)
        self:UNIT_HEALTH(nil, uid)
        self:UNIT_DISPLAYPOWER(nil, uid)
    end
end

function Gladdy:Valid(uid)
    if UnitExists(uid) and UnitName(uid) and UnitIsPlayer(uid) and UnitCanAttack("player", uid) and not UnitIsCharmed(uid) and not UnitIsCharmed("player") then
    	return true
    end
end

function Gladdy:AuraGain(unit, name, icon, expirationTime, priority)
	local aura = self.buttons[unit].auraFrame
	aura.name = name
	aura.priority = priority
	aura.timeLeft = expirationTime
	aura.icon:SetTexture(icon)
	aura.auraActive = true
end

function Gladdy:AuraFades(frame)
	frame.name = nil
	frame.priority = nil
	frame.text:SetText("")
	frame.icon:SetTexture("")
	frame.auraActive = nil
end

function Gladdy:CastEnd(bar)
	bar.isCasting = nil
	bar.isChanneling = nil
	bar.timeText:SetText("")
	bar.spellText:SetText("")
	bar.icon:SetTexture("")
	bar:SetValue(0)
end

function Gladdy:UpdateBindings()
    for k, v in pairs(self.buttons) do
		local key = GetBindingKey("GLADDYTRINKET" .. v.id)
		ClearOverrideBindings(v.trinketButton)
        if (key) then
            SetOverrideBindingClick(v.trinketButton, true, key, v.trinketButton:GetName(), "LeftButton")	
        end
	end
end

function Gladdy:UpdateAttributes(unit)
    for _, click in pairs(db.attributes) do
		self:UpdateAttribute(unit, click.button, click.modifier, click.action, click.spell)
	end
end

function Gladdy:UpdateAttribute(unit, key, mod, action, spell)
    local button = self.buttons[unit]

	local attr = mod .. "macrotext" .. key
	local text = ""

	if (action == "target") then
		text = "/targetexact " .. button.name
	elseif (action == "focus") then
        text = "/targetexact " .. button.name .. "\n/focus\n/targetlasttarget"
	elseif (action == "spell") then
		text = "/targetexact " .. button.name .. "\n/cast " .. spell
	elseif (action == "macro") then
   		text = string.gsub(spell, "*name*", button.name)
	end

	button.secure:SetAttribute(attr, text)
end

local horde = {
    [L["Orc"]] = true,
    [L["Undead"]] = true,
    [L["Tauren"]] = true,
    [L["Troll"]] = true,
    [L["Blood Elf"]] = true,
}

function Gladdy:GetTrinketIcon(unit)
	local trinketIcon
    
    -- Race provided
    if (not self:Valid(unit)) then
        if (horde[unit] == true) then
            trinketIcon = "Interface\\Icons\\INV_Jewelry_TrinketPVP_02"
        else
            trinketIcon = "Interface\\Icons\\INV_Jewelry_TrinketPVP_01"
        end
    -- Valid unit
    else
        if( UnitFactionGroup(unit) == "Horde" ) then
            trinketIcon = "Interface\\Icons\\INV_Jewelry_TrinketPVP_02"
        else
            trinketIcon = "Interface\\Icons\\INV_Jewelry_TrinketPVP_01"
        end
    end
	
	if ( db.trinketDisplay == "nameIcon" ) then
		trinketIcon = string.format("|T%s:%d:%d:10:0|t", trinketIcon, db.healthFontSize*2, db.healthFontSize*2)
	end
	
	return trinketIcon
end

local function TrinketUpdate(self, elapsed)
	if ( self.endTime < GetTime() ) then	
		local button = Gladdy.buttons[self.unit]
		local display = db.trinketDisplay

		-- Display nametext/nameicon again
		if ( display == "nameText" or display == "nameIcon" ) then
			button.trinket:SetText(display == "nameText" and " (t)" or trinketIcon)
			button.trinket:SetAlpha(display == "nameText" and 1 or 0.5)
		elseif ( display == "gridIcon" ) then
			button.gridTrinket:SetBackdropColor(0,1,0,1)
		end
		
		-- Announce trinket ready
		if ( db.trinketUpAnnounce ) then
			Gladdy:SendAnnouncement(string.format(L["TRINKET READY: %s (%s)"], button.name, button.classLoc), RAID_CLASS_COLORS[button.class])
		end
        
        button.trinkedUsed = false
		
		-- Set OnUpdate script to nothing so it won't continue updating	
		self:SetScript("OnUpdate", nil)
		
	end
	
end	

function Gladdy:TrinketUsed(unit)
	local button = self.buttons[unit]
    local time = 120
	
	if ( not button or ( button.trinketFrame and button.trinketFrame.endTime > (GetTime()+time)) ) then return end
    
    if (button.trinkedUsed) then return end
    button.trinkedUsed = true
	
	local display = db.trinketDisplay
	local trinketIcon = self:GetTrinketIcon(unit)

	-- If the updating frame doesn't exist, create it
	if ( not button.trinketFrame ) then
		button.trinketFrame = CreateFrame("Frame", nil, button)
	end

	button.trinketFrame:SetScript("OnUpdate", TrinketUpdate)
	button.trinketFrame.endTime = GetTime() + time
	button.trinketFrame.unit = unit
	
	-- Hide name-text/icon or change color of gridtrinket frame
	if ( display == "nameText" or display == "nameIcon" ) then
		button.trinket:SetText("")
	elseif ( display == "gridIcon" ) then
		button.gridTrinket:SetBackdropColor(1,0,0,1)
	end
	
	-- Set the cooldown timer
	if ( display == "overrideIcon" or display == "bigIcon" or display == "smallIcon" or display == "gridIcon" ) then 
		CooldownFrame_SetTimer(button.cooldownFrame, GetTime(), time, 1)
	end

	-- Announce that the trinket has been used
	if ( db.trinketUsedAnnounce ) then
		self:SendAnnouncement(string.format(L["TRINKET USED: %s (%s)"], button.name, button.classLoc), RAID_CLASS_COLORS[button.class])
	end
end

function Gladdy:DRGain(unit, spellType)
    local button = self.buttons[unit]
    if not button then return end

    -- don't continue if its a pet or the spellType is deactivated
    if (arenaUnits[unit] ~= "playerUnit") then return end

    -- save the diminishing return value
    if (not button.diminishingReturn) then button.diminishingReturn = {} end

    if (not button.diminishingReturn[spellType]) then
        button.diminishingReturn[spellType] = 0
    end

    if (button.diminishingReturn[spellType] >= 3) then
        button.diminishingReturn[spellType] = 0
    end
    
   
    button.diminishingReturn[spellType] = button.diminishingReturn[spellType] + 1
end

function Gladdy:DRFades(unit, spellName)
   local button = self.buttons[unit]
   if not button then return end

   if (not button.diminishingReturn) then button.diminishingReturn = {} end

   -- get the diminishing return type
   local spellType = self.drSpellIds[spellName]

   -- don't continue if its a pet or the spellType is deactivated
   if (arenaUnits[unit] ~= "playerUnit" or not spellType) then return end

   -- immune to spells
   if (button.diminishingReturn[spellType] ~= nil and button.diminishingReturn[spellType] >= 4) then return end

   -- set the cooldown
   for i=1, 16 do
      local frame = button.drCooldownFrame["icon" .. i]
      if (not frame.active or (frame.type ~= nil and frame.type == spellType)) then
         frame.active = true
         frame.lastFactor = button.diminishingReturn[spellType]
         frame.type = spellType
         frame.timeLeft = DRTIME
         frame.cooldown:SetCooldown(GetTime(), DRTIME)
         frame.texture:SetTexture(self.drSpellTextures[spellName])

         frame.text:SetText(self.drTime[button.diminishingReturn[spellType]])

         -- position the icons
         self:DRPositionIcons(unit)

         -- show icon
         frame:Show()
         frame:SetAlpha(1)

         frame:SetScript("OnUpdate", function(self, elapsed)
            self.timeLeft = self.timeLeft - elapsed
            self.timeLeftText:SetText(string.format("%d", self.timeLeft + 1))
            if ( self.timeLeft <= 0 ) then
                frame.active = false
                frame.type = nil
                frame.cooldown:Hide()
                frame:SetScript("OnUpdate", nil)
                frame:Hide()
                frame.text:SetText("")
                frame.timeLeftText:SetText("")
                frame:SetAlpha(0)

                -- reset diminishing return
                if (frame.lastFactor == button.diminishingReturn[spellType]) then
                    button.diminishingReturn[spellType] = 0
                end

                -- position icons
                Gladdy:DRPositionIcons(unit)
            end
         end)

         break
      end
   end
end

function Gladdy:DRPositionIcons(unit)
   local button = self.buttons[unit]
   if not button then return end

   local lastFrame = nil
   local anchor = db.drCooldownAnchor == "CENTER" and "" or db.drCooldownAnchor

   for i=1, 16 do
      local frame = button.drCooldownFrame["icon" .. i]
      if (frame.active) then
         frame:ClearAllPoints()
         
         if (db.drCooldownPos == "RIGHT") then
            if (lastFrame == nil) then
                frame:SetPoint(anchor .. "LEFT", button.drCooldownFrame)
            else
                frame:SetPoint("LEFT", lastFrame, "RIGHT", db.drMargin - 5, 0)
            end
         else
            if (lastFrame == nil) then
                frame:SetPoint(anchor .. "RIGHT", button.drCooldownFrame)
            else
                frame:SetPoint("RIGHT", lastFrame, "LEFT", db.drMargin - 5, 0)
            end
         end

         lastFrame = frame
      end
   end
end

function Gladdy:DetectSpec(unit, spec)
	if (not spec or arenaUnits[unit] ~= "playerUnit" or arenaSpecs[unit]) then return end
    
	arenaSpecs[unit] = spec

	local button = self.buttons[unit]
	if (not button) then return end
    
    -- For sync
    button.__spec = spec
    
    if( db.specAnnounce ) then
		self:SendAnnouncement(string.format(L["SPEC DETECTED: %s - %s %s"], button.name, spec, button.classLoc), RAID_CLASS_COLORS[button.class])
	end
    
    if( db.specText ) then
		if (button.raceText:GetText()) then
			button.raceText:SetFormattedText("%s %s", arenaSpecs[unit], button.raceText:GetText())
		else
			button.raceText:SetText(arenaSpecs[unit])
		end
	end
end

function Gladdy:SendComm(data)
    self:SendCommMessage("Gladdy", data, "PARTY", nil, "ALERT")
end

function Gladdy:Sync()
    for unit, button in pairs(self.buttons) do
        if (button.GUID ~= nil) then
            if (not button.__sendHealth or not button.__sendMana or button.__sendHealth ~= button.__currentHealth or button.__sendMana ~= button.__currentMana) then
                -- Collect data we are need
                local output = string.format("%s,%s,%s,%s,%s,%s,%d,%d,%d,%d,%d",
                    button.name,
                    button.GUID,
                    button.class,
                    button.classLoc,
                    button.raceLoc,
                    button.__spec,
                    button.__currentHealth,
                    button.__maxHealth,
                    button.__currentMana,
                    button.__maxMana,
                    button.powerType
                )
                
                button.__sendHealth = button.__currentHealth
                button.__sendMana = button.__currentMana
                
                self:SendComm(output)
            end
        end
    end
end

function Gladdy:OnCommReceived(prefix, message, distribution, sender)
    if (prefix == "Gladdy" and sender ~= UnitName("player")) then
        local name, GUID, class, classLoc, raceLoc, spec, currentHealth, maxHealth, currentMana, maxMana, powerType = string.split(',', message)
        
        local unit, button
        
        -- Have no entry?
        if (not arenaGUID[GUID]) then
            unit = "arena" .. self.currentUnit
            self.currentUnit = self.currentUnit + 1
            arenaGUID[GUID] = unit
            
            button = self.buttons[unit]
            if (not button) then return end
            
            -- Spec
            if (spec ~= nil and spec ~= "nil") then
                arenaSpecs[unit] = spec
            end
            
            -- Add data
            button.name = name
            button.GUID = GUID
            button.class = class
            button.classLoc = classLoc
            button.raceLoc = raceLoc
            button.powerType = powerType
            button.text:SetText(name)
            
            -- Announced?
            if ( db.enemyAnnounce and not button.enemyAnnounced and name ~= L["Unknown"] ) then
                self:SendAnnouncement(name .. " - " .. classLoc, RAID_CLASS_COLORS[class])
                button.enemyAnnounced = true
            end
        
            button.diminishingReturn = {}
            
            -- Setup trinket
            if (not db.trinketStatus or (db.trinketDisplay ~= "nameText" and db.trinketDisplay ~= "nameIcon")) then
                button.trinket:SetText("")
            else
                local text = db.trinketDisplay == "nameText" and " (t)" or self:GetTrinketIcon(uid, true)
                local alpha = db.trinketDisplay == "nameText" and 1 or 0.5
                button.trinket:SetText(text)
                button.trinket:SetAlpha(alpha)
            end
		
            if (db.trinketDisplay == "bigIcon" and db.trinketStatus) then
                button.bigTrinket:SetTexture(self:GetTrinketIcon(raceLoc, false))
            elseif (db.trinketDisplay == "smallIcon" and db.trinketStatus) then
                button.smallTrinket:SetTexture(self:GetTrinketIcon(raceLoc, false))
            elseif (db.trinketDisplay == "overrideIcon" and db.trinketStatus) then
                button.overrideTrinket:SetTexture(self:GetTrinketIcon(raceLoc, false))
            end
		
            -- Setup race
            button.raceText:SetText("")
            if (db.raceText) then
                button.raceText:SetText(raceLoc)
            end
		
            -- Dont forget spec
            if (db.specText and arenaSpecs[unit]) then
                button.__spec = arenaSpecs[unit]
                if (button.raceText:GetText()) then
                    button.raceText:SetFormattedText("%s %s", arenaSpecs[unit], button.raceText:GetText())
                else
                    button.raceText:SetText(arenaSpecs[unit])
                end
            end
		
            if (not db.raceText and not db.specText) then
                button.raceText:Hide()
            end
            
            --health bar class color
            if (db.healthBarClassColor) then
                button.health:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b, 1.0)
            else
                button.health:SetStatusBarColor(db.healthBarColor.r, db.healthBarColor.g, db.healthBarColor.b)
            end
            
            -- Power type
            if (button.powerType == 0 and not db.manaDefault) then
                button.mana:SetStatusBarColor(db.manaColor.r, db.manaColor.g, db.manaColor.b, db.manaColor.a)
            elseif (button.powerType == 1 and not db.rageDefault) then
                button.mana:SetStatusBarColor(db.rageColor.r, db.rageColor.g, db.rageColor.b, db.rageColor.a)
            elseif (button.powerType == 3 and not db.energyDefault) then
                button.mana:SetStatusBarColor(db.energyColor.r, db.energyColor.g, db.energyColor.b, db.energyColor.a)
            elseif (button.powerType == 6 and not db.rpDefault) then
                button.mana:SetStatusBarColor(db.rpColor.r, db.rpColor.g, db.rpColor.b, db.rpColor.a)
            else
                button.mana:SetStatusBarColor(PowerBarColor[button.powerType].r, PowerBarColor[button.powerType].g, PowerBarColor[button.powerType].b)
            end
		
            -- class icon
            button.classIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
            button.classIcon:SetTexCoord(unpack(CLASS_BUTTONS[class]))
            button.classIcon:SetAlpha(1)
            
            -- Clicks
            button.click = nil
            
            -- End cast
            self:CastEnd(button.castBar)
            
            -- Some events
            self:PLAYER_TARGET_CHANGED(nil)
            self:PLAYER_FOCUS_CHANGED(nil)
            
            -- Show
            button:SetAlpha(1)
        end
        
        -- Be sure we have button
        if (not button) then return end        
        
        -- Update HP
        currentHealth = tonumber(currentHealth)
        maxHealth = tonumber(maxHealth)
        
        local healthPercent = math.floor((currentHealth / maxHealth) * 100)
		local healthText
			
		if ( db.healthActual ) then
			healthText = db.shortHpMana and currentHealth > 9999 and string.format("%.1fk", (currentHealth / 1000)) or currentHealth  
		end
			
		if ( db.healthMax ) then
			local text = db.shortHpMana and maxHealth > 9999 and string.format("%.1fk", (maxHealth / 1000)) or maxHealth
			if ( healthText ) then
				healthText = string.format("%s/%s", healthText, text)
			else
				healthText = text
			end
        end
			
		if ( db.healthPercentage) then
			if ( healthText ) then
				healthText = string.format("%s (%d%%)", healthText, healthPercent)
			else
				healthText = string.format("%d%%", healthPercent)
			end		
		end
		
		button.healthText:SetText(healthText)
		button.health:SetValue(healthPercent)
            
        button.__currentHealth = currentHealth
        button.__maxHealth = maxHealth
            
        -- Update power
        currentMana = tonumber(currentMana)
        maxMana = tonumber(maxMana)
        
        local manaPercent = math.floor((currentMana/maxMana) * 100)
        local manaText
        
        if ( db.manaActual ) then
            manaText = db.shortHpMana and currentMana > 9999 and string.format("%.1fk", (currentMana / 1000)) or currentMana  
        end
		
        if ( db.manaMax ) then
            local text = db.shortHpMana and maxMana > 9999 and string.format("%.1fk", (maxMana / 1000)) or maxMana
            if ( manaText ) then
                manaText = string.format("%s/%s", manaText, text)
            else
                manaText = text
            end
        end
		
        if ( db.manaPercentage ) then
            if ( manaText ) then
                manaText = string.format("%s (%d%%)", manaText, manaPercent)
            else
                manaText = string.format("%d%%", manaPercent)
            end		
        end
		
        button.manaText:SetText(manaText)
        button.mana:SetValue(manaPercent)
            
        button.__currentMana = currentMana
        button.__maxMana = maxMana
    end
end