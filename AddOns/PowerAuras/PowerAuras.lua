-- -------------------------------------------
--            << Power Auras >>
--              Par -Sinsthar-
--    [Ziya/Tiven - serveur Fr - Kirin Tor] 
--
--     Effets visuels autour du personnage 
--     en cas de buff, debuff et autres...
-- -------------------------------------------

PowaVersion = "v2.46"

CurrentAura = 1;
CurrentSecondeAura = 0;
MaxAuras = 360;
SecondeAura = 0;
CurrentTestAura = 361;

PowaEnabled = 0;
PowaModTest = false; -- on test les effets

Powa_FramesVisibleTime = {}; -- visible ou pas

PowaMisc = {
		disabled = false,
		debug = false,
		maxeffects = 100,

		BTimerX = 0,
		BTimerY = 0,
		BTimerA = 1.00,
		BTimerScale = 1.00,
		BCents = true,
		Bdual = false,
		DTimerX = 0,
		DTimerY = 0,
		DTimerA = 1.00,
		DTimerScale = 1.00,
		DCents = true,
		Ddual = false
	   };

PowaTimer = {};
for i = 1, 5 do
	PowaTimer[i] = {
		x = 0, -- new
		y = 0,
		a = 1.00,
		h = 1.0,
		cents = true,
		dual = false
	    };
end

PowaGlobal = {maxtextures = 50}

PowaSet = {};
for i = 0, 1 do
	PowaSet[i] = { -- ici
		off = false,
		combat = 0,
		wowtex = false,
		customtex = false,
		customname = "",
		texture = 1,
		texmode = 1,
		icon = "",
		anim1 = 1,
		anim2 = 0,
		speed = 1.00,
		begin = 0,
		finish = 1,
		duration = 0,
		alpha = 0.75,
		size = 0.75,
		torsion = 1,
        realaura = 1,
		symetrie = 0,
		x = 0,
		y = -30,
		buffname = "",
		bufftype = 1,		
		isdebuff = false,
		isdebufftype = false,
		isenchant = false,
		target = false,
		targetfriend = false,
		-- added variables
		exact = false,
        party = false,
        raid = false,
        focus = false,
        optunitn = false,
		gcd = false,
        unitn = "",
		threshold = 0,
		sound = 0,
		soundfile = "",
		customsound = "",
		stance = 10,
		stacks = 0,
		stacksOperator = "=",
		isinraid = false,
		ismounted = false,
		-- ----------
		timer = false,
		numtimer = 1,
		timerduration = 0,
		inverse = false,
		ignoremaj = true,		
		opt1 = 0,
		opt2 = 0,
		r = 1.0,
		g = 1.0,
		b = 1.0
	};
end

-- checks des buffs
DoCheckBuffs = false;
DoCheckTargetBuffs = false;
DoCheckPartyBuffs = false;
DoCheckRaidBuffs = false;
DoCheckUnitBuffs = false;
DoCheckFocusBuffs = false;

DoCheckHealth = false;
DoCheckTargetHealth = false;
DoCheckPartyHealth = false;
DoCheckRaidHealth = false;
DoCheckFocusHealth = false;

DoCheckMana = false;
DoCheckTargetMana = false;
DoCheckPartyMana = false;
DoCheckRaidMana = false;
DoCheckFocusMana = false;

DoCheckOthers = false;
DoCheckCombo = false;
DoCheckAoe = false;
DoResetAoe = false;
ResetTargetTimers = false;

DoCheckStance = false;
DoCheckAction = false;
DoCheckEnchant = false;

DoCheckMounted = false;

-- liste des effets dans l'editeur par type
ListBuffs = {};
ListBuffsMax = 0;
ListTargetBuffs = {};
ListTargetBuffsMax = 0;
ListPartyBuffs = {};
ListPartyBuffsMax = 0;
ListRaidBuffs = {};
ListRaidBuffsMax = 0;
ListUnitBuffs = {};
ListUnitBuffsMax = 0;
ListFocusBuffs = {};
ListFocusBuffsMax = 0;

ListEnchants = {};
ListEnchantsMax = 0;

ListCombo = {};
ListComboMax = 0;

ListAoe = {};
ListAoeMax = 0;

ListActions = {};
ListActionsMax = 0;

ListHealth = {};
ListHealthMax = 0;
ListTargetHealth = {};
ListTargetHealthMax = 0;
ListFocusHealth = {};
ListFocusHealthMax = 0;
ListPartyHealth = {};
ListPartyHealthMax = 0;
ListRaidHealth = {};
ListRaidHealthMax = 0;

ListMana = {};
ListManaMax = 0;
ListTargetMana = {};
ListTargetManaMax = 0;
ListFocusMana = {};
ListFocusManaMax = 0;
ListPartyMana = {};
ListPartyManaMax = 0;
ListRaidMana = {};
ListRaidManaMax = 0;

ListStance = {};
ListStanceMax = 0;

WeAreInCombat = false;
WeAreInRaid = false;
WeAreMounted = false;
AuraHide = false;

AoeAuraAdded = "";
AoeAuraFaded = "";

ChecksTimer = 0;  -- [mode lourd]
NextCheck = 0.5; -- {mode lourd] nombre de secondes entre les checks

DebugTimer = 0;

local minimapPlayerModel;	-- For calculating player heading
local minimapRingModel;		-- For calculating minimap rotation


-- ---------------------------------------------------------------------------------------------

function Powa_OnLoad()

	-- Registering Events -- 
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
    this:RegisterEvent("PLAYER_FOCUS_CHANGED");
    this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
	this:RegisterEvent("ACTIONBAR_UPDATE_USABLE");

	Powa_Frames = {};
	Powa_textures = {};

	-- options init
	SlashCmdList["POWA"] = Powa_ShowMainOptions;
	SLASH_POWA1 = "/powa";
    
	
end

function PowaDebug(msg)
	if (PowaMisc.debug == true) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function PowaDebug2(msg)
	getglobal("PowaDebugMessagesText"):SetText(msg);
end

-- ----------------------------------------------------------------------------------------- EVENT

function Powa_OnEvent()  

  	if event == "PLAYER_ENTERING_WORLD" then
	  	Powa_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");

	  	DoCheckBuffs = true;	  	
	  	DoCheckOthers = true;		
	  	DoCheckCombo = true;
		-- added
		DoCheckTargetBuffs = true;
	  	DoCheckPartyBuffs = true;
      	DoCheckRaidBuffs = true;
      	DoCheckUnitBuffs = true;
      	DoCheckFocusBuffs = true;
		DoCheckHealth = true;
		DoCheckMana = true;
		DoCheckStance = true;
		DoCheckAction = true;
		DoCheckEnchant = true;
		if (GetNumRaidMembers() > 0) then
			WeAreInRaid = true;
		else
			WeAreInRaid = false;
		end
		if IsMounted() then
			WeAreMounted = true;
		else
			WeAreMounted = false;
		end
		
		Powa_MemorizeActions(0);
		
	elseif event == "PARTY_MEMBERS_CHANGED" then	  
		DoCheckPartyBuffs = true;
		DoCheckPartyHealth = true;
		DoCheckPartyMana = true;
		
	elseif event == "RAID_ROSTER_UPDATE" then	  
		DoCheckRaidBuffs = true;
		DoCheckRaidHealth = true;
		DoCheckRaidMana = true;	
		if GetNumRaidMembers() > 0 then
			WeAreInRaid = true;
		else
			WeAreInRaid = false;
		end
			
		
	elseif event == "UNIT_HEALTH" then
		if (PowaModTest == false) then
		    if (arg1 == "target") then
			    DoCheckTargetHealth = true;				
            elseif (arg1 == "focus") then             
		        DoCheckFocusHealth = true;				
			elseif (arg1 == "party1" or arg1 == "party2" or arg1 == "party3" or arg1 == "party4") then              
		        DoCheckPartyHealth = true;  				
			elseif ("raid" == string.sub(arg1, 1, 4)) then              
		        DoCheckRaidHealth = true;				
	        else
			    DoCheckHealth = true; -- active les checks		
	        end
	    end
		
	elseif event == "UNIT_MANA" then
		if (PowaModTest == false) then
		    if (arg1 == "target") then
			    DoCheckTargetMana = true;				
            elseif (arg1 == "focus") then             
		        DoCheckFocusMana = true;				
			elseif (arg1 == "party1" or arg1 == "party2" or arg1 == "party3" or arg1 == "party4") then             
		        DoCheckPartyMana = true;  				
			elseif ("raid" == string.sub(arg1, 1, 4)) then
		        DoCheckRaidMana = true;				
	        else
			    DoCheckMana = true; -- active les checks		
	        end
	    end	
		
	elseif event == "PLAYER_FOCUS_CHANGED" then	  
		DoCheckFocusBuffs = true;
		
	elseif event == "VARIABLES_LOADED" then
		DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r |cffffff00"..PowaVersion.."|r - "..PowaText.welcome);
	
		Powa_InitTabs(); -- verifie en cas de rajout d'effets que tous sont initialises (sinon ca bug :P)
		Powa_LoadGlobalStats();
		Powa_CreateFrames(0); -- cree la frame 0 (secondaire)
	
		PowaGlobal.maxtextures = 50;
		getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1, PowaGlobal.maxtextures);
		getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaGlobal.maxtextures);
	
		PowaEnabled = 1;
		Powa_CreateTimer();
		Powa_CreateEffectLists();

    elseif event == "UNIT_AURA" then  -- Buffs changed
	    if (PowaModTest == false) then
			PowaDebug("Unit_aura fired.");
			if IsMounted() then
				WeAreMounted = true;
			else
				WeAreMounted = false;
			end
		    if (arg1 == "target") then
			    DoCheckTargetBuffs = true;
	        elseif (arg1 == "party1" or arg1 == "party2" or arg1 == "party3" or arg1 == "party4") then
		        DoCheckPartyBuffs = true;
            elseif (arg1 == "focus") then
              -- DEFAULT_CHAT_FRAME:AddMessage("focusbuffs event");
		        DoCheckFocusBuffs = true;
            elseif (string.sub(arg1, 1, 4) == "raid") then
				-- DEFAULT_CHAT_FRAME:AddMessage("raidbuffs event");
		        DoCheckRaidBuffs = true;       
	        elseif (arg1 == "player") then
				
				 -- active les checks
			else
				DoCheckUnitBuffs = true;
	        end
	    end
        
	elseif event == "PLAYER_AURAS_CHANGED" then -- Player buff debuff changed
		if (PowaModTest == false) then
			PowaDebug("Player_auras_changed fired.");
			DoCheckBuffs = true;
		end		
	
    elseif event == "PLAYER_DEAD" then -- Player dead
		DoCheckAoe = true;
		DoResetAoe = true;
		DoCheckEnchant = true;
		WeAreMounted = false;
		DoCheckAction = true;
	 
    elseif event == "PLAYER_TARGET_CHANGED" then  --Target changed
		if (PowaModTest == false) then
			DoCheckTargetBuffs = true;
			DoCheckTargetHealth = true;
			DoCheckTargetMana = true;
			ResetTargetTimers = true;
			DoCheckAction = true;
		end
	 
    elseif event == "PLAYER_REGEN_DISABLED" then  -- ic
		if (PowaModTest == false) then
			WeAreInCombat = true;
			DoCheckOthers = true;
			DoCheckEnchant = true;
			DoCheckTargetBuffs = true;
			DoCheckBuffs = true;
			DoCheckAction = true;
		end	   
	   
    elseif event == "PLAYER_REGEN_ENABLED" then -- ooc
		if (PowaModTest == false) then
			WeAreInCombat = false;
			DoCheckOthers = true;
			DoCheckEnchant = true;
			DoCheckTargetBuffs = true;
			DoCheckBuffs = true;
			DoCheckAction = true;
		end
     
	elseif event == "PLAYER_COMBO_POINTS" then -- combopoints changed
		if (PowaModTest == false) then
			DoCheckCombo = true; -- active les checks
		end
	   
	elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" then
		if (PowaModTest == false) then
			local nText = arg1;
			-- choppe le nom du debuff
			nText = string.gsub(AURAADDEDSELFHARMFUL,"([%^%(%)%[%]%*%+%-%?])","%%%1");
			nText = string.gsub(nText, "%%s", "(.+)");
			-- verifie que le dispell vient pas du pet
			if (UnitName("Pet") ~= nil) then -- si on a un pet
				if (string.find(arg1, UnitName("Pet")) ) then 
					return;
				end
			end
			for aoename in string.gmatch(arg1, nText) do
				AoeAuraAdded = aoename;
				DoCheckAoe = true;
			end
		end -- if
	   
  	elseif event == "CHAT_MSG_SPELL_AURA_GONE_SELF" then
	   	if (PowaModTest == false) then
		  	local nText = arg1;
		  	-- choppe le nom du buff fini
		  	nText = string.gsub(AURAREMOVEDSELF,"([%^%(%)%[%]%*%+%-%?])","%%%1");
		  	nText = string.gsub(nText, "%%s", "(.+)");
		  	-- verifie que le dispell vient pas du pet
		  	if (UnitName("Pet") ~= nil) then -- si on a un pet
			  	if (string.find(arg1, UnitName("Pet")) ) then 
				  	return;
			  	end
		  	end
		  	for aoename in string.gmatch(arg1, nText) do
			  	AoeAuraFaded = aoename;
			  	DoCheckAoe = true;
		  	end
	   	end -- if
	   
  	elseif event == "ACTIONBAR_SLOT_CHANGED" then
		Powa_MemorizeActions(arg1);
		
	elseif event == "ACTIONBAR_UPDATE_USABLE" then
		if (PowaModTest == false) then
			PowaDebug("ACTIONBAR_UPDATE_USABLE");
			DoCheckAction = true;
			DoCheckStance = true;
			if IsMounted() then
				WeAreMounted = true;
			else
				WeAreMounted = false;
			end
		end
		  
	elseif event == "UPDATE_SHAPESHIFT_FORMS" then
		if (PowaModTest == false) then
			PowaDebug("UPDATE_SHAPESHIFT_FORMS");
			DoCheckStance = true;
		end
  	end
end  -- function

-- -------------------------------------------------------------------------

