--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 5.0.0 (BillyGoat)
	Revision: $Id: EnxConstants.lua 3391 2008-08-19 05:33:14Z ccox $
	URL: http://enchantrix.org/

	Enchantrix Constants.

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
Enchantrix_RegisterRevision("$URL: http://svn.norganna.org/auctioneer/branches/RC_5.0/Enchantrix/EnxConstants.lua $", "$Rev: 3391 $")

local const = Enchantrix.Constants

-- These are market norm prices.
-- Median prices from Allakhazam.com, December 4, 2007 - Updated by testleK
-- Prices are in copper aka GGSSCC
const.StaticPrices = {
	[22450] = 246666, -- Void Crystal
	[20725] =  95000, -- Nexus Crystal

	[22449] = 249999, -- Large Prismatic Shard
	[14344] =  95000, -- Large Brilliant Shard
	[11178] =  80000, -- Large Radiant Shard
	[11139] =  17500, -- Large Glowing Shard
	[11084] =   9000, -- Large Glimmering Shard

	[22448] =  84900, -- Small Prismatic Shard
	[14343] =  39600, -- Small Brilliant Shard
	[11177] =  75000, -- Small Radiant Shard
	[11138] =   5000, -- Small Glowing Shard
	[10978] =   3846, -- Small Glimmering Shard

	[22446] =  75850, -- Greater Planar Essence
	[16203] = 119999, -- Greater Eternal Essence
	[11175] =  65000, -- Greater Nether Essence
	[11135] =   8990, -- Greater Mystic Essence
	[11082] =   7887, -- Greater Astral Essence
	[10939] =   6550, -- Greater Magic Essence

	[22447] =  21366, -- Lesser Planar Essence
	[16202] =  45411, -- Lesser Eternal Essence
	[11174] =  23750, -- Lesser Nether Essence
	[11134] =   4183, -- Lesser Mystic Essence
	[10998] =   3500, -- Lesser Astral Essence
	[10938] =   3020, -- Lesser Magic Essence

	[22445] =  19000, -- Arcane Dust
	[16204] =  27500, -- Illusion Dust
	[11176] =   7500, -- Dream Dust
	[11137] =   6000, -- Vision Dust
	[11083] =   3370, -- Soul Dust
	[10940] =   1600, -- Strange Dust

	[2772] =    3500, -- Iron Ore
	[3356] =     250, -- Kingsblood
	[3371] =     110, -- Empty Vial
	[3372] =     187, -- Leaded Vial
	[3819] =    5000, -- Wintersbite
	[3829] =   32500, -- Frost Oil
	[4470] =     436, -- Simple Wood
	[4625] =    3000, -- Firebloom
	[5500] =   42000, -- Iridescent Pearl
	[5637] =    7610, -- Large Fang
	[6037] =   10000, -- Truesilver Bar
	[6048] =    5999, -- Shadow Protection Potion
	[6217] =   11100, -- Copper Rod
	[6370] =    4940, -- Blackmouth Oil
	[6371] =    5000, -- Fire Oil
	[7067] =   12344, -- Elemental Earth
	[7075] =   79600, -- Core of Earth
	[7077] =   55555, -- Heart of Fire
	[7078] =   10000, -- Essence of Fire
	[7079] =   14406, -- Globe of Water
	[7080] =   25000, -- Essence of Water
	[7081] =   90000, -- Breath of Wind
	[7082] =   11000, -- Essence of Air
	[7392] =    2880, -- Green Whelp Scale
	[7909] =   28000, -- Aquamarine
	[7971] =   26666, -- Black Pearl
	[7972] =    3000, -- Ichor of Undeath
	[8153] =   14190, -- Wildvine
	[8170] =    4625, -- Rugged Leather
	[8831] =    5000, -- Purple Lotus
	[8838] =    5325, -- Sungrass
	[8925] =     500, -- Crystal Vial
	[9224] =   35900, -- Elixir of Demonslaying
	[11128] =  32944, -- Golden Rod
	[11144] =  44500, -- Truesilver Rod
	[11291] =   4500, -- Star Wood
	[11382] = 186900, -- Blood of the Mountain
	[11754] =   3600, -- Black Diamond
	[12359] =  12000, -- Thorium Bar
	[12803] =  20000, -- Living Essence
	[12808] =  60000, -- Essence of Undeath
	[12809] =  50000, -- Guardian Stone
	[12811] = 430000, -- Righteous Orb
	[13444] =  11199, -- Major Mana Potion
	[13446] =  12400, -- Major Healing Potion
	[13467] =   7000, -- Icecap
	[13468] =  95000, -- Black Lotus
	[13926] =  17500, -- Golden Pearl
	[16206] = 550000, -- Arcanite Rod
	[17034] =    650, -- Maple Seed
	[17035] =    676, -- Stranglethorn Seed
	[18256] =   5821, -- Imbued Vial
	[18512] =  17332, -- Larval Acid
	[21884] = 250000, -- Primal Fire
	[21885] = 200000, -- Primal Water
	[21886] = 133333, -- Primal Life
	[22451] = 250000, -- Primal Air
	[22452] =  40000, -- Primal Earth
	[22456] = 180450, -- Primal Shadow
	[22457] = 196000, -- Primal Mana
	[22791] =  15891, -- Netherbloom
	[22792] =  18995, -- Nightmare Vine
	[25843] = 188500, -- Fel Iron Rod
	[25844] = 250000, -- Adamantite Rod
	[25845] = 369397, -- Eternium Rod

	[24186] =     50, 	-- COPPERPOWDER, vendor
	[24188] =    125, 	-- TINPOWDER, vendor
	[24190] =    400, 	-- IRONPOWDER, vendor
	[24234] =    500, 	-- MITHRILPOWDER, vendor
	[24235] =    800, 	-- THORIUMPOWDER, vendor
	[24242] =   1500, 	-- FELIRONPOWDER, vendor
	[24243] =   4750, 	-- ADAMANTITEPOWDER, auction

	[818] =     3500, 	-- TIGERSEYE
	[774] =     2500, 	-- MALACHITE
	[1210] =    6153,	-- SHADOWGEM
	[1705] =   12500, 	-- LESSERMOONSTONE
	[1206] =   16377, 	-- MOSSAGATE
	[3864] =   10000, 	-- CITRINE
	[1529] =   20000, 	-- JADE
	[7909] =   28000, 	-- AQUAMARINE
	[7910] =   24545, 	-- STARRUBY
	[12800] =  94500, 	-- AZEROTHIANDIAMOND
	[12361] =  46549, 	-- BLUESAPPHIRE
	[12799] =  48220, 	-- LARGEOPAL
	[12364] =  87500, 	-- HUGEEMERALD
	[23077] =   9850, 	-- BLOODGARNET
	[21929] =   6250, 	-- FLAMESPESSARITE
	[23112] =   9500, 	-- GOLDENDRAENITE
	[23079] =   7500, 	-- DEEPPERIDOT
	[23117] =   7500, 	-- AZUREMOONSTONE
	[23107] =   8000, 	-- SHADOWDRAENITE
	[23436] = 500000,	-- LIVINGRUBY
	[23439] = 439900, 	-- NOBLETOPAZ
	[23440] = 349999, 	-- DAWNSTONE
	[23437] = 157900, 	-- TALASITE
	[23438] = 450000, 	-- STAROFELUNE
	[23441] = 420000, 	-- NIGHTSEYE

}

