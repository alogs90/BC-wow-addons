--[[
	WARNING: This is a generated file.
	If you wish to perform or update localizations, please go to our Localizer website at:
	http://localizer.norganna.org/

	AddOn: Enchantrix
	Revision: $Id: EnxStrings.lua 3481 2008-09-12 14:39:29Z anaral $
	Version: 5.0.0 (BillyGoat)

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]

EnchantrixLocalizations = {

	csCZ = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "Mažu všechna data o enchantech";
		["FrmtActClearFail"]	= "Nelze najít předmět: %s";
		["FrmtActClearOk"]	= "Smazána data k předmětu: %s";
		["FrmtActDefault"]	= "Nastavení Enchantrixu '%s' bylo vráceno na základní hodnotu.";
		["FrmtActDefaultAll"]	= "Všechna nastavení Enchantrixu byla vrácena na základní hodnoty.";
		["FrmtActDisable"]	= "Vypnuto zobrazování dat předmětů o: %s";
		["FrmtActEnable"]	= "Zapnuto zobrazování dat předmetů o: %s";
		["FrmtActSet"]	= "Nastavit %s na '%s'";
		["FrmtActUnknown"]	= "Neznámý příkaz: '%s'";
		["FrmtActUnknownLocale"]	= "Zvoleny jazyk ('%s') neni dostupny. Dostupne jsou: ";
		["FrmtPrintin"]	= "Enchantrix bude zpravy zobrazovat v okne: \"%s\"";
		["FrmtUsage"]	= "Pouzivani:";
		["MesgDisable"]	= "Vypinam automaticke spusteni Enchantrix";
		["MesgNotloaded"]	= "Enchantrix neni spusten. Napis /enchantrix a dozvis se vic.";

		-- Section: Command Options
		["CmdClearAll"]	= "vse";
		["OptClear"]	= "([Objekt]|vse)";
		["OptDefault"]	= "(<nastaveni>|vse)";
		["OptFindBidauct"]	= "<stribro>";
		["OptFindBuyauct"]	= "<procent>";
		["OptLocale"]	= "<jazyk>";
		["OptPrintin"]	= "(<frameIndex>[Number]|<frameName>[String])";

		-- Section: Commands
		["CmdClear"]	= "smazat";
		["CmdDefault"]	= "vychozi";
		["CmdDisable"]	= "vypnout";
		["CmdFindBidauct"]	= "bidbroker";
		["CmdFindBidauctShort"]	= "bb";
		["CmdFindBuyauct"]	= "procent-mene";
		["CmdFindBuyauctShort"]	= "pm";
		["CmdHelp"]	= "pomoc";
		["CmdLocale"]	= "jazyk";
		["CmdOff"]	= "vyp";
		["CmdOn"]	= "zap";
		["CmdPrintin"]	= "zobraz-v";
		["CmdToggle"]	= "prepnout";
		["ShowEmbed"]	= "integrace";
		["ShowGuessAuctioneerHsp"]	= "urcit-nuc";
		["ShowGuessAuctioneerMed"]	= "urcit-stred";
		["ShowGuessBaseline"]	= "urcit-zaklad";
		["ShowTerse"]	= "strucne";
		["ShowValue"]	= "ohodnotit";
		["StatOff"]	= "Nejsou zobrazována žádná Enchant data";
		["StatOn"]	= "Jsou zobrazována vybraná Enchant data";

		-- Section: Config Text
		["GuiLoad"]	= "Spustit Enchantrix";
		["GuiLoad_Always"]	= "vzdy";
		["GuiLoad_Never"]	= "nikdy";

		-- Section: Game Constants
		["ArgSpellname"]	= "Disenchant";
		["PatReagents"]	= "Materiály: (.+)";
		["TextCombat"]	= "Boj";
		["TextGeneral"]	= "Obecne";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(navštiv http://enchantrix.org/ a poděl se o svá data)";
		["FrmtWelcome"]	= "Enchantrix v%s spuštěna";
		["MesgAuctVersion"]	= "Enchantrix potřebuje Auctioneer od verze 3.4. Dokud neprovedeš update své instalace Auctioneer, tvá Enchantrix nebude umět některé věci.";

		-- Section: Help Text
		["GuiClearall"]	= "Smazat všechna data Enchantrix";
		["GuiClearallButton"]	= "Smazat vše";
		["GuiClearallHelp"]	= "Klikni zde a smažou se všechny záznamy Enchantrix pro tento server";
		["GuiClearallNote"]	= "pro tento server a stranu";
		["GuiDefaultAll"]	= "Obnov všechna nastavení Enchantrix na základní hodnoty";
		["GuiDefaultAllButton"]	= "Obnovit vše";
		["GuiDefaultAllHelp"]	= "Klikni zde pro obnoveni vsech nastavení Enchantrix na základní hodnoty. POZOR: Všechny změny nastavení budou ztraceny";
		["GuiDefaultOption"]	= "Obnov toto nastavení";
		["GuiEmbed"]	= "Vkládat informace do nápovědy";
		["GuiLocale"]	= "Nastav jazyk na";
		["GuiMainEnable"]	= "Aktivovat Enchantrix";
		["GuiMainHelp"]	= "Obsahuje nastaveni Enchantrixu, AddOnu zobrazujího v nápovědách informace o zisku při provedení \"Disenchant\" na daný předmět.";
		["GuiOtherHeader"]	= "Dalsi moznosti";
		["GuiOtherHelp"]	= "Ruzne Enchantrix moznosti";
		["GuiPrintin"]	= "Vyber si textove okno";
		["GuiTerse"]	= "Nastavit stručné zobrazení";
		["GuiValuateAverages"]	= "Ohodnocovat podle průměrných hodnot od Auctioneer-a";
		["GuiValuateBaseline"]	= "Ohodnocovat podle vlastních dat";
		["GuiValuateEnable"]	= "Zapnout ohodnocování";
		["GuiValuateHeader"]	= "Ohodnocování";
		["GuiValuateMedian"]	= "Ohodnocovat podle mediánů od Auctioneer-a";
		["HelpClear"]	= "Smazat data k urcenemu objektu (shift - klikem ho vlozite do prikazu, nebo pouzijte urceni \"vse\" nebo \"all\")";
		["HelpDefault"]	= "Vrati urcene Enchantrix nastaveni na vychozi. Take lze pouzit urceni \"vse\" nebo \"all\" pro navrat vsech nastaveni na vychozi.";
		["HelpDisable"]	= "Deaktivuje automaticke zapinani Enchantrixu pri vstupu do hry";
		["HelpEmbed"]	= "Vkládat informace do nápověd(pozor: nektere funkce nejsou v tomto rezimu dostupne)";
		["HelpFindBidauct"]	= "Najde aukce u nichz je odhadovany zisk z \"Disenchant\" o urcenou sumu stribra vyssi nez momentalni naBIDka";
		["HelpFindBuyauct"]	= "Najde aukce u nichz je odhadovany zisk z \"Disenchant\" o urcenou sumu stribra vyssi nez Vykupni cena";
		["HelpGuessAuctioneerHsp"]	= "Je-li Ohodnocovani zapnuto a je-li instalovan Auctioneer - zobrazi Ohodnoceni podle Nejvyssi Uspesne Ceny (NUC) odhadovaného zisku z \"Disenchant\". ";
		["HelpGuessAuctioneerMedian"]	= "Je-li Ohodnocovani zapnuto a je-li instalovan Auctioneer - zobrazi Ohodnoceni podle mediánu odhadovaného zisku z \"Disenchant\".";
		["HelpGuessBaseline"]	= "Je-li Ohodnocovani zapnuto (a Auctioneer neni zapotrebi) - zobrazi jednoduche Ohodnoceni podle vlastních tabulek odhadovaného zisku z \"Disenchant\".";
		["HelpGuessNoauctioneer"]	= "Ohodnocování NUC nebo mediánem nejsou k dispozici protoze nemas instalovany Auctioneer. ";
		["HelpLoad"]	= "Nastavi spousteni Enchantrix pro tuto postavu";
		["HelpLocale"]	= "Nastavi jazyk Enchantrix zprav";
		["HelpOnoff"]	= "Nastavi zda se maji zobrazovat informace o ocarovani predmetu";
		["HelpPrintin"]	= "Nastavi v kterem okne ma Enchantrix zobrazovat zpravy. Muzete zvolit nazev okna nebo jeho index.";
		["HelpTerse"]	= "Přepínač stručného zobrazení, kdy se ukazuje pouze hodnota \"Disenchant\". Dá se obejít podržením \"Control\".";
		["HelpValue"]	= "Nastavi zda se ma zobrazovat odhadovaný zisk z \"Disenchant\" daného předmětu";

		-- Section: Report Messages
		["FrmtBidbrokerCurbid"]	= "soucBid";
		["FrmtBidbrokerDone"]	= "Prihazovani dokonceno";
		["FrmtBidbrokerHeader"]	= "Nabidky usetri %s stribra na prumerne hodnote odcarovani:";
		["FrmtBidbrokerLine"]	= "%s, Hodnota na: %s, %s: %s, Usetrit: %s, Mene %s, Cas: %s";
		["FrmtBidbrokerMinbid"]	= "minBid";
		["FrmtBidBrokerSkipped"]	= "Celkem %d aukcí vynecháno pro nedostatečný percentuální zisk (%d%%)";
		["FrmtPctlessDone"]	= "Procentuelni snizeni hotovo.";
		["FrmtPctlessHeader"]	= "Vykupy usetri %d%% oproti prumerne hodnote odcarovani:";
		["FrmtPctlessLine"]	= "%s, Hodnota na: %s, Vykup: %s, Usetrit: %s, Mene %s";
		["FrmtPctlessSkipped"]	= "Celkem %d aukcí vynecháno pro nedostatečný peněžní zisk (%s)";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Cena do chatu (%d %% zisk)";
		["FrmtDisinto"]	= "Disenchant získá: ";
		["FrmtFound"]	= "Zaznamenáno, že disenchant na %s získá:";
		["FrmtPriceEach"]	= "(%s za kus)";
		["FrmtSuggestedPrice"]	= "Doporučená cena:";
		["FrmtTotal"]	= "Celkem";
		["FrmtValueAuctHsp"]	= "Prodejní cena získaná Disenchantem (NUC)";
		["FrmtValueAuctMed"]	= "Střední cena získaná Disenchantem (StredniCena)";
		["FrmtValueMarket"]	= "Základní cena získaná Disenchantem (ZakladniCena)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer nebyl nahrán, budu používat uložené ceny]";
		["FrmtWarnNoPrices"]	= "[Ceny nejsou dostupne]";
		["FrmtWarnPriceUnavail"]	= "[Nektere ceny nedostupne]";

	};

	daDK = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "Nulstiller al Enchant data";
		["FrmtActClearFail"]	= "Kan ikke finde item: %s";
		["FrmtActClearOk"]	= "Data nulstillet for item: %s";
		["FrmtActDefault"]	= "Enchantrix's %s indstilling er blevet nulstillet";
		["FrmtActDefaultAll"]	= "Alle Enchantrix indstillinger er blevet gensat til normal";
		["FrmtActDisable"]	= "Viser ikke item's %s data";
		["FrmtActEnable"]	= "Viser item's %s data";
		["FrmtActSet"]	= "Sæt %s til '%s'";
		["FrmtActUnknown"]	= "Ukendt kommando nøgleord: '%s'";
		["FrmtActUnknownLocale"]	= "Sproget du har valgt ('%s') er ukendt. Tilladte sprog er:";
		["FrmtPrintin"]	= "Encantrix's beskeder vil nu vises i \"%s\" chat rammen";
		["FrmtUsage"]	= "Brug:";
		["MesgDisable"]	= "Slår automatisk loading af Enchantrix fra";
		["MesgNotloaded"]	= "Enchantrix er ikke indlæst. Skriv /enchantrix for mere information";

		-- Section: Command Options
		["CmdClearAll"]	= "alt";
		["OptClear"]	= "([Item]alt)";
		["OptDefault"]	= "(<option>|alt)";
		["OptFindBidauct"]	= "<sølv>";
		["OptFindBuyauct"]	= "<procent>";
		["OptLocale"]	= "<sprog>";
		["OptPrintin"]	= "(<index>[Nummer]<rammenavn>[Streng])";

		-- Section: Commands
		["CmdClear"]	= "slet";
		["CmdDefault"]	= "standard";
		["CmdDisable"]	= "deaktiver";
		["CmdFindBidauct"]	= "bidbroker";
		["CmdFindBidauctShort"]	= "bb";
		["CmdFindBuyauct"]	= "procentunder";
		["CmdFindBuyauctShort"]	= "pu";
		["CmdHelp"]	= "hjælp";
		["CmdLocale"]	= "sprog";
		["CmdOff"]	= "fra";
		["CmdOn"]	= "til";
		["CmdPrintin"]	= "skriv-i";
		["CmdToggle"]	= "skift";
		["ShowEmbed"]	= "integreret";
		["ShowGuessAuctioneerHsp"]	= "evaluer-hsp";
		["ShowGuessAuctioneerMed"]	= "evaluer-middel";
		["ShowGuessBaseline"]	= "evaluer-baseværdi";
		["ShowTerse"]	= "conciso";
		["ShowValue"]	= "Evaluer";
		["StatOff"]	= "Viser ingen enchant data";
		["StatOn"]	= "Viser konfigureret enchant data";

		-- Section: Config Text
		["GuiLoad"]	= "Load Auctioneer";
		["GuiLoad_Always"]	= "altid";
		["GuiLoad_Never"]	= "aldrig";

		-- Section: Game Constants
		["ArgSpellname"]	= "Disenchant";
		["PatReagents"]	= "Ingredienser: (.+)";
		["TextCombat"]	= "Kamp";
		["TextGeneral"]	= "Generelt";

		-- Section: Generic Messages
		["FrmtCredit"]	= "Gå til http://enchantrix.org/ for at dele dine data";
		["FrmtWelcome"]	= "Enchantrix v%s læst ind";
		["MesgAuctVersion"]	= "Enchantix kræver Auctioneer version 3.4 eller højere. Nogle muligheder vil være utilgængelige indtil du opdatere din Auctioneer installation.";

		-- Section: Help Text
		["GuiClearall"]	= "Slet alle Enchantrix data";
		["GuiClearallButton"]	= "Slet alt";
		["GuiClearallHelp"]	= "Klik her for at slette alle Enchantrix data for den aktuelle server.";
		["GuiClearallNote"]	= "for den aktuelle server/faktion";
		["GuiDefaultAll"]	= "Nulstil alle Enchantrix valg";
		["GuiDefaultAllButton"]	= "Nulstil alt";
		["GuiDefaultAllHelp"]	= "Klik her for at sætte alle Enchantrix options til deres standard værdi. ADVARSEL. Dette kan IKKE fortrydes.";
		["GuiDefaultOption"]	= "Nulstil denne værdi";
		["GuiEmbed"]	= "Vis indlejrede information i spillets tooltip";
		["GuiLocale"]	= "Sæt sprog til";
		["GuiMainEnable"]	= "Aktiver Enchantrix";
		["GuiMainHelp"]	= "Indeholder værdier for Enchantrix et Add-On som viser information om hvad en ting bliver til ved disenchant.";
		["GuiOtherHeader"]	= "Andre valg";
		["GuiOtherHelp"]	= "Diverse Enchantrix valg";
		["GuiPrintin"]	= "Vælg den ønskede meddelelses frame";
		["GuiTerse"]	= "Aktiver kortfattet indstilling";
		["GuiValuateAverages"]	= "Evaluer mod Auctioneer gennemsnit";
		["GuiValuateBaseline"]	= "Evaluer mod standard data";
		["GuiValuateEnable"]	= "Aktiver Evaluering";
		["GuiValuateHeader"]	= "Evaluering";
		["GuiValuateMedian"]	= "Evaluer mod Auctioneer middel";
		["HelpClear"]	= "Slet det valgte item data (du skal shift-klikke item ind i kommandoen). Du kan ogsÃ¥ angive all for at slette alt.";
		["HelpDefault"]	= "Sæt et Enchantrix valg til dets standard vÃ¦rdi. Du kan også angive all for at sætte alle valg til deres standard værdi.";
		["HelpDisable"]	= "Undlader at loade Enchantrix automatisk næste gang du logger ind.";
		["HelpEmbed"]	= "Indlejrer teksten i spillets egne tooltip (BemÃ¦rk: Visse valg kan ikke bruges sammen med dette)";
		["HelpFindBidauct"]	= "Find auktioner hvis potentielle disenchant værdi er et vist sølvbeløb mindre end bud prisen.";
		["HelpFindBuyauct"]	= "Find auktioner hvis potentielle disenchant værdi er vis procent værdi mindre end bud prisen.";
		["HelpGuessAuctioneerHsp"]	= "Hvis Evaluer er slået til og du har Auctioneer installeret, vis salgspris (HSP) vurderingen af at disenchante tingen.";
		["HelpGuessAuctioneerMedian"]	= "Hvis Evaluer er slået til og du har Auctioneer installeret, vis middel værdien af at disenchante tingen.";
		["HelpGuessBaseline"]	= "Hvis Evaluer er slået til (Auctioneer er ikke nødvendig) vis base værdien af at disenchante ting. Baseret på de indbyggede priser.";
		["HelpGuessNoauctioneer"]	= "Kommandoerne evaluer-hsp og evaluer-middel er ikke tilgængelige fordi du ikke har Auctioneer installeret.";
		["HelpLoad"]	= "Ændre Enchantrix load indstillinger for denne karakter";
		["HelpLocale"]	= "Ændrer sproget som bruges til at vises Enchantrix meddelelser";
		["HelpOnoff"]	= "Skifter mellem om enchant data vises eller ej.";
		["HelpPrintin"]	= "Vælg hvilken ramme Enchantrix viser sine meddelelser i.\nDu kan enten angive navnet eller nummeret.";
		["HelpTerse"]	= "Aktiver/deaktiver kortfattet indstilling. Viser kun disenchant værdi. Kan tilsidesættes ved at holde control-tasten nede.";
		["HelpValue"]	= "Vælg om tingens værdi baseret pÃ udfaldet af mulige disenchants skal vises.";

		-- Section: Report Messages
		["FrmtBidbrokerCurbid"]	= "BudNu";
		["FrmtBidbrokerDone"]	= "Gennemløb for lave priser udført.";
		["FrmtBidbrokerHeader"]	= "Auktioner som har %s sølv besparelse baseret på gennemsnitlig disenchant værdi. (min %%mindre = %d): ";
		["FrmtBidbrokerLine"]	= "%s, Vurderet til: %s, %s: %s. Besparelse: %s, Under %s, Tid: %s";
		["FrmtBidbrokerMinbid"]	= "BudMin";
		["FrmtBidBrokerSkipped"]	= "Sprang %d auktioner over, pga. for lille profit margin. (%d%%) ";
		["FrmtPctlessDone"]	= "Bud under gennemfÃ¸rt.";
		["FrmtPctlessHeader"]	= "Buyouts som har %d%% besparelse i forhold til gennemsnitlige disenchant værdi:";
		["FrmtPctlessLine"]	= "%s, vurderet til: %s, BO: %s, spar: %d, %s under.";
		["FrmtPctlessSkipped"]	= "Sprang %d auktioner over, pga. for lille profit mulighed. (%s) ";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Udråbspris (%d%% margen)";
		["FrmtDisinto"]	= "Disenchants til:";
		["FrmtFound"]	= "Fandt at %s disenchants til:";
		["FrmtPriceEach"]	= "(%s/stk.)";
		["FrmtSuggestedPrice"]	= "Anbefalet pris:";
		["FrmtTotal"]	= "I alt";
		["FrmtValueAuctHsp"]	= "Disenchant værdi (HSP)";
		["FrmtValueAuctMed"]	= "Disenchant værdi (Middel)";
		["FrmtValueMarket"]	= "Disenchant værdi (Base)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer ikke indlæst, bruger priser fra cachen]";
		["FrmtWarnNoPrices"]	= "[Ingen priser er tilgængelige]";
		["FrmtWarnPriceUnavail"]	= "[Nogen af priserne er ikke tilgængelige]";

	};

	deDE = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "Lösche alle Entzauberungsdaten";
		["FrmtActClearFail"]	= "Kann Gegenstand %s nicht finden";
		["FrmtActClearOk"]	= "Daten für Gegenstand %s gelöscht";
		["FrmtActDefault"]	= "Die Enchantrix-Option '%s' wurde auf den Standardwert zurückgesetzt.";
		["FrmtActDefaultAll"]	= "Alle Enchantrix-Optionen wurden auf die Standardwerte zurückgesetzt.";
		["FrmtActDisable"]	= "Zeige keine Daten von Gegenstand %s";
		["FrmtActEnable"]	= "Zeige Daten von Gegenstand %s";
		["FrmtActSet"]	= "Setze %s zu '%s'";
		["FrmtActUnknown"]	= "Unbekannter Befehl: '%s'";
		["FrmtActUnknownLocale"]	= "Das angegebene Gebietsschema ('%s') ist unbekannt. Gültige Gebietsschemata sind:";
		["FrmtPrintin"]	= "Die Enchantrix-Meldungen werden nun im Chat-Fenster \"%s\" angezeigt";
		["FrmtUsage"]	= "Syntax:";
		["MesgDisable"]	= "Das automatische Laden von Enchantrix wird deaktiviert";
		["MesgNotloaded"]	= "Enchantrix ist nicht geladen. Geben Sie /enchantrix ein um mehr Informationen zu erhalten.";

		-- Section: Command Options
		["CmdClearAll"]	= "all";
		["OptClear"]	= "([Gegenstand]|all)";
		["OptDefault"]	= "(<Option>|all)";
		["OptFindBidauct"]	= "<Silber>";
		["OptFindBuyauct"]	= "<Prozent>";
		["OptLocale"]	= "<Sprache>";
		["OptPrintin"]	= "(<Fenster-Index>[Nummer]|<Fenster-Name>[String])";

		-- Section: Commands
		["CmdClear"]	= "clear";
		["CmdDefault"]	= "default";
		["CmdDisable"]	= "disable";
		["CmdFindBidauct"]	= "bidbroker";
		["CmdFindBidauctShort"]	= "bb";
		["CmdFindBuyauct"]	= "percentless";
		["CmdFindBuyauctShort"]	= "pl";
		["CmdHelp"]	= "help";
		["CmdLocale"]	= "locale";
		["CmdOff"]	= "off";
		["CmdOn"]	= "on";
		["CmdPrintin"]	= "print-in";
		["CmdToggle"]	= "toggle";
		["ShowDELevels"]	= "skill";
		["ShowDEMaterials"]	= "material";
		["ShowEmbed"]	= "embed";
		["ShowGuessAuctioneerHsp"]	= "valuate-hsp";
		["ShowGuessAuctioneerMed"]	= "valuate-median";
		["ShowGuessAuctioneerVal"]	= "valuate-val";
		["ShowGuessBaseline"]	= "valuate-baseline";
		["ShowTerse"]	= "kurz";
		["ShowUI"]	= "zeigen";
		["ShowValue"]	= "valuate";
		["StatOff"]	= "Die Anzeige von Entzauberungsdaten wurde deaktiviert";
		["StatOn"]	= "Die Anzeige von Entzauberungsdaten wurde aktiviert";

		-- Section: Config Text
		["GuiLoad"]	= "Enchantrix laden";
		["GuiLoad_Always"]	= "immer";
		["GuiLoad_Never"]	= "nie";

		-- Section: Game Constants
		["ArgSpellname"]	= "Entzaubern";
		["ArgSpellProspectingName"]	= "Sondieren";
		["Enchanting"]	= "Verzauberkunst";
		["Jewelcrafting"]	= "Juwelenschleifen";
		["PatReagents"]	= "Reagenzien: (.+)";
		["TextCombat"]	= "Kampflog";
		["TextGeneral"]	= "Allgemein";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(besuche http://enchantrix.org/ um deine Entzauberdaten mit anderen zu teilen)";
		["FrmtWelcome"]	= "Enchantrix v%s geladen";
		["MesgAuctVersion"]	= "Enchantrix benötigt Auctioneer Version 3.4 oder höher. Einige Funktionen werden nicht verfügbar sein, bis Sie ihre Auctioneer Version aktualisieren.";

		-- Section: Help Text
		["GuiClearall"]	= "Alle Enchantrix-Daten löschen";
		["GuiClearallButton"]	= "Alles löschen";
		["GuiClearallHelp"]	= "Hier klicken um alle Enchantrix-Daten auf dem aktuellen Realm zu löschen.";
		["GuiClearallNote"]	= "der aktuellen Fraktion auf dem aktuellen Realm";
		["GuiDefaultAll"]	= "Alle Einstellungen zurücksetzen";
		["GuiDefaultAllButton"]	= "Zurücksetzen";
		["GuiDefaultAllHelp"]	= "Hier klicken um alle Enchantrix-Optionen auf ihren Standardwert zu setzen.\nWARNUNG: Dieser Vorgang kann NICHT rückgängig gemacht werden.";
		["GuiDefaultOption"]	= "Zurücksetzen folgender Einstellung";
		["GuiDELevels"]	= "Zeige den notwendigen Entzauberungsskill im Tooltip an";
		["GuiDEMaterials"]	= "Zeige notwendiges Entzauberungsmaterial im Tooltip an";
		["GuiEmbed"]	= "In-Game Tooltip zur Anzeige verwenden";
		["GuiLocale"]	= "Setze das Gebietsschema auf";
		["GuiMainEnable"]	= "Enchantrix aktivieren";
		["GuiMainHelp"]	= "Einstellungen für Enchantrix - ein AddOn, das Informationen über die möglichen Entzauberungen eines Gegenstands als Tooltip anzeigt.";
		["GuiOtherHeader"]	= "Sonstige Optionen";
		["GuiOtherHelp"]	= "Sonstige Enchantrix-Optionen";
		["GuiPrintin"]	= "Fenster für Meldungen auswählen";
		["GuiTerse"]	= "Kurzinfo-Modus aktivieren";
		["GuiValuateAverages"]	= "Verkaufspreis anzeigen (Auctioneer Durchschnittswerte)";
		["GuiValuateBaseline"]	= "Verkaufspreis anzeigen (Interne Preisliste)";
		["GuiValuateEnable"]	= "Wertschätzung aktivieren";
		["GuiValuateHeader"]	= "Wertschätzung";
		["GuiValuateMedian"]	= "Ermitteln von Durchschnittspreisen (Auctioneer Median)";
		["HelpClear"]	= "Lösche die Daten des angegebenen Gegenstands (Gegenstände müssen mit Shift-Klick einfügt werden). Mit dem Schlüsselwort \"all\" werden alle Daten gelöscht.";
		["HelpDefault"]	= "Setzt die angegebene Enchantrix-Option auf ihren Standardwert zurück. Mit dem Schlüsselwort \"all\" werden alle Enchantrix-Optionen zurückgesetzt.";
		["HelpDisable"]	= "Verhindert das automatische Laden von Enchantrix beim Login";
		["HelpEmbed"]	= "Zeige den Text im In-Game Tooltip \n(Hinweis: Einige Funktionen stehen dann nicht zur Verfügung)";
		["HelpFindBidauct"]	= "Suche Auktionen deren Entzauberungswert einen bestimmten Betrag (in Silber) unter dem Gebotspreis liegt";
		["HelpFindBuyauct"]	= "Suche Auktionen deren Entzauberungswert einen bestimmten Prozentsatz unter dem Sofortkaufpreis liegt";
		["HelpGuessAuctioneer5Val"]	= "Wenn die Wertschätzung aktiviert und Auctioneer installiert ist, zeige den Marktwert (Auctioneer-Marktwert) für das Entzaubern";
		["HelpGuessAuctioneerHsp"]	= "Wenn die Wertschätzung aktiviert und Auctioneer installiert ist, zeige den maximalen Verkaufspreis (Auctioneer-HVP) für das Entzaubern";
		["HelpGuessAuctioneerMedian"]	= "Wenn die Wertschätzung aktiviert und Auctioneer installiert ist, zeige den durchschnittlichen Verkaufspreis (Auctioneer-MEDIAN) für das Entzaubern";
		["HelpGuessBaseline"]	= "Wenn die Wertschätzung aktiviert ist, zeige den Marktpreis aus der internen Preisliste (Auctioneer wird nicht benötigt)";
		["HelpGuessNoauctioneer"]	= "Die Befehle \"valuate-hsp\" und \"valuate-median\" sind nicht verfügbar weil Auctioneer nicht installiert ist";
		["HelpLoad"]	= "Ladeverhalten von Enchantrix für diesen Charakter ändern";
		["HelpLocale"]	= "Ändern des Gebietsschemas das zur Anzeige \nvon Enchantrix-Meldungen verwendet wird";
		["HelpOnoff"]	= "Schaltet die Anzeige von Entzauberungsdaten ein oder aus";
		["HelpPrintin"]	= "Auswählen in welchem Fenster die Enchantrix-Meldungen angezeigt werden. Es kann entweder der Fensterindex oder der Fenstername angegeben werden.";
		["HelpShowDELevels"]	= "Auswählen ob der notwendige Verzauberungsskill für das Entzaubern der Items im Tooltip angezeigt werden soll.";
		["HelpShowDEMaterials"]	= "Auswählen ob das mögliche Material aus der Entzauberung der Items im Tooltip angezeigt werden soll.";
		["HelpShowUI"]	= "Anzeigen oder verstecken der Einstellungskonsole.";
		["HelpTerse"]	= "Aktivieren/Deaktivieren des Kurzinfo-Modus, bei dem nur der Entzauberungswert angezeigt wird. Durch drücken der STRG-Taste werden in diesem Modus alle Infos gezeigt.";
		["HelpValue"]	= "Auswählen ob geschätzte Verkaufspreise aufgrund \nder Anteile an möglichen Entzauberungen angezeigt werden";

		-- Section: Report Messages
		["AuctionScanAuctNotInstalled"]	= "Du hast Auctioneer nicht installiert. Auctioneer muss installiert sein um einen Auktionenscan durchzuführen.";
		["AuctionScanVersionTooOld"]	= "Deine Auctioneerversion ist veraltet, für diese Aktion wird Auctioneer v4.0 oder später benötigt.";
		["ChatDeletedProfile"]	= "Profil gelöscht:";
		["ChatResetProfile"]	= "Einstellungen zurückgesetzt für:";
		["ChatSavedProfile"]	= "Profil gespeichert:";
		["ChatUsingProfile"]	= "Aktuell verwendetes Profil:";
		["FrmtAutoDeActive"]	= "Autom. Entzaubern aktiv";
		["FrmtAutoDeDisabled"]	= "Autom. Entzaubern deaktiviert";
		["FrmtAutoDeDisenchantCancelled"]	= "Entzaubern abgebrochen: Item nicht gefunden";
		["FrmtAutoDeDisenchanting"]	= "Entzaubere %s";
		["FrmtAutoDeIgnorePermanent"]	= "Ignoriere %s permanent";
		["FrmtAutoDeIgnoreSession"]	= "Ignoriere %s diese Sitzung";
		["FrmtAutoDeInactive"]	= "Autom. Entzaubern nicht aktiv";
		["FrmtAutoDeProspectCancelled"]	= "Sondieren abgebrochen: item nicht gefunden";
		["FrmtAutoDeProspecting"]	= "sondieren von %s";
		["FrmtBidbrokerCurbid"]	= "aktGeb";
		["FrmtBidbrokerDone"]	= "Die Auktionssuche (Betrag unter Gebotspreis) ist abgeschlossen.";
		["FrmtBidbrokerHeader"]	= "Auktionen mit %s Silber Einsparung auf den durchschnittlichen Entzauberungswert:";
		["FrmtBidbrokerLine"]	= "%s, Wert bei: %s, %s: %s, Ersparnis: %s, %s weniger, Zeit: %s";
		["FrmtBidbrokerMinbid"]	= "minGeb";
		["FrmtBidBrokerSkipped"]	= "%d Auktionen übersprungen da Gewinnspanne von (%d%%) unterschritten";
		["FrmtBidBrokerSkippedBids"]	= "%d Auktionen übersprungen, da aktuelle Gebote vorliegen";
		["FrmtPctlessDone"]	= "Die Auktionssuche (Prozent unter Sofortkauf) ist abgeschlossen.";
		["FrmtPctlessHeader"]	= "Sofortkauf-Auktionen mit %d%% Einsparung auf durchschnittlichen Entzauberungswert:";
		["FrmtPctlessLine"]	= "%s, Wert bei: %s, SK: %s, Ersparnis: %s, %s weniger";
		["FrmtPctlessSkillSkipped"]	= "%d Auktionen übersprungen, da Skilllevel von (%s) unterschritten";
		["FrmtPctlessSkipped"]	= "%d Auktionen übersprungen, da Gewinngrenze von (%s) Prozent unterschritten";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Barker Preis (%d%% Gewinn)";
		["FrmtDisinto"]	= "Mögliche Entzauberung zu:";
		["FrmtFound"]	= "%s wird entzaubert zu:";
		["FrmtFoundNotDisenchant"]	= "%s kann nicht entzaubert werden";
		["FrmtPriceEach"]	= "(%s/stk)";
		["FrmtProspectFound"]	= "%s wird sondiert zu:";
		["FrmtProspectInto"]	= "Mögliche Sondierung zu:";
		["FrmtProspectValueAuctHsp"]	= "Sondierungswert (HVP)";
		["FrmtProspectValueAuctMed"]	= "Sondierungswert (Median)";
		["FrmtProspectValueAuctVal"]	= "Sondierungswert (AucAdv)";
		["FrmtProspectValueMarket"]	= "Sondierungswert (Marktpreis)";
		["FrmtSuggestedPrice"]	= "vorgeschlagener Preis";
		["FrmtTotal"]	= "Gesamtsumme";
		["FrmtValueAuctHsp"]	= "Entzauberungswert (HVP)";
		["FrmtValueAuctMed"]	= "Entzauberungswert (Median)";
		["FrmtValueAuctVal"]	= "Entzauberungswert (AucAdv)";
		["FrmtValueFixedVal"]	= "Entzauberungswert (Fixiert)";
		["FrmtValueMarket"]	= "Entzauberungswert (Marktpreis)";
		["FrmtWarnAuctNotLoaded"]	= "Auktionstool nicht geladen, es werden gespeicherte Preise benutzt";
		["FrmtWarnNoPrices"]	= "Keine Preise verfügbar";
		["FrmtWarnPriceUnavail"]	= "Einige Preise nicht verfügbar";
		["TooltipProspectLevel"]	= "Sondieren erfordert Skill %d";
		["TooltipShowDisenchantLevel"]	= "Entzaubern erfordert Skill %d";

		-- Section: User Interface
		["ExportPriceAucAdv"]	= "Exportiere Enchantrix-Preise nach AuctioneerAdvanced";
		["GuiActivateProfile"]	= "Aktiviere ein vorhandenes Profil";
		["GuiAutoDeEnable"]	= "Suche nach entzauberbaren Items in Taschen - VORSICHTIG VERWENDEN";
		["GuiAutoDeOptions"]	= "Automatisierung";
		["GuiAutoDePromptLine1"]	= "Willst Du dies entzaubern:";
		["GuiAutoDePromptLine3"]	= "Bewertet um %s";
		["GuiAutoProspectPromptLine1"]	= "Willst Du dies sondieren:";
		["GuiBBUnbiddedOnly"]	= "Limitiere BidBroker auf Items ohne Gebote";
		["GuiConfigProfiles"]	= "Erstelle, konfiguriere und editiere Profile";
		["GuiCreateReplaceProfile"]	= "Erstelle oder ersetze ein Profil";
		["GuiDefaultBBProfitPercent"]	= "Standardprofitwert für BidBroker in Prozent: %d";
		["GuiDefaultLessHSP"]	= "Standardprozentwert unter HVP: %d";
		["GuiDefaultProfitMargin"]	= "Standard Profitgewinn:";
		["GuiDeleteProfileButton"]	= "Löschen";
		["GuiFixedSettings"]	= "Standard Reagenzpreise";
		["GuiFixedSettingsNote"]	= "Hinweis: Diese Werte werden anstelle vom Auctioneer oder von allen anderen Schätzungsmethoden verwendet, wenn die Checkbox aktiviert wird. Die folgenden Werte werden noch durch die Reagenzgewichtung im vorhergehenden Abschnitt beeinflußt. Um sicher zu stellen, dass die Reagenz genau anhand der unten spezifizierten Menge bewertet wird, muss die Gewichtung im Gewichtungsabschnitt auf 100% eingestellt sein.";
		["GuiGeneralOptions"]	= "Allgemeine Enchantrix Optionen";
		["GuiIgnore"]	= "Ignorieren";
		["GuiItemValueAuc4HSP"]	= "Auc4 HVP";
		["GuiItemValueAuc4Median"]	= "Auc4 Median";
		["GuiItemValueAuc5Appraiser"]	= "AucAdv Appraiser Wert";
		["GuiItemValueAuc5Market"]	= "AucAdv Marktwert";
		["GuiItemValueAverage"]	= "Durchschnitt (Standard)";
		["GuiItemValueBaseline"]	= "Marktgrundwert";
		["GuiItemValueCalc"]	= "Itemwert kalkuliert von";
		["GuiMaxBuyout"]	= "Maximaler Sofortkaufspreis";
		["GuiMinBBProfitPercent"]	= "Minimaler Profitwert für Bidbroker in Prozent: %d";
		["GuiMinimapButtonAngle"]	= "Buttonposition: %d";
		["GuiMinimapButtonDist"]	= "Distanz: %d";
		["GuiMinimapOptions"]	= "Minimapanzeige Optionen";
		["GuiMinimapShowButton"]	= "Minimapbutton anzeigen";
		["GuiMinLessHSP"]	= "Mindestprozentwert unter HVP: %d";
		["GuiMinProfitMargin"]	= "Minimaler Profitgewinn:";
		["GuiNewProfileName"]	= "Neuer Profilname:";
		["GuiNo"]	= "Nein";
		["GuiPLBBOnlyBelowDESkill"]	= "Zeige nur mit aktuellem Skill entzauberbare Items";
		["GuiPLBBSettings"]	= "Prozentwerte- und BidBrokereinstellungen";
		["GuiProspectingLevels"]	= "Zeige benötigten Skilllevel für Sondierung im Tooltip";
		["GuiProspectingMaterials"]	= "Zeige erwartete Sondierwerte im Tooltip";
		["GuiProspectingOptions"]	= "Sondierungsoptionen";
		["GuiProspectingValues"]	= "Zeige erwartete Sondierungswerte";
		["GuiResetProfileButton"]	= "Zurücksetzen";
		["GuiSaveProfileButton"]	= "Speichern";
		["GuiShowProspecting"]	= "Zeige Sondierungsdaten für Erze";
		["GuiTabAuctions"]	= "Auktionen";
		["GuiTabFixed"]	= "Standardwerte";
		["GuiTabGeneral"]	= "Allgemein";
		["GuiTabProfiles"]	= "Profile";
		["GuiTabProspecting"]	= "Sondieren";
		["GuiTabWeights"]	= "Gewichtung";
		["GuiValueOptions"]	= "Wertanzeigeoptionen";
		["GuiValueShowAuc4HSP"]	= "Zeige Auctioneer HVP-Werte";
		["GuiValueShowAuc4Median"]	= "Zeige Auctioneer Medianwerte";
		["GuiValueShowAuc5Market"]	= "Zeige Auctioneer Marktwert";
		["GuiValueShowBaseline"]	= "Zeige eingebaute Standardgrundwerte";
		["GuiValueShowDEValues"]	= "Zeige erwartete Entzauberungswerte";
		["GuiValueTerse"]	= "Zeige Kurzinfo zu Entzauberungswert";
		["GuiWeighSettingsNote"]	= "Die Gewichtung oben ändert die Schätzung der erhaltenen Reagenz durch die spezifizierte Menge. Im Allgemeinen kann man sie bei 100% lassen, es sei denn, daß sie mehr oder weniger wertvoll sein sollten, wie die Schätzungsmethode die verwendet wird.";
		["GuiWeightSettings"]	= "Reagenzwunsch bei Entzauberung";
		["GuiYes"]	= "Ja";

	};

	enUS = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "Clearing all enchant data";
		["FrmtActClearFail"]	= "Unable to find item: %s";
		["FrmtActClearOk"]	= "Cleared data for item: %s";
		["FrmtActDefault"]	= "Enchantrix's %s option has been reset to its default setting";
		["FrmtActDefaultAll"]	= "All Enchantrix options have been reset to default settings.";
		["FrmtActDisable"]	= "Not displaying item's %s data";
		["FrmtActEnable"]	= "Displaying item's %s data";
		["FrmtActSet"]	= "Set %s to '%s'";
		["FrmtActUnknown"]	= "Unknown command keyword: '%s'";
		["FrmtActUnknownLocale"]	= "The locale you specified ('%s') is unknown. Valid locales are:";
		["FrmtPrintin"]	= "Enchantrix's messages will now print on the \"%s\" chat frame";
		["FrmtUsage"]	= "Usage:";
		["MesgDisable"]	= "Disabling automatic loading of Enchantrix";
		["MesgNotloaded"]	= "Enchantrix is not loaded. Type /enchantrix for more info.";

		-- Section: Command Options
		["CmdClearAll"]	= "all";
		["OptClear"]	= "([Item]|all)";
		["OptDefault"]	= "(<option>|all)";
		["OptFindBidauct"]	= "<silver>";
		["OptFindBuyauct"]	= "<percent>";
		["OptLocale"]	= "<locale>";
		["OptPrintin"]	= "(<frameIndex>[Number]|<frameName>[String])";

		-- Section: Commands
		["CmdClear"]	= "clear";
		["CmdDefault"]	= "default";
		["CmdDisable"]	= "disable";
		["CmdFindBidauct"]	= "bidbroker";
		["CmdFindBidauctShort"]	= "bb";
		["CmdFindBuyauct"]	= "percentless";
		["CmdFindBuyauctShort"]	= "pl";
		["CmdHelp"]	= "help";
		["CmdLocale"]	= "locale";
		["CmdOff"]	= "off";
		["CmdOn"]	= "on";
		["CmdPrintin"]	= "print-in";
		["CmdToggle"]	= "toggle";
		["ConfigUI"]	= "config";
		["ShowDELevels"]	= "levels";
		["ShowDEMaterials"]	= "materials";
		["ShowEmbed"]	= "embed";
		["ShowGuessAuctioneerHsp"]	= "valuate-hsp";
		["ShowGuessAuctioneerMed"]	= "valuate-median";
		["ShowGuessAuctioneerVal"]	= "valueate-val";
		["ShowGuessBaseline"]	= "valuate-baseline";
		["ShowTerse"]	= "terse";
		["ShowUI"]	= "show";
		["ShowValue"]	= "valuate";
		["StatOff"]	= "Not displaying any enchant data";
		["StatOn"]	= "Displaying configured enchant data";

		-- Section: Config Text
		["GuiLoad"]	= "Load Enchantrix";
		["GuiLoad_Always"]	= "always";
		["GuiLoad_Never"]	= "never";

		-- Section: Game Constants
		["ArgSpellname"]	= "Disenchant";
		["ArgSpellProspectingName"]	= "Prospecting";
		["Enchanting"]	= "Enchanting";
		["Inscription"]	= "Inscription";
		["Jewelcrafting"]	= "Jewelcrafting";
		["PatReagents"]	= "Reagents: (.+)";
		["TextCombat"]	= "Combat";
		["TextGeneral"]	= "General";

		-- Section: Generic Messages
		["FrmtCredit"]	= "  (go to http://enchantrix.org/ to share your data)";
		["FrmtWelcome"]	= "Enchantrix v%s loaded";
		["MesgAuctVersion"]	= "Enchantrix requires Auctioneer version 4.0 or higher. Some features will be unavailable until you update your Auctioneer installation.";

		-- Section: Help Text
		["GuiClearall"]	= "Clear All Enchantrix Data";
		["GuiClearallButton"]	= "Clear All";
		["GuiClearallHelp"]	= "Click here to clear all of Enchantrix data for the current server-realm.";
		["GuiClearallNote"]	= "for the current server-faction";
		["GuiDefaultAll"]	= "Reset All Enchantrix Options";
		["GuiDefaultAllButton"]	= "Reset All";
		["GuiDefaultAllHelp"]	= "Click here to set all Enchantrix options to their default values.\nWARNING: This action is NOT undoable.";
		["GuiDefaultOption"]	= "Reset this setting";
		["GuiDELevels"]	= "Show disenchant level requirements in the tooltip";
		["GuiDEMaterials"]	= "Show disenchant material info in the tooltip";
		["GuiEmbed"]	= "Embed info in in-game tooltip";
		["GuiLocale"]	= "Set locale to";
		["GuiMainEnable"]	= "Enable Enchantrix";
		["GuiMainHelp"]	= "Contains settings for Enchantrix \nan AddOn that displays information in item tooltips pertaining to the results of disenchanting said item.";
		["GuiOtherHeader"]	= "Other Options";
		["GuiOtherHelp"]	= "Miscellaneous Enchantrix Options";
		["GuiPrintin"]	= "Select the desired message frame";
		["GuiPrintYieldsInChat"]	= "Show item yields in chat";
		["GuiTerse"]	= "Enable terse mode";
		["GuiValuateAverages"]	= "Valuate with Auctioneer averages";
		["GuiValuateBaseline"]	= "Valuate with Built-in Data";
		["GuiValuateEnable"]	= "Enable Valuation";
		["GuiValuateHeader"]	= "Valuation";
		["GuiValuateMedian"]	= "Valuate with Auctioneer medians";
		["HelpClear"]	= "Clear the specified item's data (you must shift click insert the item(s) into the command) You may also specify the special keyword \"all\"";
		["HelpDefault"]	= "Set an Enchantrix option to it's default value. You may also specify the special keyword \"all\" to set all Enchantrix options to their default values.";
		["HelpDisable"]	= "Stops enchantrix from automatically loading next time you log in";
		["HelpEmbed"]	= "Embed the text in the original game tooltip (note: certain features are disabled when this is selected)";
		["HelpFindBidauct"]	= "Find auctions whose possible disenchant value is a certain silver amount less than the bid price";
		["HelpFindBuyauct"]	= "Find auctions whose buyout price is a certain percent less than the possible disenchant value (and, optionally, a certain amount less than the disenchant value)";
		["HelpGuessAuctioneer5Val"]	= "If valuation is enabled, and you have Auctioneer installed, display the market value of disenchanting the item.";
		["HelpGuessAuctioneerHsp"]	= "If valuation is enabled, and you have Auctioneer installed, display the sellable price (HSP) valuation of disenchanting the item.";
		["HelpGuessAuctioneerMedian"]	= "If valuation is enabled, and you have Auctioneer installed, display the median based valuation of disenchanting the item.";
		["HelpGuessBaseline"]	= "If valuation is enabled, (Auctioneer not needed) display the baseline valuation of disenchanting the item, based upon the inbuilt prices.";
		["HelpGuessNoauctioneer"]	= "The valuate-hsp and valuate-median commands are not available because you do not have auctioneer installed";
		["HelpLoad"]	= "Change Enchantrix's load settings for this toon";
		["HelpLocale"]	= "Change the locale that is used to display Enchantrix messages";
		["HelpOnoff"]	= "Turns the enchant data display on and off";
		["HelpPrintin"]	= "Select which frame Enchantix will print out it's messages. You can either specify the frame's name or the frame's index.";
		["HelpShowDELevels"]	= "Select whether to show the enchanting skill needed to disenchant the item in the tooltip.";
		["HelpShowDEMaterials"]	= "Select whether to show the possible materials given by disenchanting the item in the tooltip.";
		["HelpShowUI"]	= "Show or hide the settings panel.";
		["HelpTerse"]	= "Enable/disable terse mode, showing only disenchant value. Can be overridden by holding down the control key.";
		["HelpValue"]	= "Select whether to show item's estimated values based on the proportions of possible disenchants";

		-- Section: Report Messages
		["AuctionScanAuctNotInstalled"]	= "You do not have Auctioneer installed. Auctioneer must be installed to perform an auction scan.";
		["AuctionScanVersionTooOld"]	= "You do not have the correct version of Auctioneer installed, this feature requires Auctioneer v4.0 or later.";
		["ChatDeletedProfile"]	= "Deleted profile: ";
		["ChatResetProfile"]	= "Reset all settings for: ";
		["ChatSavedProfile"]	= "Saved profile: ";
		["ChatUsingProfile"]	= "Now using profile: ";
		["FrmtAutoDeActive"]	= "AutoDisenchant active";
		["FrmtAutoDeDisabled"]	= "AutoDisenchant disabled";
		["FrmtAutoDeDisenchantCancelled"]	= "Disenchant cancelled: item not found";
		["FrmtAutoDeDisenchanting"]	= "Disenchanting %s";
		["FrmtAutoDeIgnorePermanent"]	= "Ignoring %s permanently";
		["FrmtAutoDeIgnoreSession"]	= "Ignoring %s this session";
		["FrmtAutoDeInactive"]	= "AutoDisenchant inactive";
		["FrmtAutoDeProspectCancelled"]	= "Prospect cancelled: item not found";
		["FrmtAutoDeProspecting"]	= "Prospecting %s";
		["FrmtBidbrokerCurbid"]	= "curBid";
		["FrmtBidbrokerDone"]	= "Bid brokering done";
		["FrmtBidbrokerHeader"]	= "Bids having %s silver savings on average disenchant value (min %%less = %d):";
		["FrmtBidbrokerLine"]	= "%s, Valued at: %s, %s: %s, Save: %s, Less %s, Time: %s";
		["FrmtBidbrokerMinbid"]	= "minBid";
		["FrmtBidBrokerSkipped"]	= "Skipped %d auctions due to profit margin cutoff (%d%%)";
		["FrmtBidBrokerSkippedBids"]	= "Skipped %d auctions due to existing bids";
		["FrmtPctlessDone"]	= "Percent less done.";
		["FrmtPctlessHeader"]	= "Buyouts having %d%% savings over average item disenchant value (min savings = %s):";
		["FrmtPctlessLine"]	= "%s, Valued at: %s, BO: %s, Save: %s, Less %s";
		["FrmtPctlessSkillSkipped"]	= "Skipped %d auctions due to skill level cutoff (%s)";
		["FrmtPctlessSkipped"]	= "Skipped %d auctions due to profitability cutoff (%s)";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Barker Price (%d%% margin)";
		["FrmtDisinto"]	= "Disenchants into:";
		["FrmtFound"]	= "Found that %s disenchants into:";
		["FrmtFoundNotDisenchant"]	= "Found that %s is not disenchantable";
		["FrmtMillingValueAuctHsp"]	= "Milling value (HSP)";
		["FrmtMillingValueAuctMed"]	= "Milling value (Median)";
		["FrmtMillingValueAuctVal"]	= "Milling value (AucAdv)";
		["FrmtMillingValueMarket"]	= "Milling value (Baseline)";
		["FrmtMillsInto"]	= "Mills into:";
		["FrmtPriceEach"]	= "(%s ea)";
		["FrmtProspectFound"]	= "Found that %s prospects into:";
		["FrmtProspectInto"]	= "Prospects into:";
		["FrmtProspectValueAuctHsp"]	= "Prospect value (HSP)";
		["FrmtProspectValueAuctMed"]	= "Prospect value (Median)";
		["FrmtProspectValueAuctVal"]	= "Prospect value (AucAdv)";
		["FrmtProspectValueMarket"]	= "Prospect value (Baseline)";
		["FrmtSuggestedPrice"]	= "Suggested price:";
		["FrmtTotal"]	= "Total";
		["FrmtValueAuctHsp"]	= "Disenchant value (HSP)";
		["FrmtValueAuctMed"]	= "Disenchant value (Median)";
		["FrmtValueAuctVal"]	= "Disenchant value (AucAdv)";
		["FrmtValueFixedVal"]	= "Disenchant value (Fixed)";
		["FrmtValueMarket"]	= "Disenchant value (Baseline)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer not loaded, using cached prices]";
		["FrmtWarnNoPrices"]	= "[No prices available]";
		["FrmtWarnPriceUnavail"]	= "[Some prices unavailable]";
		["TooltipMillingLevel"]	= "Milling requires skill %d";
		["TooltipProspectLevel"]	= "Prospecting requires skill %d";
		["TooltipShowDisenchantLevel"]	= "Disenchanting requires skill %d";

		-- Section: User Interface
		["ExportPriceAucAdv"]	= "Export Enchantrix prices to Auctioneer Advanced";
		["GuiActivateProfile"]	= "Activate a current profile";
		["GuiAutoDeEnable"]	= "Watch bags for disenchantable items - USE WITH CARE\n";
		["GuiAutoDeOptions"]	= "Automation\n";
		["GuiAutoDePromptLine1"]	= "Do you want do disenchant:\n";
		["GuiAutoDePromptLine3"]	= "  Valued at %s\n";
		["GuiAutoProspectPromptLine1"]	= "Do you want to prospect:\n";
		["GuiBBUnbiddedOnly"]	= "Restrict BidBroker to unbidded items only";
		["GuiConfigProfiles"]	= "Setup, configure and edit profiles";
		["GuiCreateReplaceProfile"]	= "Create or replace a profile";
		["GuiDefaultBBProfitPercent"]	= "Default bidbroker profit Percentage: %d";
		["GuiDefaultLessHSP"]	= "Default percentage less than HSP: %d";
		["GuiDefaultProfitMargin"]	= "Default Profit Margin:";
		["GuiDeleteProfileButton"]	= "Delete";
		["GuiFixedSettings"]	= "Fixed reagent prices";
		["GuiFixedSettingsNote"]	= "Note: These values will be used instead of Auctioneer or any other valuation methods if the checkbox is checked.\nThe following values are still affected by the reagent weights in the previous section, so if you want to make sure that the reagent is valued at exactly the specified amount below, then also make sure that it's weight is set to 100% in the weights section.";
		["GuiGeneralOptions"]	= "General Enchantrix options";
		["GuiIgnore"]	= "Ignore\n";
		["GuiItemValueAuc4HSP"]	= "Auc4 HSP";
		["GuiItemValueAuc4Median"]	= "Auc4 Median";
		["GuiItemValueAuc5Appraiser"]	= "AucAdv Appraiser Value";
		["GuiItemValueAuc5Market"]	= "AucAdv Market Value";
		["GuiItemValueAverage"]	= "Average (default)";
		["GuiItemValueBaseline"]	= "Market Baseline";
		["GuiItemValueCalc"]	= "Item value calculated from";
		["GuiMaxBuyout"]	= "Maximum Buyout price:";
		["GuiMillingingValues"]	= "Show estimated milling values";
		["GuiMillingLevels"]	= "Show milling level requirements in the tooltip";
		["GuiMillingMaterials"]	= "Show milling material info in the tooltip";
		["GuiMillingOptions"]	= "Milling Options";
		["GuiMinBBProfitPercent"]	= "Minimum bidbroker profit Percentage: %d";
		["GuiMinimapButtonAngle"]	= "Button angle: %d";
		["GuiMinimapButtonDist"]	= "Distance: %d";
		["GuiMinimapOptions"]	= "Minimap display options";
		["GuiMinimapShowButton"]	= "Display Minimap button";
		["GuiMinLessHSP"]	= "Minimum Percentage less than HSP: %d";
		["GuiMinProfitMargin"]	= "Minimum Profit Margin:";
		["GuiNewProfileName"]	= "New profile name:";
		["GuiNo"]	= "No\n";
		["GuiPLBBOnlyBelowDESkill"]	= "Only show items disenchantable at current skill";
		["GuiPLBBSettings"]	= "Percentless and Bidbroker settings";
		["GuiProspectingLevels"]	= "Show prospecting level requirements in the tooltip";
		["GuiProspectingMaterials"]	= "Show prospecting material info in the tooltip";
		["GuiProspectingOptions"]	= "Prospecting Options";
		["GuiProspectingValues"]	= "Show estimated prospecting values";
		["GuiResetProfileButton"]	= "Reset";
		["GuiSaveProfileButton"]	= "Save";
		["GuiShowMilling"]	= "Show Milling data for herbs";
		["GuiShowProspecting"]	= "Show Prospecting data for ores";
		["GuiTabAuctions"]	= "Auctions";
		["GuiTabFixed"]	= "Fixed Value";
		["GuiTabGeneral"]	= "General";
		["GuiTabMilling"]	= "Milling";
		["GuiTabProfiles"]	= "Profiles";
		["GuiTabProspecting"]	= "Prospecting";
		["GuiTabWeights"]	= "Weights";
		["GuiValueOptions"]	= "Value Display Options";
		["GuiValueShowAuc4HSP"]	= "Show Auctioneer HSP values";
		["GuiValueShowAuc4Median"]	= "Show Auctioneer median values";
		["GuiValueShowAuc5Market"]	= "Show Auctioneer market value";
		["GuiValueShowBaseline"]	= "Show built-in baseline values";
		["GuiValueShowDEValues"]	= "Show estimated disenchant values";
		["GuiValueTerse"]	= "Show terse disenchant value";
		["GuiWeighSettingsNote"]	= "The weights above change the valuation of the given reagent by the specified amount. Generally you will want to leave them at 100% unless you think they should be more or less valuable than the valuation method you are using is saying.";
		["GuiWeightSettings"]	= "Disenchant reagent desirability";
		["GuiYes"]	= "Yes";

	};

	esES = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "Eliminando toda información de encantamientos";
		["FrmtActClearFail"]	= "Imposible encontrar artí­culo: %s";
		["FrmtActClearOk"]	= "Información eliminada para el artí­culo: %s";
		["FrmtActDefault"]	= "La opción %s de Enchantrix ha sido reestablecida a sus ajustes por defecto.";
		["FrmtActDefaultAll"]	= "Todas las opciones de Enchantrix han sido reestablecidas a sus ajustes por defecto.";
		["FrmtActDisable"]	= "Ocultando información del artículo: %s ";
		["FrmtActEnable"]	= "Mostrando información del artí­culo: %s ";
		["FrmtActSet"]	= "%s establecido a '%s'";
		["FrmtActUnknown"]	= "Comando o palabra clave desconocida: '%s'";
		["FrmtActUnknownLocale"]	= "La localización que has especificado ('%s') no es válida. Las localizaciones válidas son:";
		["FrmtPrintin"]	= "Los mensajes de Enchantrix se imprimirán en la ventana de chat \"%s\"";
		["FrmtUsage"]	= "Uso:";
		["MesgDisable"]	= "Desactivando la carga automática de Enchantrix";
		["MesgNotloaded"]	= "Enchantrix no está cargado. Escriba /enchantrix para más información.";

		-- Section: Command Options
		["CmdClearAll"]	= "todo";
		["OptClear"]	= "([Item]|todo)";
		["OptDefault"]	= "(<opción>|todo)";
		["OptFindBidauct"]	= "<dinero>";
		["OptFindBuyauct"]	= "<porcentaje>";
		["OptLocale"]	= "<localización>";
		["OptPrintin"]	= "(<indiceVentana>[Número]|<nombreVentana>[Serie])";

		-- Section: Commands
		["CmdClear"]	= "borrar";
		["CmdDefault"]	= "original";
		["CmdDisable"]	= "deshabilitar";
		["CmdFindBidauct"]	= "corredorofertas";
		["CmdFindBidauctShort"]	= "co";
		["CmdFindBuyauct"]	= "porcientomenos";
		["CmdFindBuyauctShort"]	= "pm";
		["CmdHelp"]	= "ayuda";
		["CmdLocale"]	= "localidad";
		["CmdOff"]	= "apagado";
		["CmdOn"]	= "prendido";
		["CmdPrintin"]	= "imprimir-en";
		["CmdToggle"]	= "invertir";
		["ShowEmbed"]	= "integrar";
		["ShowGuessAuctioneerHsp"]	= "valorizar-pmv";
		["ShowGuessAuctioneerMed"]	= "valorizar-mediano";
		["ShowGuessBaseline"]	= "valorizar-referencia";
		["ShowTerse"]	= "conciso";
		["ShowValue"]	= "valorizar";
		["StatOff"]	= "Ocultando toda información de los desencantamientos";
		["StatOn"]	= "Mostrando la configuración corriente para la información de los desencantamientos";

		-- Section: Config Text
		["GuiLoad"]	= "Cargar Enchantrix";
		["GuiLoad_Always"]	= "siempre";
		["GuiLoad_Never"]	= "nunca";

		-- Section: Game Constants
		["ArgSpellname"]	= "Desencantar";
		["PatReagents"]	= "Componentes:(.+)";
		["TextCombat"]	= "Combate";
		["TextGeneral"]	= "General";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(ve a http://enchantrix.org/ para comparti­r tu información)";
		["FrmtWelcome"]	= "Enchantrix versión %s cargado";
		["MesgAuctVersion"]	= "Enchantrix requiere la versión 3.4 o mayor de Auctioneer. Algunas características no estarán disponibles hasta que actualices tu instalación de Auctioneer.";

		-- Section: Help Text
		["GuiClearall"]	= "Elimina toda la información de Enchantrix";
		["GuiClearallButton"]	= "Eliminar Todo";
		["GuiClearallHelp"]	= "Clic aquí para eliminar toda la información de Enchantrix sobre el reino-facción actual.";
		["GuiClearallNote"]	= "el reino-facción actual.";
		["GuiDefaultAll"]	= "Reestablece todas las opciones de Enchantrix";
		["GuiDefaultAllButton"]	= "Reestablecer Todo";
		["GuiDefaultAllHelp"]	= "Clic aquí para establecer todas las opciones de Auctioneer a sus valores por defecto. ADVERTENCIA: Esta acción NO es reversible.";
		["GuiDefaultOption"]	= "Reestablece esta opción";
		["GuiEmbed"]	= "Integra la información en la caja de ayuda";
		["GuiLocale"]	= "Establece la localización a";
		["GuiMainEnable"]	= "Activa Enchantrix";
		["GuiMainHelp"]	= "Contiene ajustes para Enchantrix, un accesorio que muestra información en la caja de ayuda de objetos sobre el desencantamiento del objeto en cuestión.";
		["GuiOtherHeader"]	= "Otras Opciones";
		["GuiOtherHelp"]	= "Otras Opciones de Enchantrix";
		["GuiPrintin"]	= "Selecciona la ventana deseada";
		["GuiTerse"]	= "Activa el modo conciso";
		["GuiValuateAverages"]	= "Valora con Promedios de Auctioneer";
		["GuiValuateBaseline"]	= "Valora con la información integrada";
		["GuiValuateEnable"]	= "Activa Valoración";
		["GuiValuateHeader"]	= "Valoración";
		["GuiValuateMedian"]	= "Valora con Promedios de Auctioneer";
		["HelpClear"]	= "Elimina la información sobre el objeto especificado (debes usar clic-mayúsculas para incluir el/los objeto(s) en el comando) También puedes especificar las palabra clave \"todo\"";
		["HelpDefault"]	= "Establece una opción de Enchantrix a su valor por defecto. También puedes especificar la palabra clave especial \"todo\" para establecer todas las opciones de Enchantrix a sus valores por defecto.";
		["HelpDisable"]	= "Impide que Enchantrix se cargue automáticamente la próxima vez que te conectes";
		["HelpEmbed"]	= "Inserta el texto en la caja de ayuda original del juego (nota: algunas características se desactivan cuando esta opción es seleccionada)";
		["HelpFindBidauct"]	= "Encuentra subastas en las que el valor de desencantamiento posible es una cantidad de dinero menor que el precio de puja";
		["HelpFindBuyauct"]	= "Encuentra subastas en las que el precio de compra es un porcentaje menor que el valor de desencantamiento posible (y, opcionalmente, una cantidad menor que el valor de desenctanemiento)";
		["HelpGuessAuctioneerHsp"]	= "Si la valoración está activada y tienes Auctioneer instalado, muestra la valoración del precio de venta (PMV) al desencantar el objeto.";
		["HelpGuessAuctioneerMedian"]	= "Si la valoración está activada y tienes Auctioneer instalado, muestra la valoración basada en promedios al desencantar el objeto.";
		["HelpGuessBaseline"]	= "Si la valoración está activada (no se necesita Auctioneer) muestra la valoración base al desencantar el objeto, basado en los precios integrados.";
		["HelpGuessNoauctioneer"]	= "Los comandos valorar-pmv y valorar-promedio no están disponibles porque no tienes Auctioneer instalado";
		["HelpLoad"]	= "Cambia las opciones de carga de Enchantrix para este personaje";
		["HelpLocale"]	= "Cambia la localización que es usada para mostrar los mensajes de Enchantrix";
		["HelpOnoff"]	= "Activa y desactiva la visualización de la información de encantamientos";
		["HelpPrintin"]	= "Determina en qué ventana se imprimen los mensajes d eEnchantrix. Puedes especificar el nombre de la ventana o su índice.";
		["HelpTerse"]	= "Activa y desactiva el modo conciso, mostrando solo el valor de los desencantamientos. Puede ser desactivado temporalmente manteniendo pulsada la tecla Control.";
		["HelpValue"]	= "Determina si se muestran los valores de objeto estimados basados en las proporciones de los posibles desencantamientos";

		-- Section: Report Messages
		["FrmtBidbrokerCurbid"]	= "pujaActual";
		["FrmtBidbrokerDone"]	= "Corredor de pujas finalizado";
		["FrmtBidbrokerHeader"]	= "Pujas que tienen un promedio de ahorro de %s de plata en el valor de desencantamiento (min %%menos= %d):";
		["FrmtBidbrokerLine"]	= "%s, Valorado en: %s, %s: %s, Ahorra: %s, Menos %s, Tiempo: %s";
		["FrmtBidbrokerMinbid"]	= "pujaMin";
		["FrmtBidBrokerSkipped"]	= "Saltadas %d subastas que están por debajo del margen de beneficios (%d%%)";
		["FrmtPctlessDone"]	= "Porcentajes menores finalizado.";
		["FrmtPctlessHeader"]	= "Compras que tienen %d%% de ahorro sobre el precio promedio de desencantamiento del artí­culo (ahorro min= %s):";
		["FrmtPctlessLine"]	= "%s, Valorado en: %s, Compra: %s, Ahorra: %s, Menos %s";
		["FrmtPctlessSkipped"]	= "Saltadas %d subastas que están por debajo del margen de beneficios (%s)";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Precio de Pregonero (margen de %d%%)";
		["FrmtDisinto"]	= "Se desencanta en:";
		["FrmtFound"]	= "Se ha descubierto que %s se desencanta en:";
		["FrmtPriceEach"]	= "(%s c/u)";
		["FrmtSuggestedPrice"]	= "Precio Sugerido:";
		["FrmtTotal"]	= "Total";
		["FrmtValueAuctHsp"]	= "Valor de desencantamiento (PMV)";
		["FrmtValueAuctMed"]	= "Valor de desencantamiento (Promedio)";
		["FrmtValueMarket"]	= "Valor de desencantamiento (Referencia)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer no se ha cargado, usando los precios guardados]";
		["FrmtWarnNoPrices"]	= "[No hay precios disponibles]";
		["FrmtWarnPriceUnavail"]	= "[Algunos precios no están disponibles]";

	};

	frFR = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "Effacement de toutes les données d'enchantement";
		["FrmtActClearFail"]	= "Impossible de trouver l'objet : %s";
		["FrmtActClearOk"]	= "Information effacée pour l'objet : %s";
		["FrmtActDefault"]	= "L'option %s d'Enchantrix a été réinitialisée à sa valeur par défaut";
		["FrmtActDefaultAll"]	= "Toutes les options d'Enchantrix ont été réinitialisées à  leurs valeurs par défaut.";
		["FrmtActDisable"]	= "N'affiche pas les données de l'objet %s";
		["FrmtActEnable"]	= "Affichage des données de l'objet %s";
		["FrmtActSet"]	= "Fixe la valeur de %s à '%s'";
		["FrmtActUnknown"]	= "Mot-clé de commande inconnu : '%s'";
		["FrmtActUnknownLocale"]	= "La langue que vous avez specifiée ('%s') est inconnue. Les langues valides sont :";
		["FrmtPrintin"]	= "Les messages d'Enchantrix seront maintenant affichés dans la fenêtre de dialogue \"%s\"";
		["FrmtUsage"]	= "Syntaxe :";
		["MesgDisable"]	= "Désactivation du chargement automatique d'Enchantrix";
		["MesgNotloaded"]	= "Enchantrix n'est pas chargé. Tapez /enchantrix pour plus d'informations.";

		-- Section: Command Options
		["CmdClearAll"]	= "tout";
		["OptClear"]	= "([Objet]|tout)";
		["OptDefault"]	= "([option]|tout)";
		["OptFindBidauct"]	= "<argent>";
		["OptFindBuyauct"]	= "<pourcent>";
		["OptLocale"]	= "<langue>";
		["OptPrintin"]	= "(<fenetreIndex>[nombre]|<fenetreNom>[Chaine])";

		-- Section: Commands
		["CmdClear"]	= "effacer";
		["CmdDefault"]	= "par défaut";
		["CmdDisable"]	= "désactiver";
		["CmdFindBidauct"]	= "agent-enchere";
		["CmdFindBidauctShort"]	= "ae";
		["CmdFindBuyauct"]	= "sans-pourcentage";
		["CmdFindBuyauctShort"]	= "pl";
		["CmdHelp"]	= "aide";
		["CmdLocale"]	= "langue";
		["CmdOff"]	= "arret";
		["CmdOn"]	= "marche";
		["CmdPrintin"]	= "afficher-dans";
		["CmdToggle"]	= "activer-desactiver";
		["ShowDELevels"]	= "niveaux";
		["ShowDEMaterials"]	= "matériaux";
		["ShowEmbed"]	= "integrer";
		["ShowGuessAuctioneerHsp"]	= "evaluer-pvm";
		["ShowGuessAuctioneerMed"]	= "evaluer-median";
		["ShowGuessAuctioneerVal"]	= "evaluer-val";
		["ShowGuessBaseline"]	= "evaluer-reference";
		["ShowTerse"]	= "concis";
		["ShowUI"]	= "montrer";
		["ShowValue"]	= "evaluer";
		["StatOff"]	= "N'affiche aucune donnée d'enchantement";
		["StatOn"]	= "Affiche les données d'enchantement configurées";

		-- Section: Config Text
		["GuiLoad"]	= "Charger Enchantrix";
		["GuiLoad_Always"]	= "toujours";
		["GuiLoad_Never"]	= "jamais";

		-- Section: Game Constants
		["ArgSpellname"]	= "Désenchanter";
		["ArgSpellProspectingName"]	= "Prospecter";
		["Enchanting"]	= "Enchantement";
		["Jewelcrafting"]	= "Joaillerie";
		["PatReagents"]	= "Ingrédients: (.+)";
		["TextCombat"]	= "Combat";
		["TextGeneral"]	= "Général";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(visitez http://enchantrix.org/ pour partager vos données)";
		["FrmtWelcome"]	= "Enchantrix v%s chargé";
		["MesgAuctVersion"]	= "Enchantrix nécessite Auctioneer version 3.4 ou plus. Quelques fonctions seront désactivées tant que vous ne mettrez pas à jour auctioneer.";

		-- Section: Help Text
		["GuiClearall"]	= "Réinitialiser toutes les données d'Enchantrix";
		["GuiClearallButton"]	= "Effacer tout";
		["GuiClearallHelp"]	= "Cliquer ici pour réinitialiser toutes les données d'Enchantrix pour le serveur-faction actuel.";
		["GuiClearallNote"]	= "pour le serveur-faction actuel";
		["GuiDefaultAll"]	= "Réinitialiser toutes les Options d'Enchantrix";
		["GuiDefaultAllButton"]	= "Tout réinitialiser";
		["GuiDefaultAllHelp"]	= "Cliquer ici pour réinitialiser toutes les options d'Enchantrix. ATTENTION: Cette opération est irréversible.";
		["GuiDefaultOption"]	= "Réinitialiser ce réglage";
		["GuiEmbed"]	= "Intégrer les infos dans les bulles d'aide originales";
		["GuiLocale"]	= "Changer la langue pour";
		["GuiMainEnable"]	= "Activer Enchantrix";
		["GuiMainHelp"]	= "Contient les règlages d'Enchantrix, un AddOn qui affiche les informations liées au désenchantement des objets.";
		["GuiOtherHeader"]	= "Autres Options";
		["GuiOtherHelp"]	= "Options diverses d'Enchantrix";
		["GuiPrintin"]	= "Choisir la fenêtre de message souhaitée";
		["GuiTerse"]	= "Active le mode concis";
		["GuiValuateAverages"]	= "Evaluer avec les moyennes d'Auctioneer";
		["GuiValuateBaseline"]	= "Evaluer avec les données intégrées.";
		["GuiValuateEnable"]	= "Activer Evaluation";
		["GuiValuateHeader"]	= "Evaluation";
		["GuiValuateMedian"]	= "Evaluer avec les moyennes d'Auctioneer";
		["HelpClear"]	= "Efface les données de l'objet spécifié (vous devez maj-cliquer le ou les objets dans la ligne de commande) Vous pouvez également spécifier le mot-clef \"tout\"";
		["HelpDefault"]	= "Réinitialise une option d'Enchantrix à sa valeur par défaut. Vous pouvez spécifier le mot-clef \"tout\" pour réinitialiser toutes les options d'Enchantrix.";
		["HelpDisable"]	= "Empêche le chargement automatique d'Enchantrix lors de votre prochaine connexion.";
		["HelpEmbed"]	= "Intègre le texte dans la bulle d'aide originale (Remarque: Certaines fonctionnalités sont désactivées dans ce cas)";
		["HelpFindBidauct"]	= "Trouver les enchères dont la valeur de désenchantement potentielle est inférieure d'un certain montant en pièces d'argent au prix d'enchère.";
		["HelpFindBuyauct"]	= "Trouver les enchères dont la valeur de désenchantement potentielle est infèrieure d'un certain pourcentage au prix d'achat immédiat.";
		["HelpGuessAuctioneerHsp"]	= "Si évaluation est activé et qu'Auctioneer est installé, affiche l'estimation de plus haut prix de vente (HSP) de désenchantement de cet objet.";
		["HelpGuessAuctioneerMedian"]	= "Si évaluation est activé et qu'Auctioneer est installé, affiche l'évaluation basée sur la moyenne de désenchantement de l'objet.";
		["HelpGuessBaseline"]	= "Si évaluation est activé (Auctioneer n'est pas nécessaire), affiche les informations de base de désenchantement, en s'appuyant sur la liste de prix intégrée.";
		["HelpGuessNoauctioneer"]	= "Les commandes \"evaluer-hsp\" et \"evaluer-moyenne\" ne sont pas disponibles car vous n'avez pas Auctioneer d'installé";
		["HelpLoad"]	= "Change les règlages de chargement pour ce personnage";
		["HelpLocale"]	= "Change la langue utilisée pour afficher les messages d'Enchantrix";
		["HelpOnoff"]	= "Active ou désactive les informations d'enchantement";
		["HelpPrintin"]	= "Choisir dans quelle fenêtre Enchantrix affichera ses messages. Vous pouvez spécifier le nom de la fenêtre ou son index.";
		["HelpShowUI"]	= "Afficher ou éteindre le panneau de réglage.";
		["HelpTerse"]	= "Active ou désactive le mode concis, qui ne montre que les valeurs de désenchantement. Peut être annulé en appuyant sur la touche contrôle.";
		["HelpValue"]	= "Choisir d'afficher les valeurs estimées basées sur les proportions de désenchantement possible";

		-- Section: Report Messages
		["AuctionScanAuctNotInstalled"]	= "Vous n'avez pas installé Auctioneer. Auctioneer doit être installé afin d'effectuer un scannage des enchères.";
		["AuctionScanVersionTooOld"]	= "Vous n'avez pas la bonne version d4auctioneer installée, cette fonctionnalité requiert Auctioneer v4.0 ou plus.";
		["ChatDeletedProfile"]	= "Profil effacé:";
		["ChatResetProfile"]	= "Effacer tous les réglages pour:";
		["ChatSavedProfile"]	= "Profil enregistré:";
		["FrmtBidbrokerCurbid"]	= "EnchAct";
		["FrmtBidbrokerDone"]	= "L'agent d'enchères a terminé";
		["FrmtBidbrokerHeader"]	= "Enchères présentant %s pièces d'argent d'économie sur la valeur moyenne de désenchantement (min. %d%% de moins) :";
		["FrmtBidbrokerLine"]	= "%s, Estimé à : %s, %s: %s, Economie: %s, Moins %s, Temps: %s";
		["FrmtBidbrokerMinbid"]	= "EnchMin";
		["FrmtBidBrokerSkipped"]	= "%d enchères ignorées pour marge trop faible (%d%%)";
		["FrmtPctlessDone"]	= "Pourcentage inférieur terminé.";
		["FrmtPctlessHeader"]	= "Achats immédiats %d%% économisant plus que la valeur moyenne de désenchantement de l'objet (min. %s d'économie) :";
		["FrmtPctlessLine"]	= "%s, Estimé à : %s, AI: %s, Economie: %s, Moins %s";
		["FrmtPctlessSkillSkipped"]	= "Enchères sautées de %d dues à la coupure de niveau de compétence (%s)";
		["FrmtPctlessSkipped"]	= "%d enchères ignorées pour marge trop faible (%s)";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Prix marchand (marge : %d%%)";
		["FrmtDisinto"]	= "Se désenchante en :";
		["FrmtFound"]	= "%s se désenchante en :";
		["FrmtFoundNotDisenchant"]	= "%s ne peut pas être désenchanter";
		["FrmtPriceEach"]	= "(%s l'unité)";
		["FrmtProspectFound"]	= "Constaté que %s prospecte en:";
		["FrmtProspectInto"]	= "Prospecte en:";
		["FrmtProspectValueAuctHsp"]	= "Valeur prospectée (HSP)";
		["FrmtProspectValueAuctMed"]	= "Valeur prospectée (médiane)";
		["FrmtProspectValueAuctVal"]	= "Valeur prospectée (AucAdv)";
		["FrmtProspectValueMarket"]	= "Valeur prospectée (référence)";
		["FrmtSuggestedPrice"]	= "Prix suggéré :";
		["FrmtTotal"]	= "Total";
		["FrmtValueAuctHsp"]	= "Valeur désenchantée (HSP)";
		["FrmtValueAuctMed"]	= "Valeur désenchantée (Moyenne)";
		["FrmtValueAuctVal"]	= "Valeur désenchantée (AucAdv)";
		["FrmtValueFixedVal"]	= "Valeur désenchantée (Fixe)";
		["FrmtValueMarket"]	= "Valeur désenchantée (Référence)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer non chargé, utilisation du prix en cache]";
		["FrmtWarnNoPrices"]	= "[Aucun prix disponible]";
		["FrmtWarnPriceUnavail"]	= "[Quelques prix indisponibles]";
		["TooltipProspectLevel"]	= "Prospection demande niveau %d";
		["TooltipShowDisenchantLevel"]	= "Désenchantement demande niveau %d";

		-- Section: User Interface
		["ExportPriceAucAdv"]	= "Exporter les prix Enchantrix vers AuctioneerAdvanced";
		["GuiActivateProfile"]	= "Activer un profile existant";
		["GuiAutoDeEnable"]	= "Chercher pour des objets désenchentables - UTILISER PRUDEMMENT!";
		["GuiAutoDeOptions"]	= "Automatisation";
		["GuiAutoDePromptLine1"]	= "Voulez-vous désenchanter :";
		["GuiAutoDePromptLine3"]	= "Évalué à %s";
		["GuiBBUnbiddedOnly"]	= "BidBroker restreint aux objets non-liés seulement";
		["GuiConfigProfiles"]	= "Créer, configurer et éditer des profiles";
		["GuiCreateReplaceProfile"]	= "Créer ou replacer un profile";
		["GuiDefaultBBProfitPercent"]	= "Pourcentage de profit par défaut du bidbroker : %d";
		["GuiDefaultLessHSP"]	= "Pourcentage par défaut moin que HSP : %d";
		["GuiDefaultProfitMargin"]	= "Marge bénéficiaire par défaut :";
		["GuiDeleteProfileButton"]	= "Supprimer";
		["GuiFixedSettings"]	= "Prix fixe des réactifs";
		["GuiFixedSettingsNote"]	= "Remarque : ces valeurs seront utilisées à la place de celles d'Auctioneer ou de n'importe quelles autres méthodes si cette option est cochée. Toutefois, ces valeurs restent dépendantes du poids des réactifs de la section précédente, donc si vous voulez être certain que ces valeurs fixes soient exactement celles que vous voulez, assurez-vous de mettre 100% dans la section des poids.";
		["GuiGeneralOptions"]	= "Options générales d'Enchantrix";
		["GuiIgnore"]	= "Ignorer";
		["GuiItemValueAuc4HSP"]	= "Auc4 HSP";
		["GuiItemValueAuc4Median"]	= "Auc4 Moyenne";
		["GuiItemValueAuc5Market"]	= "AucAdv Prix du marché";
		["GuiItemValueAverage"]	= "Moyenne (défaut)";
		["GuiItemValueBaseline"]	= "Basé sur le prix du marché";
		["GuiItemValueCalc"]	= "Valeur calculée à partir de";
		["GuiMaxBuyout"]	= "Prix d'achat maximum :";
		["GuiMinBBProfitPercent"]	= "Pourcentage de profit minimum du bidboker : %d";
		["GuiMinimapButtonAngle"]	= "Angle du bouton : %d";
		["GuiMinimapButtonDist"]	= "Distance : %d";
		["GuiMinimapOptions"]	= "Options d'affichage sur la minimap";
		["GuiMinimapShowButton"]	= "Afficher le bouton de la minimap";
		["GuiMinLessHSP"]	= "Pourcentage minimum moins que l'HSP : %d";
		["GuiMinProfitMargin"]	= "Marge bénéficiaire minimale :";
		["GuiNewProfileName"]	= "Nom du nouveau profil :";
		["GuiNo"]	= "Non";
		["GuiPLBBOnlyBelowDESkill"]	= "N'afficher que les objets pouvant être désenchantés selon votre niveau actuel d'enchantement";
		["GuiProspectingLevels"]	= "Voir le niveau nécessaire dans la bulle d'aide";
		["GuiProspectingOptions"]	= "Options de prospection";
		["GuiResetProfileButton"]	= "Réinitialiser";
		["GuiSaveProfileButton"]	= "Sauver";
		["GuiShowProspecting"]	= "Afficher les données de prospection pour les minerais";
		["GuiTabFixed"]	= "Valeur fixe";
		["GuiTabGeneral"]	= "Général";
		["GuiTabProfiles"]	= "Profils";
		["GuiValueOptions"]	= "Option d'affichage du prix";
		["GuiValueShowAuc4Median"]	= "Voir le prix moyen d'Auctioneer";
		["GuiValueShowAuc5Market"]	= "Voir le prix du marché d'Auctioneer";
		["GuiValueShowDEValues"]	= "Voir la valeur estimée du désenchantement";
		["GuiWeightSettings"]	= "réactifs de désenchantement désirés";
		["GuiYes"]	= "Oui";

	};

	itIT = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "Eliminando tutti i dati di enchant";
		["FrmtActClearFail"]	= "Impossibile trovare l'oggetto: %s";
		["FrmtActClearOk"]	= "Eliminati i dati dell'oggetto: %s";
		["FrmtActDefault"]	= "L'opzione %s di Enchantrix e' stata resettata al valore di default";
		["FrmtActDefaultAll"]	= "Tutte le opzioni di Enchantrix sono state resettate al valore di default.";
		["FrmtActDisable"]	= "Non visualizzo i dati dell'oggetto %s";
		["FrmtActEnable"]	= "Visualizzo i dati dell'oggetto %s";
		["FrmtActSet"]	= "Imposta %s a '%s'";
		["FrmtActUnknown"]	= "Comando sconosciuto: '%s'";
		["FrmtActUnknownLocale"]	= "La lingua specificata ('%s') e' sconosciuta. Le lingue valide sono:";
		["FrmtPrintin"]	= "I messaggi di Enchantrix compariranno nella chat \"%s\"";
		["FrmtUsage"]	= "Sintassi:";
		["MesgDisable"]	= "Il caricamento automatico di Enchantrix è disabilitato";
		["MesgNotloaded"]	= "Enchantrix non e' caricato. Digita /enchantrix per maggiori informazioni.";

		-- Section: Command Options
		["CmdClearAll"]	= "tutto";
		["OptClear"]	= "([item]|tutto)";
		["OptDefault"]	= "(<opzione>|tutto)";
		["OptFindBidauct"]	= "<denaro>";
		["OptFindBuyauct"]	= "<percento>";
		["OptLocale"]	= "<lingua>";
		["OptPrintin"]	= "(<frameIndex>[Numero]|<frameName>[Stringa])";

		-- Section: Commands
		["CmdClear"]	= "cancella";
		["CmdDefault"]	= "default";
		["CmdDisable"]	= "disabilita";
		["CmdFindBidauct"]	= "bidbroker";
		["CmdFindBidauctShort"]	= "bb";
		["CmdFindBuyauct"]	= "percentomeno";
		["CmdFindBuyauctShort"]	= "pm";
		["CmdHelp"]	= "aiuto";
		["CmdLocale"]	= "lingua";
		["CmdOff"]	= "fuori di";
		["CmdOn"]	= "abilitato";
		["CmdPrintin"]	= "stampa-in";
		["CmdToggle"]	= "inverti";
		["ShowEmbed"]	= "integra";
		["ShowGuessAuctioneerHsp"]	= "valuta-hsp";
		["ShowGuessAuctioneerMed"]	= "valuta-mediana";
		["ShowGuessBaseline"]	= "valuta-base";
		["ShowTerse"]	= "conciso";
		["ShowValue"]	= "valuta";
		["StatOff"]	= "Visualizzazione dei dati di enchant disabilitata";
		["StatOn"]	= "Visualizzazione dei dati di enchant configurati";

		-- Section: Config Text
		["GuiLoad"]	= "Carica Enchantrix";
		["GuiLoad_Always"]	= "sempre";
		["GuiLoad_Never"]	= "mai";

		-- Section: Game Constants
		["ArgSpellname"]	= "Disincanta";
		["PatReagents"]	= "Reagente:(.+)";
		["TextCombat"]	= "Combattimento";
		["TextGeneral"]	= "Generico";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(vai su http://enchantrix.org/ per condividere i tuoi dati) ";
		["FrmtWelcome"]	= "Enchantrix v%s caricato";
		["MesgAuctVersion"]	= "Enchantrix richiede Auctioneer versione 3.4 o superiore. Alcune funzionalità non saranno disponibili finché Auctioneer non verrà aggiornato.";

		-- Section: Help Text
		["GuiClearall"]	= "Cancella tutti i dati di Enchantrix";
		["GuiClearallButton"]	= "Cancella tutto";
		["GuiClearallHelp"]	= "Clicca qui per eliminare tutti i dati di Enchantrix per il server/realm corrente";
		["GuiClearallNote"]	= "per il corrente server/fazione";
		["GuiDefaultAll"]	= "Ripristina tutte le opzioni di Enchantrix";
		["GuiDefaultAllButton"]	= "Ripristina tutto";
		["GuiDefaultAllHelp"]	= "Clicca qui per resettare tutte le opzioni di Enchantrix. ATTENZIONE: Questa azione non è reversibile.";
		["GuiDefaultOption"]	= "Ripristina questa opzione";
		["GuiEmbed"]	= "Aggiungi le informazioni al tooltip";
		["GuiLocale"]	= "Imposta la lingua a";
		["GuiMainEnable"]	= "Abilita Enchantrix";
		["GuiMainHelp"]	= "Contiene le opzioni di Enchantrix, un AddOn che mostra nel tooltip informazioni relative al disenchant dell'oggetto selezionato";
		["GuiOtherHeader"]	= "Altre opzioni";
		["GuiOtherHelp"]	= "Opzioni aggiuntive di Enchantrix";
		["GuiPrintin"]	= "Seleziona la finestra di chat desiderata";
		["GuiTerse"]	= "Abilita modo conciso";
		["GuiValuateAverages"]	= "Valuta con le medie di Auctioneer";
		["GuiValuateBaseline"]	= "Valuta con i dati di base";
		["GuiValuateEnable"]	= "Abilita la valutazione";
		["GuiValuateHeader"]	= "Valutazione";
		["GuiValuateMedian"]	= "Valuta con le mediane di Auctioneer";
		["HelpClear"]	= "Cancella i dati sull'oggetto specificato (devi inserire l'oggetto nella linea di comando usando shift-click). Puoi anche specificare il comando speciale \"tutto\"";
		["HelpDefault"]	= "Imposta un'opzione di Enchantrix al suo valore di default. Puoi inoltre specificare la parola chiave \"tutto\" per impostare tutte le opzioni di Enchantrix ai loro valori di default.";
		["HelpDisable"]	= "Impedisci che Enchantrix sia caricato automaticamente la prossima volta che entri nel gioco.";
		["HelpEmbed"]	= "Integra il testo nel tooltip originale del gioco. (nota: alcune caratteristiche vengono disabilitate quando si seleziona questa opzione)";
		["HelpFindBidauct"]	= "Trova gli oggetti con il valore possibile di disenchant  inferiore di un importo specificato all'offerta fatta in asta (bid)";
		["HelpFindBuyauct"]	= "Trova glioggetti con il valore possibile di disenchant inferiore di una data percentuale all'offerta fatta in asta (bid)";
		["HelpGuessAuctioneerHsp"]	= "Se la valutazione Ã¨ attivata, e tu hai Auctioneer installato, mostra la valutazione massima del prezzo di vendita dell'oggetto disincantato.";
		["HelpGuessAuctioneerMedian"]	= "Se la valutazione è attivata, e tu hai Auctioneer installato, mostra la valutazione mediana dell'oggetto disincantato.";
		["HelpGuessBaseline"]	= "Se la valutazione è abilitata (Auctioneer non è necessario), visualizza il prezzo di base per il disenchant dell'oggetto (dai dati interni)";
		["HelpGuessNoauctioneer"]	= "I comandi valuate-hsp e valuate-median non sono disponibili perchè non hai auctioneer installato.";
		["HelpLoad"]	= "Cambia le impostazioni di caricamento di Enchantrix per questo personaggio";
		["HelpLocale"]	= "Cambia la lingua con la quale vuoi che Enchantrix comunichi";
		["HelpOnoff"]	= "Abilita o disabilita le informazioni sull'incantesimo";
		["HelpPrintin"]	= "Seleziona in quale finestra di chat verranno mandati i messaggi di Enchantrix. Puoi specificare il nome del frame oppure l'indice.";
		["HelpTerse"]	= "Abilita/disabilita il modo conciso, facendo vedre solo il valore disenchant. Può essere cambiato tenendo premuto il tasto control.";
		["HelpValue"]	= "Seleziona per visualizzare il valore stimato dell'oggetto in base alla proporzione dei disincantamenti possibili";

		-- Section: Report Messages
		["FrmtBidbrokerCurbid"]	= "curBid";
		["FrmtBidbrokerDone"]	= "Bid brokering terminato";
		["FrmtBidbrokerHeader"]	= "Bid che hanno %s silver di meno del valore medio di disenchant:";
		["FrmtBidbrokerLine"]	= "%s, Valutato: %s, %s: %s, Risparmia: %s, Meno %s, Tempo: %s";
		["FrmtBidbrokerMinbid"]	= "minBid";
		["FrmtBidBrokerSkipped"]	= "Saltate le aste %d a causa del superamento del limite del margine di profitto (%d%%)";
		["FrmtPctlessDone"]	= "Percentomeno completato";
		["FrmtPctlessHeader"]	= "Buyout che hanno un risparmio di %s sul prezzo medio di disincantamento: ";
		["FrmtPctlessLine"]	= "%s, Valutato: %s, BO: %s, Risparmio: %s, Meno %s ";
		["FrmtPctlessSkipped"]	= "Saltate le aste %d per un taglio del profitto (%s)";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Prezzo imbonitore (margine %d%%)";
		["FrmtDisinto"]	= "Si disincanta in:";
		["FrmtFound"]	= "%s si disincanta in: ";
		["FrmtPriceEach"]	= "(%s ognuno)";
		["FrmtSuggestedPrice"]	= "Prezzo suggerito:";
		["FrmtTotal"]	= "Totale";
		["FrmtValueAuctHsp"]	= "Valore di disincantamento(HSP)";
		["FrmtValueAuctMed"]	= "Valore di disincantamento (Medio)";
		["FrmtValueMarket"]	= "Valore di disincantamento (Base)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer non caricato, uso i prezzi nascosti]";
		["FrmtWarnNoPrices"]	= "[Prezzi non disponibili]";
		["FrmtWarnPriceUnavail"]	= "[Alcuni prezzi non disponibili]";

	};

	koKR = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "모든 마법부여 데이터를 삭제합니다.";
		["FrmtActClearFail"]	= "아이템을 찾을 수 없음: %s";
		["FrmtActClearOk"]	= "아이템 데이터 삭제: %s ";
		["FrmtActDefault"]	= "Enchantrix의 %s 설정이 초기화 되었습니다.";
		["FrmtActDefaultAll"]	= "모든 Enchantrix 설정이 초기화 되었습니다.";
		["FrmtActDisable"]	= "아이템의 %s 데이터를 표시하지 않습니다.";
		["FrmtActEnable"]	= "아이템의 %s 데이터를 표시합니다.";
		["FrmtActSet"]	= "%s를 '%s'|1으로;로; 설정합니다.";
		["FrmtActUnknown"]	= "알 수 없는 명령어: '%s'";
		["FrmtActUnknownLocale"]	= "('%s|1')은;')는; 알 수 없는 지역입니다. 올바른 지역 설정은 다음과 같습니다:";
		["FrmtPrintin"]	= "Enchantrix의 메세지는 \"%s\" 채팅창에 출력됩니다.";
		["FrmtUsage"]	= "사용법:";
		["MesgDisable"]	= "Enchantrix를 자동 로딩하지 않습니다.";
		["MesgNotloaded"]	= "Enchantrix가 로드되지 않았습니다. /enchantrix 를 입력하시면 더 많은 정보를 보실 수 있습니다.";

		-- Section: Command Options
		["CmdClearAll"]	= "모두";
		["OptClear"]	= "([아이템]|모두)";
		["OptDefault"]	= "(<설정>|모두)";
		["OptFindBidauct"]	= "<실버>";
		["OptFindBuyauct"]	= "<퍼센트>";
		["OptLocale"]	= "<지역>";
		["OptPrintin"]	= "(<창번호>[번호]|<창이름>[문자열])";

		-- Section: Commands
		["CmdClear"]	= "삭제";
		["CmdDefault"]	= "기본값";
		["CmdDisable"]	= "비활성화";
		["CmdFindBidauct"]	= "입찰중개인";
		["CmdFindBidauctShort"]	= "bb";
		["CmdFindBuyauct"]	= "이하확률";
		["CmdFindBuyauctShort"]	= "pl ";
		["CmdHelp"]	= "도움말";
		["CmdLocale"]	= "지역";
		["CmdOff"]	= "끔";
		["CmdOn"]	= "켬";
		["CmdPrintin"]	= "출력하는곳";
		["CmdToggle"]	= "전환";
		["ShowDELevels"]	= "레벨";
		["ShowDEMaterials"]	= "재료";
		["ShowEmbed"]	= "내장";
		["ShowGuessAuctioneerHsp"]	= "평가된 HSP";
		["ShowGuessAuctioneerMed"]	= "평가된 중앙값";
		["ShowGuessAuctioneerVal"]	= "평가된 값";
		["ShowGuessBaseline"]	= "평가된 기본값";
		["ShowTerse"]	= "간결";
		["ShowUI"]	= "표시";
		["ShowValue"]	= "평가";
		["StatOff"]	= "어떤 마법부여자료도 표시하지 않음";
		["StatOn"]	= "설정된 마법부여자료 표시";

		-- Section: Config Text
		["GuiLoad"]	= "Enchantrix 로드";
		["GuiLoad_Always"]	= "항상";
		["GuiLoad_Never"]	= "사용안함";

		-- Section: Game Constants
		["ArgSpellname"]	= "마력추출";
		["ArgSpellProspectingName"]	= "보석추출";
		["Enchanting"]	= "마법 부여";
		["Jewelcrafting"]	= "보석세공";
		["PatReagents"]	= "재료: (.+)";
		["TextCombat"]	= "전투";
		["TextGeneral"]	= "일반";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(당신의 데이터를 공유하려면 http://enchantrix.org/ 에 방문하십시오.)";
		["FrmtWelcome"]	= "Enchantrix v%s 로딩완료";
		["MesgAuctVersion"]	= "Enchantrix는 Auctioneer 버전 3.4 이상이 필요합니다. 여러분이 새로운 Auctioneer를 설치하기전까지 몇가지 기능을 사용할 수 없습니다.";

		-- Section: Help Text
		["GuiClearall"]	= "모든 Enchantrix 데이터 삭제";
		["GuiClearallButton"]	= "모두 삭제";
		["GuiClearallHelp"]	= "클릭하면 현재 서버의 Enchantrix 자료가 모두 삭제됩니다.";
		["GuiClearallNote"]	= "현재 서버-진영";
		["GuiDefaultAll"]	= "모든 Enchantrix 옵션 초기화";
		["GuiDefaultAllButton"]	= "모두 초기화";
		["GuiDefaultAllHelp"]	= "클릭하면 Enchantrix의 설정을 기본값으로 돌립니다. 경고: 이 작업은 되돌릴 수 없습니다.";
		["GuiDefaultOption"]	= "이 설정 초기화";
		["GuiDELevels"]	= "툴팁에 마력추출에 필요한 레벨을 보여줍니다.";
		["GuiDEMaterials"]	= "툴팁에 마력추출 재료 정보를 보여줍니다.";
		["GuiEmbed"]	= "정보를 기본 툴팁에 포함";
		["GuiLocale"]	= "지역설정";
		["GuiMainEnable"]	= "Enchantrix 활성화";
		["GuiMainHelp"]	= "아이템에 대한 마력추출의 결과와 관련된 정보를 툴팁에 표시해주는 애드온인 Enchantrix에 관한 설정을 포함합니다.";
		["GuiOtherHeader"]	= "기타 설정";
		["GuiOtherHelp"]	= "기타 Enchantrix 설정";
		["GuiPrintin"]	= "원하는 메시지 프레임을 선택";
		["GuiTerse"]	= "간결 모드 사용";
		["GuiValuateAverages"]	= "Auctioneer 평균으로 평가";
		["GuiValuateBaseline"]	= "내장된 자료를 이용해 평가";
		["GuiValuateEnable"]	= "평가 활성화";
		["GuiValuateHeader"]	= "평가";
		["GuiValuateMedian"]	= "Autctioneer 중앙값으로 평가";
		["HelpClear"]	= "지정된 아이템의 데이타를 삭제합니다.(이때 아이템지정은 Shift-click 으로 명령어창에 넣어야합니다.) 모든 아이템데이타를 삭제하기 위해 \"모두\" 를 사용할 수 있습니다.";
		["HelpDefault"]	= "Enchantrix의 옵션을 기본값으로 설정합니다. 모든 Enchantrix 설정을 기본값으로 하시려면 \"모두\" 를 사용할 수 있습니다.";
		["HelpDisable"]	= "다음 로그인시 자동으로 Enchantrix를 로드하지 않음";
		["HelpEmbed"]	= "내용을 기본 게임 툴팁에 포함(이 설정이 선택되면, 일부 기능을 사용할수 없습니다.)";
		["HelpFindBidauct"]	= "가능한 마력추출 가격이 입찰가 보다 낮은 경매품 찾기";
		["HelpFindBuyauct"]	= "가능한 마력추출 가격이 즉시 구입가보다 낮은 경매품 찾기";
		["HelpGuessAuctioneer5Val"]	= "만약 평가가 활성화 되어있고 Auctioneer가 설치되어 있다면 아이템 마력추출의 시장가격을 보여줍니다.";
		["HelpGuessAuctioneerHsp"]	= "만약 평가가 활성화 되어있고 Auctioneer가 설치되어 있다면, 아이템을 마력추출시 가치의 최고판매가능가격(HSP)이 표시됩니다.";
		["HelpGuessAuctioneerMedian"]	= "만약 평가가 활성화 되었으면, 그리고 Auctioneer가 설치되어 있으면, 아이템을 마력추출시 가치의 중앙값이 표시됩니다.";
		["HelpGuessBaseline"]	= "만약 평가가 활성화 되었으면, (Autctionner는 필요하지 않습니다) 아이템을 마력추출시 가치의 기본값이 표시됩니다.";
		["HelpGuessNoauctioneer"]	= "Auctioneer가 설치되어 있지 않아서 평가된 HSP, 평가된 중앙값 명령어를 사용할 수 없습니다.";
		["HelpLoad"]	= "이 케릭터의 Enchantrix 로드 설정 변경";
		["HelpLocale"]	= "Enchantrix가 메시지를 표시하기위해 사용하는 언어 변경";
		["HelpOnoff"]	= "Enchantrix자료 표시 켬/끔";
		["HelpPrintin"]	= "Enchantrix가 메시지를 출력할 프레임 선택. 프레임의 이름이나, 번호를 사용할 수 있습니다.";
		["HelpShowDELevels"]	= "아이템을 마력추출하는데 필요한 마법부여 숙련을 툴팁에 표시할지를 선택합니다.";
		["HelpShowDEMaterials"]	= "아이템을 마력추출해서 받을 수 있는 마법재료를 툴팁에 표시할지를 선택합니다.";
		["HelpShowUI"]	= "설정창을 보이거나 숨깁니다.";
		["HelpTerse"]	= "마력추출 가격만 보이도록하는 간결 모드 사용/사용안함. 컨트롤 키를 눌러서 겹쳐쓸 수 있음.";
		["HelpValue"]	= "가능한 마력추출 비율에 근거한 아이템의 평가값 보기 여부 선택";

		-- Section: Report Messages
		["AuctionScanAuctNotInstalled"]	= "Auctioneer가 설치되어 있지 않습니다. 경매 검색을 수행하려면 Auctioneer가 설치되어 있어야 합니다.";
		["AuctionScanVersionTooOld"]	= "설치된 Auctioneer의 버젼이 맞지 않습니다. 이 기능을 이용하려면 Auctioneer 4.0 이상이 필요합니다.";
		["ChatDeletedProfile"]	= "프로파일 삭제 : ";
		["ChatResetProfile"]	= "모든 설정값 삭제 : ";
		["ChatSavedProfile"]	= "저장된 프로파일 : ";
		["ChatUsingProfile"]	= "사용중인 프로파일 : ";
		["FrmtAutoDeActive"]	= "자동 마력추출 활성화";
		["FrmtAutoDeDisabled"]	= "자동 마력추출 disabled";
		["FrmtAutoDeDisenchantCancelled"]	= "마력추출이 취소되었습니다 : 아이템을 찾을 수 없습니다.";
		["FrmtAutoDeDisenchanting"]	= "%s를 마력추출합니다.";
		["FrmtAutoDeIgnorePermanent"]	= "%s를 영원히 무시합니다.";
		["FrmtAutoDeIgnoreSession"]	= "%s를 이번 접속동안만 무시합니다.";
		["FrmtAutoDeInactive"]	= "자동 마력추출 비활성화";
		["FrmtAutoDeProspectCancelled"]	= "보석추출 취소 : 아이템을 찾을 수 없습니다.";
		["FrmtAutoDeProspecting"]	= "%s를 보석추출합니다.";
		["FrmtBidbrokerCurbid"]	= "현재 입찰";
		["FrmtBidbrokerDone"]	= "입찰 중개 완료";
		["FrmtBidbrokerHeader"]	= "입찰이 평균 마력추출 가격에서 %S 실버 절약되었습니다. (최소 %%less = %d):";
		["FrmtBidbrokerLine"]	= "%s, 가격: %s, %s: %s, 감소: %s, %s 이하, 시간: %s";
		["FrmtBidbrokerMinbid"]	= "최소 입찰";
		["FrmtBidBrokerSkipped"]	= "%d개의 경매품이 마진(%d%%)을 위해 건너뛰어짐";
		["FrmtBidBrokerSkippedBids"]	= "입찰값이 존재하여 %d개의 경매를 건너뛰었습니다.";
		["FrmtPctlessDone"]	= "%% 덜 됨.";
		["FrmtPctlessHeader"]	= "즉시 구입가격이 평균 마력추출 가격상에서 %d%% 절약되었습니다.:";
		["FrmtPctlessLine"]	= "%s, 가격: %s, BO: %s, 감소: %s, %s 이하";
		["FrmtPctlessSkillSkipped"]	= "%d개의 경매품이 전문기술숙련(%s) 때문에 건너뛰어짐";
		["FrmtPctlessSkipped"]	= "%d개의 경매품이 수익성(%s)을 위해 건너뛰어짐";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "가격 알림 (%d%% 마진)";
		["FrmtDisinto"]	= "마력 추출:";
		["FrmtFound"]	= "%s|1이;가; 마력 추출되는 아이템: ";
		["FrmtFoundNotDisenchant"]	= "%s는 마력 추출이 불가능한 아이템입니다.";
		["FrmtPriceEach"]	= "(%s 개)";
		["FrmtProspectValueAuctHsp"]	= "예상 가격 (HSP)";
		["FrmtProspectValueAuctMed"]	= "예상 가격 (중앙값)";
		["FrmtProspectValueAuctVal"]	= "예상 가격 (경매장값)";
		["FrmtProspectValueMarket"]	= "예상 가격 (기본가)";
		["FrmtSuggestedPrice"]	= "제안 가격:";
		["FrmtTotal"]	= "총";
		["FrmtValueAuctHsp"]	= "마력추출 가격 (HSP)";
		["FrmtValueAuctMed"]	= "마력추출 가격 (중앙값)";
		["FrmtValueMarket"]	= "마력추출 가격 (기준값)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer가 실행되지 않아서 저장된 가격을 사용합니다.]";
		["FrmtWarnNoPrices"]	= "[가능한 가격 없음]";
		["FrmtWarnPriceUnavail"]	= "[일부 가격을 사용할 수 없음]";

		-- Section: User Interface
		["ExportPriceAucAdv"]	= "Enchantrix 가격을 AuctioneerAdvanced로 보냅니다.";
		["GuiActivateProfile"]	= "현재 프로필 활성화";
		["GuiAutoDeEnable"]	= "가방에서 마력추출할 아이템을 찾습니다. - \"주의해서 사용하세요.\"";
		["GuiAutoDeOptions"]	= "자동설정";
		["GuiAutoDePromptLine1"]	= "마력추출하겠습니까? : ";
		["GuiAutoDePromptLine3"]	= "가치 : %s";
		["GuiBBUnbiddedOnly"]	= "입찰이 없는 아이템으로 BidBroker를 한정합니다.";
		["GuiConfigProfiles"]	= "설정 및 프로파일 수정";
		["GuiCreateReplaceProfile"]	= "프로파일 생성 또는 갱신";
		["GuiDeleteProfileButton"]	= "삭제";
		["GuiFixedSettings"]	= "고정된 재료 가격";
		["GuiGeneralOptions"]	= "일반 Enchantrix 설정";
		["GuiIgnore"]	= "무시";
		["GuiItemValueAverage"]	= "평균 (기본값)";
		["GuiItemValueBaseline"]	= "시장 기준";
		["GuiItemValueCalc"]	= "다음으로부터 아이템 가치가 산정되었습니다:";
		["GuiMaxBuyout"]	= "즉시 구매 최대가 :";
		["GuiMinimapButtonAngle"]	= "버튼 위치 : %d";
		["GuiMinimapButtonDist"]	= "거리 : %d";
		["GuiMinimapOptions"]	= "미니맵 표시 설정";
		["GuiMinimapShowButton"]	= "미니맵 버튼을 표시합니다.";
		["GuiMinProfitMargin"]	= "최소 이윤 : ";
		["GuiNewProfileName"]	= "새로운 프로파일 이름:";
		["GuiNo"]	= "아니오";
		["GuiPLBBOnlyBelowDESkill"]	= "현재 기술레벨로 마력추출이 가능한 아이템만 보이기";
		["GuiProspectingLevels"]	= "보석추출 레벨제한을 툴팁에 보여줍니다.";
		["GuiProspectingMaterials"]	= "보석추출 재료 정보를 툴팁에 보여줍니다.";
		["GuiProspectingOptions"]	= "보석 추출 설정";
		["GuiProspectingValues"]	= "보석 추출의 예상 가치를 보여줍니다.";
		["GuiResetProfileButton"]	= "초기화";
		["GuiSaveProfileButton"]	= "저장";
		["GuiShowProspecting"]	= "광석에 대한 보석 추출 데이터를 보여줍니다.";
		["GuiTabAuctions"]	= "경매";
		["GuiTabFixed"]	= "고정 가치";
		["GuiTabGeneral"]	= "일반";
		["GuiTabProfiles"]	= "프로파일";
		["GuiTabProspecting"]	= "보석 추출";
		["GuiTabWeights"]	= "가중치";
		["GuiValueOptions"]	= "가치 표시 설정";
		["GuiValueShowAuc5Market"]	= "Auctioneer 시장 가치를 보여줍니다.";
		["GuiValueShowBaseline"]	= "내장 기준 가치를 보여줍니다.";
		["GuiValueShowDEValues"]	= "마력 추출시 예상 가치를 보여줍니다.";
		["GuiValueTerse"]	= "간략한 마력 추출 가치를 보여줍니다.";
		["GuiWeighSettingsNote"]	= "위의 가중치는 명시된 양만큼 주어진 재료의 가치계산을 변경합니다. 더 혹은 덜 가치있다고 판단하지 않는 한, 일반적으로 100%로 두는 것이 좋습니다.";
		["GuiYes"]	= "예";

	};

	nlNL = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "Wissen van alle enchant gegevens";
		["FrmtActClearFail"]	= "Kan item niet vinden: %s";
		["FrmtActClearOk"]	= "Data gewist voor item: %s";
		["FrmtActDefault"]	= "Enchantrix' %s optie is teruggezet naar standaard instelling";
		["FrmtActDefaultAll"]	= "Alle Enchantrix opties zijn teruggezet naar standaard instelling.";
		["FrmtActDisable"]	= "Item's %s gegevens worden niet weergegeven";
		["FrmtActEnable"]	= "Item's %s gegevens worden weergegeven";
		["FrmtActSet"]	= "Stel %s naar '%s' in";
		["FrmtActUnknown"]	= "Onbekende opdracht: '%s'";
		["FrmtActUnknownLocale"]	= "De opgegeven taal ('%s') is onbekend. Geldige talen zijn:";
		["FrmtPrintin"]	= "Berichten van Enchantrix worden nu weergegeven op de \"%s\" chat frame";
		["FrmtUsage"]	= "Gebruik:";
		["MesgDisable"]	= "Uitschakelen automatisch laden van Enchantrix";
		["MesgNotloaded"]	= "Enchantrix is niet geladen. Type /enchantrix voor meer info.";

		-- Section: Command Options
		["OptFindBidauct"]	= "<zilver>";
		["OptFindBuyauct"]	= "<procent>";
		["OptLocale"]	= "<taal>";
		["OptPrintin"]	= "(<frameIndex>[Nummer]|<frameNaam>[Tekst])";

		-- Section: Commands
		["ShowTerse"]	= "Beknopt";
		["StatOff"]	= "Enchant gegevens worden niet getoond";
		["StatOn"]	= "De geconfigureerde enchant gegevens worden getoond";

		-- Section: Config Text
		["GuiLoad"]	= "Laden van Enchantrix";
		["GuiLoad_Always"]	= "altijd";
		["GuiLoad_Never"]	= "nooit";

		-- Section: Game Constants
		["ArgSpellname"]	= "Disenchant";
		["PatReagents"]	= "Reagents: (.+)";
		["TextCombat"]	= "Combat";
		["TextGeneral"]	= "General";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(ga naar http://enchantrix.org/ om uw data te delen)";
		["FrmtWelcome"]	= "Enchantrix v%s geladen";
		["MesgAuctVersion"]	= "Enchantrix heeft Auctioneer versie 3.4 of hoger nodig. Sommige functionaliteiten zijn niet beschikbaar totdat Auctioneer is geupgrade.";

		-- Section: Help Text
		["GuiClearall"]	= "Opschonen alle Enchantrix Data";
		["GuiClearallButton"]	= "Alles opschonen";
		["GuiClearallHelp"]	= "Klik hier om alle enchantrix data van de huidige Server/Realm op te schonen.";
		["GuiClearallNote"]	= "voor de huidige Server-factie";
		["GuiDefaultAll"]	= "Herstel alle Enchantrix Opties";
		["GuiDefaultAllButton"]	= "Herstel Alles";
		["GuiDefaultAllHelp"]	= "Klik hier om alle standaard waardes van de Enchantrix opties te laden. LET OP: Deze actie kan NIET ongedaan worde n gemaakt.";
		["GuiDefaultOption"]	= "Herstel deze instelling";
		["GuiLocale"]	= "Verander taal naar";
		["GuiMainEnable"]	= "Enchantrix Activeren";
		["GuiMainHelp"]	= "Bevat instellingen voor Enchantrix, een AddOn die mogelijke uitkomsten bij het disenchanten van een item weergeeft in een tooltip.";
		["GuiOtherHeader"]	= "Andere Opties";
		["GuiOtherHelp"]	= "Verschillende Enchantrix Opties";
		["GuiPrintin"]	= "Selecteer het gewenste berichten scherm";
		["GuiTerse"]	= "Activeer Beknopte Mode";
		["GuiValuateAverages"]	= "Taxatie met Auctioneer gemiddelden";
		["GuiValuateBaseline"]	= "Taxatie met Standaard Data";
		["GuiValuateEnable"]	= "Activeer Taxatie";
		["GuiValuateHeader"]	= "Taxatie";

		-- Section: Report Messages
		["FrmtBidbrokerCurbid"]	= "HuidigBod";
		["FrmtBidbrokerDone"]	= "Een regelend bod gedaan";
		["FrmtBidbrokerHeader"]	= "Een bod bespaart %s zilver op de gemiddelde disenchant waarde:";
		["FrmtBidbrokerLine"]	= "%s, Waarde van %s, %s: %s, Bespaard: %s, Minder %s, Tijd: %s";
		["FrmtBidbrokerMinbid"]	= "MinimaleBod";
		["FrmtPctlessDone"]	= "Percentage minder gedaan.";
		["FrmtPctlessHeader"]	= "Opkoop waarde bespaard %d%% op de gemiddelde disenchant waarde:";
		["FrmtPctlessLine"]	= "%s, Geschat op %s, BO: %s, Bespaar: %s, Minder %s";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Omroep Prijs (%d%% marge)";
		["FrmtDisinto"]	= "Gedisenchant in:";
		["FrmtFound"]	= "Gevonden dat %s wordt gedisenchant in:";
		["FrmtPriceEach"]	= "Prijs per item";
		["FrmtSuggestedPrice"]	= "Voorstel Prijs:";
		["FrmtTotal"]	= "Totaal";
		["FrmtValueAuctHsp"]	= "Disenchant Waarde";
		["FrmtValueAuctMed"]	= "Disenchant Waarde (Gemiddeld)";
		["FrmtValueMarket"]	= "Disenchant Waarde";
		["FrmtWarnAuctNotLoaded"]	= "Auctioneer niet geladen. Opgeslagen waardes worden gebruikt.";
		["FrmtWarnNoPrices"]	= "Geen prijs beschikbaar ";
		["FrmtWarnPriceUnavail"]	= "Sommige prijzen niet beschikbaar";

	};

	ptPT = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "A limpar toda a informação de enchanting";
		["FrmtActClearFail"]	= "Impossível encontrar objecto: %s";
		["FrmtActClearOk"]	= "Informação eliminada do objecto: %s";
		["FrmtActDefault"]	= "%s do Enchantrix voltaram às definições padrão";
		["FrmtActDefaultAll"]	= "Todas as opções Enchantrix revertidas para o normal.";
		["FrmtActDisable"]	= "Não está a ser mostrada informação do objecto %s";
		["FrmtActEnable"]	= "Está a ser mostrada informação do objecto %s";
		["FrmtActSet"]	= "Definir %s para '%s'";
		["FrmtActUnknown"]	= "Comando de palavra-chave desconhecido: '%s'";
		["FrmtActUnknownLocale"]	= "A localização dada ('%s') nao foi encontrada. Localizações válidas são:";
		["FrmtPrintin"]	= "Mensagens do Enchantrix vão ser mostradas no chat \"%s\"";
		["FrmtUsage"]	= "Uso:";
		["MesgDisable"]	= "A desactivar o carregamento automático do Enchantrix";
		["MesgNotloaded"]	= "Enchantrix não está carregado.  Escreva /enchantrix para mais informações.";

		-- Section: Command Options
		["CmdClearAll"]	= "todos";
		["OptClear"]	= "[Objecto]|todos";
		["OptDefault"]	= "(<opção>|todos)";
		["OptFindBidauct"]	= "<prata>";
		["OptFindBuyauct"]	= "<percentagem>";
		["OptLocale"]	= "<local>";
		["OptPrintin"]	= "(<frameIndex>[Número]<frameName>[Corda])";

		-- Section: Commands
		["CmdClear"]	= "apagar";
		["CmdDefault"]	= "por defeito";
		["CmdDisable"]	= "desactivar";
		["CmdHelp"]	= "ajuda";
		["CmdLocale"]	= "localização";
		["CmdOff"]	= "desligado";
		["CmdOn"]	= "ligado";
		["CmdPrintin"]	= "imprimir em";
		["CmdToggle"]	= "alternar";
		["ShowEmbed"]	= "embebido";
		["ShowGuessAuctioneerMed"]	= "valor médio";
		["ShowGuessBaseline"]	= "valor base";
		["ShowTerse"]	= "breve";
		["ShowValue"]	= "avaliar";
		["StatOff"]	= "Não está a ser mostrada informação do enchant";
		["StatOn"]	= "Está a ser mostrada a informação configurada do enchant";

		-- Section: Config Text
		["GuiLoad"]	= "A carregar Enchantrix";
		["GuiLoad_Always"]	= "sempre";
		["GuiLoad_Never"]	= "nunca";

		-- Section: Game Constants
		["ArgSpellname"]	= "Desencantar";
		["PatReagents"]	= "Reagentes: (.+)";
		["TextCombat"]	= "Combate";
		["TextGeneral"]	= "Geral";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(vai a http://enchantrix.org para partilhares a tua informação)";
		["FrmtWelcome"]	= "Enchantrix v%s carregado";
		["MesgAuctVersion"]	= "Enchantrix requer a versão 3.4 do Auctioneer ou mais elevado. Algumas características serão desligadas até que você actualize sua instalação do Auctioneer. ";

		-- Section: Help Text
		["GuiClearall"]	= "Limpar toda a informação do Enchantrix";
		["GuiClearallButton"]	= "Limpar tudo";
		["GuiClearallHelp"]	= "Carrega aqui para limpar toda a informação do Enchantrix do servidor actual.";
		["GuiClearallNote"]	= "para o servidor/facção actual";
		["GuiDefaultAll"]	= "Limpar todas as opções do Enchantrix";
		["GuiDefaultAllButton"]	= "Limpar tudo";
		["GuiDefaultAllHelp"]	= "Carrega aqui para voltar às definições padrão do Enchantrix. ATENÇÃO: Esta acção NÃO é reversível.";
		["GuiDefaultOption"]	= "Limpar esta definição";
		["GuiEmbed"]	= "Informação junta na tooltip do jogo";
		["GuiLocale"]	= "Definir localização para";
		["GuiMainEnable"]	= "Activar Enchantrix";
		["GuiMainHelp"]	= "Contém definições para o Enchantrix, um AddOn que mostra informação na tooltip dos objectos com possíveis resultados de desencantamento do dito objecto.";
		["GuiOtherHeader"]	= "Outras Opções";
		["GuiOtherHelp"]	= "Outras Opções do Enchantrix";
		["GuiPrintin"]	= "Seleccionar a expressão desejada da mensagem";
		["GuiTerse"]	= "Ligar modo breve";
		["GuiValuateAverages"]	= "Validar com as médias Auctioneer";
		["GuiValuateBaseline"]	= "Validar com a Data Padrão";
		["GuiValuateEnable"]	= "Activar Validação";
		["GuiValuateHeader"]	= "Validação";
		["GuiValuateMedian"]	= "Validar com os Números Médios Auctioneer";
		["HelpClear"]	= "Limpar a informação específica de um objecto (tem de carregar shift+click o objecto no comando) Também podes especificar a palavra especial \"Todos\"";
		["HelpDefault"]	= "Aplicar uma opção do Enchantrix para o seu Padrão. Também podes especificar a palavra especial \"Todos\" para por todos as opções Padrão.";
		["HelpDisable"]	= "Proíbir o Enchantrix de se ligar da próxima vez que entrar no jogo";
		["HelpEmbed"]	= "Encaixar o texto no tooltip original do jogo (nota: determinadas características são desligadas quando esta opção é selecionada)";
		["HelpFindBidauct"]	= "Encontrar os leilões cujo possível valor do desencanto é uma determinada quantidade de prata menos do que o preço de oferta";
		["HelpFindBuyauct"]	= "Encontrar os auctions cujo possível valor de desencanto é um determinado por cento menos do que o preço compra directa";
		["HelpGuessAuctioneerHsp"]	= "Se a validação estiver permitida, e você tiver o Auctioneer instalado, indicar o preço de venda (HSP) de disencanto do artigo. ";
		["HelpGuessAuctioneerMedian"]	= "Se a validação estiver permitida, e você tiver o Auctioneer instalado, indicar o valor baseado mediano de disencanto do artigo. ";
		["HelpGuessBaseline"]	= "Se a validação for permitida, (Auctioneer não necessitado) indicar o valor da linha de base de disencanto do artigo, baseado nos preços inbutidos. ";
		["HelpGuessNoauctioneer"]	= "Se a validação for permitida, (Auctioneer não necessitado) indicar o valor da linha de base de disencanto do artigo, baseado nos preços inbutidos";
		["HelpLoad"]	= "Mudar as opções de carregamento para este personagem";
		["HelpLocale"]	= "Mudar a localização que é usada para mostrar as mensagens do Enchantrix";
		["HelpOnoff"]	= "Liga e Desliga a exposição de dados do Enchant";
		["HelpPrintin"]	= "Selecionar em que janela o Enchantrix irá imprimir as suas mensagens. Poderás expecificar o nome da janela ou o inicio da janela.";
		["HelpTerse"]	= "Ligar/Desligar o modo breve, montrando somente o valor do desencanto. Pode ser sobreposto carregando na tecla Ctrl.";
		["HelpValue"]	= "Seleccionar se quer ver os valores estimados baseados em proporções possiveis dos desencantos.";

		-- Section: Report Messages
		["FrmtBidbrokerCurbid"]	= "Ofcur";
		["FrmtBidbrokerDone"]	= "Oferta do corrector feita";
		["FrmtBidbrokerHeader"]	= "As ofertas que têm as economias de prata de %s na média do valor disencanto:";
		["FrmtBidbrokerLine"]	= "%s, Avaliado em: %s, %s: %s, Excepto: %s, Menos %s, Tempo: %s";
		["FrmtBidbrokerMinbid"]	= "Ofmin";
		["FrmtPctlessDone"]	= "Percentagem menos feito";
		["FrmtPctlessHeader"]	= "As Compras Directas que têm excesso do artigo médio das economias de %d%% do valor do desencanto: ";
		["FrmtPctlessLine"]	= "%s, Avaliado em: %s, BO: %s, Excepto: %s, Menos %s ";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Preço de Vendedor (%d%% margem)";
		["FrmtDisinto"]	= "Desencanta em:";
		["FrmtFound"]	= "Observado que %s desencanta em: ";
		["FrmtPriceEach"]	= "(%s cada)";
		["FrmtSuggestedPrice"]	= "Preço sugerido:";
		["FrmtTotal"]	= "Total";
		["FrmtValueAuctHsp"]	= "Valor do Desencanto (MPV)";
		["FrmtValueAuctMed"]	= "Valor do Desencanto (Números médios)";
		["FrmtValueMarket"]	= "Valor de Disencanto (Referência)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer não carregado, usando preços em cache]";
		["FrmtWarnNoPrices"]	= "[Nenhuns Preços Disponiveis]";
		["FrmtWarnPriceUnavail"]	= "[Alguns preços indisponiveis]";

	};

	ruRU = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "Очищает всю информацию о энчантах";
		["FrmtActClearFail"]	= "Не могу найти предмет: %s";
		["FrmtActClearOk"]	= "Очищена информация о предмете: %s";
		["FrmtActDefault"]	= "Опция %s Enchantrix'а была сброшена на уст.по умолчанию";
		["FrmtActDefaultAll"]	= "Все опции Enchantrix'а были сброшены на уст.по умолчанию\n";
		["FrmtActDisable"]	= "Не показывать данные по вещи %s";
		["FrmtActEnable"]	= "Показывать данные по вещи %s\n";
		["FrmtActSet"]	= "Установите %s до '%s'\n";
		["FrmtActUnknown"]	= "Неизвестная команда: '%s'\n";
		["FrmtActUnknownLocale"]	= "Locale, котор вы определили ('%s') неизвестны. Действительные locales являются следующими:\n";
		["FrmtPrintin"]	= "Сообщения Encantrix'а теперь будут печататься в чате \"%s\"\n";
		["FrmtUsage"]	= "Использование:\n";
		["MesgDisable"]	= "Отключить автоматическую загрузку Enchantrix'а\n";
		["MesgNotloaded"]	= "Enchantrix не загружен. Напечатайте /enchantrix для большей информации.\n";

		-- Section: Command Options
		["CmdClearAll"]	= "все\n";
		["OptClear"]	= "([Item]|all) ";
		["OptDefault"]	= "(<option>|all) ";
		["OptFindBidauct"]	= "<silver> ";
		["OptFindBuyauct"]	= "<percent> ";
		["OptLocale"]	= "<locale> ";
		["OptPrintin"]	= "(<frameIndex>[Number]|<frameName>[String]) ";

		-- Section: Commands
		["CmdClear"]	= "Очистить";
		["CmdDefault"]	= "Стандартные";
		["CmdDisable"]	= "выведите из строя\n";
		["CmdFindBidauct"]	= "bidbroker ";
		["CmdFindBidauctShort"]	= "bb ";
		["CmdFindBuyauct"]	= "percentless ";
		["CmdFindBuyauctShort"]	= "pl ";
		["CmdHelp"]	= "помощь\n";
		["CmdOff"]	= "off";
		["CmdOn"]	= "на\n";
		["CmdPrintin"]	= "print-in ";
		["CmdToggle"]	= "переключить";
		["ShowDELevels"]	= "уровни";
		["ShowDEMaterials"]	= "материалы";
		["ShowGuessAuctioneerVal"]	= "valueate-val";
		["ShowTerse"]	= "сжатый";
		["ShowUI"]	= "показать";
		["StatOff"]	= "Не показывать данные зачарования";
		["StatOn"]	= "Показывать сконфигурированные данные по зачарованию ";

		-- Section: Config Text
		["GuiLoad"]	= "Загрузить Enchantrix ";
		["GuiLoad_Always"]	= "всегда";
		["GuiLoad_Never"]	= "никогда";

		-- Section: Game Constants
		["ArgSpellname"]	= "Снятие чар";
		["ArgSpellProspectingName"]	= "Старательство";
		["Enchanting"]	= "Наложение чар";
		["Inscription"]	= "Надпись";
		["Jewelcrafting"]	= "Ювелирное дело";
		["PatReagents"]	= "Реагенты: (.+) ";
		["TextCombat"]	= "Бой";
		["TextGeneral"]	= "Основной";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(на http://enchantrix.org/ можо поделиться своими данными)";
		["FrmtWelcome"]	= "Enchantrix v%s загружен";
		["MesgAuctVersion"]	= "Для Enchantrix требуется Auctioneer версии 3.4 или выше. Некоторые функции будут недоступны, пока вы не обновите Auctioneer.";

		-- Section: Help Text
		["GuiClearall"]	= "Обнулить все данные Enchantrix";
		["GuiClearallButton"]	= "Обнулить всё";
		["GuiClearallHelp"]	= "Нажмите сюда, чтобы обнулить все данные Enchantrix для текущего сервера.";
		["GuiClearallNote"]	= "для текущих сервера-фракции";
		["GuiDefaultAll"]	= "Восстановить все настройки Enchantrix по умолчанию";
		["GuiDefaultAllButton"]	= "Сбросить всё";
		["GuiDefaultAllHelp"]	= "Нажмите сюда для возврата всех настроек Enchantrix к их первоначальным значениям. ВНИМАНИЕ: Это действие НЕЛЬЗЯ ОТМЕНИТЬ.";
		["GuiDefaultOption"]	= "Восстановить данный параметр";
		["GuiDELevels"]	= "Показать требования к уровню разбиения в подсказке";
		["GuiDEMaterials"]	= "Показать материалы разбиения в подсказке";
		["GuiEmbed"]	= "Внедрить информацию в игровую подсказку";
		["GuiLocale"]	= "Сменить локаль на";
		["GuiMainEnable"]	= "Включить Enchantrix";
		["GuiMainHelp"]	= "Содержит настройки для Enchantrix, аддона, который показывает во всплывающей подсказке предмета информацию о возможных результатах его разбиения.";
		["GuiOtherHeader"]	= "Другие настройки";
		["GuiOtherHelp"]	= "Различные настройки Enchantrix ";
		["GuiPrintin"]	= "Выбирает желаемое окно сообщений";
		["GuiPrintYieldsInChat"]	= "Показать добычу из вещей в чате";
		["GuiTerse"]	= "Включить сжатый режим";
		["GuiValuateAverages"]	= "Оценивать по средним ценам Auctioneer-а";
		["GuiValuateBaseline"]	= "Оценивать по встроенным данным";
		["GuiValuateEnable"]	= "Разрешить оценку";
		["GuiValuateHeader"]	= "Оценка";
		["GuiValuateMedian"]	= "Оценивать с медианными значениями Auctioneer";
		["HelpClear"]	= "Очистить данные для определённого предмета (\"Shift+щелчок\" для вставки предмета в команду). Вы также можете использовать специальное ключевое слово \"all\".";
		["HelpDefault"]	= "Установить опцию к значению по умолчанию. Вы также можете использовать специальное ключевое слово \"all\" для установки всех настроек Enchantrix'а к их значениям по умолчанию.";
		["HelpDisable"]	= "Не загружать enchantrix в следующий раз, когда Вы войдете в игру.";
		["HelpEmbed"]	= "Внедрить текст в оригинальные игровые подсказки. (Замечание: некоторые возможности будут отключены при выборе этой опции).";
		["HelpFindBidauct"]	= "Поиск аукционов, возможная стоимость которых после разбиения на заданное количество серебряных монет ниже стоимости ставки.";
		["HelpFindBuyauct"]	= "Поиск аукционов, чьи цены выкупа равны определённому проценту, меньшему, чем возможная ценность разбиения (и опционально - определённому количеству, меньшему, чем ценность разбиения).";
		["HelpGuessAuctioneer5Val"]	= "Если определение стоимости включено и Аукционер установлен, то отображаются рыночные цены на разбиение предмета.";
		["HelpGuessAuctioneerHsp"]	= "Если определение стоимости включено и Аукционер установлен, то отображается оценка цены продажи (HSP) для разбиваемого предмета.";
		["HelpGuessAuctioneerMedian"]	= "Если оценка разрешена, и вы установили Auctioneer, то отображается средняя цена разбиения предмета.";
		["HelpGuessBaseline"]	= "Если определение стоимости включено (установленный Аукционер не нужен), то отображает базовую стоимость разбиваемого предмета, основанную на встроенных ценах.";
		["HelpGuessNoauctioneer"]	= "Команды для оценки не доступны, так как у Вас не установлен Аукционер.";
		["HelpLoad"]	= "изменить настройки Enchantrix-а, загрузив их с этого профиля";
		["HelpLocale"]	= "Изменить локаль, которая используется для отображения сообщений Enchantrix'а.";
		["HelpOnoff"]	= "Включает и отключает отображение данных инчанта.";
		["HelpPrintin"]	= "Выбор, как окно Enchantix-а будет выводить сообщения. Вы можете настроить название рамки или индекс.";
		["HelpShowDELevels"]	= "Определяет, отображать ли в подсказке уровень скила зачарования, необходимый для разбиения предмета.";
		["HelpShowDEMaterials"]	= "Определяет, показывать ли возможные продукты разбиения во всплывающей подсказке предмета.";
		["HelpShowUI"]	= "Показать или спрятать панель настроек.";
		["HelpTerse"]	= "Включение/выключение сжатого режима, показывающего только стоимость разбиения. Может быть временно отключен путём удержания клавиши \"Ctrl\".";
		["HelpValue"]	= "Выбирает отображать или нет оценённую стоимость предмета основанную на соотношениях возможного разбиения.";

		-- Section: Report Messages
		["AuctionScanAuctNotInstalled"]	= "Вы не установили Auctioneer. Auctioner должен быть установлен для того, чтобы сканировать аукцион.";
		["AuctionScanVersionTooOld"]	= "У Вас установлена неправильная версия Auctioneer, эта функция требует Auctioneer версии 4.0 или выше.";
		["ChatDeletedProfile"]	= "Профиль удалён:";
		["ChatResetProfile"]	= "Очищены все настройки для:";
		["ChatSavedProfile"]	= "Профиль сохранён:";
		["ChatUsingProfile"]	= "Теперь используется профиль:";
		["FrmtAutoDeActive"]	= "Автоматическое `Разрушение чар` включено";
		["FrmtAutoDeDisabled"]	= "Автоматическое `Разрушение чар` отключено";
		["FrmtAutoDeDisenchantCancelled"]	= "`Разрушение чар` отменено: предмет не найден";
		["FrmtAutoDeDisenchanting"]	= "Разрушение чар на %s";
		["FrmtAutoDeIgnorePermanent"]	= "%s игнорируется постоянно";
		["FrmtAutoDeIgnoreSession"]	= "%s игнорируется в течение сессии";
		["FrmtAutoDeInactive"]	= "Автоматическое `Разрушение чар` не действует";
		["FrmtAutoDeProspectCancelled"]	= "Старательство отменено: предмет не найден.";
		["FrmtAutoDeProspecting"]	= "Старательство %s";
		["FrmtBidbrokerCurbid"]	= "текСтавка";
		["FrmtBidbrokerDone"]	= "Ставка перебита";
		["FrmtBidbrokerHeader"]	= "Предлагает наличие %s сохранений серебра в средней цене разбиения (min %%less = %d):";
		["FrmtBidbrokerLine"]	= "%s, Оценено как: %s, %s: %s, Сохранение: %s, Less %s, Время: %s";
		["FrmtBidbrokerMinbid"]	= "минСтавка";
		["FrmtBidBrokerSkipped"]	= "Пропущенные %d аукционы благодаря сокращению размера прибыли (%d%%)";
		["FrmtBidBrokerSkippedBids"]	= "Пропущенные %d аукционы благодаря существующим предложениям цены";
		["FrmtPctlessDone"]	= "Менее сделанный процент.";
		["FrmtPctlessHeader"]	= "покупки имеющие %d%% сохранения над средней ценой разбиения";
		["FrmtPctlessLine"]	= "%s, Оценено: %s, БО: %s, Сохранено: %s, Меньше %s";
		["FrmtPctlessSkillSkipped"]	= "Пропущенные %d аукционы из-за недостаточного уровня навыка";
		["FrmtPctlessSkipped"]	= "Пропущенные %d аукционы благодаря сокращению прибыльности (%s)";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Прайс банкира (%d%% край) ";
		["FrmtDisinto"]	= "Разбивается на:";
		["FrmtFound"]	= "Найдено что %s разбивается на: ";
		["FrmtFoundNotDisenchant"]	= "Найдено %s не разбивается";
		["FrmtMillingValueAuctHsp"]	= "Значение разбиения (HPS)";
		["FrmtMillingValueAuctMed"]	= "Значение разбиения (Среднее)";
		["FrmtMillingValueAuctVal"]	= "Значение разбиения(АукСовет)";
		["FrmtMillingValueMarket"]	= "Значение разбиения (Базовая стоимость)";
		["FrmtMillsInto"]	= "Разобьется в:";
		["FrmtPriceEach"]	= "(%s за шт.)";
		["FrmtProspectFound"]	= "Найдено %s перспективных:";
		["FrmtProspectInto"]	= "Перспективы в: ";
		["FrmtProspectValueAuctHsp"]	= "Перспективные цены (HSP)";
		["FrmtProspectValueAuctMed"]	= "Перспективные цены (среднее)";
		["FrmtProspectValueAuctVal"]	= "Перспективные цены (АукСовет)";
		["FrmtProspectValueMarket"]	= "Перспективные цены (база)";
		["FrmtSuggestedPrice"]	= "Рекомендуемая цена:";
		["FrmtTotal"]	= "Итого";
		["FrmtValueAuctHsp"]	= "Цена разбиения (HSP) ";
		["FrmtValueAuctMed"]	= "Цена разбиения (среднее) ";
		["FrmtValueAuctVal"]	= "Цена разбиения (АукСовет) ";
		["FrmtValueFixedVal"]	= "Цена разбиения (Фиксир) ";
		["FrmtValueMarket"]	= "Цена разбиения Основная)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer не загружен, использую полученные ранее данные]";
		["FrmtWarnNoPrices"]	= "[Цены неизвестны]";
		["FrmtWarnPriceUnavail"]	= "[Некоторые цены неизвестны]";
		["TooltipMillingLevel"]	= "Разборка требует уровень умения %d";
		["TooltipProspectLevel"]	= "Для старательства необходим уровень умения %d";
		["TooltipShowDisenchantLevel"]	= "Для разбиения необходим уровень умения %d";

		-- Section: User Interface
		["ExportPriceAucAdv"]	= "Экспорт цен Enchantrix в AuctioneerAdvanced";
		["GuiActivateProfile"]	= "Активировать выбранный профиль";
		["GuiAutoDeEnable"]	= "Просмотр сумок на предмет дизинчантящихся предметов - ИСПОЛЬЗОВАТЬ С ОСТОРОЖНОСТЬЮ.";
		["GuiAutoDeOptions"]	= "Автоматизация";
		["GuiAutoDePromptLine1"]	= "Вы действительно хотите дизэнчант";
		["GuiAutoDePromptLine3"]	= "Оценено:";
		["GuiAutoProspectPromptLine1"]	= "Вы хотите проспектить";
		["GuiBBUnbiddedOnly"]	= "Ограничить (BidBroker) только на вещи без ставок";
		["GuiConfigProfiles"]	= "Установка, конфигурация и редактирование профилей";
		["GuiCreateReplaceProfile"]	= "Создать или заменить профиль";
		["GuiDefaultBBProfitPercent"]	= "Процент bidbroker-а по умолчанию: %d";
		["GuiDefaultLessHSP"]	= "Процент по умолчанию HSP: %d";
		["GuiDefaultProfitMargin"]	= "Размер Типовой Прибыли:";
		["GuiDeleteProfileButton"]	= "Удалить";
		["GuiFixedSettings"]	= "Фиксированные цены реагентов";
		["GuiFixedSettingsNote"]	= "Примечание: Эти значения будут использоваться вместо Auctioneer-а или любых других методов оценки, если галка включена. На следующие цены все еще воздействует вес реагентов в предыдущей секции, так, если вы хотите убедиться, что реагент оценивается точно в указанном количестве ниже, то также убедитесь, что это - вес устанавливается к 100% в секции веса.";
		["GuiGeneralOptions"]	= "Главные опции Enchantrix";
		["GuiIgnore"]	= "Игнорировать";
		["GuiItemValueAuc4HSP"]	= "HSP для Аук";
		["GuiItemValueAuc4Median"]	= "Средняя для Аук";
		["GuiItemValueAuc5Appraiser"]	= "Значение оценщика (Appraiser) для АукСовет";
		["GuiItemValueAuc5Market"]	= "Рыночная цена для АукСовет ";
		["GuiItemValueAverage"]	= "Среднее (по умолчанию)";
		["GuiItemValueBaseline"]	= "Базовая на рынке";
		["GuiItemValueCalc"]	= "Цена предмета, расчитаная от";
		["GuiMaxBuyout"]	= "Максимальная продажная цена";
		["GuiMillingingValues"]	= "Показывать предпологаемые значения разбиения";
		["GuiMillingLevels"]	= "Показывать требуемый уровень разбиения в интсрументах";
		["GuiMillingMaterials"]	= "Показывать инфо о материалах в инструментах";
		["GuiMillingOptions"]	= "Опции Разбиения";
		["GuiMinBBProfitPercent"]	= "Минимальный процент для ставки при перебивании на аукционе:";
		["GuiMinimapButtonAngle"]	= "Угол наклона кнопки: %d";
		["GuiMinimapButtonDist"]	= "Расстояние: %d";
		["GuiMinimapOptions"]	= "Опции отображения на миникарте";
		["GuiMinimapShowButton"]	= "Отображать кнопку на миникарте";
		["GuiMinLessHSP"]	= "Миниманльный процент меньше HSP: %d";
		["GuiMinProfitMargin"]	= "Размер Минимальной Прибыли:";
		["GuiNewProfileName"]	= "Имя нового профиля";
		["GuiNo"]	= "Нет";
		["GuiPLBBOnlyBelowDESkill"]	= "Показывать только вещи, которые позволяет разобрать текущий скил зачаровывания";
		["GuiPLBBSettings"]	= "Проценты и настройки ставок";
		["GuiProspectingLevels"]	= "Показывать рекомендуемый уровень проспектинга в окне подсказки";
		["GuiProspectingMaterials"]	= "Показывать материалы проспектинга в окне подсказки";
		["GuiProspectingOptions"]	= "Опции Проспектинга";
		["GuiProspectingValues"]	= "Показать предварительные перспективные цены";
		["GuiResetProfileButton"]	= "Сбросить";
		["GuiSaveProfileButton"]	= "Сохранить";
		["GuiShowProspecting"]	= "Показывать данные проспектинга для руды";
		["GuiTabAuctions"]	= "Аукционы";
		["GuiTabFixed"]	= "Фиксированая цена";
		["GuiTabGeneral"]	= "Главная";
		["GuiTabMilling"]	= "Разбиение";
		["GuiTabProfiles"]	= "Профили";
		["GuiTabProspecting"]	= "Проспектинг";
		["GuiTabWeights"]	= "Вес";
		["GuiValueOptions"]	= "Настройки показа цены";
		["GuiValueShowAuc4HSP"]	= "Показывать HSP Аукционера для цены";
		["GuiValueShowAuc4Median"]	= "Показывать среднюю цену аукционкра";
		["GuiValueShowAuc5Market"]	= "показывать рыночную цену аукционера";
		["GuiValueShowBaseline"]	= "показывать базовые цены";
		["GuiValueShowDEValues"]	= "показывать приблизительную стоимость разбиения";
		["GuiValueTerse"]	= "Покажите сжатую цену разбиения";
		["GuiWeighSettingsNote"]	= "Вес измененой оценки предоставленного реагента указанным количеством. В общем вы захотите их в 100%, если бы знали, что они должны быть приблизительно равны, чем метод оценки, который вы используете.";
		["GuiWeightSettings"]	= "Желательный реагент при разбиении";
		["GuiYes"]	= "Да";

	};

	trTR = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "TÃ¼m enchant verilerini siliyor";
		["FrmtActClearFail"]	= "Cisim bulunamadÄ±: %s";
		["FrmtActClearOk"]	= "Verileri silinen cisim: %s";
		["FrmtActDefault"]	= "Enchantrix'in %s seÃ§eneÄŸi varsayÄ±lan haline dÃ¶ndÃ¼rÃ¼ldÃ¼.";
		["FrmtActDefaultAll"]	= "TÃ¼m Enchantrix seÃ§enekleri varsayÄ±lan hallerine dÃ¶ndÃ¼rÃ¼ldÃ¼.";
		["FrmtActDisable"]	= "Cismin %s verisi gÃ¶sterilmiyor";
		["FrmtActEnable"]	= "Cismin %s verisi gÃ¶steriliyor";
		["FrmtActSet"]	= "%s yi '%s' ye ayarla";
		["FrmtActUnknown"]	= "Bilinmeyen komut anahtar kelimesi: '%s' ";

		-- Section: Commands
		["CmdDisable"]	= "iptal";

	};

	zhCN = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "清除全部附魔数据。";
		["FrmtActClearFail"]	= "无法找到物品：%s。";
		["FrmtActClearOk"]	= "物品：%s的数据已清除。";
		["FrmtActDefault"]	= "附魔助手的选项已重置为默认值。";
		["FrmtActDefaultAll"]	= "所有附魔助手选项已重置为默认值。";
		["FrmtActDisable"]	= "不显示物品的%s数据。";
		["FrmtActEnable"]	= "显示物品的%s数据。";
		["FrmtActSet"]	= "设置%s为'%s'。";
		["FrmtActUnknown"]	= "未知命令关键字：'%s'。";
		["FrmtActUnknownLocale"]	= "你输入的地域代码('%s')未知。有效的地域代码为：";
		["FrmtPrintin"]	= "附魔助手信息现在将显示在\"%s\"对话框。";
		["FrmtUsage"]	= "用途：";
		["MesgDisable"]	= "禁用自动加载附魔助手。";
		["MesgNotloaded"]	= "附魔助手没有加载。键入/enchantrix以获取更多信息。";

		-- Section: Command Options
		["CmdClearAll"]	= "all全部";
		["OptClear"]	= "([物品]|all全部)";
		["OptDefault"]	= "(<选项>|all全部)";
		["OptFindBidauct"]	= "<银币>";
		["OptFindBuyauct"]	= "<比率>";
		["OptLocale"]	= "<地域代码>";
		["OptPrintin"]	= "(<窗口标签>[数字]|<窗口名称>[字符串])";

		-- Section: Commands
		["CmdClear"]	= "clear清除";
		["CmdDefault"]	= "default默认";
		["CmdDisable"]	= "disable禁用";
		["CmdFindBidauct"]	= "bidbroker出价代理";
		["CmdFindBidauctShort"]	= "bb(出价代理的缩写)";
		["CmdFindBuyauct"]	= "percentless比率差额";
		["CmdFindBuyauctShort"]	= "pl(比率差额的缩写)";
		["CmdHelp"]	= "help帮助";
		["CmdLocale"]	= "locale地域代码";
		["CmdOff"]	= "off关";
		["CmdOn"]	= "on开";
		["CmdPrintin"]	= "print-in输出于";
		["CmdToggle"]	= "toggle开关转换";
		["ShowDELevels"]	= "levels等级";
		["ShowDEMaterials"]	= "materials材料";
		["ShowEmbed"]	= "embed嵌入";
		["ShowGuessAuctioneerHsp"]	= "valuate-hsp估价-最高";
		["ShowGuessAuctioneerMed"]	= "valuate-median估价-中值";
		["ShowGuessAuctioneerVal"]	= "valueate-val";
		["ShowGuessBaseline"]	= "valuate-baseline估价-基准";
		["ShowTerse"]	= "terse简洁";
		["ShowUI"]	= "show显示";
		["ShowValue"]	= "valuate估价";
		["StatOff"]	= "不显示任何分解数据";
		["StatOn"]	= "显示设定的分解数据";

		-- Section: Config Text
		["GuiLoad"]	= "加载附魔助手。";
		["GuiLoad_Always"]	= "总是";
		["GuiLoad_Never"]	= "从不";

		-- Section: Game Constants
		["ArgSpellname"]	= "分解";
		["ArgSpellProspectingName"]	= "选矿";
		["Enchanting"]	= "附魔";
		["Jewelcrafting"]	= "珠宝加工";
		["PatReagents"]	= "材料：(.+)";
		["TextCombat"]	= "战斗";
		["TextGeneral"]	= "普通";

		-- Section: Generic Messages
		["FrmtCredit"]	= "(去http://enchantrix.org/网站共享数据)";
		["FrmtWelcome"]	= "附魔助手(Enchantrix) v%s 已加载！";
		["MesgAuctVersion"]	= "Enchantrix需要Auctioneer版本3.4或更高。某些特性会失效请升级你的Auctioneer";

		-- Section: Help Text
		["GuiClearall"]	= "清除全部附魔助手数据。";
		["GuiClearallButton"]	= "全部清除";
		["GuiClearallHelp"]	= "点此清除对于当前服务器-阵营的全部附魔助手数据。";
		["GuiClearallNote"]	= "对于当前服务器-阵营";
		["GuiDefaultAll"]	= "重置全部附魔助手设置。";
		["GuiDefaultAllButton"]	= "全部重置";
		["GuiDefaultAllHelp"]	= "点此重置全部附魔助手选项为默认值。警告：此操作无法还原。";
		["GuiDefaultOption"]	= "重置该设置";
		["GuiDELevels"]	= "在提示中显示分解需要的等级";
		["GuiDEMaterials"]	= "在提示中显示分解材料信息";
		["GuiEmbed"]	= "信息显示在游戏默认提示中。";
		["GuiLocale"]	= "设置地域代码为";
		["GuiMainEnable"]	= "启用附魔助手。";
		["GuiMainHelp"]	= "包含插件 - 附魔助手的设置。它用于显示物品分解产物信息。";
		["GuiOtherHeader"]	= "其他选项";
		["GuiOtherHelp"]	= "附魔助手杂项";
		["GuiPrintin"]	= "选择期望的讯息窗口。";
		["GuiTerse"]	= "开启简洁模式";
		["GuiValuateAverages"]	= "以拍卖助手平均价进行估价。";
		["GuiValuateBaseline"]	= "以内置数据估价。";
		["GuiValuateEnable"]	= "启用估价。";
		["GuiValuateHeader"]	= "估价";
		["GuiValuateMedian"]	= "以拍卖助手中位数价进行估价。";
		["HelpClear"]	= "清除指定物品的数据(必须Shift+点击将物品插入命令)。你也可以指定特定关键字\"all\"。";
		["HelpDefault"]	= "设置某个附魔助手选项为默认值。你也可以输入特定关键字\"all\" 来设置所有附魔助手选项为默认值。";
		["HelpDisable"]	= "阻止附魔助手下一次登录时自动加载。";
		["HelpEmbed"]	= "嵌入文字到原游戏提示中(提示：某些特性在该模式下禁用)。";
		["HelpFindBidauct"]	= "找到拍卖品其可能分解价值低于竞拍价一定银币额。";
		["HelpFindBuyauct"]	= "找到拍卖品其可能分解价值低于一口价一定比率。";
		["HelpGuessAuctioneer5Val"]	= "开启估价并且拍卖助手开启，就显示物品分解的市场价。";
		["HelpGuessAuctioneerHsp"]	= "如果启用估价，并且安装了拍卖行助手(Auctioneer)，显示对于物品分解的曾售价格(最高价)。";
		["HelpGuessAuctioneerMedian"]	= "如果启用估价，并且安装了拍卖助手(Auctioneer)，显示基于物品分解估价的中位数。";
		["HelpGuessBaseline"]	= "如果启用估价，显示对于物品分解的基准估价，基于系统内置价格(不需要拍卖助手Auctioneer)。";
		["HelpGuessNoauctioneer"]	= "价格评估上限与价格评估中位数命令不能使用是因为没有安装拍卖助手。";
		["HelpLoad"]	= "改变附魔助手的加载设置。";
		["HelpLocale"]	= "更改附魔助手显示讯息的地域代码。";
		["HelpOnoff"]	= "打开/关闭附魔数据的显示。";
		["HelpPrintin"]	= "选择附魔助手使用哪个窗口来显示输出讯息。你可以指定窗口名称或索引。";
		["HelpShowDELevels"]	= "在提示中选择是否显示分解物品需要的附魔技能。";
		["HelpShowDEMaterials"]	= "在提示中选择否是显示分解物品产生材料。";
		["HelpShowUI"]	= "显示或隐藏设置面板。";
		["HelpTerse"]	= "开启/关闭简洁模式，只显示分解价值。能持续忽略控制键。";
		["HelpValue"]	= "选择是否显示物品基于可能分解几率的预计价值。";

		-- Section: Report Messages
		["AuctionScanAuctNotInstalled"]	= "你没有安装拍卖助手。拍卖助手必须安装并执行一次扫描。";
		["AuctionScanVersionTooOld"]	= "你没有正确安装拍卖助手。此特性需要拍卖助手4.0以上。";
		["ChatDeletedProfile"]	= "删除配置：";
		["ChatResetProfile"]	= "重置所有设置：";
		["ChatSavedProfile"]	= "保存配置：";
		["ChatUsingProfile"]	= "现在使用配置：";
		["FrmtAutoDeActive"]	= "自动分解-激活";
		["FrmtAutoDeDisabled"]	= "自动分解-关闭";
		["FrmtAutoDeDisenchantCancelled"]	= "分解已取消：物品没找到";
		["FrmtAutoDeDisenchanting"]	= "分解 %s";
		["FrmtAutoDeIgnorePermanent"]	= "忽视 %s 永久";
		["FrmtAutoDeIgnoreSession"]	= "忽视 %s 本次连接";
		["FrmtAutoDeInactive"]	= "自动分解-无效";
		["FrmtBidbrokerCurbid"]	= "目前的拍卖价";
		["FrmtBidbrokerDone"]	= "交易价代理完成";
		["FrmtBidbrokerHeader"]	= "比平均分解价值节省%s出价(最少%%差额= %d)：";
		["FrmtBidbrokerLine"]	= "%s，估价：%s，%s：%s，节省：%s，差额%s，次数：%s";
		["FrmtBidbrokerMinbid"]	= "最低拍卖价";
		["FrmtBidBrokerSkipped"]	= "所需利润率不足(%d%%),跳过%d拍卖";
		["FrmtBidBrokerSkippedBids"]	= "所需出价不足,跳过%d拍卖";
		["FrmtPctlessDone"]	= "比率差额完成。";
		["FrmtPctlessHeader"]	= "节省超过平均物品分解价值%d%%一口价(最少节省 = %s):";
		["FrmtPctlessLine"]	= "%s，估价：%s，一口价：%s，节省：%s，差额%s";
		["FrmtPctlessSkillSkipped"]	= "所需技能等级不够(%s),跳过%d拍卖\n";
		["FrmtPctlessSkipped"]	= "所需收益率不足(%s),跳过%d拍卖";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Barker价格(%d%% 最低利润)";
		["FrmtDisinto"]	= "可分解为:";
		["FrmtFound"]	= "发现%s可分解为：";
		["FrmtFoundNotDisenchant"]	= "发现%s不可分解";
		["FrmtPriceEach"]	= "(每件%s)";
		["FrmtSuggestedPrice"]	= "建议价格：";
		["FrmtTotal"]	= "合计";
		["FrmtValueAuctHsp"]	= "分解价值(最高)";
		["FrmtValueAuctMed"]	= "分解价值(中位数)";
		["FrmtValueAuctVal"]	= "分解价值(AucAdv)";
		["FrmtValueMarket"]	= "分解价值(基准)";
		["FrmtWarnAuctNotLoaded"]	= "[拍卖助手未加载，使用缓存中的价格]";
		["FrmtWarnNoPrices"]	= "[无价格信息]";
		["FrmtWarnPriceUnavail"]	= "[某些价格信息不可用]";
		["TooltipShowDisenchantLevel"]	= "分解必要技能%d";

		-- Section: User Interface
		["ExportPriceAucAdv"]	= "将Enchantrix的价格信息导出到AuctioneerAdvanced";
		["GuiActivateProfile"]	= "激活当前配置";
		["GuiAutoDeOptions"]	= "自动";
		["GuiAutoDePromptLine1"]	= "确认要分解：";
		["GuiAutoDePromptLine3"]	= "贵重的%s";
		["GuiBBUnbiddedOnly"]	= "仅代理无人出价的物品";
		["GuiConfigProfiles"]	= "设置或编辑配置";
		["GuiCreateReplaceProfile"]	= "创建或替换配置";
		["GuiDefaultBBProfitPercent"]	= "默认代理收益率：%d";
		["GuiDefaultLessHSP"]	= "默认最高售价差额率:%d";
		["GuiDefaultProfitMargin"]	= "默认利润率：";
		["GuiDeleteProfileButton"]	= "删除";
		["GuiFixedSettings"]	= "修复药剂价格";
		["GuiFixedSettingsNote"]	= "注：这些值将改用拍卖或任何其他估价方法，如果复选框被检查。以下值仍在受试剂重量在上一节，所以如果你想要确保试剂价值刚好指定金额下面，然后又确保它的重量定为100 ％ ，在重节。--机械翻译...";
		["GuiGeneralOptions"]	= "常规附魔助手选项";
		["GuiIgnore"]	= "忽略";
		["GuiItemValueAuc4HSP"]	= "Auc最高售价";
		["GuiItemValueAuc4Median"]	= "Auc中位数";
		["GuiItemValueAuc5Market"]	= "AucAdv市场价";
		["GuiItemValueAverage"]	= "均价(默认)";
		["GuiItemValueBaseline"]	= "市场基准";
		["GuiItemValueCalc"]	= "计算物品价格";
		["GuiMaxBuyout"]	= "最大一口价：";
		["GuiMinBBProfitPercent"]	= "最低代理收益率：%d";
		["GuiMinimapButtonAngle"]	= "按钮位置：%d";
		["GuiMinimapButtonDist"]	= "间隔:%d";
		["GuiMinimapOptions"]	= "小地图显示选项";
		["GuiMinimapShowButton"]	= "显示小地图按钮";
		["GuiMinLessHSP"]	= "最低最高售价差额率:%d";
		["GuiMinProfitMargin"]	= "最低利润率：";
		["GuiNewProfileName"]	= "新配置文件名：";
		["GuiNo"]	= "否";
		["GuiPLBBOnlyBelowDESkill"]	= "仅显示当前技能可分解物品";
		["GuiPLBBSettings"]	= "差额率与代理设置";
		["GuiResetProfileButton"]	= "重置";
		["GuiSaveProfileButton"]	= "保存";
		["GuiTabAuctions"]	= "拍卖";
		["GuiTabGeneral"]	= "常规";
		["GuiTabProfiles"]	= "配置文件";
		["GuiTabWeights"]	= "比重";
		["GuiValueOptions"]	= "价值显示选项";
		["GuiValueShowAuc4HSP"]	= "显示拍卖助手最高可售价格";
		["GuiValueShowAuc4Median"]	= "显示拍卖助手中位数";
		["GuiValueShowAuc5Market"]	= "显示拍卖助手市场价";
		["GuiValueShowBaseline"]	= "显示内置基准值";
		["GuiValueShowDEValues"]	= "显示估计分解价";
		["GuiValueTerse"]	= "简洁显示分解价";
		["GuiWeighSettingsNote"]	= "上述比重值根据特定的数量改变该原材料数量。 您通常将想要留下他们在100%，除非您认为他们比您使用应该或多或少是贵重物品的估价方法认为。";
		["GuiWeightSettings"]	= "分解材料需求度";
		["GuiYes"]	= "是";

	};

	zhTW = {

		-- Section: Command Messages
		["FrmtActClearall"]	= "清除所有附魔資料";
		["FrmtActClearFail"]	= "無法找到物品：%s";
		["FrmtActClearOk"]	= "清除物品資料：%s ";
		["FrmtActDefault"]	= "Enchantrix的%s設定已經重設為初始值";
		["FrmtActDefaultAll"]	= "所有Enchantrix的設定已經重設為初始值";
		["FrmtActDisable"]	= "不要顯示物品的 %s 資料";
		["FrmtActEnable"]	= "顯示物品的 %s 資料";
		["FrmtActSet"]	= "設定%s為'%s'";
		["FrmtActUnknown"]	= "未知的命令關鍵字：'%s'";
		["FrmtActUnknownLocale"]	= "找不到您選擇的語言('%s')。可用的語言有：";
		["FrmtPrintin"]	= "Encantrix的訊息將會顯示在 \"%s\" 聊天框架";
		["FrmtUsage"]	= "用途:";
		["MesgDisable"]	= "關閉Enchantrix之自動載入";
		["MesgNotloaded"]	= "Enchantrix未載入,輸入 /enchantrix 取得說明";

		-- Section: Command Options
		["CmdClearAll"]	= "all";
		["OptClear"]	= "([Item]|all)";
		["OptDefault"]	= "(<option>|all)";
		["OptFindBidauct"]	= "<silver>";
		["OptFindBuyauct"]	= "<percent>";
		["OptLocale"]	= "<locale>";
		["OptPrintin"]	= "(<frameIndex>[Number]|<frameName>[String])";

		-- Section: Commands
		["CmdClear"]	= "clear";
		["CmdDefault"]	= "default";
		["CmdDisable"]	= "disable";
		["CmdFindBidauct"]	= "bidbroker";
		["CmdFindBidauctShort"]	= "bb";
		["CmdFindBuyauct"]	= "percentless";
		["CmdFindBuyauctShort"]	= "pl";
		["CmdHelp"]	= "幫助";
		["CmdLocale"]	= "locale";
		["CmdOff"]	= "off";
		["CmdOn"]	= "on";
		["CmdPrintin"]	= "print-in";
		["CmdToggle"]	= "toggle";
		["ShowDELevels"]	= "levels";
		["ShowDEMaterials"]	= "materials";
		["ShowEmbed"]	= "embed";
		["ShowGuessAuctioneerHsp"]	= "valuate-hsp";
		["ShowGuessAuctioneerMed"]	= "valuate-median";
		["ShowGuessBaseline"]	= "valuate-baseline";
		["ShowTerse"]	= "terse";
		["ShowUI"]	= "show";
		["ShowValue"]	= "valuate";
		["StatOff"]	= "不顯示任何附魔資料";
		["StatOn"]	= "顯示已設定附魔資料中";

		-- Section: Config Text
		["GuiLoad"]	= "載入Enchantrix";
		["GuiLoad_Always"]	= "always";
		["GuiLoad_Never"]	= "never";

		-- Section: Game Constants
		["ArgSpellname"]	= "分解";
		["ArgSpellProspectingName"]	= "選礦";
		["Enchanting"]	= "附魔";
		["Jewelcrafting"]	= "珠寶製作";
		["PatReagents"]	= "魔法元素: (.+) ";
		["TextCombat"]	= "戰鬥記錄";
		["TextGeneral"]	= "綜合";

		-- Section: Generic Messages
		["FrmtCredit"]	= " (請至 http://enchantrix.org/ 以分享您的資料) ";
		["FrmtWelcome"]	= "Enchantrix v%s 已載入";
		["MesgAuctVersion"]	= "Enchantrix需要Auctioneer3.4或更新版本。某些功能在您未更新您的Auctioneer前無法使用。";

		-- Section: Help Text
		["GuiClearall"]	= "清除所有附魔資料";
		["GuiClearallButton"]	= "清除全部";
		["GuiClearallHelp"]	= "點擊此處，清除目前伺服器之所有附魔資料";
		["GuiClearallNote"]	= "目前的伺服器";
		["GuiDefaultAll"]	= "重置所有Enchantrix選項";
		["GuiDefaultAllButton"]	= "重設所有設定";
		["GuiDefaultAllHelp"]	= "點擊這裡以重設所有Enchantrix的選項回預設值。警告：這個動作是無法還原的。";
		["GuiDefaultOption"]	= "重設這個設定";
		["GuiDELevels"]	= "在提示中顯示分解需要的等級";
		["GuiDEMaterials"]	= "在提示中顯示分解材料信息";
		["GuiEmbed"]	= "在遊戲提示中嵌入資訊";
		["GuiLocale"]	= "設定語言為";
		["GuiMainEnable"]	= "啟動 Enchantrix";
		["GuiMainHelp"]	= "把附魔資訊嵌入遊戲資訊窗";
		["GuiOtherHeader"]	= "其他選項";
		["GuiOtherHelp"]	= "其他 Enchantrix 雜項設定";
		["GuiPrintin"]	= "選擇崁入的訊息框架";
		["GuiTerse"]	= "啟用精簡模式";
		["GuiValuateAverages"]	= "拍賣評估";
		["GuiValuateBaseline"]	= "崁入拍賣資料";
		["GuiValuateEnable"]	= "啟動評估系統";
		["GuiValuateHeader"]	= "估價";
		["GuiValuateMedian"]	= "評估拍賣平均價值";
		["HelpClear"]	= "清除指定物品的數據(必須Shift+點擊將物品插入命令)。你也可以指定特定關鍵字\"all\"。";
		["HelpDefault"]	= "設置某個附魔助手選項為預設值。你也可以輸入特定關鍵字\"all\" 來設置所有附魔助手選項為預設值。";
		["HelpDisable"]	= "停止附魔助手在下一次登錄時自動載入。";
		["HelpEmbed"]	= "嵌入文字到原游戲提示中(提示：某些特性在該模式下無法使用)。";
		["HelpFindBidauct"]	= "找到分解價值可能低于競拍價一定銀幣額的拍賣品。";
		["HelpFindBuyauct"]	= "找到分解價值可能低于買斷價一定比率的拍賣品。";
		["HelpGuessAuctioneer5Val"]	= "開啟估價并且拍賣助手開啟，就顯示物品分解的市場價。";
		["HelpGuessAuctioneerHsp"]	= "如果啟用估價，并且安裝了拍賣行助手(Auctioneer)，顯示對于物品分解的曾售價格(最高價)。";
		["HelpGuessAuctioneerMedian"]	= "如果啟用估價，并且安裝了拍賣助手(Auctioneer)，顯示基于物品分解估價的中位數。如果啟用估價，并且安裝了拍賣助手(Auctioneer)，顯示基于物品分解估價的中位數。";
		["HelpGuessBaseline"]	= "如果啟用估價，顯示對于物品分解的基準估價，基于系統內置價格(不需要拍賣助手Auctioneer)。";
		["HelpGuessNoauctioneer"]	= "價格評估上限與價格評估中位數命令不能使用是因為沒有安裝拍賣助手。";
		["HelpLoad"]	= "改變附魔助手的加載設置。";
		["HelpLocale"]	= "改變用來顯示Enchantrix訊息的語言";
		["HelpOnoff"]	= "附魔資料開啟或關閉";
		["HelpPrintin"]	= "選擇Enchantrix訊息顯示的框架。你可以輸入框架名字或者是index。";
		["HelpShowDELevels"]	= "在提示中選擇是否顯示分解物品需要的附魔技能。";
		["HelpShowDEMaterials"]	= "在提示中選擇否是顯示分解物品產生材料。";
		["HelpShowUI"]	= "顯示或隱藏設置面板。";
		["HelpTerse"]	= "開啟/關閉 簡略模式，只顯示分解價值。能持續忽略控制鍵。";
		["HelpValue"]	= "選擇是否顯示物品基于可能分解幾率的預計價值。";

		-- Section: Report Messages
		["AuctionScanAuctNotInstalled"]	= "你沒有安裝拍賣助手。拍賣助手必須安裝並執行一次掃描。";
		["AuctionScanVersionTooOld"]	= "你沒有正確安裝拍賣助手。此特性需要拍賣助手4.0以上。";
		["ChatDeletedProfile"]	= "刪除記錄檔：";
		["ChatResetProfile"]	= "重置所有設置：";
		["ChatSavedProfile"]	= "保存記錄檔：";
		["ChatUsingProfile"]	= "使用記錄檔：";
		["FrmtAutoDeActive"]	= "啟動自動分解";
		["FrmtAutoDeDisabled"]	= "停用自動分解";
		["FrmtAutoDeDisenchantCancelled"]	= "分解取消: 找不到物品";
		["FrmtAutoDeDisenchanting"]	= "%s 分解中";
		["FrmtAutoDeIgnorePermanent"]	= "永久忽略 %s";
		["FrmtAutoDeIgnoreSession"]	= "這一次忽略 %s";
		["FrmtAutoDeInactive"]	= "暫停自動分解";
		["FrmtAutoDeProspectCancelled"]	= "預估取消：找不到物品";
		["FrmtAutoDeProspecting"]	= "預估 %s";
		["FrmtBidbrokerCurbid"]	= "目前的拍賣價";
		["FrmtBidbrokerDone"]	= "交易價代理完成";
		["FrmtBidbrokerHeader"]	= "比平均分解價值平%s銀的拍賣：";
		["FrmtBidbrokerLine"]	= "%s，估價：%s，%s：%s，節省：%s，差額%s，次數：%s";
		["FrmtBidbrokerMinbid"]	= "最低拍賣價";
		["FrmtBidBrokerSkipped"]	= "所需利潤率不足(%d%%),跳過%d拍賣";
		["FrmtBidBrokerSkippedBids"]	= "所需出價不足,跳過%d拍賣";
		["FrmtPctlessDone"]	= "比率差額完成";
		["FrmtPctlessHeader"]	= "比平均分解價值平%s銀的買斷價:";
		["FrmtPctlessLine"]	= "%s，估價：%s，買斷價：%s，節省：%s，差額%s";
		["FrmtPctlessSkillSkipped"]	= "所需技能等級不夠(%s),跳過%d拍賣";
		["FrmtPctlessSkipped"]	= "所需收益率不足(%s),跳過%d拍賣";

		-- Section: Tooltip Messages
		["FrmtBarkerPrice"]	= "Barker 價格 (%d%% 保証金) ";
		["FrmtDisinto"]	= "分解成：";
		["FrmtFound"]	= "%s可分解成：";
		["FrmtFoundNotDisenchant"]	= "發現%s不可分解";
		["FrmtPriceEach"]	= "(%s 每個) ";
		["FrmtProspectFound"]	= "可能有 %s 分解成";
		["FrmtProspectInto"]	= "分解成";
		["FrmtProspectValueAuctHsp"]	= "分解價值 (HSP)";
		["FrmtProspectValueAuctMed"]	= "預估價格（Median）";
		["FrmtProspectValueAuctVal"]	= "預估價格（AucAdv）";
		["FrmtProspectValueMarket"]	= "預估價格(Baseline)";
		["FrmtSuggestedPrice"]	= "建議價格：";
		["FrmtTotal"]	= "總共";
		["FrmtValueAuctHsp"]	= "分解價值(HSP)";
		["FrmtValueAuctMed"]	= "分解價值(Median)";
		["FrmtValueAuctVal"]	= "分解價值(AucAdv)";
		["FrmtValueFixedVal"]	= "分解價格(固定)";
		["FrmtValueMarket"]	= "分解價值(Baseline)";
		["FrmtWarnAuctNotLoaded"]	= "[Auctioneer未載入，使用暫存區價格]";
		["FrmtWarnNoPrices"]	= "[無有效價格]";
		["FrmtWarnPriceUnavail"]	= "[部分價格無效]";
		["TooltipProspectLevel"]	= "選礦需要%d技能";
		["TooltipShowDisenchantLevel"]	= "分解必要技能%d";

		-- Section: User Interface
		["GuiActivateProfile"]	= "啟用當前記錄檔";
		["GuiAutoDeEnable"]	= "監看背包中可分解的物品 - 小心使用";
		["GuiAutoDeOptions"]	= "自動化";
		["GuiAutoDePromptLine1"]	= "你正要分解:";
		["GuiAutoDePromptLine3"]	= "%s 的價格";
		["GuiBBUnbiddedOnly"]	= "僅代理無人出價的物品";
		["GuiConfigProfiles"]	= "設置或編輯記錄檔";
		["GuiCreateReplaceProfile"]	= "新建或替換記錄檔";
		["GuiDefaultBBProfitPercent"]	= "默認代理收益率：%d";
		["GuiDefaultLessHSP"]	= "默認最高售價差額率:%d";
		["GuiDefaultProfitMargin"]	= "默認利潤率：";
		["GuiDeleteProfileButton"]	= "刪除";
		["GuiFixedSettings"]	= "固定藥劑費用";
		["GuiGeneralOptions"]	= "常規附魔助手選項";
		["GuiIgnore"]	= "忽略";
		["GuiItemValueAuc4HSP"]	= "Auc最高售價";
		["GuiItemValueAuc4Median"]	= "Auc中位數";
		["GuiItemValueAuc5Market"]	= "AucAdv市場價";
		["GuiItemValueAverage"]	= "均價(默認)";
		["GuiItemValueBaseline"]	= "市場基準";
		["GuiItemValueCalc"]	= "計算物品價格";
		["GuiMaxBuyout"]	= "最大買斷價：";
		["GuiMinBBProfitPercent"]	= "最低代理收益率：%d";
		["GuiMinimapButtonAngle"]	= "按鈕位置：%d";
		["GuiMinimapButtonDist"]	= "間隔:%d";
		["GuiMinimapOptions"]	= "小地圖顯示選項";
		["GuiMinimapShowButton"]	= "顯示小地圖按鈕";
		["GuiMinLessHSP"]	= "最低最高售價差額率:%d";
		["GuiMinProfitMargin"]	= "最低利润率：";
		["GuiNewProfileName"]	= "新記錄檔名字：";
		["GuiNo"]	= "否";
		["GuiPLBBOnlyBelowDESkill"]	= "僅顯示當前技能可分解物品";
		["GuiPLBBSettings"]	= "差額率與代理設置";
		["GuiProspectingLevels"]	= "在工具列上顯示選礦等級需求";
		["GuiProspectingMaterials"]	= "在工具列選礦礦物資訊";
		["GuiProspectingOptions"]	= "選礦選項";
		["GuiProspectingValues"]	= "顯示大致選礦價格";
		["GuiResetProfileButton"]	= "重置";
		["GuiSaveProfileButton"]	= "保存";
		["GuiTabAuctions"]	= "拍賣";
		["GuiTabGeneral"]	= "常規";
		["GuiTabProfiles"]	= "記錄檔";
		["GuiTabWeights"]	= "比重";
		["GuiValueOptions"]	= "價值顯示選項";
		["GuiValueShowAuc4HSP"]	= "顯示拍賣助手最高可售價格";
		["GuiValueShowAuc4Median"]	= "顯示拍賣助手中位數";
		["GuiValueShowAuc5Market"]	= "顯示拍賣助手市場價";
		["GuiValueShowBaseline"]	= "顯示內置基準值";
		["GuiValueShowDEValues"]	= "顯示估計分解價";
		["GuiValueTerse"]	= "簡潔顯示分解價";
		["GuiWeighSettingsNote"]	= "上述比重值根據特定的數量改變該原材料數量。 您通常將想要留下他們在100%，除非您認為他們比您使用應該或多或少是貴重物品的估價方法認為。";
		["GuiWeightSettings"]	= "分解材料需求度";
		["GuiYes"]	= "確定";

	};

}