function Powa_InitTabs()
	Powa_DefautAura(0);
	if (PowaMisc.BTimerX) then
		if (PowaMisc.BTimerX ~= nil) then PowaTimer[1].x = PowaMisc.BTimerX; PowaMisc.BTimerX = nil end
		if (PowaMisc.BTimerY ~= nil) then PowaTimer[1].y = PowaMisc.BTimerY; PowaMisc.BTimerY = nil; end
		if (PowaMisc.BTimerA ~= nil) then PowaTimer[1].a = PowaMisc.BTimerA; PowaMisc.BTimerA = nil; end
		if (PowaMisc.BTimerScale ~= nil) then PowaTimer[1].h = PowaMisc.BTimerScale; PowaMisc.BTimerScale = nil; end
		if (PowaMisc.BCents ~= nil) then PowaTimer[1].cents = PowaMisc.BCents; PowaMisc.BCents = nil; end
		if (PowaMisc.Bdual ~= nil) then PowaTimer[1].dual = PowaMisc.Bdual; PowaMisc.Bdual = nil; end

		if (PowaMisc.DTimerX ~= nil) then PowaTimer[2].x = PowaMisc.DTimerX; PowaMisc.DTimerX = nil; end
		if (PowaMisc.DTimerY ~= nil) then PowaTimer[2].y = PowaMisc.DTimerY; PowaMisc.DTimerY = nil; end
		if (PowaMisc.DTimerA ~= nil) then PowaTimer[2].a = PowaMisc.DTimerA; PowaMisc.DTimerA = nil; end
		if (PowaMisc.DTimerScale ~= nil) then PowaTimer[2].h = PowaMisc.DTimerScale; PowaMisc.DTimerScale = nil; end
		if (PowaMisc.DCents ~= nil) then PowaTimer[2].cents = PowaMisc.DCents; PowaMisc.DCents = nil; end
		if (PowaMisc.Ddual ~= nil) then PowaTimer[2].dual = PowaMisc.Ddual; PowaMisc.Ddual = nil; end
	end

	for i = 1, 5 do
		if (PowaTimer[i].x == nil) then PowaTimer[i].x = 0; end
		if (PowaTimer[i].y == nil) then PowaTimer[i].y = 0; end
		if (PowaTimer[i].a == nil) then PowaTimer[i].a = 1.00; end
		if (PowaTimer[i].h == nil) then PowaTimer[i].h = 1.00; end
		if (PowaTimer[i].cents == nil) then PowaTimer[i].cents = false; end
		if (PowaTimer[i].dual == nil) then PowaTimer[i].dual = false; end
	end
end

-- ---------------------------------------------------------------------------

function Powa_CreateFrames(xnum)

    if (Powa_Frames[xnum]) then
    	-- deja cree, ne fait rien
    else
    	-- Frame -- 
    	Powa_Frames[xnum] = CreateFrame("Frame","Frame"..xnum);
	    Powa_Frames[xnum]:SetFrameStrata("LOW");

    	Powa_Frames[xnum]:Hide();  

    	-- Texture --
    	Powa_textures[xnum] = Powa_Frames[xnum]:CreateTexture(nil,"BACKGROUND");
    	Powa_textures[xnum]:SetBlendMode("ADD");

    	Powa_textures[xnum]:SetAllPoints(Powa_Frames[xnum]); -- attache la texture a la frame
    	Powa_Frames[xnum].texture = Powa_textures[xnum];
 	    Powa_Frames[xnum].baseL = 256;
	    Powa_Frames[xnum].baseH = 256;

    	Powa_FramesVisibleTime[xnum] = 0;
    end
  
end

Powa_Timer = {};
Powa_Timer2 = {};
Powa_timertex = {};
Powa_timertex2 = {};
Tstep = 0.09765625;

function Powa_CreateTimer()
    for i = 1, 5 do
	Powa_Timer[i] = CreateFrame("Frame","Timer"..i);
	Powa_Timer[i]:SetFrameStrata("LOW");
	Powa_Timer[i]:Hide(); 

	Powa_timertex[i] = Powa_Timer[i]:CreateTexture(nil,"BACKGROUND");
	Powa_timertex[i]:SetBlendMode("ADD");

	Powa_timertex[i]:SetAllPoints(Powa_Timer[i]); -- attache la texture a la frame
	Powa_Timer[i].texture = Powa_timertex[i];

	Powa_timertex[i]:SetTexture("Interface\\Addons\\PowerAuras\\timers.tga");

	-- idem pour les secondes
	Powa_Timer2[i] = CreateFrame("Frame","Timer2"..i);
	Powa_Timer2[i]:SetFrameStrata("LOW");
	Powa_Timer2[i]:Hide(); 

	Powa_timertex2[i] = Powa_Timer2[i]:CreateTexture(nil,"BACKGROUND");
	Powa_timertex2[i]:SetBlendMode("ADD");

	Powa_timertex2[i]:SetAllPoints(Powa_Timer2[i]); -- attache la texture a la frame
	Powa_Timer2[i].texture = Powa_timertex2[i];

	Powa_timertex2[i]:SetTexture("Interface\\Addons\\PowerAuras\\timers.tga");
    end
    Powa_UpdateOptionsTimer();
end

-- ------------------------------------------------------------------------------------ CREE LA LISTE DES CHECKS

function Powa_CreateEffectLists()
	ListBuffsMax = 0;
	ListTargetBuffsMax = 0;
	ListPartyBuffsMax = 0;
    ListRaidBuffsMax = 0;
    ListUnitBuffsMax = 0;
    ListFocusBuffsMax = 0;
	ListEnchantsMax = 0;
	ListComboMax = 0;
	ListAoeMax = 0;	
	ListActionsMax = 0;
	ListHealthMax = 0;
	ListManaMax = 0;
	ListFocusHealthMax = 0;
	ListFocusManaMax = 0;
	ListTargetHealthMax = 0;
	ListTargetManaMax = 0;
	ListPartyHealthMax = 0;
	ListPartyManaMax = 0;
	ListRaidHealthMax = 0;
	ListRaidManaMax = 0;
	ListStanceMax= 0;
	
	for i = 1, MaxAuras do
		if (PowaMisc.disabled == true) then
			-- si desactif, ne fait rien
		elseif (PowaSet[i] == nil or PowaSet[i].buffname == "" or PowaSet[i].buffname == " " or PowaSet[i].off == true) then
			-- rien si vide ou pas actif
			
			-- Self Buffs
		elseif (PowaSet[i].bufftype == 1 
        and not PowaSet[i].target 
        and not PowaSet[i].targetfriend 
        and not PowaSet[i].party
		and not PowaSet[i].raid
        and not PowaSet[i].focus
        and not PowaSet[i].optunitn) 
        then -- self-buff
			ListBuffsMax = ListBuffsMax + 1;
			ListBuffs[ListBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 2 
        and not PowaSet[i].target 
        and not PowaSet[i].targetfriend 
        and not PowaSet[i].party 
		and not PowaSet[i].raid 
        and not PowaSet[i].focus
        and not PowaSet[i].optunitn) 
        then -- self-debuff
			ListBuffsMax = ListBuffsMax + 1;
			ListBuffs[ListBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 3
        and not PowaSet[i].target
        and not PowaSet[i].targetfriend
        and not PowaSet[i].party
		and not PowaSet[i].raid
        and not PowaSet[i].focus
        and not PowaSet[i].optunitn)
        then -- self-debufftype
			ListBuffsMax = ListBuffsMax + 1;
			ListBuffs[ListBuffsMax] = i;
			
			-- Party Buffs
		elseif (PowaSet[i].bufftype == 1 and PowaSet[i].party) then -- partybuff cible
			ListPartyBuffsMax = ListPartyBuffsMax + 1;
			ListPartyBuffs[ListPartyBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 2 and PowaSet[i].party) then -- partydebuff cible
			ListPartyBuffsMax = ListPartyBuffsMax + 1;
			ListPartyBuffs[ListPartyBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 3 and PowaSet[i].party) then -- partydebufftype cible
			ListPartyBuffsMax = ListPartyBuffsMax + 1;
			ListPartyBuffs[ListPartyBuffsMax] = i;
            
            -- Focus Buffs
		elseif (PowaSet[i].bufftype == 1 and PowaSet[i].focus) then
			ListFocusBuffsMax = ListFocusBuffsMax + 1;
			ListFocusBuffs[ListFocusBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 2 and PowaSet[i].focus) then        
			ListFocusBuffsMax = ListFocusBuffsMax + 1;
			ListFocusBuffs[ListFocusBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 3 and PowaSet[i].focus) then
			ListFocusBuffsMax = ListFocusBuffsMax + 1;
			ListFocusBuffs[ListFocusBuffsMax] = i;
            
            -- Raid Buffs
		elseif (PowaSet[i].bufftype == 1 and PowaSet[i].raid) then -- partybuff cible
			ListRaidBuffsMax = ListRaidBuffsMax + 1;
			ListRaidBuffs[ListRaidBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 2 and PowaSet[i].raid) then -- partydebuff cible
			ListRaidBuffsMax = ListRaidBuffsMax + 1;
			ListRaidBuffs[ListRaidBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 3 and PowaSet[i].raid) then -- partydebufftype cible
			ListRaidBuffsMax = ListRaidBuffsMax + 1;
			ListRaidBuffs[ListRaidBuffsMax] = i;
            
            -- Unit Buffs
		elseif (PowaSet[i].bufftype == 1 and PowaSet[i].optunitn) then -- partybuff cible
			ListUnitBuffsMax = ListUnitBuffsMax + 1;
			ListUnitBuffs[ListUnitBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 2 and PowaSet[i].optunitn) then -- partydebuff cible
			ListUnitBuffsMax = ListUnitBuffsMax + 1;
			ListUnitBuffs[ListUnitBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 3 and PowaSet[i].optunitn) then -- partydebufftype cible
			ListUnitBuffsMax = ListUnitBuffsMax + 1;
			ListUnitBuffs[ListUnitBuffsMax] = i;
                    			
			-- Target Buffs
		elseif (PowaSet[i].bufftype == 1 and (PowaSet[i].target or PowaSet[i].targetfriend)) then -- buff cible
			ListTargetBuffsMax = ListTargetBuffsMax + 1;
			ListTargetBuffs[ListTargetBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 2 and (PowaSet[i].target or PowaSet[i].targetfriend)) then -- debuff cible
			ListTargetBuffsMax = ListTargetBuffsMax + 1;
			ListTargetBuffs[ListTargetBuffsMax] = i;
		elseif (PowaSet[i].bufftype == 3 and (PowaSet[i].target or PowaSet[i].targetfriend)) then -- debufftype cible
			ListTargetBuffsMax = ListTargetBuffsMax + 1;
			ListTargetBuffs[ListTargetBuffsMax] = i;
			
			--Other Events
		elseif (PowaSet[i].bufftype == 4) then -- AOE
			ListAoeMax = ListAoeMax + 1;
			ListAoe[ListAoeMax] = i;
			
		elseif (PowaSet[i].bufftype == 5) then -- Enchants
			ListEnchantsMax = ListEnchantsMax + 1;
			ListEnchants[ListEnchantsMax] = i;
			
		elseif (PowaSet[i].bufftype == 6) then -- Combo
			ListComboMax = ListComboMax + 1;
			ListCombo[ListComboMax] = i;
			
		elseif (PowaSet[i].bufftype == 7) then -- Actions ready
			ListActionsMax = ListActionsMax + 1;
			ListActions[ListActionsMax] = i;
		
		-- Health + Mana auralists	
		elseif (PowaSet[i].bufftype == 8 
        and not PowaSet[i].target 
        and not PowaSet[i].targetfriend 
        and not PowaSet[i].party 
		and not PowaSet[i].raid 
        and not PowaSet[i].focus
        and not PowaSet[i].optunitn) 
        then -- self-health
			ListHealthMax = ListHealthMax + 1;
			ListHealth[ListHealthMax] = i;
		
		elseif (PowaSet[i].bufftype == 9
        and not PowaSet[i].target
        and not PowaSet[i].targetfriend
        and not PowaSet[i].party
		and not PowaSet[i].raid
        and not PowaSet[i].focus
        and not PowaSet[i].optunitn)
        then -- self-mana
			ListManaMax = ListManaMax + 1;
			ListMana[ListManaMax] = i;
			
		elseif (PowaSet[i].bufftype == 8 and PowaSet[i].focus) then -- focushealth      
			ListFocusHealthMax = ListFocusHealthMax + 1;
			ListFocusHealth[ListFocusHealthMax] = i;
		elseif (PowaSet[i].bufftype == 9 and PowaSet[i].focus) then -- focusmana
			ListFocusManaMax = ListFocusManaMax + 1;
			ListFocusMana[ListFocusManaMax] = i;
			
		elseif (PowaSet[i].bufftype == 8 and (PowaSet[i].target or PowaSet[i].targetfriend)) then -- TargetHealth
			ListTargetHealthMax = ListTargetHealthMax + 1;
			ListTargetHealth[ListTargetHealthMax] = i;
		elseif (PowaSet[i].bufftype == 9 and (PowaSet[i].target or PowaSet[i].targetfriend)) then -- TargetMana
			ListTargetManaMax = ListTargetManaMax + 1;
			ListTargetMana[ListTargetManaMax] = i;	
			
		elseif (PowaSet[i].bufftype == 8 and PowaSet[i].party) then -- partyhealth
			ListPartyHealthMax = ListPartyHealthMax + 1;
			ListPartyHealth[ListPartyHealthMax] = i;
		elseif (PowaSet[i].bufftype == 9 and PowaSet[i].party) then -- partymana
			ListPartyManaMax = ListPartyManaMax + 1;
			ListPartyMana[ListPartyManaMax] = i;
			
		elseif (PowaSet[i].bufftype == 8 and PowaSet[i].raid) then -- raidhealth
			ListRaidHealthMax = ListRaidHealthMax + 1;
			ListRaidHealth[ListRaidHealthMax] = i;
		elseif (PowaSet[i].bufftype == 9 and PowaSet[i].raid) then -- raidmana
			ListRaidManaMax = ListRaidManaMax + 1;
			ListRaidMana[ListRaidManaMax] = i;
			
		elseif (PowaSet[i].bufftype == 10) then -- stance
			ListStanceMax = ListStanceMax + 1;
			ListStance[ListStanceMax] = i;
		    
		end	
		-- ------------------
	end -- end for i = 1, MaxAuras

