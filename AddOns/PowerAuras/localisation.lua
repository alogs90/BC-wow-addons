if (GetLocale() == "frFR") then 

PowaAnim = {};
PowaAnim[0] = "[Invisible]";
PowaAnim[1] = "Statique";
PowaAnim[2] = "Clignotement";
PowaAnim[3] = "Agrandir";
PowaAnim[4] = "Pulsation";
PowaAnim[5] = "Effet bulle";
PowaAnim[6] = "Goutte d'eau";
PowaAnim[7] = "Electrique";
PowaAnim[8] = "R\195\169tr\195\169cir";
PowaAnim[9] = "Flamme";
PowaAnim[10] = "Orbite";

PowaDisplay = {};
PowaDisplay[0] = "[Aucun]";
PowaDisplay[1] = "Zoom Avant";
PowaDisplay[2] = "Zoom Arriere";
PowaDisplay[3] = "Transparence seule";
PowaDisplay[4] = "Gauche";
PowaDisplay[5] = "Haut-Gauche";
PowaDisplay[6] = "Haut";
PowaDisplay[7] = "Haut-Droite";
PowaDisplay[8] = "Droite";
PowaDisplay[9] = "Bas-Droite";
PowaDisplay[10] = "Bas";
PowaDisplay[11] = "Bas-Gauche";

-- untranslated--francais---------------------
PowaSound = {};								--
PowaSound[0] = "None";						--
PowaSound[1] = "LEVELUP";					--
PowaSound[2] = "LOOTWINDOWCOINSOUND";
PowaSound[3] = "MapPing";					--
PowaSound[4] = "Exploration";
PowaSound[5] = "QUESTADDED";				--
PowaSound[6] = "QUESTCOMPLETED";
PowaSound[7] = "WriteQuest";				--
PowaSound[8] = "Fishing Reel in";
PowaSound[9] = "igPVPUpdate";				--		
PowaSound[10] = "ReadyCheck";
PowaSound[11] = "RaidWarning";				--
PowaSound[12] = "AuctionWindowOpen";
PowaSound[13] = "AuctionWindowClose";		--
PowaSound[14] = "TellMessage";
PowaSound[15] = "igBackPackOpen";			--

PowaStance = {};						--
PowaStance[0] = "-------------";		--
PowaStance[1] = "Battle Stance";    	--
PowaStance[2] = "Defensive Stance"; 	--
PowaStance[3] = "Berserker Stance"; 	--
----------------------------------------------