const.DUST = 1
const.ESSENCE_LESSER = 2
const.ESSENCE_GREATER = 3
const.SHARD_SMALL = 4
const.SHARD_LARGE = 5
const.CRYSTAL = 6

const.CONSUMABLE = 0
const.CONTAINER  = 1
const.WEAPON     = 2
const.ARMOR      = 4
const.REAGENT    = 5
const.PROJECTILE = 6
const.TRADE      = 7
const.RECIPE     = 9
const.QUIVER     = 11
const.QUEST      = 12
const.KEY        = 13
const.MISC       = 15


const.InventoryTypes = {
	["INVTYPE_2HWEAPON"] = const.WEAPON,
	["INVTYPE_WEAPON"] = const.WEAPON,
	["INVTYPE_WEAPONMAINHAND"] = const.WEAPON,
	["INVTYPE_WEAPONOFFHAND"] = const.WEAPON,
	["INVTYPE_RANGED"] = const.WEAPON,
	["INVTYPE_RANGEDRIGHT"] = const.WEAPON,
	["INVTYPE_THROWN"] = const.WEAPON,
	["INVTYPE_BODY"] = const.ARMOR,
	["INVTYPE_CHEST"] = const.ARMOR,
	["INVTYPE_CLOAK"] = const.ARMOR,
	["INVTYPE_FEET"] = const.ARMOR,
	["INVTYPE_FINGER"] = const.ARMOR,
	["INVTYPE_HAND"] = const.ARMOR,
	["INVTYPE_HEAD"] = const.ARMOR,
	["INVTYPE_HOLDABLE"] = const.ARMOR,
	["INVTYPE_LEGS"] = const.ARMOR,
	["INVTYPE_NECK"] = const.ARMOR,
	["INVTYPE_ROBE"] = const.ARMOR,
	["INVTYPE_SHIELD"] = const.ARMOR,
	["INVTYPE_SHOULDER"] = const.ARMOR,
	["INVTYPE_TABARD"] = const.ARMOR,
	["INVTYPE_TRINKET"] = const.ARMOR,
	["INVTYPE_WAIST"] = const.ARMOR,
	["INVTYPE_WRIST"] = const.ARMOR,
	["INVTYPE_RELIC"] = const.ARMOR,
}

-- Enchanting reagents
local VOID = 22450
local NEXUS = 20725
local LPRISMATIC = 22449
local LBRILLIANT = 14344
local LRADIANT = 11178
local LGLOWING = 11139
local LGLIMMERING = 11084
local SPRISMATIC = 22448
local SBRILLIANT = 14343
local SRADIANT = 11177
local SGLOWING = 11138
local SGLIMMERING = 10978
local GPLANAR = 22446
local GETERNAL = 16203
local GNETHER = 11175
local GMYSTIC = 11135
local GASTRAL = 11082
local GMAGIC = 10939
local LPLANAR = 22447
local LETERNAL = 16202
local LNETHER = 11174
local LMYSTIC = 11134
local LASTRAL = 10998
local LMAGIC = 10938
local ARCANE = 22445
local ILLUSION = 16204
local DREAM = 11176
local VISION = 11137
local SOUL = 11083
local STRANGE = 10940


