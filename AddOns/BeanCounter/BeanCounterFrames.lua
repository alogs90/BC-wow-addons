--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.0.0 (BillyGoat)
	Revision: $Id: BeanCounterFrames.lua 3502 2008-09-17 18:03:11Z root $
	URL: http://auctioneeraddon.com/
	
	BeanCounterFrames - AuctionHouse UI for Beancounter 

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
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
]]

local lib = BeanCounter
local private = lib.Private
local print =  BeanCounter.Print
local _BC = private.localizations

local function debugPrint(...) 
    if private.getOption("util.beancounter.debugFrames") then
        private.debugPrint("BeanCounterFrames",...)
    end
end

local frame
function private.AuctionUI()
	if frame then return end
	frame = private.frame
	
	--Create the TAB
	frame.ScanTab = CreateFrame("Button", "AuctionFrameTabUtilBeanCounter", AuctionFrame, "AuctionTabTemplate")
	frame.ScanTab:SetText("BeanCounter")
	frame.ScanTab:Show()
	
	PanelTemplates_DeselectTab(frame.ScanTab)
	
	if AucAdvanced then
		AucAdvanced.AddTab(frame.ScanTab, frame)
	else
		private.AddTab(frame.ScanTab, frame)
	end
	
	function frame.ScanTab.OnClick(_, _, index)
		if private.frame:GetParent() == BeanCounterBaseFrame then
			BeanCounterBaseFrame:Hide()
			private.frame:SetParent(AuctionFrame)
			frame:SetPoint("TOPLEFT", "AuctionFrame", "TOPLEFT")
			--private.frame:SetWidth(834.
			--private.frame:SetHeight(450)
			private.relevelFrame(frame)--make sure our frame stays in proper order		
		end
	
		if not index then index = this:GetID() end
		local tab = getglobal("AuctionFrameTab"..index)
		if (tab and tab:GetName() == "AuctionFrameTabUtilBeanCounter") then
			--Modified Textures
			AuctionFrameTopLeft:SetTexture("Interface\\AddOns\\BeanCounter\\Textures\\BC-TopLeft")
			AuctionFrameTop:SetTexture("Interface\\AddOns\\BeanCounter\\Textures\\BC-Top")
			AuctionFrameTopRight:SetTexture("Interface\\AddOns\\BeanCounter\\Textures\\BC-TopRight")
			--Default AH textures
			AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotLeft")
			AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-Bot")
			AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotRight")
			
			--print(tab:GetName())
			
			if (AuctionDressUpFrame:IsVisible()) then
				AuctionDressUpFrame:Hide()
				AuctionDressUpFrame.reshow = true
			end
			frame:Show()
		else
			if (AuctionDressUpFrame.reshow) then
				AuctionDressUpFrame:Show()
				AuctionDressUpFrame.reshow = nil
			end
			AuctionFrameMoneyFrame:Show()
			frame:Hide()
		end
	end
	
	hooksecurefunc("AuctionFrameTab_OnClick", frame.ScanTab.OnClick)
end
--Change parent to our GUI base frame/ Also used to display our Config frame
function private.GUI(_, button)
	if (button == "LeftButton") then
		if private.frame:GetParent() == AuctionFrame then 
			private.frame:SetParent("BeanCounterBaseFrame")
			private.frame:SetPoint("TOPLEFT", BeanCounterBaseFrame, "TOPLEFT")
		end
		if not BeanCounterBaseFrame:IsVisible() then
			if AuctionFrame then AuctionFrame:Hide() end
			BeanCounterBaseFrame:Show()
			--private.frame:SetFrameStrata("FULLSCREEN")
			private.frame:Show()
		else
			BeanCounterBaseFrame:Hide()
		end
	else 
		if not lib.Gui:IsVisible() then
			lib.Gui:Show()
		else
			lib.Gui:Hide()
		end
	end
		
end

--Seperated frame items from frame creation, this should allow the same code to be reused for AH UI and Standalone UI
function private.CreateFrames()

	--Create the base frame for external GUI
	local base = CreateFrame("Frame", "BeanCounterBaseFrame", UIParent)
	base:SetFrameStrata("HIGH")
	base:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	base:SetBackdropColor(0,0,0, 1)
	base:Hide()
	
	base:SetPoint("CENTER", UIParent, "CENTER")
	base:SetWidth(834.5)
	base:SetHeight(450)
	
	
	base:SetMovable(true)
	base:EnableMouse(true)
	base:SetToplevel(true)
	
	base.Drag = CreateFrame("Button", nil, base)
	base.Drag:SetPoint("TOPLEFT", base, "TOPLEFT", 10,-5)
	base.Drag:SetPoint("TOPRIGHT", base, "TOPRIGHT", -10,-5)
	base.Drag:SetHeight(6)
	base.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

	base.Drag:SetScript("OnMouseDown", function() base:StartMoving() end)
	base.Drag:SetScript("OnMouseUp", function() base:StopMovingOrSizing() private.setter("configator.left", base:GetLeft()) private.setter("configator.top", base:GetTop()) end)
	
	base.DragBottom = CreateFrame("Button",nil, base)
	base.DragBottom:SetPoint("BOTTOMLEFT", base, "BOTTOMLEFT", 10,5)
	base.DragBottom:SetPoint("BOTTOMRIGHT", base, "BOTTOMRIGHT", -10,5)
	base.DragBottom:SetHeight(6)
	base.DragBottom:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")

	base.DragBottom:SetScript("OnMouseDown", function() base:StartMoving() end)
	base.DragBottom:SetScript("OnMouseUp", function() base:StopMovingOrSizing() private.setter("configator.left", base:GetLeft()) private.setter("configator.top", base:GetTop()) end)
			
	--Launch BeanCounter GUI Config frame
	base.Config = CreateFrame("Button", nil, base, "OptionsButtonTemplate")
	base.Config:SetPoint("BOTTOMRIGHT", base, "BOTTOMRIGHT", -10, 10)
	base.Config:SetScript("OnClick", function() base:Hide() end)
	base.Config:SetText(_BC('UiDone'))
			
	--Create the Actual Usable Frame
	local frame = CreateFrame("Frame", "BeanCounterUiFrame", base)
	private.frame = frame
	frame:Hide()
	
	private.frame:SetPoint("TOPLEFT", base, "TOPLEFT")
	private.frame:SetWidth(828)
	private.frame:SetHeight(450)	
	
	--Add Title to the Top
	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", frame, "TOPLEFT", 80, -17)
	title:SetText(_BC("UiAddonTitle")) 

	local SelectBox = LibStub:GetLibrary("SelectBox")
	local ScrollSheet = LibStub:GetLibrary("ScrollSheet")
	
	--Beginner Tooltips script display for all UI elements 
	function private.buttonTooltips(self, text)
		if private.getOption("util.beancounter.displaybeginerTooltips") and text and self then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:SetText(text)
		end
	end

	--Add Configuration Button for those who dont use sidebar.
	frame.Config = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
	frame.Config:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -139, -13)
	frame.Config:SetScript("OnClick", function() private.GUI() end)
	frame.Config:SetText("Configure")
	frame.Config:SetScript("OnEnter", function() private.buttonTooltips( frame.Config, "Opens the BeanCounter configuration window") end)
	frame.Config:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	
	--ICON box, used to drag item and display ICo for item being searched. Based Appraiser Code
	function frame.IconClicked()
		local objtype, _, link = GetCursorInfo()
		ClearCursor()
		if objtype == "item" then
			local itemID = lib.API.decodeLink(link)
			local _, itemName =  lib.API.getItemString(link)
			local itemTexture = select(2, private.getItemInfo(link, "name")) 
			frame.searchBox:SetText(itemName)
			private.searchByItemID(itemID, private.getCheckboxSettings(), nil, 150, itemTexture, itemName)
		end
	end 
	
	frame.slot = frame:CreateTexture(nil, "BORDER")
	frame.slot:SetPoint("TOPLEFT", frame, "TOPLEFT", 23, -125)
	frame.slot:SetWidth(45)
	frame.slot:SetHeight(45)
	frame.slot:SetTexCoord(0.15, 0.85, 0.15, 0.85)
	frame.slot:SetTexture("Interface\\Buttons\\UI-EmptySlot")

	frame.icon = CreateFrame("Button", nil, frame)
	frame.icon:SetPoint("TOPLEFT", frame.slot, "TOPLEFT", 3, -3)
	frame.icon:SetWidth(38)
	frame.icon:SetHeight(38)
	frame.icon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square.blp")
	frame.icon:SetScript("OnClick", frame.IconClicked)
	frame.icon:SetScript("OnReceiveDrag", frame.IconClicked)
	frame.icon:SetScript("OnEnter", function() private.buttonTooltips( frame.icon, "Drop an item here to start a search for it.\nDisplays current search's icon if possible") end)
	frame.icon:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	--help text
	frame.slot.help = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.slot.help:SetPoint("LEFT", frame.slot, "RIGHT", 2, 7)
	frame.slot.help:SetText(_BC('HelpGuiItemBox')) --"Drop item into box to search."
	frame.slot.help:SetWidth(100)
		
	--Select box, used to chooose where the stats comefrom we show server/faction/player/all
	frame.SelectBoxSetting = {"1","server"}
	function private.ChangeControls(obj, arg1,arg2,...)
		frame.SelectBoxSetting = {arg1, arg2}
	end
	--Default Server wide
	--Used GLOBALSTRINGS for the horde alliance translations
	local vals = {{"server", private.realmName.." ".._BC('UiData')},{"alliance", FACTION_ALLIANCE.." ".._BC('UiData')},{"horde", FACTION_HORDE.." ".._BC('UiData')},}
	for name,data in pairs(private.serverData) do 
		table.insert(vals,{name, name.." ".._BC('UiData')})
	end	
	
	frame.selectbox = CreateFrame("Frame", "BeanCounterSelectBox", frame)
	frame.selectbox.box = SelectBox:Create("BeanCounterSelectBox", frame.selectbox, 140, private.ChangeControls, vals, "default")
	frame.selectbox.box:SetPoint("TOPLEFT", frame, "TOPLEFT", 4,-80)
	frame.selectbox.box.element = "selectBox"
	frame.selectbox.box:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	frame.selectbox.box:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0,-90)
	frame.selectbox.box:SetText(private.realmName.." ".._BC('UiData'))
	frame.selectbox.box.button:SetScript("OnEnter", function() private.buttonTooltips( frame.selectbox.box.button, "Filter search results by server, player, faction") end)
	frame.selectbox.box.button:SetScript("OnLeave", function() GameTooltip:Hide() end)
		
	--Search box
	frame.searchBox = CreateFrame("EditBox", "BeancountersearchBox", frame, "InputBoxTemplate")
	frame.searchBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 29, -180)
	frame.searchBox:SetAutoFocus(false)
	frame.searchBox:SetHeight(15)
	frame.searchBox:SetWidth(150)
	frame.searchBox:SetScript("OnEnterPressed", function()
		private.startSearch(frame.searchBox:GetText(), private.getCheckboxSettings())
	end)
	frame.searchBox:SetScript("OnEnter", function() private.buttonTooltips( frame.searchBox, "Enter search query's here or leave blank to search all") end)
	frame.searchBox:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	
	--Search Button
	frame.searchButton = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
	frame.searchButton:SetPoint("TOPLEFT", frame.searchBox, "BOTTOMLEFT", -6, -1)
	frame.searchButton:SetText(_BC('UiSearch'))
	frame.searchButton:SetScript("OnClick", function()
		private.startSearch(frame.searchBox:GetText(), private.getCheckboxSettings())
	end)
	--Clicking for BC search --Thanks for the code Rockslice
	function private.ClickBagHook(_,_,button)
		if (frame.searchBox and frame.searchBox:IsVisible()) then
			local bag = this:GetParent():GetID()
			local slot = this:GetID()
			local link = GetContainerItemLink(bag, slot)
			if link then
				local itemID = lib.API.decodeLink(link)
				local _, itemName = lib.API.getItemString(link)
				local _, itemTexture = private.getItemInfo(link, "name")
				if (button == "LeftButton") and (IsAltKeyDown()) and itemName then
					--debugPrint(itemName, itemID,itemTexture, link)
					frame.searchBox:SetText(itemName)
					private.searchByItemID(itemID, private.getCheckboxSettings(), nil, 150, itemTexture, itemName) 
				end
			end
		end
	end	
	Stubby.RegisterFunctionHook("ContainerFrameItemButton_OnModifiedClick", -50, private.ClickBagHook)	
	
	function private.ClickLinkHook(itemString, link, button)
			if (frame.searchBox and frame.searchBox:IsVisible()) then
			if link then
				local itemID = lib.API.decodeLink(link)
				local _, itemName = lib.API.getItemString(link)				
				local _, itemTexture = private.getItemInfo(link, "name")
				if (button == "LeftButton") and (IsAltKeyDown()) and itemName then
					--debugPrint(itemName, itemID,itemTexture, link)
					frame.searchBox:SetText(itemName)
					private.searchByItemID(itemID, private.getCheckboxSettings(), nil, 150, itemTexture, itemName) 
				end
			end
		end
	end
	hooksecurefunc("ChatFrame_OnHyperlinkShow", private.ClickLinkHook)
	
	--Check boxes to narrow our search
	frame.exactCheck = CreateFrame("CheckButton", "BeancounterexactCheck", frame, "OptionsCheckButtonTemplate")
	frame.exactCheck:SetChecked(private.getOption("util.beancounter.ButtonExactCheck")) --get the last used checked/unchecked value Then use below script to store state changes
	frame.exactCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -217)
	frame.exactCheck:SetScript("OnClick", function() local set if frame.exactCheck:GetChecked() then set = true end private.setOption("util.beancounter.ButtonExactCheck", set) end)
	getglobal("BeancounterexactCheckText"):SetText(_BC('UiExactNameSearch'))
	frame.exactCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.exactCheck, "Only match the Exact text in the search box") end)
	frame.exactCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)

	--search classic data
	frame.classicCheck = CreateFrame("CheckButton", "BeancounterclassicCheck", frame, "OptionsCheckButtonTemplate")
	frame.classicCheck:SetChecked(false) --Set this to false We only want this to be true/searchabe if there is a classic DB to search
	frame.classicCheck:SetScript("OnClick", function() local set if frame.classicCheck:GetChecked() then set = true end private.setOption("util.beancounter.ButtonClassicCheck", set) end)
	getglobal("BeancounterclassicCheckText"):SetText(_BC('UiClassicCheckBox'))
	frame.classicCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -242)	
	frame.classicCheck:Hide()
	frame.classicCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.classicCheck, "Display results from BeanCounter Classic Database") end)
	frame.classicCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	--no need to show this button if theres no classic data to search
	if BeanCounterAccountDB then
		if BeanCounterAccountDB[private.realmName] then 
			frame.classicCheck:Show() --Show id classic has server data
			frame.classicCheck:SetChecked(private.getOption("util.beancounter.ButtonClassicCheck")) --Recall last checked state
		end
	end
	
	--search bids
	frame.bidCheck = CreateFrame("CheckButton", "BeancounterbidCheck", frame, "OptionsCheckButtonTemplate")
	frame.bidCheck:SetChecked(private.getOption("util.beancounter.ButtonBidCheck"))
	frame.bidCheck:SetScript("OnClick", function() local set if frame.bidCheck:GetChecked() then set = true end private.setOption("util.beancounter.ButtonBidCheck", set) end)
	getglobal("BeancounterbidCheckText"):SetText(_BC('UiBids'))
	frame.bidCheck:SetScale(0.85)
	frame.bidCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -335)
	frame.bidCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.bidCheck, "Display items bought from the Auction House") end)
	frame.bidCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	
	frame.bidFailedCheck = CreateFrame("CheckButton", "BeancounterbidFailedCheck", frame, "OptionsCheckButtonTemplate")
	frame.bidFailedCheck:SetChecked(private.getOption("util.beancounter.ButtonBidFailedCheck"))
	frame.bidFailedCheck:SetScript("OnClick", function() local set if frame.bidFailedCheck:GetChecked() then set = true end private.setOption("util.beancounter.ButtonBidFailedCheck", set) end)
	frame.bidFailedCheck:SetScale(0.85)
	getglobal("BeancounterbidFailedCheckText"):SetText(_BC('UiOutbids'))
	frame.bidFailedCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -435)
	frame.bidFailedCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.bidCheck, "Display items you were outbided on.") end)
	frame.bidFailedCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	--search Auctions
	frame.auctionCheck = CreateFrame("CheckButton", "BeancounterauctionCheck", frame, "OptionsCheckButtonTemplate")
	frame.auctionCheck:SetChecked(private.getOption("util.beancounter.ButtonAuctionCheck"))
	frame.auctionCheck:SetScript("OnClick", function() local set if frame.auctionCheck:GetChecked() then set = true end private.setOption("util.beancounter.ButtonAuctionCheck", set) end)
	getglobal("BeancounterauctionCheckText"):SetText(_BC('UiAuctions'))
	frame.auctionCheck:SetScale(0.85)
	frame.auctionCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -360)
	frame.auctionCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.auctionCheck, "Display items sold at the Auction House") end)
	frame.auctionCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
	
	frame.auctionFailedCheck = CreateFrame("CheckButton", "BeancounterauctionFailedCheck", frame, "OptionsCheckButtonTemplate")
	frame.auctionFailedCheck:SetChecked(private.getOption("util.beancounter.ButtonAuctionFailedCheck"))
	frame.auctionFailedCheck:SetScript("OnClick", function() local set if frame.auctionFailedCheck:GetChecked() then set = true end private.setOption("util.beancounter.ButtonAuctionFailedCheck", set) end)
	frame.auctionFailedCheck:SetScale(0.85)
	getglobal("BeancounterauctionFailedCheckText"):SetText(_BC('UiFailedAuctions')) 
	frame.auctionFailedCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -460)
	frame.auctionFailedCheck:SetScript("OnEnter", function() private.buttonTooltips( frame.auctionFailedCheck, "Display items you failed to sell.") end)
	frame.auctionFailedCheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
		
	--[[search Purchases (vendor/trade)
	frame.buyCheck = CreateFrame("CheckButton", "BeancounterbuyCheck", frame, "OptionsCheckButtonTemplate")
	frame.buyCheck:SetChecked(true)
	getglobal(BeancounterbuyCheck:GetName().."Text"):SetText("Buys")
	frame.buyCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -255)
	--search Sold (vendor/trade)
	frame.sellCheck = CreateFrame("CheckButton", "BeancountersellCheck", frame, "OptionsCheckButtonTemplate")
	frame.sellCheck:SetChecked(true)
	getglobal(BeancountersellCheck:GetName().."Text"):SetText("Sold")
	frame.sellCheck:SetPoint("TOPLEFT", frame, "TOPLEFT", 19, -330)]]
		
	--Create the results window
	frame.resultlist = CreateFrame("Frame", nil, frame)
	frame.resultlist:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
	
	frame.resultlist:SetBackdropColor(0, 0, 0.0, 0.5)
	frame.resultlist:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 187, 417.5)
	frame.resultlist:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 3, 0)
	frame.resultlist:SetPoint("BOTTOM", frame, "BOTTOM", 0, 37)
	
	--Scripts that are executed when we mouse over a TOOLTIP frame	
	function private.scrollSheetOnEnter(button, row, index)
		local link, name, _
		link = frame.resultlist.sheet.rows[row][index]:GetText() or "FAILED LINK"
		if link:match("^(|c%x+|H.+|h%[.+%])") then
			_, name = lib.API.getItemString(link)
		end
		GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
		if frame.resultlist.sheet.rows[row][index]:IsShown()then --Hide tooltip for hidden cells
			if link and name then
				GameTooltip:SetHyperlink(link)
				if (EnhTooltip) then EnhTooltip.TooltipCall(GameTooltip, name, link, -1, 1) end
			else
				GameTooltip:SetText("Unable to get Tooltip Info", 1.0, 1.0, 1.0)
			end
		end			
        end
	function private.scrollSheetOnLeave(button, row, index)
		GameTooltip:Hide()
	end
	--records the column width changes
	 --store width by header name, that way if column reorginizing is added we apply size to proper column
	function private.onResize(self, column,  width)
		if not width then 
			private.setOption("columnwidth."..self.labels[column]:GetText(), "default") --reset column if no width is passed. We use CTRL+rightclick to reset column
			self.labels[column].button:SetWidth(private.getOption("columnwidth."..self.labels[column]:GetText()))
		else
			private.setOption("columnwidth."..self.labels[column]:GetText(), width)
		end
	end
		
	local Buyer, Seller = string.match(_BC('UiBuyerSellerHeader'), "(.*)/(.*)")
	frame.resultlist.sheet = ScrollSheet:Create(frame.resultlist, {
		{ _BC('UiNameHeader'), "TOOLTIP",  private.getOption("columnwidth.".._BC('UiNameHeader')) },
		{ _BC('UiTransactions'), "TEXT", private.getOption("columnwidth.".._BC('UiTransactions')) },
		
		{_BC('UiBidTransaction') , "COIN", private.getOption("columnwidth.".._BC('UiBidTransaction')) },
		{ _BC('UiBuyTransaction') , "COIN", private.getOption("columnwidth.".._BC('UiBuyTransaction')) },
		{ _BC('UiNetHeader'), "COIN", private.getOption("columnwidth.".._BC('UiNetHeader')) },
		{ _BC('UiQuantityHeader'), "TEXT", private.getOption("columnwidth.".._BC('UiQuantityHeader')) },
		{ _BC('UiPriceper'), "COIN", private.getOption("columnwidth.".._BC('UiPriceper')) }, 
		
		{ "|CFFFFFF00"..Seller.."/|CFF4CE5CC"..Buyer, "TEXT", private.getOption("columnwidth.".."|CFFFFFF00"..Seller.."/|CFF4CE5CC"..Buyer) },
				
		{ _BC('UiDepositTransaction'), "COIN", private.getOption("columnwidth.".._BC('UiDepositTransaction')) },
		{ _BC("UiFee"), "COIN", private.getOption("columnwidth.".._BC("UiFee")) }, 
		{ _BC('UiReason'), "TEXT", private.getOption("columnwidth.".._BC('UiReason')) }, 
		{ _BC('UiDateHeader'), "text", private.getOption("columnwidth.".._BC('UiDateHeader')) },
	}, private.scrollSheetOnEnter, private.scrollSheetOnLeave, nil, private.onResize)
	--Add tooltip help to the scrollframe headers	
	for i = 1, #frame.resultlist.sheet.labels do
		local self = frame.resultlist.sheet.labels[i].button
		local text = frame.resultlist.sheet.labels[i]:GetText()
		self:SetScript("OnEnter", function() private.buttonTooltips( self, text.."\nRightclick+Drag to resize\nCTRL+RightClick to reset") end)
		self:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

		
	--All the UI settings are stored here. We then split it to get the appropriate search settings
	function private.getCheckboxSettings()
		return {["selectbox"] = frame.SelectBoxSetting , ["exact"] = frame.exactCheck:GetChecked(), ["classic"] = frame.classicCheck:GetChecked(), 
			["bid"] = frame.bidCheck:GetChecked(), ["failedbid"] = frame.bidFailedCheck:GetChecked(), ["auction"] = frame.auctionCheck:GetChecked(),
			["failedauction"] = frame.auctionFailedCheck:GetChecked() 
			}
	end
		
	private.CreateMailFrames()