PowaDebug("Buffs : "..ListBuffsMax.." / Target Buffs : "..ListTargetBuffsMax.."/ Focus Buffs : "..ListFocusBuffsMax.." / Party Buffs : "..ListPartyBuffsMax.." / Raid Buffs : "..ListRaidBuffsMax.." / AOE Debuff : "..ListAoeMax.." / Enchants : "..ListEnchantsMax.." / Combos : "..ListComboMax.." / Actions : "..ListActionsMax.." / Health : "..ListHealthMax.." / Mana : "..ListManaMax.." / Stance : "..ListStanceMax);
end
-- ------------------------------------------------------------------------------------ Memorize les actions
function Powa_MemorizeActions(anum)
	local imin, imax;
	PowaDebug("--MemorizeActions--");
	if (ListActionsMax == 0) then
		return;
	end
	
	-- scan tout ou uniquement le slot qui a change
	if (anum == 0) then
		PowaDebug("--Scan all Actionbuttons--");
		imin = 1;
		imax = 120;
		-- reset tout
		for j = 1, ListActionsMax do
			PowaSet[ListActions[j]].opt1 = 0;
		end
	else
		imin = anum;
		imax = anum;
	end

	for i = imin, imax do
		if (HasAction(i)) then
			PowaDebug("--Has Action on button"..i.."--");
			PowaAction_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
		 	PowaAction_Tooltip:SetAction(i);
			local mytextline = getglobal("PowaAction_TooltipTextLeft1");		
			local text = mytextline:GetText();				
			if (text ~= "") and (text ~= nil) then
				PowaDebug("| "..text.." |");
			end	
			if (PowaAction_TooltipTextLeft1:IsShown()) then
				PowaDebug(PowaAction_TooltipTextLeft1:GetText());
				for j = 1, ListActionsMax do
					if((PowaSet[ListActions[j]].ignoremaj == true  and string.find(string.upper(PowaAction_TooltipTextLeft1:GetText()), string.upper(PowaSet[ListActions[j]].buffname), 1, true)) or
					   (PowaSet[ListActions[j]].ignoremaj == false and string.find(PowaAction_TooltipTextLeft1:GetText(), PowaSet[ListActions[j]].buffname, 1, true)) ) then -- on a trouve le slot
						PowaSet[ListActions[j]].opt1 = i; -- memorize le slot
						PowaDebug("----------------------------------");
						PowaDebug("Actionname="..PowaSet[ListActions[j]].buffname.." / Search in Tooltipstring="..PowaAction_TooltipTextLeft1:GetText());
						-- prend la texture
						if (PowaSet[ListActions[j]].icon == "") then
							getglobal("PowaIconTexture"):SetTexture(GetActionTexture(i));
							  PowaSet[ListActions[j]].icon = getglobal("PowaIconTexture"):GetTexture();
						end
					end
				end
			end
			PowaAction_Tooltip:Hide();
		end
	end
end
-- ------------------------------------------------------------------------------------ BUFF CHECKS
function PowaCompareBuffDebuff(xnum)
	local buffIndex, untilCancelled;
	local curhealth, maxhealth, curpercenthp, curmana, maxmana, curpercentmp;
	local typeDebuff;
	local unitidentifikation;
    local buffonpm = 0;
    local numpm = GetNumPartyMembers();
    local numrm = GetNumRaidMembers();
	PowaDebug("numPartymembers="..numpm.." / numRaidmembers="..numpm);
	local stacksOperator = PowaSet[xnum].stacksOperator;
    if stacksOperator == "" then
		stacksOperator = "=";
	end	
    local stacks = PowaSet[xnum].stacks;
	if stacks == "" then
		stacks = "0";
	end	
	
	if (PowaSet[xnum].bufftype == 6) then -- combos
		PowaDebug("Check Combos");
		local nCombo = GetComboPoints();
		if (string.find(PowaSet[xnum].buffname, tostring(nCombo))) then
			Powa_CreateFrames(xnum);
			if (PowaSet[xnum].icon == "") then
			  getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\inv_sword_48");
			  PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
			end
			return true;
		end
	elseif (PowaSet[xnum].bufftype == 8) then -- Health changed
		PowaDebug("Check Health");
        -- Health
        if (PowaSet[xnum].target or PowaSet[xnum].targetfriend) then
			unitidentifikation = "target";
		elseif (PowaSet[xnum].focus) then
			unitidentifikation = "focus";
		elseif (PowaSet[xnum].party) then
			unitidentifikation = "party";
		elseif (PowaSet[xnum].raid) then
			unitidentifikation = "raid";
		else 
			unitidentifikation = "player";
		end	
		PowaDebug("on unit "..unitidentifikation);
		if (unitidentifikation == "player") and not (unitidentifikation == "party") and not (unitidentifikation == "raid") and not (unitidentifikation == "target") and not (unitidentifikation == "focus") then			
			curhealth = UnitHealth(unitidentifikation);
			maxhealth = UnitHealthMax(unitidentifikation);
			curpercenthp = (curhealth / maxhealth) * 100;
			local UnitAlive = true;
			if (UnitIsDeadOrGhost(unitidentifikation)) then
				UnitAlive = false;
			end	
		    if  (curpercenthp < PowaSet[xnum].threshold) and (UnitAlive == true) then			        
				Powa_CreateFrames(xnum);					        
			  	if (PowaSet[xnum].icon == "") then
					getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
				end -- icone
				return true;
			end
		elseif (unitidentifikation == "party") then	
			for pm = 1, numpm do
				partyunitidentifikation = unitidentifikation + pm;
				curhealth = UnitHealth(partyunitidentifikation);
				maxhealth = UnitHealthMax(partyunitidentifikation);
				curpercenthp = (curhealth / maxhealth) * 100;			
		    	if  (curpercenthp < PowaSet[xnum].threshold) then			        
					Powa_CreateFrames(xnum);					        
			  		if (PowaSet[xnum].icon == "") then
						getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					    PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
					end -- icone
					return true;
				end
			end
		elseif (unitidentifikation == "target") then							
				curpercenthp = UnitHealth("target");		
		    	if  (curpercenthp < PowaSet[xnum].threshold) then			        
					Powa_CreateFrames(xnum);					        
			  		if (PowaSet[xnum].icon == "") then
						getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					    PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
					end -- icone
					return true;
				end
				
		elseif (unitidentifikation == "focus") then							
				curpercenthp = UnitHealth("focus");		
		    	if  (curpercenthp < PowaSet[xnum].threshold) then			        
					Powa_CreateFrames(xnum);					        
			  		if (PowaSet[xnum].icon == "") then
						getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					    PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
					end -- icone
					return true;
				end
				
		elseif (unitidentifikation == "raid") then
			for rm = 1, numrm do
				raidunitidentifikation = unitidentifikation + rm;
				curhealth = UnitHealth(raidunitidentifikation);
				maxhealth = UnitHealthMax(raidunitidentifikation);
				curpercenthp = (curhealth / maxhealth) * 100;			
		    	if  (curpercenthp < PowaSet[xnum].threshold) then			        
					Powa_CreateFrames(xnum);					        
			  		if (PowaSet[xnum].icon == "") then
						getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					    PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
					end -- icone
					return true;
				end	
			end	
		end
		
	elseif (PowaSet[xnum].bufftype == 9) then -- Mana changed
		PowaDebug("Check Mana");
        -- Mana
        if (PowaSet[xnum].target or PowaSet[xnum].targetfriend) then
			unitidentifikation = "target";
		elseif (PowaSet[xnum].focus) then
			unitidentifikation = "focus";
		elseif (PowaSet[xnum].party) then
			unitidentifikation = "party";
		elseif (PowaSet[xnum].raid) then
			unitidentifikation = "raid";
		elseif (PowaSet[xnum].optunitn) then
			unitidentifikation = unitn;
		else
			unitidentifikation = "player";
		end	
		PowaDebug("on unit "..unitidentifikation);
		local UnitAlive = true;
		if (unitidentifikation ~= "") and not (unitidentifikation == "party") and not (unitidentifikation == "raid") then			
			curmana = UnitMana(unitidentifikation);
			maxmana = UnitManaMax(unitidentifikation);
			curpercentmp = (curmana / maxmana) * 100;
			local UnitAlive = true;
			if (UnitIsDeadOrGhost(unitidentifikation)) then
				UnitAlive = false;
			end	
		    if  (curpercentmp < PowaSet[xnum].threshold) and (UnitAlive == true) then			        
				Powa_CreateFrames(xnum);					        
			  	if (PowaSet[xnum].icon == "") then
					getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
				end -- icone
				return true;
			end
		elseif (unitidentifikation == "party") then	
			for pm = 1, numpm do
				partyunitidentifikation = unitidentifikation + pm;
				curmana = UnitMana(partyunitidentifikation);
				maxmana = UnitManaMax(partyunitidentifikation);
				curpercentmp = (curmana / maxmana) * 100;			
		    	if (UnitIsDeadOrGhost(partyunitidentifikation)) then
					UnitAlive = false;
				end	
		    	if  (curpercentmp < PowaSet[xnum].threshold) and (UnitAlive == true) then		        
					Powa_CreateFrames(xnum);					        
			  		if (PowaSet[xnum].icon == "") then
						getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					    PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
					end -- icone
					return true;
				end
			end	
		elseif (unitidentifikation == "raid") then
			for rm = 1, numrm do
				raidunitidentifikation = unitidentifikation + rm;
				curmana = UnitMana(raidunitidentifikation);
				maxmana = UnitManaMax(raidunitidentifikation);
				curpercentmp = (curmana / maxmana) * 100			
		    	if (UnitIsDeadOrGhost(raidunitidentifikation)) then
					UnitAlive = false;
				end	
		    	if  (curpercentmp < PowaSet[xnum].threshold) and (UnitAlive == true) then	        
					Powa_CreateFrames(xnum);					        
			  		if (PowaSet[xnum].icon == "") then
						getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					    PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
					end -- icone
					return true;
				end	
			end	
		end
		
	elseif (PowaSet[xnum].bufftype == 10) then -- Stance
	    PowaDebug("Check Stance");
		local nStance = GetShapeshiftForm(true); -- 0=humanoid,1 = Battle Stance 2 = Defensive Stance 3 = Beserker Stance
        PowaDebug("nStance = "..nStance.." / PowaSet[xnum].stance = "..PowaSet[xnum].stance);
		if (nStance == PowaSet[xnum].stance) then
		    return true;
        else            
            return false;		    
        end	
		
	elseif (PowaSet[xnum].bufftype == 7) then -- Actions utilisables
		PowaDebug("Check Action / Button:"..PowaSet[xnum].opt1);
		if (PowaSet[xnum].opt1 == 0) then 
            return false; 
        end -- inactif / pas d'action sur les barres

		local isUsable, _ = IsUsableAction(PowaSet[xnum].opt1);
		local cdstart, cdduration, _ = GetActionCooldown(PowaSet[xnum].opt1);
          --	local inRange = IsActionInRange(PowaSet[xnum].opt1); -- portee
        PowaDebug("cdstart= "..cdstart.." duration= "..cdduration);
		if (cdduration < 1.7 and cdduration > 0.2 and PowaSet[xnum].gcd == false) then
		    if (isUsable == 1) then -- utilisable, pas de cooldown
		        return true;
		    end
        else
            if (isUsable == 1 and cdstart == 0) then
               	return true;
		    end
        end
			
	elseif (PowaSet[xnum].bufftype == 4) then -- AOE
	PowaDebug("Check AoE");
		if (DoResetAoe == true) then -- probablement mort, on reset l'effet
			return false;
		elseif (AoeAuraAdded ~= "") then -- debuff ajoute
		   	if PowaSet[xnum].exact == true then
				if PowaSet[xnum].buffname == AoeAuraAdded then
					Powa_CreateFrames(xnum);
					Powa_Frames[xnum].buffindex = 1; -- point vers le buff qui a le timer
					if (PowaSet[xnum].icon == "") then
					    getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					    PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
					end
					return true;
				end
			else	
				for pword in string.gmatch(PowaSet[xnum].buffname, "[^/]+") do
					if ( (PowaSet[xnum].ignoremaj == true and string.find(string.upper(AoeAuraAdded), string.upper(pword), 1, true)) 
					or   (PowaSet[xnum].ignoremaj == false and string.find(AoeAuraAdded, pword, 1, true)) ) then
						Powa_CreateFrames(xnum);
						Powa_Frames[xnum].buffindex = 1; -- point vers le buff qui a le timer
						if (PowaSet[xnum].icon == "") then
					   	 	getglobal("PowaIconTexture"):SetTexture("Interface\\icons\\Spell_fire_meteorstorm");
					    	PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
						end
						return true;
					end
				end
			end
		elseif (AoeAuraFaded ~= "") then -- debuff retire
			for pword in string.gmatch(PowaSet[xnum].buffname, "[^/]+") do
				if ( (PowaSet[xnum].ignoremaj == true and string.find(string.upper(AoeAuraFaded), string.upper(pword), 1, true)) 
				or   (PowaSet[xnum].ignoremaj == false and string.find(AoeAuraFaded, pword, 1, true)) ) then
					Powa_CreateFrames(xnum);
					Powa_Frames[xnum].buffindex = 1; -- point vers le buff qui a le timer
					return false;
				end
			end
		end
		if (Powa_FramesVisibleTime[xnum] == 0) then -- pas visible
			return false;
		else
			return true;
		end
	elseif (PowaSet[xnum].bufftype == 5) then -- enchant
		PowaDebug("Check enchant");
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();		
		if (hasMainHandEnchant) then		
			if (Powa_CheckforMainEnchant(xnum)) then
				PowaDebug("found "..PowaSet[xnum].buffname.." in the tooltip!");
				if (stacksOperator == "<") then					
					if (mainHandCharges < PowaSet[xnum].stacks) then					
						Powa_CreateFrameMainEnchant(xnum)
						return true;
					end	
				elseif (stacksOperator == ">") then
					if (mainHandCharges > PowaSet[xnum].stacks) then						
						Powa_CreateFrameMainEnchant(xnum)
						return true;
					end	
				elseif (stacksOperator == "=") then
					if (mainHandCharges == PowaSet[xnum].stacks) then				
						Powa_CreateFrameMainEnchant(xnum)
						return true;
					end
				elseif (stacksOperator == "!") then
					if (mainHandCharges ~= PowaSet[xnum].stacks) then							
						Powa_CreateFrameMainEnchant(xnum)
						return true;
					end		
				end								
			end			
		elseif (hasOffHandEnchant) then
			if (Powa_CheckforOffEnchant(xnum)) then
				PowaDebug("found "..PowaSet[xnum].buffname.." in the tooltip!");
				if (stacksOperator == "<") then					
					if (offHandCharges < PowaSet[xnum].stacks) then					
						Powa_CreateFrameOffEnchant(xnum)
						return true;
					end	
				elseif (stacksOperator == ">") then
					if (offHandCharges > PowaSet[xnum].stacks) then						
						Powa_CreateFrameOffEnchant(xnum)
						return true;
					end	
				elseif (stacksOperator == "=") then
					if (offHandCharges == PowaSet[xnum].stacks) then				
						Powa_CreateFrameOffEnchant(xnum)
						return true;
					end
				elseif (stacksOperator == "!") then
					if (offHandCharges ~= PowaSet[xnum].stacks) then							
						Powa_CreateFrameOffEnchant(xnum)
						return true;
					end		
				end								
			end	
		end	
			
		--elseif ( (PowaSet[xnum].ignoremaj == true and string.find(string.upper(PowaSet[xnum].buffname), string.upper(PowaText.bothHands)))
		--or     (PowaSet[xnum].ignoremaj == true and string.find(PowaSet[xnum].buffname, PowaText.bothHands)) ) then -- les 2
		--	if (hasMainHandEnchant and hasOffHandEnchant) then
		--		Powa_CreateFrames(xnum);
		--		if (PowaSet[xnum].icon == "") then
		--		    getglobal("PowaIconTexture"):SetTexture( GetInventoryItemTexture("player", 16) );
		--		    PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
		--		end -- icone
		--		Powa_Frames[xnum].buffindex = 3;
		--		Powa_Frames[xnum].buffstacks = mainHandCharges;
		--		return true;
		--	end
	elseif (PowaSet[xnum].bufftype == 2) then -- a debuff
		PowaDebug("Check debuff");
        -- target debuff
        if (PowaSet[xnum].target or PowaSet[xnum].targetfriend) then
			PowaDebug("on target or friendlytarget");
		    for i = 1, 40 do
		        if (Powa_IsBuffedChecker("debuff", "target", xnum, i)) then
					return true;
				end	
		    end		
        -- focus debuff   
        elseif PowaSet[xnum].focus then
			PowaDebug("on focus");
		    for i = 1, 40 do
		        if (Powa_IsBuffedChecker("debuff", "focus", xnum, i)) then
					return true;
				end	
		    end
        -- unit debuff   
        elseif PowaSet[xnum].optunitn then
			PowaDebug("on unit "..PowaSet[xnum].unitn);
		    for i = 1, 40 do
		        if (Powa_IsBuffedChecker("debuff", PowaSet[xnum].unitn, xnum, i)) then
					return true;
				end	
		    end
        -- party debuff   
        elseif (PowaSet[xnum].party) then -- Partymember Debuff
			PowaDebug("on partyunit");
            for partym = 1, numpm do
	            for i = 1, 40 do
					if (Powa_IsBuffedChecker("debuff", "party"..partym, xnum, i)) then
						return true;
					end	
                end
            end
        -- raid debuff    
        elseif (PowaSet[xnum].raid) then -- Raidmember Debuff
			PowaDebug("on raidunit");
            for raidm = 1, numrm do
	            for i = 1, 40 do
		            if (Powa_IsBuffedChecker("debuff", "raid"..raidm, xnum, i)) then
						return true;
					end	
                end
            end     	 
		-- Player Debuff
        else
			PowaDebug("on player");
			PowaDebug("search deBuffName = "..PowaSet[xnum].buffname);
		    for i = 1, 40 do
		        if (Powa_IsBuffedChecker("debuff", "player", xnum, i)) then
					return true;
				end	
		    end
        end
		
	elseif (PowaSet[xnum].bufftype == 3) then -- type de debuff
	PowaDebug("Check debuff type");
        if (PowaSet[xnum].target or PowaSet[xnum].targetfriend) then
			PowaDebug("on target or friendlytarget");
		    for i = 1, 40 do
				if (Powa_CompareDebufftypes("target", xnum, i)) then
					return true;
				end			        
		    end
        -- focus    
        elseif PowaSet[xnum].focus then
			PowaDebug("on focus");
		    for i = 1, 40 do
				if (Powa_CompareDebufftypes("focus", xnum, i)) then
					return true;
				end	
		    end
        -- unit    
        elseif PowaSet[xnum].optunitn then
			PowaDebug("on unit "..PowaSet[xnum].unitn);
		    for i = 1, 40 do
				if (Powa_CompareDebufftypes(PowaSet[xnum].unitn, xnum, i)) then
					return true;
				end	
		    end         
		-- Party Debufftype
        elseif (PowaSet[xnum].party) then
			PowaDebug("on partyunit");
            for partymdb = 1, numpm do --Partymembers Debuff
                for i = 1, 40 do
					if (Powa_CompareDebufftypes("party"..partymdb, xnum, i)) then
						return true;
					end	
                end
            end  
        -- Raid Debufftype
        elseif (PowaSet[xnum].raid) then
			PowaDebug("on raidunit");
            for raidmdb = 1, numrm do --Raidmembers Debuff
                for i = 1, 40 do
					if (Powa_CompareDebufftypes("raid"..raidmdb, xnum, i)) then
						return true;
					end	
				end	 
            end
        -- Player Debufftype
        else 
			PowaDebug("on player");
			PowaDebug("search deBuffName = "..PowaSet[xnum].buffname);
            for i = 1, 40 do
				if (Powa_CompareDebufftypes("player", xnum, i)) then
					return true;
				end	
            end
        end
		
	elseif (PowaSet[xnum].bufftype == 1) then -- un buff
		PowaDebug("Check buff");
	
		-- targets
        if (PowaSet[xnum].target or PowaSet[xnum].targetfriend) then
			PowaDebug("on target or friendlytarget");
		    for i = 1, 40 do
		        if (Powa_CompareBuffs("target", xnum, i)) then
                	return true;
				end	
            end
			
        -- focus buff    
        elseif PowaSet[xnum].focus then
			PowaDebug("on focus");
		    for i = 1, 40 do
		        if (Powa_CompareBuffs("focus", xnum, i)) then
                	return true;
				end	
            end
			
        -- unit buff    
        elseif PowaSet[xnum].optunitn then
			PowaDebug("on unit "..PowaSet[xnum].unitn);
		    for i = 1, 40 do
		        if (Powa_CompareBuffs(PowaSet[xnum].unitn, xnum, i)) then
                	return true;
				end	
            end
			
        -- partybuff    
        elseif (PowaSet[xnum].party) then
		PowaDebug("on partyunit");
			local buffonrm = 0;
            for partymb = 1, numpm do		
		        for i = 1, 40 do
		            if (Powa_CompareBuffs("party"..partymb, xnum, i)) then
						buffonpm = buffonpm + 1;
					end	
		        end
	        end
            if (buffonpm == numpm) then              
                return true;
            end
			
        -- raid buff
        elseif (PowaSet[xnum].raid) then
		PowaDebug("on raidunit");
			local buffonrm = 0;
            for raidmb = 1, numrm do
		    -- Party		
		        for i = 1, 40 do
		            if (Powa_CompareBuffs("raid"..raidmb, xnum, i)) then
						buffonrm = buffonrm + 1;
					end	
		        end
	        end
            if (buffonrm == numrm) then         
                return true;
            end
			
        -- player buff    
        else
			PowaDebug("on player");
			PowaDebug("search BuffName = "..PowaSet[xnum].buffname);
		    for i = 1, 40 do
		        if (Powa_PlayerBuffedChecker("buff", xnum, i)) then
					return true;
				end	
		    end
	    end        
    end
	return false;
