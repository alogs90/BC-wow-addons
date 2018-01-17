
--local RL = AceLibrary("Roster-2.1")

local private = {

}
	

function private.onUpdate()

end


function private.onEvent(frame, event, arg1, arg2, arg3, ...)

	if (event == "ADDON_LOADED" and arg1 == "ZodsRaidAssign") then
		private.onLoad()
		
	elseif event == "ree" then


	else
		--unhandled onEvent
		--DEFAULT_CHAT_FRAME:AddMessage(event..(arg1 or ""))
	end
end

local backdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4},
}
function private.onLoad()
local f = CreateFrame("Frame", "ZRALayoutFrame", UIParent)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:SetClampedToScreen(true)
	f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, 20)
	f:SetScript("OnMouseUp", f.StopMovingOrSizing)
	f:SetScript("OnHide", f.StopMovingOrSizing)
	f:SetScript("OnMouseDown", f.StartMoving)
	f:SetFrameStrata("MEDIUM")
	f:SetWidth(700)
	f:SetHeight(500)
	-- create background
	f:SetFrameLevel(0)
	
	f:SetBackdrop(backdrop)
	-- create bg texture
	f.texture = f:CreateTexture(nil, "BORDER")
	f.texture:SetTexture(0,0,.5,.5)
	f.texture:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -4)
	f.texture:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 4)
	f.texture:SetBlendMode("ADD")
	f.texture:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .2, .2, .2, 0.5)
	f:SetBackdropColor(.3,.3,.3,.3)
	f:Show()
	
	f.roleFrames = {}
	f.busy_roleframes = 0
	
	f.playerFrames = {}
	f.busy_playerFrames = 0
	
	f.catcherFrames = {}
	f.busy_catcherFrames = 0
	
	f.roleMemberFrames = {}
	f.busy_roleMemberFrames = 0
	
	f.usedSpaceX = 0
	
	--close button
	local closebutton = CreateFrame("Button",nil,f,"UIPanelCloseButton")
	closebutton:SetScript("OnClick", private.closeOnClick)
	closebutton:SetPoint("TOPRIGHT",f,"TOPRIGHT",-2,-2)
	f.closebutton = closebutton
	closebutton.obj = f
	
	-- create the options frame
	local o = CreateFrame("Frame", "ZOptionsFrame", UIParent)
	o:SetPoint("CENTER", f, "CENTER", -20, 20)
	o:SetFrameStrata("MEDIUM")
	o:SetWidth(200)
	o:SetFrameStrata("HIGH") 
	o:SetHeight(300)
	o:SetFrameLevel(0)
	o:SetBackdrop(backdrop)
	o.texture = o:CreateTexture(nil, "BORDER")
	o.texture:SetTexture(.5,.5,.5,.75)
	o.texture:SetPoint("TOPLEFT", o, "TOPLEFT", 4, -4)
	o.texture:SetPoint("BOTTOMRIGHT", o, "BOTTOMRIGHT", -4, 4)
	o:SetBackdropColor(.3,.3,.3,.3)
	o:Hide()
	o.selectframes = {}
	o.stringframes = {}
	o.labelframes = {}
	o.editboxes = {}
	
	--drag frame		
	local dragframe = CreateFrame("Button", "ZDragframe", ZRALayoutFrame);

	dragframe:SetWidth(30);
	dragframe:SetHeight(30);
	dragframe:SetBackdrop(backdrop)
	dragframe.Text = dragframe:CreateFontString(nil, "ARTWORK")
	dragframe.Text:SetFont(STANDARD_TEXT_FONT, 12)
	dragframe.Text:SetJustifyH("CENTER")
	dragframe.Text:SetJustifyV("CENTER")
	dragframe.Text:SetPoint("CENTER", dragframe, "CENTER")
	dragframe.Text:SetText("test")
	dragframe.Text:SetTextColor(0,0,0)
	dragframe:SetMovable(true)
	dragframe:Hide()
	
	
	--ok and cancel buttons for options frame
	local btn = CreateFrame("Button",nil,o, "UIPanelButtonTemplate")
	local text = btn:GetFontString()
	text:SetPoint("LEFT",btn,"LEFT",7,0)
	text:SetPoint("RIGHT",btn,"RIGHT",-7,0)
	text:SetText("OK")
	btn:SetHeight(24)
	btn:SetWidth(text:GetWidth()+20)
	btn:SetPoint("BOTTOMLEFT", o ,"BOTTOMLEFT", 100, 20)
	o.OK = btn
	
	local btn = CreateFrame("Button",nil,o, "UIPanelButtonTemplate")
	local text = btn:GetFontString()
	text:SetPoint("LEFT",btn,"LEFT",7,0)
	text:SetPoint("RIGHT",btn,"RIGHT",-7,0)
	text:SetText("Cancel")
	btn:SetHeight(24)
	btn:SetWidth(text:GetWidth()+20)
	btn:SetPoint("BOTTOMLEFT", o ,"BOTTOMLEFT", 20, 20)
	btn:SetScript("OnClick", function() o:Hide() end)
	o.cancel = btn
	
	
	--new group button
	local btnNewGroup = CreateFrame("Button",nil,ZRALayoutFrame, "UIPanelButtonTemplate")
	
	text = btnNewGroup:GetFontString()
	text:SetPoint("LEFT",btnNewGroup,"LEFT",7,0)
	text:SetPoint("RIGHT",btnNewGroup,"RIGHT",-7,0)
	text:SetText("+New Role")
	btnNewGroup:SetHeight(24)
	btnNewGroup:SetWidth(text:GetWidth()+20)
	btnNewGroup:SetPoint("TOPLEFT", ZRALayoutFrame ,"TOPLEFT", 150, -20)
	
	
	btnNewGroup:SetScript("OnClick",function()
		local newRoleOptions = {
		{input = "SELECT", "Rotation", "Tank", "Group"},
		{input = "STRING", phrase = "Title"},
		}
		private.Z_OptionsFrame(newRoleOptions, function(options)
				local complete = true
				for i, v in pairs(options) do
					if not ZOptionsFrame.optionsSelected[i] then complete = false end
				end
				if complete then
					
					private.AddNewRole(ZOptionsFrame.optionsSelected)
				else
					DEFAULT_CHAT_FRAME:AddMessage("selections were missing")
				end
			end)
		end)
	
	--create player frames
	private.AllPlayerFrames()
	
	
