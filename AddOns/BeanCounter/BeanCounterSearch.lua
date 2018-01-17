--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.0.0 (BillyGoat)
	Revision: $Id: BeanCounterSearch.lua 3473 2008-09-11 20:19:38Z kandoko $

	BeanCounterSearch - Search routines for BeanCounter data
	URL: http://auctioneeraddon.com/
	
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
lib.API = {}

local private = lib.Private
local print =  BeanCounter.Print
local _BC = private.localizations

local function debugPrint(...) 
    if private.getOption("util.beancounter.debugSearch") then
        private.debugPrint("BeanCounterSearch",...)
    end
end


local data = {}
local style = {}
local temp ={}
local tbl = {}
print("SearchLOADED")
--This is all handled by ITEMIDS need to remove/rename this to be a utility to convert text searches to itemID searches
function private.startSearch(itemName, settings, queryReturn, count, itemTexture) --queryReturn is passed by the externalsearch routine, when an addon wants to see what data BeanCounter knows
	--Run the compression function once per session, use first search as trigger
	--Check the postedDB tables and remove any entries that are older than 31 Days
	if not private.compressed then private.refreshItemIDArray() private.sortArrayByDate() private.compactDB() private.prunePostedDB()  private.compressed = true end
	
	if not itemName then return end
	if not settings then settings = private.getCheckboxSettings() end
	
	tbl = {}
	for itemKey, itemLink in pairs(BeanCounterDB["ItemIDArray"]) do
		if itemLink:lower():find(itemName:lower(), 1, true)  then
			if settings.exact and private.frame.searchBox:GetText() ~= "" then --if the search field is blank do not exact check
				local _, name = lib.API.getItemString(itemLink) or nil, "failed name"
				if itemName:lower() == name:lower() then
					local itemID, suffix = string.split(":", itemKey)--Create a list of itemIDs that match the search text
					settings.suffix = suffix -- Store Suffix used to later filter unwated results from the itemID search
					tbl[itemID] = itemID --Since its possible to have the same itemID returned multiple times this will only allow one instance to be recorded
					break
				end
			else
				local itemID = string.split(":", itemKey)--Create a list of itemIDs that match the search text
				tbl[itemID] = itemID --Since its possible to have the same itemID returned multiple times this will only allow one instance to be recorded
			end
		end
	end
	
	if queryReturn then --need to return the ItemID results to calling function
		return(private.searchByItemID(tbl, settings, queryReturn, count, itemTexture, itemName))
	else
		--get the itemTexture for display in the drop box
		for i, itemLink in pairs(BeanCounterDB.ItemIDArray) do
			if itemLink:lower():find("["..itemName:lower().."]", 1, true) then
				itemTexture = select(2, private.getItemInfo(itemLink, "name"))
				break
			end
		end
		private.searchByItemID(tbl, settings, queryReturn, count, itemTexture, itemName)
	end
end