end

function Powa_CheckforMainEnchant(xnum)
	PowaDebug("Has mainhand enchant activ.");
	Powa_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
	Powa_Tooltip:SetInventoryItem("player", 16);
	-- Powa_Tooltip:SetPlayerBuff(buffIndexpassive);
	PowaDebug("search in mainhand tooltip:");			
	for z = 1, Powa_Tooltip:NumLines() do
		local mytextline = getglobal("Powa_TooltipTextLeft"..z)		
		local text = mytextline:GetText()				
		if (text ~= "") and (text ~= nil) then
			PowaDebug("| "..text.." |");
			if ( (PowaSet[xnum].ignoremaj == true and string.find(string.upper(text), string.upper(PowaSet[xnum].buffname), 1, true))
			or   (PowaSet[xnum].ignoremaj == false and string.find(text, PowaSet[xnum].buffname, 1, true)) ) then -- droite
				text = "";
				Powa_Tooltip:Hide();
				return true;
			end	
		end
	end	
	Powa_Tooltip:Hide();
	return false;		
end

function Powa_CreateFrameMainEnchant(xnum)
	Powa_CreateFrames(xnum);
	if (PowaSet[xnum].icon == "") then
		getglobal("PowaIconTexture"):SetTexture( GetInventoryItemTexture("player", 16) );
		PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
	end -- icone
	Powa_Frames[xnum].buffindex = 1;
end	

function Powa_CreateFrameOffEnchant(xnum)
	Powa_CreateFrames(xnum);
	if (PowaSet[xnum].icon == "") then
		getglobal("PowaIconTexture"):SetTexture( GetInventoryItemTexture("player", 17) );
		PowaSet[xnum].icon = getglobal("PowaIconTexture"):GetTexture();
	end -- icone
	Powa_Frames[xnum].buffindex = 2;
end	
						

function Powa_CheckforOffEnchant(xnum)
	PowaDebug("Has offhand enchant activ.");
	Powa_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
	Powa_Tooltip:SetInventoryItem("player", 17);
	-- Powa_Tooltip:SetPlayerBuff(buffIndexpassive);
	PowaDebug("search in mainhand tooltip:");			
	for z = 1, Powa_Tooltip:NumLines() do
		local mytextline = getglobal("Powa_TooltipTextLeft"..z)		
		local text = mytextline:GetText()				
		if (text ~= "") and (text ~= nil) then
			PowaDebug("| "..text.." |");
			if ( (PowaSet[xnum].ignoremaj == true and string.find(string.upper(text), string.upper(PowaSet[xnum].buffname), 1, true))
			or   (PowaSet[xnum].ignoremaj == false and string.find(text, PowaSet[xnum].buffname, 1, true)) ) then -- droite
				text = "";
				Powa_Tooltip:Hide();
				return true;
			end	
		end
	end	
	Powa_Tooltip:Hide();
	return false;		
end

function Powa_IsBuffedChecker(bufftype, unittarget, snum, s)
	stacksOperator = PowaSet[snum].stacksOperator;
    if stacksOperator == "" then
		stacksOperator = "=";
	end	
    stacks = PowaSet[snum].stacks;
	if stacks == "" then
		stacks = "0";
	end	
	if (bufftype == "debuff") then
		if (unittarget == "player") then
			if (Powa_PlayerBuffedChecker("debuff", snum, s)) then
				return true;
			end	
		else	
			if (UnitDebuff(unittarget, s)) then
				_, _, _, count, _, _, _ = UnitDebuff(unittarget, s);
				PowaDebug("Check Debuff "..PowaSet[snum].buffname.." on "..unittarget.." that "..stacksOperator.." "..stacks.." stacks. Result: "..count.." stacks.");					
				if (stacksOperator == "<") then					
					if (count < stacks) then					
						if (Powa_CompareDebuffs(unittarget, snum, s)) then
							return true;
						end	
					end	
				elseif (stacksOperator == ">") then
					if (count > stacks) then						
						if (Powa_CompareDebuffs(unittarget, snum, s)) then
							return true;
						end	
					end	
				elseif (stacksOperator == "=") then
					if (count == stacks) then				
						if (Powa_CompareDebuffs(unittarget, snum, s)) then
							return true;
						end	
					end
				elseif (stacksOperator == "!") then
					if (count ~= stacks) then							
						if (Powa_CompareDebuffs(unittarget, snum, s)) then
							return true;
						end	
					end		
				end
			end
		end	
	else	
		if (UnitBuff(unittarget, s)) then
			_, _, _, count, _, _, _ = UnitBuff(unittarget, s);
			PowaDebug("Check buff "..PowaSet[snum].buffname.." on "..unittarget.." that "..stacksOperator.." "..stacks.." stacks. Result: "..count.." stacks.");					
			if (stacksOperator == "<") then					
				if (count < stacks) then					
					if (Powa_CompareBuffs(unittarget, snum, s)) then
						return true;
					end	
				end	
			elseif (stacksOperator == ">") then
				if (count > stacks) then						
					if (Powa_CompareBuffs(unittarget, snum, s)) then
						return true;
					end	
				end	
			elseif (stacksOperator == "=") then
				if (count == stacks) then				
					if (Powa_CompareBuffs(unittarget, snum, s)) then
						return true;
					end	
				end
			elseif (stacksOperator == "!") then
				if (count ~= stacks) then							
					if (Powa_CompareBuffs(unittarget, snum, s)) then
						return true;
					end	
				end		
			end
		end	
	end
	return false;
end	

function Powa_CompareBuffs(target, znum, z)
	if (UnitBuff(target, z)) then
		if (PowaSet[znum].exact == true) then
			if PowaSet[znum].buffname == UnitBuff(target, z) then
				Powa_CreateFrames(znum);
				Powa_Frames[znum].buffindex = z;
				if (PowaSet[znum].icon == "") then
					getglobal("PowaIconTexture"):SetTexture(UnitBuff(target, z));
					PowaSet[znum].icon = getglobal("PowaIconTexture"):GetTexture();
				end -- icone
		        return true;
	        end	
		else		
        	for pword in string.gmatch(PowaSet[znum].buffname, "[^/]+") do
	        	if ( (PowaSet[znum].ignoremaj == true and string.find(string.upper(UnitBuff(target, z)), string.upper(pword), 1, true)) 
	        	or   (PowaSet[znum].ignoremaj == false and string.find(UnitBuff(target, z), pword, 1, true)) ) then
					Powa_CreateFrames(znum);
					Powa_Frames[znum].buffindex = z;
					if (PowaSet[znum].icon == "") then
						getglobal("PowaIconTexture"):SetTexture(UnitBuff(target, z));
						PowaSet[znum].icon = getglobal("PowaIconTexture"):GetTexture();
					end -- icone
					return true;
	        	end
			end		
        end
    end
	return false;
