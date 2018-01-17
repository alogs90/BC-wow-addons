local self = Gladdy
local db
local currentBracket
local LSM = LibStub("LibSharedMedia-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Gladdy", true)

local function AuraUpdate(frame, elapsed)
	if (frame.auraActive) then
		frame.timeLeft = frame.timeLeft - elapsed
		if (frame.timeLeft <= 0) then
			self:AuraFades(frame)
			return
		end	
		frame.text:SetFormattedText("%.1f", frame.timeLeft)
	end
end

local function CastUpdate(frame, elapsed)
	if (frame.isCasting) then
		if (frame.value >= frame.maxValue) then
			frame:SetValue(frame.maxValue)
			self:CastEnd(frame)
			return
		end
		frame.value = frame.value + elapsed
		frame:SetValue(frame.value)
		frame.timeText:SetFormattedText("%.1f", frame.maxValue-frame.value)
	elseif (frame.isChanneling) then
		if (frame.value <= 0) then
			self:CastEnd(frame)
			return
		end
		frame.value = frame.value - elapsed
		frame:SetValue(frame.value)
		frame.timeText:SetFormattedText("%.1f", frame.value)
	end
end

local function StyleActionButton(f)
	local name = f:GetName()
	local button  = _G[name]
	local icon  = _G[name.."Icon"]
	local normalTex = _G[name.."NormalTexture"]
	
	normalTex:SetHeight(button:GetHeight())
	normalTex:SetWidth(button:GetWidth())
	normalTex:SetPoint("CENTER", 0, 0)

	button:SetNormalTexture("Interface\\AddOns\\Gladdy\\statusbar\\gloss")
	
	icon:SetTexCoord(0.1,0.9,0.1,0.9)
	icon:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
	icon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	
	normalTex:SetVertexColor(1,1,1,1)	
end

function Gladdy:CreateFrame()
	currentBracket = self.currentBracket and self.currentBracket or 5
	db = self.db.profile
	
	local backdrop = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,}

	--if resizing is off
	if (not db.frameResize) then
		currentBracket = 5 --set current bracket to 5 for correct calculations
	end
	local classIconSize = db.barHeight
	local height = (db.barHeight*currentBracket)+((currentBracket-1)*db.barBottomMargin)+(db.padding*2)+5
	local width = db.barWidth+(db.padding*2)+5
	
	if (db.castBar) then
		height = height + (currentBracket*db.castBarHeight)		
	end
	
	if (db.powerBar) then
		classIconSize = classIconSize+db.manaBarHeight
		height = height + (currentBracket*db.manaBarHeight)	
	end
	
	if (true) then
		width = width + classIconSize
	end
	
	if (db.trinketDisplay == "bigIcon" and db.trinketStatus) then
		width = width+classIconSize
	end
	
	self.frame=CreateFrame("Button", "GladdyFrame", UIParent)
	self.frame:SetBackdrop(backdrop)
	self.frame:SetBackdropColor(db.frameColor.r,db.frameColor.g,db.frameColor.b,db.frameColor.a)
	self.frame:SetScale(db.frameScale)
	self.frame:SetWidth(width)
	self.frame:SetHeight(height)
	self.frame:SetClampedToScreen(true)

	self.frame:ClearAllPoints()
	if (db.x==0 and db.y==0) then
		self.frame:SetPoint("TOP", UIParent, "TOP",0,-15)
	else
		local scale = self.frame:GetEffectiveScale()
		self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", db.x/scale, db.y/scale)
	end
	self.frame:EnableMouse(true)
	self.frame:SetMovable(true)
	self.frame:RegisterForDrag("LeftButton")
	
	self.frame:SetScript('OnDragStart', function(self) 
		if (not InCombatLockdown() and not db.locked) then self:StartMoving() end 
	end)
    
	self.frame:SetScript('OnDragStop', function()
		if (not InCombatLockdown()) then
			this:StopMovingOrSizing()
			local scale = self.frame:GetEffectiveScale()
			db.x = self.frame:GetLeft() * scale
			db.y = self.frame:GetTop() * scale
		end
    end)
    
    self.anchor=CreateFrame("Button",nil, self.frame)
    self.anchor:SetWidth(width)
    self.anchor:SetHeight(15)
	self.anchor:SetBackdrop(backdrop)
	self.anchor:SetBackdropColor(0,0,0,1)
	self.anchor:EnableMouse(true)
	self.anchor:RegisterForClicks("RightButtonUp")
	self.anchor:RegisterForDrag("LeftButton")
	self.anchor:SetClampedToScreen(true)
	
	self.anchor:SetScript('OnDragStart', function()
		if (not InCombatLockdown() and not db.locked) then self.frame:StartMoving() end
     end)
    
    self.anchor:SetScript('OnClick', function()
			if (not InCombatLockdown()) then self:ShowOptions() end
	end)
	
	self.anchor.text = self.anchor:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	self.anchor.text:SetText(L["Gladdy - drag to move"])
	self.anchor.text:SetPoint("CENTER", self.anchor, "CENTER")
	
	self.anchor.button = CreateFrame("Button", nil, self.anchor, "UIPanelCloseButton")
	self.anchor.button:SetHeight(20)
	self.anchor.button:SetWidth(20)
	self.anchor.button:SetPoint("RIGHT",self.anchor, "RIGHT", 2, 0)
	self.anchor.button:SetScript("OnClick", function (frame, button, down)
		if(not down) then
			db.locked = true
			self:UpdateFrame()
		end
	end)
	
	if (db.locked) then
		self.anchor:Hide()
	end
	
    self.frame:Hide()
	self.frame.buttons={}
