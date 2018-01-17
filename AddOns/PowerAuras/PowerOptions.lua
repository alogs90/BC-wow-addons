-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< MAIN OPTIONS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

MainOptionPage = 1;
CurrentAuraPage = 1;

MoveEffect = 0; -- 1 = copie / 2 = move

PowaSavedBuff = {};       -- olds -> 121 a 216
PowaSavedDebuff = {};     -- olds -> 217 a 312
PowaSavedDebuffType = {}; -- olds -> 313 a 322

PowaGlobalSet = {};

PowaGlobalListe = {};
PowaPlayerListe = {};
for i = 1, 5 do
	PowaPlayerListe[i] = PowaText.ListePlayer.." "..i;
end
for i = 1, 10 do
	PowaGlobalListe[i] = PowaText.ListeGlobal.." "..i;
end

-- ---------------------------------------------------------------------------------------------------------------------

PowaWowTextures = {};

-- auras types
PowaWowTextures[1] = "Spells\\AuraRune_B";
PowaWowTextures[2] = "Spells\\AuraRune256b";
PowaWowTextures[3] = "Spells\\Circle";
PowaWowTextures[4] = "Spells\\GENERICGLOW2B";
PowaWowTextures[5] = "Spells\\GenericGlow2b1";
PowaWowTextures[6] = "Spells\\ShockRingCrescent256";
-- icones types
PowaWowTextures[7] = "Particles\\Intellect128_outline";
PowaWowTextures[8] = "Spells\\Intellect_128";
PowaWowTextures[9] = "Spells\\Aspect_Beast";
PowaWowTextures[10] = "Spells\\Aspect_Hawk";
PowaWowTextures[11] = "Spells\\Aspect_Wolf";
PowaWowTextures[12] = "Spells\\Blobs";
PowaWowTextures[13] = "Spells\\Blobs2";
PowaWowTextures[14] = "Spells\\DemonRune5backup";
PowaWowTextures[15] = "Spells\\GradientCrescent2";
PowaWowTextures[16] = "Spells\\Holy_Rune_128";
PowaWowTextures[17] = "Spells\\InnerFire_Rune_128";
PowaWowTextures[18] = "Spells\\RapidFire_Rune_128";
PowaWowTextures[19] = "Spells\\Nature_Rune_128";
PowaWowTextures[20] = "Spells\\Protect_128";
PowaWowTextures[21] = "Spells\\Reticle_128";
PowaWowTextures[22] = "Spells\\Star2A";
PowaWowTextures[23] = "Spells\\Star4";
PowaWowTextures[24] = "Spells\\Strength_128";
PowaWowTextures[25] = "Particles\\STUNWHIRL";

-- Total
PowaWowMaxTextures = 25;

-- ---------------------------------------------------------------------------------------------------------------------
function Powa_DefautAura(xnum)
	PowaSet[xnum] = nil;
	PowaSet[xnum] = {
		off = false,
		combat = 0,
		wowtex = false, -- added
		customtex = false, -- added
		customname = "",
		texture = 1,
		texmode = 1, -- added
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
		isdebuff = false, -- del
		isdebufftype = false, -- del
		isenchant = false, -- del
		-- added options
		exact = false,
		gcd = false,
		party = false,
        focus = false,
        raid = false,
        optunitn = false,
        unitn = "",
		threshold = 20,
		sound = 0,
		soundfile = "",		
		customsound = "",
		stance = 10,
		stacks = 0,
		stacksOperator = "=",
		isinraid = false,
		ismounted = false,
		-- ------
		target = false,
		targetfriend = false,		
		timer = false,
		numtimer = 1,
		timerduration = 0,
		inverse = false,
		ignoremaj = true,
		randomcolor = false,
		opt1 = 0,
		opt2 = 0,
		r = 1.0,
		g = 1.0,
		b = 1.0	}
	Powa_FramesVisibleTime[xnum] = 0;
end
-- ---------------------------------------------------------------------------------------------------------------------
function Powa_LoadGlobalStats()
   local a = 1;

	-- teste la version de la sauvegarde du perso actuel
	if (PowaGlobal.SavedVersion == nil or PowaGlobal.SavedVersion == 555) then
		PowaGlobal.SavedVersion = 1;

		a = 121;
		for i = 1, 100 do
		    if (PowaSavedBuff[i]) then
			if (PowaSet[a] == nil) then PowaSet[a] = {}; end
			PowaSet[a].wowtex = PowaSavedBuff[i].wowtex; -- added
			PowaSet[a].texture = PowaSavedBuff[i].texture;
			PowaSet[a].icon = PowaSavedBuff[i].icon;
			PowaSet[a].anim1 = PowaSavedBuff[i].anim1;
			PowaSet[a].anim2 = PowaSavedBuff[i].anim2;
			PowaSet[a].speed = PowaSavedBuff[i].speed;
			PowaSet[a].begin = PowaSavedBuff[i].begin;
			PowaSet[a].finish = PowaSavedBuff[i].finish;
			PowaSet[a].duration = PowaSavedBuff[i].duration;
			PowaSet[a].alpha = PowaSavedBuff[i].alpha;
			PowaSet[a].size = PowaSavedBuff[i].size;
			PowaSet[a].torsion = PowaSavedBuff[i].torsion;
            PowaSet[a].realaura = PowaSavedBuff[i].realaura;
			PowaSet[a].symetrie = PowaSavedBuff[i].symetrie;
			PowaSet[a].x = PowaSavedBuff[i].x;
			PowaSet[a].y = PowaSavedBuff[i].y;
			PowaSet[a].buffname = PowaSavedBuff[i].buffname;			
			PowaSet[a].bufftype = PowaSavedBuff[i].bufftype;
			PowaSet[a].isdebuff = PowaSavedBuff[i].isdebuff;
			PowaSet[a].isdebufftype = PowaSavedBuff[i].isdebufftype;
			PowaSet[a].target = PowaSavedBuff[i].target;
			-- added options
			PowaSet[a].exact = PowaSavedBuff[i].exact;
			PowaSet[a].gcd = PowaSavedBuff[i].gcd;
			PowaSet[a].threshold = PowaSavedBuff[i].threshold;
			PowaSet[a].party = PowaSavedBuff[i].party;
            PowaSet[a].focus = PowaSavedBuff[i].focus;
            PowaSet[a].raid = PowaSavedBuff[i].raid;
            PowaSet[a].optunitn = PowaSavedBuff[i].optunitn;
            PowaSet[a].unitn = PowaSavedBuff[i].unitn;
			PowaSet[a].sound = PowaSavedBuff[i].sound;
			PowaSet[a].soundfile = PowaSavedBuff[i].soundfile;
			PowaSet[a].customsound = PowaSavedBuff[i].customsound;
			PowaSet[a].stance = PowaSavedBuff[i].stance;
			PowaSet[a].stacks = PowaSavedBuff[i].stacks;
			PowaSet[a].stacksOperator = PowaSavedBuff[i].stacksOperator;
			PowaSet[a].isinraid = PowaSavedBuff[i].isinraid;
			PowaSet[a].ismounted = PowaSavedBuff[i].ismounted;
			-- -----------
			PowaSet[a].isenchant = PowaSavedBuff[i].isenchant;
			PowaSet[a].timer = PowaSavedBuff[i].timer;
			PowaSet[a].inverse = PowaSavedBuff[i].inverse;
			PowaSet[a].ignoremaj = PowaSavedBuff[i].ignoremaj;
			PowaSet[a].r = PowaSavedBuff[i].r;
			PowaSet[a].g = PowaSavedBuff[i].g;
			PowaSet[a].b = PowaSavedBuff[i].b;
			PowaSet[a].off = true;

			if (PowaSet[a]) then PowaGlobalSet[a] = PowaSet[a]; end
			a = a+1;
		     else
			PowaSet[a] = nil;
		     end
		     PowaSavedBuff[i] = nil;
		end
--		a = 217;
		for i = 1, 100 do -- debuffs
		     if (PowaSavedDebuff[i]) then
			if (PowaSet[a] == nil) then PowaSet[a] = {}; end
			PowaSet[a].wowtex = PowaSavedDebuff[i].wowtex; -- added
			PowaSet[a].texture = PowaSavedDebuff[i].texture;
			PowaSet[a].icon = PowaSavedDebuff[i].icon;
			PowaSet[a].anim1 = PowaSavedDebuff[i].anim1;
			PowaSet[a].anim2 = PowaSavedDebuff[i].anim2;
			PowaSet[a].speed = PowaSavedDebuff[i].speed;
			PowaSet[a].begin = PowaSavedDebuff[i].begin;
			PowaSet[a].finish = PowaSavedDebuff[i].finish;
			PowaSet[a].duration = PowaSavedDebuff[i].duration;
			PowaSet[a].alpha = PowaSavedDebuff[i].alpha;
			PowaSet[a].size = PowaSavedDebuff[i].size;
			PowaSet[a].torsion = PowaSavedDebuff[i].torsion;
            PowaSet[a].realaura = PowaSavedDebuff[i].realaura;
			PowaSet[a].symetrie = PowaSavedDebuff[i].symetrie;
			PowaSet[a].x = PowaSavedDebuff[i].x;
			PowaSet[a].y = PowaSavedDebuff[i].y;
			PowaSet[a].buffname = PowaSavedDebuff[i].buffname;
			PowaSet[a].isdebuff = PowaSavedDebuff[i].isdebuff;
			PowaSet[a].isdebufftype = PowaSavedDebuff[i].isdebufftype;
			PowaSet[a].target = PowaSavedDebuff[i].target;
			-- added options
			PowaSet[a].party = PowaSavedDebuff[i].party;
            PowaSet[a].focus = PowaSavedDebuff[i].focus;
            PowaSet[a].raid = PowaSavedDebuff[i].raid;
            PowaSet[a].optunitn = PowaSavedDebuff[i].optunitn;
            PowaSet[a].unitn = PowaSavedDebuff[i].unitn;
			PowaSet[a].exact = PowaSavedDebuff[i].exact;
			PowaSet[a].gcd = PowaSavedDebuff[i].gcd;
			PowaSet[a].threshold = PowaSavedDebuff[i].threshold;
			PowaSet[a].sound = PowaSavedDebuff[i].sound;
			PowaSet[a].soundfile = PowaSavedDebuff[i].soundfile;
			PowaSet[a].customsound = PowaSavedDebuff[i].customsound;
			PowaSet[a].stance = PowaSavedDebuff[i].stance;
			PowaSet[a].stacks = PowaSavedDebuff[i].stacks;
			PowaSet[a].stacksOperator = PowaSavedDebuff[i].stacksOperator;
			PowaSet[a].isinraid = PowaSavedDebuff[i].isinraid;
			PowaSet[a].ismounted = PowaSavedDebuff[i].ismounted;
			-- ----------
			PowaSet[a].isenchant = PowaSavedDebuff[i].isenchant;
			PowaSet[a].timer = PowaSavedDebuff[i].timer;
			PowaSet[a].inverse = PowaSavedDebuff[i].inverse;
			PowaSet[a].ignoremaj = PowaSavedDebuff[i].ignoremaj;
			PowaSet[a].r = PowaSavedDebuff[i].r;
			PowaSet[a].g = PowaSavedDebuff[i].g;
			PowaSet[a].b = PowaSavedDebuff[i].b;
			PowaSet[a].off = true;
			
			if (PowaSet[a]) then PowaGlobalSet[a] = PowaSet[a]; end
			a = a+1;
		     else
			PowaSet[a] = nil;
		     end
		     PowaSavedDebuff[i] = nil;
		end