end

function Powa_CompareDebuffs(target, znum, z)
	local debuffnamez = UnitDebuff(target, z);
	local _, _, TextureIconn, count, _, _, _ = UnitDebuff(target, z);
	PowaDebug("CompareDebuffs "..target.." "..znum.." "..z);
	if (UnitDebuff(target, z)) then
		if PowaSet[znum].exact == true then
			if (PowaSet[znum].buffname == debuffnamez) then
				Powa_CreateFrames(znum);
				Powa_Frames[znum].buffindex = z; -- point vers le debuff qui a le timer
				if (PowaSet[znum].icon == "") then
					getglobal("PowaIconTexture"):SetTexture(TextureIconn);
					PowaSet[znum].icon = getglobal("PowaIconTexture"):GetTexture();
				end -- icone
				return true;
			end
		else
			for pword in string.gmatch(PowaSet[znum].buffname, "[^/]+") do											
				if ( (PowaSet[znum].ignoremaj == true and string.find(string.upper(UnitDebuff(target, z)), string.upper(pword), 1, true)) 
				or   (PowaSet[znum].ignoremaj == false and string.find(UnitDebuff(target, z), pword, 1, true)) ) then								
					Powa_CreateFrames(znum);
					Powa_Frames[znum].buffindex = z; -- point vers le debuff qui a le timer
					if (PowaSet[znum].icon == "") then
						getglobal("PowaIconTexture"):SetTexture(TextureIconn);
						PowaSet[znum].icon = getglobal("PowaIconTexture"):GetTexture();
					end -- icone
					return true;									
				end
			end
		end		
	end
	return false;
end

function Powa_CompareDebufftypes(target, znum, z)
	_,_,_,_,typeDebuff = UnitDebuff(target, z);
    if (UnitDebuff(target, z)) then
        for pword in string.gmatch(PowaSet[znum].buffname, "[^/]+") do
	        if (PowaSet[znum].ignoremaj == true) then
		        if((typeDebuff == nil and string.find(string.upper(PowaSet[znum].buffname), string.upper(PowaText.aucun), 1, true))
		        or (typeDebuff == "Magic" and string.find(string.upper(PowaSet[znum].buffname), string.upper(PowaText.TypeMagic), 1, true))
		        or (typeDebuff == "Curse" and string.find(string.upper(PowaSet[znum].buffname), string.upper(PowaText.TypeCurse), 1, true))
		        or (typeDebuff == "Disease" and string.find(string.upper(PowaSet[znum].buffname), string.upper(PowaText.TypeDisease), 1, true))
		        or (typeDebuff == "Poison" and string.find(string.upper(PowaSet[znum].buffname), string.upper(PowaText.TypePoison), 1, true)) ) then
			        Powa_CreateFrames(znum);
			        Powa_Frames[znum].buffindex = z; -- point vers le debuff qui a le timer
			        if (PowaSet[znum].icon == "") then
			            getglobal("PowaIconTexture"):SetTexture(UnitDebuff(target, z));
			            PowaSet[znum].icon = getglobal("PowaIconTexture"):GetTexture();
			        end -- icone
			        return true;
		        end
	        else
		        if((typeDebuff == nil and string.find(PowaSet[znum].buffname, PowaText.aucun, 1, true))
		        or (typeDebuff == "Magic" and string.find(PowaSet[znum].buffname, PowaText.TypeMagic, 1, true))
		        or (typeDebuff == "Curse" and string.find(PowaSet[znum].buffname, PowaText.TypeCurse, 1, true))
		        or (typeDebuff == "Disease" and string.find(PowaSet[znum].buffname, PowaText.TypeDisease, 1, true))
		        or (typeDebuff == "Poison" and string.find(PowaSet[znum].buffname, PowaText.TypePoison, 1, true)) ) then
			        Powa_CreateFrames(znum);
			        Powa_Frames[znum].buffindex = z; -- point vers le debuff qui a le timer
			        if (PowaSet[znum].icon == "") then
			            getglobal("PowaIconTexture"):SetTexture(UnitDebuff(target, z));
			            PowaSet[znum].icon = getglobal("PowaIconTexture"):GetTexture();
			        end -- icone
			        return true;
		        end
	        end
        end
    end
	return false;
end

function Powa_PlayerBuffedChecker(bufftypee, dnum, d)
    if (bufftypee == "buff") then
		SlotFilter = "HELPFUL|PASSIVE";
	else
		SlotFilter = "HARMFUL|PASSIVE";
	end	
	
	buffIndex, untilCancelled = GetPlayerBuff(d, SlotFilter);	        
	if (GetPlayerBuffName(buffIndex) ~= nil) then
		local playerbuffname = GetPlayerBuffName(buffIndex);
		PowaDebug("found DE/BUFFName = "..playerbuffname.." with buffIndex = "..buffIndex);
		if PowaSet[dnum].exact == true then
			if PowaSet[dnum].buffname == GetPlayerBuffName(buffIndex) then
				Powa_CreateFrames(dnum);
		        Powa_Frames[dnum].buffindex = d; -- point vers le buff qui a le timer
		        if (PowaSet[dnum].icon == "") then 
		           	PowaSet[dnum].icon = GetPlayerBuffTexture( buffIndex ); 
		        end -- icone
		        return true;
	        end
		else	
        	for pword in string.gmatch(PowaSet[dnum].buffname, "[^/]+") do
	        	if ( (PowaSet[dnum].ignoremaj == true and string.find(string.upper(GetPlayerBuffName(buffIndex)), string.upper(pword), 1, true)) 
	        	or   (PowaSet[dnum].ignoremaj == false and string.find(GetPlayerBuffName(buffIndex), pword, 1, true)) ) then
		        	Powa_CreateFrames(dnum);
		        	Powa_Frames[dnum].buffindex = d; -- point vers le buff qui a le timer
		        	if (PowaSet[dnum].icon == "") then 
		            	PowaSet[dnum].icon = GetPlayerBuffTexture( buffIndex ); 
		        	end -- icone
		        	return true;
	        	end
			end	
        end
    end	
end	

function Powa_HideThisEffect(h)
	if (Powa_Frames[h] and Powa_Frames[h]:IsVisible() ) then
		Powa_FramesVisibleTime[h] = 0;
		if (h == CurrentSecondeAura) then
			Powa_FramesVisibleTime[SecondeAura] = 0;
			if (LastAura > 0) then -- cet effet n'est plus actif mais on affiche l'aura 2 sur le dernier effet
				CurrentSecondeAura = LastAura;
				Powa_DisplayAura(LastAura);
			end
		end
	end
end

function Powa_TestThisEffect(j)
   local numpm = GetNumPartyMembers();
   local numrm = GetNumRaidMembers();
   AuraHide = false;
   PowaDebug("------------------------------");
   PowaDebug("Test Aura for Hide or Show = "..j);
	-- n'affiche pas si la cible est inexistante ou morte
 	if ((PowaSet[j].target or PowaSet[j].targetfriend) and (UnitName("target") == nil or UnitIsDead("target") or UnitName("target") == UnitName("player")) ) then
	    Powa_HideThisEffect(j);
	    		
	-- regarde si la cible est ennemie
	elseif (PowaSet[j].target and PowaSet[j].targetfriend == false and UnitIsFriend("player","target")) then -- cible amie alors que faut pas
		Powa_HideThisEffect(j);
		
	-- party
	elseif (PowaSet[j].party and not ((numpm > 0) or (numrm > 0))) then -- partycheck yes, but not in party
		Powa_HideThisEffect(j);
        
    -- focus
	elseif (PowaSet[j].focus and (UnitName("focus") == nil or UnitIsDead("focus") or UnitName("focus") == UnitName("player"))) then -- focuscheck
		Powa_HideThisEffect(j);
        
    -- unit
	elseif (PowaSet[j].optunitn and not ((numpm > 0) or (numrm > 0)))then -- Unitn yes, but not in party/raid
		Powa_HideThisEffect(j);
        
    -- raid
	elseif (PowaSet[j].raid and not (numrm > 0)) then -- raidcheck yes, but not in raid
		Powa_HideThisEffect(j);
		
	-- regarde si la cible est amie
	elseif (PowaSet[j].target == false and PowaSet[j].targetfriend and not UnitIsFriend("player","target")) then -- cible ennemie
		Powa_HideThisEffect(j);

	-- mode combat, cache si besoin
	elseif ((WeAreInCombat == true and PowaSet[j].combat == 2) or (WeAreInCombat == false and PowaSet[j].combat == 1)) then
		AuraHide = true;
		Powa_HideThisEffect(j);
		
	elseif (WeAreInRaid == false and PowaSet[j].isinraid == true) then
		Powa_HideThisEffect(j);
		
	elseif (WeAreMounted == false and PowaSet[j].ismounted == true) then		
		Powa_HideThisEffect(j);
	
	-- gain d'aura
	elseif (PowaCompareBuffDebuff(j)) then -- buff actif
	    if (PowaSet[j].inverse == true) then
			PowaDebug("HideAura = "..j);
		    Powa_HideThisEffect(j);
			
	    else
			PowaDebug("ShowAura = "..j);
		    Powa_DisplayAura(j);
		    LastAura = j;
	    end
	    
	-- perte d'aura
	else 
	    if (PowaSet[j].inverse == false) then			
			PowaDebug("HideAura = "..j);
		    Powa_HideThisEffect(j);
	    else
			PowaDebug("ShowAura = "..j);
		    Powa_DisplayAura(j);
		    LastAura = j;
	    end
	end
end

function Powa_NewCheckBuffs()
     
LastAura = 0;
     
     -- test buffs / debuffs / debuffs type du joueur
    if ((DoCheckBuffs or DoCheckMounted) and ListBuffsMax > 0) then
        -- DEFAULT_CHAT_FRAME:AddMessage("player");
	    for i = 1, ListBuffsMax do
		    Powa_TestThisEffect(ListBuffs[i]);
	    end
	    DoCheckBuffs = false;
    end
     
    -- test party buffs / debuffs / debuffs type de la cible partie
    if ((DoCheckPartyBuffs or DoCheckMounted) and ListPartyBuffsMax > 0) then
        -- DEFAULT_CHAT_FRAME:AddMessage("party");
	    for i = 1, ListPartyBuffsMax do
		    Powa_TestThisEffect(ListPartyBuffs[i]);
	    end
	    DoCheckPartyBuffs = false;
    end
    
     -- new raid de/buffs
    if ((DoCheckRaidBuffs or DoCheckMounted) and ListRaidBuffsMax > 0) then
        -- DEFAULT_CHAT_FRAME:AddMessage("raid");
	    for i = 1, ListRaidBuffsMax do
		    Powa_TestThisEffect(ListRaidBuffs[i]);
	    end
	    DoCheckRaidBuffs = false;
    end
    
    -- newunit de/buffs
    if ((DoCheckUnitBuffs or DoCheckMounted) and ListUnitBuffsMax > 0) then
	    for i = 1, ListUnitBuffsMax do
		    Powa_TestThisEffect(ListUnitBuffs[i]);
	    end
	    DoCheckUnitBuffs = false;
    end
     
    -- test buffs / debuffs / debuffs type de la cible target
    if ((DoCheckTargetBuffs or DoCheckMounted) and ListTargetBuffsMax > 0) then
        -- DEFAULT_CHAT_FRAME:AddMessage("target");
	    for i = 1, ListTargetBuffsMax do
		    Powa_TestThisEffect(ListTargetBuffs[i]);
	    end
	    DoCheckTargetBuffs = false;
    end
    
    -- test buffs / debuffs / debuffs type de la cible focus
    if ((DoCheckFocusBuffs or DoCheckMounted) and ListFocusBuffsMax > 0) then
        -- DEFAULT_CHAT_FRAME:AddMessage("focus");
	    for i = 1, ListFocusBuffsMax do
		    Powa_TestThisEffect(ListFocusBuffs[i]);
	    end
	    DoCheckFocusBuffs = false;
    end
     
     -- test les aoe
    if ((DoCheckAoe or DoCheckMounted) and ListAoeMax > 0) then
	    for i = 1, ListAoeMax do
		    Powa_TestThisEffect(ListAoe[i]);
	    end
	    DoCheckAoe = false;
	    DoResetAoe = false;	
	    AoeAuraAdded = "";
	    AoeAuraFaded = "";
     end
     
     -- test les enchants et actions
    if ((DoCheckEnchant or DoCheckMounted)) then
	    if (ListEnchantsMax > 0) then
		    for i = 1, ListEnchantsMax do
			     Powa_TestThisEffect(ListEnchants[i]);
		    end
	    end
	    DoCheckEnchant = false;
    end
	
	-- test actions
    if ((DoCheckAction or DoCheckMounted) and ListActionsMax > 0) then
	    for i = 1, ListActionsMax do
			Powa_TestThisEffect(ListActions[i]);
		end 
	    DoCheckAction = false;
    end
     
    -- test les combos
    if ((DoCheckCombo or DoCheckMounted) and ListComboMax > 0) then
	    for i = 1, ListComboMax do
		    Powa_TestThisEffect(ListCombo[i]);
	    end
	    DoCheckCombo = false;
    end
	
	-- test Health
    if ((DoCheckHealth or DoCheckMounted) and ListHealthMax > 0) then    
	    for i = 1, ListHealthMax do
		    Powa_TestThisEffect(ListHealth[i]);
	    end
	    DoCheckHealth = false;
    end
     
    -- test party Health
    if ((DoCheckPartyHealth or DoCheckMounted) and ListPartyHealthMax > 0) then
	    for i = 1, ListPartyHealthMax do
		    Powa_TestThisEffect(ListPartyHealth[i]);
	    end
	    DoCheckPartyHealth = false;
    end
    
     -- new raid Health
    if ((DoCheckRaidHealth or DoCheckMounted) and ListRaidHealthMax > 0) then
	    for i = 1, ListRaidHealthMax do
		    Powa_TestThisEffect(ListRaidHealth[i]);
	    end
	    DoCheckRaidHealth = false;
    end
     
    -- test Health target
    if ((DoCheckTargetHealth or DoCheckMounted) and ListTargetHealthMax > 0) then
	    for i = 1, ListTargetHealthMax do
		    Powa_TestThisEffect(ListTargetHealth[i]);
	    end
	    DoCheckTargetHealth = false;
    end
	
	-- test Health focus
    if ((DoCheckFocusHealth or DoCheckMounted) and ListFocusHealthMax > 0) then
	    for i = 1, ListFocusHealthMax do
		    Powa_TestThisEffect(ListFocusHealth[i]);
	    end
	    DoCheckFocusHealth = false;
    end
	
	
	-- test Mana
    if ((DoCheckMana or DoCheckMounted) and ListManaMax > 0) then
	    for i = 1, ListManaMax do
		    Powa_TestThisEffect(ListMana[i]);
	    end
	    DoCheckMana = false;
    end
     
    -- test party Mana
    if ((DoCheckPartyMana or DoCheckMounted) and ListPartyManaMax > 0) then
	    for i = 1, ListPartyManaMax do
		    Powa_TestThisEffect(ListPartyMana[i]);
	    end
	    DoCheckPartyMana = false;
    end
    
     -- new raid Mana
    if ((DoCheckRaidMana or DoCheckMounted) and ListRaidManaMax > 0) then
	    for i = 1, ListRaidManaMax do
		    Powa_TestThisEffect(ListRaidMana[i]);
	    end
	    DoCheckRaidMana = false;
    end
     
    -- test Mana target
    if ((DoCheckTargetMana or DoCheckMounted) and ListTargetManaMax > 0) then
	    for i = 1, ListTargetManaMax do
		    Powa_TestThisEffect(ListTargetMana[i]);
	    end
	    DoCheckTargetMana = false;
    end
	
	-- test Mana focus
    if ((DoCheckFocusMana or DoCheckMounted) and ListFocusManaMax > 0) then
	    for i = 1, ListFocusManaMax do
		    Powa_TestThisEffect(ListFocusMana[i]);
	    end	
	    DoCheckFocusMana = false;
    end
	
	 -- test stance
    if ((DoCheckStance or DoCheckMounted) and ListStanceMax > 0) then
	    for i = 1, ListStanceMax do
		    Powa_TestThisEffect(ListStance[i]);
	    end
	    DoCheckStance = false;
    end
	DoCheckMounted = false;	