end

function Gladdy:CreateButton(i)
    db = self.db.profile
	local fontPath = GameFontNormalSmall:GetFont()

	if (not self.frame) then
		self:CreateFrame()
	end
	
	local button = CreateFrame("Frame", "GladdyButtonFrame"..i, self.frame)
	button:Show()
    button:SetAlpha(0)
	
	--selected frame (solid frame around the players target)
    button.selected =  CreateFrame("Frame", nil, button)
    button.selected:SetBackdrop({edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1,})
    button.selected:SetFrameStrata("HIGH")
    button.selected:Hide()
    
    --focus frame (solid frame around the players focus)
    local focusBorder =  CreateFrame("Frame", nil, button)
    focusBorder:SetBackdrop({edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1,})
    focusBorder:SetFrameStrata("LOW")
    focusBorder:Hide()
    
    -- assist frame (solid frame around the raid main assist target)
    local leaderBorder =  CreateFrame("Frame", nil, button)
    leaderBorder:SetBackdrop({edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1,})
    leaderBorder:SetFrameStrata("MEDIUM")
    leaderBorder:Hide()
	
	--Health bar   
	local healthBar = CreateFrame("StatusBar", nil, button)
	healthBar:ClearAllPoints()
	healthBar:SetPoint("TOPLEFT",button,"TOPLEFT", classIconSize, 0)
	healthBar:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT")
	healthBar:SetMinMaxValues(0, 100)
			   
	healthBar.bg = healthBar:CreateTexture(nil, "BACKGROUND")
	healthBar.bg:ClearAllPoints()
	healthBar.bg:SetAllPoints(healthBar)
	healthBar.bg:SetAlpha(0.3)
			
	--Highlight for the health bar
	healthBar.highlight = healthBar:CreateTexture(nil, "OVERLAY")
    healthBar.highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    healthBar.highlight:SetBlendMode("ADD")
    healthBar.highlight:SetAlpha(0.5)
    healthBar.highlight:ClearAllPoints()
    healthBar.highlight:SetAllPoints(healthBar)
    healthBar.highlight:Hide()

	--Mana bar
	local manaBar = CreateFrame("StatusBar", nil, button)
	manaBar:ClearAllPoints()
	manaBar:SetPoint("TOPLEFT",healthBar,"BOTTOMLEFT",0,-1)
	manaBar:SetMinMaxValues(0, 100)
		
	manaBar.bg = manaBar:CreateTexture(nil, "BACKGROUND")
	manaBar.bg:ClearAllPoints()
	manaBar.bg:SetAllPoints(manaBar)
	manaBar.bg:SetAlpha(0.3)

	--Cast bar
	local castBar = CreateFrame("StatusBar", nil, button)
	castBar:SetMinMaxValues(0, 100)
	castBar:SetValue(0)
	castBar:SetScript("OnUpdate", CastUpdate)
	castBar:Hide()
	
	castBar.bg = castBar:CreateTexture(nil, "BACKGROUND")
    castBar.bg:ClearAllPoints()
    castBar.bg:SetAllPoints(castBar)
    
    castBar.icon = castBar:CreateTexture(nil)
    castBar.icon:ClearAllPoints()
    castBar.icon:SetPoint("RIGHT", castBar, "LEFT")
    castBar.icon:SetTexCoord(0.1,0.9,0.1,0.9)
    
    if (db.castBar) then
		castBar:Show()
	end
	
	--Class icon
	local classIcon = button:CreateTexture(nil, "ARTWORK")
    classIcon:ClearAllPoints()
    classIcon:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 0)
 	
 	--Aura frame
	local auraFrame = CreateFrame("Frame", nil, button)
    auraFrame:ClearAllPoints()
    auraFrame:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 0)
    auraFrame:SetScript("OnUpdate", AuraUpdate)
    
    --The actual icon
    auraFrame.icon = auraFrame:CreateTexture(nil, "ARTWORK")
    auraFrame.icon:SetAllPoints(auraFrame)
    
    --the text
	auraFrame.text = auraFrame:CreateFontString(nil,"OVERLAY")
	auraFrame.text:SetFont(LSM:Fetch(LSM.MediaType.FONT), db.auraFontSize)
	auraFrame.text:SetTextColor(db.auraFontColor.r,db.auraFontColor.g,db.auraFontColor.b,db.auraFontColor.a)
	auraFrame.text:SetShadowOffset(1, -1)
	auraFrame.text:SetShadowColor(0, 0, 0, 1)
	auraFrame.text:SetJustifyH("CENTER")
	auraFrame.text:SetPoint("CENTER",0,0)
	
	-- diminishing return frame
	local drCooldownFrame = CreateFrame("Frame", nil, button)
	for x=1, 16 do
		local icon = CreateFrame("CheckButton", "Gladdy"..i.."DRCooldownFrame"..x, drCooldownFrame, "ActionButtonTemplate")
		icon:EnableMouse(false)
		icon:SetFrameStrata("BACKGROUND")
		icon.texture = _G[icon:GetName().."Icon"]
		icon.cooldown = _G[icon:GetName().."Cooldown"]
		icon.cooldown:SetReverse(false)
		icon.cooldown:SetFrameStrata("BACKGROUND")
		icon.text = drCooldownFrame:CreateFontString(nil,"OVERLAY")
		icon.text:SetDrawLayer("OVERLAY")
		icon.text:SetJustifyH("CENTER")
		icon.text:SetPoint("CENTER", icon)
        icon.timeLeftText = drCooldownFrame:CreateFontString(nil, "OVERLAY")
        icon.timeLeftText:SetDrawLayer("OVERLAY")
        icon.timeLeftText:SetJustifyH("CENTER")
        icon.timeLeftText:SetPoint("BOTTOM", icon)
		drCooldownFrame["icon"..x] = icon
	end
    
	--Name text
	local text = healthBar:CreateFontString(nil,"OVERLAY")
	text:SetFont(LSM:Fetch(LSM.MediaType.FONT), db.healthFontSize)
	text:SetTextColor(db.healthFontColor.r,db.healthFontColor.g,db.healthFontColor.b,db.healthFontColor.a)
	text:SetShadowOffset(1, -1)
	text:SetShadowColor(0, 0, 0, 1)
	text:SetJustifyH("LEFT")
	text:SetPoint("LEFT",5,0)
	
	--Trinket "text"
	local trinket = healthBar:CreateFontString(nil,"OVERLAY")
	trinket:SetFont(LSM:Fetch(LSM.MediaType.FONT), db.healthFontSize)
	trinket:SetTextColor(db.healthFontColor.r,db.healthFontColor.g,db.healthFontColor.b,db.healthFontColor.a)
	trinket:SetShadowOffset(1, -1)
	trinket:SetShadowColor(0, 0, 0, 1)
	trinket:SetPoint("LEFT", text, "RIGHT",0,0)
	
	--Trinket icon that overrides auras/class icon
	local overrideTrinket = button:CreateTexture(nil, "OVERLAY")
	overrideTrinket:ClearAllPoints()
    overrideTrinket:SetPoint("TOPLEFT",button,"TOPLEFT",-2,0)

    --Big trinket icon
    local bigTrinket = button:CreateTexture(nil, "ARTWORK")

    --Small trinket icon
    local smallTrinket = button:CreateTexture(nil, "ARTWORK")

    --Grid-style trinket icon
	local gridTrinket =  CreateFrame("Frame", nil, button)
	gridTrinket:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tileSize = 1, edgeFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeSize = 1,})
	gridTrinket:SetBackdropColor(0,1,0,1)
	gridTrinket:SetBackdropBorderColor(0,0,0,1)
	
	-- cooldown frame for trinkets
	local cooldownFrame = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")

	--Health text
	local healthText = healthBar:CreateFontString(nil,"LOW")
	healthText:SetFont(LSM:Fetch(LSM.MediaType.FONT), db.healthFontSize)
	healthText:SetTextColor(db.healthFontColor.r,db.healthFontColor.g,db.healthFontColor.b,db.healthFontColor.a)
	healthText:SetShadowOffset(1, -1)
	healthText:SetShadowColor(0, 0, 0, 1)
	healthText:SetJustifyH("RIGHT")
	healthText:SetPoint("RIGHT",-5,0)
	
	--Mana text
	local manaText = manaBar:CreateFontString(nil,"LOW")
	manaText:SetFont(LSM:Fetch(LSM.MediaType.FONT), db.manaFontSize)
	manaText:SetTextColor(db.manaFontColor.r,db.manaFontColor.g,db.manaFontColor.b,db.manaFontColor.a)
	manaText:SetShadowOffset(1, -1)
	manaText:SetShadowColor(0, 0, 0, 1)
	manaText:SetJustifyH("CENTER")
	manaText:SetPoint("RIGHT",-5,0)	

	--Class and race text
	local raceText = manaBar:CreateFontString(nil,"LOW")
	raceText:SetFont(LSM:Fetch(LSM.MediaType.FONT), db.manaFontSize)
	raceText:SetTextColor(db.manaFontColor.r,db.manaFontColor.g,db.manaFontColor.b,db.manaFontColor.a)
	raceText:SetShadowOffset(1, -1)
	raceText:SetShadowColor(0, 0, 0, 1)
	raceText:SetJustifyH("CENTER")
	raceText:SetPoint("LEFT",5,0)
	
	--Cast bar texts
	local castBarTextSpell = castBar:CreateFontString(nil,"LOW")
	castBarTextSpell:SetFont(LSM:Fetch(LSM.MediaType.FONT), db.castBarFontSize)
	castBarTextSpell:SetTextColor(db.castBarFontColor.r,db.castBarFontColor.g,db.castBarFontColor.b,db.castBarFontColor.a)
	castBarTextSpell:SetShadowOffset(1, -1)
	castBarTextSpell:SetShadowColor(0, 0, 0, 1)
	castBarTextSpell:SetJustifyH("CENTER")
	castBarTextSpell:SetPoint("LEFT",5,1)

	local castBarTextTime = castBar:CreateFontString(nil,"LOW")
	castBarTextTime:SetFont(LSM:Fetch(LSM.MediaType.FONT), db.castBarFontSize)
	castBarTextTime:SetTextColor(db.castBarFontColor.r,db.castBarFontColor.g,db.castBarFontColor.b,db.castBarFontColor.a)
	castBarTextTime:SetShadowOffset(1, -1)
	castBarTextTime:SetShadowColor(0, 0, 0, 1)
	castBarTextTime:SetJustifyH("CENTER")
	castBarTextTime:SetPoint("RIGHT",-5,1)
    
    --Secure button for target and focus
	local secure = CreateFrame("Button", "GladdyButton"..i, button, "SecureActionButtonTemplate")
	secure:RegisterForClicks("AnyUp")
    secure:SetAttribute("*type*", "macro")
    
    -- Trinket presser
    local trinketButton = CreateFrame("Button", "GladdyTrinketButton" .. i, button, "SecureActionButtonTemplate")
    trinketButton:RegisterForClicks("AnyUp")
    trinketButton:SetAttribute("*type*", "macro")
    trinketButton:SetAttribute("macrotext1", string.format("/script Gladdy:TrinketUsed(\"%s\")", "arena" .. i))
	
    button.mana = manaBar
    button.health = healthBar
    button.castBar = castBar
    button.castBar.timeText = castBarTextTime
    button.castBar.spellText = castBarTextSpell
    button.manaText = manaText
    button.healthText = healthText
    button.text = text
    button.cooldownFrame = cooldownFrame
    button.trinket = trinket
    button.overrideTrinket = overrideTrinket
    button.smallTrinket = smallTrinket
    button.bigTrinket = bigTrinket
    button.gridTrinket = gridTrinket
    button.raceText = raceText
    button.classIcon = classIcon
    button.auraFrame = auraFrame
    button.drCooldownFrame = drCooldownFrame
    button.highlight = healthBar.highlight
    button.selected = button.selected
    button.focusBorder = focusBorder
    button.leaderBorder = leaderBorder
    button.secure = secure
    button.secureTarget = secureTarget
    button.trinketButton = trinketButton
    button.id = i
    button.spells = {}

    return button
