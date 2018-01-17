--[[
	WARNING: This is a generated file.
	If you wish to perform or update localizations, please go to our Localizer website at:
	http://localizer.norganna.org/

	AddOn: BeanCounter
	Revision: $Id: BeanCounterStrings.lua 3490 2008-09-14 04:17:47Z aesir $
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

BeanCounterLocalizations = {

	csCZ = {

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Aliancni aukce";
		["MailAuctionCancelledSubject"]	= "Aukce zrusena";
		["MailAuctionExpiredSubject"]	= "Platnost aukce vyprsela";
		["MailAuctionSuccessfulSubject"]	= "Aukce probehla uspesne";
		["MailAuctionWonSubject"]	= "Vyhral/a jste aukci";
		["MailHordeAuctionHouse"]	= "Hordacka aukce";
		["MailOutbidOnSubject"]	= "Prehozen/a na";

		-- Section: User Interface
		["UiAuctions"]	= "Aukce";
		["UiAuctionTransaction"]	= "Aukce";
		["UiBids"]	= "Bidy";
		["UiBidTransaction"]	= "Bid";
		["UiBuyerSellerHeader"]	= "Zakaznik/prodavajici";
		["UiBuyTransaction"]	= "Kup";
		["UiDateHeader"]	= "Datum";
		["UiDepositTransaction"]	= "Sklad";
		["UiExactNameSearch"]	= "Presny nazev";
		["UiNameHeader"]	= "Vec";
		["UiNetHeader"]	= "Sit";
		["UiNetPerHeader"]	= "Sit per";
		["UiPriceHeader"]	= "Cena";
		["UiPricePerHeader"]	= "Cenova hlava";
		["UiPurchases"]	= "Nakupy";
		["UiQuantityHeader"]	= "Mnozstvi";
		["UiSales"]	= "Prodeje";
		["UiSearch"]	= "Hledat";
		["UiSearchForLabel"]	= "Hledej";
		["UiSellTransaction"]	= "Prodej";
		["UiTransactions"]	= "Transakce";
		["UiTransactionsLabel"]	= "Transakce";
		["UiTransactionTypeHeader"]	= "Typ";

	};

	daDK = {

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Alliance Auktions Hus";
		["MailAuctionCancelledSubject"]	= "Auktion afbrudt";
		["MailAuctionExpiredSubject"]	= "Auktion udløbet";
		["MailAuctionSuccessfulSubject"]	= "Auktion succesfuld";
		["MailAuctionWonSubject"]	= "Auktion vundet";
		["MailHordeAuctionHouse"]	= "Horde Auktions Hus";
		["MailOutbidOnSubject"]	= "Overbudt på";

		-- Section: User Interface
		["UiAuctions"]	= "Auktioner";
		["UiAuctionTransaction"]	= "Auktion";
		["UiBids"]	= "Bud";
		["UiBidTransaction"]	= "Byd";
		["UiBuyerSellerHeader"]	= "Køber/Sælger";
		["UiBuyTransaction"]	= "Køb";
		["UiDateHeader"]	= "Dato";
		["UiDepositTransaction"]	= "Indskud";
		["UiExactNameSearch"]	= "Eksakt navne-søgning";
		["UiNameHeader"]	= "Item";
		["UiNetHeader"]	= "Net";
		["UiNetPerHeader"]	= "Net Per";
		["UiPriceHeader"]	= "Pris";
		["UiPricePerHeader"]	= "Styk Pris";
		["UiPurchases"]	= "Køb";
		["UiQuantityHeader"]	= "Stk";
		["UiSales"]	= "Salg";
		["UiSearch"]	= "Søg";
		["UiSearchForLabel"]	= "Søg efter:";
		["UiSellTransaction"]	= "Sælg";
		["UiTransactions"]	= "Transaktioner";
		["UiTransactionsLabel"]	= "Transaktioner:";
		["UiTransactionTypeHeader"]	= "Type";

	};

	deDE = {

		-- Section: Config Text
		["C_BeanCounterConfig"]	= "BeanCounter Konfig.";
		["C_BeanCounterOptions"]	= "BeanCounter Optionen";
		["C_DateString"]	= "Zu verwendendes Datumsformat:";
		["C_DateStringExample"]	= "Beispieldatum:";
		["C_ExtenalSearch"]	= "Externen AddOns die BeanCounter Suche erlauben";
		["C_MailInvoiceTimeout"]	= "Mail-Zeitüberschreitung = %d Sekunden";
		["C_MailRecolor"]	= "Mail einfärben";

		-- Section: Generic Strings
		["NoRe-Color"]	= "Kein einfärben";
		["off"]	= "aus";
		["on"]	= "ein";
		["Re-ColorIcons"]	= "Icons einfärben";
		["Re-ColorIconsandText"]	= "Icons und Text einfärben";
		["Re-ColorText"]	= "Text einfärben";

		-- Section: Help Text
		["A_DateString"]	= "Dies bestimmt, wie das Datum vom GUI BeanCounters angezeigt wird. Befehle werden durch % eingeleitet und mehrfache Befehle und Text können gemischt werden. Z.B. würde %a == %X Mi == 21:34:21 anzeigen";
		["A_DateStringCommands"]	= "Commands: \n %a = gek. Wochentagsname, \n %A = voller Wochentagsname, \n %b = gek. Monatsname, \n %B = voller Monatsname,\n %c = Datum und Zeit, \n %d = Monatstag (01-31),\n %H = Stunde (24), \n %I = Stunde (12),\n %M = Minute, \n %m = Monat,\n %p = am/pm, \n %S = Sekunde,\n %U = Jahreswochennummer ,\n %w = Nummerischer Wochentag (0-6),\n %x = Datum, \n %X = Zeit,\n %Y = Jahr lang (2007), \n %y = Jahr kurz (07)";
		["A_ExtenalSearch"]	= "Andere Addons können BeanCounters Suche nutzen, damit ein Item im GUI von BeanCounter angezeigt werden kann. Dies läßt BeanCounter z.B. zeigen, welche Items Sie in Appraiser betrachten";
		["A_MailInvoiceTimeout"]	= "Die Zeitspanne, die BeanCounter auf eine Antwort des Servers wartet, um auf eine Mailabfrage zu reagieren. Eine Abfrage ist das wer, was, wie von Auktionshausmails.";
		["A_MailRecolor"]	= "BeanCounter liest alle Mails vom Auktionshaus. Diese Option bestimmt, wie BeanCounter die Anzeige der Mails einfärben soll, um sie als ungelesen darzustellen.";
		["HelpGuiItemBox"]	= "Ziehe ein Item in die Box für Suche";
		["Q_DateString"]	= "Anzuwendendes Datumsformat ?";
		["Q_DateStringCommands"]	= "Gültige Datumsbefehle ?";
		["Q_ExtenalSearch"]	= "Erlaube ext. AddOns die Benutzung von BeanCounter ?";
		["Q_MailInvoiceTimeout"]	= "Was ist eine Mail-Zeitüberschreitung ?";
		["Q_MailRecolor"]	= "Was ist Mail einfärben ?";

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Auktionshaus der Allianz";
		["MailAuctionCancelledSubject"]	= "Auktion abgebrochen";
		["MailAuctionExpiredSubject"]	= "Auktion abgelaufen";
		["MailAuctionSuccessfulSubject"]	= "Auktion erfolgreich";
		["MailAuctionWonSubject"]	= "Auktion gewonnen";
		["MailHordeAuctionHouse"]	= "Auktionshaus der Horde";
		["MailOutbidOnSubject"]	= "Höheres Gebot für";
		["MailSalePendingOnSubject"]	= "Ausstehender Verkauf";

		-- Section: Tooltip Messages
		["TTDateString"]	= "Tragen Sie das Format ein, wie Sie das Datum darstellen möchten. Standard ist %c";
		["TTDateStringExample"]	= "Zeigt ein Beispiel an, wie Ihre Datumsausgabe aussehen wird";
		["TTExtenalSearch"]	= "Wenn eine Suche in ein anderes AddOn eingetragen wird, zeigt BeanCounter auch eine Suche nach diesem Item an.";
		["TTMailInvoiceTimeout"]	= "Bestimmt wie lange BeanCounter versucht, eine Mail vom Server zu erhalten, bevor es aufgibt. Tiefer == schneller, aber grössere Wahrscheinlichkeit auf fehlende Daten; Höher == langsamer, verbessert aber die Wahrscheinlichkeit alle Daten zu erhalten, wenn der Mailserver extrem beschäftigt ist.";
		["TTMailRecolor"]	= "Wählen Sie, wie die Mailanzeige erscheint, nachdem BeanCounter den Briefkasten durchsucht hat.";

		-- Section: User Interface
		["UiAddonTitle"]	= "BeanCounter: Auktionenverlauf Datenbank";
		["UiAucExpired"]	= "Auktion abgelaufen";
		["UiAucSuccessful"]	= "Auktion erfolgreich";
		["UiAuctions"]	= "Auktionen";
		["UiAuctionTransaction"]	= "Auktion";
		["UiBids"]	= "Gebote";
		["UiBidTransaction"]	= "Gebot";
		["UiBuyerSellerHeader"]	= "Käufer/Verkäufer";
		["UiBuyTransaction"]	= "Kaufen";
		["UiClassicCheckBox"]	= "Zeige klassische BC-Daten";
		["UiData"]	= "Daten";
		["UiDateHeader"]	= "Datum";
		["UiDepositTransaction"]	= "Anzahlung";
		["UiDone"]	= "Fertig";
		["UiExactNameSearch"]	= "Genaue Namenssuche";
		["UiFailedAuctions"]	= "Fehlgeschlagene Auktion";
		["UiFee"]	= "Gebühr";
		["UiNameHeader"]	= "Gegenstand";
		["UiNetHeader"]	= "Netto";
		["UiNetPerHeader"]	= "Netto pro";
		["UiOutbid"]	= "Überboten";
		["UiOutbids"]	= "Überboten";
		["UiPriceHeader"]	= "Preis";
		["UiPriceper"]	= "Einzelpreis";
		["UiPricePerHeader"]	= "Preisüberschrift";
		["UiPurchases"]	= "Einkäufe";
		["UiQuantityHeader"]	= "Anz.";
		["UiSales"]	= "Verkäufe";
		["UiSearch"]	= "Suche";
		["UiSearchForLabel"]	= "Suche nach:";
		["UiSellTransaction"]	= "Verkaufen";
		["UiServer"]	= "Server";
		["UiTransactions"]	= "Transaktionen";
		["UiTransactionsLabel"]	= "Transaktionen:";
		["UiTransactionTypeHeader"]	= "Typ";
		["UiWealth"]	= "Vermögen";
		["UiWononBid"]	= "Gebotskauf";
		["UiWononBuyout"]	= "Sofortkauf";

	};

	elGR = {

		-- Section: Config Text
		["C_MailRecolor"]	= "Mail Re-Color Method";

	};

	enUS = {

		-- Section: Config Text
		["C_BeanCounterConfig"]	= "BeanCounter Config";
		["C_BeanCounterDatabaseMaintenance"]	= "BeanCounter Database Maintenance";
		["C_BeanCounterOptions"]	= "BeanCounter options";
		["C_DataMaintenance"]	= "Data Maintenance";
		["C_DateString"]	= "Date format to use:";
		["C_DateStringExample"]	= "Example Date:";
		["C_ExtenalSearch"]	= "Allow External Addons to use BeanCounter's Search?";
		["C_MailInvoiceTimeout"]	= "Mail Invoice Timeout = %d seconds";
		["C_MailRecolor"]	= "Mail Re-Color Method";
		["C_Resortascendingtime"]	= "Resort all entries by ascending time";
		["C_ResortDatabase"]	= "Resort Database";
		["C_ScanDatabase"]	= "Scan Database for errors: Use if you have errors when searching BeanCounter. \n Backup BeanCounter's saved variables before using.";
		["C_ShowBeginnerTooltips"]	= "Show beginner tooltips on mouse over.";
		["C_ShowReasonPurchase"]	= "Show reason for purchase in the games Tooltips.";
		["C_ValidateDatabase"]	= "Validate Database";

		-- Section: Generic Strings
		["NoRe-Color"]	= "No Re-Color";
		["off"]	= "off";
		["on"]	= "on";
		["Re-ColorIcons"]	= "Re-Color Icons";
		["Re-ColorIconsandText"]	= "Re-Color Icons and Text";
		["Re-ColorText"]	= "Re-Color Text";

		-- Section: Help Text
		["A_BeanCountersTooltip"]	= "BeanCounter will store the SearchUI reason an item was purchased and display it in the tooltip.";
		["A_DateString"]	= "This controls how the Date field of BeanCounter's GUI is shown. Commands are prefaced by % and multiple commands and text can be mixed. For example %a == %X would display Wed == 21:34:21";
		["A_DateStringCommands"]	= "Commands: \n %a = abr. weekday name, \n %A = weekday name, \n %b = abr. month name, \n %B = month name,\n %c = date and time, \n %d = day of the month (01-31),\n %H = hour (24), \n %I = hour (12),\n %M = minute, \n %m = month,\n %p = am/pm, \n %S = second,\n %U = week number of the year ,\n %w = numerical weekday (0-6),\n %x = date, \n %X = time,\n %Y = full year (2007), \n %y = two-digit year (07)";
		["A_ExtenalSearch"]	= "Other addons can have BeanCounter search for an item to be displayed in BeanCounter's GUI. For example this allows BeanCounter to show what items you are looking at in Appraiser";
		["A_MailInvoiceTimeout"]	= "The length of time BeanCounter will wait on the server to respond to an invoice request. An invoice is the \"who\", \"what\", and \"how\" of an Auction House mail.";
		["A_MailRecolor"]	= "BeanCounter reads all mail from the Auction House. This option tells BeanCounter how the user wants to re-color the messages to make them look unread.";
		["HelpGuiItemBox"]	= "Drop item into box to search.";
		["Q_BeanCountersTooltip"]	= "What is BeanCounter's Tooltip";
		["Q_DateString"]	= "Date Format to use?";
		["Q_DateStringCommands"]	= "Acceptable Date Commands?";
		["Q_ExtenalSearch"]	= "Allow External Addons to use BeanCounter?";
		["Q_MailInvoiceTimeout"]	= "What is Mail Invoice Timeout?";
		["Q_MailRecolor"]	= "What is Mail Re-color Method?";

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Alliance Auction House";
		["MailAuctionCancelledSubject"]	= "Auction cancelled";
		["MailAuctionExpiredSubject"]	= "Auction expired";
		["MailAuctionSuccessfulSubject"]	= "Auction successful";
		["MailAuctionWonSubject"]	= "Auction won";
		["MailHordeAuctionHouse"]	= "Horde Auction House";
		["MailNeutralAuctionHouse"]	= "Blackwater Auction House";
		["MailOutbidOnSubject"]	= "Outbid on";
		["MailSalePendingOnSubject"]	= "Sale Pending";

		-- Section: Tooltip Messages
		["TTDateString"]	= "Enter the format that you would like your date field to show. Default is %c.";
		["TTDateStringExample"]	= "Displays an example of what your formatted date will look like.";
		["TTExtenalSearch"]	= "When entering a search in another addon, BeanCounter will also display a search for that item.";
		["TTMailInvoiceTimeout"]	= "Chooses how long BeanCounter will attempt to get a mail invoice from the server before giving up. Lower == quicker but more chance of missing data. Higher == slower, but improves chances of getting data if the Mail server is extremely busy.";
		["TTMailRecolor"]	= "Choose how mail will appear after BeanCounter has scanned the Mail Box.";
		["TTResort Database"]	= "This will scan Beancounter's Data sort all entries in ascending time order. This helps speed up the database compression functions.";
		["TTShowBeginnerTooltips"]	= "Turns on the beginner tooltips that display on mouse over.";
		["TTShowReasonPurchase"]	= "Turns on the SearchUI reason an item was purchased for in the tooltip.";
		["TTValidateDatabase"]	= "This will scan Beancounter's Data and attempt to correct any errors it may find. Use if you are getting errors on search.";

		-- Section: User Interface
		["UiAddonTitle"]	= "BeanCounter: Auction History Database";
		["UiAucExpired"]	= "Auc Expired";
		["UiAucSuccessful"]	= "Auc Successful";
		["UiAuctions"]	= "Auctions";
		["UiAuctionTransaction"]	= "Auction";
		["UiBids"]	= "Bids";
		["UiBidTransaction"]	= "Bid";
		["UiBuyerSellerHeader"]	= "Buyer/Seller";
		["UiBuyTransaction"]	= "Buy";
		["UiClassicCheckBox"]	= "Show BC Classic data.";
		["UiData"]	= "Data";
		["UiDateHeader"]	= "Date";
		["UiDepositTransaction"]	= "Deposit";
		["UiDone"]	= "Done";
		["UiExactNameSearch"]	= "Exact name search";
		["UiFailedAuctions"]	= "Failed Auctions ";
		["UiFee"]	= "Fee";
		["UiNameHeader"]	= "Item";
		["UiNetHeader"]	= "Net";
		["UiNetPerHeader"]	= "Net Per";
		["UiOutbid"]	= "Outbid";
		["UiOutbids"]	= "Outbids";
		["UiPriceHeader"]	= "Price";
		["UiPriceper"]	= "Price/Per";
		["UiPricePerHeader"]	= "Price Header";
		["UiPurchases"]	= "Purchases";
		["UiQuantityHeader"]	= "Qty";
		["UiSales"]	= "Sales";
		["UiSearch"]	= "Search";
		["UiSearchForLabel"]	= "Search for:";
		["UiSellTransaction"]	= "Sell";
		["UiServer"]	= "Server";
		["UiTransactions"]	= "Transactions";
		["UiTransactionsLabel"]	= "Transactions:";
		["UiTransactionTypeHeader"]	= "Type";
		["UiWealth"]	= "Wealth";
		["UiWononBid"]	= "Won on Bid";
		["UiWononBuyout"]	= "Won on Buyout";

	};

	esES = {

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Casa de subastas de la Alianza";
		["MailAuctionCancelledSubject"]	= "Subasta cancelada";
		["MailAuctionExpiredSubject"]	= "Subasta terminada";
		["MailAuctionSuccessfulSubject"]	= "Subasta conseguida";
		["MailAuctionWonSubject"]	= "Subasta ganada";
		["MailHordeAuctionHouse"]	= "Casa de subastas de la Horda";
		["MailOutbidOnSubject"]	= "Puja superada en";

		-- Section: User Interface
		["UiAuctions"]	= "Subastas";
		["UiAuctionTransaction"]	= "Subasta";
		["UiBids"]	= "Pujas";
		["UiBidTransaction"]	= "Puja";
		["UiBuyerSellerHeader"]	= "Comprador/Vendedor";
		["UiBuyTransaction"]	= "Compra";
		["UiDateHeader"]	= "Fecha";
		["UiDepositTransaction"]	= "Depósito";
		["UiExactNameSearch"]	= "Búsqueda de nombre exacto";
		["UiNameHeader"]	= "Artículo";
		["UiNetHeader"]	= "Neto";
		["UiNetPerHeader"]	= "Neto c/u";
		["UiPriceHeader"]	= "Precio";
		["UiPricePerHeader"]	= "Precio c/u";
		["UiPurchases"]	= "Compras";
		["UiQuantityHeader"]	= "Ctd";
		["UiSales"]	= "Ventas";
		["UiSearch"]	= "Buscar";
		["UiSearchForLabel"]	= "Buscar por:";
		["UiSellTransaction"]	= "Vender";
		["UiTransactions"]	= "Transacciones";
		["UiTransactionsLabel"]	= "Transacciones:";
		["UiTransactionTypeHeader"]	= "Tipo";

	};

	frFR = {

		-- Section: Config Text
		["C_BeanCounterConfig"]	= "BeanCounter Configuration";
		["C_BeanCounterOptions"]	= "BeanCounter Options";
		["C_DateString"]	= "Format date à utiliser:";
		["C_DateStringExample"]	= "Exemple Date:";
		["C_ExtenalSearch"]	= "Autorise les Addons Externes à utiliser la recherche BeanCounter?";
		["C_MailInvoiceTimeout"]	= "Mail de dépassement du temps des encheres = %d secondes";
		["C_MailRecolor"]	= "Méthode de changement de couleur de mail";

		-- Section: Generic Strings
		["NoRe-Color"]	= "Pas de changement de couleur";
		["off"]	= "Eteint";
		["on"]	= "Allumé";
		["Re-ColorIcons"]	= "Changement couleur d'icones";
		["Re-ColorIconsandText"]	= "Changement couleur d'icones et du texte";
		["Re-ColorText"]	= "Changement couleur du texte";

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Hôtel des ventes de l'Alliance";
		["MailAuctionCancelledSubject"]	= "Vente annulée";
		["MailAuctionExpiredSubject"]	= "Vente aux enchères terminée";
		["MailAuctionSuccessfulSubject"]	= "Vente aux enchères réussie";
		["MailAuctionWonSubject"]	= "Vente gagnée";
		["MailHordeAuctionHouse"]	= "Hôtel des ventes de la Horde";
		["MailOutbidOnSubject"]	= "Augmenter l'offre pour";
		["MailSalePendingOnSubject"]	= "vente en suspend";

		-- Section: Tooltip Messages
		["TTDateString"]	= "Entrez le format voulu d'affichage de votre date.Par défaut c'est %c";
		["TTDateStringExample"]	= "Montre un exemple de votre format de date";
		["TTExtenalSearch"]	= "Quand vous entrez une recherche dans un autre addon,BeanCounter affichera aussi une recherche pour cette objet";
		["TTMailRecolor"]	= "Choisissez comment un mail va apparaitre apres que BeanCounter\naura scanné la boite au lettre";

		-- Section: User Interface
		["UiAddonTitle"]	= "BeanCounter: Historique de vente";
		["UiAucExpired"]	= "Vente terminée";
		["UiAucSuccessful"]	= "Vente réussie";
		["UiAuctions"]	= "Enchères";
		["UiAuctionTransaction"]	= "Enchère";
		["UiBids"]	= "Offres";
		["UiBidTransaction"]	= "Offre";
		["UiBuyerSellerHeader"]	= "Acheteur/Vendeur";
		["UiBuyTransaction"]	= "Acheter";
		["UiClassicCheckBox"]	= "Afficher les données BeanCounter classique";
		["UiData"]	= "Donnée";
		["UiDateHeader"]	= "Date";
		["UiDepositTransaction"]	= "Dépôt";
		["UiDone"]	= "Effectué";
		["UiExactNameSearch"]	= "Nom exact";
		["UiFailedAuctions"]	= "Vente ratée";
		["UiFee"]	= "Commission";
		["UiNameHeader"]	= "Objet";
		["UiNetHeader"]	= "Net";
		["UiNetPerHeader"]	= "Net unit.";
		["UiOutbid"]	= "Surenchere";
		["UiOutbids"]	= "Surencheres";
		["UiPriceHeader"]	= "Prix";
		["UiPriceper"]	= "Prix/par";
		["UiPricePerHeader"]	= "Prix unit.";
		["UiPurchases"]	= "Achats";
		["UiQuantityHeader"]	= "Qte";
		["UiSales"]	= "Ventes";
		["UiSearch"]	= "Recherche";
		["UiSearchForLabel"]	= "Rechercher :";
		["UiSellTransaction"]	= "Vendre";
		["UiServer"]	= "Serveur";
		["UiTransactions"]	= "Transactions";
		["UiTransactionsLabel"]	= "Transactions:";
		["UiTransactionTypeHeader"]	= "Type";
		["UiWealth"]	= "Fortune";
		["UiWononBid"]	= "Gagné sur enchere";
		["UiWononBuyout"]	= "Gagné sur achat direct";

	};

	itIT = {

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Casa d'aste dell'Alleanza";
		["MailAuctionCancelledSubject"]	= "Asta annullata";
		["MailAuctionExpiredSubject"]	= "Asta espirata";
		["MailAuctionSuccessfulSubject"]	= "Asta riuscita";
		["MailAuctionWonSubject"]	= "Asta vinta";
		["MailHordeAuctionHouse"]	= "Casa d'aste dell'Orda";
		["MailOutbidOnSubject"]	= "Battuto su";

		-- Section: User Interface
		["UiAuctions"]	= "Aste";
		["UiAuctionTransaction"]	= "Asta";
		["UiBids"]	= "Offerte";
		["UiBidTransaction"]	= "Offerta";
		["UiBuyerSellerHeader"]	= "Compratore/Venditore";
		["UiBuyTransaction"]	= "Compra";
		["UiDateHeader"]	= "Data";
		["UiDepositTransaction"]	= "Deposito";
		["UiExactNameSearch"]	= "Ricerca nome esatto";
		["UiNameHeader"]	= "Oggetto";
		["UiNetHeader"]	= "Netto";
		["UiNetPerHeader"]	= "Netto per";
		["UiPriceHeader"]	= "Prezzo";
		["UiPricePerHeader"]	= "Prezzo per";
		["UiPurchases"]	= "Compere";
		["UiQuantityHeader"]	= "Q.tà";
		["UiSales"]	= "Vendite";
		["UiSearch"]	= "Ricerca";
		["UiSearchForLabel"]	= "Cerca per:";
		["UiSellTransaction"]	= "Vendi";
		["UiTransactions"]	= "Transazioni";
		["UiTransactionsLabel"]	= "Transazioni:";
		["UiTransactionTypeHeader"]	= "Tipo";

	};

	koKR = {

		-- Section: Config Text
		["C_BeanCounterConfig"]	= "콩순이 설정";
		["C_BeanCounterOptions"]	= "콩순이 옵션";
		["C_DateString"]	= "사용할 날짜 형식: ";
		["C_DateStringExample"]	= "날짜 예제: ";
		["C_ExtenalSearch"]	= "외부 애드온이 콩순이 검색을 사용하도록 허락합니까?";
		["C_MailInvoiceTimeout"]	= "우편 송장 타임아웃 = %d 초";
		["C_MailRecolor"]	= "우편에 다시 색입히는 방법";

		-- Section: Generic Strings
		["NoRe-Color"]	= "다시 색을 입히지 않음";
		["off"]	= "끄기";
		["on"]	= "켜기";
		["Re-ColorIcons"]	= "아이콘에 다시 색입히기";
		["Re-ColorIconsandText"]	= "아이콘과 글자에 다시 색입히기";
		["Re-ColorText"]	= "글씨에 다시 색입히기";

		-- Section: Help Text
		["A_DateString"]	= "콩순이의 GUI창에 보이는 날짜의 형식을 결정합니다.\n명령어 앞에 %를 붙여야 하고, 복수의 명령어와 글씨가 혼합될 수 있습니다.\n예를 들어 %a == %X라고 하면 수요일 == 21:34:21로 표시됩니다.";
		["A_DateStringCommands"]	= "명령어 : \n %a = 요일 약자, \n %A = 요일, \n %b = 월 약자, \n %B = 월,\n %c = 날짜와 시간, \n %d = 일(01-31일),\n %H = 시간 (24시간제), \n %I = 시간(12시간제),\n %M = 분, \n %m = 월(숫자),\n %p = a ";
		["A_ExtenalSearch"]	= "다른 애드온이 콩순이를 이용해 아이템을 검색하여 콩순이 GUI에 보이도록 할 수 있습니다. 예를 들면 Appraiser에서 보고있는 아이템이 무엇인지 콩순이가 보여주도록 합니다.";
		["A_MailInvoiceTimeout"]	= "송장 요청에 서버가 반응하기를 기다리는 시간입니다. 송장이란 경매장에서 온 우편의 누구, 무엇, 어떻게 부분입니다.";
		["A_MailRecolor"]	= "콩순이는 경매장에서 온 모든 우편을 읽습니다. 이 옵션은 우편을 안 읽은 것처럼 다시 색을 입힐지를 결정합니다.";
		["HelpGuiItemBox"]	= "아이템을 검색창에 떨굽니다.";
		["Q_DateString"]	= "사용할 날짜 형식이란?";
		["Q_DateStringCommands"]	= "알맞는 날짜 명령어란?";
		["Q_ExtenalSearch"]	= "외부 애드온의 콩순이 사용이란?";
		["Q_MailInvoiceTimeout"]	= "우편 송장 타임아웃이란?";
		["Q_MailRecolor"]	= "다시 색입히기란?";

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "얼라이언스 경매장";
		["MailAuctionCancelledSubject"]	= "경매 취소";
		["MailAuctionExpiredSubject"]	= "경매 만료";
		["MailAuctionSuccessfulSubject"]	= "경매 완료";
		["MailAuctionWonSubject"]	= "경매 낙찰";
		["MailHordeAuctionHouse"]	= "호드 경매장";
		["MailOutbidOnSubject"]	= "보다 높은 가격이 제시됨";
		["MailSalePendingOnSubject"]	= "판매 예정";

		-- Section: Tooltip Messages
		["TTDateString"]	= "날짜 부분에 보일 형식을 넣습니다. 기본값은 %c입니다.";
		["TTDateStringExample"]	= "설정된 날짜 형식의 예제를 보여줍니다.";
		["TTExtenalSearch"]	= "다른 애드온에서 검색을 하면, 콩순이도 그 아이템에 대한 검색결과를 보여줍니다.";
		["TTMailInvoiceTimeout"]	= "서버로부터 우편 송장을 얻기 위해 몇번이나 시도할지를 정합니다. 값을 낮추면 빠르지만 데이터가 빠져있을 확률이 있고, 값을 높이면 느리지만 우편 서버가 극히 바쁠경우 데이터를 가져올 확률을 높입니다.";
		["TTMailRecolor"]	= "콩순이가 우편함을 검색한 다음에 우편이 어떻게 보일지를 결정합니다.";

		-- Section: User Interface
		["UiAddonTitle"]	= "콩순이: 경매결과 데이터베이스";
		["UiAucExpired"]	= "경매 만료";
		["UiAucSuccessful"]	= "경매 완료";
		["UiAuctions"]	= "경매품";
		["UiAuctionTransaction"]	= "경매";
		["UiBids"]	= "입찰품";
		["UiBidTransaction"]	= "입찰";
		["UiBuyerSellerHeader"]	= "구매자/판매자";
		["UiBuyTransaction"]	= "구입";
		["UiClassicCheckBox"]	= "불타는 성전의 옛 데이터 표시";
		["UiData"]	= "데이터";
		["UiDateHeader"]	= "날짜";
		["UiDepositTransaction"]	= "보증금";
		["UiDone"]	= "완료";
		["UiExactNameSearch"]	= "정확한 이름 찾기";
		["UiFailedAuctions"]	= "실패한 경매";
		["UiFee"]	= "수수료";
		["UiNameHeader"]	= "아이템";
		["UiNetHeader"]	= "항목";
		["UiNetPerHeader"]	= "항목내용";
		["UiOutbid"]	= "상회 입찰";
		["UiOutbids"]	= "상회 입찰";
		["UiPriceHeader"]	= "가격";
		["UiPriceper"]	= "개당 가격";
		["UiPricePerHeader"]	= "가격 항목";
		["UiPurchases"]	= "구입";
		["UiQuantityHeader"]	= "수량";
		["UiSales"]	= "판매";
		["UiSearch"]	= "검색";
		["UiSearchForLabel"]	= "검색:";
		["UiSellTransaction"]	= "판매";
		["UiServer"]	= "서버";
		["UiTransactions"]	= "거래";
		["UiTransactionsLabel"]	= "거래:";
		["UiTransactionTypeHeader"]	= "형식";
		["UiWealth"]	= "재산";
		["UiWononBid"]	= "구입";
		["UiWononBuyout"]	= "즉시 구입";

	};

	nlNL = {

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Alliance Auction House";
		["MailAuctionCancelledSubject"]	= "Auction cancelled";
		["MailAuctionExpiredSubject"]	= "Auction expired";
		["MailAuctionSuccessfulSubject"]	= "Auction successful";
		["MailAuctionWonSubject"]	= "Auction won";
		["MailHordeAuctionHouse"]	= "Horde Auction House";
		["MailOutbidOnSubject"]	= "Outbid on";

		-- Section: User Interface
		["UiAuctions"]	= "Veilingen";
		["UiAuctionTransaction"]	= "Veiling";
		["UiBids"]	= "Biedingen";
		["UiBidTransaction"]	= "Bod";
		["UiBuyerSellerHeader"]	= "Koper/Verkoper";
		["UiBuyTransaction"]	= "Koop";
		["UiDateHeader"]	= "Datum";
		["UiDepositTransaction"]	= "Storting";
		["UiExactNameSearch"]	= "Zoek op exacte naam";
		["UiNameHeader"]	= "Item";
		["UiNetHeader"]	= "Net";
		["UiNetPerHeader"]	= "Net Per";
		["UiPriceHeader"]	= "Prijs";
		["UiPricePerHeader"]	= "Stuksprijs";
		["UiPurchases"]	= "Aankopen";
		["UiQuantityHeader"]	= "Hoev.";
		["UiSales"]	= "Verkopen";
		["UiSearch"]	= "Zoek";
		["UiSearchForLabel"]	= "Zoek naar:";
		["UiSellTransaction"]	= "Verkoop";
		["UiTransactions"]	= "Transacties";
		["UiTransactionsLabel"]	= "Transacties:";
		["UiTransactionTypeHeader"]	= "Type";

	};

	ptPT = {

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Leilão da Alliance";
		["MailAuctionCancelledSubject"]	= "Leilão Cancelado";
		["MailAuctionExpiredSubject"]	= "Leilão Expirou";
		["MailAuctionSuccessfulSubject"]	= "Leilão Bem Sucedido";
		["MailAuctionWonSubject"]	= "Leilão Ganho";
		["MailHordeAuctionHouse"]	= "Leilão da Horde";
		["MailOutbidOnSubject"]	= "Sobrebidado em";

		-- Section: User Interface
		["UiAuctions"]	= "Leilões";
		["UiAuctionTransaction"]	= "Leilão";
		["UiBids"]	= "Ofertas";
		["UiBidTransaction"]	= "Oferta";
		["UiBuyerSellerHeader"]	= "Comprador/Vendedor";
		["UiBuyTransaction"]	= "Compra";
		["UiDateHeader"]	= "Data";
		["UiDepositTransaction"]	= "Depósito";
		["UiExactNameSearch"]	= "Procura por nome exacto";
		["UiNameHeader"]	= "Objecto";
		["UiNetHeader"]	= "Rede";
		["UiNetPerHeader"]	= "Rede por";
		["UiPriceHeader"]	= "Preço";
		["UiPricePerHeader"]	= "Cabeçalho de Preço";
		["UiPurchases"]	= "Compras";
		["UiQuantityHeader"]	= "Qtn";
		["UiSales"]	= "Vendas";
		["UiSearch"]	= "Procura";
		["UiSearchForLabel"]	= "Procurar por:";
		["UiSellTransaction"]	= "Vender";
		["UiTransactions"]	= "Transacções";
		["UiTransactionsLabel"]	= "Transacções";
		["UiTransactionTypeHeader"]	= "Tipo";

	};

	ruRU = {

		-- Section: Config Text
		["C_BeanCounterConfig"]	= "Параметры BeanCounter";
		["C_BeanCounterOptions"]	= "Опции BeanCounter";
		["C_DateString"]	= "Используемый формат даты:";
		["C_DateStringExample"]	= "Пример даты:";
		["C_ExtenalSearch"]	= "Позволить сторонним аддонам использовать поиск BeanCounter'а?";
		["C_MailInvoiceTimeout"]	= "Перерыв Почтовой Накладной";
		["C_MailRecolor"]	= "способ определения цвета почты";

		-- Section: Generic Strings
		["NoRe-Color"]	= "Не изменять цвет";
		["off"]	= "выкл";
		["on"]	= "вкл";
		["Re-ColorIcons"]	= "Изменить цвет иконок";
		["Re-ColorIconsandText"]	= "Изменить цвет иконок и текста";
		["Re-ColorText"]	= "Изменить цвет текста";

		-- Section: Help Text
		["A_DateString"]	= "Эта опция определяет, как поле Дата BeanCounter отображает в интерфейсе. Команды перед % и несколько команд с текстом могут быть употреблятся одновременно. Для примера %a == %X покажут Пн == 21:34:21";
		["A_DateStringCommands"]	= "Комманды \n %a = аббр. дня недели,  \n %A = полное название дня недели, \n %b = аббр. месяца, \n %B = month name - название месяца, \n %c = дата и время, \n %d = число (01-31), \n %H = часов (24), \n %I = часов (12),\n %M = минут,\n %m = месяц(12),\n %p = a";
		["A_ExtenalSearch"]	= "Другие аддоны могут использовать BeanCounter-поиск, который покажет BeanCounter-интерфейс. Например, это позволит BeanCounter-у показывать при просмотре Оценщика (Appraiser)";
		["A_MailInvoiceTimeout"]	= "Время ожидания ответа от сервера накладной. Накладная -  кто, что, как почты дома Аукциона.";
		["A_MailRecolor"]	= "BeanCounter читает всю почту от Аукционного дома. Этот параметр скажет BeanCounter'у, как пользователь хочет изменить цвет сообщений, чтобы было видно что они не прочитаны.";
		["HelpGuiItemBox"]	= "Поместите предмет в ячейку для поиска.";
		["Q_DateString"]	= "Используемый формат даты?";
		["Q_DateStringCommands"]	= "Приемлемые Команды Даты?";
		["Q_ExtenalSearch"]	= "Позволить сторонним аддонам использовать BeanCounter?";
		["Q_MailInvoiceTimeout"]	= "Сколько задержка почты?";
		["Q_MailRecolor"]	= "Как перекрашивать?";

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "Аукцион Альянса";
		["MailAuctionCancelledSubject"]	= "Аукцион отменен";
		["MailAuctionExpiredSubject"]	= "Аукцион просрочен";
		["MailAuctionSuccessfulSubject"]	= "Аукцион успешно состоялся";
		["MailAuctionWonSubject"]	= "Аукцион выигран";
		["MailHordeAuctionHouse"]	= "Аукцион Орды";
		["MailNeutralAuctionHouse"]	= "Аукцион Черной Воды";
		["MailOutbidOnSubject"]	= "Ставка принята";
		["MailSalePendingOnSubject"]	= "Продажа в течение";

		-- Section: Tooltip Messages
		["TTDateString"]	= "Введите формат, в котором Вы хотели бы видеть отображаемую дату. По умолчанию %c";
		["TTDateStringExample"]	= "Отображает каким именно образом будет выглядеть Ваш формат даты.";
		["TTExtenalSearch"]	= "Когда производится поиск в другом аддоне, BeanCounter будет также отображать поиск для этого предмета.";
		["TTMailInvoiceTimeout"]	= "Выбор того, насколько долго BeanCounter будет пытаться получить входящую почту с сервера до того как прекратит попытки. Ниже == быстрее, но велик шанс потерять часть данных, выше == медленнее, но увеличивает шансы получить данные даже если почтовый сервер слишком занят.";
		["TTMailRecolor"]	= "Выберите каким именно образом почта будет появляться после того, как BeanCounter просканирует почтовый ящик.";

		-- Section: User Interface
		["UiAddonTitle"]	= "BeanCounter: Аукционная база данных";
		["UiAucExpired"]	= "Просроченный аук.";
		["UiAucSuccessful"]	= "Успешный аук.";
		["UiAuctions"]	= "Аукционы";
		["UiAuctionTransaction"]	= "Аукцион";
		["UiBids"]	= "Ставки";
		["UiBidTransaction"]	= "Ставка";
		["UiBuyerSellerHeader"]	= "Покупатель/Продавец";
		["UiBuyTransaction"]	= "Купить";
		["UiClassicCheckBox"]	= "Показать прошлые данные";
		["UiData"]	= "Данные";
		["UiDateHeader"]	= "Дата";
		["UiDepositTransaction"]	= "Депозит";
		["UiDone"]	= "Завершить";
		["UiExactNameSearch"]	= "Поиск точного имени";
		["UiFailedAuctions"]	= "Неудавщийся аукционы";
		["UiFee"]	= "Оплата";
		["UiNameHeader"]	= "Предмет";
		["UiNetHeader"]	= "Сеть";
		["UiNetPerHeader"]	= "Сеть за";
		["UiOutbid"]	= "Выкуп";
		["UiOutbids"]	= "Выкупы";
		["UiPriceHeader"]	= "Цена";
		["UiPriceper"]	= "Цена/За";
		["UiPricePerHeader"]	= "Цена Заголовка";
		["UiPurchases"]	= "Покупок";
		["UiQuantityHeader"]	= "Кол-во";
		["UiSales"]	= "Продажи";
		["UiSearch"]	= "Поиск";
		["UiSearchForLabel"]	= "Поиск:";
		["UiSellTransaction"]	= "Продажа";
		["UiServer"]	= "Сервер";
		["UiTransactions"]	= "Переводы";
		["UiTransactionsLabel"]	= "Переводы:";
		["UiTransactionTypeHeader"]	= "Тип";
		["UiWealth"]	= "Состояние";
		["UiWononBid"]	= "Выиграно по ставке";
		["UiWononBuyout"]	= "Выиграно по выкупу";

	};

	zhCN = {

		-- Section: Config Text
		["C_BeanCounterConfig"]	= "BeanCounter 设置";
		["C_BeanCounterOptions"]	= "BeanCounter 选项";
		["C_DateString"]	= "使用的日期格式:";
		["C_DateStringExample"]	= "示例日期:";
		["C_ExtenalSearch"]	= "允许外部插件使用BeanCounter的搜索?";
		["C_MailInvoiceTimeout"]	= "邮箱通知延迟=%d秒";
		["C_MailRecolor"]	= "邮箱上色方法";

		-- Section: Generic Strings
		["NoRe-Color"]	= "无上色";
		["off"]	= "关闭";
		["on"]	= "开启";
		["Re-ColorIcons"]	= "为图标上色";
		["Re-ColorIconsandText"]	= "为图标和文字上色";
		["Re-ColorText"]	= "为文字上色";

		-- Section: Help Text
		["A_DateString"]	= "控制BeanCounter的GUI如何显示日期.命令以%作为前缀,并且可以混用多个命令与文字.例如%a==%X将显示Wed==21:34:21";
		["A_DateStringCommands"]	= "命令:\n %a = 缩写的日期名,\n %A = 日期名, \n %b = 缩写的月名, \n %B = 月名,\n %c = 日期和时间, \n %d = 日 (01-31),\n %H = 小时 (24), \n %I = 小时 (12),\n %M = 分, \n %m = 月,\n %p = 每";
		["A_ExtenalSearch"]	= "其他插件可以请求于BeanCounter的GUI内显示一件物品的搜索结果. 例如 此允许BeanCounter显示你在Appraiser查找的物品.";
		["A_MailInvoiceTimeout"]	= "BeanCounter将等待的服务器的通知请求的时间.通知是一个记载了谁,什么,多少钱的拍卖行邮件.";
		["A_MailRecolor"]	= "BeanCounter读取来自拍卖行的所有邮件,此选项告诉BeanCounter如何将未读邮件上色以便用户阅读.";
		["HelpGuiItemBox"]	= "拖入物品以开始搜索";
		["Q_DateString"]	= "使用日期格式?";
		["Q_DateStringCommands"]	= "可接受日期命令?";
		["Q_ExtenalSearch"]	= "允许外部插件使用BeanCounter?";
		["Q_MailInvoiceTimeout"]	= "什么是邮件通知延迟?";
		["Q_MailRecolor"]	= "什么是上色?";

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "联盟拍卖行";
		["MailAuctionCancelledSubject"]	= "拍卖取消";
		["MailAuctionExpiredSubject"]	= "拍卖已到期";
		["MailAuctionSuccessfulSubject"]	= "拍卖成功";
		["MailAuctionWonSubject"]	= "竞拍获胜";
		["MailHordeAuctionHouse"]	= "部落拍卖行";
		["MailNeutralAuctionHouse"]	= "黑水拍卖行";
		["MailOutbidOnSubject"]	= "出价被压过";
		["MailSalePendingOnSubject"]	= "竞买等待中";

		-- Section: Tooltip Messages
		["TTDateString"]	= "键入你期望的日期显示格式.默认为%c";
		["TTDateStringExample"]	= "显示一个示例的日期";
		["TTExtenalSearch"]	= "当在其他插件中键入一个搜索,BeanCounter也将显示一个搜索结果";
		["TTMailInvoiceTimeout"]	= "选择BeanCounter将尝试从服务器获取一个邮件通知的时间.低==更快但较高几率丢失数据,高==更慢但可提高获取数据的几率(如果邮件服务器非常忙).";
		["TTMailRecolor"]	= "选择BeanCounter扫描邮箱后邮件的显示方式.";

		-- Section: User Interface
		["UiAddonTitle"]	= "BeanCounter: 拍卖历史数据库";
		["UiAucExpired"]	= "拍卖过期";
		["UiAucSuccessful"]	= "拍卖成功";
		["UiAuctions"]	= "拍卖";
		["UiAuctionTransaction"]	= "拍卖";
		["UiBids"]	= "出价";
		["UiBidTransaction"]	= "竞标";
		["UiBuyerSellerHeader"]	= "买主/卖主";
		["UiBuyTransaction"]	= "购买";
		["UiClassicCheckBox"]	= "显示BC传统数据";
		["UiData"]	= "数据";
		["UiDateHeader"]	= "日期";
		["UiDepositTransaction"]	= "保管费";
		["UiDone"]	= "完成";
		["UiExactNameSearch"]	= "确切名字搜索";
		["UiFailedAuctions"]	= "已失败的拍卖";
		["UiFee"]	= "费用";
		["UiNameHeader"]	= "物品";
		["UiNetHeader"]	= "净利";
		["UiNetPerHeader"]	= "单件净利";
		["UiOutbid"]	= "最高出价";
		["UiOutbids"]	= "最高出价";
		["UiPriceHeader"]	= "价格";
		["UiPriceper"]	= "价格/单件";
		["UiPricePerHeader"]	= "单件价格";
		["UiPurchases"]	= "购买";
		["UiQuantityHeader"]	= "数量";
		["UiSales"]	= "销售";
		["UiSearch"]	= "搜索";
		["UiSearchForLabel"]	= "搜索";
		["UiSellTransaction"]	= "出售";
		["UiServer"]	= "服务器";
		["UiTransactions"]	= "交易";
		["UiTransactionsLabel"]	= "交易";
		["UiTransactionTypeHeader"]	= "类型";
		["UiWealth"]	= "大量";
		["UiWononBid"]	= "竞拍获胜";
		["UiWononBuyout"]	= "一口价获胜";

	};

	zhTW = {

		-- Section: Config Text
		["C_BeanCounterConfig"]	= "拍賣記錄器設定";
		["C_BeanCounterOptions"]	= "拍賣記錄器選項";
		["C_DateString"]	= "資料格式使用";
		["C_DateStringExample"]	= "範例資料";
		["C_ExtenalSearch"]	= "允許其他addons使用拍賣記錄器的搜尋？";
		["C_MailInvoiceTimeout"]	= "郵件通知到期 = %d 秒";
		["C_MailRecolor"]	= "信件重新上色方法";

		-- Section: Generic Strings
		["NoRe-Color"]	= "不重新上色";
		["off"]	= "關閉";
		["on"]	= "開啟";
		["Re-ColorIcons"]	= "圖標重新上色";
		["Re-ColorIconsandText"]	= "圖標和文字重新上色";
		["Re-ColorText"]	= "文字重新上色";

		-- Section: Help Text
		["HelpGuiItemBox"]	= "將物品丟入格中搜尋";
		["Q_DateString"]	= "要使用的資料格式？";
		["Q_DateStringCommands"]	= "接受資料指令？";
		["Q_ExtenalSearch"]	= "允許外部addons使用拍賣記錄器？";
		["Q_MailInvoiceTimeout"]	= "什麼是郵件通知逾時？";
		["Q_MailRecolor"]	= "什麼是重新上色？";

		-- Section: Mail
		["MailAllianceAuctionHouse"]	= "聯盟拍賣場";
		["MailAuctionCancelledSubject"]	= "拍賣已取消";
		["MailAuctionExpiredSubject"]	= "拍賣過期";
		["MailAuctionSuccessfulSubject"]	= "拍賣成功";
		["MailAuctionWonSubject"]	= "得標";
		["MailHordeAuctionHouse"]	= "部落拍賣場";
		["MailOutbidOnSubject"]	= "出價失敗";
		["MailSalePendingOnSubject"]	= "出價等待中";

		-- Section: Tooltip Messages
		["TTDateString"]	= "請輸入資料欄位想使用的格式. 預設為 %c";
		["TTDateStringExample"]	= "顯示現在資料格式範例";
		["TTExtenalSearch"]	= "當從其他addon輸入搜尋時，拍賣記錄野將顯示物品搜尋結果";
		["TTMailRecolor"]	= "選擇交易拍賣在掃瞄信箱後如何顯示郵件";

		-- Section: User Interface
		["UiAddonTitle"]	= "拍賣記錄器：拍賣交易歷史資料庫";
		["UiAucExpired"]	= "拍賣逾時";
		["UiAucSuccessful"]	= "拍賣成功！";
		["UiAuctions"]	= "拍賣場";
		["UiAuctionTransaction"]	= "拍賣";
		["UiBids"]	= "出價";
		["UiBidTransaction"]	= "出價";
		["UiBuyerSellerHeader"]	= "買方/賣方";
		["UiBuyTransaction"]	= "買";
		["UiClassicCheckBox"]	= "顯示拍賣交易的傳統資料";
		["UiData"]	= "資料";
		["UiDateHeader"]	= "日期";
		["UiDepositTransaction"]	= "保管費";
		["UiDone"]	= "完成";
		["UiExactNameSearch"]	= "完整名稱比對";
		["UiFailedAuctions"]	= "失敗的拍賣";
		["UiFee"]	= "費用";
		["UiNameHeader"]	= "物品";
		["UiNetHeader"]	= "淨利";
		["UiNetPerHeader"]	= "單件淨利";
		["UiOutbid"]	= "超過出價";
		["UiOutbids"]	= "超過出價";
		["UiPriceHeader"]	= "價格";
		["UiPriceper"]	= "單一價格";
		["UiPricePerHeader"]	= "價格標題";
		["UiPurchases"]	= "購買";
		["UiQuantityHeader"]	= "數量";
		["UiSales"]	= "銷售";
		["UiSearch"]	= "搜尋";
		["UiSearchForLabel"]	= "搜尋";
		["UiSellTransaction"]	= "出售";
		["UiServer"]	= "伺服器";
		["UiTransactions"]	= "交易";
		["UiTransactionsLabel"]	= "交易";
		["UiTransactionTypeHeader"]	= "類別";
		["UiWealth"]	= "財產";
		["UiWononBid"]	= "成功出價";
		["UiWononBuyout"]	= "成功直購";

	};

}