end

-- ---------------------------------------------------------------------------------------------

function Powa_MouseDown(arg1)
	if (arg1 == "RightButton") then
		-- DEFAULT_CHAT_FRAME:AddMessage("RightMouseDown");
		RightClicking = true;
	end

	if Origi_MouseDown then
		Origi_MouseDown();
	end
end

function Powa_MouseUp(arg1)
	if (arg1 == "RightButton") then
		-- DEFAULT_CHAT_FRAME:AddMessage("RightMouseUp");
		RightClicking = false;
	end

	if Origi_MouseDown then
		Origi_MouseDown();
	end
end

-- -----------------------------------------------------------------------------------------------

function Powa_DisplayAura(FNum)
    local TexDeca = 0.0;
    local FRandom = 0;
    local pitch, yaw, squish

    if (PowaEnabled == 0) then return; end   -- desactived

    if (Powa_FramesVisibleTime[FNum] == 0) then  -- si pas en cours
        if (PowaModTest == false) then
			if (PowaSet[FNum].sound > 0) and (PowaSet[FNum].customsound == "") then
				PlaySound(PowaSet[FNum].soundfile);
			end	
			if not (PowaSet[FNum].customsound == "") then
				PlaySoundFile("Interface\\AddOns\\PowerAuras\\Sounds\\"..PowaSet[FNum].customsound);
			end	
		end
	    Powa_CreateFrames(FNum); -- cree la frame si pas encore creee

	    if (PowaSet[FNum].wowtex == true) then
		    Powa_textures[FNum]:SetTexture(PowaWowTextures[PowaSet[FNum].texture]);
	    elseif (PowaSet[FNum].customtex == true) then
		    Powa_textures[FNum]:SetTexture("Interface\\Addons\\PowerAuras\\Custom\\"..PowaSet[FNum].customname);
	    else
		    Powa_textures[FNum]:SetTexture("Interface\\Addons\\PowerAuras\\aura"..PowaSet[FNum].texture..".tga");
	    end
	    if (PowaSet[FNum].randomcolor) then
		    Powa_textures[FNum]:SetVertexColor(random(20,100)/100,random(20,100)/100,random(20,100)/100);
	    else
		    Powa_textures[FNum]:SetVertexColor(PowaSet[FNum].r,PowaSet[FNum].g,PowaSet[FNum].b);
	    end
	    if (PowaSet[FNum].texmode == 1) then
		    Powa_textures[FNum]:SetBlendMode("ADD");
		    Powa_Frames[FNum]:SetFrameStrata("LOW");
	    else
		    Powa_textures[FNum]:SetBlendMode("DISABLE");
		    Powa_Frames[FNum]:SetFrameStrata("BACKGROUND");
	    end

	    if (PowaSet[FNum].symetrie == 1) then Powa_textures[FNum]:SetTexCoord(1, 0, 0, 1); -- inverse X
	    elseif (PowaSet[FNum].symetrie == 2) then Powa_textures[FNum]:SetTexCoord(0, 1, 1, 0); -- inverse Y
	    elseif (PowaSet[FNum].symetrie == 3) then Powa_textures[FNum]:SetTexCoord(1, 0, 1, 0); -- inverse XY
	    else Powa_textures[FNum]:SetTexCoord(0, 1, 0, 1); end	

	    if (PowaSet[FNum].begin > 0) then Powa_Frames[FNum].beginAnim = 1;
	    else Powa_Frames[FNum].beginAnim = 0; end
        -- if (PowaSet[FNum].realaura == 1) then
        --    local Facing = minimapPlayerModel:GetFacing() - (1.5 * math.pi);
        --    
        --    SaveView(5);
		--    pitch = tonumber(GetCVar("cameraPitchD"));
        --    
        --   pitch = pitch * (2 * math.pi) / 360;
        --    DEFAULT_CHAT_FRAME:AddMessage("pitch"..pitch);
		--    -- pitch is 0 when level with ground +pi/2 straight above, -pi/2 straight below
--
--		    yaw = tonumber(GetCVar("cameraYawD"));
--		    yaw = yaw * (2 * math.pi) / 360;
--		    -- yaw is 0 whenstraight behind, pi/2 straight right, pi forwards, and 3*pi/2 left
--
--		    -- Here's some weirdness for you
--		    -- When turning with left or right mouse button, camera yaw is relative to game world
--		    -- When not, camera yaw variable is relative to your player.
--
--		    -- HOWEVER, IsMouselooking catches player turning with the RIGHT mouse button, and not camera movement with left.
--		    -- So, we will be hooking WorldFrame:OnMouseDown...
--           if RightClicking or IsMouselooking() then
--			    --yaw = yaw - Facing + (math.pi/2);
--			    --Facing = Facing + yaw;
--			    Facing = yaw + (math.pi/2); -- Camera angle is 90 degree offset from our reference point (straight left).
--
--			    -- However, WHEN mouselooking, camera yaw is relative to north, and I can't use playermodelfacing to get
--			    -- the player facing to compensate and get a relative-to-player camera angle
--            else
--			    Facing = Facing + yaw;
--		    end
--            squish = abs(pitch) / 90; -- Squish!
--            DEFAULT_CHAT_FRAME:AddMessage("squish"..squish);
--            Powa_Frames[FNum].baseL = 256 * PowaSet[FNum].size * squish;
--	        Powa_Frames[FNum].baseH = 256 * PowaSet[FNum].size * (2-squish);
--        else } 
            Powa_Frames[FNum].baseL = 256 * PowaSet[FNum].size * PowaSet[FNum].torsion;
	        Powa_Frames[FNum].baseH = 256 * PowaSet[FNum].size * (2-PowaSet[FNum].torsion);
    
    
        -- end       
        Powa_Frames[FNum]:SetAlpha(PowaSet[FNum].alpha);
        Powa_Frames[FNum]:SetPoint("Center",PowaSet[FNum].x, PowaSet[FNum].y);
        Powa_Frames[FNum]:SetWidth(Powa_Frames[FNum].baseL);
        Powa_Frames[FNum]:SetHeight(Powa_Frames[FNum].baseH);
        Powa_Frames[FNum].statut = 0;
        Powa_Frames[FNum].duree = 0;
        Powa_Frames[FNum].timerduree = PowaSet[FNum].timerduration;
        Powa_Frames[FNum]:Show();
    
        Powa_FramesVisibleTime[FNum] = 1;        -- affiche anim1
        Powa_FramesVisibleTime[SecondeAura] = 0; -- init anim2
    end

    if (Powa_FramesVisibleTime[SecondeAura] == 0) then  -- si pas en cours (Anim 2)
	
	    CurrentSecondeAura = FNum; -- 2eme aura en cours
	
	    if (PowaSet[FNum].anim2 == 0) then -- pas d'anim
		    Powa_Frames[SecondeAura]:Hide();
		    return;
	    end

	    if (PowaSet[FNum].begin > 0) then Powa_Frames[SecondeAura].beginAnim = 2;
	    else Powa_Frames[SecondeAura].beginAnim = 0; end

	    PowaSet[SecondeAura].size = PowaSet[FNum].size;
	    PowaSet[SecondeAura].torsion = PowaSet[FNum].torsion;
	    PowaSet[SecondeAura].symetrie = PowaSet[FNum].symetrie;
	    PowaSet[SecondeAura].alpha = PowaSet[FNum].alpha * 0.5;
	    PowaSet[SecondeAura].anim1 = PowaSet[FNum].anim2;
	    PowaSet[SecondeAura].speed = PowaSet[FNum].speed - 0.1; -- legerement plus lent
	    PowaSet[SecondeAura].duration = PowaSet[FNum].duration;
	    PowaSet[SecondeAura].begin = PowaSet[FNum].begin;
	    PowaSet[SecondeAura].finish = PowaSet[FNum].finish;
	    PowaSet[SecondeAura].x = PowaSet[FNum].x;
	    PowaSet[SecondeAura].y = PowaSet[FNum].y;

	    if (PowaSet[FNum].wowtex == true) then
		    Powa_textures[SecondeAura]:SetTexture(PowaWowTextures[PowaSet[FNum].texture]);
	    elseif (PowaSet[FNum].customtex == true) then
		    Powa_textures[SecondeAura]:SetTexture("Interface\\Addons\\PowerAuras\\Custom\\"..PowaSet[FNum].customname);
	    else
		    Powa_textures[SecondeAura]:SetTexture("Interface\\Addons\\PowerAuras\\aura"..PowaSet[FNum].texture..".tga");
        end
        if (PowaSet[FNum].randomcolor) then
            Powa_textures[SecondeAura]:SetVertexColor( Powa_textures[FNum]:GetVertexColor() );
        else
            Powa_textures[SecondeAura]:SetVertexColor(PowaSet[FNum].r,PowaSet[FNum].g,PowaSet[FNum].b);
        end
        if (PowaSet[FNum].texmode == 1) then
            Powa_textures[SecondeAura]:SetBlendMode("ADD");
            Powa_Frames[SecondeAura]:SetFrameStrata("LOW");
        else
            Powa_textures[SecondeAura]:SetBlendMode("DISABLE");
            Powa_Frames[SecondeAura]:SetFrameStrata("BACKGROUND");
        end
    
        if (PowaSet[FNum].symetrie == 1) then Powa_textures[SecondeAura]:SetTexCoord(1, 0, 0, 1); -- inverse X
        elseif (PowaSet[FNum].symetrie == 2) then Powa_textures[SecondeAura]:SetTexCoord(0, 1, 1, 0); -- inverse Y
        elseif (PowaSet[FNum].symetrie == 3) then Powa_textures[SecondeAura]:SetTexCoord(1, 0, 1, 0); -- inverse XY
        else Powa_textures[SecondeAura]:SetTexCoord(0, 1, 0, 1); end
    
        Powa_Frames[SecondeAura].baseL = Powa_Frames[FNum].baseL;
        Powa_Frames[SecondeAura].baseH = Powa_Frames[FNum].baseH;
        Powa_Frames[SecondeAura]:SetAlpha(PowaSet[SecondeAura].alpha);
        Powa_Frames[SecondeAura]:SetPoint("Center",PowaSet[FNum].x, PowaSet[FNum].y);
        Powa_Frames[SecondeAura]:SetWidth(Powa_Frames[SecondeAura].baseL);
        Powa_Frames[SecondeAura]:SetHeight(Powa_Frames[SecondeAura].baseH);
        Powa_Frames[SecondeAura].statut = 1;
        Powa_Frames[SecondeAura].duree = Powa_Frames[FNum].duree;
        Powa_Frames[SecondeAura].timerduree = Powa_Frames[FNum].timerduree;
    
        -- si on doit reafficher une seconde anim, fait gaffe de pas la reafficher si elle est sensee avoir disparu
        if (PowaSet[SecondeAura].duration > 0 and Powa_Frames[SecondeAura].duree > PowaSet[SecondeAura].duration) then return; end
    
        Powa_Frames[SecondeAura]:Show();
    
        Powa_FramesVisibleTime[SecondeAura] = 1;
    end
end

-- -------------------------------------------------------------------------------------- ON UPDATE
minScale = {a=0, w=0, h=0};
maxScale = {a=0, w=0, h=0};
curScale = {a=0, w=0, h=0};
speedScale = 0;