PowaText = {
	welcome = "Tapez /powa pour afficher les options.",

	aucune = "Aucune",
	aucun = "Aucun",
	largeur = "Largeur",
	hauteur = "Hauteur",
	mainHand = "droite",
	offHand = "gauche",
	bothHands = "toutes",

	TypeMagic = "Magie",
	TypeDisease = "Maladie",
	TypeCurse = "Mal\195\169diction",
	TypePoison = "Poison",

	-- Main
	nomEnable = "Activer Power Auras",
	aideEnable = "Active tous les effets de Power Auras",
	ListePlayer = "Page",
	ListeGlobal = "Global",
	aideMove = "D\195\169place l'effet s\195\169l\195\169ctionn\195\169 ici.",
	aideCopy = "Copie l'effet s\195\169l\195\169ctionn\195\169 ici.",
	nomRename = "Renommer",
	aideRename = "Renomme la page d'effet en cours.",
	nomTest = "Tester",
	nomHide = "Tout masquer",
	nomEdit = "Editer",
	nomNew = "Nouveau",
	nomDel = "Suppr.",
	aideDel = "Supprime l'effet s\195\169l\195\169ctionn\195\169 (appuyez sur CTRL pour autoriser la suppression)",
	nomMove = "D\195\169placer",
	nomCopy = "Copier",
	nomPlayerEffects = "Effets du personnage",
	nomGlobalEffects = "Effets\nglobaux",
	aideEffectTooltip = "(Maj-click pour mettre cet effet sur ON ou OFF)",

	-- untranslated --francais-------------------
	nomDebug = "Activer Debug Messages",
	aideDebug = "Shows Debug Messages in the chat",
	
	nomSound = "Sound to play",
	aideSound = "Plays a sound at the beginning.",
	nomCustomSound = "OR soundfile:",
	aideCustomSound = "Enter a soundfile that is in the Sounds folder, BEFORE you started the game. mp3 and wav are supported. example: 'cookie.mp3' ;)",
	
	nomExact = "Exact Name",
	nomThreshold = "Threshold",
	nomGCD = "Global Cooldown",
	
	aideGCD = "Check this and the Global Cooldown triggers with 'action usable'. May cause blinking the aura, when an action only has a Global Cooldown.",
	aideStance = "Select which Stance,Aura or Form trigger the event.",
	
	nomCheckHealth = "Health",
	nomCheckMana = "Mana",
	nomCheckStance = "Stance",
	
	aideExact = "Check this to test the exact name of the buff/debuff.",
	
	nomTabSound = "Sound",
	nomTabTimer = "Timer",
	-- -------------------------------------------
	
	nomTexture = "Texture",
	aideTexture = "La texture \195\160 afficher. Vous pouvez facilement remplacer les textures en changeant les fichier Aura#.tga du dossier de l'AddOn.",
	nomAnim1 = "Animation principale",
	nomAnim2 = "Animation secondaire",
	aideAnim1 = "Anime la texture ou pas, avec diff\195\169rents effets.",
	aideAnim2 = "Cette animation sera affich\195\169e avec moins d'opacit\195\169 que la principale. Attention, afin de ne pas surcharger le tout, une seule animation secondaire sera affich\195\169e a la fois.",
	nomDeform = "D\195\169formation",
	aideDeform = "Etire la texture vers le haut ou en largeur.",
	aideColor = "Cliquez ici pour changer la couleur de la texture.",
	aideBuff = "Entrez ici le nom du buff, ou une partie du nom, qui doit activer/d\195\169sactiver l'effet. Vous pouvez entrer plusieurs noms s'ils sont s\195\169par\195\169 comme il convient (ex: Super Buff/Puissance)",
	aideBuff2 = "Entrez ici le nom du d\195\169buff, ou une partie du nom, qui doit activer/d\195\169sactiver l'effet. Vous pouvez entrer plusieurs noms s'ils sont s\195\169par\195\169 comme il convient (ex: Maladie noire/Peste)",
	aideBuff3 = "Entrez ici le type du d\195\169buff qui doit activer ou d\195\169sactiver l'effet (Poison, Maladie, Mal\195\169diction, Magie ou Aucun). Vous pouvez aussi entrer plusieurs types de d\195\169buffs \195\160 la fois.",
	aideBuff4 = "Entrez ici le nom de l'effet de zone qui activera l'effet (comme une pluie de feu par exemple, g\195\169n\195\169ralement le nom de l'effet est disponible dans le journal de combat)",
	aideBuff5 = "Veuillez entrer ici l'arme en question : 'droite', 'gauche' ou 'toutes' pour tester les 2.",
	aideBuff6 = "Vous pouvez entrez ici le ou les chiffres des points de combos qui activeront l'effet (ex : 1 ou 123 ou 045 etc...) ",
	aideBuff7 = "Indiquez ici le nom, ou une partie du nom, d'une des actions dans vos barres. L'effet sera actif si l'action est utilisable.",
	
	aideStacks = "Enter here the operator and the amount of stacks, which must activate/deactivate the effect. It works only with an operator! ex: '<5' or '>3' or '=11'", -- untranslated
	
	aideUnitn = "Entrez ici le nom du unit, qui doit activer/d\195\169sactiver l'effet. Works only for raid/partymembers.",
	aideUnitn2 = "Only for raid/group.",
    aideMaxTex = "Defini le maximum de textures disponibles dans l'Editeur d'Effets. Si vous rajoutez des textures en les mettant dans le dossier de l'AddOn (nomm\195\169es de AURA1.tga \195\160 AURA50.tga) c'est ici qu'il faudra le signaler.",
	aideAddEffect = "Ajoute une page d'effet.",
	aideWowTextures = "Cochez cette case pour utiliser les textures internes du jeu plut\195\180t que le dossier de l'addon pour cet effet.",
	aideRealaura = "Reale Aura",
    aideCustomTextures = "Cochez cette case pour utiliser les textures pr\195\169sentes dans le sous-dossier 'Custom'. Vous devez connaitre le nom du fichier et indiquer son nom (ex : myTexture.tga)",
	aideRandomColor = "Cochez cette case pour que l'effet prenne des couleurs au hasard \195\160 chaque activation.",
	aideTexMode = "Decochez cette case pour utiliser la transparence de la texture. Par defaut, les couleurs sombres seront plus transparentes.",
	nomActivationBy = "Activation par :",
	
	nomStacks = "Stacks", -- untranslated
	
	nomSpeed = "Vitesse d'Anim.",
	nomBegin = "Animation de d\195\169part",
	nomEnd = "Animation de fin",
	nomSymetrie = "Sym\195\169trie",
	nomAlpha = "Transparence",
	nomPos = "Position",
	nomTaille = "Taille",
	
	nomCheckBuff = "Buff",
	nomCheckDebuff = "Debuff",
	nomCheckDebuffType = "Type du Debuff",
	nomCheckAoeDebuff = "Debuff de zone",
	nomCheckEnchant = "Enchant. d'arme",
	nomCheckCombo = "Combos",
	nomCheckSkill = "Action utilisable",
		
	nomCheckTarget = "Cible ennemie",
	nomCheckFriend = "Cible amie",
	nomCheckParty = "Cible partie",
    nomCheckFocus = "Cible focus",
    nomCheckRaid = "Cible raid",
    nomCheckOptunitn = "Cible unit",
	aideTarget = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible ennemie.",
	aideTargetFriend = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible amie.",
	aideParty = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible partie.",
	aideParty = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible focus.",
	aideParty = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible raid.",
	aideParty = "Cochez cette case pour v\195\169rifier plut\195\180t les buffs/d\195\169buffs d'une cible unit de raid ou partie.",	
    aideExact = "Check this to test the exact name of the buff/debuff.",
	
	nomCheckShowTimer = "Afficher",
	nomTimerDuration = "Chronometre",
	
	aideTimerDuration = "Affiche un timer pour simuler la dur\195\169e d'un buff/debuff sur la cible (0 pour d\195\169sactiver)",
	aideShowTimer = "Cochez cette case pour afficher la dur\195\169e de cet effet.",
	aideSelectTimer = "Choisissez quel timer sera pris pour afficher la dur\195\169e",
	aideSelectTimerBuff = "Choisissez quel timer sera pris pour afficher la dur\195\169e (celui-ci est reserv\195\169 aux buffs du joueur)",
	aideSelectTimerDebuff = "Choisissez quel timer sera pris pour afficher la dur\195\169e (celui-ci est reserv\195\169 aux debuffs du joueur)",
	
	nomCheckInverse = "Afficher si inactif",
	aideInverse = "Cochez cette case pour afficher cet effet uniquement quand le buff/d\195\169buff n'est pas actif.",
	
	nomCheckIgnoreMaj = "Ignorer les majuscules",
	aideIgnoreMaj = "Cochez cette case pour ignorer les majuscules/minuscules du nom des buffs/d\195\169buffs.",
	
	nomDuration = "Dur\195\169e de l'Anim.",
	aideDuration = "Pass\195\169 ce d\195\169lai, l'animation sera masqu\195\169e (0 pour d\195\169sactiver)",
	
	nomCentiemes = "Afficher centiemes",
	nomDual = "Afficher 2 dur\195\169es",
	nomClose = "Fermer",
	nomEffectEditor = "Editeur d'Effet",
	nomAdvOptions = "Options",
	nomMaxTex = "Maximum de textures disponibles",
	nomTabAnim = "Animation",
	nomTabActiv = "Activation",
	nomWowTextures = "Textures WoW",
	nomCustomTextures = "Autres Textures",
    nomRealaura = "Reale Aura",
	nomRandomColor = "Couleurs al\195\169atoires",
	nomTexMode = "Glow",
	nomInCombat = "Actif si en combat",
	aideInCombat = "Affiche cet effet uniquement si le personnage est en combat.",
	nomNotInCombat = "Actif si hors combat",
	aideNotInCombat = "Affiche cet effet uniquement si le personnage ne se trouve pas en combat.",
	
	nomIsMounted = "Only if on mount.", -- untranslated
	aideIsMounted = "Show this effect only when you are on a mount.", -- untranslated
	nomIsInRaid = "Only if in raid", -- untranslated
	aideIsInRaid = "Show this effect only when you are in a raid." -- untranslated
};

elseif (GetLocale() == "deDE") then
    
PowaAnim = {};
PowaAnim[0] = "[Nichts]";
PowaAnim[1] = "Statisch";
PowaAnim[2] = "Blitzend";
PowaAnim[3] = "Wachsend";
PowaAnim[4] = "Pulsierend";
PowaAnim[5] = "Blase";
PowaAnim[6] = "Wassertropfen";
PowaAnim[7] = "Electrisch";
PowaAnim[8] = "Schrumpfend";
PowaAnim[9] = "Flamme";
PowaAnim[10] = "Orbit";

PowaDisplay = {};
PowaDisplay[0] = "[None]";
PowaDisplay[1] = "Reinzoomend";
PowaDisplay[2] = "Rauszoomend";
PowaDisplay[3] = "Nur Alpha";
PowaDisplay[4] = "Links";
PowaDisplay[5] = "Obenlinks";
PowaDisplay[6] = "Oben";
PowaDisplay[7] = "Obenrechts";
PowaDisplay[8] = "Rechts";
PowaDisplay[9] = "Untenrechts";
PowaDisplay[10] = "Unten";
PowaDisplay[11] = "Untenlinks";