end

function private.CreateMailFrames()
	local frame = CreateFrame("Frame", "BeanCounterMail", MailFrame)
	frame:Hide()
	private.MailGUI = frame
	local count, total = 0,0
	
	frame:SetPoint("TOPLEFT", MailFrame, "TOPLEFT", 19,-71)
	frame:SetPoint("BOTTOMRIGHT", MailFrame, "BOTTOMRIGHT", -39,115)
	--Add Title to the Top
	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("CENTER", frame, "CENTER", 0,60)
	title:SetText("BeanCounter is recording your mail")
	
	local body = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	body:SetPoint("CENTER", frame, "CENTER", 0, 30)
	body:SetText("Please do not close the mail frame or")
	local body1 = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	body1:SetPoint("CENTER", frame, "CENTER", 0,0)
	body1:SetText("Auction Items will not be recorded")
		
	local countdown = frame:CreateFontString("BeanCounterMailCount", "OVERLAY", "GameFontNormalLarge")
	private.CountGUI = countdown
	countdown:SetPoint("CENTER", frame, "CENTER", 0, -60)
	countdown:SetText("Recording: "..count.." of "..total.." items")
end

--ONLOAD Error frame, used to show missmatched DB versus client errors that stop BC load NEEDS LOCALIZATION
function private.CreateErrorFrames(error, expectedVersion, playerVersion)
	frame = private.scriptframe
	frame.loadError = CreateFrame("Frame", nil, UIParent)
	frame.loadError:SetFrameStrata("HIGH")
	frame.loadError:SetBackdrop({
		bgFile = "Interface/Tooltips/ChatBubble-Background",
		edgeFile = "Interface/Tooltips/ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	})
	frame.loadError:SetBackdropColor(0,0,0, 1)
	frame.loadError:Show()

	frame.loadError:SetPoint("CENTER", UIParent, "CENTER")
	frame.loadError:SetWidth(300)
	frame.loadError:SetHeight(200)

	frame.loadError.close = CreateFrame("Button", nil, frame.loadError, "OptionsButtonTemplate")
	frame.loadError.close:SetPoint("BOTTOMRIGHT", frame.loadError, "BOTTOMRIGHT", -10, 10)
	frame.loadError.close:SetScript("OnClick", function() frame.loadError:Hide() end)
	frame.loadError.close:SetText("Ok")

	frame.loadError.text = frame.loadError:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.loadError.text:SetPoint("LEFT", frame.loadError, "LEFT", 25, 30)
	frame.loadError.text:SetWidth(250)
	if error == "bean older" then
		print ("Your database has been created with a newer version of BeanCounter than the one you are currently using. BeanCounter will not load to prevent possibly corrupting the saved data. Please go to http://auctioneeraddon.com and update to the latest version")
		frame.loadError.text:SetText("Your database has been created with a newer version of BeanCounter "..playerVersion.." than the one you are currently using. "..expectedVersion.." BeanCounter will not load to prevent possibly corrupting the saved data. Please go to http://auctioneeraddon.com and update to the latest version")
	elseif error == "failed update" then
		print ("Your database has failed to update. BeanCounter expects "..private.version.."BeanCounter will not load to prevent possibly corrupting the saved data. Please go to the forums at http://auctioneeraddon.com")
		frame.loadError.text:SetText("Your database has failed to update. BeanCounter expects "..expectedVersion.." But the player's version is still "..playerVersion.." BeanCounter will not load to prevent possibly corrupting the saved data. Please go to the forums at http://auctioneeraddon.com")
	else
		frame.loadError.text:SetText("Unknow Error on loading. BeanCounter will not load to prevent possibly corrupting the saved data. Please go to the forums at http://auctioneeraddon.com")
	end
	frame.loadError.title = frame.loadError:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	frame.loadError.title:SetPoint("CENTER", frame.loadError, "TOP", 0,-15)
	frame.loadError.title:SetText("|CFFFF0000 BEANCOUNTER WARNING")
end

--Taken from AucCore to make beancounter Standalone, Need to remove Redudundant stuff
function private.AddTab(tabButton, tabFrame)
	-- Count the number of auction house tabs (including the tab we are going
	-- to insert).
	local tabCount = 1;
	while (getglobal("AuctionFrameTab"..(tabCount))) do
		tabCount = tabCount + 1;
	end

	-- Find the correct location to insert our Search Auctions and Post Auctions
	-- tabs. We want to insert them at the end or before BeanCounter's
	-- Transactions tab.
	local tabIndex = 1;
	while (getglobal("AuctionFrameTab"..(tabIndex)) and
		   getglobal("AuctionFrameTab"..(tabIndex)):GetName() ~= "AuctionFrameTabTransactions") do
		tabIndex = tabIndex + 1;
	end

	-- Make room for the tab, if needed.
	for index = tabCount, tabIndex + 1, -1  do
		setglobal("AuctionFrameTab"..(index), getglobal("AuctionFrameTab"..(index - 1)));
		getglobal("AuctionFrameTab"..(index)):SetID(index);
	end

	-- Configure the frame.
	tabFrame:SetParent("AuctionFrame");
	tabFrame:SetPoint("TOPLEFT", "AuctionFrame", "TOPLEFT", 0, 0);
	private.relevelFrame(tabFrame);

	-- Configure the tab button.
	setglobal("AuctionFrameTab"..tabIndex, tabButton);
	tabButton:SetParent("AuctionFrame");
	tabButton:SetPoint("TOPLEFT", getglobal("AuctionFrameTab"..(tabIndex - 1)):GetName(), "TOPRIGHT", -8, 0);
	tabButton:SetID(tabIndex);
	tabButton:Show();

	-- Update the tab count.
	PanelTemplates_SetNumTabs(AuctionFrame, tabCount)
end

function private.relevelFrame(frame)
	return private.relevelFrames(frame:GetFrameLevel() + 2, frame:GetChildren())
end

function private.relevelFrames(myLevel, ...)
	for i = 1, select("#", ...) do
		local child = select(i, ...)
		child:SetFrameLevel(myLevel)
		private.relevelFrame(child)
	end
end
--Created SearchUI reason code data into tooltips
function private.processTooltip(_, _, _, _, itemLink, _, quantity, _, ...)
	if not itemLink then return end
	if not private.getOption("util.beancounter.displayReasonCodeTooltip") then return end
	
	local reason, Time, bid = lib.API.getBidReason(itemLink, quantity)
	debugPrint("Add to Tooltip", itemLink, reason)
	if not reason then return end
	if reason == "" then reason = "Unknown" end
	Time = SecondsToTime((time() - Time))
	
	EnhTooltip.AddLine( string.format("Last won for |CFFFFFFFF%s |CFFE59933{|CFFFFFFFF%s |CFFE59933 ago}", reason, Time ), tonumber(bid))
	EnhTooltip.LineColor(0.9,0.6,0.2)
end