end

function private.AllPlayerFrames()
	local pre
	local numplayers
	ZRALayoutFrame.busy_playerFrames = 0
	for i, v in ipairs(ZRALayoutFrame.playerFrames) do
		v.busy = false
		v:Hide()
	end
	if GetRaidRosterInfo(1) then
		--in a raid --GetNumRaidMembers() counts self
		numplayers = GetNumRaidMembers()
		pre = "raid"
		ZRALayoutFrame.raid = true
	else
		--in a party GetNumPartyMembers() doesnt count self
		pre = "party"
		numplayers = GetNumPartyMembers()
		private.MakePlayerFrame("player")
		ZRALayoutFrame.raid = false
	end
	
	for i = 1, numplayers do
		private.MakePlayerFrame(pre..i)
	end
end

function private.MakeCatcherFrame()
	local f
	if #ZRALayoutFrame.catcherFrames - ZRALayoutFrame.busy_catcherFrames == 0 then
		f = CreateFrame("Button", nil, ZRALayoutFrame);
		DEFAULT_CHAT_FRAME:AddMessage("making catcher frame")
		f:SetWidth(30);
		f:SetHeight(30);
		f:SetBackdrop(backdrop)
		f:SetBackdropColor(.8,.8,.8,0.2)
		f.Text = f:CreateFontString(nil, "ARTWORK")
		f.Text:SetFont(STANDARD_TEXT_FONT, 12)
		f.Text:SetJustifyH("CENTER")
		f.Text:SetJustifyV("CENTER")
		f.Text:SetPoint("CENTER", f, "CENTER")
		f.Text:SetText("+")
		f.Text:SetTextColor(0,0,0)
		f.catch = private.CatcherFrameCatch
		f:SetScript("OnMouseUp", function(self, button)
			if button == "RightButton" and #self.role.groups[self.rolegroup] == 1 and #self.role.groups ~= self.rolegroup then
				--remove rolegroup
				private.RemoveRoleGroup(self)
			end
		end)
		
		table.insert(ZRALayoutFrame.catcherFrames,f)
	else
	local i = private.findNotBusyFrame(ZRALayoutFrame.catcherFrames)
		f = ZRALayoutFrame.catcherFrames[i]
	end
	ZRALayoutFrame.busy_catcherFrames = ZRALayoutFrame.busy_catcherFrames + 1
	return f
