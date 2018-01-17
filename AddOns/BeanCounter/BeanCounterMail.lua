--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.0.0 (BillyGoat)
	Revision: $Id: BeanCounterMail.lua 3473 2008-09-11 20:19:38Z kandoko $
	URL: http://auctioneeraddon.com/
	
	BeanCounteMail - Handles recording of all auction house related mail 

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
    if private.getOption("util.beancounter.debugMail") then
        private.debugPrint("BeanCounterMail",...)
    end
end

local expiredLocale = AUCTION_EXPIRED_MAIL_SUBJECT:gsub("(.+)%%s", "%1") 
local salePendingLocale = AUCTION_INVOICE_MAIL_SUBJECT:gsub("(.+)%%s", "%1") --sale pending
local outbidLocale = AUCTION_OUTBID_MAIL_SUBJECT:gsub("(.+)%%s", "%1")
local cancelledLocale = AUCTION_REMOVED_MAIL_SUBJECT:gsub("(.+)%%s", "%1") 
local successLocale = AUCTION_SOLD_MAIL_SUBJECT:gsub("(.+)%%s", "%1") 
local wonLocale = AUCTION_WON_MAIL_SUBJECT:gsub("(.+)%%s", "%1") 

local registeredAltaholicHook = false
function private.mailMonitor(event,arg1)
	if (event == "MAIL_INBOX_UPDATE") then
		private.updateInboxStart()
	
	elseif (event == "MAIL_SHOW") then
		--Since Altoholic has an option to read mail this is a workaround for it. We call our read function before
		if Altoholic and not registeredAltaholicHook then
			registeredAltaholicHook = true
			Stubby.RegisterFunctionHook("Altoholic.UpdatePlayerMail", -10, private.updateInboxStart)
		end
		
		private.inboxStart = {} --clear the inbox list, if we errored out this should give us a fresh start.
		hooksecurefunc("InboxFrame_OnClick", private.mailFrameClick)
		hooksecurefunc("InboxFrame_Update", private.mailFrameUpdate)
		--We cannot use mail show since the GetInboxNumItems() returns 0 till the first "MAIL_INBOX_UPDATE"
	
	elseif (event == "MAIL_CLOSED") then
		InboxCloseButton:Show()
		InboxFrame:Show()
		MailFrameTab2:Show()
		private.MailGUI:Hide()
	end
end

--Mailbox Snapshots
local HideMailGUI
function private.updateInboxStart()
	for n = 1,GetInboxNumItems() do
		local _, _, sender, subject, money, _, daysLeft, _, wasRead, _, _, _ = GetInboxHeaderInfo(n)
		if sender and (sender:match(FACTION_ALLIANCE) or sender:match(FACTION_HORDE) or sender:find("Blackwater Auction House",1,true)) and subject and not wasRead then --record unread messages, so we know what indexes need to be added
			HideMailGUI = true
			wasRead = wasRead or 0 --its nil unless its has been read
			local itemLink = GetInboxItemLink(n, 1)
			local _, _, stack, _, _ = GetInboxItem(n)
			local invoiceType, itemName, playerName, bid, buyout, deposit, consignment, retrieved, startTime = private.getInvoice(n,sender, subject)
			table.insert(private.inboxStart, {["n"] = n, ["sender"]=sender, ["subject"]=subject,["money"]=money, ["read"]=wasRead, ["age"] = daysLeft, 
					["invoiceType"] = invoiceType, ["itemName"] = itemName, ["Seller/buyer"] = playerName, ['bid'] = bid, ["buyout"] = buyout, 
					["deposit"] = deposit, ["fee"] = consignment, ["retrieved"] = retrieved, ["startTime"] = startTime, ["itemLink"] = itemLink, ["stack"] = stack,
					})
			GetInboxText(n) --read message
		end
	end
	if HideMailGUI == true then
		InboxCloseButton:Hide()
		InboxFrame:Hide()
		MailFrameTab2:Hide()
		private.MailGUI:Show()
	end
	private.mailBoxColorStart()
end

function private.getInvoice(n, sender, subject)
	if sender:match(FACTION_ALLIANCE) or sender:match(FACTION_HORDE) or sender:find("Blackwater Auction House",1,true) then
		if subject:match(successLocale) or subject:match(wonLocale) then
			local invoiceType, itemName, playerName, bid, buyout, deposit, consignment = GetInboxInvoiceInfo(n)
			if  playerName and playerName ~= "" then
				--debugPrint("getInvoice", invoiceType, itemName, playerName, bid, buyout, deposit, consignment, "yes")
				return invoiceType, itemName, playerName, bid, buyout, deposit, consignment, "yes", time()
			else
				--debugPrint("getInvoice", invoiceType, itemName, playerName, bid, buyout, deposit, consignment, "no")
				return invoiceType, itemName, playerName, bid, buyout, deposit, consignment, "no", time()
			end
		end
	end
	return 
