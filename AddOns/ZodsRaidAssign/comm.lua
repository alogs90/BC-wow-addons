function ZodsRaidAssign:HandleRemoteData(data, name)
	DEFAULT_CHAT_FRAME:AddMessage(data.." "..name)
end