--		a = 313;
		for i = 1, 10 do -- debuffs type
		     if (PowaSavedDebuffType[i]) then
			if (PowaSet[a] == nil) then PowaSet[a] = {}; end
			PowaSet[a].wowtex = PowaSavedDebuffType[i].wowtex; -- added
			PowaSet[a].texture = PowaSavedDebuffType[i].texture;
			PowaSet[a].icon = PowaSavedDebuffType[i].icon;
			PowaSet[a].anim1 = PowaSavedDebuffType[i].anim1;
			PowaSet[a].anim2 = PowaSavedDebuffType[i].anim2;
			PowaSet[a].speed = PowaSavedDebuffType[i].speed;
			PowaSet[a].begin = PowaSavedDebuffType[i].begin;
			PowaSet[a].finish = PowaSavedDebuffType[i].finish;
			PowaSet[a].duration = PowaSavedDebuffType[i].duration;
			PowaSet[a].alpha = PowaSavedDebuffType[i].alpha;
			PowaSet[a].size = PowaSavedDebuffType[i].size;
			PowaSet[a].torsion = PowaSavedDebuffType[i].torsion;
            PowaSet[a].realaura = PowaSavedDebuffType[i].realaura;
			PowaSet[a].symetrie = PowaSavedDebuffType[i].symetrie;
			PowaSet[a].x = PowaSavedDebuffType[i].x;
			PowaSet[a].y = PowaSavedDebuffType[i].y;
			PowaSet[a].buffname = PowaSavedDebuffType[i].buffname;
			PowaSet[a].isdebuff = PowaSavedDebuffType[i].isdebuff;
			PowaSet[a].isdebufftype = PowaSavedDebuffType[i].isdebufftype;
			PowaSet[a].target = PowaSavedDebuffType[i].target;
			-- added options
			PowaSet[a].party = PowaSavedDebuffType[i].party;
            PowaSet[a].focus = PowaSavedDebuffType[i].focus;
            PowaSet[a].raid = PowaSavedDebuffType[i].raid;
            PowaSet[a].optunitn = PowaSavedDebuffType[i].optunitn;
            PowaSet[a].unitn = PowaSavedDebuffType[i].unitn;
			PowaSet[a].exact = PowaSavedDebuffType[i].exact;
			PowaSet[a].gcd = PowaSavedDebuffType[i].gcd;
			PowaSet[a].threshold = PowaSavedDebuffType[i].threshold;
			PowaSet[a].sound = PowaSavedDebuffType[i].sound;
			PowaSet[a].soundfile = PowaSavedDebuffType[i].soundfile;
			PowaSet[a].customsound = PowaSavedDebuffType[i].customsound;
			PowaSet[a].stance = PowaSavedDebuffType[i].stance;
			PowaSet[a].stacks = PowaSavedDebuffType[i].stacks;
			PowaSet[a].stacksOperator = PowaSavedDebuffType[i].stacksOperator;
			PowaSet[a].isinraid = PowaSavedDebuffType[i].isinraid;
			PowaSet[a].ismounted = PowaSavedDebuffType[i].ismounted;
			-- ----------
			PowaSet[a].isenchant = PowaSavedDebuffType[i].isenchant;
			PowaSet[a].timer = PowaSavedDebuffType[i].timer;
			PowaSet[a].inverse = PowaSavedDebuffType[i].inverse;
			PowaSet[a].ignoremaj = PowaSavedDebuffType[i].ignoremaj;
			PowaSet[a].r = PowaSavedDebuffType[i].r;
			PowaSet[a].g = PowaSavedDebuffType[i].g;
			PowaSet[a].b = PowaSavedDebuffType[i].b;
			PowaSet[a].off = true;
			
			if (PowaSet[a]) then PowaGlobalSet[a] = PowaSet[a]; end
			a = a+1;
		     else
			PowaSet[a] = nil;
		     end
		     PowaSavedDebuffType[i] = nil;
		end
		-- supprime le reste
		for i = a, 360 do
			PowaSet[i] = nil;
		end
	else
		-- cree juste un lien vers les effets globaux
		for i = 121, 360 do
			 PowaSet[i] = PowaGlobalSet[i];
		end
	end

	-- reset les effets sans noms
	for i = 1, 360 do
		if (PowaSet[i] ~= nil and PowaSet[i].buffname == "") then
			PowaSet[i] = nil;
		end
		-- gere les rajouts
		if (PowaSet[i]) then
			if (PowaSet[i].combat == nil) then PowaSet[i].combat = 0; end
			if (PowaSet[i].off == nil) then PowaSet[i].off = false; end
			if (PowaSet[i].randomcolor == nil) then PowaSet[i].randomcolor = false; end
			if (PowaSet[i].wowtex == nil) then PowaSet[i].wowtex = false; end
			if (PowaSet[i].realaura == nil) then PowaSet[i].realaura = false; end		
            if (PowaSet[i].customname == nil) then PowaSet[i].customname = ""; end
			if (PowaSet[i].customtex == nil) then PowaSet[i].customtex = false; end
			if (PowaSet[i].texmode == nil) then PowaSet[i].texmode = 1; end
			if (PowaSet[i].target == nil) then PowaSet[i].target = false; end
			if (PowaSet[i].targetfriend == nil) then PowaSet[i].targetfriend = false; end
			-- added options
			if (PowaSet[i].party == nil) then PowaSet[i].party = false; end 
            if (PowaSet[i].focus == nil) then PowaSet[i].focus = false; end 
            if (PowaSet[i].raid == nil) then PowaSet[i].raid = false; end 
            if (PowaSet[i].optunitn == nil) then PowaSet[i].optunitn = false; end 
            if (PowaSet[i].unitn == nil) then PowaSet[i].unitn = ""; end 
            if (PowaSet[i].unitn == false) then PowaSet[i].unitn = ""; end 
			if (PowaSet[i].exact == nil) then PowaSet[i].exact = false; end 
			if (PowaSet[i].gcd == nil) then PowaSet[i].gcd = false; end
			if (PowaSet[i].threshold == nil) then PowaSet[i].threshold = 20; end
			if (PowaSet[i].sound == nil) then PowaSet[i].sound = 0; end
			if (PowaSet[i].soundfile == nil) then PowaSet[i].soundfile = ""; end
			if (PowaSet[i].customsound == nil) then PowaSet[i].customsound = ""; end
			if (PowaSet[i].stance == nil) then PowaSet[i].stance = 10; end
			if (PowaSet[i].stacks == nil) then PowaSet[i].stacks = 0; end
			if (PowaSet[i].stacksOperator == nil) then PowaSet[i].stacksOperator = "="; end
			if (PowaSet[i].isinraid == nil) then PowaSet[i].isinraid = false; end
			if (PowaSet[i].ismounted == nil) then PowaSet[i].ismounted = false; end
			-- ------------
			if (PowaSet[i].isenchant == nil) then PowaSet[i].isenchant = false; end
			if (PowaSet[i].duration == nil) then PowaSet[i].duration = 0; end	
			if (PowaSet[i].begin == nil) then PowaSet[i].begin = 0; end
			if (PowaSet[i].finish == nil) then PowaSet[i].finish = 1; end
			if (PowaSet[i].icon == nil) then PowaSet[i].icon = ""; end
			if (PowaSet[i].timer == nil) then PowaSet[i].timer = false; end
			if (PowaSet[i].timerduration == nil) then PowaSet[i].timerduration = 0; end
			if (PowaSet[i].opt1 == nil) then PowaSet[i].opt1 = 0; end
			if (PowaSet[i].opt2 == nil) then PowaSet[i].opt2 = 0; end
			if (PowaSet[i].inverse == nil) then PowaSet[i].inverse = false; end
			if (PowaSet[i].ignoremaj == nil) then PowaSet[i].ignoremaj = true; end
			if (PowaSet[i].speed == nil) then PowaSet[i].speed = 1.0; end
		end
		-- nouveau, bufftype de 1 a 4
		if (PowaSet[i] and PowaSet[i].bufftype == nil) then
			if (PowaSet[i].isdebuff) then
				PowaSet[i].bufftype = 2;
			elseif (PowaSet[i].isdebufftype) then
				PowaSet[i].bufftype = 3;
			elseif (PowaSet[i].isenchant) then
				PowaSet[i].bufftype = 5;
			else
				PowaSet[i].bufftype = 1;
			end
		end
		if (PowaSet[i] and PowaSet[i].numtimer == nil and PowaSet[i].bufftype == 1) then 
			PowaSet[i].numtimer = 1;
		elseif (PowaSet[i] and PowaSet[i].numtimer == nil and PowaSet[i].bufftype == 2) then 
			PowaSet[i].numtimer = 2;
		elseif (PowaSet[i] and PowaSet[i].numtimer == nil and PowaSet[i].bufftype == 3) then 
			PowaSet[i].numtimer = 3;
		elseif (PowaSet[i] and PowaSet[i].numtimer == nil) then
			PowaSet[i].numtimer = 1;
		end

		Powa_FramesVisibleTime[i] = 0;
	end

	-- Gere les traductions et les noms de liste
	for i = 1, 5 do
		getglobal("PowaOptionsList"..i):SetText(PowaPlayerListe[i]);
	end
	for i = 1, 10 do
		getglobal("PowaOptionsList"..i+5):SetText(PowaGlobalListe[i]);
	end
end
-- ---------------------------------------------------------------------------------------------------------------------
function Powa_UpdateMainOption()
	local k = 0;
	
	-- traductions
	getglobal("PowaOptionsHeader"):SetText("POWER AURAS "..PowaVersion);
	getglobal("PowaMainHideAllButton"):SetText(PowaText.nomHide);
	getglobal("PowaMainTestButton"):SetText(PowaText.nomTest);
	getglobal("PowaEditButton"):SetText(PowaText.nomEdit);
	getglobal("PowaOptionsRename"):SetText(PowaText.nomRename);
	if (PowaMisc.disabled) then
		getglobal("PowaEnableButton"):SetChecked(false);
	else
		getglobal("PowaEnableButton"):SetChecked(true);
	end
	if (PowaMisc.debug) then
		getglobal("PowaDebugButton"):SetChecked(true);
	else
		getglobal("PowaDebugButton"):SetChecked(false);
	end

	-- affiche les icones
	for i = 1, 24 do
		k = ((MainOptionPage-1)*24) + i;
		
		-- icone
		if (PowaSet[k] == nil) then
			getglobal("PowaIcone"..i):SetNormalTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot");
		elseif (PowaSet[k].buffname == "" or PowaSet[k].buffname == " ") then -- pas de nom -> desactive
			getglobal("PowaIcone"..i):SetNormalTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot");
		elseif (PowaSet[k].icon == "") then -- active mais pas d'icone
			getglobal("PowaIcone"..i):SetNormalTexture("Interface\\Icons\\Inv_Misc_QuestionMark");
		else
			getglobal("PowaIcone"..i):SetNormalTexture(PowaSet[k].icon);	
		end
		-- off ou ON
		if (PowaSet[k] and PowaSet[k].buffname ~= "" and PowaSet[k].buffname ~= " " and PowaSet[k].off) then
			getglobal("PowaIcone"..i):SetText("OFF");
		else
			getglobal("PowaIcone"..i):SetText("");
		end
		-- surbrillance de l'effet en cours
		if (CurrentAura == k) then -- le bouton en cours
			if (PowaSet[k] == nil or PowaSet[k].buffname == "" or PowaSet[k].buffname == " ") then -- nulle
				getglobal("PowaSelected"):Hide();
			else
				getglobal("PowaSelected"):SetPoint("CENTER", "PowaIcone"..i, "CENTER");
				getglobal("PowaSelected"):Show();
			end
		end
		-- grisage des effets non visibles
		if (Powa_FramesVisibleTime[k] == nil or Powa_FramesVisibleTime[k] == 0) then
			getglobal("PowaIcone"..i):SetAlpha(0.33);
		else
			getglobal("PowaIcone"..i):SetAlpha(1.0);
		end
	end
	-- choisi la liste en cours
	getglobal("PowaOptionsList"..MainOptionPage):SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight");
	getglobal("PowaOptionsList"..MainOptionPage):LockHighlight();
end
-- ---------------------------------------------------------------------------------------------------------------------
function Powa_IconeClick()
	local iconeID = this:GetID();
	local k = ((MainOptionPage-1)*24) + iconeID;

	if (MoveEffect > 0) then -- mode move, annule
		return;
	elseif (ColorPickerFrame:IsVisible()) then -- color picker visible, ca deconne
		return;
	elseif (PowaSet[k] == nil or PowaSet[k].buffname == "" or PowaSet[k].buffname == " ") then -- ne fait rien si bouton vide
		return;
	elseif (IsShiftKeyDown()) then -- ON ou OFF
		if (PowaSet[k].off) then -- deja ON
			PowaSet[k].off = false;
			getglobal("PowaIcone"..iconeID):SetText("");
		else
			PowaSet[k].off = true;
			getglobal("PowaIcone"..iconeID):SetText("OFF");
		end
	elseif (CurrentAura == k) then -- on appuie sur le meme bouton, show ou hide
		if (arg1 == "RightButton") then
			Powa_EditorShow();
			return;
		elseif (Powa_FramesVisibleTime[CurrentAura] > 0) then -- deja visible, on la cache
			Powa_FramesVisibleTime[CurrentAura] = 0;
			Powa_FramesVisibleTime[SecondeAura] = 0;
			getglobal("PowaIcone"..iconeID):SetAlpha(0.33);
		else                                           -- pas visible alors on affiche
			Powa_DisplayAura(CurrentAura);
			getglobal("PowaIcone"..iconeID):SetAlpha(1.0);
		end
	elseif (CurrentAura ~= k) then -- on appuie un bouton different...
		CurrentAura = k;
		CurrentAuraPage = MainOptionPage;
		getglobal("PowaSelected"):SetPoint("CENTER", this, "CENTER");
		getglobal("PowaSelected"):Show();
		Powa_InitPage(); -- change de page dans l'editeur d'effet
	end
end

function Powa_IconeEntered()
	local iconeID = this:GetID();
	local k = ((MainOptionPage-1)*24) + iconeID;

	if (MoveEffect > 0) then -- mode move, annule
		return;
	elseif (PowaSet[k] == nil) then
		-- rien si pas actif
	elseif (PowaSet[k].buffname == "" or PowaSet[k].buffname == " ") then
		-- rien si pas de nom
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		
		if (PowaSet[k].bufftype == 2) then
			GameTooltip:SetText(PowaText.nomCheckDebuff, 1.0, 0.7, 0.7, 1);
			if not (PowaSet[k].buffname == "???") then
				GameTooltip:AddLine(PowaSet[k].buffname, nil, nil, nil, nil, 1);
    		end
			GameTooltip:AddLine(PowaText.nomStacks..PowaSet[k].stacksOperator..PowaSet[k].stacks, 1.0, 0.7, 0.7, 1);
			
		elseif (PowaSet[k].bufftype == 3) then
			GameTooltip:SetText(PowaText.nomCheckDebuffType, 1.0, 1.0, 0.7, 1);
			
		elseif (PowaSet[k].bufftype == 4) then
			GameTooltip:SetText(PowaText.nomCheckAoeDebuff, 1.0, 0.3, 0.1, 1);
			if not (PowaSet[k].buffname == "???") then
				GameTooltip:AddLine(PowaSet[k].buffname, nil, nil, nil, nil, 1);
    		end
			
		elseif (PowaSet[k].bufftype == 5) then
			GameTooltip:SetText(PowaText.nomCheckEnchant, 1.0, 0.7, 1.0, 1);
			if not (PowaSet[k].buffname == "???") then
				GameTooltip:AddLine(PowaSet[k].buffname, nil, nil, nil, nil, 1);
    		end
			
		elseif (PowaSet[k].bufftype == 6) then
			GameTooltip:SetText(PowaText.nomCheckCombo, 1.0, 1.0, 0.0, 1);
			
		elseif (PowaSet[k].bufftype == 7) then
			GameTooltip:SetText(PowaText.nomCheckSkill, 0.7, 0.7, 1.0, 1);
			if not (PowaSet[k].buffname == "???") then
				GameTooltip:AddLine(PowaSet[k].buffname, nil, nil, nil, nil, 1);
    		end
			
		elseif (PowaSet[k].bufftype == 8) then
			GameTooltip:SetText(PowaText.nomCheckHealth, 0.7, 0.7, 1.0, 1);
			GameTooltip:AddLine(PowaSet[k].threshold, 0.7, 0.7, 1.0, 1);
			
		elseif (PowaSet[k].bufftype == 9) then
			GameTooltip:SetText(PowaText.nomCheckMana, 0.7, 0.7, 1.0, 1);
			GameTooltip:AddLine(PowaSet[k].threshold, 0.7, 0.7, 1.0, 1);
			
		elseif (PowaSet[k].bufftype == 10) then
			GameTooltip:SetText(PowaText.nomCheckStance, 0.7, 0.7, 1.0, 1);
			GameTooltip:AddLine(PowaStance[PowaSet[k].stance], 0.7, 0.7, 1.0, 1);
			
		elseif (PowaSet[k].bufftype == 1) then
			GameTooltip:SetText(PowaText.nomCheckBuff, 0.7, 1.0, 0.7, 1);
			if not (PowaSet[k].buffname == "???") then
				GameTooltip:AddLine(PowaSet[k].buffname, nil, nil, nil, nil, 1);
    		end
			GameTooltip:AddLine(PowaText.nomStacks..PowaSet[k].stacksOperator..PowaSet[k].stacks, 0.7, 1.0, 0.7, 1);
		end
		
        if (PowaSet[k].party) then
			GameTooltip:AddLine("("..PowaText.nomCheckParty..")", 1.0, 0.2, 0.2, 1);
		end		
		if (PowaSet[k].exact) then
			GameTooltip:AddLine("("..PowaText.nomExact..")", 1.0, 0.2, 0.2, 1);
		end	
		if (PowaSet[k].gcd) then
			GameTooltip:AddLine("("..PowaText.nomGCD..")", 1.0, 0.2, 0.2, 1);
		end	
        if (PowaSet[k].focus) then
			GameTooltip:AddLine("("..PowaText.nomCheckFocus..")", 1.0, 0.2, 0.2, 1);
		end
        if (PowaSet[k].raid) then
			GameTooltip:AddLine("("..PowaText.nomCheckRaid..")", 1.0, 0.2, 0.2, 1);
		end
        if (PowaSet[k].optunitn) then
			GameTooltip:AddLine("("..PowaText.nomCheckOptunitn..")", 1.0, 0.2, 0.2, 1);
		end
		if (PowaSet[k].target) then
			GameTooltip:AddLine("("..PowaText.nomCheckTarget..")", 1.0, 0.2, 0.2, 1);
		end
		if (PowaSet[k].targetfriend) then
			GameTooltip:AddLine("("..PowaText.nomCheckFriend..")", 0.2, 1.0, 0.2, 1);
		end
		GameTooltip:AddLine(PowaText.aideEffectTooltip,1.0,1.0,1.0,1);

		GameTooltip:Show();
	end
