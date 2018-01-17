

eventPostFrame = CreateFrame("FRAME", "FooAddonFrame");
local function eH(self, event, ...)
	 if string.find(event,searchWord) then
		 DEFAULT_CHAT_FRAME:AddMessage(event)
		 DEFAULT_CHAT_FRAME:AddMessage("1:"..arg1.." 2:"..(arg2 or "").. " 3:".. (arg3 or "").. " 4:"..(arg4 or "").. " 5:"..(arg5 or "")..
			" 6:"..(arg6 or "").. " 7:"..(arg7 or "").. " 8:"..(arg8 or "").. " 9:"..(arg9 or "").. " 10:"..(arg10 or "").. " 11:"..(arg11 or "").. 
			" 12:"..(arg12 or "").. " 13:"..(arg13 or "").. " 14:"..(arg14 or "").. " 15:"..(arg15 or "").. " 16:"..(arg16 or ""))
	end
end 
eventPostFrame:SetScript("OnEvent", eH);


local private = {
	wf = 0,
	wfTotal = 0,
	wfLastTime = 0,
	playerName = UnitName("player"),
	}
	
if not zodsDB then
	zodsDB = {}
end

function private.onUpdate()
	local t = GetTime()
	local wfTime = 2 + private.wfLastTime - t
	if wfTime < 0 then
		ztimer:Hide()
	else
		ztimer:Show()
		ztimer:SetValue(wfTime*50)
	end
end

function private.onEvent(frame, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16, ...)
	if (event == "PLAYER_MONEY") then
		private.wealth = GetMoney()
		private.playerData["wealth"] = private.wealth
	elseif (event == "PLAYER_ENTERING_WORLD") then 

		
	elseif (event == "ADDON_LOADED") then
		if arg1 == "zods" then

		end
		elseif (event == "CHAT_MSG_PARTY") then
			--DEFAULT_CHAT_FRAME:AddMessage("partry chat")
			--LootSlot(1)
			--LootSlot(2)
			--LootSlot(3)
			--LootSlot(4)
	elseif ((event == "COMBAT_LOG_EVENT_UNFILTERED") or (event == "COMBAT_LOG_EVENT")) then
		--DEFAULT_CHAT_FRAME:AddMessage("1:"..arg1.." 2:"..(arg2 or "").. " 3:".. (arg3 or "").. " 4:"..(arg4 or "").. " 5:"..(arg5 or "")..
		--" 6:"..(arg6 or "").. " 7:"..(arg7 or "").. " 8:"..(arg8 or "").. " 9:"..(arg9 or "").. " 10:"..(arg10 or "").. " 11:"..(arg11 or "").. 
		--" 12:"..(arg12 or "").. " 13:"..(arg13 or "").. " 14:"..(arg14 or "").. " 15:"..(arg15 or "").. " 16:"..(arg16 or ""))
		
		if (arg2=="SPELL_DAMAGE"  or arg2=="SPELL_MISSED") and arg4==private.playerName and arg10 =="Windfury Attack" then
			if (arg2 == "SPELL_DAMAGE") then
				private.wfTotal = private.wfTotal + arg12
			end
			if private.wf == 1 then
				
				DEFAULT_CHAT_FRAME:AddMessage("WF for " .. private.wfTotal .. " last was " .. (GetTime()-private.wfLastTime) .. " ago")
				private.wfLastTime = GetTime()
				private.wfTotal = 0
			end
			
			private.wf = 1 - private.wf
		end
		if (arg2=="SPELL_HEALL") then
			if arg4==private.playerName then
				if not zodsDB[arg9] then
					zodsDB[arg9] = {}
				end
				
				if arg13 then
					--crit
					if not zodsDB[arg9].crit then
						zodsDB[arg9].crit = 
						{
						count = 1,
						_min = arg12,
						_max = arg12
						}
					else
						zodsDB[arg9].crit.count = zodsDB[arg9].crit.count +1
						if arg12 > zodsDB[arg9].crit._max then
							zodsDB[arg9].crit._max = arg12
						end
						if arg12 < zodsDB[arg9].crit._min then
							zodsDB[arg9].crit._min = arg12
						end
					end
				else
					--noncrit
					if not zodsDB[arg9].hit then
						zodsDB[arg9].hit = 
						{
						count = 1,
						_min = arg12,
						_max = arg12
						}
					else
						zodsDB[arg9].hit.count = zodsDB[arg9].hit.count +1
						if arg12 > zodsDB[arg9].hit._max then
							zodsDB[arg9].hit._max = arg12
						end
						if arg12 < zodsDB[arg9].hit._min then
							zodsDB[arg9].hit._min = arg12
						end
					end
				end
			end
		
		
		
		end
	
	else
		DEFAULT_CHAT_FRAME:AddMessage("unhandled onEvent")
	end