-- and in a form we can iterate over, with a fixed order for the UI

const.DisenchantReagentList = {

	22450, -- Void Crystal
	20725, -- Nexus Crystal

	22449, -- Large Prismatic Shard
	14344, -- Large Brilliant Shard
	11178, -- Large Radiant Shard
	11139, -- Large Glowing Shard
	11084, -- Large Glimmering Shard

	22448, -- Small Prismatic Shard
	14343, -- Small Brilliant Shard
	11177, -- Small Radiant Shard
	11138, -- Small Glowing Shard
	10978, -- Small Glimmering Shard

	22446, -- Greater Planar Essence
	16203, -- Greater Eternal Essence
	11175, -- Greater Nether Essence
	11135, -- Greater Mystic Essence
	11082, -- Greater Astral Essence
	10939, -- Greater Magic Essence

	22447, -- Lesser Planar Essence
	16202, -- Lesser Eternal Essence
	11174, -- Lesser Nether Essence
	11134, -- Lesser Mystic Essence
	10998, -- Lesser Astral Essence
	10938, -- Lesser Magic Essence

	22445, -- Arcane Dust
	16204, -- Illusion Dust
	11176, -- Dream Dust
	11137, -- Vision Dust
	11083, -- Soul Dust
	10940, -- Strange Dust

}


-- item qualities
local UNCOMMON = 2
local RARE = 3
local EPIC = 4

-- disenchanting level bracket upper bounds
-- e.g. an ilevel 52 item goes into bracket 55
const.levelUpperBounds = { 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 79, 85, 94, 99, 115, 120, 164 }


-- the big disenchant table, indexed by [quality][type][level bracket]
-- and yielding { { reagent type, drop probability, average drop quantity }, ... }
-- Thanks to Chardonnay, Tekkub and Wowhead

