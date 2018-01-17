--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.0.0 (BillyGoat)
	Revision: $Id: EnxTooltip.lua 3389 2008-08-19 05:31:55Z ccox $
	URL: http://enchantrix.org/

	Tooltip functions.

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
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/RC_5.0/Enchantrix/EnxTooltip.lua $", "$Rev: 3389 $")

-- Global functions
local addonLoaded	-- Enchantrix.Tooltip.AddonLoaded()
local tooltipFormat	-- Enchantrix.Tooltip.Format

-- Local functions
local itemTooltip
local enchantTooltip
local hookTooltip

function addonLoaded()
	-- Hook in new tooltip code
	Stubby.RegisterFunctionHook("EnhTooltip.AddTooltip", 400, hookTooltip)
end

tooltipFormat = {
	currentFormat = "fancy",
	format = {
		["fancy"] = "  $prob% |q$name|r $rate",
		["default"] = "  $name: $prob% $rate",
	},
	patterns = {
		-- Strings
		["$prob"]	= "",			-- Probability: "75"
		["$name"]	= "",			-- Name: "Lesser Magic Essence"
		["$rate"]	= "",			-- Avg drop amount: "x1.5"
		-- Colors
		["|q"]		= "",			-- Quality color
		["|E"]		= "|cffcccc33",	-- Yellow ("Enchantrix" color)
		["|e"]		= "|cff7f7f00",	-- Dark yellow
		["|r"]		= "|r",			-- Reset color
	},
	SelectFormat = function(this, fmt)
		if this.format[fmt] then
			this.currentFormat = fmt
		else
			this.currentFormat = "default"
		end
	end,
	SetFormat = function(this, fmt, val, counts)
		this.format[fmt] = val
	end,
	GetFormat = function(this, fmt, counts)
		if not this.format[fmt] then return end
		return this.format[fmt]
	end,
	GetString = function(this)
		local line = this.format[this.currentFormat]
		-- Replace patterns
		for pat, repl in pairs(this.patterns) do
			line = line:gsub(pat, repl or "")
		end
		return line
	end,
	SetPattern = function(this, pat, repl)
		this.patterns[pat] = repl
	end,
}