end

function Powa_MainListClick()
	local listeID = this:GetID();

	if (MoveEffect == 1) then
		-- deplace l'effet
		Powa_BeginCopyEffect(CurrentAura, listeID)
		return;
	elseif (MoveEffect == 2) then
		-- deplace l'effet
		Powa_BeginMoveEffect(CurrentAura, listeID)
		return;
	end

	getglobal("PowaOptionsList"..MainOptionPage):SetHighlightTexture("");
	getglobal("PowaOptionsList"..MainOptionPage):UnlockHighlight();
	getglobal("PowaSelected"):Hide();
	MainOptionPage = listeID;

	-- selectionne le premier effet de la page
	CurrentAura = ((MainOptionPage-1)*24)+1;
	CurrentAuraPage = MainOptionPage;
	-- change de page dans l'editeur d'effet ou cache l'editeur
	if (PowaSet[CurrentAura] ~= nil and PowaSet[CurrentAura].buffname ~= "" and PowaSet[CurrentAura].buffname ~= " ") then
		Powa_InitPage(); 
	else
		Powa_EditorClose();
	end

	-- en cas d'edition de renommage :)
	getglobal("PowaOptionsRenameEditBox"):SetText( getglobal("PowaOptionsList"..MainOptionPage):GetText() );

	Powa_UpdateMainOption();
end

function Powa_MainListEntered()
	local listeID = this:GetID();

	if (MainOptionPage ~= listeID) then
		if (MoveEffect > 0) then
			getglobal("PowaOptionsList"..listeID):SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight"); 
		else
			getglobal("PowaOptionsList"..listeID):SetHighlightTexture("");
			getglobal("PowaOptionsList"..listeID):UnlockHighlight();
		end
	end
	if (MoveEffect == 1) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(PowaText.aideCopy, nil, nil, nil, nil, 1);
		GameTooltip:Show();
	elseif (MoveEffect == 2) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(PowaText.aideMove, nil, nil, nil, nil, 1);
		GameTooltip:Show();
	end
end
-- ---------------------------------------------------------------------------------------------------------------------
function Powa_OptionRename()
	getglobal("PowaOptionsRename"):Hide();
	getglobal("PowaOptionsRenameEditBox"):Show();

	getglobal("PowaOptionsRenameEditBox"):SetText( getglobal("PowaOptionsList"..MainOptionPage):GetText() );
end

function Powa_OptionRenameEdited()
	getglobal("PowaOptionsRename"):Show();
	getglobal("PowaOptionsRenameEditBox"):Hide();

	getglobal("PowaOptionsList"..MainOptionPage):SetText( getglobal("PowaOptionsRenameEditBox"):GetText() );
	if (MainOptionPage > 5) then
		PowaGlobalListe[MainOptionPage-5] = getglobal("PowaOptionsRenameEditBox"):GetText();
	else
		PowaPlayerListe[MainOptionPage] = getglobal("PowaOptionsRenameEditBox"):GetText();
	end
end
-- ---------------------------------------------------------------------------------------------------------------------
function Powa_TriageIcones(nPage)
  local min = ((nPage-1)*24) + 1;
  local max = ((nPage-1)*24) + 24;

  local a = min;

	-- masque les effets de la page
	for i = min, max do
		Powa_FramesVisibleTime[i] = 0;
		if (Powa_Frames[i]) then Powa_Frames[i]:Hide(); end
	end
	-- masque aussi le second effet
	Powa_FramesVisibleTime[0] = 0;
	Powa_Frames[0]:Hide();

	for i = min, max do
		if (PowaSet[i]) then
			PowaSet[a] = PowaSet[i];
			PowaSet[a].off = PowaSet[i].off; -- off ou ON
			if (i>a) then
				PowaSet[i] = nil;
			end
			a = a+1;
		end
	end
	-- gere les liens vers les effets globaux
	for i = 121, 360 do
		if (PowaSet[i]) then 
			PowaGlobalSet[i] = PowaSet[i]; 
		else
			PowaGlobalSet[i] = nil;
		end
	end
end

function Powa_OptionDeleteEffect()
  local min = ((MainOptionPage-1)*24) + 1;
  local max = ((MainOptionPage-1)*24) + 24;

     if (IsControlKeyDown()) then
	PowaSet[CurrentAura] = nil; -- efface l'entree
	getglobal("PowaSelected"):Hide();

	if (getglobal("PowaBarConfigFrame"):IsVisible()) then
		getglobal("PowaBarConfigFrame"):Hide();
	end

	Powa_TriageIcones(MainOptionPage); -- trie les trous
	Powa_UpdateMainOption();
     end
end

function Powa_OptionNewEffect()
  local min = ((MainOptionPage-1)*24) + 1;
  local max = ((MainOptionPage-1)*24) + 24;

	for i = min, max do
        
		if (PowaSet[i] == nil or PowaSet[i].buffname == "" or PowaSet[i].buffname == " ") then -- on a trouve une place dispo			
                       
            CurrentAura = i;
			CurrentAuraPage = MainOptionPage;
			Powa_DefautAura(i);
			PowaSet[i].buffname = "???"; -- un nom pour le visu
            PowaSet[i].unitn = PowaText.aideUnitn2; 
			PowaSet[i].off = false;
			-- effet global ?
			if (i > 120) then
				PowaGlobalSet[i] = PowaSet[i];
			end
			Powa_DisplayAura(CurrentAura);
			Powa_UpdateMainOption();
			-- affiche l'editeur
			if (getglobal("PowaBarConfigFrame"):IsVisible()) then
				Powa_InitPage();
			else
				Powa_InitPage();
				getglobal("PowaBarConfigFrame"):Show();
				PlaySound("TalentScreenOpen");
			end
			return;
		end
	end
end

function Powa_DisableMoveMode()
	getglobal("PowaOptionsMove"):UnlockHighlight();
	getglobal("PowaOptionsCopy"):UnlockHighlight();
	MoveEffect = 0;
	for i = 1, 15 do
		getglobal("PowaOptionsList"..i.."Glow"):Hide();
	end
	-- reactive les boutons
	getglobal("PowaOptionsMove"):Enable();
	getglobal("PowaOptionsCopy"):Enable();
	getglobal("PowaOptionsRename"):Enable();
	getglobal("PowaEditButton"):Enable();
	getglobal("PowaMainTestButton"):Enable();
	getglobal("PowaMainHideAllButton"):Enable();
	getglobal("PowaOptionsSelectorNew"):Enable();
	getglobal("PowaOptionsSelectorDelete"):Enable();
end

function Powa_OptionMoveEffect(isMove)

	if (PowaSet[CurrentAura] == nil or PowaSet[CurrentAura].buffname == "" or PowaSet[CurrentAura].buffname == " ") then
		return; -- on essaye de deplacer un effet vide !!
	end

	-- illumine le bouton pour dire que c'est actif
	if (MoveEffect == 0) then
		if (isMove) then
			MoveEffect = 2;
			getglobal("PowaOptionsMove"):LockHighlight();
			getglobal("PowaOptionsCopy"):Disable();
		else
			MoveEffect = 1;
			getglobal("PowaOptionsCopy"):LockHighlight();
			getglobal("PowaOptionsMove"):Disable();
		end
		for i = 1, 15 do
			getglobal("PowaOptionsList"..i.."Glow"):SetVertexColor(0.5,0.5,0.5);
			getglobal("PowaOptionsList"..i.."Glow"):Show();
		end
		-- annule tous les boutons
		getglobal("PowaOptionsRename"):Disable();
		getglobal("PowaEditButton"):Disable();
		getglobal("PowaMainTestButton"):Disable();
		getglobal("PowaMainHideAllButton"):Disable();
		getglobal("PowaOptionsSelectorNew"):Disable();
		getglobal("PowaOptionsSelectorDelete"):Disable();
	else
		Powa_DisableMoveMode();
	end
end

function Powa_BeginMoveEffect(Pfrom, ToPage)
  local min = ((ToPage-1)*24) + 1;
  local max = ((ToPage-1)*24) + 24;
	-- trouve un endroit dispo dans la page choisie
	for i = min, max do
		if (PowaSet[i] == nil or PowaSet[i].buffname == "" or PowaSet[i].buffname == " ") then -- on a trouve une place dispo
			Powa_DoCopyEffect(Pfrom, i, true); -- copie et efface effet actuel
			Powa_TriageIcones(CurrentAuraPage); -- trie les pages pour eviter les trous
			CurrentAura = ((MainOptionPage-1)*24)+1; -- nouvelle aura en cours sera le premier effet de cette page
			-- gere les visus
			Powa_DisableMoveMode();
			-- met a jour la page
			Powa_UpdateMainOption();
			return;
		end
	end
end

function Powa_BeginCopyEffect(Pfrom, ToPage)
  local min = ((ToPage-1)*24) + 1;
  local max = ((ToPage-1)*24) + 24;
	-- trouve un endroit dispo dans la page choisie
	for i = min, max do
		if (PowaSet[i] == nil or PowaSet[i].buffname == "" or PowaSet[i].buffname == " ") then -- on a trouve une place dispo
			Powa_DoCopyEffect(Pfrom, i, false); -- copie et efface effet actuel
			CurrentAura = i; -- nouvelle aura en cours sera l'effet cree
			-- gere les visus
			Powa_DisableMoveMode();
			-- met a jour la page
			Powa_UpdateMainOption();
			return;
		end
	end
end

