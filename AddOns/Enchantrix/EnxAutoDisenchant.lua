--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.0.0 (BillyGoat)
	Revision: $Id: EnxAutoDisenchant.lua 3502 2008-09-17 18:03:11Z root $
	URL: http://enchantrix.org/

	Automatic disenchant scanner.

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
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/RC_5.0/Enchantrix/EnxAutoDisenchant.lua $", "$Rev: 3502 $")

local ignoreList = {}
local frame
local prompt

local setState
local beginScan
local showPrompt
local hidePrompt
local clearPrompt

--------------------------------------------------------------------------------
-- Debug stuff

local DebugLib = LibStub("DebugLib")
local debug, assert
if DebugLib then
	debug, assert = DebugLib("Enchantrix")
else
	function debug() end
	assert = debug
end

local function debugSpam(...)
--	local message = debug:Dump(...)
--	local r, g, b = 0, 0.75, 1
--	getglobal("ChatFrame1"):AddMessage("AutoDe: " .. message, r, g, b)
end

local function eventSpam(...)
--	local message = debug:Dump(...)
--	debugSpam("Event: " .. message)
end

--------------------------------------------------------------------------------
-- Item ignore list and utility functions

local function itemStringFromLink(link)
	local _, _, itemString = string.find(link, "^|c%x+|H(.+)|h%[.+%]")
	return itemString
end

local function genericizeItemLink(link)
	-- strip out unique id
	local _, _, head, tail = string.find(link, "^(|c%x+|H.+:)[-%d]+(|h.+)")
	return head .. "0" .. tail
end

local function ignoreItemPermanent(link)
	local genericLink = genericizeItemLink(link)
	Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeIgnorePermanent"):format(genericLink))
	AutoDisenchantIgnoreList[genericLink] = true
end

local function ignoreItemSession(link, silent)
	local genericLink = genericizeItemLink(link)
	if not silent then
		Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeIgnoreSession"):format(genericLink))
	end
	ignoreList[genericLink] = true
end

local function isItemIgnored(link)
	local genericLink = genericizeItemLink(link)
	return ignoreList[genericLink] or AutoDisenchantIgnoreList[genericLink]
end

local function nameFromIgnoreListItem(item)
	local _, _, name = string.find(item, "%[(.+)%]")
	return name
end

--------------------------------------------------------------------------------
-- Main logic

local moduleState
function setState(newState)
	if newState ~= state then
		debugSpam("State: " .. newState)
		moduleState = newState
	end
end

function isState(state)
	return moduleState == state
end

local function getDisenchantOrProspectValue(link, count)
	local _, _, quality, level = GetItemInfo(link)
	if not (quality and level) then return end
	if quality >= 2 then
		local enchSkillRequired = Enchantrix.Util.DisenchantSkillRequiredForItemLevel(level, quality)
		if enchSkillRequired and Enchantrix.Util.GetUserEnchantingSkill() >= enchSkillRequired then
			local hsp, median, baseline, valFive = Enchantrix.Storage.GetItemDisenchantTotals(link)
			if (not hsp) or (hsp == 0) then
				-- what to do when Auc4 isn't loaded, but Auc5 is
				-- or when you have no data for mat prices
				if valFive and valFive > 0 then
					hsp = valFive
				else
					hsp = baseline
				end
			end
			if hsp and hsp > 0 then
				return hsp, _ENCH('ArgSpellname')
			end
		end
	elseif count >= 5 then
		local jcSkillRequired = Enchantrix.Util.JewelCraftSkillRequiredForItem(link)
		if jcSkillRequired and Enchantrix.Util.GetUserJewelCraftingSkill() >= jcSkillRequired then
			local prospect = Enchantrix.Storage.GetItemProspects(link)
			if prospect then
				local prospectValue = 0
				for result, yield in pairs(prospect) do
					local hsp, median, baseline, valFive = Enchantrix.Util.GetReagentPrice(result)
					if (not hsp) or (hsp == 0) then
						-- what to do when Auc4 isn't loaded, but Auc5 is
						-- or when you have no data for mat prices
						if valFive and valFive > 0 then
							hsp = valFive
						else
							hsp = baseline
						end
					end
					local value = (hsp or 0) * yield
					prospectValue = prospectValue + value
				end
				return prospectValue, _ENCH('ArgSpellProspectingName')
			end
		end
	end