function Powa_OnUpdate(elapsed)
    
	-- lance les checks de la cible
	ChecksTimer = ChecksTimer + elapsed;
    local pitch, yaw, squish

	if (ChecksTimer > NextCheck) then
		ChecksTimer = 0;
		if (PowaModTest == false) then
			if IsMounted() then
				WeAreMountednew = true;
			else
				WeAreMountednew = false;
			end
			if (WeAreMountednew ~= WeAreMounted) then
				DoCheckMounted = true;
				WeAreMounted = WeAreMountednew;
			end	
			DoCheckEnchant = true;
		end
	end  

	-- lance les checks normaux
	if (DoCheckBuffs
		or DoCheckTargetBuffs 
		or DoCheckPartyBuffs 
		or DoCheckRaidBuffs 
		or DoCheckUnitBuffs 
		or DoCheckFocusBuffs 
		or DoCheckHealth
		or DoCheckTargetHealth
		or DoCheckPartyHealth 
		or DoCheckRaidHealth 
		or DoCheckFocusHealth 
		or DoCheckMana
		or DoCheckTargetMana
		or DoCheckPartyMana 
		or DoCheckRaidMana 
		or DoCheckFocusMana
		or DoCheckStance
		or DoCheckAction
		or DoCheckEnchant
		or DoCheckMounted) then
			
        Powa_NewCheckBuffs();        
	end

    for i = 0, MaxAuras do
    	if (PowaEnabled == 0) then return; end -- desactived
        
--          if (PowaSet[i].realaura == 1) then
--          local Facing = minimapPlayerModel:GetFacing() - (1.5 * math.pi);
--            
--            SaveView(5);
--		    pitch = tonumber(GetCVar("cameraPitchD"));            
--            pitch = pitch * (1.5 * math.pi) / 360;
--            DEFAULT_CHAT_FRAME:AddMessage("pitch"..pitch);
--		    -- pitch is 0 when level with ground +pi/2 straight above, -pi/2 straight below
--
--		    yaw = tonumber(GetCVar("cameraYawD"));
--		    yaw = yaw * (2 * math.pi) / 360;
--		    -- yaw is 0 whenstraight behind, pi/2 straight right, pi forwards, and 3*pi/2 left
--
--		    -- Here's some weirdness for you
--		    -- When turning with left or right mouse button, camera yaw is relative to game world
--		    -- When not, camera yaw variable is relative to your player.
--
--		    -- HOWEVER, IsMouselooking catches player turning with the RIGHT mouse button, and not camera movement with left.
--		    -- So, we will be hooking WorldFrame:OnMouseDown...
--          if RightClicking or IsMouselooking() then
--			   --yaw = yaw - Facing + (math.pi/2);
--			   --Facing = Facing + yaw;
--			   Facing = yaw + (math.pi/2); -- Camera angle is 90 degree offset from our reference point (straight left).
--
--			   -- However, WHEN mouselooking, camera yaw is relative to north, and I can't use playermodelfacing to get
--			   -- the player facing to compensate and get a relative-to-player camera angle
--          else
--			  Facing = Facing + yaw;
--		    end
--          squish = abs(pitch) / 90; -- Squish!
--            PowaSet[i].torsion = pitch
--            DEFAULT_CHAT_FRAME:AddMessage("squish"..squish);
--            DEFAULT_CHAT_FRAME:AddMessage("torsion"..PowaSet[i].torsion);
--            DEFAULT_CHAT_FRAME:AddMessage("squish"..squish);
--        end    

	if (PowaSet[i] == nil or Powa_Frames[i] == nil) then
		-- rien si vide
         	 
	elseif (Powa_FramesVisibleTime[i] > 0) then -- si visible seulement
        Powa_UpdateTimer(i);
		 -- met a jour les Timers

		DebugTimer = DebugTimer + 1; -- debug

		curScale.w = Powa_Frames[i].baseL; -- regle la taille de l'image en pixel
		curScale.h = Powa_Frames[i].baseH;

		-- pas d'anim si l'effet va disparaitre avec duree
		if ((PowaSet[i].duration > 0) and (Powa_Frames[i].duree > PowaSet[i].duration)) then
			-- si visible, baisse l'alpha
			if (Powa_Frames[i]:GetAlpha() > 0) then
				Powa_Frames[i].beginAnim = 0;
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed * 2);
				-- si alpha 0, cache
				if (curScale.a <= 0) then
					Powa_Frames[i]:SetAlpha(0);
				else
					Powa_Frames[i]:SetAlpha(curScale.a);
				end
			end
		-- animation de depart active ----------------------------------------------
		elseif (Powa_Frames[i].beginAnim > 0) then
			if (i == SecondeAura) then -- la 2eme aura ne s'affiche pas maintenant
				if (Powa_Frames[CurrentSecondeAura].beginAnim == 0) then -- la premiere a fini
					Powa_Frames[i].beginAnim = 0;
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				else
					Powa_Frames[i]:SetAlpha(0.0);
				end
			elseif (PowaSet[i].begin == 1) then -- zoom avant
				maxScale.w = curScale.w * 1.5;
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(curScale.h * 1.5);
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * 150 * PowaSet[i].speed * PowaSet[i].torsion) );
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * 150 * PowaSet[i].speed * (2-PowaSet[i].torsion)) );
				Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - curScale.w)) * PowaSet[i].alpha );
				if (Powa_Frames[i]:GetWidth() < curScale.w) then
					Powa_Frames[i]:SetWidth(curScale.w);
					Powa_Frames[i]:SetHeight(curScale.h);
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
					Powa_Frames[i].beginAnim = 0;
				end
			elseif (PowaSet[i].begin == 2) then -- zoom arriere
				maxScale.w = curScale.w * 0.5;
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(curScale.h * 0.5);
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * 150 * PowaSet[i].speed * PowaSet[i].torsion) );
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * 150 * PowaSet[i].speed * (2-PowaSet[i].torsion)) );
				Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - curScale.w)) * PowaSet[i].alpha );
				if (Powa_Frames[i]:GetWidth() > curScale.w) then
					Powa_Frames[i]:SetWidth(curScale.w);
					Powa_Frames[i]:SetHeight(curScale.h);
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
					Powa_Frames[i].beginAnim = 0;
				end
			elseif (PowaSet[i].begin == 3) then -- transparence
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i]:GetAlpha() > PowaSet[i].alpha) then
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
					Powa_Frames[i].beginAnim = 0;
				end
			elseif (PowaSet[i].begin == 4) then -- gauche
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x - 100;
					Powa_Frames[i].beginAnimY = PowaSet[i].y;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX + (elapsed * 200 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX > PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 5) then
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x - 75;
					Powa_Frames[i].beginAnimY = PowaSet[i].y + 75;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX + (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY - (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 1.5 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX > PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 6) then -- haut
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x;
					Powa_Frames[i].beginAnimY = PowaSet[i].y + 100;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY - (elapsed * 200 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimY < PowaSet[i].y) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 7) then
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x + 75;
					Powa_Frames[i].beginAnimY = PowaSet[i].y + 75;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX - (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY - (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 1.5 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX < PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 8) then -- droite
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x + 100;
					Powa_Frames[i].beginAnimY = PowaSet[i].y;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX - (elapsed * 200 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX < PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 9) then
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x + 75;
					Powa_Frames[i].beginAnimY = PowaSet[i].y - 75;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX - (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY + (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 1.5 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX < PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 10) then -- haut
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x;
					Powa_Frames[i].beginAnimY = PowaSet[i].y - 100;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY + (elapsed * 200 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 2 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimY > PowaSet[i].y) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			elseif (PowaSet[i].begin == 11) then
				if (Powa_Frames[i].beginAnim == 1) then -- init
					Powa_Frames[i].beginAnimX = PowaSet[i].x - 75;
					Powa_Frames[i].beginAnimY = PowaSet[i].y - 75;
					Powa_Frames[i].beginAnim = 3;
					Powa_Frames[i]:SetAlpha(0.0);
				end
				Powa_Frames[i].beginAnimX = Powa_Frames[i].beginAnimX + (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i].beginAnimY = Powa_Frames[i].beginAnimY + (elapsed * 150 * PowaSet[i].speed);
				Powa_Frames[i]:SetAlpha( Powa_Frames[i]:GetAlpha() + (elapsed * 1.5 * PowaSet[i].speed * PowaSet[i].alpha) );
				if (Powa_Frames[i].beginAnimX > PowaSet[i].x) then
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
					Powa_Frames[i].beginAnim = 0;
				else
					Powa_Frames[i]:SetPoint("Center",Powa_Frames[i].beginAnimX, Powa_Frames[i].beginAnimY);
				end
			end
		-- Animations --------------------------------------------------------------
		-- Animation 1 : aucune
		elseif (PowaSet[i].anim1 == 1) then

		-- Animation 2 : max alpha <-> mi-alpha
		elseif (PowaSet[i].anim1 == 2) then
			minScale.a = PowaSet[i].alpha * 0.5 * PowaSet[i].speed;
			maxScale.a = PowaSet[i].alpha;

			if (Powa_Frames[i].statut == 0) then
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed / 2);
				Powa_Frames[i]:SetAlpha( curScale.a )
				if (Powa_Frames[i]:GetAlpha() < minScale.a) then
					Powa_Frames[i]:SetAlpha(minScale.a);
					Powa_Frames[i].statut = 1;
				end
			else
				curScale.a = Powa_Frames[i]:GetAlpha() + (elapsed / 2);
				if (curScale.a > 1.0) then curScale.a = 1.0; end -- pas trop haut non plus
				Powa_Frames[i]:SetAlpha( curScale.a )
				if (Powa_Frames[i]:GetAlpha() >= maxScale.a) then 
					Powa_Frames[i]:SetAlpha(maxScale.a);
					Powa_Frames[i].statut = 0;
				end
			end
		-- Animation 3 : mini-zoom in repetitif + fading
		elseif (PowaSet[i].anim1 == 3) then
			minScale.w = curScale.w * 0.90;
			minScale.h = curScale.h * 0.90;
			maxScale.w = curScale.w * 1.20;
			maxScale.h = curScale.h * 1.20;
			speedScale = (25 * PowaSet[i].speed) * PowaSet[i].size;

			if (Powa_Frames[i].statut == 1) then  -- decale anim 2
				Powa_Frames[i]:SetWidth(curScale.w * 1.15);
				Powa_Frames[i]:SetHeight(curScale.h * 1.15);
				Powa_Frames[i].statut = 0;
			end

			Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * speedScale) )
			Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * speedScale) )

			Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - minScale.w)) * PowaSet[i].alpha );

			if (Powa_Frames[i]:GetWidth() > maxScale.w) then
				Powa_Frames[i]:SetWidth(minScale.w);
				Powa_Frames[i]:SetHeight(minScale.h);
			end
		-- Animation 4 : mini-zoom in/out
		elseif (PowaSet[i].anim1 == 4) then
			minScale.w = curScale.w * 0.95;
			minScale.h = curScale.h * 0.95;
			maxScale.w = curScale.w * 1.05;
			maxScale.h = curScale.h * 1.05;
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;

			if (Powa_Frames[i].statut == 0) then
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * speedScale * (2-PowaSet[i].torsion) ) )				
				if (Powa_Frames[i]:GetWidth() > maxScale.w) then	
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(maxScale.h);
					Powa_Frames[i].statut = 1;
				end
			else
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )				
				if (Powa_Frames[i]:GetWidth() < minScale.w) then 
					Powa_Frames[i]:SetWidth(minScale.w);
					Powa_Frames[i]:SetHeight(minScale.h);
					Powa_Frames[i].statut = 0;
				end
			end
		-- Animation 5 : effet bulle
		elseif (PowaSet[i].anim1 == 5) then
			minScale.w = curScale.w * 0.95;
			minScale.h = curScale.h * 0.95;
			maxScale.w = curScale.w * 1.05;
			maxScale.h = curScale.h * 1.05;
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;

			if (Powa_Frames[i].statut == 0) then	
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )
				if (Powa_Frames[i]:GetWidth() > maxScale.w) then
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(minScale.h);
					Powa_Frames[i].statut = 1;
				end
			else
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * speedScale * (2-PowaSet[i].torsion) ) )
				if (Powa_Frames[i]:GetHeight() > maxScale.h) then 
					Powa_Frames[i]:SetWidth(minScale.w);
					Powa_Frames[i]:SetHeight(maxScale.h);
					Powa_Frames[i].statut = 0;
				end
			end
		-- position au hasard + zoom in + fade
		elseif (PowaSet[i].anim1 == 6) then
			if (Powa_Frames[i]:GetAlpha() > 0) then
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed * PowaSet[i].alpha * 0.5 * PowaSet[i].speed);
				if (curScale.a < 0) then Powa_Frames[i]:SetAlpha(0.0);
				else Powa_Frames[i]:SetAlpha(curScale.a); end
				maxScale.w = Powa_Frames[i]:GetWidth() + (elapsed * 100 * PowaSet[i].speed * PowaSet[i].size);
				maxScale.h = Powa_Frames[i]:GetHeight() + (elapsed * 100 * PowaSet[i].speed * PowaSet[i].size);
				if ( (maxScale.w * 1.5) > Powa_Frames[i]:GetWidth()) then -- evite les lags
					Powa_Frames[i]:SetWidth(maxScale.w)
					Powa_Frames[i]:SetHeight(maxScale.h)
				end
			else
				maxScale.w = (random(0,20) - 10) * PowaSet[i].speed;
				maxScale.h = (random(0,20) - 10) * PowaSet[i].speed;
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				Powa_Frames[i]:SetWidth(curScale.w * 0.85);
				Powa_Frames[i]:SetHeight(curScale.h * 0.85);
				Powa_Frames[i]:SetPoint("Center",PowaSet[i].x + maxScale.w, PowaSet[i].y + maxScale.h);
			end
		-- static sauf parfois ou la texture est decalee + opaque (type electrique)
		elseif (PowaSet[i].anim1 == 7) then
			if (Powa_Frames[i].statut < 2) then
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha / 2); -- mi-alpha
				if (random( 210-(PowaSet[i].speed*100) ) == 1) then
					Powa_Frames[i].statut = 2;
					maxScale.w = random(0,10) - 5;
					maxScale.h = random(0,10) - 5;
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x + maxScale.w, PowaSet[i].y + maxScale.h);
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				end
			else
				Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
				Powa_Frames[i].statut = 0;
			end
		-- zoom out + stop + fade
		elseif (PowaSet[i].anim1 == 8) then
			minScale.w = curScale.w;
			minScale.h = curScale.h;
			maxScale.w = curScale.w * 1.30;
			maxScale.h = curScale.h * 1.30;
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;
			
			if (Powa_Frames[i].statut == 0) then -- demarre le zoom out (max size)
				Powa_Frames[i]:SetWidth(maxScale.w);
				Powa_Frames[i]:SetHeight(maxScale.h);
				Powa_Frames[i]:SetAlpha(0.0);
				Powa_Frames[i].statut = 2;
			elseif (Powa_Frames[i].statut == 2) then -- zoom out + fade in
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )

				Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - minScale.w)) * PowaSet[i].alpha );

				if (Powa_Frames[i]:GetWidth() < curScale.w) then
					Powa_Frames[i]:SetWidth(curScale.w);
					Powa_Frames[i]:SetHeight(curScale.h);	
					Powa_Frames[i].statut = 1;
				end
			elseif (Powa_Frames[i].statut == 1) then -- demarre le fade-out
				Powa_Frames[i]:SetWidth(curScale.w);
				Powa_Frames[i]:SetHeight(curScale.h);
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				Powa_Frames[i].statut = 3;

			elseif (Powa_Frames[i].statut == 3) then -- fade-out
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed / random(1,2));

				if (curScale.a < 0.0) then
					Powa_Frames[i]:SetAlpha(0.0);
					Powa_Frames[i].statut = 0;
				else
					Powa_Frames[i]:SetAlpha(curScale.a);
				end
			end
		-- deplacement vers le haut + fade-out + reduction
		elseif (PowaSet[i].anim1 == 9) then
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;
			
			if (Powa_Frames[i].statut < 2) then -- debut
				Powa_Frames[i]:SetWidth(curScale.w);
				Powa_Frames[i]:SetHeight(curScale.h);
				Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				Powa_Frames[i].statut = 2;
			else
				_,_,_,xOfs,yOfs = Powa_Frames[i]:GetPoint();
				Powa_Frames[i]:SetPoint("Center",xOfs + (random(1,3)-2), yOfs + (elapsed * random(10,20)));
				curScale.a = Powa_Frames[i]:GetAlpha() - ( (elapsed / random(2,4)) * PowaSet[i].alpha);

				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )

				if (curScale.a < 0.0) then
					Powa_Frames[i]:SetAlpha(0.0);
					Powa_Frames[i].statut = 1;
				else
					Powa_Frames[i]:SetAlpha(curScale.a);
				end
			end
		-- rotation autour du centre
		elseif (PowaSet[i].anim1 == 10) then
			maxScale.w = math.max(PowaSet[i].x, -PowaSet[i].x, 5) * 1.0;
			maxScale.h = maxScale.w * (1.6 - PowaSet[i].torsion);
			speedScale = elapsed * 75 * PowaSet[i].speed;
			
			if ((i == SecondeAura) and (PowaSet[CurrentSecondeAura].anim1 == 10)) then
				if (PowaSet[i].symetrie < 2) then
					Powa_Frames[i].statut = Powa_Frames[CurrentSecondeAura].statut + 180;
					if (Powa_Frames[i].statut > 360) then Powa_Frames[i].statut = Powa_Frames[i].statut - 360; end
				else
					Powa_Frames[i].statut = 180-Powa_Frames[CurrentSecondeAura].statut;
					if (Powa_Frames[i].statut < 0) then Powa_Frames[i].statut = Powa_Frames[i].statut + 360; end
				end
			elseif (PowaSet[i].symetrie == 1 or PowaSet[i].symetrie == 3) then
				Powa_Frames[i].statut = Powa_Frames[i].statut - speedScale;
				if (Powa_Frames[i].statut < 0) then Powa_Frames[i].statut = 360; end
			else
				Powa_Frames[i].statut = Powa_Frames[i].statut + speedScale;
				if (Powa_Frames[i].statut > 360) then Powa_Frames[i].statut = 0; end
			end

			-- annule la torsion
			Powa_Frames[i]:SetWidth(curScale.w / PowaSet[i].torsion);
			Powa_Frames[i]:SetHeight(curScale.h / (2-PowaSet[i].torsion));
			-- annule la symetrie
			Powa_textures[i]:SetTexCoord(0, 1, 0, 1);

			-- transparence
			if (Powa_Frames[i].statut < 180) then -- zone de transparence
				if (Powa_Frames[i].statut < 90) then
					Powa_Frames[i]:SetAlpha( (1-(Powa_Frames[i].statut / 90)) * PowaSet[i].alpha );
				else
					Powa_Frames[i]:SetAlpha( ((Powa_Frames[i].statut-90) / 90) * PowaSet[i].alpha );
				end
			else
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
			end

			Powa_Frames[i]:SetPoint("Center",maxScale.w * cos(Powa_Frames[i].statut), (maxScale.h * sin(Powa_Frames[i].statut)) + PowaSet[i].y);
		end

		-- si duration
		if (PowaSet[i].duration > 0) then
			-- ajoute le temps passe
			Powa_Frames[i].duree = Powa_Frames[i].duree + elapsed;
		end
		-- si timer duration
		if (PowaSet[i].timerduration > 0) then
			-- diminue le temps
			Powa_Frames[i].timerduree = Powa_Frames[i].timerduree - elapsed;
			if (Powa_Frames[i].timerduree < 0) then Powa_Frames[i].timerduree = 0; end;
		end

	-- FADE OUT
	elseif Powa_Frames[i]:IsVisible() then

	    if (PowaSet[i].finish > 0) then
		curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed * 2);

		if (curScale.a <= 0) then
			Powa_Frames[i]:Hide();
		else
			if (PowaSet[i].finish == 1) then -- agrandir + fade
				Powa_Frames[i]:SetWidth(Powa_Frames[i]:GetWidth() + (elapsed * 200) );
				Powa_Frames[i]:SetHeight(Powa_Frames[i]:GetHeight() + (elapsed * 200) );
			elseif (PowaSet[i].finish == 2) then -- retrecir + fade
				Powa_Frames[i]:SetWidth( math.max(0, Powa_Frames[i]:GetWidth() - (elapsed * 200)) );
				Powa_Frames[i]:SetHeight( math.max(0, Powa_Frames[i]:GetHeight() - (elapsed * 200)) );
			end
			Powa_Frames[i]:SetAlpha(curScale.a);
		end
	    else
		Powa_Frames[i]:Hide();
	    end	
	
	elseif (PowaSet[i].bufftype == 7)then 
		Powa_UpdateTimer(i);
	end
	

  end	
	Powa_ResetTimers(); -- reset Timers

    ResetTargetTimers = false;
     
    DebugTimer = 0;