function Powa_DoCopyEffect(Pfrom, Pcopied, isMove)
	if (PowaSet[Pcopied] == nil) then PowaSet[Pcopied] = {}; end
	PowaSet[Pcopied].wowtex = PowaSet[Pfrom].wowtex; -- added
	PowaSet[Pcopied].customtex = PowaSet[Pfrom].customtex; -- added
	PowaSet[Pcopied].customname = PowaSet[Pfrom].customname; -- added
	PowaSet[Pcopied].texture = PowaSet[Pfrom].texture;
	PowaSet[Pcopied].icon = PowaSet[Pfrom].icon;
	PowaSet[Pcopied].anim1 = PowaSet[Pfrom].anim1;
	PowaSet[Pcopied].anim2 = PowaSet[Pfrom].anim2;
	PowaSet[Pcopied].speed = PowaSet[Pfrom].speed;
	PowaSet[Pcopied].begin = PowaSet[Pfrom].begin;
	PowaSet[Pcopied].finish = PowaSet[Pfrom].finish;
	PowaSet[Pcopied].texmode = PowaSet[Pfrom].texmode;
	PowaSet[Pcopied].duration = PowaSet[Pfrom].duration;
	PowaSet[Pcopied].alpha = PowaSet[Pfrom].alpha;
	PowaSet[Pcopied].size = PowaSet[Pfrom].size;
	PowaSet[Pcopied].torsion = PowaSet[Pfrom].torsion;
    PowaSet[Pcopied].realaura = PowaSet[Pfrom].realaura;
	PowaSet[Pcopied].symetrie = PowaSet[Pfrom].symetrie;
	PowaSet[Pcopied].x = PowaSet[Pfrom].x;
	PowaSet[Pcopied].y = PowaSet[Pfrom].y;
	PowaSet[Pcopied].buffname = PowaSet[Pfrom].buffname;
	PowaSet[Pcopied].bufftype = PowaSet[Pfrom].bufftype;
	PowaSet[Pcopied].isdebuff = PowaSet[Pfrom].isdebuff;
	PowaSet[Pcopied].isdebufftype = PowaSet[Pfrom].isdebufftype;
	PowaSet[Pcopied].target = PowaSet[Pfrom].target;
	PowaSet[Pcopied].targetfriend = PowaSet[Pfrom].targetfriend;
	-- added options
	PowaSet[Pcopied].party = PowaSet[Pfrom].party;
    PowaSet[Pcopied].focus = PowaSet[Pfrom].focus;
    PowaSet[Pcopied].raid = PowaSet[Pfrom].raid;
    PowaSet[Pcopied].optunitn = PowaSet[Pfrom].optunitn;
    PowaSet[Pcopied].unitn = PowaSet[Pfrom].unitn;
	PowaSet[Pcopied].exact = PowaSet[Pfrom].exact; -- v.2.40
	PowaSet[Pcopied].gcd = PowaSet[Pfrom].gcd;-- v.2.41
	PowaSet[Pcopied].threshold = PowaSet[Pfrom].threshold; -- v.2.40
	PowaSet[Pcopied].sound = PowaSet[Pfrom].sound; -- v.2.43
	PowaSet[Pcopied].soundfile = PowaSet[Pfrom].soundfile; -- v.2.43
	PowaSet[Pcopied].customsound = PowaSet[Pfrom].customsound; -- v.2.43
	PowaSet[Pcopied].stance = PowaSet[Pfrom].stance; -- v.2.44
	PowaSet[Pcopied].stacks = PowaSet[Pfrom].stacks; -- v.2.45
	PowaSet[Pcopied].stacksOperator = PowaSet[Pfrom].stacksOperator; -- v.2.45
	PowaSet[Pcopied].isinraid = PowaSet[Pfrom].isinraid; -- v.2.45
	PowaSet[Pcopied].ismounted = PowaSet[Pfrom].ismounted; -- v.2.45
	-- --------
	PowaSet[Pcopied].isenchant = PowaSet[Pfrom].isenchant;
	PowaSet[Pcopied].timer = PowaSet[Pfrom].timer;
	PowaSet[Pcopied].numtimer = PowaSet[Pfrom].numtimer;
	PowaSet[Pcopied].timerduration = PowaSet[Pfrom].timerduration;
	PowaSet[Pcopied].inverse = PowaSet[Pfrom].inverse;
	PowaSet[Pcopied].ignoremaj = PowaSet[Pfrom].ignoremaj;
	PowaSet[Pcopied].randomcolor = PowaSet[Pfrom].randomcolor;
	PowaSet[Pcopied].opt1 = PowaSet[Pfrom].opt1;
	PowaSet[Pcopied].opt2 = PowaSet[Pfrom].opt2;
	PowaSet[Pcopied].r = PowaSet[Pfrom].r;
	PowaSet[Pcopied].g = PowaSet[Pfrom].g;
	PowaSet[Pcopied].b = PowaSet[Pfrom].b;
	PowaSet[Pcopied].off = PowaSet[Pfrom].off;
	PowaSet[Pcopied].combat = PowaSet[Pfrom].combat;

	if (Pcopied > 120) then -- on entre dans la zone des effets globaux
		PowaGlobalSet[Pcopied] = PowaSet[Pcopied];
	end

	if (isMove == true) then
		PowaSet[Pfrom] = nil;
	end
end
-- ---------------------------------------------------------------------------------------------------------------------
function Powa_MainOptionShow()
	if (PowaOptionsFrame:IsVisible()) then
		Powa_MainOptionClose();
	else
		Powa_OptionHideAll();
		PowaModTest = true;
		Powa_UpdateMainOption();
		getglobal("PowaOptionsFrame"):Show();
		PlaySound("TalentScreenOpen");
	end
end

function Powa_MainOptionClose() -- ferme la fenetre d'option
	Powa_DisableMoveMode();
	PowaModTest = false;
	getglobal("PowaBarConfigFrame"):Hide();
	getglobal("PowaOptionsFrame"):Hide();
	PlaySound("TalentScreenClose");
	-- cache tous les effets en test
	for i = 0, MaxAuras do
	    if (PowaSet[i]) then
		Powa_FramesVisibleTime[i] = 0;
	    end
	end
    
	Powa_CreateEffectLists();
	DoCheckBuffs = true;
	DoCheckTargetBuffs = true;
	DoCheckPartyBuffs = true;
    DoCheckRaidBuffs = true;
    DoCheckFocusBuffs = true;
    DoCheckUnitBuffs = true;
	DoCheckOthers = true;
	DoCheckEnchant = true;
	DoCheckHealth = true;
	DoCheckMana = true;
	DoCheckCombo = true;
	DoCheckStance = true;
	DoCheckAction = true;
	Powa_NewCheckBuffs();
    Powa_MemorizeActions(0);
    -- detect les effets en cours
end

function PowaEnableChecked()
	if (getglobal("PowaEnableButton"):GetChecked()) then
		PowaMisc.disabled = false;
	else
		PowaMisc.disabled = true;
	end
end

function PowaDebugChecked()
	if (getglobal("PowaDebugButton"):GetChecked()) then
		PowaMisc.debug = true;
	else
		PowaMisc.debug = false;
	end
end
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< MAIN OPTIONS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function Powa_UpdateTimerOptions()
	local tnum;

	if (getglobal("PowaBarConfigFrameEditor4"):IsVisible()) then

		getglobal("PowaShowTimerButton"):SetChecked(PowaSet[CurrentAura].timer);

		tnum = PowaSet[CurrentAura].numtimer;
		if (tnum == nil) then 
			return; 
		elseif (tnum == 0) then
			PowaSet[CurrentAura].numtimer = 1;
			tnum = 1;
		end -- evite une erreur bizarre

		getglobal("PowaTimerAlphaSlider"):SetValue(PowaTimer[tnum].a);
		getglobal("PowaTimerSizeSlider"):SetValue(PowaTimer[tnum].h);
		-- ajuste slider Y
		getglobal("PowaTimerCoordSlider"):SetMinMaxValues(PowaTimer[tnum].y-5000,PowaTimer[tnum].y+5000);
		getglobal("PowaTimerCoordSliderLow"):SetText(PowaTimer[tnum].y-100);
		getglobal("PowaTimerCoordSliderHigh"):SetText(PowaTimer[tnum].y+100);
		getglobal("PowaTimerCoordSlider"):SetValue(PowaTimer[tnum].y);
		getglobal("PowaTimerCoordSlider"):SetMinMaxValues(PowaTimer[tnum].y-100,PowaTimer[tnum].y+100);
		-- ajuste slider X
		getglobal("PowaTimerCoordXSlider"):SetMinMaxValues(PowaTimer[tnum].x-5000,PowaTimer[tnum].x+5000);
		getglobal("PowaTimerCoordXSliderLow"):SetText(PowaTimer[tnum].x-100);
		getglobal("PowaTimerCoordXSliderHigh"):SetText(PowaTimer[tnum].x+100);
		getglobal("PowaTimerCoordXSlider"):SetValue(PowaTimer[tnum].x);
		getglobal("PowaTimerCoordXSlider"):SetMinMaxValues(PowaTimer[tnum].x-100,PowaTimer[tnum].x+100);

		getglobal("PowaBuffTimerCentsButton"):SetChecked(PowaTimer[tnum].cents);
		getglobal("PowaBuffTimerDualButton"):SetChecked(PowaTimer[tnum].dual);
	end
end