PowaSound = {};
PowaSound[0] = "Kein";
PowaSound[1] = "LEVELUP";
PowaSound[2] = "LOOTWINDOWCOINSOUND";
PowaSound[3] = "MapPing";
PowaSound[4] = "Exploration";
PowaSound[5] = "QUESTADDED";
PowaSound[6] = "QUESTCOMPLETED";
PowaSound[7] = "WriteQuest";
PowaSound[8] = "Fishing Reel in";
PowaSound[9] = "igPVPUpdate";
PowaSound[10] = "ReadyCheck";
PowaSound[11] = "RaidWarning";
PowaSound[12] = "AuctionWindowOpen";
PowaSound[13] = "AuctionWindowClose";
PowaSound[14] = "TellMessage";
PowaSound[15] = "igBackPackOpen";

PowaStance = {};
PowaStance[0] = "-------------";
PowaStance[1] = "Kampfhaltung";
PowaStance[2] = "Defensivhaltung";
PowaStance[3] = "Berserkerhaltung";

PowaText = {
	welcome = "Gib /powa ein, um die Optionen zu öffnen.",

	aucune = "Nichts",
	aucun = "Nichts",
	largeur = "Breite",
	hauteur = "Höhe",
	mainHand = "Waffenhand",
	offHand = "Schildhand",
	bothHands = "beide",

	TypeMagic = "Magie",
	TypeDisease = "Disease",
	TypeCurse = "Fluch",
	TypePoison = "Gift",

	-- main
	nomEnable = "Aktiviere Power Auras",
	aideEnable = "Alle Power Auras Effekte einschalten",
	nomDebug = "Aktiviere Debug Meldungen",
	aideDebug = "Zeigt Debug Meldungen im Chatfenster",	
	ListePlayer = "Char",
	ListeGlobal = "Global",
	aideMove = "Effekt hierher verschieben.",
	aideCopy = "Effekt hierher kopieren.",
	nomRename = "Umbenennen",
	aideRename = "Seitentitel umbenennen.",
	nomTest = "Test",
	nomHide = "Alle ausblenden",
	nomEdit = "Editieren",
	nomNew = "Neu",
	nomDel = "Löschen",
	aideDel = "Löscht den ausgewählten Effekt.(Halte CTRL gedrückt, um zu löschen)",
	nomMove = "Verschieben",
	nomCopy = "Kopieren",
	nomPlayerEffects = "Charakter Effekte",
	nomGlobalEffects = "Globale\nEffekte",
	aideEffectTooltip = "(Shift-Klick um Effekt ein oder auszuschalten.)",

	-- editor
	nomSound = "Sound abspielen:",
	aideSound = "Spielt einen Sound am Anfang ab.",
	nomCustomSound = "ODER Sounddatei:",
	aideCustomSound = "Dateiname eingeben der Sounddatei, die VOR dem WoW Starten im Sounds Verzeichniss war. mp3 und wav werden unterstützt. Bsp.: 'cookie.mp3' ;)",
	
	nomTexture = "Grafik",
	aideTexture = "Die Aura die angezeigt werden soll.",
	nomAnim1 = "Hauptanimation",
	nomAnim2 = "Zweitanimation",
	aideAnim1 = "Animiere die Aura oder nicht.",
	aideAnim2 = "Diese Animation wird mit weniger Staerke angezeigt als die Hauptanimation. Nur eine Singleanimation wird zu selben Zeit angezeigt, wegen möglicher Überladung der Grafik.",
	nomDeform = "Deformation",
	aideDeform = "Strecke die Animation in Höhe und Breite.",
	aideColor = "Klicken, um die Farbe zu ändern.",
	aideBuff = "Gib hier den Namen oder einen Teil vom Namen des Buff ein, der die Aura ein und ausschalten soll. Mit einem Slash können mehrere Namen getrennt werden. (Bsp.: Super Buff/Power)",
	aideBuff2 = "Gib hier den Namen oder einen Teil vom Namen des Debuff ein, der die Aura ein und ausschalten soll. Mit einem Slash können mehrere Namen getrennt werden. (Bsp: Dark Disease/Plague)",
	aideBuff3 = "Gib hier den Typ(Gift, Disease, Fluch, Magie or Nichts) des Debuff ein, der die Aura ein und ausschalten soll. Mit einem Slash können mehrere Typen getrennt werden.",
	aideBuff4 = "Gib hier den Namen der Area of Effect(AoE) ein, der die Aura ein oder ausschalten soll. Der Name einer AoE steht im Kampflog.",
	aideBuff5 = "Gib hier die Waffenhand ein, bei der die Aura ein oder ausgeschalten werden soll. : 'Waffenhand', 'Schildhand' oder 'beide' für beide Waffen.",
	aideBuff6 = "Gib hier die Anzahl Kombopunkte ein, um die Aura ein oder auszuschalten (Bsp.: 1 oder 123 oder 045 usw...) ",
	aideBuff7 = "Gib hier einen Namen oder einen Teil davon einer Aktion auf deiner Aktionsleiste ein, um diese auf Benutzbarkeit zu überprüfen. (Bsp.: Hinrichten, Fass, Rache, Überwältigen,...",
	
	aideStacks = "Gib hier den Vergleicher und die Anzahl Stapel ein des De/Buffs. Oder einfach freilassen, wenn nicht stapelbar. Es geht nur MIT einem Vergleicher! Bsp: '<5' or '>3' or '=11'",
	
	aideUnitn = "Gib hier den Namen des Spielers ein, welcher überwacht werden soll. Funktioniert nur mit Spieler innerhalb des Raids oder der Gruppe.",	
    aideUnitn2 = "Only for raid/group.",
    aideMaxTex = "Definiert die Texturanzahl die im Editor zur Verfügung stehen. Wenn Texturen im PowerAuras Verzeichniss hinzugefügt wurden (mit den Namen AURA1.tga bis AURA50.tga), muss hier die letzte Zahl eingetragen werden.",
	aideAddEffect = "Fügt ein Effekt zum bearbeiten hinzu.",
	aideWowTextures = "Aktivieren um die WoW-Grafiken anstatt die Grafiken im PowerAuras Verzeichniss zu verwenden.",
    aideRealaura = "Reale Aura",
	aideCustomTextures = "Aktivieren um die Grafiken im 'Custom' Verzeichniss zu verwenden. Du musst den Dateinamen der Grafik eintragen (Bsp.: myTexture.tga)",
	aideRandomColor = "Aktivieren um jedesmal wenn die Aura aktiviert wird eine zufällige Farbe zu erhalten.",
	aideTexMode = "Uncheck this to use the texture opacity. By default, the darkest colors will be more transparent.",
	
	nomActivationBy = "Aktiv wenn:",
	
	nomStacks = "Stacks",
	
	nomSpeed = "Animations Tempo",
	nomBegin = "Animations Start",
	nomEnd = "Animations Ende",
	nomSymetrie = "Symetrie",
	nomAlpha = "Alpha",
	nomPos = "Position",
	nomTaille = "Grösse",
	
	nomExact = "Exakter Name",
	nomThreshold = "Schwellwert",
	nomGCD = "Global Cooldown",	
	
	nomStance = "Haltung",
	aideStance = "Kampfhaltung auswählen, die die Aura aktiviert.",	
	
	nomCheckBuff = "Buff",
	nomCheckDebuff = "Debuff",
	nomCheckAoeDebuff = "AOE Debuff",
	nomCheckDebuffType = "Debuff Typ",
	nomCheckEnchant = "Waffenbuffs",
	nomCheckCombo = "Kombo Punkte",
	nomCheckSkill = "Aktion benutzbar",
	nomCheckHealth = "Leben",
	nomCheckMana = "Mana",
	nomCheckStance = "Haltung",
	
	nomCheckTarget = "Feindliches Ziel",
	nomCheckFriend = "Freundliches Ziel",
	nomCheckParty = "Gruppenmitglied",
    nomCheckFocus = "Focus",
    nomCheckRaid = "Raidmitglied",
    nomCheckOptunitn = "Charname",
	
	aideTarget = "Aktivieren um feindliches Ziel zu überwachen.",
	aideTargetFriend = "Aktivieren um freundliches Ziel zu überwachen.",
	aideParty = "Aktivieren um Gruppenmitglieder zu überwachen.",
	aideFocus = "Aktivieren um das Focusziel zu überwachen.",
	aideRaid = "Aktivieren um Raidmitglieder zu überwachen.",
	aideExact = "Aktivieren um den EXAKTEN Namen des Buffes zu überwachen.",
	aideOptunitn = "Aktivieren um einen bestimmten Char in der Raid/Gruppe zu überwachen.",
	aideExact = "Aktivieren um den Globalen Cooldown mit einzubeziehen, wenn 'Aktion benutzbar' gewählt ist. Kann zu einem blinken der Aura führen, wenn die Aktion nur einen Globalen Cooldown hat.",
    
	nomCheckShowTimer = "Zeigen",
	nomTimerDuration = "Dauer",
	aideTimerDuration = "Zeigt eine Buff/Debuff Dauer. (0 um zu daktivieren)",
	aideShowTimer = "Aktivieren um den Timer zu zeigen.",
	aideSelectTimer = "Auswählen welcher Timer die Dauer anzeigen soll.",
	aideSelectTimerBuff = "Auswählen welcher Timer die Dauer anzeigen soll (this one is reserved for player's buffs)",
	aideSelectTimerDebuff = "Auswählen welcher Timer die Dauer anzeigen soll (this one is reserved for player's debuffs)",
	
	nomCheckInverse = "Zeige wenn NICHT aktiv",
	aideInverse = "Aktivieren um die Aura nur zu zeigen wenn der Buff/Debuff NICHT aktiv ist.",	
	
	nomCheckIgnoreMaj = "Ignoriere Gross/Kleinschreibung",	
	aideIgnoreMaj = "Aktivieren um die Gross/Kleinschreibung bei Buff/Debuff-Namen zu ignorieren.",
	
	nomDuration = "Animationsdauer",
	aideDuration = "Nach dieser Zeit wird die Aura verschwinden (0 um zu daktivieren)",
	
	nomCentiemes = "Zeige hundertstel",
	nomDual = "Zeige 2 Timer",
	nomClose = "Schliessen",
	nomEffectEditor = "Effekt Editor",
	nomAdvOptions = "Optionen",
	nomMaxTex = "Maximum Texturen verfügbar",
	nomTabAnim = "Animation",
	nomTabActiv = "Aktivierung",
	nomTabSound = "Sound",
	nomTabTimer = "Timer",
	nomWowTextures = "WoW Texturen",
	nomCustomTextures = "Custom Texturen",
    nomRealaura = "Reale Aura",
	nomRandomColor = "Zufällige Farben",
	nomTexMode = "Glühen",
	nomInCombat = "Nur wenn im Kampf.",
	aideInCombat = "Zeigt diese Aura nur im Kampf.",
	nomNotInCombat = "Nur wenn nicht im Kampf",
	aideNotInCombat = "Zeigt diese Aura nur wenn nicht im Kampf.",
	nomIsMounted = "Nur wenn auf Reittier.", 
	aideIsMounted = "Zeigt diese Aura nur wenn man auf einem Reittier sitzt.",
	nomIsInRaid = "Nur wenn im Raid.", 
	aideIsInRaid = "Zeigt diese Aura nur wenn im Raid."
};