end

-- -------------------------------------------------------------------------------------- TIMERS
function Powa_UpdateTimer(numi)
	local newvalue, ntimer;
	
	if (numi > MaxAuras) then -- fin du cycle on arrete
		return;
	elseif (PowaSet[numi] == nil) then -- aucun effet
		return;
	elseif (PowaSet[numi].timer == false) then -- cet effet n'affiche pas de timer
		return;
	end

	ntimer = PowaSet[numi].numtimer;

	-- si on test, met des valeur de timer au hasard...
	if (PowaModTest) then
		newvalue = random(1,9) + (random(1, 99) / 100);
	-- si enchant, prend le temps restant
	elseif (PowaSet[numi].bufftype == 5) then
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
		if (mainHandExpiration) then newvalue = mainHandExpiration / 1000;
		else newvalue = 0; end
	-- si duree buff/debuff cible, prend la valeur de la duree
	elseif (PowaSet[numi].target or PowaSet[numi].targetfriend) then
		if (PowaSet[numi].timerduration > 0) then
			if (ResetTargetTimers == true) then
				Powa_Frames[numi].timerduree = 0;
				newvalue = 0;
			else
				newvalue = Powa_Frames[numi].timerduree;
			end
		else
			newvalue = 0;
		end
	-- si un buff, prend la valeur restante
	elseif (PowaSet[numi].bufftype == 1) then
		newvalue = GetPlayerBuffTimeLeft( GetPlayerBuff(Powa_Frames[numi].buffindex, "HELPFUL") );
		--PowaDebug("bufftimeleft="..newvalue.." buffindex="..Powa_Frames[numi].buffindex);
	-- si un debuff, prend la valeur restante
	elseif (PowaSet[numi].bufftype == 2 or PowaSet[numi].bufftype == 3) then
		newvalue = GetPlayerBuffTimeLeft( GetPlayerBuff(Powa_Frames[numi].buffindex, "HARMFUL") );
		--PowaDebug("debufftimeleft="..newvalue.." buffindex="..Powa_Frames[numi].buffindex);
	-- sinon, ne met rien
	elseif (PowaSet[numi].bufftype == 7) then
		local cdstart, cdduration, _ = GetActionCooldown(PowaSet[numi].opt1);
		-- cdstart = starttime of the CD, cdduration = duration of the cd
		-- ok when cdstart + cdduration = endtime
		local endtime = cdstart + cdduration;
		-- timeleft = endtime - actualtime
	   	newvalue = (endtime - GetTime());
		--PowaDebug("CDtimeleft="..newvalue);
	else
		newvalue = 0;
	end

	-- init
	if (Powa_Timer[ntimer].value == nil) then Powa_Timer[ntimer].value = 0; end
	if (Powa_Timer2[ntimer].value == nil) then Powa_Timer2[ntimer].value = 0; end

	if (newvalue > 0) then -- ok on a un timer a afficher...
		if ((Powa_Timer[ntimer].value > 0) and (newvalue > Powa_Timer[ntimer].value)) then
			-- y'a deja un timer dont le nombre est plus petit, verifie le second
			if (PowaTimer[ntimer].dual == true and PowaTimer[ntimer].cents == true) then
				if ((Powa_Timer2[ntimer].value > 0) and (newvalue > Powa_Timer2[ntimer].value)) then
					-- le second est pris, tant pis...
					return;
				else
					Powa_Timer2[ntimer].num = numi;          -- lien vers l'effet
					Powa_Timer2[ntimer].value = newvalue; -- retiens la valeur
				end
			else
				return;
			end
		else
			Powa_Timer2[ntimer].num = Powa_Timer[ntimer].num;
			Powa_Timer2[ntimer].value = Powa_Timer[ntimer].value;
			Powa_Timer[ntimer].num = numi;       -- lien vers l'effet
			Powa_Timer[ntimer].value = newvalue; -- retiens la valeur
		end
	end
end

function Powa_ResetTimers()
    local deci, uni, newvalue, timedEffect;

    for i = 1, 5 do

	timedEffect = Powa_Timer[i].num;
	if (timedEffect == nil) then
		 
	else	 
		if (timedEffect and timedEffect > 0) then
		-- le timer en cours doit etre affiche	
			if ((Powa_Frames[timedEffect]:IsVisible()) or ((PowaSet[timedEffect].bufftype == 7) and not (AuraHide == true)))then -- l'effet est visible, affiche
				--PowaDebug("bufftype == "..PowaSet[timedEffect].bufftype);
				-- timer 1, le gros (secondes)
				Powa_timertex[i]:SetVertexColor(Powa_textures[timedEffect]:GetVertexColor());
				-- si le timer est > 60, le transforme en minutes
				newvalue = Powa_Timer[i].value;
				if (newvalue > 60.00) then newvalue = newvalue / 60; end
				newvalue = math.min (99.00, newvalue);
			
				deci = math.floor(newvalue / 10);
				uni  = math.floor(newvalue - (deci*10));
				Powa_timertex[i]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
				Powa_Timer[i]:Show();
				-- timer 2, le petit (centieme de secondes)
				-- mode 2eme timer...
				if (PowaTimer[i].dual == true and PowaTimer[i].cents == true and Powa_Timer2[i].value > 0) then
					Powa_timertex2[i]:SetVertexColor(Powa_textures[Powa_Timer2[i].num]:GetVertexColor());
					newvalue = Powa_Timer2[i].value;
					if (newvalue > 60.00) then newvalue = newvalue / 60; end
					newvalue = math.min (99.00, newvalue);
				
					deci = math.floor(newvalue / 10);
					uni  = math.floor(newvalue - (deci*10));
					Powa_timertex2[i]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
					Powa_Timer2[i]:Show();
				elseif (PowaTimer[i].cents == true) then -- mode normal (centiemes)
					Powa_timertex2[i]:SetVertexColor(Powa_textures[timedEffect]:GetVertexColor());
	
					newvalue = Powa_Timer[i].value;
					if (newvalue > 60.00) then 
						newvalue = math.fmod(newvalue,60); 
					else
						newvalue = (newvalue - math.floor(newvalue)) * 100;
					end
					deci = math.floor(newvalue / 10);
					uni  = math.floor(newvalue - (deci*10));
					Powa_timertex2[i]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
					Powa_Timer2[i]:Show();
				else
					Powa_Timer2[i]:Hide();
				end
			else			
					Powa_Timer[i]:Hide();  -- cache les timer
					Powa_Timer2[i]:Hide(); -- cache les timer
			end	
		else
				Powa_Timer[i]:Hide();  -- cache les timer
				Powa_Timer2[i]:Hide(); -- cache les timer
			
		end
	end
	-- reset
	Powa_Timer[i].num = 0;
	Powa_Timer[i].value = 0;
	Powa_Timer2[i].num = 0;
	Powa_Timer2[i].value = 0;
    end -- end for
end

-- --------------------------------------------------------------------------- GESTION DES OPTIONS
function Powa_UpdateAura() -- met a jour l'effet apres modification d'options

	if (PowaEnabled == 0) then return; end   -- desactived

	Powa_CreateFrames(CurrentAura);

	Powa_FramesVisibleTime[CurrentAura] = 0;
	Powa_FramesVisibleTime[SecondeAura] = 0;

	if (Powa_Frames[CurrentAura]:IsVisible()) then -- sinon on affiche seulement si deja visible
		Powa_DisplayAura(CurrentAura);
	end
end

function Powa_OptionTest() -- teste ou masque l'effet choisi

	Powa_CreateFrames(CurrentAura);

	if (PowaSet[CurrentAura] == nil or PowaSet[CurrentAura].buffname == "" or PowaSet[CurrentAura].buffname == " ") then
		return;
	end

	if (Powa_Frames[CurrentAura]:IsVisible()) then -- deja visible, on la cache
		Powa_FramesVisibleTime[CurrentAura] = 0;
		Powa_FramesVisibleTime[SecondeAura] = 0;
	else                                           -- pas visible alors on affiche
		Powa_DisplayAura(CurrentAura);
	end
end

function Powa_OptionHideAll() -- cache tous les effets
	-- cache tous les effets en test
	for i = 0, MaxAuras do
		Powa_FramesVisibleTime[i] = 0;
	end
end