function Powa_InitPage()
	local CheckTexture = 0;

	Powa_UpdateTimerOptions();

	getglobal("PowaDropDownAnim1Text"):SetText(PowaAnim[PowaSet[CurrentAura].anim1]);
	getglobal("PowaDropDownAnim2Text"):SetText(PowaAnim[PowaSet[CurrentAura].anim2]);
	getglobal("PowaDropDownAnimBeginText"):SetText(PowaDisplay[PowaSet[CurrentAura].begin]);
	getglobal("PowaDropDownAnimEndText"):SetText(PowaDisplay[PowaSet[CurrentAura].finish]);
    -- added dropdowns
	getglobal("PowaDropDownSoundText"):SetText(PowaSound[PowaSet[CurrentAura].sound]); -- v.2.43
	getglobal("PowaDropDownStanceText"):SetText(PowaStance[PowaSet[CurrentAura].stance]); -- v.2.44
	getglobal("PowaBarCustomSound").aide = PowaText.aideCustomSound;
	getglobal("PowaBarBuffStacks").aide = PowaText.aideStacks;
	-- ---------------
	getglobal("PowaWowTextureButton"):SetChecked(PowaSet[CurrentAura].wowtex);
	getglobal("PowaCustomTextureButton"):SetChecked(PowaSet[CurrentAura].customtex);
	getglobal("PowaRandomColorButton"):SetChecked(PowaSet[CurrentAura].randomcolor);
	getglobal("PowaIgnoreMajButton"):SetChecked(PowaSet[CurrentAura].ignoremaj);
	getglobal("PowaInverseButton"):SetChecked(PowaSet[CurrentAura].inverse);
	getglobal("PowaTargetButton"):SetChecked(PowaSet[CurrentAura].target);
	getglobal("PowaTargetFriendButton"):SetChecked(PowaSet[CurrentAura].targetfriend);
	-- added checkboxes
	getglobal("PowaPartyButton"):SetChecked(PowaSet[CurrentAura].party);
    getglobal("PowaFocusButton"):SetChecked(PowaSet[CurrentAura].focus);
    getglobal("PowaRaidButton"):SetChecked(PowaSet[CurrentAura].raid);
    getglobal("PowaOptunitnButton"):SetChecked(PowaSet[CurrentAura].optunitn);
	getglobal("PowaExactButton"):SetChecked(PowaSet[CurrentAura].exact);
	getglobal("PowaGCDButton"):SetChecked(PowaSet[CurrentAura].gcd);
	getglobal("PowaIsInRaidButton"):SetChecked(PowaSet[CurrentAura].isinraid);
	getglobal("PowaIsMountedButton"):SetChecked(PowaSet[CurrentAura].ismounted);
	-- ----------------
	getglobal("PowaTexModeButton"):SetChecked(PowaSet[CurrentAura].texmode == 1);
    -- getglobal("PowaRealauraButton"):SetChecked(PowaSet[CurrentAura].realaura == 1);
	
    getglobal("PowaTimer1Button"):SetChecked(PowaSet[CurrentAura].numtimer == 1);
	getglobal("PowaTimer2Button"):SetChecked(PowaSet[CurrentAura].numtimer == 2);
	getglobal("PowaTimer3Button"):SetChecked(PowaSet[CurrentAura].numtimer == 3);
	getglobal("PowaTimer4Button"):SetChecked(PowaSet[CurrentAura].numtimer == 4);
	getglobal("PowaTimer5Button"):SetChecked(PowaSet[CurrentAura].numtimer == 5);
	getglobal("PowaTimerDurationSlider"):SetValue(PowaSet[CurrentAura].timerduration);
	-- added sliders
	getglobal("PowaBarThresholdSlider"):SetValue(PowaSet[CurrentAura].threshold);
	----------------
	
	
	-- modes combats
	Powa_EnableCheckBox("PowaInCombatButton");
	Powa_EnableCheckBox("PowaNotInCombatButton");
	if (PowaSet[CurrentAura].bufftype == 4 or PowaSet[CurrentAura].bufftype == 6) then
		getglobal("PowaNotInCombatButton"):SetChecked(false);
		getglobal("PowaInCombatButton"):SetChecked(false);
		Powa_DisableCheckBox("PowaInCombatButton");
		Powa_DisableCheckBox("PowaNotInCombatButton");
	elseif (PowaSet[CurrentAura].combat == 1) then 
		getglobal("PowaInCombatButton"):SetChecked(true);
		getglobal("PowaNotInCombatButton"):SetChecked(false);
	elseif (PowaSet[CurrentAura].combat == 2) then
		getglobal("PowaNotInCombatButton"):SetChecked(true);
		getglobal("PowaInCombatButton"):SetChecked(false);
	else
		getglobal("PowaNotInCombatButton"):SetChecked(false);
		getglobal("PowaInCombatButton"):SetChecked(false);		
	end
	
	-- inverse, target and timer
	if ((PowaSet[CurrentAura].inverse) and not (PowaSet[CurrentAura].bufftype == 7)) then
		PowaSet[CurrentAura].timer = false;
		PowaEditorTab3:Hide();
	else
		PowaEditorTab3:Show();
	end
	
	-- Dropdown selection alias buffs type. variable PowaSet[int].bufftype
	if (PowaSet[CurrentAura].bufftype == 1) then -- BUFF
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff;
		getglobal("PowaExactButton").aide = PowaText.aideExact;
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckBuff);
		-- enabled
		getglobal("PowaBarBuffName"):Show();
		getglobal("PowaBarBuffStacks"):Show();
		Powa_EnableCheckBox("PowaTargetButton");
		Powa_EnableCheckBox("PowaTargetFriendButton");
		Powa_EnableCheckBox("PowaPartyButton");
        Powa_EnableCheckBox("PowaFocusButton");
        Powa_EnableCheckBox("PowaRaidButton");
        Powa_EnableCheckBox("PowaOptunitnButton");
		Powa_EnableCheckBox("PowaInverseButton");
		Powa_EnableCheckBox("PowaIgnoreMajButton");
		Powa_EnableCheckBox("PowaExactButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaBarThresholdSlider"):Hide();
		getglobal("PowaDropDownStance"):Hide();
		Powa_DisableCheckBox("PowaTimer2Button");
		Powa_DisableCheckBox("PowaGCDButton");
		-- --------
		if (PowaSet[CurrentAura].target or PowaSet[CurrentAura].targetfriend or PowaSet[CurrentAura].party or PowaSet[CurrentAura].focus or PowaSet[CurrentAura].raid or PowaSet[CurrentAura].optunitn) then
			Powa_DisableCheckBox("PowaTimer1Button");
			getglobal("PowaTimerDurationSlider"):Show();
		else
			Powa_EnableCheckBox("PowaTimer1Button");
			getglobal("PowaTimer1ButtonText"):SetTextColor(0.2,1.0,0.2);
			getglobal("PowaTimerDurationSlider"):Hide();
		end
		
		if (PowaSet[CurrentAura].inverse == false) then 
      		PowaEditorTab3:Show(); 
    	end
		getglobal("PowaTargetButtonText"):SetTextColor(1.0,0.2,0.2);
		getglobal("PowaTargetFriendButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaPartyButtonText"):SetTextColor(0.2,1.0,0.2);
        getglobal("PowaFocusButtonText"):SetTextColor(0.2,1.0,0.2);
        getglobal("PowaRaidButtonText"):SetTextColor(0.2,1.0,0.2);
        getglobal("PowaOptunitnButtonText"):SetTextColor(0.2,1.0,0.2);
		
	elseif (PowaSet[CurrentAura].bufftype == 2) then -- DEBUFF
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff2;
		getglobal("PowaExactButton").aide = PowaText.aideExact2;
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckDebuff);
		-- enabled
		getglobal("PowaBarBuffName"):Show();
		getglobal("PowaBarBuffStacks"):Show();
		Powa_EnableCheckBox("PowaTargetButton");
		Powa_EnableCheckBox("PowaTargetFriendButton");
		Powa_EnableCheckBox("PowaPartyButton");
        Powa_EnableCheckBox("PowaFocusButton");
        Powa_EnableCheckBox("PowaRaidButton");
        Powa_EnableCheckBox("PowaOptunitnButton");
		Powa_EnableCheckBox("PowaInverseButton");
		Powa_EnableCheckBox("PowaIgnoreMajButton");
		Powa_EnableCheckBox("PowaExactButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaBarThresholdSlider"):Hide();
		getglobal("PowaDropDownStance"):Hide();
		Powa_DisableCheckBox("PowaTimer1Button");
		Powa_DisableCheckBox("PowaGCDButton");
		-- --------		
		if (PowaSet[CurrentAura].target or PowaSet[CurrentAura].targetfriend or PowaSet[CurrentAura].party or PowaSet[CurrentAura].focus or PowaSet[CurrentAura].raid or PowaSet[CurrentAura].optunitn) then
			Powa_DisableCheckBox("PowaTimer2Button");
			getglobal("PowaTimerDurationSlider"):Show();
		else
			Powa_EnableCheckBox("PowaTimer2Button");
			getglobal("PowaTimer2ButtonText"):SetTextColor(1.0,0.2,0.2);
			getglobal("PowaTimerDurationSlider"):Hide();
		end		
		if (PowaSet[CurrentAura].inverse == false) then 
		PowaEditorTab3:Show(); end
		getglobal("PowaTargetButtonText"):SetTextColor(1.0,0.2,0.2);
		getglobal("PowaTargetFriendButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaPartyButtonText"):SetTextColor(0.2,1.0,0.2);
        getglobal("PowaFocusButtonText"):SetTextColor(0.2,1.0,0.2);
        getglobal("PowaRaidButtonText"):SetTextColor(0.2,1.0,0.2);
        getglobal("PowaOptunitnButtonText"):SetTextColor(0.2,1.0,0.2);
		
	elseif (PowaSet[CurrentAura].bufftype == 3) then -- DEBUFF-TYPE
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff3;
		getglobal("PowaExactButton").aide = PowaText.aideExact3;
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckDebuffType);
		-- enabled
		getglobal("PowaBarBuffName"):Show();
		Powa_EnableCheckBox("PowaTargetButton");
		Powa_EnableCheckBox("PowaTargetFriendButton");
		Powa_EnableCheckBox("PowaPartyButton");
        Powa_EnableCheckBox("PowaFocusButton");
        Powa_EnableCheckBox("PowaRaidButton");
        Powa_EnableCheckBox("PowaOptunitnButton");
		Powa_EnableCheckBox("PowaInverseButton");
		Powa_EnableCheckBox("PowaIgnoreMajButton");
		Powa_EnableCheckBox("PowaExactButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaBarThresholdSlider"):Hide();
		getglobal("PowaDropDownStance"):Hide();
		getglobal("PowaBarBuffStacks"):Hide();
		Powa_DisableCheckBox("PowaTimer1Button");
		Powa_DisableCheckBox("PowaGCDButton");
		-- --------
		if (PowaSet[CurrentAura].target or PowaSet[CurrentAura].targetfriend or PowaSet[CurrentAura].party or PowaSet[CurrentAura].focus or PowaSet[CurrentAura].raid or PowaSet[CurrentAura].optunitn) then
			Powa_DisableCheckBox("PowaTimer2Button");
			getglobal("PowaTimerDurationSlider"):Show();
		else
			Powa_EnableCheckBox("PowaTimer2Button");
			getglobal("PowaTimer2ButtonText"):SetTextColor(1.0,0.2,0.2);
			getglobal("PowaTimerDurationSlider"):Hide();
		end
		
		
		if (PowaSet[CurrentAura].inverse == false) then PowaEditorTab3:Show(); end
		getglobal("PowaTargetButtonText"):SetTextColor(1.0,0.2,0.2);
		getglobal("PowaTargetFriendButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaPartyButtonText"):SetTextColor(0.2,1.0,0.2);
        getglobal("PowaFocusButtonText"):SetTextColor(0.2,1.0,0.2);
        getglobal("PowaRaidButtonText"):SetTextColor(0.2,1.0,0.2);
        getglobal("PowaOptunitnButtonText"):SetTextColor(0.2,1.0,0.2);
		
	elseif (PowaSet[CurrentAura].bufftype == 4) then -- AOE
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff4;
		getglobal("PowaExactButton").aide = PowaText.aideExact4;
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckAoeDebuff);
		PowaSet[CurrentAura].target = false;
		getglobal("PowaTargetButton"):SetChecked(false);
		getglobal("PowaTargetFriendButton"):SetChecked(false);
		getglobal("PowaPartyButton"):SetChecked(false);
		-- enabled
		getglobal("PowaBarBuffName"):Show();
		Powa_EnableCheckBox("PowaExactButton");
		Powa_EnableCheckBox("PowaIgnoreMajButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaBarThresholdSlider"):Hide();
		getglobal("PowaDropDownStance"):Hide();
		PowaEditorTab3:Hide();
		getglobal("PowaBarBuffStacks"):Hide();
		Powa_DisableCheckBox("PowaTargetButton");
		Powa_DisableCheckBox("PowaTargetFriendButton");
		Powa_DisableCheckBox("PowaPartyButton");
        Powa_DisableCheckBox("PowaFocusButton");
        Powa_DisableCheckBox("PowaRaidButton");
        Powa_DisableCheckBox("PowaOptunitnButton");      
		Powa_DisableCheckBox("PowaInverseButton");
		Powa_DisableCheckBox("PowaGCDButton");
		
		-- -------	
		PowaSet[CurrentAura].timer = false;
		
	elseif (PowaSet[CurrentAura].bufftype == 5) then -- ENCHANT
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff5;
		getglobal("PowaExactButton").aide = PowaText.aideExact5;
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckEnchant);
		PowaSet[CurrentAura].target = false;
		getglobal("PowaTargetButton"):SetChecked(false);
		getglobal("PowaTargetFriendButton"):SetChecked(false);
		getglobal("PowaPartyButton"):SetChecked(false);
		getglobal("PowaTimer1ButtonText"):SetTextColor(0.2,1.0,0.2);
		-- enabled
		getglobal("PowaBarBuffName"):Show();
		getglobal("PowaBarBuffStacks"):Show();
		Powa_EnableCheckBox("PowaIgnoreMajButton");
		Powa_EnableCheckBox("PowaInverseButton");
		Powa_EnableCheckBox("PowaTimer1Button");
		Powa_EnableCheckBox("PowaExactButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaBarThresholdSlider"):Hide();
		getglobal("PowaTimerDurationSlider"):Hide();
		getglobal("PowaDropDownStance"):Hide();
		Powa_DisableCheckBox("PowaTargetButton");
		Powa_DisableCheckBox("PowaTargetFriendButton");
		Powa_DisableCheckBox("PowaPartyButton");
        Powa_DisableCheckBox("PowaFocusButton");
        Powa_DisableCheckBox("PowaRaidButton");
        Powa_DisableCheckBox("PowaOptunitnButton");
		Powa_DisableCheckBox("PowaGCDButton");
		Powa_DisableCheckBox("PowaTimer2Button");
		-- --------
		
			
		if (PowaSet[CurrentAura].inverse == false) then PowaEditorTab3:Show(); end
		
	elseif (PowaSet[CurrentAura].bufftype == 6) then -- COMBOS
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff6;
		getglobal("PowaExactButton").aide = PowaText.aideExact6;		
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckCombo);
		PowaSet[CurrentAura].target = false;
		getglobal("PowaTargetButton"):SetChecked(true);
		getglobal("PowaTargetFriendButton"):SetChecked(false);
		getglobal("PowaPartyButton"):SetChecked(false);
		-- enabled
		getglobal("PowaBarBuffName"):Show();
		Powa_EnableCheckBox("PowaIgnoreMajButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaBarThresholdSlider"):Hide();
		getglobal("PowaDropDownStance"):Hide();
		PowaEditorTab3:Hide();
		getglobal("PowaBarBuffStacks"):Hide();
		Powa_DisableCheckBox("PowaTargetButton");
		Powa_DisableCheckBox("PowaTargetFriendButton");
		Powa_DisableCheckBox("PowaPartyButton");
        Powa_DisableCheckBox("PowaFocusButton");
        Powa_DisableCheckBox("PowaRaidButton");
        Powa_DisableCheckBox("PowaOptunitnButton");
		Powa_DisableCheckBox("PowaInverseButton");
		Powa_DisableCheckBox("PowaGCDButton");
		
		-- --------		
		PowaSet[CurrentAura].timer = false;
		
	elseif (PowaSet[CurrentAura].bufftype == 7) then -- ACTION READY
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff7;
		getglobal("PowaExactButton").aide = PowaText.aideExact7;
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckSkill);
		PowaSet[CurrentAura].target = false;
		getglobal("PowaTargetButton"):SetChecked(false);
		getglobal("PowaTargetFriendButton"):SetChecked(false);
		getglobal("PowaPartyButton"):SetChecked(false);
		-- enabled
		getglobal("PowaBarBuffName"):Show();
		Powa_EnableCheckBox("PowaGCDButton");
		Powa_EnableCheckBox("PowaExactButton");
		Powa_EnableCheckBox("PowaIgnoreMajButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaBarThresholdSlider"):Hide();
		getglobal("PowaDropDownStance"):Hide();
		getglobal("PowaBarBuffStacks"):Hide();
		Powa_DisableCheckBox("PowaTargetButton");
		Powa_DisableCheckBox("PowaTargetFriendButton");
		Powa_DisableCheckBox("PowaPartyButton");
        Powa_DisableCheckBox("PowaFocusButton");
        Powa_DisableCheckBox("PowaRaidButton");		
        Powa_DisableCheckBox("PowaOptunitnButton");
		-- -------							
	
	elseif (PowaSet[CurrentAura].bufftype == 8) then -- HEALTH
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckHealth);		
		getglobal("PowaTargetButtonText"):SetTextColor(1.0,0.2,0.2);
		getglobal("PowaTargetFriendButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaPartyButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaRaidButtonText"):SetTextColor(1.0,0.2,0.2);
		getglobal("PowaOptunitnButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaInverseButtonText"):SetTextColor(0.2,1.0,0.2);
		-- enabled
		getglobal("PowaBarThresholdSlider"):Show();
		Powa_EnableCheckBox("PowaTargetButton");
		Powa_EnableCheckBox("PowaTargetFriendButton");
		Powa_EnableCheckBox("PowaPartyButton");
        Powa_EnableCheckBox("PowaFocusButton");
        Powa_EnableCheckBox("PowaRaidButton");
        Powa_EnableCheckBox("PowaOptunitnButton");
		Powa_EnableCheckBox("PowaInverseButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaDropDownStance"):Hide();
		PowaEditorTab3:Hide();
		Powa_DisableTextfield("PowaBarBuffName");
		getglobal("PowaBarBuffStacks"):Hide();
		Powa_DisableCheckBox("PowaExactButton");
		Powa_DisableCheckBox("PowaIgnoreMajButton");
		Powa_DisableCheckBox("PowaGCDButton");
		-- -------		
		PowaSet[CurrentAura].timer = false;
		
	elseif (PowaSet[CurrentAura].bufftype == 9) then -- Mana		
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckMana);
		getglobal("PowaTargetButtonText"):SetTextColor(1.0,0.2,0.2);
		getglobal("PowaTargetFriendButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaPartyButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaFocusButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaRaidButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaOptunitnButtonText"):SetTextColor(0.2,0.2,1.0);
		getglobal("PowaInverseButtonText"):SetTextColor(0.3,0.3,0.3);
		-- enabled
		getglobal("PowaBarThresholdSlider"):Show();
		Powa_EnableCheckBox("PowaTargetButton");
		Powa_EnableCheckBox("PowaTargetFriendButton");
		Powa_EnableCheckBox("PowaPartyButton");
        Powa_EnableCheckBox("PowaFocusButton");
        Powa_EnableCheckBox("PowaRaidButton");
        Powa_EnableCheckBox("PowaOptunitnButton");
		Powa_EnableCheckBox("PowaInverseButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaDropDownStance"):Hide();
		PowaEditorTab3:Hide();
		Powa_DisableTextfield("PowaBarBuffName");
		getglobal("PowaBarBuffStacks"):Hide();
		Powa_DisableCheckBox("PowaExactButton");
		Powa_DisableCheckBox("PowaIgnoreMajButton");
		Powa_DisableCheckBox("PowaGCDButton");
		-- --------	
		PowaSet[CurrentAura].timer = false;	
	
	elseif (PowaSet[CurrentAura].bufftype == 10) then -- Stance		
		getglobal("PowaDropDownBuffTypeText"):SetText(PowaText.nomCheckStance);
		getglobal("PowaTargetButtonText"):SetTextColor(1.0,0.2,0.2);
		getglobal("PowaTargetFriendButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaPartyButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaFocusButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaRaidButtonText"):SetTextColor(0.2,1.0,0.2);
		getglobal("PowaOptunitnButtonText"):SetTextColor(0.2,0.2,1.0);
		getglobal("PowaInverseButtonText"):SetTextColor(0.3,0.3,0.3);
		-- enabled
		getglobal("PowaDropDownStance"):Show();
		Powa_EnableCheckBox("PowaInverseButton");
		Powa_EnableCheckBox("PowaIsInRaidButton");
		Powa_EnableCheckBox("PowaIsMountedButton");
		-- disabled
		getglobal("PowaBarThresholdSlider"):Hide();
		PowaEditorTab3:Hide();
		Powa_DisableTextfield("PowaBarBuffName");
		getglobal("PowaBarBuffStacks"):Hide();
		Powa_DisableCheckBox("PowaTargetButton");
		PowaSet[CurrentAura].target = false;
		Powa_DisableCheckBox("PowaTargetFriendButton");
		PowaSet[CurrentAura].targetfriend = false;
		Powa_DisableCheckBox("PowaPartyButton");
		PowaSet[CurrentAura].party = false;
        Powa_DisableCheckBox("PowaFocusButton");
		PowaSet[CurrentAura].focus = false;
        Powa_DisableCheckBox("PowaRaidButton");
		PowaSet[CurrentAura].raid = false;
        Powa_DisableCheckBox("PowaOptunitnButton");
		PowaSet[CurrentAura].optunitn = false;
		Powa_DisableCheckBox("PowaExactButton");
		PowaSet[CurrentAura].exact = false;
		Powa_DisableCheckBox("PowaIgnoreMajButton");
		PowaSet[CurrentAura].ignoremaj = false;
		Powa_DisableCheckBox("PowaGCDButton");
		PowaSet[CurrentAura].gcd = false;
		-- --------		
		PowaSet[CurrentAura].timer = false;	
	end
	
	-- changement de page
	if (getglobal("PowaBarConfigFrameEditor4"):IsVisible() and not PowaEditorTab3:IsVisible() ) then
		PanelTemplates_SelectTab(PowaEditorTab2);
		PanelTemplates_DeselectTab(PowaEditorTab1);
		PanelTemplates_DeselectTab(PowaEditorTab3);
		getglobal("PowaBarConfigFrameEditor2"):Show();
		getglobal("PowaBarConfigFrameEditor3"):Hide();
		getglobal("PowaBarConfigFrameEditor4"):Hide();
	end
	-- Visuels auras
	getglobal("PowaBarAuraAlphaSlider"):SetValue(PowaSet[CurrentAura].alpha);
	getglobal("PowaBarAuraSizeSlider"):SetValue(PowaSet[CurrentAura].size);
	-- ajuste slider Y
	getglobal("PowaBarAuraCoordSlider"):SetMinMaxValues(PowaSet[CurrentAura].y-5000,PowaSet[CurrentAura].y+5000);
	getglobal("PowaBarAuraCoordSliderLow"):SetText(PowaSet[CurrentAura].y-200);
	getglobal("PowaBarAuraCoordSliderHigh"):SetText(PowaSet[CurrentAura].y+200);
	getglobal("PowaBarAuraCoordSlider"):SetValue(PowaSet[CurrentAura].y);
	getglobal("PowaBarAuraCoordSlider"):SetMinMaxValues(PowaSet[CurrentAura].y-200,PowaSet[CurrentAura].y+200);
	getglobal("PowaBarAuraCoordYEdit"):SetText(PowaSet[CurrentAura].y);
	-- ajuste slider X
	getglobal("PowaBarAuraCoordXSlider"):SetMinMaxValues(PowaSet[CurrentAura].x-5000,PowaSet[CurrentAura].x+5000);
	getglobal("PowaBarAuraCoordXSliderLow"):SetText(PowaSet[CurrentAura].x-200);
	getglobal("PowaBarAuraCoordXSliderHigh"):SetText(PowaSet[CurrentAura].x+200);
	getglobal("PowaBarAuraCoordXSlider"):SetValue(PowaSet[CurrentAura].x);
	getglobal("PowaBarAuraCoordXSlider"):SetMinMaxValues(PowaSet[CurrentAura].x-200,PowaSet[CurrentAura].x+200);
	getglobal("PowaBarAuraCoordXEdit"):SetText(PowaSet[CurrentAura].x);

	getglobal("PowaBarAuraAnimSpeedSlider"):SetValue(PowaSet[CurrentAura].speed);
	getglobal("PowaBarAuraDurationSlider"):SetValue(PowaSet[CurrentAura].duration);
	getglobal("PowaBarAuraSymSlider"):SetValue(PowaSet[CurrentAura].symetrie);
	getglobal("PowaBarAuraDeformSlider"):SetValue(PowaSet[CurrentAura].torsion);
	getglobal("PowaBarBuffName"):SetText(PowaSet[CurrentAura].buffname);
	getglobal("PowaBarCustomSound"):SetText(PowaSet[CurrentAura].customsound);
    getglobal("PowaBarUnitn"):SetText(PowaSet[CurrentAura].unitn);
	
	local numbertotext = tostring(PowaSet[CurrentAura].stacks);
	local stackstext = PowaSet[CurrentAura].stacksOperator..numbertotext;
	getglobal("PowaBarBuffStacks"):SetText(stackstext);
	
	if (PowaSet[CurrentAura].icon == "") then
		getglobal("PowaIconTexture"):SetTexture("Interface\\Icons\\Inv_Misc_QuestionMark");
	else
		getglobal("PowaIconTexture"):SetTexture(PowaSet[CurrentAura].icon);
	end
    
    if (PowaSet[CurrentAura].optunitn == true) then
        Powa_EnableTextfield("PowaBarUnitn");
    elseif (PowaSet[CurrentAura].optunitn == false) then
        Powa_DisableTextfield("PowaBarUnitn");
    end

	if (PowaSet[CurrentAura].wowtex == true) then
		getglobal("PowaBarAuraTextureSlider"):Show();
		getglobal("PowaBarCustomTexName"):Hide();
		if (PowaWowMaxTextures > PowaGlobal.maxtextures) then
			getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,PowaWowMaxTextures);
			getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaWowMaxTextures);
			getglobal("PowaBarAuraTextureSlider"):SetValue(PowaSet[CurrentAura].texture);
		else
			getglobal("PowaBarAuraTextureSlider"):SetValue(PowaSet[CurrentAura].texture);
			getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,PowaWowMaxTextures);
			getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaWowMaxTextures);
		end
		CheckTexture = getglobal("AuraTexture"):SetTexture(PowaWowTextures[PowaSet[CurrentAura].texture]);

	elseif (PowaSet[CurrentAura].customtex == true) then
		getglobal("PowaBarAuraTextureSlider"):Hide();
		getglobal("PowaBarCustomTexName"):Show();
		getglobal("PowaBarCustomTexName"):SetText(PowaSet[CurrentAura].customname);
		CheckTexture = getglobal("AuraTexture"):SetTexture("Interface\\Addons\\PowerAuras\\Custom\\"..PowaSet[CurrentAura].customname);
	else
		getglobal("PowaBarAuraTextureSlider"):Show();
		getglobal("PowaBarCustomTexName"):Hide();
		if (PowaWowMaxTextures < PowaGlobal.maxtextures) then
			getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,PowaGlobal.maxtextures);
			getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaGlobal.maxtextures);
			getglobal("PowaBarAuraTextureSlider"):SetValue(PowaSet[CurrentAura].texture);
		else
			getglobal("PowaBarAuraTextureSlider"):SetValue(PowaSet[CurrentAura].texture);
			getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,PowaGlobal.maxtextures);
			getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaGlobal.maxtextures);
		end
		CheckTexture = getglobal("AuraTexture"):SetTexture("Interface\\Addons\\PowerAuras\\Aura"..PowaSet[CurrentAura].texture..".tga");
	end
	if (CheckTexture ~= 1) then
		getglobal("AuraTexture"):SetTexture("Interface\\CharacterFrame\\TempPortrait.tga");
	end

	getglobal("PowaColorNormalTexture"):SetVertexColor(PowaSet[CurrentAura].r,PowaSet[CurrentAura].g,PowaSet[CurrentAura].b);
	getglobal("AuraTexture"):SetVertexColor(PowaSet[CurrentAura].r,PowaSet[CurrentAura].g,PowaSet[CurrentAura].b);

	-- affiche la symetrie
	    if (PowaSet[CurrentAura].symetrie == 1) then getglobal("AuraTexture"):SetTexCoord(1, 0, 0, 1); -- inverse X
	elseif (PowaSet[CurrentAura].symetrie == 2) then getglobal("AuraTexture"):SetTexCoord(0, 1, 1, 0); -- inverse Y
	elseif (PowaSet[CurrentAura].symetrie == 3) then getglobal("AuraTexture"):SetTexCoord(1, 0, 1, 0); -- inverse XY
	else getglobal("AuraTexture"):SetTexCoord(0, 1, 0, 1); end

	getglobal("PowaColor_SwatchBg").r = PowaSet[CurrentAura].r;
	getglobal("PowaColor_SwatchBg").g = PowaSet[CurrentAura].g;
	getglobal("PowaColor_SwatchBg").b = PowaSet[CurrentAura].b;

	getglobal("PowaHeader"):SetText(PowaText.nomEffectEditor);