elseif (GetLocale() == "zhCN") then
PowaAnim = {};
PowaAnim[0] = "[无]";
PowaAnim[1] = "静止";
PowaAnim[2] = "闪光效果";
PowaAnim[3] = "生长效果";
PowaAnim[4] = "脉冲效果";
PowaAnim[5] = "气泡效果";
PowaAnim[6] = "水滴效果";
PowaAnim[7] = "漏电效果";
PowaAnim[8] = "收缩效果";
PowaAnim[9] = "火焰效果";
PowaAnim[10] = "盘旋效果";

PowaDisplay = {};
PowaDisplay[0] = "[无]";
PowaDisplay[1] = "放大进入";
PowaDisplay[2] = "缩小进入";
PowaDisplay[3] = "改变透明度";
PowaDisplay[4] = "左边进入";
PowaDisplay[5] = "左上进入";
PowaDisplay[6] = "上部进入";
PowaDisplay[7] = "右上进入";
PowaDisplay[8] = "右边进入";
PowaDisplay[9] = "右下进入";
PowaDisplay[10] = "下部进入";
PowaDisplay[11] = "左下进入";

PowaSound = {};
PowaSound[0] = "[无]";
PowaSound[1] = "升级音效";
PowaSound[2] = "抬取金币";
PowaSound[3] = "飞过";
PowaSound[4] = "探索新地图";
PowaSound[5] = "接到任务";
PowaSound[6] = "任务完成";
PowaSound[7] = "写任务";
PowaSound[8] = "钓鱼";
PowaSound[9] = "PVP事件";
PowaSound[10] = "团队检查";
PowaSound[11] = "团队警告";
PowaSound[12] = "打开拍卖行";
PowaSound[13] = "关闭拍卖行";
PowaSound[14] = "消消话";
PowaSound[15] = "打开背包";

PowaStance = {};
PowaStance[0] = "-------------";
PowaStance[1] = "战斗姿态";
PowaStance[2] = "防御姿态";
PowaStance[3] = "狂暴姿态";

