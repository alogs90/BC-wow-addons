--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 5.0.0 (BillyGoat)
	Revision: $Id: PostMonitor.lua 3243 2008-07-19 21:03:12Z kandoko $
	URL: http://auctioneeraddon.com/
	
	PostMonitor - Records items posted up for auction

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
--[[Most of this code is from BC classic]]--
local libName = "BeanCounter"
local libType = "Util"
local lib = BeanCounter
local private = lib.Private
local print =  BeanCounter.Print

local function debugPrint(...)
    if private.getOption("util.beancounter.debugPost") then
        private.debugPrint("PostMonitor",...)
    end
end

-------------------------------------------------------------------------------
-- Called before StartAuction()
-------------------------------------------------------------------------------
function private.preStartAuctionHook(_, _, minBid, buyoutPrice, runTime)
	debugPrint("Prehook",minBid, buyoutPrice, runTime, GetCursorInfo(), "Info?")
	local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo()
	if (name and count and price) then
		local deposit = CalculateAuctionDeposit(runTime)
		private.addPendingPost(name, count, minBid, buyoutPrice, runTime, deposit)
	end
end

-------------------------------------------------------------------------------
-- Adds a pending post to the queue.
-------------------------------------------------------------------------------
function private.addPendingPost(name, count, minBid, buyoutPrice, runTime, deposit)
	-- Add a pending post to the queue.
	local pendingPost = {}
	pendingPost.name = name
	pendingPost.count = count
	pendingPost.minBid = minBid
	pendingPost.buyoutPrice = buyoutPrice
	pendingPost.runTime = runTime
	pendingPost.deposit = deposit
	table.insert(private.PendingPosts, pendingPost)
	--debugPrint("private.addPendingPost() - Added pending post")
	
	-- Register for the response events if this is the first pending post.
	if (#private.PendingPosts == 1) then
		--debugPrint("private.addPendingPost() - Registering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE")
		Stubby.RegisterFunctionHook("AuctionFrameAuctions_Update", 10, private.onAuctionCreated)
				
		Stubby.RegisterEventHook("UI_ERROR_MESSAGE", "BeanCounter_PostMonitor", private.onEventHookPosting)
	end
end

-------------------------------------------------------------------------------
-- Removes the pending post from the queue.
-------------------------------------------------------------------------------
function private.removePendingPost()
	if (#private.PendingPosts > 0) then
		-- Remove the first pending post.
		local post = private.PendingPosts[1]
		table.remove(private.PendingPosts, 1)
		--debugPrint("private.removePendingPost() - Removed pending post")

		-- Unregister for the response events if this is the last pending post.
		if (#private.PendingPosts == 0) then
			--debugPrint("private.removePendingPost() - Unregistering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE")
			Stubby.UnregisterFunctionHook("AuctionFrameAuctions_Update", private.onAuctionCreated)
			
			Stubby.UnregisterEventHook("UI_ERROR_MESSAGE", "BeanCounter_PostMonitor", private.onEventHookPosting)
		end

		return post
	end
	
	-- No pending post to remove!
	return nil
end

-------------------------------------------------------------------------------
-- OnEvent handler Auctions. these are unhooked when not needed
-------------------------------------------------------------------------------
function private.onEventHookPosting(_, event, arg1)
	if (event == "UI_ERROR_MESSAGE" and arg1) then
		debugPrint(event)
		if (arg1) then debugPrint("    "..arg1) end
		if (arg1 == ERR_NOT_ENOUGH_MONEY) then
			private.onPostFailed()
		end
	end
end

-------------------------------------------------------------------------------
-- Called when a post is accepted by the server.
-------------------------------------------------------------------------------
function private.onAuctionCreated()
	local post = private.removePendingPost()
	if (post) then
		-- Add to sales database
		local itemID, itemLink = private.getItemInfo(post.name, "itemid") --"of the" items are not handled well by this 
		--debugPrint("first itemlink lookup", itemLink)
		local Count = GetNumAuctionItems("owner")
		Count = Count + 1
		for i = Count, 1, -1 do
			if post.name == GetAuctionItemInfo("owner",i) then
				itemLink = GetAuctionItemLink("owner",i) or itemLink--so we try and replace with a better itemlink
				--debugPrint("second itemlink lookup", itemLink)
				break
			end
		end 
		local text = private.packString(post.count, post.minBid, post.buyoutPrice, post.runTime, post.deposit, time(),"")
		private.databaseAdd("postedAuctions", itemID, itemLink, text)
		debugPrint("Added", itemLink, "to the postedAuctions DB", post.minBid, post.buyoutPrice)
		--debugPrint(post.count, post.minBid, post.buyoutPrice, post.runTime, post.deposit, time(),"")
	end
end

-------------------------------------------------------------------------------
-- Called when a post is rejected by the server.
-------------------------------------------------------------------------------
function private.onPostFailed()
	private.removePendingPost()
end

