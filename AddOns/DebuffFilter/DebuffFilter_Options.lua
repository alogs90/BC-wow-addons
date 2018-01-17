local _G = getfenv(0);
local DebuffFilterOptions = {};
local DebuffFilter_PlayerConfig;

DebuffFilterOptions.items = {};

DebuffFilterOptions.target = "";
DebuffFilterOptions.type = "debuff";

DebuffFilterOptions.Frames = {
	DebuffFilter_DebuffFrame = "debuff_list",
	DebuffFilter_BuffFrame = "buff_list",
	DebuffFilter_PDebuffFrame = "pdebuff_list",
	DebuffFilter_PBuffFrame = "pbuff_list",
	DebuffFilter_FDebuffFrame = "fdebuff_list",
	DebuffFilter_FBuffFrame = "fbuff_list",
}

DebuffFilterOptions.LayoutTable = {
	rightdown = {1, "Right-Down"},
	rightup = {2, "Right-Up"},
	leftdown = {3, "Left-Down"},
	leftup = {4, "Left-Up"},
}

DebuffFilterOptions_Selection = "";

function DebuffFilterOptions_Initialize()
	DebuffFilter_PlayerConfig = DebuffFilter_Config[DebuffFilter_Player];

	UIPanelWindows["DebuffFilterOptionsFrame"] = {area = "center", pushable = 0, whileDead = 1}
	DebuffFilterOptions_UpdateItems();
	DebuffFilterOptions_Title:SetText("Debuff Filter " .. GetAddOnMetadata("DebuffFilter", "Version"));
end

function DebuffFilterOptions_TargetDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, DebuffFilterOptions_TargetDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(this, 1);
	UIDropDownMenu_SetWidth(72);

	this.tooltipText = DFILTER_OPTIONS_TARGET_TOOLTIP;
end

function DebuffFilterOptions_TargetDropDown_Initialize()
	local info = {};
	info.text = "Target";
	info.value = "";
	info.func = DebuffFilterOptions_TargetDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.checked = nil;
	info.text = "Player";
	info.value = "p";
	info.func = DebuffFilterOptions_TargetDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.checked = nil;
	info.text = "Focus";
	info.value = "f";
	info.func = DebuffFilterOptions_TargetDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function DebuffFilterOptions_TargetDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(DebuffFilterOptions_TargetDropDown, this:GetID());
	DebuffFilterOptions.target = this.value;

	if (this.value ~= "p") then
		DebuffFilterOptions_CheckButtonSelfApplied:Show();
	else
		DebuffFilterOptions_CheckButtonSelfApplied:Hide();
	end

	DebuffFilterOptions_ClearSelection();
end

function DebuffFilterOptions_GrowDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, DebuffFilterOptions_GrowDropDown_Initialize);
	UIDropDownMenu_SetWidth(102);

	this.tooltipText = DFILTER_OPTIONS_GROW_TOOLTIP;
end

function DebuffFilterOptions_GrowDropDown_Initialize()
	local info = {};
	info.text = "Right-Down";
	info.value = "rightdown";
	info.func = DebuffFilterOptions_GrowDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.checked = nil;
	info.text = "Right-Up";
	info.value = "rightup";
	info.func = DebuffFilterOptions_GrowDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.checked = nil;
	info.text = "Left-Down";
	info.value = "leftdown";
	info.func = DebuffFilterOptions_GrowDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.checked = nil;
	info.text = "Left-Up";
	info.value = "leftup";
	info.func = DebuffFilterOptions_GrowDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function DebuffFilterOptions_GrowDropDown_OnClick()
	DebuffFilterOptions_ModifyLayout("grow", this.value, this:GetID());
end

function DebuffFilterOptions_Tab_OnClick(type)
	DebuffFilterOptions.type = type;

	DebuffFilterOptions_ClearSelection();
end

-- taken from bongos
function DebuffFilterOptions_SetScale(scale)
	local ratio, x, y;

	DebuffFilter_PlayerConfig.scale = scale;
	ratio = DebuffFilterFrame:GetScale() / scale

	for k in pairs(DebuffFilterOptions.Frames) do
		x, y = _G[k]:GetLeft() * ratio, _G[k]:GetTop() * ratio;
		_G[k]:ClearAllPoints();
		_G[k]:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y);
	end

	DebuffFilterFrame:SetScale(scale);
end