end


-- check one bag (to save time when we know something moved in just this bag)
local function findItemInOneBag(bag, findLink)
   		for slot = 1, GetContainerNumSlots(bag) do
			local _, count = GetContainerItemInfo(bag, slot)
	    	local link = GetContainerItemLink(bag, slot)
			if link and (not findLink or link == findLink) then
				if not findLink and link == prompt.link and bag == prompt.bag
					and slot == prompt.slot and count == prompt.count then
					-- items sometimes linger after they've been disenchanted and looted
					debugSpam("Skipping zombie item " .. link)
				else
					if not isItemIgnored(link) then
						local value, spell = getDisenchantOrProspectValue(link, count)
						if value and value > 0 then
							return link, bag, slot, value, spell
						end
					end
				end
			end
		end
	end


-- check all bags for disenchantable items
local function findItemInBags(findLink)
	debugSpam("scanning bags")
	for bag = 0, 4 do
		local link, bag, slot, value, spell = findItemInOneBag(bag, findLink)
		if (spell) then
			return link, bag, slot, value, spell
		end
	end
end


function beginScan(bag)
	setState("scan")
	local link, outBag, slot, value, spell
	if (bag) then
		link, outBag, slot, value, spell = findItemInOneBag(bag)
	else
		link, outBag, slot, value, spell = findItemInBags()
	end
	if link then
		-- prompt for disenchant
		setState("prompt")
		showPrompt(link, outBag, slot, value, spell)
	end
end

local function onEvent(...)
	if isState("sleep") or isState("disabled") then return end

	local event, arg1, arg2, arg3, arg4 = select(2, ...)
	if event == "LOOT_OPENED" then
		if isState("loot_wait") then
			-- loot window opened - grab the spoils
			eventSpam(...)
			for slot = 1, GetNumLootItems() do
				LootSlot(slot)
			end
			setState("loot")
		end
	elseif event == "LOOT_CLOSED" then
		if isState("loot") then
			-- looting done - continue scanning
			eventSpam(...)
			beginScan()
		end
	elseif event == "UNIT_SPELLCAST_SENT" then
		if isState("prompt") and arg1 == "player" and arg2 == prompt.Yes:GetAttribute("spell") then
			-- disenchant started - wait for completion
			eventSpam(...)
			if (Enchantrix.Settings.GetSetting('chatShowFindings')) then
				if arg2 == _ENCH('ArgSpellProspectingName') then
					Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeProspecting"):format(prompt.link))
				else
					Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeDisenchanting"):format(prompt.link))
				end
			end
			hidePrompt()
			setState("cast")
		end
	elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
		if isState("cast") and arg1 == "player" then
			-- interrupted - revert to scanning
			eventSpam(...)
			clearPrompt()
			beginScan()
		end
	elseif event == "UNIT_SPELLCAST_FAILED" then
		if isState("cast") and arg1 == "player" then
			-- failed - revert to scanning
			eventSpam(...)
			clearPrompt()
			beginScan()
		end
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		if isState("cast") and arg1 == "player" and arg2 == prompt.Yes:GetAttribute("spell") then
			-- completed - wait for loot window to come up
			eventSpam(...)
			setState("loot_wait")
		end
	elseif event == "BAG_UPDATE" then
		if isState("scan") then
			-- bag contents changed - rescan bags
			eventSpam(...)
			beginScan(arg1)
		elseif isState("prompt") and arg1 == prompt.bag then
			-- verify that our item is still there
		    local link = GetContainerItemLink(prompt.bag, prompt.slot)
			if link ~= prompt.link then
				eventSpam(...)
				debugSpam(prompt.link, "moved/disappeared")
				hidePrompt()

				local bag, slot, value, spell
				link, bag, slot, value, spell = findItemInBags(prompt.link)
				if link then
					-- moved
					debugSpam("  found again at [" .. bag .. "," .. slot .. "]")
					showPrompt(link, bag, slot, value, spell)
				else
					-- sold, traded, banked, destroyed, ...
					if prompt.Yes:GetAttribute("spell") == _ENCH('ArgSpellProspectingName') then
						Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeProspectCancelled"))
					else
						Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeDisenchantCancelled"))
					end
					clearPrompt()
					beginScan()
				end
			end
		end
	end