PowaText = {
	
	nomDebug = "启用Debug模式",
	aideDebug = "选项此项后,插件如果遇到错误将显示提示信息",
	
	nomStance = "姿态",
	aideStance = "选择用于触发特效的姿态",
	
	nomCheckStance = "姿态(战士)",
	
	nomCustomSound = "自定义声音文件:",
	
	nomTabSound = "声音",
	nomTabTimer = "计时器",
		
	welcome = "输入 /powa 打开特效编辑器.",			

	aucune = "无",
	aucun = "无",
	largeur = "宽度",
	hauteur = "高度",
	mainHand = "主手",
	offHand = "副手",
	bothHands = "双手",

	TypeMagic = "魔法",
	TypeDisease = "疾病",
	TypeCurse = "诅咒",
	TypePoison = "中毒",

	-- main
	nomEnable = "启用",
	aideEnable = "启用/禁用所有PowerAuras特效",
	
	ListePlayer = "分类",
	ListeGlobal = "全局",
	aideMove = "移动特效",
	aideCopy = "复制特效",
	nomRename = "重命名",
	aideRename = "重命名我的特效分类名",
	nomTest = "测试",
	nomHide = "全部隐藏",
	nomEdit = "编辑",
	nomNew = "新建",
	nomDel = "删除",
	aideDel = "删除所选特效(必须按住Ctrl键才能使用此功能)",
	nomMove = "移动",
	nomCopy = "复制",
	nomPlayerEffects = "我的特效",
	nomGlobalEffects = "通用特效",
	aideEffectTooltip = "按住Shift键点击图标以启用/禁用该特效",

	-- editor
	nomTexture = "当前材质",
	aideTexture = "显示特效使用的材质.你可以修改相应文件夹内的.tga 文件来增加特效",
	nomAnim1 = "动画效果",
	nomAnim2 = "辅助效果",
	aideAnim1 = "是否为所选材质使用动画效果",
	aideAnim2 = "此动画效果以较低不透明度显示,为了不过多占用屏幕同一时间只显示一个辅助效果",
	nomDeform = "变形",
	aideDeform = "在高度或宽度方向拉伸材质",
	aideColor = "点击此处修改材质颜色",
	aideBuff = "此处输入用于激活特效的buff的名字,或名字中的几个连续文字.如果使用分隔符,也可以输入多个buff的名字.例如输入: 能量灌注/奥术能量",
	aideBuff2 = "此处输入用于激活特效的debuff的名字,或名字中的几个连续文字.如果使用分隔符,也可以输入多个debuff的名字.例如输入: 堕落治疗/燃烧刺激",
	aideBuff3 = "此处输入用于激活特效的debuff的类型名称,或名称中的几个连续文字.如果使用分隔符,也可以输入多个debuff类型的名称.例如输入: 魔法/诅咒/中毒/疾病",
	aideBuff4 = "此处输入用于激活特效的AOE法术的名字,AOE法术名字可以在战斗记录中找到.例如输入:邪恶光环/火焰之雨/暴风雪",
	aideBuff5 = "此处输入用于激活特效的武器分类名称.例如输入:主手/副手/双手",
	aideBuff6 = "此处输入用于激活特效的连击点数.例如输入: 1或者123或者045等等自由组合",
	aideBuff7 = "此处输入激活特效的动作条上的动作名,或名字中的几个连续文字,当此动作完全冷却时此效果触发.例如输入:赞达拉英雄护符/法力之潮图腾/心灵专注",
	
	aideStacks = "Enter here the operator and the amount of stacks, which must activate/deactivate the effect. It works only with an operator! ex: '<5' or '>3' or '=11'", -- untranslated
	
	aideUnitn = "此处输入用于激活特效的特定成员名称,必须处于同一团队",
    aideUnitn2 = "仅用于团队/队伍模式",    
	aideMaxTex = "定义特效编辑器使用的材质数量,如果你增加了自定义材质请修改此值.",
	aideAddEffect = "新增加一个特效",
	aideWowTextures = "使用游戏内置材质",
	aideRealaura = "清晰光环",
	aideCustomTextures = "使用custom文件夹下的自定义材质,例如: Flamme.tga",
	aideRandomColor = "每次激活时使用随机颜色",
	aideTexMode = "材质透明度反向显示",
	
	nomActivationBy = "激活条件",
	
	nomStacks = "Stacks", -- untranslated
	
	nomSpeed = "运动速度",
	nomBegin = "进场效果",
	nomEnd = "结束效果",
	nomSymetrie = "对称性",
	nomAlpha = "不透明度",
	nomPos = "位置",
	nomTaille = "大小",
	nomExact = "精确匹配名称",
	nomThreshold = "触发极限",
	
	nomGCD = "公共冷却",
	aideGCD = "选中此项后'动作冷却'功能将检测公共冷却.需要注意的是,如果一个技能只有公共冷却则会引起光环特效闪烁",
	
	
	
	nomSound = "播放声音",
	aideSound = "特效触发时播放声音",
	aideCustomSound = "输入声音文件名称,如cookie.mp3 注意:你需要在游戏启动前把声音文件放入Sounds文件夹下,目前仅支持mp3和wav格式.",
	
	nomCheckBuff = "Buff",
	nomCheckDebuff = "Debuff",
	nomCheckAoeDebuff = "AOE法术",
	nomCheckDebuffType = "Debuff类型",
	nomCheckEnchant = "武器强化",
	nomCheckCombo = "连击点数",
	nomCheckSkill = "动作冷却",
	nomCheckHealth = "生命值",
	nomCheckMana = "魔法值",
	
	nomCheckTarget = "敌方目标",
	nomCheckFriend = "友方目标",
	nomCheckParty = "团队目标",
    nomCheckFocus = "焦点目标",
    nomCheckRaid = "团队成员",
    nomCheckOptunitn = "特定成员",

	aideTarget = "此buff/debuff仅存在于敌方目标上",
	aideTargetFriend = "此buff/debuff仅存在于友方目标上",
	aideParty = "此buff/debuff仅存在于小队中",
	aideFocus = "此buff/debuff仅存在焦点目标上",
	aideRaid = "此buff/debuff仅存在于团队中",
	aideOptunitn = "此buff/debuff仅存在于团队/小队中的特定成员身上",
	aideExact = "选中此项将精确匹配buff/debff名称",
	
	nomCheckShowTimer = "显示",
	nomTimerDuration = "延迟消失",
	aideTimerDuration = "目标上的buff/debuff计时器延迟到此时间结束后再消失(0为禁用)",
	aideShowTimer = "为此效果显示计时器",
	aideSelectTimer = "选择使用何种计时器来显示持续时间",
	aideSelectTimerBuff = "选择使用何种计时器来显示持续时间(仅用于玩家buff)",
	aideSelectTimerDebuff = "选择使用何种计时器来显示持续时间(仅用于玩家debuff)",
	nomCheckInverse = "不存在时激活",
	aideInverse = "选中此项后,仅当buff/debuff不存在时显示此特效",	
	nomCheckIgnoreMaj = "忽略大小写",	
	aideIgnoreMaj = "选中此项将忽略buff/debuff名字的大小写字母(供英文玩家使用,中国玩家不需要修改此项)",
	nomDuration = "延迟消失",
	aideDuration = "特效延迟到此时间结束后再消失(0为禁用)",
	nomCentiemes = "显示百分位",
	nomDual = "显示两个计时器",
	nomClose = "关闭",
	nomEffectEditor = "特效编辑器",
	nomAdvOptions = "选项",
	nomMaxTex = "最大可用材质",
	nomTabAnim = "动画效果",
	nomTabActiv = "激活条件",
	
	nomWowTextures = "使用内置材质",
	nomCustomTextures = "使用自定义材质",
    nomRealaura = "清晰光环",
	nomRandomColor = "随机颜色",
	nomTexMode = "光晕效果",
	nomInCombat = "战斗状态",
	aideInCombat = "仅当你处于战斗状态时才激活此特效",
	nomNotInCombat = "非战斗状态",
	aideNotInCombat = "仅在非战斗状态时才激活此特效",
	
	nomIsMounted = "Only if on mount.", -- untranslated
	aideIsMounted = "Show this effect only when you are on a mount.", -- untranslated
	nomIsInRaid = "Only if in raid", -- untranslated
	aideIsInRaid = "Show this effect only when you are in a raid." -- untranslated

};
elseif (GetLocale() == "zhTW") then
PowaAnim = {};
PowaAnim[0] = "[無]";
PowaAnim[1] = "靜止";
PowaAnim[2] = "閃光效果";
PowaAnim[3] = "生長效果";
PowaAnim[4] = "脈沖效果";
PowaAnim[5] = "氣泡效果";
PowaAnim[6] = "水滴效果";
PowaAnim[7] = "漏電效果";
PowaAnim[8] = "收縮效果";
PowaAnim[9] = "火焰效果";
PowaAnim[10] = "盤旋效果";