end

function private.MakeRoleMemberFrame()
	local f
	if #ZRALayoutFrame.roleMemberFrames - ZRALayoutFrame.busy_roleMemberFrames == 0 then
		f = CreateFrame("Button", nil, ZRALayoutFrame);
		DEFAULT_CHAT_FRAME:AddMessage("making role member frame")
		f:SetWidth(30);
		f:SetHeight(30);
		f:SetBackdrop(backdrop)
		f:SetBackdropColor(.8,.8,.8,0.2)
		f.Text = f:CreateFontString(nil, "ARTWORK")
		f.Text:SetFont(STANDARD_TEXT_FONT, 12)
		f.Text:SetJustifyH("CENTER")
		f.Text:SetJustifyV("CENTER")
		f.Text:SetPoint("CENTER", f, "CENTER")
		f.Text:SetText("dude")
		f.Text:SetTextColor(0,0,0)
		f:SetScript("OnMouseUp", function(self, button)
			if button == "RightButton" then
				--remove role member
				private.RemoveRoleMember(self)
			end
		end)

		table.insert(ZRALayoutFrame.roleMemberFrames,f)
	else
	local i = private.findNotBusyFrame(ZRALayoutFrame.roleMemberFrames)
		f = ZRALayoutFrame.roleMemberFrames[i]
	end
	ZRALayoutFrame.busy_roleMemberFrames = ZRALayoutFrame.busy_roleMemberFrames + 1
	f.busy = true
	return f
end




function private.MakePlayerFrame(unitid)
	local f
	if #ZRALayoutFrame.playerFrames - ZRALayoutFrame.busy_playerFrames == 0 then
		f = CreateFrame("Button", nil, ZRALayoutFrame);
		DEFAULT_CHAT_FRAME:AddMessage("making player frame for " .. unitid)
		f:SetWidth(30);
		f:SetHeight(30);
		f:SetBackdrop(backdrop)
		f.Text = f:CreateFontString(nil, "ARTWORK")
		f.Text:SetFont(STANDARD_TEXT_FONT, 12)
		f.Text:SetJustifyH("CENTER")
		f.Text:SetJustifyV("CENTER")
		f.Text:SetPoint("CENTER", f, "CENTER")
		f.Text:SetText("test")
		f.Text:SetTextColor(0,0,0)
		f:SetScript("OnMouseUp", function(self,btn) 
			ZDragframe:StopMovingOrSizing()
			local mousex, mousey = GetCursorPosition()
			mousex = mousex / UIParent:GetEffectiveScale()
			mousey = mousey / UIParent:GetEffectiveScale()
			for i, v in ipairs(ZRALayoutFrame.catcherFrames) do
				if v:IsShown() then
					local x,y = v:GetCenter()
					if abs(x - mousex) < v:GetWidth()/2 and abs(y - mousey) < v:GetHeight()/2 then
						v:catch(ZDragframe.unitid)
						
					end
				end
			end
			ZDragframe:Hide()
		end)
		f:SetScript("OnMouseDown", function(self,btn)
			ZDragframe:SetPoint("TOPLEFT", f, "TOPLEFT")
			ZDragframe:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
			ZDragframe:SetBackdropColor(f:GetBackdropColor())
			ZDragframe.Text:SetText(f.Text:GetText())
			ZDragframe.unitid = f.unitid
			ZDragframe:Show()
			ZDragframe:StartMoving()
			
		end)
		
		table.insert(ZRALayoutFrame.playerFrames, f)
	else
		local i = private.findNotBusyFrame(ZRALayoutFrame.playerFrames)
		f = ZRALayoutFrame.playerFrames[i]
	end
	f:SetPoint("CENTER", ZRALayoutFrame, "BOTTOMLEFT", 30 + 31*ZRALayoutFrame.busy_playerFrames, 30);
	local color = RAID_CLASS_COLORS[string.upper(UnitClass(unitid))]
	f:SetBackdropColor(color.r, color.g, color.b,1)
	local playerName = UnitName(unitid)
	f.Text:SetText(string.sub(playerName,1,4))
	f.unitid = unitid
	f.busy =  true
	f:Show()
	ZRALayoutFrame.busy_playerFrames = ZRALayoutFrame.busy_playerFrames + 1