end

local updatedAgo = 0
local function onUpdate(frame, elapsed)
	if isState("disabled") then return end

	-- only handle initialization and settings changes in here, so don't need to
	-- update often. most of the grunt work happens in the event handler

	local updateEvery = 0.5
	updatedAgo = updatedAgo + elapsed
	if updatedAgo < updateEvery then return end

	local enabledInOptions = Enchantrix.Settings.GetSetting('AutoDisenchantEnable')
	if enabledInOptions then
		if isState("sleep") or isState("init") then
			if Enchantrix.Util.GetUserEnchantingSkill() >= 1 or Enchantrix.Util.GetUserJewelCraftingSkill() >= 20 then
				Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeActive"))
				beginScan()
			elseif isState("init") then
				Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeDisabled"))
				setState("disabled")
			end
		end
	else
		if isState("prompt") or isState("scan") then
			Enchantrix.Util.ChatPrint(_ENCH("FrmtAutoDeInactive"))
			if isState("prompt") then
				clearPrompt()
			end
			setState("sleep")
		end
	end

	updatedAgo = 0
end

--------------------------------------------------------------------------------
-- Prompt handling

local function getGSC(money)
	if (money == nil) then money = 0 end
	local g = math.floor(money / 10000)
	local s = math.floor((money - (g*10000)) / 100)
	local c = math.ceil(money - (g*10000) - (s*100))
	return g,s,c
end

local function getTextGSC(money)
	if (type(money) ~= "number") then return end

	local TEXT_NONE = "0"

	local GSC_GOLD="ffd100"
	local GSC_SILVER="e6e6e6"
	local GSC_COPPER="c8602c"
	local GSC_START="|cff%s%d%s|r"
	local GSC_PART=".|cff%s%02d%s|r"
	local GSC_NONE="|cffa0a0a0"..TEXT_NONE.."|r"

	if (not money) then money = 0 end

	local g, s, c = getGSC(money)
	local gsc = ""
	local fmt = GSC_START
	if (g > 0) then gsc = gsc..string.format(fmt, GSC_GOLD, g, 'g') fmt = GSC_PART end
	if (s > 0) or (c > 0) then gsc = gsc..string.format(fmt, GSC_SILVER, s, 's') fmt = GSC_PART end
	if (c > 0) then gsc = gsc..string.format(fmt, GSC_COPPER, c, 'c') end

	if (gsc == "") then gsc = GSC_NONE end

	return gsc
end

function showPrompt(link, bag, slot, value, spell)
	debugSpam(link ..",".. bag ..",".. slot ..",".. value ..",".. spell)
	
	local _, count = GetContainerItemInfo(bag, slot)
	
	prompt.link, prompt.bag, prompt.slot, prompt.count = link, bag, slot, count

	local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(prompt.link)
	prompt.Item:SetNormalTexture(texture)
	prompt.Yes:SetAttribute("target-item", itemStringFromLink(prompt.link))
	prompt.Yes:SetAttribute("spell", spell)

	-- TODO: should refer to prospecting if that's what it's doing
	if spell == _ENCH('ArgSpellProspectingName') then
		prompt.Lines[1]:SetText(_ENCH("GuiAutoProspectPromptLine1"))
		prompt.Lines[2]:SetText("  " .. prompt.link .. "x5")
	else
		prompt.Lines[1]:SetText(_ENCH("GuiAutoDePromptLine1"))
		prompt.Lines[2]:SetText("  " .. prompt.link)
	end
	prompt.Lines[3]:SetText(_ENCH("GuiAutoDePromptLine3"):format(getTextGSC(floor(value))))

	prompt:Show()