end
-----------------------------------------------------------------------------------------------------------------------
-- Sliders Changed
-----------------------------------------------------------------------------------------------------------------------
	
function PowaBarAuraTextureSliderChanged()
	local SliderValue = getglobal("PowaBarAuraTextureSlider"):GetValue();
	local CheckTexture = 0;

	if (PowaSet[CurrentAura].wowtex == true) then
		CheckTexture = getglobal("AuraTexture"):SetTexture(PowaWowTextures[SliderValue]);

	elseif (PowaSet[CurrentAura].customtex == true) then
		CheckTexture = getglobal("AuraTexture"):SetTexture("Interface\\Addons\\PowerAuras\\Custom\\"..PowaSet[CurrentAura].customname);
	else
		CheckTexture = getglobal("AuraTexture"):SetTexture("Interface\\Addons\\PowerAuras\\Aura"..SliderValue..".tga");
	end
	if (CheckTexture ~= 1) then
		getglobal("AuraTexture"):SetTexture("Interface\\CharacterFrame\\TempPortrait.tga");
	end

	getglobal("PowaBarAuraTextureSliderText"):SetText(PowaText.nomTexture.." : "..SliderValue);
	getglobal("AuraTexture"):SetVertexColor(PowaSet[CurrentAura].r,PowaSet[CurrentAura].g,PowaSet[CurrentAura].b);

	PowaSet[CurrentAura].texture = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAlphaSliderChanged()
	local SliderValue = getglobal("PowaBarAuraAlphaSlider"):GetValue();

	getglobal("PowaBarAuraAlphaSliderText"):SetText(PowaText.nomAlpha.." : "..format("%.0f",SliderValue*100).."%");

	PowaSet[CurrentAura].alpha = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraSizeSliderChanged()
	local SliderValue = getglobal("PowaBarAuraSizeSlider"):GetValue();

	getglobal("PowaBarAuraSizeSliderText"):SetText(PowaText.nomTaille.." : "..format("%.0f",SliderValue*100).."%");

	PowaSet[CurrentAura].size = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraCoordSliderChanged()
	local SliderValue = getglobal("PowaBarAuraCoordSlider"):GetValue();

	getglobal("PowaBarAuraCoordSliderText"):SetText(PowaText.nomPos.." Y : "..SliderValue);
	if (getglobal("PowaBarAuraCoordYEdit")) then
		getglobal("PowaBarAuraCoordYEdit"):SetText(SliderValue);
	end

	PowaSet[CurrentAura].y = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraCoordXSliderChanged()
	local SliderValue = getglobal("PowaBarAuraCoordXSlider"):GetValue();

	getglobal("PowaBarAuraCoordXSliderText"):SetText(PowaText.nomPos.." X : "..SliderValue);
	if (getglobal("PowaBarAuraCoordXEdit")) then
		getglobal("PowaBarAuraCoordXEdit"):SetText(SliderValue);
	end

	PowaSet[CurrentAura].x = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAnimSpeedSliderChanged()
	local SliderValue = getglobal("PowaBarAuraAnimSpeedSlider"):GetValue();

	getglobal("PowaBarAuraAnimSpeedSliderText"):SetText(PowaText.nomSpeed.." : "..format("%.0f",SliderValue*100).."%");

	PowaSet[CurrentAura].speed = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAnimDurationSliderChanged()
	local SliderValue = getglobal("PowaBarAuraDurationSlider"):GetValue();

	getglobal("PowaBarAuraDurationSliderText"):SetText(PowaText.nomDuration.." : "..SliderValue.." sec");

	PowaSet[CurrentAura].duration = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraSymSliderChanged()
	local SliderValue = getglobal("PowaBarAuraSymSlider"):GetValue();

	if (SliderValue == 0) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : "..PowaText.aucune);
		getglobal("AuraTexture"):SetTexCoord(0, 1, 0, 1);
	elseif (SliderValue == 1) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : X");
		getglobal("AuraTexture"):SetTexCoord(1, 0, 0, 1);
	elseif (SliderValue == 2) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : Y");
		getglobal("AuraTexture"):SetTexCoord(0, 1, 1, 0);
	elseif (SliderValue == 3) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : XY");
		getglobal("AuraTexture"):SetTexCoord(1, 0, 1, 0);
	end

	PowaSet[CurrentAura].symetrie = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraDeformSliderChanged()
	local SliderValue = getglobal("PowaBarAuraDeformSlider"):GetValue();

	getglobal("PowaBarAuraDeformSliderText"):SetText(PowaText.nomDeform.." : "..format("%.2f", SliderValue));

	PowaSet[CurrentAura].torsion = SliderValue;
	Powa_UpdateAura();
end

function PowaBarThresholdSliderChanged()
	local SliderValue = getglobal("PowaBarThresholdSlider"):GetValue();

	getglobal("PowaBarThresholdSliderText"):SetText(PowaText.nomThreshold.." : "..SliderValue.."%");

	PowaSet[CurrentAura].threshold = SliderValue;
end

------------------------------------------------------------------
-- Text Changed
------------------------------------------------------------------

