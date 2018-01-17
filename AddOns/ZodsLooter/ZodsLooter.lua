


local private = {

}
	

function private.onUpdate()

end


function private.onEvent(frame, event, arg1, arg2, arg3, ...)

	if (event == "CHAT_MSG_PARTY" and arg1 == zloot_saved.phrase) then
		local numItems = 0
		local item = GetLootSlotInfo(numItems + 1) 
		while item do
			numItems = numItems + 1
			item = GetLootSlotInfo(numItems + 1) 
		end
		for i = 1,numItems do
			LootSlot(i) 
		end
		
	elseif (event == "ADDON_LOADED" and arg1 == "ZodsLooter") then
		if zloot_saved == nil then 
			zloot_saved = {
				phrase = "k",
				on = true
			}
		end
		if zloot_saved.on == true then
				private.scriptframe:RegisterEvent("CHAT_MSG_PARTY")
		end
	else
		--unhandled onEvent
	end
end





private.scriptframe = CreateFrame("Frame")
private.scriptframe:RegisterEvent("ADDON_LOADED")
private.scriptframe:SetScript("OnEvent", private.onEvent)
--private.scriptframe:SetScript("OnUpdate", private.onUpdate)




--- slash handler
SLASH_ZLOOT1 = "/zloot"
SlashCmdList["ZLOOT"] = function(msg)
	local command = msg:match("^[^ ]+")
	local arg1 = msg:sub(string.len(command) + 2)
	
	if (command == "off") then
		private.scriptframe:UnregisterEvent("CHAT_MSG_PARTY")
		DEFAULT_CHAT_FRAME:AddMessage("disabled looting")
		zloot_saved.on = false
		
	elseif (command == "on") then
		private.scriptframe:RegisterEvent("CHAT_MSG_PARTY")
		DEFAULT_CHAT_FRAME:AddMessage("enabled looting")
		zloot_saved.on = true
		
	elseif (command == "phrase" and arg1) then
		if string.len(arg1) == 0 then
			DEFAULT_CHAT_FRAME:AddMessage("phrase is " .. zloot_saved.phrase)
		else
			zloot_saved.phrase = arg1
			DEFAULT_CHAT_FRAME:AddMessage("phrase set to " .. arg1)
		end
	elseif (command == "mote" and arg1) then
		private.MotePath(arg1)
	else 
		--unhandled slash command
		DEFAULT_CHAT_FRAME:AddMessage("commands are: off, on, phrase <new phase>, mote <element>")
	end
end

local MOTE_NODES = {
	["water"] = {
		{x=.098, y=.519   },
		{x=.160, y=.202   },
		{x=.304, y=.211   },
		{x=.327, y=.306   },
		{x=.316, y=.326   },
		{x=.326, y=.383   },
		{x=.345, y=.425   },
		{x=.300, y=.502   },
		{x=.246, y=.569   },
		{x=.466, y=.581   },
		{x=.587, y=.526   },
		{x=.605, y=.548   },
		{x=.639, y=.665   },
		{x=.655, y=.732   },
		{x=.856, y=.495   },
		{x=.783, y=.793   },
		{x=.753, y=.838   },
	},
	["shadow"] = {
		{x=.622, y=.638  },
		{x=.645, y=.615  },
		{x=.613, y=.583  },
		{x=.560, y=.539  },
		{x=.540, y=.502  },
		{x=.573, y=.470  },
		{x=.634, y=.463  },
		{x=.624, y=.372  },
		{x=.571, y=.191  },
		{x=.513, y=.203  },
		{x=.533, y=.341  },
		{x=.492, y=.337  },
		{x=.451, y=.381  },
		{x=.462, y=.472  },
		{x=.434, y=.493  },
		{x=.411, y=.418  },
		{x=.343, y=.342  },
		{x=.329, y=.371  },
		{x=.309, y=.457  },
		{x=.303, y=.453  },
	},
	["mana"] = {
		{x=.568, y=.328   } ,
		{x=.699, y=.440   } ,
		{x=.643, y=.580   } ,
		{x=.501, y=.600   } ,
		{x=.403, y=.627   } ,
		{x=.326, y=.657   } ,
	},
	["Zones"] = {
		["shadow"] = "Shadowmoon Valley",
		["water"] = "Zangarmarsh",
		["mana"] = "Netherstorm",
	},
}





local function clearQueue()
	for i, v in ipairs(Cartographer_Waypoints.Queue) do
		v:Cancel()
	end
end

function private.MotePath(element)
	clearQueue() 
	local zone = MOTE_NODES.Zones[element]
	for i, v in ipairs(MOTE_NODES[element]) do
		waypoint = NotePoint:new(zone, v.x, v.y, element)
		Cartographer_Waypoints:AddWaypoint(waypoint)
	end
	
end

function ps(energy)
	local f="Cat Form";f=GetSpellCooldown(f)>0 or UnitMana('player')>energy or not IsUsableSpell(f) or CancelPlayerBuff(f)
end