PowaDisplay = {};
PowaDisplay[0] = "[無]";
PowaDisplay[1] = "放大進入";
PowaDisplay[2] = "縮小進入";
PowaDisplay[3] = "改變透明度";
PowaDisplay[4] = "左邊進入";
PowaDisplay[5] = "左上進入";
PowaDisplay[6] = "上部進入";
PowaDisplay[7] = "右上進入";
PowaDisplay[8] = "右邊進入";
PowaDisplay[9] = "右下進入";
PowaDisplay[10] = "下部進入";
PowaDisplay[11] = "左下進入";

PowaSound = {};
PowaSound[0] = "[無]";
PowaSound[1] = "升級音效";
PowaSound[2] = "擡取金幣";
PowaSound[3] = "飛過";
PowaSound[4] = "探索新地圖";
PowaSound[5] = "接到任務";
PowaSound[6] = "任務完成";
PowaSound[7] = "寫任務";
PowaSound[8] = "釣魚";
PowaSound[9] = "PVP事件";
PowaSound[10] = "團隊檢查";
PowaSound[11] = "團隊警告";
PowaSound[12] = "打開拍賣行";
PowaSound[13] = "關閉拍賣行";
PowaSound[14] = "消消話";
PowaSound[15] = "打開背包";

PowaStance = {};
PowaStance[0] = "-------------";
PowaStance[1] = "戰鬥姿態";
PowaStance[2] = "防禦姿態";
PowaStance[3] = "狂暴姿態";


PowaText = {
	
	nomDebug = "啟用Debug模式",
	aideDebug = "選項此項後,插件如果遇到錯誤將顯示提示信息",
	
	nomStance = "姿態",
	aideStance = "選擇用於觸發特效的姿態",
	
	nomCheckStance = "姿態",
	
	nomCustomSound = "自定義聲音文件:",
	
	nomTabSound = "聲音",
	nomTabTimer = "計時器",

	nomExact = "精確匹配名稱",
	aideExact = "選中此項將精確匹配buff/debff名稱",


	
	nomGCD = "公共冷卻",
	aideGCD = "選中此項後'動作冷卻'功能將檢測公共冷卻.需要註意的是,如果一個技能只有公共冷卻則會引起光環特效閃爍",
	
	
	
	nomSound = "播放聲音",
	aideSound = "特效觸發時播放聲音",
	aideCustomSound = "輸入聲音文件名稱,如cookie.mp3 註意:你需要在遊戲啟動前把聲音文件放入Sounds文件夾下,目前僅支持mp3和wav格式.",

	
	nomThreshold = "觸發極限",

	nomSound = "播放聲音",
	aideSound = "特效觸發時播放聲音",
	aideCustomSound = "輸入聲音文件名稱,如cookie.mp3 註意:你需要在遊戲啟動前把聲音文件放入Sounds文件夾下,目前僅支持mp3和wav格式.",
	
	nomCheckHealth = "生命值",
	nomCheckMana = "魔法值",
	
	welcome = "輸入 /powa 打開特效編輯器.",

	aucune = "無",
	aucun = "無",
	largeur = "寬度",
	hauteur = "高度",
	mainHand = "主手",
	offHand = "副手",
	bothHands = "雙手",

	TypeMagic = "魔法",
	TypeDisease = "疾病",
	TypeCurse = "詛咒",
	TypePoison = "中毒",

	-- main
	nomEnable = "啓用",
	aideEnable = "啓用所有PowerAuras特效",	
	ListePlayer = "分類",
	ListeGlobal = "全局",
	aideMove = "移動特效",
	aideCopy = "複制特效",
	nomRename = "重命名",
	aideRename = "重命名我的特效分類名",
	nomTest = "測試",
	nomHide = "全部隱藏",
	nomEdit = "編輯",
	nomNew = "新建",
	nomDel = "刪除",
	aideDel = "刪除所選特效(必須按住Ctrl鍵才能使用此功能)",
	nomMove = "移動",
	nomCopy = "複制",
	nomPlayerEffects = "我的特效",
	nomGlobalEffects = "通用特效",
	aideEffectTooltip = "按住Shift鍵點擊圖標以啓用/禁用該特效",

	-- editor
	nomTexture = "當前材質",
	aideTexture = "顯示特效使用的材質.你可以修改相應文件夾內的.tga 文件來增加特效",
	nomAnim1 = "動畫效果",
	nomAnim2 = "輔助效果",
	aideAnim1 = "是否爲所選材質使用動畫效果",
	aideAnim2 = "此動畫效果以較低不透明度顯示,爲了不過多占用屏幕同一時間隻顯示一個輔助效果",
	nomDeform = "變形",
	aideDeform = "在高度或寬度方向拉伸材質",
	aideColor = "點擊此處修改材質顔色",
	aideBuff = "此處輸入用于激活特效的buff的名字,或名字中的幾個連續文字.如果使用分隔符,也可以輸入多個buff的名字.例如輸入: 能量灌注/奧術能量",
	aideBuff2 = "此處輸入用于激活特效的debuff的名字,或名字中的幾個連續文字.如果使用分隔符,也可以輸入多個debuff的名字.例如輸入: 墮落治療/燃燒刺激",
	aideBuff3 = "此處輸入用于激活特效的debuff的類型名稱,或名稱中的幾個連續文字.如果使用分隔符,也可以輸入多個debuff類型的名稱.例如輸入: 魔法/詛咒/中毒/疾病",
	aideBuff4 = "此處輸入用于激活特效的AOE法術的名字,AOE法術名字可以在戰鬥記錄中找到.例如輸入:邪惡光環/火焰之雨/暴風雪",
	aideBuff5 = "此處輸入用于激活特效的武器分類名稱.例如輸入:主手/副手/雙手",
	aideBuff6 = "此處輸入用于激活特效的連擊點數.例如輸入: 1或者123或者045等等自由組合",
	aideBuff7 = "此處輸入激活特效的動作條上的動作名,或名字中的幾個連續文字,當此動作完全冷卻時此效果觸發.例如輸入:贊達拉英雄護符/法力之潮圖騰/心靈專注",
	aideStacks = "Enter here the operator and the amount of stacks, which must activate/deactivate the effect. It works only with an operator! ex: '<5' or '>3' or '=11'", -- untranslated
	aideUnitn = "此處輸入用于激活特效的特定成員名稱,必須處于同一團隊",
    aideUnitn2 = "僅用于團隊/隊伍模式",    
	aideMaxTex = "定義特效編輯器使用的材質數量,如果你增加了自定義材質請修改此值.",
	aideAddEffect = "新增加一個特效",
	aideWowTextures = "使用遊戲內置材質",
	aideRealaura = "清晰光環",
	aideCustomTextures = "使用custom文件夾下的自定義材質,例如: Flamme.tga",
	aideRandomColor = "每次激活時使用隨機顔色",
	aideTexMode = "材質透明度反向顯示",
	
	nomActivationBy = "激活條件",
	nomStacks = "Stacks", -- untranslated
	nomSpeed = "運動速度",
	nomBegin = "進場效果",
	nomEnd = "結束效果",
	nomSymetrie = "對稱性",
	nomAlpha = "不透明度",
	nomPos = "位置",
	nomTaille = "大小",
	
	nomCheckBuff = "Buff",
	nomCheckDebuff = "Debuff",
	nomCheckAoeDebuff = "AOE法術",
	nomCheckDebuffType = "Debuff類型",
	nomCheckEnchant = "武器強化",
	nomCheckCombo = "連擊點數",
	nomCheckSkill = "動作冷卻",
		
	nomCheckTarget = "敵方目標",
	nomCheckFriend = "友方目標",
	nomCheckParty = "團隊目標",
    nomCheckFocus = "焦點目標",
    nomCheckRaid = "團隊成員",
    nomCheckOptunitn = "特定成員",

	aideTarget = "此buff/debuff僅存在于敵方目標上",
	aideTargetFriend = "此buff/debuff僅存在于友方目標上",
	aideParty = "此buff/debuff僅存在于小隊中",
	aideFocus = "此buff/debuff僅存在焦點目標上",
	aideRaid = "此buff/debuff僅存在于團隊中",
	aideOptunitn = "此buff/debuff僅存在于團隊/小隊中的特定成員身上",
	
	nomCheckShowTimer = "顯示",
	nomTimerDuration = "延遲消失",
	aideTimerDuration = "目標上的buff/debuff計時器延遲到此時間結束後再消失(0爲禁用)",
	aideShowTimer = "爲此效果顯示計時器",
	aideSelectTimer = "選擇使用何種計時器來顯示持續時間",
	aideSelectTimerBuff = "選擇使用何種計時器來顯示持續時間(僅用于玩家buff)",
	aideSelectTimerDebuff = "選擇使用何種計時器來顯示持續時間(僅用于玩家debuff)",
	nomCheckInverse = "不存在時激活",
	aideInverse = "選中此項後,僅當buff/debuff不存在時顯示此特效",	
	nomCheckIgnoreMaj = "忽略大小寫",	
	aideIgnoreMaj = "選中此項將忽略buff/debuff名字的大小寫字母(供英文玩家使用,中國玩家不需要修改此項)",
	nomDuration = "延遲消失",
	aideDuration = "特效延遲到此時間結束後再消失(0爲禁用)",
	nomCentiemes = "顯示百分位",
	nomDual = "顯示兩個計時器",
	nomClose = "關閉",
	nomEffectEditor = "特效編輯器",
	nomAdvOptions = "選項",
	nomMaxTex = "最大可用材質",
	nomTabAnim = "動畫效果",
	nomTabActiv = "激活條件",
	nomWowTextures = "使用內置材質",
	nomCustomTextures = "使用自定義材質",
    nomRealaura = "清晰光環",
	nomRandomColor = "隨機顔色",
	nomTexMode = "光暈效果",
	nomInCombat = "戰鬥狀態",
	aideInCombat = "僅當你處于戰鬥狀態時才激活此特效",
	nomNotInCombat = "非戰鬥狀態",
	aideNotInCombat = "僅在非戰鬥狀態時才激活此特效",
	
	nomIsMounted = "Only if on mount.", -- untranslated
	aideIsMounted = "Show this effect only when you are on a mount.", -- untranslated
	nomIsInRaid = "Only if in raid", -- untranslated
	aideIsInRaid = "Show this effect only when you are in a raid." -- untranslated
};

