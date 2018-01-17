


local private = {

}

local _, class = UnitClass("player")

function private.onEvent(frame, event, arg1, arg2, arg3, ...)

	if (event == "ADDON_LOADED" and arg1 == "ZodsManaBar" and class == "DRUID") then

		LibStub("LibDruidMana-1.0"):AddListener(function(currMana, maxMana)
			ZManaBar:SetMinMaxValues(0,maxMana);
			ZManaBar:SetValue(currMana);
		end)

	else
		--unhandled onEvent
	end
end


private.scriptframe = CreateFrame("Frame")
private.scriptframe:RegisterEvent("ADDON_LOADED")
private.scriptframe:SetScript("OnEvent", private.onEvent)


if class == "DRUID" then
	local bar = CreateFrame("StatusBar", "ZManaBar", UIParent);
	bar:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 2, 26);
	bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	bar:SetWidth(116);
	bar:SetHeight(16);
	bar:SetStatusBarColor(0,0.2,1)
	bar:SetMinMaxValues(0,100);
	bar:SetFrameStrata("MEDIUM")
	bar:SetFrameLevel(8)
	bar:Show();
end