end

function private.mailonUpdate()
local count = 1
local total = #private.inboxStart
	for i, data in pairs(private.inboxStart) do
		--update mail GUI Count
		if count <= total then 
			private.CountGUI:SetText("Recording: "..count.." of "..total.." items")
			count = count + 1 
		end	
			
		local tbl = private.inboxStart[i]
		if not data.retrieved then --Send non invoiceable mails through
			table.insert(private.reconcilePending, data)
			private.inboxStart[i] = nil
			--debugPrint("not a invoice mail type")
		
		elseif  data.retrieved == "failed" then
			table.insert(private.reconcilePending, data)
			private.inboxStart[i] = nil
			--debugPrint("data.retrieved == failed")
		
		elseif  data.retrieved == "yes" then
			table.insert(private.reconcilePending, data)
			private.inboxStart[i] = nil
			--debugPrint("data.retrieved == yes")
		
		elseif  time() - data.startTime > private.getOption("util.beacounter.invoicetime") then --time exceded so fail it and process on next update
			debugPrint("time to retrieve invoice exceeded")
			tbl["retrieved"] = "failed" --time to get invoice exceded
		else 
			--debugPrint("Invoice retieve attempt",tbl["subject"])
			tbl["invoiceType"], tbl["itemName"], tbl["Seller/buyer"], tbl['bid'], tbl["buyout"] , tbl["deposit"] , tbl["fee"], tbl["retrieved"], _ = private.getInvoice(data.n, data.sender, data.subject)
		end
	end
	if (#private.inboxStart == 0) and (HideMailGUI == true) then
		InboxCloseButton:Show()
		InboxFrame:Show()
		MailFrameTab2:Show()
		private.MailGUI:Hide()
		HideMailGUI = false
		private.mailBoxColorStart() --delay recolor system till we have had a chance to read the mail
	end
	
	if (#private.reconcilePending > 0) then		
		private.mailSort()
	end
end

function private.mailSort()
	for i in pairs(private.reconcilePending) do
		--Get Age of message for timestamp 
		local messageAgeInSeconds = math.floor((30 - private.reconcilePending[i]["age"]) * 24 * 60 * 60)
		private.reconcilePending[i]["time"] = (time() - messageAgeInSeconds)
		
		if private.reconcilePending[i]["sender"]:match(FACTION_ALLIANCE) or private.reconcilePending[i]["sender"]:match(FACTION_HORDE) or private.reconcilePending[i]["sender"]:find("Blackwater Auction House",1,true) then
			if private.reconcilePending[i].subject:match(successLocale) and (private.reconcilePending[i].retrieved == "yes" or private.reconcilePending[i].retrieved == "failed") then
				private.sortCompletedAuctions( i )
				
			elseif private.reconcilePending[i].subject:match(expiredLocale)then
				private.sortFailedAuctions( i )
			
			elseif private.reconcilePending[i].subject:match(wonLocale) and (private.reconcilePending[i].retrieved == "yes" or private.reconcilePending[i].retrieved == "failed") then
				private.sortCompletedBidsBuyouts( i )
			
			elseif private.reconcilePending[i].subject:match(outbidLocale) then
				private.sortFailedBids( i )
			
			elseif private.reconcilePending[i].subject:match(cancelledLocale) then
				--Need to add a filter to remove/record canceled
				table.remove(private.reconcilePending,i)
			
			elseif private.reconcilePending[i].subject:match(salePendingLocale) then
				--ignore We dont care about this message
				table.remove(private.reconcilePending,i)
			else
				debugPrint("We had an Auction mail that failed mailsort()", private.reconcilePending[i].subject)
				table.remove(private.reconcilePending,i)	
			end	
		else --if its not AH do we care? We need to record cash arrival from other toons
			debugPrint("OTHER", private.reconcilePending[i].subject)
			table.remove(private.reconcilePending, i)
				
		end
	end
end
--retrieves the itemID from the DB
function private.matchDB(text)
	local itemID
	for i, itemLink in pairs(BeanCounterDB.ItemIDArray) do
		if itemLink:find("["..text.."]", 1, true) then 
			itemID = string.split(":", i)
			--debugPrint("Searching",key,"for",text,"Sucess: link is",itemLink)
			return itemID, itemLink
		end
	end
	debugPrint("Searching DB for ItemID..", key, text, "Failed Item does not exist in the name array")
	return nil
end

function private.sortCompletedAuctions( i )
	--Get itemID from database
	local itemName = private.reconcilePending[i].subject:match(successLocale.."(.*)")
	local itemID, itemLink = private.matchDB(itemName) 
	if itemID then  --Get the Bid and stack size if possible
		local stack, bid = private.findStackcompletedAuctions("postedAuctions", itemID, itemLink, private.reconcilePending[i].deposit, private.reconcilePending[i]["buyout"], private.reconcilePending[i]["time"])
		if stack then
			local value = private.packString(stack, private.reconcilePending[i]["money"], private.reconcilePending[i]["deposit"], private.reconcilePending[i]["fee"], private.reconcilePending[i]["buyout"], bid, private.reconcilePending[i]["Seller/buyer"], private.reconcilePending[i]["time"], "")
			private.databaseAdd("completedAuctions", itemID, itemLink, value)
			debugPrint("databaseAdd completedAuctions", itemID, itemLink)
		end
	end
	table.remove(private.reconcilePending, i)
end
--Find the stack information in postedAuctions to add into the completedAuctions DB on mail arrivial
function private.findStackcompletedAuctions(key, itemID, itemLink, soldDeposit, soldBuy, soldTime)
	if not private.playerData[key][itemID] then return end --if no keys present abort
	
	local soldDeposit, soldBuy, soldTime ,oldestPossible = tonumber(soldDeposit), tonumber(soldBuy), tonumber(soldTime), tonumber(soldTime - 173400) --48H 15min oldest we will go back
	--ItemLink will be used minus its unique ID
	local itemString --WOW 3.0 HACK
	if private.serverVersion >= 30000 then
		itemString = itemLink:match("^.*(item:.+):.-:.-")-- ignore Unique ID
		debugPrint("3.0 Hack find stacksize", itemString, itemlink)
	else
		itemString = itemLink:match("^.*(item:.+):.-") -- ignore Unique ID
	end
	
	for i,v in pairs (private.playerData[key][itemID]) do
		if i:match(itemString) or i == itemString then
			for index, text in pairs(v) do
				if not text:match(".*USED.*") then
					local tbl2 = private.unpackString(private.playerData[key][itemID][i][index])
					local postDeposit, postBuy, postTime = tonumber(tbl2[5]), tonumber(tbl2[3]),tonumber(tbl2[6])
					--if the deposits and buyouts match, check if time range would make this a possible match
					if postDeposit ==  soldDeposit and postBuy == soldBuy then
						if (soldTime > postTime) and (oldestPossible < postTime) then
							table.remove(private.playerData[key][itemID][i], index) --remove the matched item From postedAuctions DB
							--private.playerData[key][itemID][i][index] = private.playerData[key][itemID][i][index]..";USED Sold"
							debugPrint("postedAuction removed as sold", itemID, itemLink)
							return tonumber(tbl2[1]), tonumber(tbl2[2])
						end
					end
				end
			end
		end
	end
	--return 1 if the item is nonstackable and no match was found
	if private.getItemInfo(itemID, "stack") == 1 then return 1 end
end

function private.sortFailedAuctions( i )
	local itemID =  lib.API.decodeLink(private.reconcilePending[i]["itemLink"])
	if itemID then
		local stack, bid, buyout, deposit = private.findStackfailedAuctions("postedAuctions", itemID, private.reconcilePending[i]["itemLink"], private.reconcilePending[i]["stack"], private.reconcilePending[i]["time"])
		if stack then 
			local value = private.packString(stack, buyout, bid, deposit, private.reconcilePending[i]["time"], "")
			private.databaseAdd("failedAuctions", itemID, private.reconcilePending[i]["itemLink"], value)
			debugPrint("databaseAdd failedAuctions", itemID, private.reconcilePending[i]["itemLink"])
		end
	end
	table.remove(private.reconcilePending, i, private.reconcilePending[i]["itemLink"])
end
--find stack, bid and buy info for failedauctions
function private.findStackfailedAuctions(key, itemID, itemLink, returnedStack, expiredTime)
	if not private.playerData[key][itemID] then return end --if no keys present abort
	local itemString = lib.API.getItemString(itemLink) --use the UniqueID stored to match this 
 	for i,v in pairs (private.playerData[key][itemID]) do
		if i:match(itemString) or i == itemString then --we still stack check and data range check but match should be assured by now
 			for index, text in pairs(v) do
				if not text:match(".*USED.*") then
					local tbl2 = private.unpackString(private.playerData[key][itemID][i][index])
					if returnedStack == tonumber(tbl2[1]) then --stacks same see if we can match time
						local timeAuctionPosted, timeFailedAuctionStarted = tonumber(tbl2[6]), tonumber(expiredTime - (tbl2[4]*60)) --Time this message should have been posted
						if (timeAuctionPosted - 500) <= timeFailedAuctionStarted and timeFailedAuctionStarted <= (timeAuctionPosted + 800) then
							table.remove(private.playerData[key][itemID][i], index) --remove the matched item From postedAuctions DB
							--private.playerData[key][itemID][i][index] = private.playerData[key][itemID][i][index]..";USED Failed"
							debugPrint("postedAuction removed as Failed", itemID, itemLink )
							return tbl2[1], tbl2[2], tbl2[3], tbl2[5]
						end
					end
				end
 			end
		end
	end
end

 --No need to reconcile, all needed data has been provided in the invoice We do need to clear entries so outbid has less to wade through
function private.sortCompletedBidsBuyouts( i )
	local itemID = lib.API.decodeLink(private.reconcilePending[i]["itemLink"])
	local reason = private.findCompletedBids(itemID, private.reconcilePending[i]["Seller/buyer"], private.reconcilePending[i]["bid"], private.reconcilePending[i]["itemLink"])
	if itemID then
		--For a Won Auction money, deposit, fee are always 0  so we can use them as placeholders for BeanCounter Data
		local value = private.packString(private.reconcilePending[i]["stack"], private.reconcilePending[i]["money"], private.reconcilePending[i]["fee"], private.reconcilePending[i]["buyout"], private.reconcilePending[i]["bid"], private.reconcilePending[i]["Seller/buyer"], private.reconcilePending[i]["time"], reason)
		private.databaseAdd("completedBids/Buyouts", itemID, private.reconcilePending[i]["itemLink"], value)
		debugPrint("databaseAdd completedBids/Buyouts", itemID, private.reconcilePending[i]["itemLink"])
	end
	
	table.remove(private.reconcilePending,i)		
end
--Used only to clear postedBid entries so failed bids is less likely to miss
function private.findCompletedBids(itemID, seller, bid, itemLink)
	local buy, bid = tonumber(buy),tonumber(bid)
	local itemString = lib.API.getItemString(itemLink) --use the UniqueID stored to match this 	
	debugPrint("Starting search to remove posted Bid")
	if private.playerData["postedBids"][itemID] and private.playerData["postedBids"][itemID][itemString] then
		for index, text in pairs(private.playerData["postedBids"][itemID][itemString]) do
 			if not text:match(".*USED.*") then
				local tbl = private.unpackString(text)
				local stack, postBid, postSeller = tonumber(tbl[1]), tonumber(tbl[2]), tbl[3]
				--if seller ==  postSeller and postBid == bid then --Seller is mostly useless thanks to blizzards item name cahce chamges. Can often be nil  esp after a getall
				if postBid == bid then
					table.remove(private.playerData["postedBids"][itemID][itemString], index) --remove the matched item From postedBids DB
					--private.playerData["postedBids"][itemID][itemString][index] = private.playerData["postedBids"][itemID][itemString][index] ..";USED WON"
					debugPrint("posted Bid removed as Won", itemString, index, tbl[7])
					return tbl[7] --return the reason code provided for why we bid/bought item
				end
			end
		end
	end
end
function private.sortFailedBids( i )
	local itemName = private.reconcilePending[i].subject:match(outbidLocale.."(.*)") 
	local itemID, itemLink = private.matchDB(itemName)
	if itemID then
		local value = private.packString(private.reconcilePending[i]["money"], private.reconcilePending[i]["time"], "")
		private.databaseAdd("failedBids", itemID, itemLink, value)
		debugPrint("databaseAdd failedBids", itemID, itemLink, value)
	end
	private.findFailedBids(itemID, itemLink, private.reconcilePending[i]["money"])
	table.remove(private.reconcilePending,i)
end
function private.findFailedBids(itemID, itemLink, gold)
	gold = tonumber(gold)
	if not itemLink then debugPrint("Failed auction ItemStrig nil", itemID, itemLink) return end
	local itemString = lib.API.getItemString(itemLink) --use the UniqueID stored to match this 
	if private.playerData["postedBids"][itemID] and private.playerData["postedBids"][itemID][itemString] then
		for index, text in pairs(private.playerData["postedBids"][itemID][itemString]) do
 			if not text:match(".*USED.*") then
				local tbl = private.unpackString(text)
				local postBid = tonumber(tbl[2])
				if postBid == gold then
					table.remove(private.playerData["postedBids"][itemID][itemString], index) --remove the matched item From postedBids DB
					--private.playerData["postedBids"][itemID][itemString][index] = private.playerData["postedBids"][itemID][itemString][index] ..";USED FAILED"
					debugPrint("posted Bid removed as Failed", itemString, index)
					break
				end
			end
		end
	end

end
--Hook, take money event, if this still has an unretrieved invoice we delay X sec or invoice retrieved
local inboxHookMessage = false --Stops spam of the message.
function private.PreTakeInboxMoneyHook(funcArgs, retVal, index, ignore)
	if #private.inboxStart > 0 and not inboxHookMessage then
		print("Please allow BeanCounter time to reconcile the mail box")
		inboxHookMessage = true
		return "abort"
	end
end

--Hook, take item event, if this still has an unretrieved invoice we delay X sec or invoice retrieved
function private.PreTakeInboxItemHook( ignore, retVal, index)
	if #private.inboxStart > 0 and not inboxHookMessage then
		print("Please allow BeanCounter time to reconcile the mail box")
		inboxHookMessage = true
		return "abort"
	end
end

--[[
The below code manages the mailboxes Icon color /read/unread status

]]--
function private.mailFrameClick(index)
	if BeanCounterDB[private.realmName][private.playerName]["mailbox"][index] then
		BeanCounterDB[private.realmName][private.playerName]["mailbox"][index]["read"] = 2
	end
end

function private.mailFrameUpdate()
--Change Icon back color if only addon read
if not BeanCounterDB[private.realmName][private.playerName]["mailbox"] then return end  --we havn't read mail yet
if private.getOption("util.beancounter.mailrecolor") == "off" then return end

	local numItems = GetInboxNumItems()
	local  index
	if (InboxFrame.pageNum * 7) < numItems then
		index = 7
	else
		index = 7 - ((InboxFrame.pageNum * 7) - numItems)
	end
	for i = 1, index do
		local button = getglobal("MailItem"..i.."Button")
		local buttonIcon = getglobal("MailItem"..i.."ButtonIcon")
		local senderText = getglobal("MailItem"..i.."Sender")
		local subjectText = getglobal("MailItem"..i.."Subject")
		button:Show()
			
		local itemindex = ((InboxFrame.pageNum * 7) - 7 + i) --this gives us the actual itemindex as oposed to teh 1-7 button index
		local _, _, sender, subject, money, _, daysLeft, _, wasRead, _, _, _ = GetInboxHeaderInfo(itemindex)
		if BeanCounterDB[private.realmName][private.playerName]["mailbox"][itemindex] then
			local sender = BeanCounterDB[private.realmName][private.playerName]["mailbox"][itemindex]["sender"]
			if sender and (sender:match(FACTION_HORDE) or sender:match(FACTION_ALLIANCE) or sender:find("Blackwater Auction House",1,true)) then
				if (BeanCounterDB[private.realmName][private.playerName]["mailbox"][itemindex]["read"] < 2) then
					if private.getOption("util.beancounter.mailrecolor") == "icon" or private.getOption("util.beancounter.mailrecolor") == "both" then 
						getglobal("MailItem"..i.."ButtonSlot"):SetVertexColor(1.0, 0.82, 0)
						SetDesaturation(buttonIcon, nil)
					end
					if private.getOption("util.beancounter.mailrecolor") == "text" or private.getOption("util.beancounter.mailrecolor") == "both" then 
						senderText = getglobal("MailItem"..i.."Sender");senderText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
						subjectText:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
					end
				end
			end
		end
	end

end
--CHANGE THIS TO REVERSE ORDER
local mailCurrent
local group = {["n"] = "", ["start"] = 1, ["end"] = 1} --stores the start and end locations for a group of same name items
function private.mailBoxColorStart()
	mailCurrent = {} --clean table every update
	
	for n = 1,GetInboxNumItems() do
		local _, _, sender, subject, money, _, daysLeft, _, wasRead, _, _, _ = GetInboxHeaderInfo(n);
		mailCurrent[n] = {["time"] = daysLeft ,["sender"] = sender, ["subject"] = subject, ["read"] = wasRead or 0 }
	end
	
	--Fix reported errors of mail DB not existing for some reason.
	if not BeanCounterDB[private.realmName][private.playerName]["mailbox"] then BeanCounterDB[private.realmName][private.playerName]["mailbox"] = {} end 
	--Create Characters Mailbox, or resync if we get more that 5 mails out of tune
	if #BeanCounterDB[private.realmName][private.playerName]["mailbox"] > (#mailCurrent+2) or #BeanCounterDB[private.realmName][private.playerName]["mailbox"] == 0 then
		--debugPrint("Mail tables too far out of sync, resyncing #mailCurrent", #mailCurrent,"#mailData" ,#BeanCounterDB[private.realmName][private.playerName]["mailbox"])
		BeanCounterDB[private.realmName][private.playerName]["mailbox"] = {}
		for i, v in pairs(mailCurrent) do
			BeanCounterDB[private.realmName][private.playerName]["mailbox"][i] = v
		end
	end
	
	if #BeanCounterDB[private.realmName][private.playerName]["mailbox"] >= #mailCurrent then --mail removed or same
		for i in ipairs(mailCurrent) do 
			if BeanCounterDB[private.realmName][private.playerName]["mailbox"][i]["subject"] == group["n"] then
				if group["start"] then group["end"] = i else group["start"] = i end
			else
				group["n"], group["start"], group["end"] = BeanCounterDB[private.realmName][private.playerName]["mailbox"][i]["subject"], i, i
			end
			
			if mailCurrent[i]["subject"] ~= BeanCounterDB[private.realmName][private.playerName]["mailbox"][i]["subject"] then
				--debugPrint("group = ",group["n"], group["start"], group["end"])
				if BeanCounterDB[private.realmName][private.playerName]["mailbox"][i]["read"] == 2 then
					--debugPrint("This is marked read so removing ", i)
					table.remove(BeanCounterDB[private.realmName][private.playerName]["mailbox"], i)
					break
				elseif BeanCounterDB[private.realmName][private.playerName]["mailbox"][i]["read"] < 2 then
	--This message has not been read, so we have a sequence of messages with the same name. Need to go back recursivly till we find the "Real read" message that need removal
					for V = group["end"], group["start"], -1 do
						if BeanCounterDB[private.realmName][private.playerName]["mailbox"][V]["read"] == 2 then
							--debugPrint("recursive read group",group["end"] ,"--",group["start"], "found read at",V )
							table.remove(BeanCounterDB[private.realmName][private.playerName]["mailbox"], V)
							break
						end
					end
				end
				break
			end
		end
	elseif #BeanCounterDB[private.realmName][private.playerName]["mailbox"] < #mailCurrent then --mail added
		for i,v in ipairs(mailCurrent) do
			if BeanCounterDB[private.realmName][private.playerName]["mailbox"][i] then
				if mailCurrent[i]["subject"] ~=  BeanCounterDB[private.realmName][private.playerName]["mailbox"][i]["subject"] then
					--debugPrint("#private.mailData < #mailCurrent adding", i, mailCurrent[i]["subject"])
					table.insert(BeanCounterDB[private.realmName][private.playerName]["mailbox"], i, v)
				end
			else
			--debugPrint("need to add key ", i)
				table.insert(BeanCounterDB[private.realmName][private.playerName]["mailbox"], i, v)
			end
		end
		
	end	
	private.mailFrameUpdate()
	private.hasUnreadMail()
end

function private.hasUnreadMail()
	--[[if HasNewMail() then MiniMapMailFrame:Show() debugPrint("We have real unread mail, mail icon show/hide code bypassed") return end  --no need to process if we have real unread messages waiting
	if not private.getOption("util.beancounter.mailrecolor") then MiniMapMailFrame:Hide() return end --no need to do this if user isn't using recolor system, and mail icon should not show since HasnewMail() failed

	local mailunread = false
	for i,v in pairs(BeanCounterDB[private.realmName][private.playerName]["mailbox"]) do
		if BeanCounterDB[private.realmName][private.playerName]["mailbox"][i]["read"] < 2 then
		    mailunread = true
		end
	end
	if mailunread then
		lib.SetSetting("util.beancounter.hasUnreadMail", true)
		MiniMapMailFrame:Show()
	else
		lib.SetSetting("util.beancounter.hasUnreadMail", false)
		MiniMapMailFrame:Hide()
	end]]
end