else -- english

PowaAnim = {};
PowaAnim[0] = "[Invisible]";
PowaAnim[1] = "Static";
PowaAnim[2] = "Flashing";
PowaAnim[3] = "Growing";
PowaAnim[4] = "Pulse";
PowaAnim[5] = "Bubble";
PowaAnim[6] = "Water drop";
PowaAnim[7] = "Electric";
PowaAnim[8] = "Shrinking";
PowaAnim[9] = "Flame";
PowaAnim[10] = "Orbit";

PowaDisplay = {};
PowaDisplay[0] = "[None]";
PowaDisplay[1] = "Zoom In";
PowaDisplay[2] = "Zoom Out";
PowaDisplay[3] = "Opacity only";
PowaDisplay[4] = "Left";
PowaDisplay[5] = "Top-Left";
PowaDisplay[6] = "Top";
PowaDisplay[7] = "Top-Right";
PowaDisplay[8] = "Right";
PowaDisplay[9] = "Bottom-Right";
PowaDisplay[10] = "Bottom";
PowaDisplay[11] = "Bottom-Left";

PowaSound = {};
PowaSound[0] = "None";
PowaSound[1] = "LEVELUP";
PowaSound[2] = "LOOTWINDOWCOINSOUND";
PowaSound[3] = "MapPing";
PowaSound[4] = "Exploration";
PowaSound[5] = "QUESTADDED";
PowaSound[6] = "QUESTCOMPLETED";
PowaSound[7] = "WriteQuest";
PowaSound[8] = "Fishing Reel in";
PowaSound[9] = "igPVPUpdate";
PowaSound[10] = "ReadyCheck";
PowaSound[11] = "RaidWarning";
PowaSound[12] = "AuctionWindowOpen";
PowaSound[13] = "AuctionWindowClose";
PowaSound[14] = "TellMessage";
PowaSound[15] = "igBackPackOpen";

PowaStance = {};
PowaStance[0] = "-------------";
PowaStance[1] = "Battle Stance";
PowaStance[2] = "Defensive Stance";
PowaStance[3] = "Berserker Stance";