end

function private.findNotBusyFrame(frames)
	for i = 1, #frames do
		if frames[i].busy == false then
			return i
		end
	end
end

function private.AddNewRole(role)
	local f
	if #ZRALayoutFrame.roleFrames - ZRALayoutFrame.busy_roleframes == 0 then
		f = CreateFrame("Frame", nil, ZRALayoutFrame)
		
		f:SetFrameStrata("MEDIUM")
		
		f:SetFrameLevel(0)
		f:SetBackdrop(backdrop)
		f.texture = f:CreateTexture(nil, "BORDER")
		f.texture:SetTexture(.5,.5,.5,.75)
		f.texture:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -4)
		f.texture:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 4)
		f:SetBackdropColor(.3,.3,.3,.3)
		DEFAULT_CHAT_FRAME:AddMessage(role[1] .. " frame added")
		table.insert(ZRALayoutFrame.roleFrames, f)
		
		f.button = CreateFrame("Button",nil, f , "UIPanelButtonTemplate")
		f.button:SetWidth(100)
		f.button:SetHeight(20)
		f.button:SetPoint("TOP", f, "TOP", 0, -15)
		local text = f.button:GetFontString()
		text:SetText(role[2])
		f.button:Show()
		
		
	else
		for i, v in ipairs(ZRALayoutFrame.roleFrames) do
			if v.busy == false then
				f = v
				break
			end
		end
	end
	f.busy = true
	ZRALayoutFrame.busy_roleframes = ZRALayoutFrame.busy_roleframes + 1
	if role[1] == "Rotation" then
		f:SetPoint("TOPLEFT", ZRALayoutFrame, "TOPLEFT", 30 + ZRALayoutFrame.usedSpaceX, -60)
		f.width = 200
		f.height = 300
		f:SetWidth(f.width)
		f:SetHeight(f.height)
		f.groups = {}
		f:Show()
		ZRALayoutFrame.usedSpaceX = ZRALayoutFrame.usedSpaceX + f.width
		c = private.MakeCatcherFrame()
		c.busy = true
		c.role = f
		c.rolegroup = 1
		table.insert(f.groups,{c})
		
		private.PositionRoleMembers(c)
		c:SetParent(f)
		c:Show()
	end
	
end

function private.CatcherFrameCatch(catcher, unitid)
	if #catcher.role.groups[catcher.rolegroup] > 1 or catcher.role.groups[catcher.rolegroup + 1] then
		--just increment
		
	else
		--open new group
		local c = private.MakeCatcherFrame()
		table.insert(catcher.role.groups,{c})  --role.groups = {{c}}
		c.busy = true
		c:Show()
		c.role = catcher.role
		c.rolegroup = #catcher.role.groups
		DEFAULT_CHAT_FRAME:AddMessage("new rolegroup is "..c.rolegroup)
		c:SetParent(catcher.role)
		
		private.PositionRoleMembers(c)
		--c:SetPoint("TOPLEFT", c.role, "TOPLEFT", 20+40*(c.rolegroup-1), -20)
		
		
	end
	local m = private.MakeRoleMemberFrame()
	table.insert(catcher.role.groups[catcher.rolegroup],m)
	m.Text:SetText(ZDragframe.Text:GetText())
	m:SetBackdropColor(ZDragframe:GetBackdropColor())
	m.role = catcher.role
	m.rolegroup = catcher.rolegroup
	m:Show()
	private.PositionRoleMembers(m)
	
end

function private.RemoveRoleMember(self)
	for i, v in ipairs(self.role.groups[self.rolegroup]) do
		if v == self then
			table.remove(self.role.groups[self.rolegroup], i)
			break
		end
	end
	self.busy = false
	self:Hide()
	ZRALayoutFrame.busy_roleMemberFrames = ZRALayoutFrame.busy_roleMemberFrames - 1
	private.PositionRoleMembers(self)
	
end