end

function hidePrompt()
	prompt:Hide()
end

function clearPrompt()
	hidePrompt()
	prompt.link, prompt.bag, prompt.slot, prompt.count = nil, nil, nil, nil, nil
end

local function promptNo()
	ignoreItemSession(prompt.link)
	clearPrompt()
	beginScan()
end

local function promptIgnore()
	ignoreItemPermanent(prompt.link)
	clearPrompt()
	beginScan()
end

--------------------------------------------------------------------------------
-- Tooltip handling

local function showTooltip()
	GameTooltip:SetOwner(prompt, "ANCHOR_NONE")
	GameTooltip:SetHyperlink(prompt.link)

	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPRIGHT", "AutoDisenchantPromptItem", "TOPLEFT", -10, -20)

	if (EnhTooltip) then
		local name = GetItemInfo(prompt.link)
		local count = 1
		if prompt.Yes:GetAttribute("spell") == _ENCH('ArgSpellProspectingName') then
			count = 5
		end
		EnhTooltip.TooltipCall(GameTooltip, name, prompt.link, -1, count, 0)
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("TOPRIGHT", "AutoDisenchantPromptItem", "TOPLEFT", -10, -20)
	end

	GameTooltip:Show()
end

local function hideTooltip()
	GameTooltip:Hide()
end

--------------------------------------------------------------------------------
-- UI