end

function Gladdy:UpdateFrame()
    local oldBracket
	db = self.db.profile
	local fontPath = GameFontNormalSmall:GetFont()
	currentBracket = self.currentBracket
	
	if (not self.frame or currentBracket == nil) then return end
	
	--if resizing is off
	if (not db.frameResize) then
		oldBracket = currentBracket --store bracket for later
		currentBracket = 5 --set current bracket to 5 for correct calculations
	end
	
	local classIconSize = db.barHeight
	local targetIconSize = db.barHeight
	local margin = db.barBottomMargin
	local height = (db.barHeight*currentBracket)+((currentBracket-1)*db.barBottomMargin)+(db.padding*2)+5
	local width = db.barWidth+(db.padding*2)+5
	local extraBarWidth = 0
	local extraBarHeight = 0
	local selectedHeight = db.barHeight+6
	local offset = 0
	local gridIcon = 0
	local extraSelectedWidth = 0
	
	if (db.castBar) then
		margin = margin + db.castBarHeight
		height = height + (currentBracket*db.castBarHeight)
		extraBarHeight = extraBarHeight + db.castBarHeight
		selectedHeight = selectedHeight + db.castBarHeight + 3		
	end
	
	if (db.powerBar) then
		classIconSize = classIconSize+db.manaBarHeight
		margin = margin+db.manaBarHeight
		height = height + (currentBracket*db.manaBarHeight)
		extraBarHeight = extraBarHeight + db.manaBarHeight
		selectedHeight = selectedHeight + db.manaBarHeight	
	end
	
	if (true) then
		width = width + classIconSize
		extraBarWidth = extraBarWidth + classIconSize
		extraSelectedWidth = classIconSize
	end
	
	if (false) then
		width = width+targetIconSize
		offset = targetIconSize/2
	else
		targetIconSize = 0
	end
	
	if (db.trinketDisplay == "bigIcon" and db.trinketStatus) then
		width = width+classIconSize*db.bigTrinketScale
		extraSelectedWidth = extraSelectedWidth + (classIconSize*db.bigTrinketScale)
		offset = offset + (classIconSize/2)*db.bigTrinketScale
	elseif ((db.trinketDisplay == "gridIcon" or db.trinketDisplay == "smallIcon") and db.trinketStatus) then
		gridIcon = db.manaBarHeight
	end
	
	--set frame size and position
	self.frame:ClearAllPoints()
	if (db.x==0 and db.y==0) then
		self.frame:SetPoint("TOP", UIParent, "TOP",0,-15)
	else
		local scale = self.frame:GetEffectiveScale()
		if ( not db.growUp ) then
			self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", db.x/scale, db.y/scale)
		else
			self.frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", db.x/scale, db.y/scale)
		end
	end
	self.frame:SetScale(db.frameScale)
	self.frame:SetWidth(width)
	self.frame:SetHeight(height)
	self.frame:SetBackdropColor(db.frameColor.r,db.frameColor.g,db.frameColor.b,db.frameColor.a)
	
	--set the visibility of the anchor
	if (db.locked) then
		self.anchor:Hide()
	else
		self.anchor:Show()
	end
	
	--anchor
	self.anchor:SetWidth(width)
	self.anchor:ClearAllPoints()
	
	self.anchor:SetPoint("TOPLEFT", self.frame, "TOPLEFT",0,15)
	self.anchor:SetScript('OnDragStop', function()
		if (not InCombatLockdown()) then
			self.frame:StopMovingOrSizing()
			local scale = self.frame:GetEffectiveScale()
			db.x = self.frame:GetLeft() * scale
			db.y = db.growUp and self.frame:GetBottom() * scale or self.frame:GetTop() * scale
		end
	end)
	
	--if resize is off
	if (not db.frameResize) then
		currentBracket = oldBracket --restore the bracket so it will update the correct amount of buttons
	end
	
	--update all the buttons
	for i=1, currentBracket do
		local button = self.buttons["arena"..i]
		
		--set button and secure button sizes
		button:SetHeight(db.barHeight)
		button:SetWidth(db.barWidth+extraBarWidth)
		
		button.secure:SetHeight(db.barHeight+extraBarHeight)
		button.secure:SetWidth(db.barWidth+extraBarWidth+targetIconSize)		
		
		button:ClearAllPoints()	
		button.secure:ClearAllPoints()
			
		if ( not db.growUp ) then 
			if ( i==1 ) then
				button:SetPoint("TOPLEFT",self.frame,"TOPLEFT", 0, -db.padding)
				button.secure:SetPoint("TOPLEFT",self.frame,"TOPLEFT", 0, -db.padding)
			else
				button:SetPoint("TOPLEFT",self.buttons["arena"..i-1],"BOTTOMLEFT", 0, -margin)
				button.secure:SetPoint("TOPLEFT",self.buttons["arena" .. i-1],"BOTTOMLEFT", 0, -margin)
			end
		else
			if ( i==1 ) then
				button:SetPoint("BOTTOMLEFT",self.frame,"BOTTOMLEFT", 0, db.padding+extraBarHeight)
				button.secure:SetPoint("BOTTOMLEFT",self.frame,"BOTTOMLEFT", 0, db.padding)
			else
				button:SetPoint("BOTTOMLEFT",self.buttons["arena"..i-1],"TOPLEFT", 0, margin)
				button.secure:SetPoint("BOTTOMLEFT",self.buttons["arena" .. i-1],"TOPLEFT", 0, margin-extraBarHeight)
			end
		end
			
		--size of the selected frame
		button.selected:SetHeight(selectedHeight)
		button.selected:SetWidth(db.barWidth+extraSelectedWidth+targetIconSize+9)
		button.selected:ClearAllPoints()
		button.selected:SetPoint("TOP",button,"TOP", offset-1, 3)
		button.selected:SetBackdropBorderColor(db.selectedFrameColor.r,db.selectedFrameColor.g,db.selectedFrameColor.b,db.selectedFrameColor.a)	
		
		--size of the selected frame
		button.focusBorder:SetHeight(selectedHeight)
		button.focusBorder:SetWidth(db.barWidth+extraSelectedWidth+targetIconSize+9)
		button.focusBorder:ClearAllPoints()
		button.focusBorder:SetPoint("TOP",button,"TOP", offset-1, 3)
		button.focusBorder:SetBackdropBorderColor(db.focusBorderColor.r,db.focusBorderColor.g,db.focusBorderColor.b,db.focusBorderColor.a)
		
		--size of the main assist frame
		button.leaderBorder:SetHeight(selectedHeight)
		button.leaderBorder:SetWidth(db.barWidth+extraSelectedWidth+targetIconSize+9)
		button.leaderBorder:ClearAllPoints()
		button.leaderBorder:SetPoint("TOP",button,"TOP", offset-1, 3)
		button.leaderBorder:SetBackdropBorderColor(db.leaderBorderColor.r,db.leaderBorderColor.g,db.leaderBorderColor.b,db.leaderBorderColor.a)
				
		--health bar location and texture
		button.health:ClearAllPoints()
		if (true) then
			button.health:SetPoint("TOPLEFT",button,"TOPLEFT", classIconSize, 0)
		else
			button.health:SetPoint("TOPLEFT",button,"TOPLEFT")
		end
		local healthBottom = 0	
		button.health:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT", healthBottom, 0)				
		button.health:SetStatusBarTexture(LSM:Fetch(LSM.MediaType.STATUSBAR, db.barTexture))	
		button.health.bg:SetTexture(LSM:Fetch(LSM.MediaType.STATUSBAR, db.barTexture))
		
		--mana bar location, size and texture		
		button.mana:ClearAllPoints()
		button.mana:SetHeight(db.manaBarHeight)
		button.mana:SetWidth(button.health:GetWidth()+targetIconSize-gridIcon)
		button.mana:SetPoint("TOPLEFT",button.health,"BOTTOMLEFT",0,-1)
		button.mana:SetStatusBarTexture(LSM:Fetch(LSM.MediaType.STATUSBAR, db.barTexture))
		button.mana.bg:SetTexture(LSM:Fetch(LSM.MediaType.STATUSBAR, db.barTexture))
		
		if (not db.powerBar) then
			button.mana:Hide()
		else
			button.mana:Show()
		end
		
		--cast bar location, size, texture and color
		button.castBar:ClearAllPoints()
		local castBarX = db.castBarHeight - classIconSize
		if (db.powerBar) then
            local parent = button.mana
                button.castBar:SetPoint("TOPLEFT",parent, "BOTTOMLEFT",castBarX,0)
		else
            local parent = button.health
			button.castBar:SetPoint("TOPLEFT",parent,"BOTTOMLEFT",castBarX,0)
		end			
		button.castBar:SetHeight(db.castBarHeight)
		button.castBar:SetWidth(button.health:GetWidth()+classIconSize+targetIconSize-db.castBarHeight)

		button.castBar:SetStatusBarTexture(LSM:Fetch(LSM.MediaType.STATUSBAR, db.barTexture))		
		button.castBar:SetStatusBarColor(db.castBarColor.r,db.castBarColor.g,db.castBarColor.b,db.castBarColor.a)
		button.castBar.bg:SetTexture(LSM:Fetch(LSM.MediaType.STATUSBAR, db.barTexture))
		button.castBar.bg:SetVertexColor(db.castBarBgColor.r,db.castBarBgColor.g,db.castBarBgColor.b,db.castBarBgColor.a)
		
		button.castBar.icon:SetHeight(db.castBarHeight)
		button.castBar.icon:SetWidth(db.castBarHeight)
		button.castBar.bg:ClearAllPoints()
		button.castBar.bg:SetPoint("RIGHT",button.castBar,"RIGHT")
		button.castBar.bg:SetWidth(button.castBar:GetWidth()+db.castBarHeight)
		button.castBar.bg:SetHeight(button.castBar:GetHeight())
		
		if (not db.castBar) then
			button.castBar:Hide()
		else
			button.castBar:Show()
		end
		
		--font sizes and color
		button.text:SetFont(LSM:Fetch(LSM.MediaType.FONT, db.healthFont), db.healthFontSize)
		button.healthText:SetFont(LSM:Fetch(LSM.MediaType.FONT, db.healthFont), db.healthFontSize)
		button.manaText:SetFont(LSM:Fetch(LSM.MediaType.FONT, db.manaFont), db.manaFontSize)
		button.raceText:SetFont(LSM:Fetch(LSM.MediaType.FONT, db.manaFont), db.manaFontSize)
		button.castBar.spellText:SetFont(LSM:Fetch(LSM.MediaType.FONT, db.castBarFont), db.castBarFontSize)
		button.castBar.timeText:SetFont(LSM:Fetch(LSM.MediaType.FONT, db.castBarFont), db.castBarFontSize)
		
		--healthbar color
		if(button.class and db.healthBarClassColor) then
			button.health:SetStatusBarColor(RAID_CLASS_COLORS[button.class].r, RAID_CLASS_COLORS[button.class].g, RAID_CLASS_COLORS[button.class].b, 1.0)
        else
            button.health:SetStatusBarColor(db.healthBarColor.r, db.healthBarColor.g, db.healthBarColor.b, 1.0)
		end
		
		--power bar colors
		if (button.powerType == 0 and not db.manaDefault) then
			button.mana:SetStatusBarColor(db.manaColor.r, db.manaColor.g, db.manaColor.b, db.manaColor.a)
		elseif (button.powerType == 1 and not db.rageDefault) then
			button.mana:SetStatusBarColor(db.rageColor.r, db.rageColor.g, db.rageColor.b, db.rageColor.a)
		elseif (button.powerType == 3 and not db.energyDefault) then
			button.mana:SetStatusBarColor(db.energyColor.r, db.energyColor.g, db.energyColor.b, db.energyColor.a)
		elseif (button.powerType) then			
			button.mana:SetStatusBarColor(PowerBarColor[button.powerType].r, PowerBarColor[button.powerType].g, PowerBarColor[button.powerType].b)
		end
		
		--class icon size
		local targetIcon = 0
		button.classIcon:ClearAllPoints()
		button.classIcon:SetWidth(classIconSize)
		button.classIcon:SetHeight(classIconSize+1)
		button.classIcon:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 0)
		button.auraFrame:ClearAllPoints()
		button.auraFrame:SetWidth(classIconSize)
		button.auraFrame:SetHeight(classIconSize+1)
		button.auraFrame:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 0)
				
		if (false) then
			button.classIcon:Hide()
		else
			button.classIcon:Show()
		end					
		
		--text toggling
		if (not db.specText and not db.raceText) then
			button.raceText:Hide()
		else
			button.raceText:Show()
		end
		
		if (not db.manaText) then
			button.manaText:Hide()
		else
			button.manaText:Show()
		end
		
		--override trinket icon
		button.overrideTrinket:SetWidth(classIconSize)
		button.overrideTrinket:SetHeight(classIconSize+1)
		button.overrideTrinket:SetTexture(self:GetTrinketIcon("player", false))

		if (db.trinketDisplay ~= "overrideIcon" or not db.trinketStatus or not db.classIcon) then
			button.overrideTrinket:Hide()
		else
			button.overrideTrinket:Show()
		end
		
		--the big trinket icon		
		button.bigTrinket:SetWidth(classIconSize*db.bigTrinketScale)
		button.bigTrinket:SetHeight((classIconSize+1)*db.bigTrinketScale)
		button.bigTrinket:SetTexture(self:GetTrinketIcon("player", false))
		button.bigTrinket:ClearAllPoints()
		local parent = db.targetIcon and button.targetIcon or button
		local bigTrinketX = (classIconSize+1)*db.bigTrinketScale
		if (db.classIcon and db.auraPos == "RIGHT" and db.targetIcon) then bigTrinketX = 2*(classIconSize+1)*db.bigTrinketScale end	
		button.bigTrinket:SetPoint("TOPRIGHT", parent ,"TOPRIGHT", bigTrinketX, 0)

		if (db.trinketDisplay ~= "bigIcon" or not db.trinketStatus) then
			button.bigTrinket:Hide()
		else
			button.bigTrinket:Show()
		end
		
		--small trinket icon
		button.smallTrinket:SetWidth(db.manaBarHeight)
		button.smallTrinket:SetHeight(db.manaBarHeight)
		button.smallTrinket:SetTexture(self:GetTrinketIcon("player", false))
		button.smallTrinket:ClearAllPoints()
		button.smallTrinket:SetPoint("LEFT",button.mana,"RIGHT")
		
		if (db.trinketDisplay ~= "smallIcon" or not db.trinketStatus) then
			button.smallTrinket:Hide()
		else
			button.smallTrinket:Show()
		end
		
		--grid trinket icon
		button.gridTrinket:SetWidth(db.manaBarHeight)
		button.gridTrinket:SetHeight(db.manaBarHeight)
		button.gridTrinket:ClearAllPoints()
		button.gridTrinket:SetPoint("LEFT",button.mana,"RIGHT")
		
		if (db.trinketDisplay ~= "gridIcon") then
			button.gridTrinket:Hide()
		else
			button.gridTrinket:Show()
		end
		
		-- cooldown frame
		if ( db.trinketStatus and ( db.trinketDisplay == "overrideIcon" or db.trinketDisplay == "bigIcon" or db.trinketDisplay == "smallIcon" or db.trinketDisplay == "gridIcon" ) ) then 
			button.cooldownFrame:ClearAllPoints()
			
			if ( db.trinketDisplay == "overrideIcon" ) then
				button.cooldownFrame:SetAllPoints(button.overrideTrinket)
				button.cooldownFrame:SetWidth(classIconSize)
				button.cooldownFrame:SetHeight(classIconSize+1)	
			elseif ( db.trinketDisplay == "bigIcon" ) then
				button.cooldownFrame:SetWidth(classIconSize)
				button.cooldownFrame:SetHeight(classIconSize+1)	
				button.cooldownFrame:SetAllPoints(button.bigTrinket)
			elseif ( db.trinketDisplay == "smallIcon" ) then
				button.cooldownFrame:SetWidth(db.manaBarHeight)
				button.cooldownFrame:SetHeight(db.manaBarHeight)	
				button.cooldownFrame:SetAllPoints(button.smallTrinket)
			elseif ( db.trinketDisplay == "gridIcon" ) then
				button.cooldownFrame:SetWidth(db.manaBarHeight)
				button.cooldownFrame:SetHeight(db.manaBarHeight)	
				button.cooldownFrame:SetAllPoints(button.gridTrinket)
			end
			
			button.cooldownFrame:Show()
		else
			button.cooldownFrame:Hide()
		end
      
        -- diminishing return frame
		if (db.drCooldown) then
            -- frame position
            local anchor = db.drCooldownAnchor == "CENTER" and "" or db.drCooldownAnchor
         
            button.drCooldownFrame:ClearAllPoints()
            
            if (db.drCooldownPos == "RIGHT") then
                if (db.trinketStatus and db.trinketDisplay == "bigIcon") then
                    button.drCooldownFrame:SetPoint("TOPLEFT", button.bigTrinket, "TOPRIGHT", db.drMargin, -1)
                else
                    button.drCooldownFrame:SetPoint("TOPLEFT", button, "TOPRIGHT", db.drMargin, -1)
                end
            else
                button.drCooldownFrame:SetPoint("TOPRIGHT", button, "TOPLEFT", -db.drMargin, -1)
            end
            
            button.drCooldownFrame:SetHeight(db.barHeight+extraBarHeight)
            button.drCooldownFrame:SetWidth(db.barHeight+extraBarHeight)    
         
            -- Update each cooldown icon
            for i=1,16 do
                local icon = button.drCooldownFrame["icon"..i]
            
                -- adjust cooldown to the frame height 
                if (db.drIconAdjust) then
                    icon:SetHeight(button.drCooldownFrame:GetHeight())
                    icon:SetWidth(button.drCooldownFrame:GetWidth())
                else
                    icon:SetHeight(db.drIconSize)
                    icon:SetWidth(db.drIconSize)
                end
            
                -- omniCC disabled cooldown count
                icon.cooldown.noCooldownCount = true
            
                -- text
                icon.text:SetFont(LSM:Fetch(LSM.MediaType.FONT, db.drFont), db.drFontSize, "OUTLINE")
                icon.text:SetTextColor(db.drFontColor.r, db.drFontColor.g, db.drFontColor.b, db.drFontColor.a)
                icon.timeLeftText:SetFont(LSM:Fetch(LSM.MediaType.FONT), db.drFontSize - 3, "OUTLINE")
                icon.timeLeftText:SetTextColor(db.drFontColor.r, db.drFontColor.g, db.drFontColor.b, db.drFontColor.a)
                icon:ClearAllPoints()
            
                -- position
                if (db.drCooldownPos == "RIGHT") then
                    if (i == 1) then
                        icon:SetPoint(anchor .. "LEFT", button.drCooldownFrame)
                    else
                        icon:SetPoint("LEFT", button.drCooldownFrame["icon" .. (i - 1)], "RIGHT", db.drMargin - 5, 0)
                    end
                else
                    if (i == 1) then
                        icon:SetPoint(anchor .. "RIGHT", button.drCooldownFrame)
                    else
                        icon:SetPoint("RIGHT", button.drCooldownFrame["icon" .. (i - 1)], "LEFT", -db.drMargin + 5, 0)
                    end
                end
            
                -- reset stuff
                if (icon.active) then
                    icon.active = false            
                    icon.cooldown:SetCooldown(GetTime(), 0)
                    icon:SetScript("OnUpdate", nil)
                end
            
                icon.type = nil
                icon.active = nil
                icon:SetAlpha(1)
                icon.text:SetText("")
                icon.texture:SetTexture(select(3, GetSpellInfo(118)))
                StyleActionButton(icon)

                -- testing? Show the icons
                if (not self.frame.testing or i > 5) then               
                    icon:Hide()
                else
                    if (db.drText) then
                        icon.text:SetText("1/2")
                        icon.timeLeftText:SetText("15")
                    end
               
                    icon.active = true
                    icon:Show()
                end
            end
            button.drCooldownFrame:Show()
        else
            button.drCooldownFrame:Hide()
        end
		
		--do some extra updates if the frame is in test mode
		if (self.frame.testing) then
			button.raceText:SetText("")
			
			--set the class/race text
			if (db.raceText) then
				button.raceText:SetText(button.raceLoc)
			end
			
			--set health text
			local currentHealth, maxHealth = button.healthActual, button.healthMax
			local healthPercent = button.healthPercentage
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
						
			--set the mana text
			local currentMana, maxMana = button.manaActual, button.manaMax
			local manaPercent = button.manaPercentage
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
            
            self:DRPositionIcons("arena" .. i)
			
			if ( db.manaPercentage) then
				if ( manaText ) then
					manaText = string.format("%s (%d%%)", manaText, manaPercent)
				else
					manaText = string.format("%d%%", manaPercent)
				end		
			end
			
			button.manaText:SetText(manaText)
			
			--Trinket text toggling
			if (not db.trinketStatus or (db.trinketDisplay ~= "nameText" and db.trinketDisplay ~= "nameIcon")) then
				button.trinket:SetText("")
			else
				local text = db.trinketDisplay == "nameText" and " (t)" or self:GetTrinketIcon("player", true)
				local alpha = db.trinketDisplay == "nameText" and 1 or 0.5
				button.trinket:SetText(text)
				button.trinket:SetAlpha(alpha)
			end

		end
		
	end
    
    self:PLAYER_TARGET_CHANGED()
    self:PLAYER_FOCUS_CHANGED()
end

function Gladdy:ToggleFrame(i)
	self:ClearAllUnits()
	if (self.frame and self.frame:IsShown() and i == self.currentBracket) then
		self:UnregisterAllEvents()
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
		self.frame:Hide()
		self.frame.testing = false
	else
		self.currentBracket = i
		if ( not self.frame ) then
			self:CreateFrame()
		end
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterEvent("PLAYER_FOCUS_CHANGED")
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		self:RegisterEvent("UNIT_AURA")
		self.frame:Show()
		self.frame.testing = true
		self:Test()
		self:UpdateFrame()
		Gladdy:UpdateBindings()
	end
end

function Gladdy:HideFrame()
	if ( self.frame ) then
		self.frame:Hide()
		self.frame.testing = false
	end
	self:UnregisterAllEvents()
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
	self.currentBracket = nil
end