end

ztimer = CreateFrame("StatusBar", "zodsThing")

ztimer:SetOrientation("HORIZONTAL")
ztimer:SetMinMaxValues(0, 100)
ztimer:SetValue(20)
ztimer:SetStatusBarColor(0,0,0.8)
ztimer:SetWidth(80)
ztimer:SetHeight(20)
ztimer:SetPoint("CENTER", 86, -123)
ztimer:SetStatusBarTexture("Interface\\Addons\\Grid\\gradient32x32")
ztimer:Show()

function Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end


--[[Bootstrap Code]]
private.scriptframe = CreateFrame("Frame")
private.scriptframe:RegisterEvent("ADDON_LOADED")
private.scriptframe:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
private.scriptframe:RegisterEvent("CHAT_MSG_PARTY")


--private.scriptframe:RegisterEvent("COMBAT_LOG_EVENT")
--private.scriptframe:RegisterAllEvents()
private.scriptframe:SetScript("OnEvent", private.onEvent)
private.scriptframe:SetScript("OnUpdate", private.onUpdate)


function reportActionButtons()
	local lActionSlot = 0;
	for lActionSlot = 1, 120 do
		local lActionText = GetActionText(lActionSlot);
		local lActionTexture = GetActionTexture(lActionSlot);
		if lActionTexture then
			local lMessage = "Slot " .. lActionSlot .. ": [" .. lActionTexture .. "]";
			if lActionText then
				lMessage = lMessage .. " \"" .. lActionText .. "\"";
			end
			DEFAULT_CHAT_FRAME:AddMessage(lMessage);
		end
	end
end



--- slash handler
SLASH_ZOD1 = "/zod"
SlashCmdList["ZOD"] = function(msg)
	if (msg=="print") then
			for i,v in pairs(zodsDB) do
				DEFAULT_CHAT_FRAME:AddMessage(i.." ")
				if v.hit then
					DEFAULT_CHAT_FRAME:AddMessage(v.hit._min.." "..v.hit._max.." "..v.hit.count)
				end
				if v.crit then
					DEFAULT_CHAT_FRAME:AddMessage(v.crit._min.." "..v.crit._max.." "..v.crit.count)
				end
			end
	elseif (msg=="clear") then
		zodsDB = {}
		DEFAULT_CHAT_FRAME:AddMessage("DB erased")
	elseif (string.find(msg, "events")) then
		searchWord = string.sub(msg,8)
		DEFAULT_CHAT_FRAME:AddMessage("finding "..searchWord )
		eventPostFrame:RegisterAllEvents();
	elseif (msg=="stop") then
		DEFAULT_CHAT_FRAME:AddMessage("done finding events")
		eventPostFrame:UnregisterAllEvents();
		searchWord = "none"
	elseif (msg=="loot") then
		DEFAULT_CHAT_FRAME:AddMessage("looting")
		LootSlot(1)
		LootSlot(2)
		LootSlot(3)
		LootSlot(4)
	else 
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
end

searchWord = "none"

zf1 = CreateFrame("Button","A_TEXTURE",UIParent)


	zf1:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, 20)
	zf1:SetWidth(100)
	zf1:SetHeight(100)
	zf1.texture = zf1:CreateTexture()
	zf1.texture:SetTexture("Interface\\Icons\\Spell_Shadow_ShadowWordPain")
	zf1.texture:SetPoint("TOPLEFT", zf1, "TOPLEFT", 4, -4)
	zf1.texture:SetPoint("BOTTOMRIGHT", zf1, "BOTTOMRIGHT", -4, 4)
	zf1:Show()
	zf1.texture:Show()