function PowaTextCoordXChanged()
	local thisText = getglobal("PowaBarAuraCoordXEdit"):GetText();
	local thisNumber = tonumber(thisText);

	if (thisNumber == nil) then
		getglobal("PowaBarAuraCoordXSliderText"):SetText(PowaText.nomPos.." X : "..0);
		getglobal("PowaBarAuraCoordXSlider"):SetValue(0);
		getglobal("PowaBarAuraCoordXEdit"):SetText(0);
		PowaSet[CurrentAura].x = 0;	
	else
		if (thisNumber > 300 or thisNumber < -300) then
			getglobal("PowaBarAuraCoordXEdit"):SetText(thisNumber);
			Powa_DisableSlider("PowaBarAuraCoordXSlider");
		else
			Powa_EnableSlider("PowaBarAuraCoordXSlider");
			getglobal("PowaBarAuraCoordXSliderText"):SetText(PowaText.nomPos.." X : "..thisNumber);
			getglobal("PowaBarAuraCoordXSlider"):SetValue(thisNumber);
		end
		PowaSet[CurrentAura].x = thisNumber;
	end
	Powa_UpdateAura();
end

function PowaTextCoordYChanged()
	local thisText = getglobal("PowaBarAuraCoordYEdit"):GetText();
	local thisNumber = tonumber(thisText);

	if (thisNumber == nil) then
		getglobal("PowaBarAuraCoordSliderText"):SetText(PowaText.nomPos.." Y : "..0);
		getglobal("PowaBarAuraCoordSlider"):SetValue(0);
		getglobal("PowaBarAuraCoordYEdit"):SetText(0);
		PowaSet[CurrentAura].y = 0;	
	else
		if (thisNumber > 300 or thisNumber < -300) then
			getglobal("PowaBarAuraCoordYEdit"):SetText(thisNumber);
			Powa_DisableSlider("PowaBarAuraCoordSlider");
		else
			Powa_EnableSlider("PowaBarAuraCoordSlider");
			getglobal("PowaBarAuraCoordSliderText"):SetText(PowaText.nomPos.." Y : "..thisNumber);
			getglobal("PowaBarAuraCoordSlider"):SetValue(thisNumber);
		end
		PowaSet[CurrentAura].y = thisNumber;
	end
	Powa_UpdateAura();
end

function PowaTextChanged()
	local oldText = getglobal("PowaBarBuffName"):GetText();

	if (oldText == PowaSet[CurrentAura].buffname) then -- meme texte
	else
		PowaSet[CurrentAura].buffname = getglobal("PowaBarBuffName"):GetText();
		PowaSet[CurrentAura].icon = "";
		getglobal("PowaIconTexture"):SetTexture("Interface\\Icons\\Inv_Misc_QuestionMark");
	end
end

function PowaStacksTextChanged()
	local oldText = getglobal("PowaBarBuffStacks"):GetText();
	
	oldStacks = string.sub(oldText, 2)
	oldOperator = string.sub(oldText, 1, 1)
	if oldStacks == "" then oldStacks = "0"; end
    local Stacks = tonumber(oldStacks);
	PowaDebug(Stacks);
	
		
	if (Stacks == PowaSet[CurrentAura].stacks) then -- meme texte
	else
		if (Stacks > 100) or (Stacks < 0) then Stacks = 0; end
		PowaSet[CurrentAura].stacks = Stacks;
		PowaSet[CurrentAura].icon = "";
		getglobal("PowaIconTexture"):SetTexture("Interface\\Icons\\Inv_Misc_QuestionMark");
	end
	
	if (oldOperator == PowaSet[CurrentAura].stacksOperator) then--same operator as it was before
	else -- not the same operator as it was before ^.^
		if oldOperator ~= ">" and oldOperator ~= "<" and oldOperator ~= "=" and oldOperator ~= "!" then
			oldOperator = "=";
		end	
		PowaSet[CurrentAura].stacksOperator = oldOperator;
	end	
end

function PowaUnitnTextChanged()
	local oldUnitnText = getglobal("PowaBarUnitn"):GetText();

	if (oldUnitnText == PowaSet[CurrentAura].unitn) then -- same text
	else
		PowaSet[CurrentAura].unitn = getglobal("PowaBarUnitn"):GetText();
	end
end

function PowaCustomTextChanged()
	PowaSet[CurrentAura].customname = getglobal("PowaBarCustomTexName"):GetText();
	PowaBarAuraTextureSliderChanged();
end

function PowaCustomSoundTextChanged()
	local oldCustomSound = getglobal("PowaBarCustomSound"):GetText();

	if (oldCustomSound == PowaSet[CurrentAura].customsound) then -- meme texte
	else
		PowaSet[CurrentAura].customsound = getglobal("PowaBarCustomSound"):GetText();
		if not (PowaSet[CurrentAura].customsound == "") then
			PlaySoundFile("Interface\\AddOns\\PowerAuras\\Sounds\\"..PowaSet[CurrentAura].customsound);
		end
	end	
end

---------------------------------
-- Checkboxes changed
---------------------------------

function PowaInverseChecked()
	if (getglobal("PowaInverseButton"):GetChecked()) then
		PowaSet[CurrentAura].inverse = true;
	else
		PowaSet[CurrentAura].inverse = false;
	end
end

function PowaIgnoreMajChecked()
	if (getglobal("PowaIgnoreMajButton"):GetChecked()) then
		PowaSet[CurrentAura].ignoremaj = true;
	else
		PowaSet[CurrentAura].ignoremaj = false;
	end
end

function PowaExactChecked()
	if (getglobal("PowaExactButton"):GetChecked()) then
		PowaSet[CurrentAura].exact = true;
	else
		PowaSet[CurrentAura].exact = false;
	end
end

function PowaGCDChecked()
	if (getglobal("PowaGCDButton"):GetChecked()) then
		PowaSet[CurrentAura].gcd = true;
	else
		PowaSet[CurrentAura].gcd = false;
	end
end

function PowaCombatChecked(xnum)
	if (xnum == 1) then -- case InCombat cochee
		if (getglobal("PowaInCombatButton"):GetChecked()) then
			PowaSet[CurrentAura].combat = 1;
			getglobal("PowaNotInCombatButton"):SetChecked(false);
		else
			PowaSet[CurrentAura].combat = 0;
		end
	elseif (xnum == 2) then -- case NotInCombat cochee
		if (getglobal("PowaInCombatButton"):GetChecked()) then
			PowaSet[CurrentAura].combat = 2;
			getglobal("PowaInCombatButton"):SetChecked(false);
		else
			PowaSet[CurrentAura].combat = 1;
		end
	end
end

function PowaIsInRaidChecked()
	if (getglobal("PowaIsInRaidButton"):GetChecked()) then
		PowaSet[CurrentAura].isinraid = true;
	else
		PowaSet[CurrentAura].isinraid = false;
	end
end

function PowaIsMountedChecked()
	if (getglobal("PowaIsMountedButton"):GetChecked()) then
		PowaSet[CurrentAura].ismounted = true;
	else
		PowaSet[CurrentAura].ismounted = false;
	end
end

function PowaRandomColorChecked()
	if (getglobal("PowaRandomColorButton"):GetChecked()) then
		PowaSet[CurrentAura].randomcolor = true;
	else
		PowaSet[CurrentAura].randomcolor = false;
	end
end

function PowaTexModeChecked()
	if (getglobal("PowaTexModeButton"):GetChecked()) then
		PowaSet[CurrentAura].texmode = 1;
	else
		PowaSet[CurrentAura].texmode = 2;
	end
	Powa_UpdateAura();
end

-----------------------------------
-- Realaura

-- function PowaRealauraChecked()
--	if (getglobal("PowaRealauraButton"):GetChecked()) then
--		PowaSet[CurrentAura].realaura = true;
--        Powa_DisableSlider("PowaBarAuraDeformSlider");
--	else
--		PowaSet[CurrentAura].realaura = false;
--        Powa_EnableSlider("PowaBarAuraDeformSlider");
--	end
--    Powa_UpdateAura();
-- end

------------------------------------

function PowaWowTexturesChecked()
	if (getglobal("PowaWowTextureButton"):GetChecked()) then
		PowaSet[CurrentAura].wowtex = true;
		getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,PowaWowMaxTextures);
		getglobal("PowaBarAuraTextureSlider"):SetValue(1);
		getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaWowMaxTextures);
		PowaSet[CurrentAura].customtex = false;
		getglobal("PowaCustomTextureButton"):SetChecked(false);
		getglobal("PowaBarAuraTextureSlider"):Show();
		getglobal("PowaBarCustomTexName"):Hide();
	else
		PowaSet[CurrentAura].wowtex = false;
		getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,PowaGlobal.maxtextures);
		getglobal("PowaBarAuraTextureSlider"):SetValue(1);
		getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaGlobal.maxtextures);
	end
	PowaBarAuraTextureSliderChanged();
end

function PowaCustomTexturesChecked()
	if (getglobal("PowaCustomTextureButton"):GetChecked()) then
		PowaSet[CurrentAura].customtex = true;
		getglobal("PowaBarAuraTextureSlider"):Hide();
		getglobal("PowaBarCustomTexName"):Show();
		getglobal("PowaBarCustomTexName"):SetText(PowaSet[CurrentAura].customname);
		PowaSet[CurrentAura].wowtex = false;
		getglobal("PowaWowTextureButton"):SetChecked(false);
		getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,PowaGlobal.maxtextures);
		getglobal("PowaBarAuraTextureSlider"):SetValue(1);
		getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaGlobal.maxtextures);
	else
		PowaSet[CurrentAura].customtex = false;
		getglobal("PowaBarAuraTextureSlider"):Show();
		getglobal("PowaBarCustomTexName"):Hide();
	end
	PowaBarAuraTextureSliderChanged();
end

-----------------------------------------------
-- Targets, Party, Raid, ... Checkboxes
-----------------------------------------------

function PowaTargetChecked()
	if (getglobal("PowaTargetButton"):GetChecked()) then
		PowaSet[CurrentAura].target = true;
	else
		PowaSet[CurrentAura].target = false;
	end
	Powa_InitPage();
end

function PowaTargetFriendChecked()
	if (getglobal("PowaTargetFriendButton"):GetChecked()) then
		PowaSet[CurrentAura].targetfriend = true;
	else
		PowaSet[CurrentAura].targetfriend = false;
	end
	Powa_InitPage();
end

function PowaPartyChecked()
	if (getglobal("PowaPartyButton"):GetChecked()) then
		PowaSet[CurrentAura].party = true;
	else
		PowaSet[CurrentAura].party = false;
	end
	Powa_InitPage();
end

function PowaFocusChecked()
	if (getglobal("PowaFocusButton"):GetChecked()) then
		PowaSet[CurrentAura].focus = true;
	else
		PowaSet[CurrentAura].focus = false;
	end
	Powa_InitPage();
end

function PowaRaidChecked()
	if (getglobal("PowaRaidButton"):GetChecked()) then
		PowaSet[CurrentAura].raid = true;
	else
		PowaSet[CurrentAura].raid = false;
	end
	Powa_InitPage();
end

function PowaOptunitnChecked()
	if (getglobal("PowaOptunitnButton"):GetChecked()) then
		PowaSet[CurrentAura].optunitn = true;		
		getglobal("PowaBarUnitn"):Show();
		getglobal("PowaBarUnitn"):SetText(PowaSet[CurrentAura].unitn);
	else
		PowaSet[CurrentAura].optunitn = false;
		getglobal("PowaBarUnitn"):Hide();
	end
end

------------------------------------------
-- Dropdownmenus
------------------------------------------

function PowaDropDownMenu_Initialize() 
	local info;
	local _, englishClass = UnitClass("player");

	if (this:GetName() == "PowaDropDownAnim1Button" or this:GetName() == "PowaDropDownAnim1") then
		for i = 1, 10 do
			info = {}; 
			info.text = PowaAnim[i]; 
			info.func = PowaDropDownMenu_OnClickAnim1;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownAnim1, PowaAnim[PowaSet[CurrentAura].anim1]);
	elseif (this:GetName() == "PowaDropDownAnim2Button" or this:GetName() == "PowaDropDownAnim2") then
		for i = 0, 10 do
			info = {}; 
			info.text = PowaAnim[i]; 
			info.func = PowaDropDownMenu_OnClickAnim2;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownAnim2, PowaAnim[PowaSet[CurrentAura].anim2]);
	elseif (this:GetName() == "PowaDropDownStanceButton" or this:GetName() == "PowaDropDownStance") then
		if (englishClass == "WARRIOR") then
			for i = 1, 3 do
				info = {};
				info.text = PowaStance[i]; 
				info.func = PowaDropDownMenu_OnClickStance;
				UIDropDownMenu_AddButton(info);
			end				
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownStance, PowaStance[PowaSet[CurrentAura].stance]);
		UIDropDownMenu_SetWidth(220, PowaDropDownStance);
	elseif (this:GetName() == "PowaDropDownSoundButton" or this:GetName() == "PowaDropDownSound") then
		for i = 0, 15 do
			info = {}; 
			info.text = PowaSound[i]; 
			info.func = PowaDropDownMenu_OnClickSound;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownSound, PowaSound[PowaSet[CurrentAura].sound]);	
		UIDropDownMenu_SetWidth(220, PowaDropDownSound);
	elseif (this:GetName() == "PowaDropDownAnimBeginButton" or this:GetName() == "PowaDropDownAnimBegin") then
		for i = 0, 11 do
			info = {}; 
			info.text = PowaDisplay[i]; 
			info.func = PowaDropDownMenu_OnClickBegin;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownAnimBegin, PowaDisplay[PowaSet[CurrentAura].begin]);
	elseif (this:GetName() == "PowaDropDownAnimEndButton" or this:GetName() == "PowaDropDownAnimEnd") then
		for i = 0, 3 do
			info = {}; 
			info.text = PowaDisplay[i]; 
			info.func = PowaDropDownMenu_OnClickEnd;
			UIDropDownMenu_AddButton(info);
		end
		UIDropDownMenu_SetSelectedValue(PowaDropDownAnimEnd, PowaDisplay[PowaSet[CurrentAura].finish]);
	elseif (this:GetName() == "PowaDropDownBuffTypeButton" or this:GetName() == "PowaDropDownBuffType") then
		info = {};
		info.text = PowaText.nomCheckBuff; 
		info.func = PowaDropDownMenu_OnClickBuffType;
		UIDropDownMenu_AddButton(info);
		info.text = PowaText.nomCheckDebuff; 
		info.func = PowaDropDownMenu_OnClickBuffType;
		UIDropDownMenu_AddButton(info);
		info.text = PowaText.nomCheckDebuffType; 
		info.func = PowaDropDownMenu_OnClickBuffType;
		UIDropDownMenu_AddButton(info);
		info.text = PowaText.nomCheckAoeDebuff; 
		info.func = PowaDropDownMenu_OnClickBuffType;
		UIDropDownMenu_AddButton(info);
		info.text = PowaText.nomCheckEnchant; 
		info.func = PowaDropDownMenu_OnClickBuffType;
		UIDropDownMenu_AddButton(info);
		info.text = PowaText.nomCheckCombo; 
		info.func = PowaDropDownMenu_OnClickBuffType;
		UIDropDownMenu_AddButton(info);
		info.text = PowaText.nomCheckSkill; 
		info.func = PowaDropDownMenu_OnClickBuffType;
		UIDropDownMenu_AddButton(info);
		info.text = PowaText.nomCheckHealth; 
		info.func = PowaDropDownMenu_OnClickBuffType;
		UIDropDownMenu_AddButton(info);
		info.text = PowaText.nomCheckMana; 
		info.func = PowaDropDownMenu_OnClickBuffType;
		UIDropDownMenu_AddButton(info);
		if (englishClass == "WARRIOR") then 
			info.text = PowaText.nomCheckStance; 
			info.func = PowaDropDownMenu_OnClickBuffType;
			UIDropDownMenu_AddButton(info);
		end
		-- le nom
		local optionName =  UIDropDownMenu_GetText(PowaDropDownBuffType);
		UIDropDownMenu_SetSelectedValue(PowaDropDownBuffType, optionName);
	end