function printGroups()
	for i, RF in ipairs(ZRALayoutFrame.roleFrames) do
		DEFAULT_CHAT_FRAME:AddMessage("printing role ".. i)
		for i2, RG in ipairs(RF.groups) do
			DEFAULT_CHAT_FRAME:AddMessage("  printing group ".. i2)
			for i3, GM in ipairs(RG) do
				DEFAULT_CHAT_FRAME:AddMessage("    ".. i3.."="..GM.Text:GetText())
			end
		end
	end
end

function private.RemoveRoleGroup(self)
	
	self.busy = false
	self:Hide()
	ZRALayoutFrame.busy_catcherFrames = ZRALayoutFrame.busy_catcherFrames - 1
	table.remove(self.role.groups[self.rolegroup],1)
	for i, v in ipairs(self.role.groups) do --v = groups
		if i > self.rolegroup then
			for i2, v2 in ipairs(v) do
				v2.rolegroup = v2.rolegroup - 1
				
			end
		end
		
	end
	
	table.remove(self.role.groups, self.rolegroup)
	for i = 1,#self.role.groups do
		private.PositionRoleMembers(self.role.groups[i][1])
	end

	
end

function private.PositionRoleMembers(self)
	for i, v in ipairs(self.role.groups[self.rolegroup]) do
		v:SetPoint("TOPLEFT", v.role, "TOPLEFT", 20+40*(v.rolegroup-1), -40 - (i-2)*32)
	end
	local size = #self.role.groups[self.rolegroup]
	self.role.groups[self.rolegroup][1]:SetPoint("TOPLEFT", self.role, "TOPLEFT", 20+40*(self.rolegroup-1), -40 - (size-1)*32)
end


function private.Z_OptionsFrame(options, returnfunction)
	local width = 300
	local height = 300
	
	local currentY = 20
	local currentX = 20
	local busy_selectframes = 0
	
	local busy_stringframes = 0
	local busy_labelframes = 0
	
	ZOptionsFrame.groups = {}
	ZOptionsFrame.optionsSelected = {}
	ZOptionsFrame:Raise()
	for i, v in ipairs(options) do
		local group = {}
		if v.input == "SELECT" then
			for i2, v2 in ipairs(v) do
				local btn
				if #ZOptionsFrame.selectframes - busy_selectframes == 0 then
					btn = CreateFrame("Button",nil,ZOptionsFrame, "UIPanelButtonTemplate")
					DEFAULT_CHAT_FRAME:AddMessage("made frame for "..v2)
					table.insert(ZOptionsFrame.selectframes, btn)
					
					local highlight = btn:CreateTexture(nil, "BORDER")
					btn.highlight = highlight
					highlight:SetTexture("Interface\\ChatFrame\\ChatFrameBorder")
					highlight:SetPoint("TOPLEFT", btn, "TOPLEFT", -4, 1)
					highlight:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", 4, -7)
					highlight:Hide()
				else
					btn = ZOptionsFrame.selectframes[1 + busy_selectframes]
				end
				local text = btn:GetFontString()
				text:SetPoint("LEFT",btn,"LEFT",7,0)
				text:SetPoint("RIGHT",btn,"RIGHT",-7,0)
				text:SetText(v2)
				btn:SetHeight(24)
				btn:SetWidth(text:GetWidth()+20)
				btn:SetPoint("TOPLEFT", ZOptionsFrame ,"TOPLEFT", currentX, 0-currentY)
				btn:SetScript("OnClick", function()
					for j,k in ipairs(ZOptionsFrame.groups[this.group]) do
						k.selected = false
						k.highlight:Hide()
					end
					this.highlight:Show() 
					this.selected = true
					ZOptionsFrame.optionsSelected[i] = options[i][i2]
				end)
				
				btn.group = i
				this.selected = false
				btn.highlight:Hide()
				busy_selectframes = busy_selectframes + 1
				currentX = currentX + text:GetWidth() + 30
				table.insert(group, btn)
			end
		elseif v.input == "STRING" then
			--v.phrase
				-- edit box
				local edb
				if #ZOptionsFrame.stringframes - busy_stringframes == 0 then
					edb = CreateFrame("EditBox",nil,ZOptionsFrame, "InputBoxTemplate")
					table.insert(ZOptionsFrame.stringframes, edb)
					edb:SetAutoFocus(false)
					edb:SetScript("OnEscapePressed", function(self) 
						self:ClearFocus()
						edb:SetText(ZOptionsFrame.optionsSelected[i])
					end)
					
					edb:SetScript("OnEnterPressed", function(self) 
						ZOptionsFrame.optionsSelected[i] = edb:GetText()
						self:ClearFocus() 
					end)
					
				else
					edb = ZOptionsFrame.stringframes[1 + busy_stringframes]
				end
				edb:SetPoint("TOPLEFT", ZOptionsFrame ,"TOPLEFT", currentX + 50 , 0-currentY)
				edb:SetWidth(100)
				edb:SetHeight(25)
				edb:Show()
				edb:SetText("DEFAULT")
				edb.group = i
				ZOptionsFrame.optionsSelected[i] = edb:GetText()
				--label
				local lbl
				if #ZOptionsFrame.labelframes - busy_labelframes == 0 then
					lbl = ZOptionsFrame:CreateFontString(nil, "ARTWORK")
					table.insert(ZOptionsFrame.labelframes, lbl)
				else
					lbl = ZOptionsFrame.labelframes[1 + busy_labelframes]
				end
				lbl:SetFont(STANDARD_TEXT_FONT, 12)
				lbl:SetTextColor(0,0,0)
				lbl:SetJustifyH("CENTER")
				lbl:SetJustifyV("CENTER")
				lbl:SetPoint("TOPLEFT", ZOptionsFrame ,"TOPLEFT", currentX, 0-currentY - 5)
				lbl:SetText(v.phrase)
				lbl:Show()
		end
		currentY = currentY + 40
		currentX = 20
		table.insert(ZOptionsFrame.groups, group)
	end
	
	ZOptionsFrame:SetWidth(width)
	ZOptionsFrame:SetHeight(height)
	ZOptionsFrame.OK:SetScript("OnClick",function() returnfunction(options) ZOptionsFrame:Hide() end)
	
	ZOptionsFrame:Show()