function private.searchByItemID(id, settings, queryReturn, count, itemTexture, classic)

	if not id then return end
	if not settings then settings = private.getCheckboxSettings() end
	if not count then count = 500 end --count determines how many results we show or display High # ~to display all

	tbl = {}
	if type(id) == "table" then --we can search for a sinlge itemID or an array of itemIDs
		for i,v in pairs(id)do
			table.insert(tbl, tostring(v))
		end
	else
		tbl[1] = tostring(id)
	end

	data = {}
	style = {}
	data.temp = {}
	data.temp.completedAuctions = {}
	data.temp["completedBids/Buyouts"] = {}
	data.temp.failedAuctions = {}
	data.temp.failedBids = {}
	
	--debugPrint(id, settings, queryReturn, count, itemTexture)
	
	--Retrives all matching results
	for i in pairs(private.serverData) do
		if settings.selectbox[2] == "alliance" and private.serverData[i]["faction"] and private.serverData[i]["faction"]:lower() ~= settings.selectbox[2] then
			--If looking for alliance and player is not alliance fall into this null
		elseif settings.selectbox[2] == "horde" and private.serverData[i]["faction"] and private.serverData[i]["faction"]:lower() ~= settings.selectbox[2] then
			--If looking for horde and player is not horde fall into this null
		elseif (settings.selectbox[2] ~= "server" and settings.selectbox[2] ~= "alliance" and settings.selectbox[2] ~= "horde") and i ~= settings.selectbox[2] then
			--If we are not doing a whole server search and the chosen search player is not "i" then we fall into this null
			--otherwise we search the server or toon as normal
		else
			for _, id in pairs(tbl) do
				if settings.auction and private.serverData[i]["completedAuctions"][id] then
					for index, itemKey in pairs(private.serverData[i]["completedAuctions"][id]) do
						for _, text in ipairs(itemKey) do
							table.insert(data.temp.completedAuctions, {i, id, index,text})
						end
					end
				end
				if settings.failedauction and private.serverData[i]["failedAuctions"][id] then
					for index, itemKey in pairs(private.serverData[i]["failedAuctions"][id]) do
						for _, text in ipairs(itemKey) do
							table.insert(data.temp["failedAuctions"], {i, id, index,text})
						end
					end
				end
				if settings.bid and private.serverData[i]["completedBids/Buyouts"][id] then
					for index, itemKey in pairs(private.serverData[i]["completedBids/Buyouts"][id]) do
						for _, text in ipairs(itemKey) do
							table.insert(data.temp["completedBids/Buyouts"], {i, id, index,text})
						end
					end
				end
				if settings.failedbid and private.serverData[i]["failedBids"][id] then
					for index, itemKey in pairs(private.serverData[i]["failedBids"][id]) do
						for _, text in ipairs(itemKey) do
							table.insert(data.temp.failedBids, {i, id, index,text})
						end
						
					end
				end
			end
		end
	end
	--reduce results to the latest XXXX ammount based on how many user wants returned or displayed
	if #data.temp.completedAuctions > count then
		data.temp.completedAuctions = private.reduceSize(data.temp.completedAuctions, count)
	end
	if #data.temp.failedAuctions > count then
		data.temp.failedAuctions = private.reduceSize(data.temp.failedAuctions, count)
	end
	if #data.temp["completedBids/Buyouts"] > count then
		data.temp["completedBids/Buyouts"] = private.reduceSize(data.temp["completedBids/Buyouts"], count)
	end
	if #data.temp.failedBids > count then
		data.temp.failedBids = private.reduceSize(data.temp.failedBids, count)
	end
	
	--Return Data as raw if requesting addon wants un-formated data --FAST
	if queryReturn == "none" then
		for i,v in pairs(data.temp)do
			for a,b in pairs(v)do
				b[5] = b[4]:match(".*;(.-);") --Makes the time stamp more accesable so addon can sort easier
			end
		end
		return data.temp
	end
	--Format Data for display via scroll private.frame or if requesting addon wants formated data  --SLOW
	local dateString = private.getOption("dateString") or "%c"
	for i,v in pairs(data.temp.completedAuctions) do
		local match = true
		--to provide exact match filtering for of the tems we compare names to the itemKey on API searches
		if settings.exact and settings.suffix then
			if v[3]:match(".*:("..settings.suffix.."):.-") then
				-- do nothing and add item to data table
			else
				match = false --we want exact matches and this is not one
			end
		end
		
		if match then
			table.insert(data, private.COMPLETEDAUCTIONS(v[2], v[3], v[4], settings))
			if not queryReturn then --do not create style tables if this data is being returned to an addon
				style[#data] = {}
				style[#data][12] = {["date"] = dateString}
				style[#data][2] = {["textColor"] = {0.3, 0.9, 0.8}}
				style[#data][8] ={["textColor"] = {0.3, 0.9, 0.8}}
			end
		end
	end
	for i,v in pairs(data.temp.failedAuctions) do
		local match = true
		--to provide exact match filtering for of the tems we compare names to the itemKey on API searches
		if settings.exact and settings.suffix then
			if v[3]:match(".*:("..settings.suffix.."):.-") then
				-- do nothing and add item to data table
			else
				match = false --we want exact matches and this is not one
			end
		end
		
		if match then
			table.insert(data, private.FAILEDAUCTIONS(v[2], v[3], v[4]))
			if not queryReturn then
				style[#data] = {}
				style[#data][12] = {["date"] = dateString}
				style[#data][2] = {["textColor"] = {1,0,0}}
				style[#data][8] ={["textColor"] = {1,0,0}}
			end
		end
	end
	for i,v in pairs(data.temp["completedBids/Buyouts"]) do
		local match = true
		--to provide exact match filtering for of the tems we compare names to the itemKey on API searches
		if settings.exact and settings.suffix then
			if v[3]:match(".*:("..settings.suffix.."):.-") then
				-- do nothing and add item to data table
			else
				match = false --we want exact matches and this is not one
			end
		end
		
		if match then
			table.insert(data, private.COMPLETEDBIDSBUYOUTS(v[2], v[3], v[4]))
			if not queryReturn then
				style[#data] = {}
				style[#data][12] = {["date"] = dateString}
				style[#data][2] = {["textColor"] = {1,1,0}}
				style[#data][8] ={["textColor"] = {1,1,0}}
			end
		end
	end
	for i,v in pairs(data.temp.failedBids) do
		local match = true
		--to provide exact match filtering for of the tems we compare names to the itemKey on API searches
		if settings.exact and settings.suffix then
			if v[3]:match(".*:("..settings.suffix.."):.-") then
				-- do nothing and add item to data table
			else
				match = false --we want exact matches and this is not one
			end
		end
		
		if match then
			table.insert(data, private.FAILEDBIDS(v[2], v[3], v[4]))
			if not queryReturn then
				style[#data] = {}
				style[#data][12] = {["date"] = dateString}
				style[#data][2] = {["textColor"] = {1,1,1}}
				style[#data][8] ={["textColor"] = {1,1,1}}
			end
		end
	end
	
	--BC CLASSIC DATA SEARCH Only usable when a plain text search is used
	if settings.classic and classic and not tonumber(classic)then
		data, style = private.classicSearch(data, style, classic, settings, dateString)
	end
	if not queryReturn then --this lets us know it was not an external addon asking for beancounter data
		if itemTexture then 
			private.frame.icon:SetNormalTexture(itemTexture)
		else
			private.frame.icon:SetNormalTexture(nil)
		end		
		private.frame.resultlist.sheet:SetData(data, style) --Set the GUI scrollsheet
		private.frame.resultlist.sheet:ButtonClick(12, "click") --This tells the scroll sheet to sort by column 11 (time)
		private.frame.resultlist.sheet:ButtonClick(12, "click") --and fired again puts us most recent to oldest
		
		--If the user has scrolled to far and search is not showing scroll back to starting position
		if  not private.frame.resultlist.sheet.rows[1][1]:IsShown() then
			private.frame.resultlist.sheet.panel:ScrollToCoords(0,0)
		end
	else --If Query return is true but not == to "none" then we return a formated table
		return(data)
	end
end
function private.reduceSize(tbl, count)
	--The data provided is from multiple toons tables, so we need to resort the merged data back into sequential time order
	table.sort(tbl, function(a,b) return a[4]:match(".*;(%d+);.-") > b[4]:match(".*;(%d+);.-") end)
	tbl.sort = {}
	for i = 1, count do
		table.insert(tbl.sort, tbl[i])
	end
	return tbl.sort
end

--To simplify having two seperate search routines, the Data creation of each table has been made a local function
	function private.COMPLETEDAUCTIONS(id, itemKey, text) --this passes the player, itemID and text as string or as an already seperated table
			tbl = text
			if type(text) == "string" then tbl = private.unpackString(text) end
		
			local pricePer = 0
			local stack = tonumber(tbl[1]) or 0
			if stack > 0 then pricePer =  (tbl[2]-tbl[3]+tbl[4])/stack end
							
			local itemID, suffix = lib.API.decodeLink(itemKey)
			local itemLink =  BeanCounterDB["ItemIDArray"][itemID..":"..suffix]
			
			if not itemLink then itemLink = private.getItemInfo(id, "name") end--if not in our DB ask the server
			
			return({
				itemLink or "Failed to get Link", --itemname
				_BC('UiAucSuccessful'), --status
				 
				tonumber(tbl[6]) or 0,  --bid
				tonumber(tbl[5]) or 0,  --buyout
				tonumber(tbl[2]), --Profit,
				tonumber(stack),  --stacksize
				tonumber(pricePer), --Profit/per

				tbl[7],  --seller/seller

				tonumber(tbl[3]), --deposit
				tonumber(tbl[4]), --fee
				tbl[9], --current wealth
				tbl[8], --time, --Make this a user choosable option.
			})
	end
	--STACK; BUY; BID; DEPOSIT; TIME; DATE; WEALTH
	function private.FAILEDAUCTIONS(id, itemKey, text)
			tbl = text
			if type(text) == "string" then tbl = private.unpackString(text) end
			
			local itemID, suffix = lib.API.decodeLink(itemKey)
			local itemLink =  BeanCounterDB["ItemIDArray"][itemID..":"..suffix]

			if not itemLink then itemLink = private.getItemInfo(id, "name") end--if not in our DB ask the server
			
			return({
				itemLink, --itemname
				_BC('UiAucExpired'), --status

				tonumber(tbl[3]) or 0, --bid
				tonumber(tbl[2]) or 0, --buyout
				0, --money,
				tonumber(tbl[1]) or 0,
				0, --Profit/per

				"...",  --seller/buyer

				tonumber(tbl[4]) or 0, --deposit
				0, --fee
				tbl[6], --current wealth
				tbl[5], --time,
			})
	end
	function private.COMPLETEDBIDSBUYOUTS(id, itemKey, text)
			tbl = text
			if type(text) == "string" then tbl= private.unpackString(text) end
			
			local pricePer, stack, text = 0, tonumber(tbl[1]), _BC('UiWononBuyout')
			--If the auction was won on bid change text, and adjust ProfitPer
			if tbl[5] ~= tbl[4] then	
				text = _BC('UiWononBid') 
				if stack > 0 then	pricePer = (tbl[5]-tbl[2]+tbl[3])/stack end
			else --Devide by BUY price if it was won on Buy
				if stack > 0 then	pricePer = (tbl[4]-tbl[2]+tbl[3])/stack end
			end
			
			local itemID, suffix = lib.API.decodeLink(itemKey)
			local itemLink =  BeanCounterDB["ItemIDArray"][itemID..":"..suffix]

			if not itemLink then itemLink = private.getItemInfo(id, "name") end--if not in our DB ask the server
			
			return({
				itemLink, --itemname
				text, --status

				tonumber(tbl[5]), --bid
				tonumber(tbl[4]), --buyout
				tonumber(0), --money,
				tonumber(stack),  --stacksize
				pricePer, --Profit/per

				tbl[6],   --seller/buyer

				tonumber(tbl[2]), --deposit
				tonumber(tbl[3]), --fee
				tbl[8], --current wealth
				tbl[7], --time,
			})
	end
	function private.FAILEDBIDS(id, itemKey, text)
			tbl = text
			if type(text) == "string" then tbl= private.unpackString(text) end

			local itemID, suffix = lib.API.decodeLink(itemKey)
			local itemLink =  BeanCounterDB["ItemIDArray"][itemID..":"..suffix]

			if not itemLink then itemLink = private.getItemInfo(id, "name") end--if not in our DB ask the server
			return({
				itemLink, --itemname
				_BC('UiOutbid'), --status

				tonumber(tbl[1]), --bid
				0, --buyout
				0, --money,
				0, --stack
				0, --Profit/per

				"-",  --seller/buyer

				0, --deposit
				0, --fee
				tbl[3], --current wealth
				tbl[2], --time,
			})
	end
	
	

--[[ BeanCounter Classic Search routine ]]--
--Only used by classic search now	
function private.fragmentsearch(compare, itemName, exact, classic)
	if exact and private.frame.searchBox:GetText() ~= "" then 
		if compare:lower() == itemName:lower() then return true end --If we are searching older classic data 
	else
		local match = (compare:lower():find(itemName:lower(), 1, true) ~= nil)
		return match
	end
end
--Search BeancounterClassic Data
function private.classicSearch(data, style, itemName, settings, dateString)
	if settings.auction or settings.failedauction then
		for name, v in pairs(BeanCounterAccountDB[private.realmName]["sales"]) do
			for index, text in pairs(v) do

				tbl= {strsplit(";", text)}
				local match = false
				match = private.fragmentsearch(name, itemName, settings.exact, "classic")
				if match then
					--    1    2        3         4       5          6          7           8        9       10
					--"time;saleResult;quantity;bid;buyout;netPrice;price;isBuyout;buyerName;sellerId"
					--"1173571623;1;1;11293;22000;-1500;<nil>;<nil>;<nil>;2"
					--tbl[2]  0 = sold 1 exp 3 = CANCELED
					local status = _BC('UiAucSuccessful').." CL"

					if tbl[2] == "1" then
						if not settings.failedauction then break end --used to filter Exp auc 
						status = _BC('UiAucExpired').." CL"
						tbl[9] = "-"
					else   
						if not settings.auction then break end --used to filter comp auc if user only wants expend
					end
					
					local stack = tonumber(tbl[3]) or 1
					local price = tonumber(tbl[6]) or 0
					if stack < 1 then    stack = 1 end
					local pricePer = (price/stack)

					table.insert(data,{
							name, --itemname
							status, --status

							tonumber(tbl[4]) or 0,  --bid
							tonumber(tbl[5]) or 0, --buyout
							price, --money,
							tonumber(stack),  --stacksize
							pricePer, --Profit/per

							tbl[9],  --seller/buyer

							0, --deposit
							0,  --fee
							0, --current wealth
							tbl[1], --time,
							})   
							
					style[#data] = {}
					style[#data][12] = {["date"] = dateString}
					if status == _BC('UiAucSuccessful').." CL" then
						style[#data][2] = {["textColor"] = {0.3, 0.9, 0.8}}
						style[#data][8] ={["textColor"] = {0.3, 0.9, 0.8}}
					else
						style[#data][2] = {["textColor"] = {1,0,0}}
						style[#data][8] ={["textColor"] = {1,0,0}}
					end

				end
			end
		end
	end
	
	if settings.bid then
		for name, v in pairs(BeanCounterAccountDB[private.realmName]["purchases"]) do
			for index, text in pairs(v) do
				tbl= {strsplit(";", text)}
				local match = false
				match = private.fragmentsearch(name, itemName, settings.exact, "classic")
				if match then
					--    1                 2        3         4       5          6          7           8        9       10
					--time; quantity;value;seller;isBuyout;buyerId
					--"1178840165;1;980000;Eruder;1;5",
					local bid, buyout, status = 0,0,"Invalid data"
					if tbl[5] == "1" then --is bid
						status = _BC('UiWononBuyout').." CL"
						buyout = tbl[3]
						bid = 0
					else
						status = _BC('UiWononBid').." CL"
						buyout = 0
						bid = tbl[3]
					end

					table.insert(data,{
							name, --itemname
							status, --status

							tonumber(bid),  --bid
							tonumber(buyout), --buyout
							0, --money,
							tonumber(tbl[2]),  --stacksize,
							tonumber(tbl[3]) / tonumber(tbl[2]) or 1, --Profit/per

							tbl[4],  --seller/buyer

							0,--deposit
							0, --fee
							0, --current wealth
							tbl[1], --time,
							})
					style[#data] = {}
					style[#data][12] = {["date"] = dateString}	
					style[#data][2] = {["textColor"] = {1,1,0}}
					style[#data][8] ={["textColor"] = {1,1,0}}
				end
			end
		end
	end
	return data, style
end