function DebuffFilterOptions_UpdateItems()
	for k in pairs(DebuffFilterOptions.items) do
		DebuffFilterOptions.items[k] = nil;
	end

	local targettype = DebuffFilterOptions.target .. DebuffFilterOptions.type;

	DebuffFilterOptions.list = targettype .. "_list";
	DebuffFilterOptions.layout = targettype .. "_layout";

	for k in pairs(DebuffFilter_PlayerConfig[DebuffFilterOptions.list]) do
		table.insert(DebuffFilterOptions.items, k);
	end

	table.sort(DebuffFilterOptions.items);
	DebuffFilterOptions.count = table.getn(DebuffFilterOptions.items);
end

function DebuffFilterOptions_ScrollFrame_Update()
	local button, name;

	local offset = FauxScrollFrame_GetOffset(DebuffFilterOptions_ScrollFrame);
	FauxScrollFrame_Update(DebuffFilterOptions_ScrollFrame, DebuffFilterOptions.count, 14, 16);

	for i = 1, 14 do
		button = _G["DebuffFilterOptions_Item" .. i];

		if (DebuffFilterOptions.count >= i + offset) then
			name = DebuffFilterOptions.items[i + offset];

			if (name == DebuffFilterOptions_Selection) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end

			button:SetText(name);
			button:Show();
		else
			button:Hide();
		end
	end
end

function DebuffFilterOptions_ModifyLayout(type, value, id)
	if (type == "grow") then
		DebuffFilter_PlayerConfig[DebuffFilterOptions.layout].grow = value;
		UIDropDownMenu_SetSelectedID(DebuffFilterOptions_GrowDropDown, id);
	else
		DebuffFilter_PlayerConfig[DebuffFilterOptions.layout].per_row = value;
	end

	for k, v in pairs(DebuffFilterOptions.Frames) do
		if (v == DebuffFilterOptions.list) then
			DebuffFilter_UpdateLayout(k);
			
			break;
		end
	end
end

function DebuffFilterOptions_ModifyList(arg)
	local item = DebuffFilterOptions_EditBox:GetText();
	local texture = DebuffFilterOptions_EditBox2:GetText();
	local selfapplied = DebuffFilterOptions_CheckButtonSelfApplied:GetChecked();
	local dontcombine = DebuffFilterOptions_CheckButtonDontCombine:GetChecked();

	if (item ~= "") then
		if (arg == "add") then
			DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item] = {};
			DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item].selfapplied = selfapplied;
			DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item].dontcombine = dontcombine;

			if (texture ~= "") then
				DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item].texture = texture;
			else
				DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item].texture = nil;
			end

			DebuffFilterOptions_ClearSelection();
		elseif (arg == "selfapplied" or arg == "dontcombine") then
			if (DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item]) then
				DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item].selfapplied = selfapplied;
				DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item].dontcombine = dontcombine;
			end
		else
			DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item] = nil;

			DebuffFilterOptions_ClearSelection();
		end

		for k, v in pairs(DebuffFilterOptions.Frames) do
			if (v == DebuffFilterOptions.list) then
				_G[k .. "_Update"]();
				
				break;
			end
		end
	else
		DebuffFilterOptions_ClearSelection();
	end
end

function DebuffFilterOptions_ClearSelection()
	DebuffFilterOptions_Selection = "";
	DebuffFilterOptions_EditBox:SetText("");
	DebuffFilterOptions_EditBox2:SetText("");
	DebuffFilterOptions_CheckButtonSelfApplied:SetChecked(0);
	DebuffFilterOptions_CheckButtonDontCombine:SetChecked(0);

	DebuffFilterOptions_ScrollFrameScrollBar:SetValue(0);
	DebuffFilterOptions_UpdateItems();
	DebuffFilterOptions_ScrollFrame_Update();

	DebuffFilterOptions_GetLayout();
end

function DebuffFilterOptions_GetLayout()
	local grow = DebuffFilter_PlayerConfig[DebuffFilterOptions.layout].grow;

	UIDropDownMenu_SetSelectedID(DebuffFilterOptions_GrowDropDown, DebuffFilterOptions.LayoutTable[grow][1]);
	UIDropDownMenu_SetText(DebuffFilterOptions.LayoutTable[grow][2], DebuffFilterOptions_GrowDropDown);

	DebuffFilterOptions_RowSlider:SetValue(DebuffFilter_PlayerConfig[DebuffFilterOptions.layout].per_row);
end

function DebuffFilterOptions_GetOptions(item)
	DebuffFilterOptions_CheckButtonSelfApplied:SetChecked(DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item].selfapplied);
	DebuffFilterOptions_CheckButtonDontCombine:SetChecked(DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item].dontcombine);
	DebuffFilterOptions_EditBox2:SetText(DebuffFilter_PlayerConfig[DebuffFilterOptions.list][item].texture or "");
end