end

--ZOptionsFrame.selectframes[1]:GetScript("OnLeave")

--local function editbox()
--local editbox = CreateFrame("EditBox",nil,btn)
--	editbox:SetFontObject(ChatFontNormal)
--	editbox:SetScript("OnEscapePressed",function(this) this:ClearFocus() end)
--	editbox:SetScript("OnEnterPressed",function(this) this:ClearFocus() end)
--
--	editbox:SetTextInsets(5,5,3,3)
--	editbox:SetMaxLetters(256)
--	editbox:SetAutoFocus(false)
--	editbox:SetBackdropColor(0,0,0)
--	editbox:SetPoint("TOPLEFT",btn,"TOPLEFT",0,0)
--	editbox:SetPoint("BOTTOMRIGHT",btn,"BOTTOMRIGHT",0,0)
--	editbox:SetText("rere")
--end




private.scriptframe = CreateFrame("Frame")
private.scriptframe:RegisterEvent("ADDON_LOADED")
private.scriptframe:SetScript("OnEvent", private.onEvent)
private.scriptframe:SetScript("OnUpdate", private.onUpdate)
--private.scriptframe:RegisterEvent("RAID_ROSTER_UPDATE") 
private.scriptframe:RegisterEvent("PARTY_MEMBERS_CHANGED")

function debugthis(arg1)
	func = ZDragframe:GetCenter()
	params = nil
	if arg1 then
		params = arg1
	end
	values = {func(params)}
	for i, v in ipairs(values) do
		DEFAULT_CHAT_FRAME:AddMessage("arg"..i.."="..(v or "F"))
	end
end

local function justholdingthis()
	btn = CreateFrame("Button", "myButton", ZRALayoutFrame, "SecureActionButtonTemplate");
	btn:SetAttribute("type1", "macro");
	btn:SetAttribute("unit", "player")
	btn:SetAttribute("macrotext", "/targetexact " .. "Vindicator Aeus")


	btn:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	btn:SetPoint("CENTER", ZRALayoutFrame, "TOPLEFT", 140, 26);
	btn:SetWidth(30);
	btn:SetHeight(30);
	btn:SetMovable(true)
	btn:EnableMouse(true)
	btn:RegisterForDrag("LeftButton")
	btn:SetScript("OnDragStart", btn.StartMoving)
	btn:SetScript("OnDragStop", btn.StopMovingOrSizing)
	
	btn:Show();

	btn.BarBG = btn:CreateTexture()
	local color = RAID_CLASS_COLORS["WARRIOR"]
	btn.BarBG:SetTexture(color.r, color.g, color.b,0)
	btn.BarBG:SetAllPoints(btn)
	
	btn:SetBackdrop(backdrop)
	btn:SetBackdropColor(color.r, color.g, color.b,1)
	
	
	
	btn.Text = btn:CreateFontString(nil, "ARTWORK")
	btn.Text:SetFont(STANDARD_TEXT_FONT, 12)
	btn.Text:SetJustifyH("CENTER")
	btn.Text:SetJustifyV("CENTER")
	btn.Text:SetPoint("CENTER", btn, "CENTER")
	btn.Text:SetText("rere")
	
	btn.Text:SetTextColor(0,0,0)