end

function PowaDropDownMenu_OnClickBuffType()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownBuffType, optionID);
	local optionName =  UIDropDownMenu_GetText(PowaDropDownBuffType);
	UIDropDownMenu_SetSelectedValue(PowaDropDownBuffType, optionName);

	PowaSet[CurrentAura].bufftype = optionID;

	if (PowaSet[CurrentAura].bufftype == 4 or PowaSet[CurrentAura].bufftype == 6) then
		PowaSet[CurrentAura].combat = 0;
	end

	Powa_InitPage();
end

function PowaDropDownMenu_OnClickAnim1()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownAnim1, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownAnim1); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownAnim1, optionName);

	PowaSet[CurrentAura].anim1 = optionID;
	Powa_UpdateAura();
end

function PowaDropDownMenu_OnClickAnim2()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownAnim2, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownAnim2); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownAnim2, optionName);

	PowaSet[CurrentAura].anim2 = optionID -1;
	Powa_UpdateAura();
end

function PowaDropDownMenu_OnClickSound()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownSound, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownSound); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownSound, optionName);

	PowaSet[CurrentAura].sound = optionID -1;
	if (PowaSet[CurrentAura].sound == 1) then
		PowaSet[CurrentAura].soundfile = "LEVELUP";
	elseif (PowaSet[CurrentAura].sound == 2) then
		PowaSet[CurrentAura].soundfile = "LOOTWINDOWCOINSOUND";
	elseif (PowaSet[CurrentAura].sound == 3) then
		PowaSet[CurrentAura].soundfile = "MapPing";
	elseif (PowaSet[CurrentAura].sound == 4) then
		PowaSet[CurrentAura].soundfile = "UndeadExploration";
	elseif (PowaSet[CurrentAura].sound == 5) then
		PowaSet[CurrentAura].soundfile = "QUESTADDED";
	elseif (PowaSet[CurrentAura].sound == 6) then
		PowaSet[CurrentAura].soundfile = "QUESTCOMPLETED";
	elseif (PowaSet[CurrentAura].sound == 7) then
		PowaSet[CurrentAura].soundfile = "WriteQuest";
	elseif (PowaSet[CurrentAura].sound == 8) then
		PowaSet[CurrentAura].soundfile = "Fishing Reel in";
	elseif (PowaSet[CurrentAura].sound == 9) then
		PowaSet[CurrentAura].soundfile = "igPVPUpdate";
	elseif (PowaSet[CurrentAura].sound == 10) then
		PowaSet[CurrentAura].soundfile = "ReadyCheck";
	elseif (PowaSet[CurrentAura].sound == 11) then
		PowaSet[CurrentAura].soundfile = "RaidWarning";
	elseif (PowaSet[CurrentAura].sound == 12) then
		PowaSet[CurrentAura].soundfile = "AuctionWindowOpen";
	elseif (PowaSet[CurrentAura].sound == 13) then
		PowaSet[CurrentAura].soundfile = "AuctionWindowClose";
	elseif (PowaSet[CurrentAura].sound == 14) then
		PowaSet[CurrentAura].soundfile = "TellMessage";
	elseif (PowaSet[CurrentAura].sound == 15) then
		PowaSet[CurrentAura].soundfile = "igBackPackOpen";
	elseif (PowaSet[CurrentAura].sound == 0) then
		PowaSet[CurrentAura].soundfile = "";	
	end	
	if not(PowaSet[CurrentAura].soundfile == "") or not (PowaSet[CurrentAura].soundfile == nil)then
		PlaySound(PowaSet[CurrentAura].soundfile);
	end	
end

function PowaDropDownMenu_OnClickStance()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownStance, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownStance); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownStance, optionName);

	PowaSet[CurrentAura].stance = optionID;
	Powa_InitPage();
end

function PowaDropDownMenu_OnClickBegin()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownAnimBegin, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownAnimBegin); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownAnimBegin, optionName);

	PowaSet[CurrentAura].begin = optionID - 1;
	Powa_UpdateAura();
end

function PowaDropDownMenu_OnClickEnd()
	local optionID = this:GetID();

	UIDropDownMenu_SetSelectedID(PowaDropDownAnimEnd, optionID); 
	local optionName =  UIDropDownMenu_GetText(PowaDropDownAnimEnd); 
	UIDropDownMenu_SetSelectedValue(PowaDropDownAnimEnd, optionName);

	PowaSet[CurrentAura].finish = optionID - 1;
	Powa_UpdateAura();
end

----------------------------------------------------------
-- OPTIONS DEPLACEMENT

function PowaBar_MouseDown( strButton, frmFrame)
	if( strButton == "LeftButton") then
		getglobal( frmFrame ):StartMoving( );
	end
end

function PowaBar_MouseUp( strButton, frmFrame)
	getglobal( frmFrame ):StopMovingOrSizing( );
end

----------------------------------------------------------
-- COLOR PICKER

function PowaOptionsFrame_SetColor()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	swatch = getglobal("PowaColorNormalTexture"); -- juste le visuel
	frame = getglobal("PowaColor_SwatchBg");      -- enregistre la couleur
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;

	PowaSet[CurrentAura].r = r;
	PowaSet[CurrentAura].g = g;
	PowaSet[CurrentAura].b = b;

	getglobal("AuraTexture"):SetVertexColor(r,g,b);
	Powa_UpdateAura();
end

function PowaOptionsFrame_CancelColor()
	local r = ColorPickerFrame.previousValues.r;
	local g = ColorPickerFrame.previousValues.g;
	local b = ColorPickerFrame.previousValues.b;
	local swatch,frame;
	swatch = getglobal("PowaColorNormalTexture"); -- juste le visuel
	frame = getglobal("PowaColor_SwatchBg");      -- enregistre la couleur
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;

	getglobal("AuraTexture"):SetVertexColor(r,g,b);
end

function Powa_OpenColorPicker()
	CloseMenus();
	
	button = getglobal("PowaColor_SwatchBg");

	ColorPickerFrame.func = PowaOptionsFrame_SetColor -- button.swatchFunc;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = PowaOptionsFrame_CancelColor

	ColorPickerFrame:SetPoint("TOPRIGHT", "PowaBarConfigFrameTexture", "BOTTOMRIGHT", 0, 0)

	ColorPickerFrame:Show();
end
----------------------------------------------------------------------
function Powa_EditorShow()
	if (PowaBarConfigFrame:IsVisible()) then
		Powa_EditorClose();
	elseif (PowaSet[CurrentAura]) then -- ouvre seulement si l'effet existe
		Powa_InitPage();
		getglobal("PowaBarConfigFrame"):Show();
		getglobal("PowaBarConfigFrameTexture"):Show();
		PlaySound("TalentScreenOpen");
	end
end

function Powa_EditorClose() -- ferme la fenetre d'option
	if (PowaBarConfigFrame:IsVisible()) then
		getglobal("PowaBarConfigFrame"):Hide();
		getglobal("PowaBarConfigFrameTexture"):Hide();
		PlaySound("TalentScreenClose");
	end
end

-- <<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- <<<<<<<<<<<<<<<<<<< ADV. OPTIONS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function Powa_UpdateOptionsTimer()

	if (PowaEnabled == 0) then return; end   -- desactived

	for i = 1, 5 do

		Powa_Timer[i]:SetAlpha(PowaTimer[i].a);
		Powa_Timer[i]:SetWidth(20 * PowaTimer[i].h);
		Powa_Timer[i]:SetHeight(20 * PowaTimer[i].h);
		Powa_Timer[i]:SetPoint("Center", PowaTimer[i].x, PowaTimer[i].y);

		Powa_Timer2[i]:SetWidth(14 * PowaTimer[i].h);
		Powa_Timer2[i]:SetHeight(14 * PowaTimer[i].h);
		Powa_Timer2[i]:SetPoint("LEFT", Powa_Timer[i], "RIGHT", 1, -1.5);
		Powa_Timer2[i]:SetAlpha(PowaTimer[i].a * 0.75);

	end
end

function PowaShowTimerChecked()
	if (getglobal("PowaShowTimerButton"):GetChecked()) then
		PowaSet[CurrentAura].timer = true;
	else
		PowaSet[CurrentAura].timer = false;
	end
end

function PowaSelectTimer()
	local optionID = this:GetID();

	for i = 1, 5 do
		getglobal("PowaTimer"..i.."Button"):SetChecked(false);
	end
	getglobal("PowaTimer"..optionID.."Button"):SetChecked(true);

	PowaSet[CurrentAura].numtimer = optionID;

	Powa_UpdateOptionsTimer();
	Powa_UpdateTimerOptions(); -- stats des options
end

function PowaTimerAlphaSliderChanged()
	local SliderValue = getglobal("PowaTimerAlphaSlider"):GetValue();

	if (PowaEnabled == 0) then return; end   -- desactived

	getglobal("PowaTimerAlphaSliderText"):SetText(PowaText.nomAlpha.." : "..format("%.2f", SliderValue) );

	PowaTimer[PowaSet[CurrentAura].numtimer].a = SliderValue;
	Powa_UpdateOptionsTimer();
end

function PowaTimerSizeSliderChanged()
	local SliderValue = getglobal("PowaTimerSizeSlider"):GetValue();

	if (PowaEnabled == 0) then return; end   -- desactived

	getglobal("PowaTimerSizeSliderText"):SetText(PowaText.nomTaille.." : "..format("%.2f", SliderValue) );

	PowaTimer[PowaSet[CurrentAura].numtimer].h = SliderValue;
	Powa_UpdateOptionsTimer();
end

function PowaTimerCoordSliderChanged()
	local SliderValue = getglobal("PowaTimerCoordSlider"):GetValue();

	if (PowaEnabled == 0) then return; end   -- desactived

	getglobal("PowaTimerCoordSliderText"):SetText(PowaText.nomPos.." Y : "..SliderValue);

	PowaTimer[PowaSet[CurrentAura].numtimer].y = SliderValue;
	Powa_UpdateOptionsTimer();
end

function PowaTimerCoordXSliderChanged()
	local SliderValue = getglobal("PowaTimerCoordXSlider"):GetValue();

	if (PowaEnabled == 0) then return; end   -- desactived

	getglobal("PowaTimerCoordXSliderText"):SetText(PowaText.nomPos.." X : "..SliderValue);

	PowaTimer[PowaSet[CurrentAura].numtimer].x = SliderValue;
	Powa_UpdateOptionsTimer();
end

function PowaTimerDurationSliderChanged()
	local SliderValue = getglobal("PowaTimerDurationSlider"):GetValue();

	getglobal("PowaTimerDurationSliderText"):SetText(PowaText.nomTimerDuration.." : "..SliderValue.." sec");

	PowaSet[CurrentAura].timerduration = SliderValue;
end

function PowaBuffTimerCentsChecked()
	if (getglobal("PowaBuffTimerCentsButton"):GetChecked()) then

		PowaTimer[PowaSet[CurrentAura].numtimer].cents = true;
	else
		PowaTimer[PowaSet[CurrentAura].numtimer].cents = false;
	end
end

function PowaBuffTimerDualChecked()
	if (getglobal("PowaBuffTimerDualButton"):GetChecked()) then
		PowaTimer[PowaSet[CurrentAura].numtimer].dual = true;
	else
		PowaTimer[PowaSet[CurrentAura].numtimer].dual = false;
	end
end

-- ----------------------------------------------------------- LIGNE DE COMMANDE

function Powa_ShowMainOptions()
	Powa_MainOptionShow();
end

------------------------------------
-- Enable/Disable Options Functions
------------------------------------

function Powa_DisableSlider(slider)
	getglobal(slider):EnableMouse(false);
	getglobal(slider.."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(slider.."Low"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(slider.."High"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function Powa_EnableSlider(slider)
	getglobal(slider):EnableMouse(true);
	getglobal(slider.."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	getglobal(slider.."Low"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	getglobal(slider.."High"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
end

function Powa_DisableTextfield(textfield)
	getglobal(textfield):Hide();
	getglobal(textfield.."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function Powa_EnableTextfield(textfield)
	getglobal(textfield):Show();
	getglobal(textfield.."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function Powa_DisableCheckBox(checkBox)
	getglobal(checkBox):Disable();
	getglobal(checkBox.."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function Powa_EnableCheckBox(checkBox, checked)
	getglobal(checkBox):Enable();
	getglobal(checkBox.."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);	
end