local function initUI()
	-- main frame
	frame = CreateFrame("Frame")

	-- prompt frame
	prompt = CreateFrame("Frame", "", UIParent)
	prompt:Hide()

	prompt:SetPoint("TOP", "UIParent", "TOP", 0, -100)
	prompt:SetFrameStrata("DIALOG")
	prompt:SetHeight(130)
	prompt:SetWidth(400)
	prompt:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 9, right = 9, top = 9, bottom = 9 }
	})
	prompt:SetBackdropColor(0,0,0, 0.8)
	prompt:EnableMouse(true)
	prompt:SetMovable(true)

	-- prompt dragbar
	prompt.Drag = CreateFrame("Button", "", prompt)
	prompt.Drag:SetPoint("TOPLEFT", prompt, "TOPLEFT", 10,-5)
	prompt.Drag:SetPoint("TOPRIGHT", prompt, "TOPRIGHT", -10,-5)
	prompt.Drag:SetHeight(6)
	prompt.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
	prompt.Drag:SetScript("OnMouseDown", function() prompt:StartMoving() end)
	prompt.Drag:SetScript("OnMouseUp", function() prompt:StopMovingOrSizing() end)

	-- prompt item icon
	prompt.Item = CreateFrame("Button", "AutoDisenchantPromptItem", prompt)
	prompt.Item:SetNormalTexture("Interface\\Buttons\\UI-Slot-Background")
	prompt.Item:SetPoint("TOPLEFT", prompt, "TOPLEFT", 15, -15)
	prompt.Item:SetHeight(37)
	prompt.Item:SetWidth(37)
	prompt.Item:SetScript("OnEnter", showTooltip)
	prompt.Item:SetScript("OnLeave", hideTooltip)

	-- prompt text
	prompt.Lines = {}
	for i = 1, 3 do
		prompt.Lines[i] = prompt:CreateFontString("AutoDisenchantPromptLine"..i, "HIGH")
		if (i == 1) then
			prompt.Lines[i]:SetPoint("TOPLEFT", prompt.Item, "TOPRIGHT", 5, 5)
			prompt.Lines[i]:SetFont("Fonts\\FRIZQT__.TTF",16)
		else
			prompt.Lines[i]:SetPoint("TOPLEFT", prompt.Lines[i-1], "BOTTOMLEFT", 0, -5)
			prompt.Lines[i]:SetFont("Fonts\\FRIZQT__.TTF",13)
		end
		prompt.Lines[i]:SetWidth(350)
		prompt.Lines[i]:SetJustifyH("LEFT")
		prompt.Lines[i]:SetText(" ")
	end

	-- prompt buttons

	-- there is no secure version of OptionsButton, so create an invisible
	-- OptionsButton (prompt.DummyYes) and copy its visual settings across to a
	-- SecureActionButton (prompt.Yes) to perform the spellcast

	local function copyButtonVisuals(dest, source)
		dest:ClearAllPoints()
		dest:SetPoint("TOPLEFT", source, "TOPLEFT")
		dest:SetPoint("BOTTOMRIGHT", source, "BOTTOMRIGHT")
		dest:SetNormalTexture(source:GetNormalTexture())
		dest:SetHighlightTexture(source:GetHighlightTexture())
		dest:SetPushedTexture(source:GetPushedTexture())
		dest:SetText(source:GetText())

		if select(4, GetBuildInfo() ) >= 30000 then
			dest:SetNormalFontObject(GameFontNormal);		-- ccox - WoW 3.0
			dest:SetHighlightFontObject(GameFontHighlight);	-- ccox - WOTLK
		else
			dest:SetFont(source:GetFont()) 				-- ccox - API gone in WoW 3.0
			dest:SetTextColor(source:GetTextColor()) 	-- ccox - API gone in WoW 3.0
			dest:SetHighlightTextColor(source:GetHighlightTextColor()) -- ccox - API gone in WoW 3.0
		end
	end

	-- create an invisible "Yes" OptionsButton, then copy its settings
	-- across to the secure button
	prompt.DummyYes = CreateFrame("Button", "", prompt, "OptionsButtonTemplate")
	prompt.DummyYes:SetText(_ENCH("GuiYes"))
	prompt.DummyYes:SetPoint("BOTTOMRIGHT", prompt, "BOTTOMRIGHT", -10, 10)
	prompt.DummyYes:Hide()

	prompt.Yes = CreateFrame("Button", "AutoDEPromptYes", prompt, "SecureActionButtonTemplate")
	copyButtonVisuals(prompt.Yes, prompt.DummyYes)
	prompt.Yes:SetAttribute("unit", "none")
	prompt.Yes:SetAttribute("type", "spell")

	prompt.No = CreateFrame("Button", "AutoDEPromptNo", prompt, "OptionsButtonTemplate")
	prompt.No:SetText(_ENCH("GuiNo"))
	prompt.No:SetPoint("BOTTOMRIGHT", prompt.Yes, "BOTTOMLEFT", -5, 0)
	prompt.No:SetScript("OnClick", promptNo)

	prompt.Ignore = CreateFrame("Button", "AutoDEPromptIgnore", prompt, "OptionsButtonTemplate")
	prompt.Ignore:SetText(_ENCH("GuiIgnore"))
	prompt.Ignore:SetPoint("BOTTOMRIGHT", prompt.No, "BOTTOMLEFT", -5, 0)
	prompt.Ignore:SetScript("OnClick", promptIgnore)
end

--------------------------------------------------------------------------------
-- Global setup

function addonLoaded()
	if not AutoDisenchantIgnoreList then AutoDisenchantIgnoreList = {} end

	setState("init")

	initUI()

	Stubby.RegisterEventHook("LOOT_OPENED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("LOOT_CLOSED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("UNIT_SPELLCAST_SENT", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("UNIT_SPELLCAST_INTERRUPTED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("UNIT_SPELLCAST_FAILED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("UNIT_SPELLCAST_SUCCEEDED", "Enchantrix.AutoDisenchant", onEvent)
	Stubby.RegisterEventHook("BAG_UPDATE", "Enchantrix.AutoDisenchant", onEvent)

	frame:SetScript("OnUpdate", onUpdate)
end


Enchantrix.AutoDisenchant = {
	AddonLoaded = addonLoaded,
	NameFromIgnoreListItem = nameFromIgnoreListItem,
	
}