end




--- slash handler
SLASH_ZRAIDASSIGN1 = "/zra"
SlashCmdList["ZRAIDASSIGN"] = function(msg)
	local command, arg1, arg2, arg3 = strsplit(" ",msg)
	
	if (command == "re") then
		--local t = RL:GetUnitObjectFromName(UnitName("target"))
		--for i, v in pairs(t) do
		--Print(i.. "=".. (v or "F"))
		--end
		
	elseif (command == "asdas") then
		
	else 
		private.OpenMenu()
	end
end


function private.OpenMenu()
	private.AllPlayerFrames()
	ZRALayoutFrame:Show()
end

function private.closeOnClick(this)
	this.obj:Hide()
end


--Vindicator Aeus

--local dd = CreateFrame("Button", "DD", UIParent, "UIDropDownMenuTemplate")

function MyDropDownMenu_OnLoad()
       info            = {};
       info.text       = "This is an option in the menu.";
       info.value      = "OptionVariable";
       info.func       = function() UIDropDownMenu_SetSelectedValue(DD, info.value) end
                 -- can also be done as function() FunctionCalledWhenOptionIsClicked() end;
       
       -- Add the above information to the options menu as a button.
       UIDropDownMenu_AddButton(info);
	   
	   info2            = {};
       info2.text       = "option 2 bitch";
       info2.value      = "O2onVarreree";
       info2.func       = function() UIDropDownMenu_SetSelectedValue(DD, info2.value) end
                 -- can also be done as function() FunctionCalledWhenOptionIsClicked() end;
       
       -- Add the above information to the options menu as a button.
       UIDropDownMenu_AddButton(info2);
end
--dd:SetScript("OnClick", MyDropDownMenuButton_OnClick)
--dd:SetPoint("CENTER",UIParent, "CENTER", 200, 200)

function MyDropDownMenuButton_OnClick() 
       ToggleDropDownMenu(1, nil, nil, DD, 0, 0);
end
   
   
    -- creating test data structure
 local Test1_Data = {
   ["level1_test_1"] = {
     [1] = { ["name"] = "sublevel 1"; },
     [2] = {	["name"] = "sublevel 2"; },
   },
   ["level1_test_2"] = {
     [1] = {	["name"] = "sublevel A"; },
     [2] = {	["name"] = "sublevel B"; },
   }
 }
 
 function Test1_DropDown_Initialize(self,level)
   level = level or 1;
   if (level == 1) then
     for key, subarray in pairs(Test1_Data) do
       local info = UIDropDownMenu_CreateInfo();
       info.hasArrow = true; -- creates submenu
       info.notCheckable = true;
       info.text = key;
       info.value = {
         ["Level1_Key"] = key;
       };
       UIDropDownMenu_AddButton(info, level);
     end -- for key, subarray
   end -- if level 1

   if (level == 2) then
     -- getting values of first menu
     local Level1_Key = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"];
     subarray = Test1_Data[Level1_Key];
     for key, subsubarray in pairs(subarray) do
       local info = UIDropDownMenu_CreateInfo();
       info.hasArrow = false; -- no submenues this time
       info.notCheckable = true;
       info.text = subsubarray["name"];
       -- use info.func to set a function to be called at "click"
       info.value = {
         ["Level1_Key"] = Level1_Key;
         ["Sublevel_Key"] = key;
       };
       UIDropDownMenu_AddButton(info, level);
     end -- for key,subsubarray
   end -- if level 2
 end
--UIDropDownMenu_Initialize(dd, MyDropDownMenu_OnLoad)