local function prospectTooltip(prospect, funcVars, retVal, frame, name, link, quality, count)

	local embed = Enchantrix.Settings.GetSetting('ToolTipEmbedInGameTip')

	local lines

	local totalFive = {}
	local totalHSP, totalMed, totalMkt, totalFive = 0,0,0,0
	local totalNumber, totalQuantity

	for result, resYield in pairs( prospect ) do
		if (not lines) then lines = {} end
		local style, extra = Enchantrix.Util.GetPricingModel();
		local hsp, med, mkt, five = Enchantrix.Util.GetReagentPrice(result,extra)
		local resHSP, resMed, resMkt, resFive = (hsp or 0)*resYield, (med or 0)*resYield, (mkt or 0)*resYield, (five or 0)*resYield
		totalHSP = totalHSP + resHSP
		totalMed = totalMed + resMed
		totalMkt = totalMkt + resMkt
		totalFive = totalFive + resFive

		-- Probabilities
		local prob = tostring( resYield * 100 )
		tooltipFormat:SetPattern("$prob", prob)

		-- Name and quality
		local rName, _, rQuality = Enchantrix.Util.GetReagentInfo(result)
		local _, _, _, color = GetItemQualityColor(rQuality or 0)
		tooltipFormat:SetPattern("|q", color or "|cffcccc33")
		if (not rName) then rName = "item:"..result; end
		tooltipFormat:SetPattern("$name", rName)

		-- Rate is always unity here (not really 1, but handled in the probability)
		tooltipFormat:SetPattern("$rate", "")

		-- Store this line and sort key
		local line = tooltipFormat:GetString(false)	-- no counts here
		table.insert(lines,  {str = line, sort = resYield})
	end


	-- multiply values by the number of items in this stack
	local groups = count / 5;
	totalHSP = totalHSP * groups;
	totalMed = totalMed * groups;
	totalMkt = totalMkt * groups;
	totalFive = totalFive * groups;

	-- Terse mode
	if Enchantrix.Settings.GetSetting('ToolTipProspectTerseFormat') and not IsControlKeyDown() then
		if (AucAdvanced and Enchantrix.Settings.GetSetting('TooltipProspectShowAuctAdvValue') and totalFive > 0) then
			EnhTooltip.AddLine(_ENCH('FrmtProspectValueAuctVal'), totalFive, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		elseif Enchantrix.Settings.GetSetting('TooltipProspectShowAuctValueHSP') and totalHSP > 0 then
			EnhTooltip.AddLine(_ENCH('FrmtProspectValueAuctHsp'), totalHSP, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		elseif Enchantrix.Settings.GetSetting('TooltipProspectShowAuctValueMedian') and totalMed > 0 then
			EnhTooltip.AddLine(_ENCH('FrmtProspectValueAuctMed'), totalMed, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		elseif Enchantrix.Settings.GetSetting('TooltipProspectShowBaselineValue') and totalMkt > 0 then
			EnhTooltip.AddLine(_ENCH('FrmtProspectValueMarket'), totalMkt, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		end
		return
	end

	if (Enchantrix.Settings.GetSetting('TooltipProspectMats')) then
		-- Header
		local totalText = ""
		EnhTooltip.AddLine(_ENCH('FrmtProspectInto')..totalText, nil, embed);
		EnhTooltip.LineColor(0.8,0.8,0.2);
		-- Sort in order of decreasing probability before adding to tooltip
		table.sort(lines, function(a, b) return a.sort > b.sort end)
		for n, line in ipairs(lines) do
			EnhTooltip.AddLine(line.str, nil, embed)
			EnhTooltip.LineColor(0.8, 0.8, 0.2);
			if n >= 13 then break end -- Don't add more than 13 lines (1 Powder + 6 Uncommon + 6 Rare)
		end
	end

	if (Enchantrix.Settings.GetSetting('TooltipProspectLevels')) then
		local reqSkill = Enchantrix.Util.JewelCraftSkillRequiredForItem(link);
		local userSkill = Enchantrix.Util.GetUserJewelCraftingSkill();
		local deText = format(_ENCH("TooltipProspectLevel"), reqSkill );
		EnhTooltip.AddLine(deText, nil, embed);
		if (userSkill < reqSkill) then
			EnhTooltip.LineColor(0.8,0.1,0.1);		-- reddish
		else
			EnhTooltip.LineColor(0.1,0.8,0.1);		-- greenish
		end
	end

	if (Enchantrix.Settings.GetSetting('TooltipProspectValues')) then
		if (AucAdvanced and Enchantrix.Settings.GetSetting('TooltipProspectShowAuctAdvValue') and totalFive > 0) then
			EnhTooltip.AddLine(_ENCH('FrmtProspectValueAuctVal'), totalFive, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		end
		if (Enchantrix.Settings.GetSetting('TooltipProspectShowAuctValueHSP') and totalHSP > 0) then
			EnhTooltip.AddLine(_ENCH('FrmtProspectValueAuctHsp'), totalHSP, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		end
		if (Enchantrix.Settings.GetSetting('TooltipProspectShowAuctValueMedian') and totalMed > 0) then
			EnhTooltip.AddLine(_ENCH('FrmtProspectValueAuctMed'), totalMed, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		end
		if (Enchantrix.Settings.GetSetting('TooltipProspectShowBaselineValue') and totalMkt > 0) then
			EnhTooltip.AddLine(_ENCH('FrmtProspectValueMarket'), totalMkt, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		end
	end

end


function itemTooltip(funcVars, retVal, frame, name, link, quality, count)
	
	-- first, see if this is a prospectable item (short list)
	local prospect = Enchantrix.Storage.GetItemProspects(link)
	if (prospect and Enchantrix.Settings.GetSetting('TooltipShowProspecting')) then
		prospectTooltip(prospect, funcVars, retVal, frame, name, link, quality, count)
		return
	end

	-- then see if it's disenchantable
	local data = Enchantrix.Storage.GetItemDisenchants(link)
	if not data then
		-- error message would have been printed inside GetItemDisenchants
		return
	end

	local lines

	local total = data.total
	local totalFive = {}
	local totalHSP, totalMed, totalMkt, totalFive = 0,0,0,0
	local totalNumber, totalQuantity
	local allFixed = true

	if (total and total[1] > 0) then
		totalNumber, totalQuantity = unpack(total)
		for result, resData in pairs(data) do
			if (result ~= "total") then
				if (not lines) then lines = {} end

				local resNumber, resQuantity = unpack(resData)
				local style, extra = Enchantrix.Util.GetPricingModel()
				local hsp, med, mkt, five, fix = Enchantrix.Util.GetReagentPrice(result, extra)
				local resProb, resCount = resNumber/totalNumber, resQuantity/resNumber
				local resYield = resProb * resCount;	-- == resQuantity / totalNumber;
				local resHSP, resMed, resMkt, resFive, resFix = (hsp or 0)*resYield, (med or 0)*resYield, (mkt or 0)*resYield, (five or 0)*resYield, (fix or 0)*resYield
				if (fix) then
					resHSP, resMed, resMkt, resFive = resFix,resFix,resFix,resFix
				else
					allFixed = false
				end
				totalHSP = totalHSP + resHSP
				totalMed = totalMed + resMed
				totalMkt = totalMkt + resMkt
				totalFive = totalFive + resFive

				local prob = 100 * resProb

				-- Probabilities
				tooltipFormat:SetPattern("$prob", tostring(prob))

				-- Name and quality
				local rName, _, rQuality = Enchantrix.Util.GetReagentInfo(result)
				local _, _, _, color = GetItemQualityColor(rQuality or 0)
				tooltipFormat:SetPattern("|q", color or "|cffcccc33")
				if (not rName) then rName = "item:"..result; end
				tooltipFormat:SetPattern("$name", rName)

				-- Rate
                tooltipFormat:SetPattern("$rate", ("x%0.1f"):format(resCount))

				-- Store this line and sort key
				local line = tooltipFormat:GetString()
				table.insert(lines,  {str = line, sort = prob})
			end
		end
	else
		return
	end

	local embed = Enchantrix.Settings.GetSetting('ToolTipEmbedInGameTip')

	-- Terse mode
	if Enchantrix.Settings.GetSetting('ToolTipTerseFormat') and not IsControlKeyDown() then
		if (allFixed) then
			EnhTooltip.AddLine(_ENCH('FrmtValueFixedVal'), totalHSP, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		else
			if (AucAdvanced and Enchantrix.Settings.GetSetting('TooltipShowAuctAdvValue') and totalFive > 0) then
				EnhTooltip.AddLine(_ENCH('FrmtValueAuctVal'), totalFive, embed);
				EnhTooltip.LineColor(0.1,0.6,0.6);
			elseif Enchantrix.Settings.GetSetting('TooltipShowAuctValueHSP') and totalHSP > 0 then
				EnhTooltip.AddLine(_ENCH('FrmtValueAuctHsp'), totalHSP, embed);
				EnhTooltip.LineColor(0.1,0.6,0.6);
			elseif Enchantrix.Settings.GetSetting('TooltipShowAuctValueMedian') and totalMed > 0 then
				EnhTooltip.AddLine(_ENCH('FrmtValueAuctMed'), totalMed, embed);
				EnhTooltip.LineColor(0.1,0.6,0.6);
			elseif Enchantrix.Settings.GetSetting('TooltipShowBaselineValue') and totalMkt > 0 then
				EnhTooltip.AddLine(_ENCH('FrmtValueMarket'), totalMkt, embed);
				EnhTooltip.LineColor(0.1,0.6,0.6);
			end
		end
		return
	end

	if (Enchantrix.Settings.GetSetting('TooltipShowDisenchantMats')) then
		-- Header
		local totalText = ""
		EnhTooltip.AddLine(_ENCH('FrmtDisinto')..totalText, nil, embed);
		EnhTooltip.LineColor(0.8,0.8,0.2);
		-- Sort in order of decreasing probability before adding to tooltip
		table.sort(lines, function(a, b) return a.sort > b.sort end)
		for n, line in ipairs(lines) do
			EnhTooltip.AddLine(line.str, nil, embed)
			EnhTooltip.LineColor(0.8, 0.8, 0.2);
			if n >= 5 then break end -- Don't add more than 5 lines
		end
	end

	if (Enchantrix.Settings.GetSetting('TooltipShowDisenchantLevel')) then
		local reqSkill = Enchantrix.Util.DisenchantSkillRequiredForItem(link);
		local userSkill = Enchantrix.Util.GetUserEnchantingSkill();
		local deText = format(_ENCH("TooltipShowDisenchantLevel"), reqSkill );
		EnhTooltip.AddLine(deText, nil, embed);
		if (userSkill < reqSkill) then
			EnhTooltip.LineColor(0.8,0.1,0.1);		-- reddish
		else
			EnhTooltip.LineColor(0.1,0.8,0.1);		-- greenish
		end
	end

	if (Enchantrix.Settings.GetSetting('TooltipShowValues')) then
		if (allFixed) then
			EnhTooltip.AddLine(_ENCH('FrmtValueFixedVal'), totalHSP, embed);
			EnhTooltip.LineColor(0.1,0.6,0.6);
		else
			if (AucAdvanced and Enchantrix.Settings.GetSetting('TooltipShowAuctAdvValue') and totalFive > 0) then
				EnhTooltip.AddLine(_ENCH('FrmtValueAuctVal'), totalFive, embed);
				EnhTooltip.LineColor(0.1,0.6,0.6);
			end
			if (Enchantrix.Settings.GetSetting('TooltipShowAuctValueHSP') and totalHSP > 0) then
				EnhTooltip.AddLine(_ENCH('FrmtValueAuctHsp'), totalHSP, embed);
				EnhTooltip.LineColor(0.1,0.6,0.6);
			end
			if (Enchantrix.Settings.GetSetting('TooltipShowAuctValueMedian') and totalMed > 0) then
				EnhTooltip.AddLine(_ENCH('FrmtValueAuctMed'), totalMed, embed);
				EnhTooltip.LineColor(0.1,0.6,0.6);
			end
			if (Enchantrix.Settings.GetSetting('TooltipShowBaselineValue') and totalMkt > 0) then
				EnhTooltip.AddLine(_ENCH('FrmtValueMarket'), totalMkt, embed);
				EnhTooltip.LineColor(0.1,0.6,0.6);
			end
		end
	end
end

-- using the Craft APIs
local function getReagentsFromCraftFrame(craftIndex)
	local reagentList = {}
	
	local getReagentsFunc = GetCraftNumReagents or GetTradeSkillNumReagents;	-- ccox - WoW 3.0
	local getReagentLinkFunc = GetCraftReagentItemLink or GetTradeSkillReagentItemLink;	 -- ccox - WoW 3.0
	local getReagentInfoFunc = GetCraftReagentInfo or GetTradeSkillReagentInfo;	-- ccox - WoW 3.0

	local numReagents = getReagentsFunc(craftIndex)
	for i = 1, numReagents do
		local link = getReagentLinkFunc(craftIndex, i)
		if link then
			local hlink = EnhTooltip.HyperlinkFromLink(link)
			local reagentName, reagentTexture, reagentCount, playerReagentCount = getReagentInfoFunc(craftIndex, i)
			table.insert(reagentList, {hlink, reagentCount})
		end
	end

	return reagentList
end

-- using the Trade APIs
local function getReagentsFromTradeFrame(craftIndex)
	local reagentList = {}

	local numReagents = GetTradeSkillNumReagents(craftIndex)
	for i = 1, numReagents do
		local link = GetTradeSkillReagentItemLink(craftIndex, i)
		if link then
			local hlink = EnhTooltip.HyperlinkFromLink(link)
			local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(craftIndex, i)
			table.insert(reagentList, {hlink, reagentCount})
		end
	end

	return reagentList
end

-- NOTE - ccox - to match non enchants, I'd need to search for "Requires (.+)"
local function getReagentsFromTooltip(frame)
	local frameName = frame:GetName()
	local nLines = frame:NumLines()
	local reagents
	-- Find reagents line ("Reagents: ...")
	for i = 1, nLines do
		local text = getglobal(frameName.."TextLeft"..i):GetText()

		-- text:find("Reagents: (.+)")
		local _, _, r = text:find(_ENCH('PatReagents'))
		if r then
			reagents = r
			--Enchantrix.Util.DebugPrintQuick("matched reagents line ", reagents )
			break
		end
	end
	if not reagents then return end

	local reagentList = {}
	local name, quality, color, hlink
	-- Process reagents separated by ","
	for reagent in Enchantrix.Util.Spliterator(reagents, ",") do
		-- Chomp whitespace
		reagent = reagent:gsub("^%s*", "")	-- remove leading spaces
		reagent = reagent:gsub("%s*$", "")	-- remove trailing spaces
		--reagent = reagent:gsub("%c*", "")	-- remove all control characters
		-- ...and newlines
		reagent = reagent:gsub("%|n", "")	-- remove blizzard style newline codes
		-- ...and color codes
		reagent = reagent:gsub("^%|c%x%x%x%x%x%x%x%x", "")
		reagent = reagent:gsub("%|r$", "")	-- remove blizzard style return at end of line

		-- NOTE - ccox - if reagents aren't being found, Blizzard may have added more formatting that needs to be removed above
		-- Enchantrix.Util.DebugPrintQuick("cleaned reagent string ", reagent )
		
		-- Get and chomp counts, e.g "Strange Dust (2)"
		local _, _, count = reagent:find("%((%d+)%)$")
		if count then
			reagent = reagent:gsub("%s*%(%d+%)$", "")
			count = tonumber(count)
		else
			count = 1
		end

		hlink = Enchantrix.Util.GetLinkFromName(reagent)
		if hlink then
			table.insert(reagentList, {hlink, count})
		else
			return
		end
	end

	return reagentList
end


-- this can be used by non enchanters when clicking on an enchant tooltip
-- this is also used inside the enchanting/crafting trade window

function enchantTooltip(funcVars, retVal, frame, name, link, isItem)

-- TODO - ccox - for items, get the number made!  But what about items with random yield?
-- TODO - ccox - this really should recursively descend crafted items for true costs not AH prices
--		most of the time they'll be in the cache, so it won't add a lot of time to the search

	local craftIndex = nil
	local tradeIndex = nil
	local reagentList

	-- if it's an item, try our cache
	if isItem then
		reagentList = Enchantrix.Util.GetCraftReagentInfoFromCache(name)
	end

	if not reagentList or (#reagentList < 1) then
	
		-- clean up the craft item string
		--Enchantrix.Util.DebugPrintQuick("original name is ", name )
		name = name:gsub("^%a+:", "")	-- remove crafting type "Enchanting:"
		name = name:gsub("^%s*", "")	-- remove leading spaces
		--Enchantrix.Util.DebugPrintQuick("cleaned name is ", name )

		if select(4, GetBuildInfo()) < 30000 then		-- ccox - WoW 3.0 gets rid of GetCraft APIs
			-- first try craft APIs
			for i = 1, GetNumCrafts() do
				local craftName = GetCraftInfo(i)
				--Enchantrix.Util.DebugPrintQuick("testing craft ", name, " equal to ", craftName )
				if name == craftName then
					craftIndex = i
					break
				end
			end
		end

		if craftIndex then
			reagentList = getReagentsFromCraftFrame(craftIndex)
		else
			-- try trade skill APIs next
			for i = GetFirstTradeSkill(), GetNumTradeSkills() do
				local tradeName = GetTradeSkillInfo(i);
				if name == tradeName then
					tradeIndex = i
					break
				end
			end

			if tradeIndex then
				reagentList = getReagentsFromTradeFrame(tradeIndex)
			else
				-- if all else fails
				reagentList = getReagentsFromTooltip(frame)
			end
		end

		if not reagentList or (#reagentList < 1) then
			--Enchantrix.Util.DebugPrintQuick("no reagents found for ", link, " in ", name )
			return
		end

		-- now save it to the cache
		if isItem then
			Enchantrix.Util.SaveCraftReagentInfoToCache( name, reagentList );
		end

	end

	-- Append additional reagent info
	for _, reagent in ipairs(reagentList) do
		local rName, _, rQuality = Enchantrix.Util.GetReagentInfo(reagent[1])
		local style, extra = Enchantrix.Util.GetPricingModel();
		local hsp, median, market, five, fix = Enchantrix.Util.GetReagentPrice(reagent[1],extra)
		local _, _, _, color = GetItemQualityColor(rQuality)

		reagent[1] = rName
		table.insert(reagent, rQuality)
		table.insert(reagent, color)
		if fix then
			table.insert(reagent, fix)
		elseif AucAdvanced and five and five > 0 then
			table.insert(reagent, five)
		else
			table.insert(reagent, hsp)
		end
	end

	local NAME, COUNT, QUALITY, COLOR, PRICE = 1, 2, 3, 4, 5

	-- Sort by rarity and price
	table.sort(reagentList, function(a,b)
		if (not b) or (not a) then return end
		return ((b[QUALITY] or -1) < (a[QUALITY] or -1)) or ((b[PRICE] or 0) < (a[PRICE] or 0))
	end)

	-- Header
	local embed = Enchantrix.Settings.GetSetting('ToolTipEmbedInGameTip');
	if not embed and not isItem then
		local icon
		if craftIndex then
			icon = GetCraftIcon(craftIndex)		-- ccox - WoW 3.0 - API is gone, but can't be hit because craftIndex won't be set
		elseif tradeIndex then
			icon = GetTradeSkillIcon(tradeIndex)
		else
			icon = "Interface\\Icons\\Spell_Holy_GreaterHeal"
		end
		EnhTooltip.SetIcon(icon)
		EnhTooltip.AddLine(name)
		EnhTooltip.AddLine(EnhTooltip.HyperlinkFromLink(link))
	end
	EnhTooltip.AddLine(_ENCH('FrmtSuggestedPrice'), nil, embed)
	EnhTooltip.LineColor(0.8,0.8,0.2)

	local price = 0
	local unknownPrices
	-- Add reagent list to tooltip and sum reagent prices
	for _, reagent in pairs(reagentList) do
		local line = "  "

		if reagent[COLOR] then
			line = line..reagent[COLOR]
		end
		line = line..reagent[NAME]
		if reagent[COLOR] then
			line = line.."|r"
		end
		line = line.." x"..reagent[COUNT]
		if reagent[COUNT] > 1 and reagent[PRICE] then
			line = line.." ".._ENCH('FrmtPriceEach'):format(EnhTooltip.GetTextGSC(Enchantrix.Util.Round(reagent[PRICE], 3)))
			EnhTooltip.AddLine(line, Enchantrix.Util.Round(reagent[PRICE] * reagent[COUNT], 3), embed)
			price = price + reagent[PRICE] * reagent[COUNT]
		elseif reagent[PRICE] then
			EnhTooltip.AddLine(line, Enchantrix.Util.Round(reagent[PRICE], 3), embed)
			price = price + reagent[PRICE]
		else
			EnhTooltip.AddLine(line, nil, embed)
			unknownPrices = true
		end
		EnhTooltip.LineColor(0.7,0.7,0.1)
	end

	-- add barker line, if barker is loaded
	local margin = 0
	local profit = 0
	local barkerPrice = 0

	if (Barker and Barker.Settings.GetSetting('barker')) then
	-- Barker price
		margin = Barker.Settings.GetSetting("barker.profit_margin")
		profit = price * margin * 0.01
		profit = math.min(profit, Barker.Settings.GetSetting("barker.highest_profit"))
		barkerPrice = Enchantrix.Util.Round(price + profit)
	end


	-- Totals
	if price > 0 then

		EnhTooltip.AddLine(_ENCH('FrmtTotal'), Enchantrix.Util.Round(price, 2.5), embed)
		EnhTooltip.LineColor(0.8,0.8,0.2)

		if (Barker and Barker.Settings.GetSetting('barker')) then
			-- "Barker Price (%d%% margin)"
			EnhTooltip.AddLine(_ENCH('FrmtBarkerPrice'):format(Barker.Util.Round(margin)), barkerPrice, embed)
			EnhTooltip.LineColor(0.8,0.8,0.2)
		end

		if not Enchantrix.State.Auctioneer_Loaded then
			EnhTooltip.AddLine(_ENCH('FrmtWarnAuctNotLoaded'))
			EnhTooltip.LineColor(0.6,0.6,0.1)
		end

		if unknownPrices then
			EnhTooltip.AddLine(_ENCH('FrmtWarnPriceUnavail'))
			EnhTooltip.LineColor(0.6,0.6,0.1)
		end
	else
		EnhTooltip.AddLine(_ENCH('FrmtWarnNoPrices'))
		EnhTooltip.LineColor(0.6,0.6,0.1)
	end
end

function hookTooltip(funcVars, retVal, frame, name, link, quality, count)
	-- nothing to do, if enchantrix is disabled
	if (not Enchantrix.Settings.GetSetting('all')) then
		return
	end

	local ltype = EnhTooltip.LinkType(link)
	if ltype == "item" then
		itemTooltip(funcVars, retVal, frame, name, link, quality, count)
		if (Enchantrix.Settings.GetSetting('ShowAllCraftReagents')) then
			enchantTooltip(funcVars, retVal, frame, name, link, true)
		end
	elseif ltype == "enchant" or ltype == "spell" then
-- ccox - debugging Wow 3.0 -- Enchantrix.Util.DebugPrintQuick("tooltip inputs", funcVars, retVal, frame, name, link, quality, count )
		
		name = name or ""	-- tooltip hook gives a nil name in 3.0!  Filed as a bug with Blizzard
		
		enchantTooltip(funcVars, retVal, frame, name, link, false)
	end
end

Enchantrix.Tooltip = {
	Revision		= "$Revision: 3389 $",

	AddonLoaded		= addonLoaded,
	Format			= tooltipFormat,
}