PowaText = {
	welcome = "Type /powa to view the options.",

	aucune = "None",
	aucun = "None",
	largeur = "Width",
	hauteur = "Height",
	mainHand = "main",
	offHand = "off",
	bothHands = "both",

	TypeMagic = "Magic",
	TypeDisease = "Disease",
	TypeCurse = "Curse",
	TypePoison = "Poison",

	-- main
	nomEnable = "Activate Power Auras",
	aideEnable = "Enable all Power Auras effects",
	nomDebug = "Activate Debug Messages",
	aideDebug = "Enable Debug Messages",
	ListePlayer = "Page",
	ListeGlobal = "Global",
	aideMove = "Move the effect here.",
	aideCopy = "Copy the effect here.",
	nomRename = "Rename",
	aideRename = "Rename the selected effect's page.",
	nomTest = "Test",
	nomHide = "Hide all",
	nomEdit = "Edit",
	nomNew = "New",
	nomDel = "Delete",
	aideDel = "Remove the selected effect (Hold CTRL to allow this button to work)",
	nomMove = "Move",
	nomCopy = "Copy",
	nomPlayerEffects = "Character effects",
	nomGlobalEffects = "Global\neffects",
	aideEffectTooltip = "(Shift-click to toggle effect ON or OFF)",

	-- editor
	nomSound = "Sound to play",
	aideSound = "Plays a sound at the beginning.",
	nomCustomSound = "OR soundfile:",
	aideCustomSound = "Enter a soundfile that is in the Sounds folder, BEFORE you started the game. mp3 and wav are supported. example: 'cookie.mp3' ;)",
	
	nomTexture = "Texture",
	aideTexture = "The texture to be shown. You can easily replace textures by changing the files Aura#.tga in the Addon's directory.",
	
	nomAnim1 = "Main Animation",
	nomAnim2 = "Secondary Animation",
	aideAnim1 = "Animate the texture or not, with various effects.",
	aideAnim2 = "This animation will be shown with less opacity than the main animaton. Attention, to not overload the screen, only a single secondary animation will be shown at the same time.",
	
	nomDeform = "Deformation",
	aideDeform = "Stretch the texture in height or in width.",
	
	aideColor = "Click here to change the color of the texture.",
	
	aideBuff = "Enter here the name of the buff, or a part of the name, which must activate/deactivate the effect. You can enter several names if they are decently separated (ex: Super Buff/Power)",
	aideBuff2 = "Enter here the name of the debuff, or a part of the name, which must activate/deactivate the effect. You can enter several names if they are decently separated (ex: Dark Disease/Plague)",
	aideBuff3 = "Enter here the type of the debuff which must activate or deactivate the effect (Poison, Disease, Curse, Magic or None). You can also enter several types of debuff.",
	aideBuff4 = "Enter here the name of area of effect that must trigger this effect (like a rain of fire for example, the name of this AOE can be found in the combat log)",
	aideBuff5 = "Enter here the weapon who must activate this effect : 'main', 'off' or 'both' for the 2 weapons.",
	aideBuff6 = "You can entrer here the numbers of combo points that must activate this effect (ex : 1 or 123 or 045 etc...) ",
	aideBuff7 = "Enter here the name, or a part of the name, of an action in your action bars. The effect will be active when this action is usable.",
	
	aideStacks = "Enter here the operator and the amount of stacks, which must activate/deactivate the effect. It works only with an operator! ex: '<5' or '>3' or '=11'",
	
	aideUnitn = "Enter here the name of the unit, which must activate/deactivate the effect. You can enter only names, if they are in your raid or group.",
    aideUnitn2 = "Only for raid/group.",    
    
	aideMaxTex = "Define the maximum number of textures available on the Effect Editor. If you add textures on the Mod directory (with the names AURA1.tga to AURA50.tga), you must indicate the correct number here.",
	aideAddEffect = "Add an effect for edition.",
	aideWowTextures = "Check this to use the texture of WoW instead of textures in the Power Auras directory for this effect.",
	aideCustomTextures = "Check this to use the textures in the 'Custom' subdirectory. You must put the name of the texture below (ex : myTexture.tga)",
	aideRealaura = "Real Aura",
    aideRandomColor = "Check this to tell this effect to use random color each time it will be activated.",
	aideTexMode = "Uncheck this to use the texture opacity. By default, the darkest colors will be more transparent.",
	
	
	nomActivationBy = "Activation by :",
	nomStacks = "Stacks",
	nomSpeed = "Animation speed",
	nomBegin = "Begin Animation",
	nomEnd = "End Animation",
	nomSymetrie = "Symmetry",
	nomAlpha = "Opacity",
	nomPos = "Position",
	nomTaille = "Size",
	nomExact = "Exact Name",
	nomGCD = "Global Cooldown",
	nomThreshold = "Threshold",
	nomStance = "Stance",
	
	nomCheckBuff = "Buff",
	nomCheckDebuff = "Debuff",
	nomCheckAoeDebuff = "AOE Debuff",
	nomCheckDebuffType = "Debuff's type",
	nomCheckEnchant = "Weapon Enchant",
	nomCheckCombo = "Combo Points",
	nomCheckSkill = "Action Usable",
	nomCheckHealth = "Health",
	nomCheckMana = "Mana",
	nomCheckStance = "Stance",
	
	nomCheckTarget = "Enemy Target",
	nomCheckFriend = "Friendly Target",
	nomCheckParty = "Partymember",
    nomCheckFocus = "Focus",
    nomCheckRaid = "Raidmember",
    nomCheckOptunitn = "Unitname",
	
	aideTarget = "Check this to test an enemy target only.",
	aideTargetFriend = "Check this to test a friendly target only.",
	aideParty = "Check this to test a party member only.",
	aideFocus = "Check this to test the focus only.",
	aideRaid = "Check this to test a raid member only.",
	aideOptunitn = "Check this to test a spezial char in raid/group only.",	
    aideExact = "Check this to test the exact name of the buff/debuff/action.",
	aideGCD = "Check this and the Global Cooldown triggers with 'action usable'. May cause blinking the aura, when an action only has a Global Cooldown.",
	aideStance = "Select which Stance,Aura or Form trigger the event.",
	
	nomCheckShowTimer = "Show",
	nomTimerDuration = "Duration",
	aideTimerDuration = "Show a timer to simulate buff/debuff duration on the target (0 to deactivate)",
	aideShowTimer = "Check this to show the timer of this effect.",
	aideSelectTimer = "Select which timer will show the duration",
	aideSelectTimerBuff = "Select which timer will show the duration (this one is reserved for player's buffs)",
	aideSelectTimerDebuff = "Select which timer will show the duration (this one is reserved for player's debuffs)",
	
	nomCheckInverse = "Show when not active",
	aideInverse = "Check this to show this effect only when buff/debuff is not active.",	
	
	nomCheckIgnoreMaj = "Ignore uppercase",	
	aideIgnoreMaj = "Check this to ignore upper/lowercase of buff/debuff names.",
	
	nomDuration = "Anim. duration",
	aideDuration = "After this time, this effect will disapear (0 to deactivate)",
	
	nomCentiemes = "Show hundredth",
	nomDual = "Show 2 timers",
	nomClose = "Close",
	nomEffectEditor = "Effect Editor",
	nomAdvOptions = "Options",
	nomMaxTex = "Maximum of textures available",
	nomTabAnim = "Animation",
	nomTabActiv = "Activation",
	nomTabSound = "Sound",
	nomTabTimer = "Timer",
	nomWowTextures = "WoW Textures",
	nomCustomTextures = "Custom Textures",
    nomRealaura = "Reale Aura",
	nomRandomColor = "Random Colors",
	nomTexMode = "Glow",
	nomInCombat = "Only if in combat",
	aideInCombat = "Show this effect only when you are in combat.",
	nomNotInCombat = "Only if not in combat",
	aideNotInCombat = "Show this effect only when you are NOT in combat.",
	nomIsMounted = "Only if on mount.",
	aideIsMounted = "Show this effect only when you are on a mount.",
	nomIsInRaid = "Only if in raid",
	aideIsInRaid = "Show this effect only when you are in a raid."
};

end