-- TODO - ccox - can I use a bounds list per quality to make the tables smaller?
const.baseDisenchantTable = {
 [UNCOMMON] = {
  [const.WEAPON] = {
   [15]  = { { STRANGE , 0.20, 1.5 }, { LMAGIC  , 0.80, 1.5 }, },
   [20]  = { { STRANGE , 0.20, 2.5 }, { GMAGIC  , 0.75, 1.5 }, { SGLIMMERING, 0.05, 1.0 }, },
   [25]  = { { STRANGE , 0.15, 5.0 }, { LASTRAL , 0.75, 1.5 }, { SGLIMMERING, 0.10, 1.0 }, },
   [30]  = { { SOUL    , 0.20, 1.5 }, { GASTRAL , 0.75, 1.5 }, { LGLIMMERING, 0.05, 1.0 }, },
   [35]  = { { SOUL    , 0.20, 3.5 }, { LMYSTIC , 0.75, 1.5 }, { SGLOWING   , 0.05, 1.0 }, },
   [40]  = { { VISION  , 0.20, 1.5 }, { GMYSTIC , 0.75, 1.5 }, { LGLOWING   , 0.05, 1.0 }, },
   [45]  = { { VISION  , 0.15, 3.5 }, { LNETHER , 0.80, 1.5 }, { SRADIANT   , 0.05, 1.0 }, },
   [50]  = { { DREAM   , 0.20, 1.5 }, { GNETHER , 0.75, 1.5 }, { LRADIANT   , 0.05, 1.0 }, },
   [55]  = { { DREAM   , 0.20, 3.5 }, { LETERNAL, 0.75, 1.5 }, { SBRILLIANT , 0.05, 1.0 }, },
   [60]  = { { ILLUSION, 0.20, 1.5 }, { GETERNAL, 0.75, 1.5 }, { LBRILLIANT , 0.05, 1.0 }, },
   [65]  = { { ILLUSION, 0.20, 3.5 }, { GETERNAL, 0.75, 2.5 }, { LBRILLIANT , 0.05, 1.0 }, },
   [70]  = { { ARCANE  , 0.20, 1.5 }, { LPLANAR , 0.75, 1.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [79]  = { { ARCANE  , 0.20, 1.5 }, { LPLANAR , 0.75, 1.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [85]  = { { ARCANE  , 0.20, 2.5 }, { LPLANAR , 0.75, 2.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [94]  = { { ARCANE  , 0.20, 2.5 }, { LPLANAR , 0.75, 2.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [99]  = { { ARCANE  , 0.20, 2.5 }, { LPLANAR , 0.75, 2.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [115] = { { ARCANE  , 0.20, 3.5 }, { GPLANAR , 0.75, 1.5 }, { LPRISMATIC , 0.05, 1.0 }, },
   [120] = { { ARCANE  , 0.20, 3.5 }, { GPLANAR , 0.75, 1.5 }, { LPRISMATIC , 0.05, 1.0 }, },	-- highest level BC green
  },
  [const.ARMOR] = {
   [15]  = { { STRANGE , 0.80, 1.5 }, { LMAGIC  , 0.20, 1.5 }, },
   [20]  = { { STRANGE , 0.75, 2.5 }, { GMAGIC  , 0.20, 1.5 }, { SGLIMMERING, 0.05, 1.0 }, },
   [25]  = { { STRANGE , 0.75, 5.0 }, { LASTRAL , 0.15, 1.5 }, { SGLIMMERING, 0.10, 1.0 }, },
   [30]  = { { SOUL    , 0.75, 1.5 }, { GASTRAL , 0.20, 1.5 }, { LGLIMMERING, 0.05, 1.0 }, },
   [35]  = { { SOUL    , 0.75, 3.5 }, { LMYSTIC , 0.20, 1.5 }, { SGLOWING   , 0.05, 1.0 }, },
   [40]  = { { VISION  , 0.75, 1.5 }, { GMYSTIC , 0.20, 1.5 }, { LGLOWING   , 0.05, 1.0 }, },
   [45]  = { { VISION  , 0.80, 3.5 }, { LNETHER , 0.15, 1.5 }, { SRADIANT   , 0.05, 1.0 }, },
   [50]  = { { DREAM   , 0.75, 1.5 }, { GNETHER , 0.20, 1.5 }, { LRADIANT   , 0.05, 1.0 }, },
   [55]  = { { DREAM   , 0.75, 3.5 }, { LETERNAL, 0.20, 1.5 }, { SBRILLIANT , 0.05, 1.0 }, },
   [60]  = { { ILLUSION, 0.75, 1.5 }, { GETERNAL, 0.20, 1.5 }, { LBRILLIANT , 0.05, 1.0 }, },
   [65]  = { { ILLUSION, 0.75, 3.5 }, { GETERNAL, 0.20, 2.5 }, { LBRILLIANT , 0.05, 1.0 }, },
   [70]  = { { ARCANE  , 0.80, 1.5 }, { LPLANAR , 0.15, 1.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [79]  = { { ARCANE  , 0.80, 1.5 }, { LPLANAR , 0.15, 1.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [85]  = { { ARCANE  , 0.75, 2.5 }, { LPLANAR , 0.20, 2.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [94]  = { { ARCANE  , 0.75, 2.5 }, { LPLANAR , 0.20, 2.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [99]  = { { ARCANE  , 0.75, 2.5 }, { LPLANAR , 0.20, 2.5 }, { SPRISMATIC , 0.05, 1.0 }, },
   [115] = { { ARCANE  , 0.75, 3.5 }, { GPLANAR , 0.20, 1.5 }, { LPRISMATIC , 0.05, 1.0 }, },
   [120] = { { ARCANE  , 0.75, 3.5 }, { GPLANAR , 0.20, 1.5 }, { LPRISMATIC , 0.05, 1.0 }, },	-- highest level BC green
  },
 },
 [RARE] = {
  [const.WEAPON] = {
   [20]  = { { SGLIMMERING, 1.00, 1.0 }, },
   [25]  = { { SGLIMMERING, 1.00, 1.0 }, },
   [30]  = { { LGLIMMERING, 1.00, 1.0 }, },
   [35]  = { { SGLOWING   , 1.00, 1.0 }, },
   [40]  = { { LGLOWING   , 1.00, 1.0 }, },
   [45]  = { { SRADIANT   , 1.00, 1.0 }, },
   [50]  = { { LRADIANT   , 1.00, 1.0 }, },
   [55]  = { { SBRILLIANT , 1.00, 1.0 }, },
   [60]  = { { LBRILLIANT , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },
   [65]  = { { LBRILLIANT , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },
   [70]  = { { SPRISMATIC , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },
   [79]  = { { SPRISMATIC , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },
   [85]  = { { SPRISMATIC , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },
   [94]  = { { SPRISMATIC , 0.99, 1.0 }, { VOID , 0.01, 1.0 }, },
   [99]  = { { SPRISMATIC , 0.99, 1.0 }, { VOID , 0.01, 1.0 }, },
   [115] = { { LPRISMATIC , 0.99, 1.0 }, { VOID , 0.01, 1.0 }, },	-- highest level BC blue is 115
  },
  [const.ARMOR] = {
   [20]  = { { SGLIMMERING, 1.00, 1.0 }, },
   [25]  = { { SGLIMMERING, 1.00, 1.0 }, },
   [30]  = { { LGLIMMERING, 1.00, 1.0 }, },
   [35]  = { { SGLOWING   , 1.00, 1.0 }, },
   [40]  = { { LGLOWING   , 1.00, 1.0 }, },
   [45]  = { { SRADIANT   , 1.00, 1.0 }, },
   [50]  = { { LRADIANT   , 1.00, 1.0 }, },
   [55]  = { { SBRILLIANT , 1.00, 1.0 }, },
   [60]  = { { LBRILLIANT , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },
   [65]  = { { LBRILLIANT , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },
   [70]  = { { SPRISMATIC , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },	-- this is for pre-BC items, there is some overlap 66-70
   [79]  = { { SPRISMATIC , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },
   [85]  = { { SPRISMATIC , 0.99, 1.0 }, { NEXUS, 0.01, 1.0 }, },
   [94]  = { { SPRISMATIC , 0.99, 1.0 }, { VOID , 0.01, 1.0 }, },
   [99]  = { { SPRISMATIC , 0.99, 1.0 }, { VOID , 0.01, 1.0 }, },
   [115] = { { LPRISMATIC , 0.99, 1.0 }, { VOID , 0.01, 1.0 }, },	-- highest level BC blue
  },
 },
 [EPIC] = {
  [const.WEAPON] = {
   [40]  = { { SRADIANT  , 1.00, 3.0 }, },
   [45]  = { { SRADIANT  , 1.00, 3.5 }, },
   [50]  = { { LRADIANT  , 1.00, 3.5 }, },
   [55]  = { { SBRILLIANT, 1.00, 3.5 }, },
   [60]  = { { NEXUS     , 1.00, 1.0 }, },
   [65]  = { { NEXUS     , 1.00, 1.5 }, },
   [70]  = { { NEXUS     , 1.00, 1.5 }, },
   [79]  = { { NEXUS     , 1.00, 1.5 }, },
   [85]  = { { NEXUS     , 1.00, 1.5 }, },
   [94]  = { { NEXUS     , 1.00, 1.5 }, },	-- BC gear appears to start at 95
   [99]  = { { VOID      , 1.00, 1.0 }, },
   [115] = { { VOID      , 1.00, 1.5 }, },
   [120] = { { VOID      , 1.00, 1.5 }, },
   [164] = { { VOID      , 1.00, 1.5 }, },	-- highest level BC epic
  },
  [const.ARMOR] = {
   [40]  = { { SRADIANT  , 1.00, 3.0 }, },
   [45]  = { { SRADIANT  , 1.00, 3.5 }, },
   [50]  = { { LRADIANT  , 1.00, 3.5 }, },
   [55]  = { { SBRILLIANT, 1.00, 3.5 }, },
   [60]  = { { NEXUS     , 1.00, 1.0 }, },
   [65]  = { { NEXUS     , 1.00, 1.5 }, },
   [70]  = { { NEXUS     , 1.00, 1.5 }, },
   [79]  = { { NEXUS     , 1.00, 1.5 }, },
   [85]  = { { NEXUS     , 1.00, 1.5 }, },
   [94]  = { { NEXUS     , 1.00, 1.5 }, },	-- BC gear appears to start at 95
   [99]  = { { VOID      , 1.00, 1.0 }, },
   [115] = { { VOID      , 1.00, 1.5 }, },
   [120] = { { VOID      , 1.00, 1.5 }, },
   [164] = { { VOID      , 1.00, 1.5 }, },	-- highest level BC epic
  },
 },
}



local COPPER_ORE = 2770
local TIN_ORE = 2771
local IRON_ORE = 2772
local MITHRIL_ORE = 3858
local THORIUM_ORE = 10620
local FEL_IRON_ORE = 23424
local ADAMANTITE_ORE = 23425

local COPPERPOWDER = 24186
local TINPOWDER = 24188
local IRONPOWDER = 24190
local MITHRILPOWDER = 24234
local THORIUMPOWDER = 24235
local FELIRONPOWDER = 24242
local ADAMANTITEPOWDER = 24243

local TIGERSEYE = 818
local MALACHITE = 774
local SHADOWGEM = 1210
local LESSERMOONSTONE = 1705
local MOSSAGATE = 1206
local CITRINE = 3864
local JADE = 1529
local AQUAMARINE = 7909
local STARRUBY = 7910
local AZEROTHIANDIAMOND = 12800
local BLUESAPPHIRE = 12361
local LARGEOPAL = 12799
local HUGEEMERALD = 12364
local BLOODGARNET = 23077
local FLAMESPESSARITE = 21929
local GOLDENDRAENITE = 23112
local DEEPPERIDOT = 23079
local AZUREMOONSTONE = 23117
local SHADOWDRAENITE = 23107
local LIVINGRUBY = 23436
local NOBLETOPAZ = 23439
local DAWNSTONE = 23440
local TALASITE = 23437
local STAROFELUNE = 23438
local NIGHTSEYE = 23441


--[[
	Prospectable ores
	percentages from Wowhead
	last updated Fed 16, 2008
]]

const.ProspectMinLevels = {
	[COPPER_ORE] = 20,
	[TIN_ORE] = 50,
	[IRON_ORE] = 125,
	[MITHRIL_ORE] = 175,
	[THORIUM_ORE] = 250,
	[FEL_IRON_ORE] = 275,
	[ADAMANTITE_ORE] = 325,
}


const.ProspectableItems = {

	[COPPER_ORE] = {
			[COPPERPOWDER] = 1.0,
			[TIGERSEYE] = 0.5,
			[MALACHITE] = 0.5,
			[SHADOWGEM] = 0.1,
			},

	[TIN_ORE] = {
			[TINPOWDER] = 1.0,
			[SHADOWGEM] = 0.375,
			[LESSERMOONSTONE] = 0.375,
			[MOSSAGATE] = 0.375,
			[CITRINE] = 0.033,
			[JADE] = 0.033,
			[AQUAMARINE] = 0.033,
			},

	[IRON_ORE] = {
			[IRONPOWDER] = 1.0,
			[CITRINE] = 0.30,
			[LESSERMOONSTONE] = 0.33,
			[JADE] = 0.33,
			[AQUAMARINE] = 0.05,
			[STARRUBY] = 0.05,
			},

	[MITHRIL_ORE] = {
			[MITHRILPOWDER] = 1.0,
			[CITRINE] = 0.33,
			[STARRUBY] = 0.33,
			[AQUAMARINE] = 0.33,
			[AZEROTHIANDIAMOND] = 0.03,
			[BLUESAPPHIRE] = 0.03,
			[LARGEOPAL] = 0.03,
			[HUGEEMERALD] = 0.03,
			},

	[THORIUM_ORE] = {
			[THORIUMPOWDER] = 1.0,
			[STARRUBY] = 0.26,
			[LARGEOPAL] = 0.19,
			[BLUESAPPHIRE] = 0.19,
			[AZEROTHIANDIAMOND] = 0.19,
			[HUGEEMERALD] = 0.19,
			[BLOODGARNET] = 0.01,
			[FLAMESPESSARITE] = 0.01,
			[GOLDENDRAENITE] = 0.01,
			[DEEPPERIDOT] = 0.01,
			[AZUREMOONSTONE] = 0.01,
			[SHADOWDRAENITE] = 0.01,
			},

	[FEL_IRON_ORE] = {
			[FELIRONPOWDER] = 1.0,
			[BLOODGARNET] = 0.17,
			[FLAMESPESSARITE] = 0.17,
			[GOLDENDRAENITE] = 0.17,
			[DEEPPERIDOT] = 0.17,
			[AZUREMOONSTONE] = 0.17,
			[SHADOWDRAENITE] = 0.17,
			[LIVINGRUBY] = 0.011,
			[NOBLETOPAZ] = 0.011,
			[DAWNSTONE] = 0.011,
			[TALASITE] = 0.011,
			[STAROFELUNE] = 0.011,
			[NIGHTSEYE] = 0.011,
			},

	[ADAMANTITE_ORE] = {
			[ADAMANTITEPOWDER] = 1.0,
			[BLOODGARNET] = 0.19,
			[FLAMESPESSARITE] = 0.19,
			[GOLDENDRAENITE] = 0.19,
			[DEEPPERIDOT] = 0.19,
			[AZUREMOONSTONE] = 0.19,
			[SHADOWDRAENITE] = 0.19,
			[LIVINGRUBY] = 0.03,
			[NOBLETOPAZ] = 0.03,
			[DAWNSTONE] = 0.03,
			[TALASITE] = 0.03,
			[STAROFELUNE] = 0.03,
			[NIGHTSEYE] = 0.03,
			},
}

-- reagents that have no use, sell to vendor, and thus get vendor prices
const.VendorTrash =  {
	[COPPERPOWDER] = true,
	[TINPOWDER] = true,
	[IRONPOWDER] = true,
	[MITHRILPOWDER] = true,
	[THORIUMPOWDER] = true,
	[FELIRONPOWDER] = true,
}


-- needed because GetItemInfo fails when items are not in the user's cache
const.BackupReagentItemInfo = {
	[10939] = "Greater Magic Essence#|cff1eff00|Hitem:10939:0:0:0:0:0:0:0|h[Greater Magic Essence]|h|r#2#15#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
	[10940] = "Strange Dust#|cffffffff|Hitem:10940:0:0:0:0:0:0:0|h[Strange Dust]|h|r#1#10#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_DustStrange",
	[12799] = "Large Opal#|cff1eff00|Hitem:12799:0:0:0:0:0:0:0|h[Large Opal]|h|r#2#55#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Opal_01",
	[22446] = "Greater Planar Essence#|cff1eff00|Hitem:22446:0:0:0:0:0:0:0|h[Greater Planar Essence]|h|r#2#65#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceArcaneLarge",
	[1529] = "Jade#|cff1eff00|Hitem:1529:0:0:0:0:0:0:0|h[Jade]|h|r#2#35#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Stone_01",
	[14344] = "Large Brilliant Shard#|cff0070dd|Hitem:14344:0:0:0:0:0:0:0|h[Large Brilliant Shard]|h|r#3#55#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardBrilliantLarge",
	[22449] = "Large Prismatic Shard#|cff0070dd|Hitem:22449:0:0:0:0:0:0:0|h[Large Prismatic Shard]|h|r#3#70#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardPrismaticLarge",
	[22450] = "Void Crystal#|cffa335ee|Hitem:22450:0:0:0:0:0:0:0|h[Void Crystal]|h|r#4#70#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_VoidCrystal",
	[12361] = "Blue Sapphire#|cff1eff00|Hitem:12361:0:0:0:0:0:0:0|h[Blue Sapphire]|h|r#2#55#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Sapphire_02",
	[24235] = "Thorium Powder#|cff9d9d9d|Hitem:24235:0:0:0:0:0:0:0|h[Thorium Powder]|h|r#0#50#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Misc_Powder_Thorium",
	[24234] = "Mithril Powder#|cff9d9d9d|Hitem:24234:0:0:0:0:0:0:0|h[Mithril Powder]|h|r#0#30#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Misc_Powder_Mithril",
	[11134] = "Lesser Mystic Essence#|cff1eff00|Hitem:11134:0:0:0:0:0:0:0|h[Lesser Mystic Essence]|h|r#2#30#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceMysticalSmall",
	[22447] = "Lesser Planar Essence#|cff1eff00|Hitem:22447:0:0:0:0:0:0:0|h[Lesser Planar Essence]|h|r#2#60#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceArcaneSmall",
	[11135] = "Greater Mystic Essence#|cff1eff00|Hitem:11135:0:0:0:0:0:0:0|h[Greater Mystic Essence]|h|r#2#35#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceMysticalLarge",
	[12364] = "Huge Emerald#|cff1eff00|Hitem:12364:0:0:0:0:0:0:0|h[Huge Emerald]|h|r#2#60#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Emerald_01",
	[12800] = "Azerothian Diamond#|cff1eff00|Hitem:12800:0:0:0:0:0:0:0|h[Azerothian Diamond]|h|r#2#60#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Diamond_01",
	[16202] = "Lesser Eternal Essence#|cff1eff00|Hitem:16202:0:0:0:0:0:0:0|h[Lesser Eternal Essence]|h|r#2#50#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceEternalSmall",
	[11137] = "Vision Dust#|cffffffff|Hitem:11137:0:0:0:0:0:0:0|h[Vision Dust]|h|r#1#35#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_DustVision",
	[10978] = "Small Glimmering Shard#|cff0070dd|Hitem:10978:0:0:0:0:0:0:0|h[Small Glimmering Shard]|h|r#3#20#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardGlimmeringSmall",
	[11138] = "Small Glowing Shard#|cff0070dd|Hitem:11138:0:0:0:0:0:0:0|h[Small Glowing Shard]|h|r#3#30#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardGlowingSmall",
	[23077] = "Blood Garnet#|cff1eff00|Hitem:23077:0:0:0:0:0:0:0|h[Blood Garnet]|h|r#2#65#0#Gem#Red#20##Interface\\Icons\\INV_Misc_Gem_BloodGem_03",
	[11139] = "Large Glowing Shard#|cff0070dd|Hitem:11139:0:0:0:0:0:0:0|h[Large Glowing Shard]|h|r#3#35#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardGlowingLarge",
	[3864] = "Citrine#|cff1eff00|Hitem:3864:0:0:0:0:0:0:0|h[Citrine]|h|r#2#40#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Opal_02",
	[23079] = "Deep Peridot#|cff1eff00|Hitem:23079:0:0:0:0:0:0:0|h[Deep Peridot]|h|r#2#65#0#Gem#Green#20##Interface\\Icons\\INV_Misc_Gem_DeepPeridot_03",
	[21929] = "Flame Spessarite#|cff1eff00|Hitem:21929:0:0:0:0:0:0:0|h[Flame Spessarite]|h|r#2#65#0#Gem#Orange#20##Interface\\Icons\\INV_Misc_Gem_FlameSpessarite_03",
	[23107] = "Shadow Draenite#|cff1eff00|Hitem:23107:0:0:0:0:0:0:0|h[Shadow Draenite]|h|r#2#65#0#Gem#Purple#20##Interface\\Icons\\INV_Misc_Gem_EbonDraenite_03",
	[23441] = "Nightseye#|cff0070dd|Hitem:23441:0:0:0:0:0:0:0|h[Nightseye]|h|r#3#70#0#Gem#Purple#20##Interface\\Icons\\INV_Jewelcrafting_Nightseye_02",
	[818] = "Tigerseye#|cff1eff00|Hitem:818:0:0:0:0:0:0:0|h[Tigerseye]|h|r#2#15#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Opal_03",
	[11174] = "Lesser Nether Essence#|cff1eff00|Hitem:11174:0:0:0:0:0:0:0|h[Lesser Nether Essence]|h|r#2#40#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceNetherSmall",
	[24242] = "Fel Iron Powder#|cff9d9d9d|Hitem:24242:0:0:0:0:0:0:0|h[Fel Iron Powder]|h|r#0#60#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Misc_Powder_Feliron",
	[11175] = "Greater Nether Essence#|cff1eff00|Hitem:11175:0:0:0:0:0:0:0|h[Greater Nether Essence]|h|r#2#45#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceNetherLarge",
	[11178] = "Large Radiant Shard#|cff0070dd|Hitem:11178:0:0:0:0:0:0:0|h[Large Radiant Shard]|h|r#3#45#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardRadientLarge",
	[11176] = "Dream Dust#|cffffffff|Hitem:11176:0:0:0:0:0:0:0|h[Dream Dust]|h|r#1#45#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_DustDream",
	[11082] = "Greater Astral Essence#|cff1eff00|Hitem:11082:0:0:0:0:0:0:0|h[Greater Astral Essence]|h|r#2#25#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceAstralLarge",
	[11177] = "Small Radiant Shard#|cff0070dd|Hitem:11177:0:0:0:0:0:0:0|h[Small Radiant Shard]|h|r#3#40#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardRadientSmall",
	[11083] = "Soul Dust#|cffffffff|Hitem:11083:0:0:0:0:0:0:0|h[Soul Dust]|h|r#1#25#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_DustSoul",
	[24243] = "Adamantite Powder#|cffffffff|Hitem:24243:0:0:0:0:0:0:0|h[Adamantite Powder]|h|r#1#70#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Misc_Powder_Adamantite",
	[11084] = "Large Glimmering Shard#|cff0070dd|Hitem:11084:0:0:0:0:0:0:0|h[Large Glimmering Shard]|h|r#3#25#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardGlimmeringLarge",
	[16204] = "Illusion Dust#|cffffffff|Hitem:16204:0:0:0:0:0:0:0|h[Illusion Dust]|h|r#1#55#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_DustIllusion",
	[23112] = "Golden Draenite#|cff1eff00|Hitem:23112:0:0:0:0:0:0:0|h[Golden Draenite]|h|r#2#65#0#Gem#Yellow#20##Interface\\Icons\\INV_Misc_Gem_GoldenDraenite_03",
	[22445] = "Arcane Dust#|cffffffff|Hitem:22445:0:0:0:0:0:0:0|h[Arcane Dust]|h|r#1#60#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_DustArcane",
	[23436] = "Living Ruby#|cff0070dd|Hitem:23436:0:0:0:0:0:0:0|h[Living Ruby]|h|r#3#70#0#Gem#Red#20##Interface\\Icons\\INV_Jewelcrafting_LivingRuby_02",
	[24186] = "Copper Powder#|cff9d9d9d|Hitem:24186:0:0:0:0:0:0:0|h[Copper Powder]|h|r#0#10#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Misc_Powder_Copper",
	[23117] = "Azure Moonstone#|cff1eff00|Hitem:23117:0:0:0:0:0:0:0|h[Azure Moonstone]|h|r#2#65#0#Gem#Blue#20##Interface\\Icons\\INV_Misc_Gem_AzureDraenite_03",
	[24188] = "Tin Powder#|cff9d9d9d|Hitem:24188:0:0:0:0:0:0:0|h[Tin Powder]|h|r#0#10#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Misc_Powder_Tin",
	[20725] = "Nexus Crystal#|cffa335ee|Hitem:20725:0:0:0:0:0:0:0|h[Nexus Crystal]|h|r#4#60#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardNexusLarge",
	[24190] = "Iron Powder#|cff9d9d9d|Hitem:24190:0:0:0:0:0:0:0|h[Iron Powder]|h|r#0#30#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Misc_Powder_Iron",
	[14343] = "Small Brilliant Shard#|cff0070dd|Hitem:14343:0:0:0:0:0:0:0|h[Small Brilliant Shard]|h|r#3#50#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardBrilliantSmall",
	[1705] = "Lesser Moonstone#|cff1eff00|Hitem:1705:0:0:0:0:0:0:0|h[Lesser Moonstone]|h|r#2#30#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Crystal_01",
	[23437] = "Talasite#|cff0070dd|Hitem:23437:0:0:0:0:0:0:0|h[Talasite]|h|r#3#70#0#Gem#Green#20##Interface\\Icons\\INV_Jewelcrafting_Talasite_02",
	[23438] = "Star of Elune#|cff0070dd|Hitem:23438:0:0:0:0:0:0:0|h[Star of Elune]|h|r#3#70#0#Gem#Blue#20##Interface\\Icons\\INV_Jewelcrafting_StarOfElune_02",
	[23439] = "Noble Topaz#|cff0070dd|Hitem:23439:0:0:0:0:0:0:0|h[Noble Topaz]|h|r#3#70#0#Gem#Orange#20##Interface\\Icons\\INV_Jewelcrafting_NobleTopaz_02",
	[23440] = "Dawnstone#|cff0070dd|Hitem:23440:0:0:0:0:0:0:0|h[Dawnstone]|h|r#3#70#0#Gem#Yellow#20##Interface\\Icons\\INV_Jewelcrafting_Dawnstone_02",
	[7909] = "Aquamarine#|cff1eff00|Hitem:7909:0:0:0:0:0:0:0|h[Aquamarine]|h|r#2#45#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Crystal_02",
	[10998] = "Lesser Astral Essence#|cff1eff00|Hitem:10998:0:0:0:0:0:0:0|h[Lesser Astral Essence]|h|r#2#20#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceAstralSmall",
	[1206] = "Moss Agate#|cff1eff00|Hitem:1206:0:0:0:0:0:0:0|h[Moss Agate]|h|r#2#25#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Misc_Gem_Emerald_02",
	[774] = "Malachite#|cff1eff00|Hitem:774:0:0:0:0:0:0:0|h[Malachite]|h|r#2#7#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Emerald_03",
	[7910] = "Star Ruby#|cff1eff00|Hitem:7910:0:0:0:0:0:0:0|h[Star Ruby]|h|r#2#50#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Ruby_02",
	[1210] = "Shadowgem#|cff1eff00|Hitem:1210:0:0:0:0:0:0:0|h[Shadowgem]|h|r#2#20#0#Gem#Simple#20##Interface\\Icons\\INV_Misc_Gem_Amethyst_01",
	[16203] = "Greater Eternal Essence#|cff1eff00|Hitem:16203:0:0:0:0:0:0:0|h[Greater Eternal Essence]|h|r#2#55#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceEternalLarge",
	[10938] = "Lesser Magic Essence#|cff1eff00|Hitem:10938:0:0:0:0:0:0:0|h[Lesser Magic Essence]|h|r#2#10#0#Trade Goods#Trade Goods#10##Interface\\Icons\\INV_Enchant_EssenceMagicSmall",
	[22448] = "Small Prismatic Shard#|cff0070dd|Hitem:22448:0:0:0:0:0:0:0|h[Small Prismatic Shard]|h|r#3#65#0#Trade Goods#Trade Goods#20##Interface\\Icons\\INV_Enchant_ShardPrismaticSmall",
}

