local DebuffFilter_DefaultSettings = {
	debuffs = true,
	buffs = false,
	pdebuffs = false,
	pbuffs = false,
	fdebuffs = false,
	fbuffs = false,
	scale = 1,
	debuff_layout = {grow="rightdown", per_row=8, time_tb="bottom", time_lr="right"},
	buff_layout = {grow="rightdown", per_row=8, time_tb="bottom", time_lr="right"},
	pdebuff_layout = {grow="rightdown", per_row=8, time_tb="bottom", time_lr="right"},
	pbuff_layout = {grow="rightdown", per_row=8, time_tb="bottom", time_lr="right"},
	fdebuff_layout = {grow="rightdown", per_row=8, time_tb="bottom", time_lr="right"},
	fbuff_layout = {grow="rightdown", per_row=8, time_tb="bottom", time_lr="right"},
	all_pdebuffs = false,
	all_fdebuffs = false,
	all_fbuffs = false,
	count = false,
	cooldowncount = false,
	combat = false,
	tooltips = true,
	lock = false,
	debuff_list = {
		["Sunder Armor"] = {},
		["Faerie Fire"] = {},
		["Curse of Recklessness"] = {},
		["Thunder Clap"] = {},
		["Expose Armor"] = {},
	},
	buff_list = {
		["Renew"] = {},
		["Rejuvenation"] = {},
	},
	pdebuff_list = {
		["Bloodboil"] = {},
		["Carrion Swarm"] = {},
	},
	pbuff_list = {
		["Battle Shout"] = {},
		["Adrenaline Rush"] = {},
		["Blade Flurry"] = {},
		["Lightning Speed"] = {},
	},
	fdebuff_list = {
		["Mortal Strike"] = {},
	},
	fbuff_list = {
		["Fear Ward"] = {},
	},
}

local _G = getfenv(0);
local DebuffFilter = {};
local DebuffFilter_PlayerConfig;

DebuffFilter.Orientation = {
	rightdown = { point="LEFT", relpoint="RIGHT", x=4, y=0 },
	rightup = { point="LEFT", relpoint="RIGHT", x=4, y=0 },
	leftdown = { point="RIGHT", relpoint="LEFT", x=-4, y=0 },
	leftup = { point="RIGHT", relpoint="LEFT", x=-4, y=0 },
	bottom = { point="TOP", relpoint="BOTTOM", x=0, y=-2, next_time="top" },
	top = { point="BOTTOM", relpoint="TOP", x=0, y=2, next_time="bottom" },
	left = { point="RIGHT", relpoint="LEFT", x=-4, y=0, next_time="right" },
	right = { point="LEFT", relpoint="RIGHT", x=4, y=0, next_time="left" },
}

DebuffFilter.Frames = {
	DebuffFilter_DebuffFrame = { option_key="debuffs", list_key="debuff_list", layout_key="debuff_layout", name="debuff", button="DebuffFilter_DebuffButton" },
	DebuffFilter_BuffFrame = { option_key="buffs", list_key="buff_list", layout_key="buff_layout", name="buff", button="DebuffFilter_BuffButton" },
	DebuffFilter_PDebuffFrame = { option_key="pdebuffs", list_key="pdebuff_list", layout_key="pdebuff_layout", name="player debuff" , all_cmd="allpd", button="DebuffFilter_PDebuffButton" },
	DebuffFilter_PBuffFrame = { option_key="pbuffs", list_key="pbuff_list", layout_key="pbuff_layout", name="player buff", button="DebuffFilter_PBuffButton" },
	DebuffFilter_FDebuffFrame = { option_key="fdebuffs", list_key="fdebuff_list", layout_key="fdebuff_layout", name="focus debuff", all_cmd="allfd", button="DebuffFilter_FDebuffButton" },
	DebuffFilter_FBuffFrame = { option_key="fbuffs", list_key="fbuff_list", layout_key="fbuff_layout", name="focus buff", all_cmd="allfb", button="DebuffFilter_FBuffButton" },
}

DebuffFilter.Stacks = {
	debuffs = {},
	buffs = {},
	pdebuffs = {},
	pbuffs = {},
	fdebuffs = {},
	fbuffs = {},
}

local function DebuffFilter_Initialize()
	if (not DebuffFilter_Config) then
		DebuffFilter_Config = {};
	end

	if (not DebuffFilter_Config[DebuffFilter_Player]) then
		DebuffFilter_Config[DebuffFilter_Player] = {};
	end

	DebuffFilter_PlayerConfig = DebuffFilter_Config[DebuffFilter_Player];

	for k, v in pairs(DebuffFilter_PlayerConfig) do
		if (DebuffFilter_DefaultSettings[k] == nil) then
			DebuffFilter_PlayerConfig[k] = nil;
		end
	end

	for k, v in pairs(DebuffFilter_DefaultSettings) do
		if (DebuffFilter_PlayerConfig[k] == nil) then
			DebuffFilter_PlayerConfig[k] = v;
		elseif (DebuffFilter_PlayerConfig[k] == "yes") then
			DebuffFilter_PlayerConfig[k] = true;
		elseif (DebuffFilter_PlayerConfig[k] == "no") then
			DebuffFilter_PlayerConfig[k] = false;
		end
	end

	local list_key, layout;

	for k, v in pairs(DebuffFilter.Frames) do
		list_key = v.list_key;
		layout = DebuffFilter_PlayerConfig[v.layout_key];

		for listk, listv in pairs(DebuffFilter_PlayerConfig[list_key]) do
			if (listv == 1) then
				DebuffFilter_PlayerConfig[list_key][listk] = {};
			end
		end

		if (not DebuffFilter_PlayerConfig[v.option_key]) then
			_G[k]:Hide();
		end

		if (DebuffFilter_PlayerConfig.count) then
			_G[k .. "Count"]:Show();
		end

		DebuffFilter_SetCountOrientation(layout, k);
	end

	if (DebuffFilter_PlayerConfig.lock) then
		DebuffFilter_LockFrames(true);
	end

	if (DebuffFilter_PlayerConfig.combat) then
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");

		if (not UnitAffectingCombat("player")) then
			this:Hide();
		end
	end

	DebuffFilterOptions_Initialize();

	SlashCmdList["DFILTER"] = DebuffFilter_Command;
	SLASH_DFILTER1 = "/dfilter";
end

function DebuffFilter_OnMouseDown(arg1)
	if (arg1 == "LeftButton" and IsShiftKeyDown()) then
		this:GetParent():StartMoving();
	elseif (arg1 == "RightButton" and IsControlKeyDown()) then
		local next_time;
		local frame = this:GetParent():GetName();
		local layout_key = DebuffFilter.Frames[frame].layout_key;
		local layout = DebuffFilter_PlayerConfig[layout_key];

		if (layout.per_row == 1) then
			next_time = DebuffFilter.Orientation[layout.time_lr].next_time;
			layout.time_lr = next_time;
		else
			next_time = DebuffFilter.Orientation[layout.time_tb].next_time;
			layout.time_tb = next_time;
		end

		DebuffFilter_SetTimeOrientation(next_time, DebuffFilter.Frames[frame].button);
		DebuffFilter_Print(DebuffFilter.Frames[frame].name .. " time orientation: " .. next_time);
	end
end

function DebuffFilter_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		this:GetParent():StopMovingOrSizing();
	end
end

function DebuffFilter_OnLoad()
	DebuffFilter_Player = (UnitName("player").." - "..GetRealmName());
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_FOCUS_CHANGED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("UNIT_AURA");
end

function DebuffFilter_Button_OnLoad()
	local name = this:GetName();

	this.icon = _G[name .. "Icon"];
	this.time = _G[name .. "Duration"];
	this.cooldown = _G[name .. "Cooldown"];
	this.count = _G[name .. "Count"];
	this.count2 = _G[name .. "Count2"];
	this.border = _G[name .. "Border"];
	this.update = 0;
end

function DebuffFilter_ShowButton(button, index, texture, applications, duration, timeleft, target)
	button.index = index;
	button.duration = duration;
	button.target = target;
	button.icon:SetTexture(texture);

	if (applications > 1) then
		button.count:SetText(applications);
		button.count:Show();
	else
		button.count:Hide();
	end

	if (duration and duration > 0) then
		if (not DebuffFilter_PlayerConfig.cooldowncount) then
			DebuffFilter_SetTime(button, timeleft);
			button.time:Show();
		else
			CooldownFrame_SetTimer(button.cooldown, GetTime()-(duration-timeleft), duration, 1);
		end
	else
		button.time:Hide();
		button.cooldown:Hide();

		if (button.timer) then
			button.timer:Hide();
		end
	end

	button:Show();
end

function DebuffFilter_HideButton(button)
	if (button) then
		button:Hide();
	end
end

function DebuffFilter_ShowPlayerButton(button, index, texture, untilcancelled)
	button.index = index;
	button.untilcancelled = untilcancelled;
	button.icon:SetTexture(texture);

	local applications = GetPlayerBuffApplications(index);
	local timeleft = GetPlayerBuffTimeLeft(index);

	if (applications > 1) then
		button.count:SetText(applications);
		button.count:Show();
	else
		button.count:Hide();
	end

	if (untilcancelled ~= 1) then
		if (not DebuffFilter_PlayerConfig.cooldowncount) then
			DebuffFilter_SetTime(button, timeleft);
			button.time:Show();
		else
			CooldownFrame_SetTimer(button.cooldown, GetTime(), timeleft, 1);
			button.cooldown:Hide();
		end
	else
		button.time:Hide();

		if (button.timer) then
			button.timer:Hide();
		end
	end

	button:Show();
end

function DebuffFilter_DebuffFrame_Update()
	if (not DebuffFilter_PlayerConfig.debuffs) then
		return;
	end

	local button;
	local name, texture, applications, debufftype, duration, timeleft;
	local selfapplied, dontcombine, texturefilter;
	local nametexture, color;
	local width = 0;

	for i = 1, 40 do
		name, _, texture, applications, debufftype, duration, timeleft = UnitDebuff("target", i);

		if (not texture) then
			break;
		end

		DebuffFilter_DebuffFrameCount:SetText(i);

		if (DebuffFilter_PlayerConfig.debuff_list[name]) then
			selfapplied = DebuffFilter_PlayerConfig.debuff_list[name].selfapplied;
			dontcombine = DebuffFilter_PlayerConfig.debuff_list[name].dontcombine;
			texturefilter = DebuffFilter_PlayerConfig.debuff_list[name].texture;

			if (not selfapplied or duration) and (not texturefilter or string.match(texture, texturefilter)) then
				nametexture = name .. texture;

				if (not dontcombine and DebuffFilter.Stacks.debuffs[nametexture]) then
					button = _G["DebuffFilter_DebuffButton" .. DebuffFilter.Stacks.debuffs[nametexture]];

					DebuffFilter_CombineStacks(button);

					if (duration and duration > 0) then
						DebuffFilter_ShowButton(button, i, texture, applications, duration, timeleft, "target");
					end
				elseif (width < 8) then
					if (debufftype) then
						color = DebuffTypeColor[debufftype];
					else
						color = DebuffTypeColor["none"];
					end

					width = width + 1;

					button = _G["DebuffFilter_DebuffButton" .. width];

					if (not button) then
						button = CreateFrame("Button", "DebuffFilter_DebuffButton" .. width, DebuffFilter_DebuffFrame, "DebuffFilter_DebuffButtonTemplate");
						button:EnableMouse(not DebuffFilter_PlayerConfig.lock);
						DebuffFilter_SetButtonLayout(DebuffFilter_PlayerConfig.debuff_layout, "DebuffFilter_DebuffFrame", button, width);
					end

					button.border:SetVertexColor(color.r, color.g, color.b);
					button.count2:SetText("");
					DebuffFilter_ShowButton(button, i, texture, applications, duration, timeleft, "target");

					DebuffFilter.Stacks.debuffs[nametexture] = width;
				end
			end
		end
	end

	for i = width+1, 8 do
		DebuffFilter_HideButton(_G["DebuffFilter_DebuffButton" .. i]);
	end

	if (width == 0) then
		DebuffFilter_DebuffFrameCount:SetText("");
	end

	for k in pairs(DebuffFilter.Stacks.debuffs) do
		DebuffFilter.Stacks.debuffs[k] = nil;
	end
end

function DebuffFilter_BuffFrame_Update()
	if (not DebuffFilter_PlayerConfig.buffs) then
		return;
	end

	local button;
	local name, texture, applications, duration, timeleft;
	local selfapplied, dontcombine, texturefilter;
	local nametexture;
	local width = 0;

	for i = 1, 24 do
		name, _, texture, applications, duration, timeleft = UnitBuff("target", i);

		if (not texture) then
			break;
		end

		DebuffFilter_BuffFrameCount:SetText(i);

		if (DebuffFilter_PlayerConfig.buff_list[name]) then
			selfapplied = DebuffFilter_PlayerConfig.buff_list[name].selfapplied;
			dontcombine = DebuffFilter_PlayerConfig.buff_list[name].dontcombine;
			texturefilter = DebuffFilter_PlayerConfig.buff_list[name].texture;

			if (not selfapplied or duration) and (not texturefilter or string.match(texture, texturefilter)) then
				nametexture = name .. texture;

				if (not dontcombine and DebuffFilter.Stacks.buffs[nametexture]) then
					button = _G["DebuffFilter_BuffButton" .. DebuffFilter.Stacks.buffs[nametexture]];

					DebuffFilter_CombineStacks(button);

					if (duration and duration > 0) then
						DebuffFilter_ShowButton(button, i, texture, applications, duration, timeleft, "target");
					end
				elseif (width < 8) then
					width = width + 1;

					button = _G["DebuffFilter_BuffButton" .. width];

					if (not button) then
						button = CreateFrame("Button", "DebuffFilter_BuffButton" .. width, DebuffFilter_BuffFrame, "DebuffFilter_BuffButtonTemplate");
						button:EnableMouse(not DebuffFilter_PlayerConfig.lock);
						DebuffFilter_SetButtonLayout(DebuffFilter_PlayerConfig.buff_layout, "DebuffFilter_BuffFrame", button, width);
					end

					button.count2:SetText("");
					DebuffFilter_ShowButton(button, i, texture, applications, duration, timeleft, "target");

					DebuffFilter.Stacks.buffs[nametexture] = width;
				end
			end
		end
	end

	for i = width+1, 8 do
		DebuffFilter_HideButton(_G["DebuffFilter_BuffButton" .. i]);
	end

	if (width == 0) then
		DebuffFilter_BuffFrameCount:SetText("");
	end

	for k in pairs(DebuffFilter.Stacks.buffs) do
		DebuffFilter.Stacks.buffs[k] = nil;
	end
end

function DebuffFilter_PDebuffFrame_Update()
	if (not DebuffFilter_PlayerConfig.pdebuffs) then
		return;
	end

	local button;
	local index, untilcancelled, name, texture, debufftype;
	local dontcombine, texturefilter;
	local nametexture, color;
	local width = 0;

	for i = 1, 8 do
		index, untilcancelled = GetPlayerBuff(i, "HARMFUL");

		if (index < 1) then
			break;
		end

		DebuffFilter_PDebuffFrameCount:SetText(i);

		name = GetPlayerBuffName(index);

		if (DebuffFilter_PlayerConfig.pdebuff_list[name] or DebuffFilter_PlayerConfig.all_pdebuffs) then
			texture = GetPlayerBuffTexture(index);

			if (not DebuffFilter_PlayerConfig.all_pdebuffs) then
				dontcombine = DebuffFilter_PlayerConfig.pdebuff_list[name].dontcombine;
				texturefilter = DebuffFilter_PlayerConfig.pdebuff_list[name].texture;
			end

			if (not texturefilter or string.match(texture, texturefilter)) then
				nametexture = name .. texture;

				if (not dontcombine and DebuffFilter.Stacks.pdebuffs[nametexture]) then
					button = _G["DebuffFilter_PDebuffButton" .. DebuffFilter.Stacks.pdebuffs[nametexture]];

					DebuffFilter_CombineStacks(button);
					DebuffFilter_ShowPlayerButton(button, index, texture, untilcancelled);
				else
					debufftype = GetPlayerBuffDispelType(index);

					if (debufftype) then
						color = DebuffTypeColor[debufftype];
					else
						color = DebuffTypeColor["none"];
					end

					width = width + 1;

					button = _G["DebuffFilter_PDebuffButton" .. width];

					if (not button) then
						button = CreateFrame("Button", "DebuffFilter_PDebuffButton" .. width, DebuffFilter_PDebuffFrame, "DebuffFilter_PDebuffButtonTemplate");
						button:EnableMouse(not DebuffFilter_PlayerConfig.lock);
						DebuffFilter_SetButtonLayout(DebuffFilter_PlayerConfig.pdebuff_layout, "DebuffFilter_PDebuffFrame", button, width);
					end

					button.border:SetVertexColor(color.r, color.g, color.b);
					button.count2:SetText("");
					DebuffFilter_ShowPlayerButton(button, index, texture, untilcancelled);

					DebuffFilter.Stacks.pdebuffs[nametexture] = width;
				end
			end
		end
	end

	for i = width+1, 8 do
		DebuffFilter_HideButton(_G["DebuffFilter_PDebuffButton" .. i]);
	end

	if (width == 0) then
		DebuffFilter_PDebuffFrameCount:SetText("");
	end

	for k in pairs(DebuffFilter.Stacks.pdebuffs) do
		DebuffFilter.Stacks.pdebuffs[k] = nil;
	end
end

function DebuffFilter_PBuffFrame_Update()
	if (not DebuffFilter_PlayerConfig.pbuffs) then
		return;
	end

	local button;
	local index, untilcancelled, name, texture;
	local dontcombine, texturefilter;
	local nametexture;
	local width = 0;

	for i = 1, 24 do
		index, untilcancelled = GetPlayerBuff(i, "HELPFUL");

		if (index < 1) then
			break;
		end

		DebuffFilter_PBuffFrameCount:SetText(i);

		name = GetPlayerBuffName(index);

		if (DebuffFilter_PlayerConfig.pbuff_list[name]) then
			texture = GetPlayerBuffTexture(index);
			dontcombine = DebuffFilter_PlayerConfig.pbuff_list[name].dontcombine;
			texturefilter = DebuffFilter_PlayerConfig.pbuff_list[name].texture;

			if (not texturefilter or string.match(texture, texturefilter)) then
				nametexture = name .. texture;

				if (not dontcombine and DebuffFilter.Stacks.pbuffs[nametexture]) then
					button = _G["DebuffFilter_PBuffButton" .. DebuffFilter.Stacks.pbuffs[nametexture]];

					DebuffFilter_CombineStacks(button);
					DebuffFilter_ShowPlayerButton(button, index, texture, untilcancelled);
				elseif (width < 8) then
					width = width + 1;

					button = _G["DebuffFilter_PBuffButton" .. width];

					if (not button) then
						button = CreateFrame("Button", "DebuffFilter_PBuffButton" .. width, DebuffFilter_PBuffFrame, "DebuffFilter_PBuffButtonTemplate");
						button:EnableMouse(not DebuffFilter_PlayerConfig.lock);
						DebuffFilter_SetButtonLayout(DebuffFilter_PlayerConfig.pbuff_layout, "DebuffFilter_PBuffFrame", button, width);
					end

					button.count2:SetText("");
					DebuffFilter_ShowPlayerButton(button, index, texture, untilcancelled);

					DebuffFilter.Stacks.pbuffs[nametexture] = width;
				end
			end
		end
	end

	for i = width+1, 8 do
		DebuffFilter_HideButton(_G["DebuffFilter_PBuffButton" .. i]);
	end

	if (width == 0) then
		DebuffFilter_PBuffFrameCount:SetText("");
	end

	for k in pairs(DebuffFilter.Stacks.pbuffs) do
		DebuffFilter.Stacks.pbuffs[k] = nil;
	end
end

function DebuffFilter_FDebuffFrame_Update()
	if (not DebuffFilter_PlayerConfig.fdebuffs) then
		return;
	end

	local button;
	local name, texture, applications, debufftype, duration, timeleft;
	local selfapplied, dontcombine, texturefilter;
	local nametexture, color;
	local width = 0;

	for i = 1, 8 do
		name, _, texture, applications, debufftype, duration, timeleft = UnitDebuff("focus", i);

		if (not texture) then
			break;
		end

		DebuffFilter_FDebuffFrameCount:SetText(i);

		if (DebuffFilter_PlayerConfig.fdebuff_list[name] or DebuffFilter_PlayerConfig.all_fdebuffs) then
			if (not DebuffFilter_PlayerConfig.all_fdebuffs) then
				selfapplied = DebuffFilter_PlayerConfig.fdebuff_list[name].selfapplied;
				dontcombine = DebuffFilter_PlayerConfig.fdebuff_list[name].dontcombine;
				texturefilter = DebuffFilter_PlayerConfig.fdebuff_list[name].texture;
			end

			if (not selfapplied or duration) and (not texturefilter or string.match(texture, texturefilter)) then
				nametexture = name .. texture;

				if (not dontcombine and DebuffFilter.Stacks.fdebuffs[nametexture]) then
					button = _G["DebuffFilter_FDebuffButton" .. DebuffFilter.Stacks.fdebuffs[nametexture]];

					DebuffFilter_CombineStacks(button);

					if (duration and duration > 0) then
						DebuffFilter_ShowButton(button, i, texture, applications, duration, timeleft, "focus");
					end
				else
					if (debufftype) then
						color = DebuffTypeColor[debufftype];
					else
						color = DebuffTypeColor["none"];
					end

					width = width + 1;

					button = _G["DebuffFilter_FDebuffButton" .. width];

					if (not button) then
						button = CreateFrame("Button", "DebuffFilter_FDebuffButton" .. width, DebuffFilter_FDebuffFrame, "DebuffFilter_DebuffButtonTemplate");
						button:EnableMouse(not DebuffFilter_PlayerConfig.lock);
						DebuffFilter_SetButtonLayout(DebuffFilter_PlayerConfig.fdebuff_layout, "DebuffFilter_FDebuffFrame", button, width);
					end

					button.border:SetVertexColor(color.r, color.g, color.b);
					button.count2:SetText("");
					DebuffFilter_ShowButton(button, i, texture, applications, duration, timeleft, "focus");

					DebuffFilter.Stacks.fdebuffs[nametexture] = width;
				end
			end
		end
	end

	for i = width+1, 8 do
		DebuffFilter_HideButton(_G["DebuffFilter_FDebuffButton" .. i]);
	end

	if (width == 0) then
		DebuffFilter_FDebuffFrameCount:SetText("");
	end

	for k in pairs(DebuffFilter.Stacks.fdebuffs) do
		DebuffFilter.Stacks.fdebuffs[k] = nil;
	end
end

function DebuffFilter_FBuffFrame_Update()
	if (not DebuffFilter_PlayerConfig.fbuffs) then
		return;
	end

	local button;
	local name, texture, applications, duration, timeleft;
	local selfapplied, dontcombine, texturefilter;
	local nametexture;
	local width = 0;

	for i = 1, 24 do
		name, _, texture, applications, duration, timeleft = UnitBuff("focus", i);

		if (not texture) then
			break;
		end

		DebuffFilter_FBuffFrameCount:SetText(i);

		if (DebuffFilter_PlayerConfig.fbuff_list[name] or DebuffFilter_PlayerConfig.all_fbuffs) then
			if (not DebuffFilter_PlayerConfig.all_fbuffs) then
				selfapplied = DebuffFilter_PlayerConfig.fbuff_list[name].selfapplied;
				dontcombine = DebuffFilter_PlayerConfig.fbuff_list[name].dontcombine;
				texturefilter = DebuffFilter_PlayerConfig.fbuff_list[name].texture;
			end

			if (not selfapplied or duration) and (not texturefilter or string.match(texture, texturefilter)) then
				nametexture = name .. texture;

				if (not dontcombine and DebuffFilter.Stacks.fbuffs[nametexture]) then
					button = _G["DebuffFilter_FBuffButton" .. DebuffFilter.Stacks.fbuffs[nametexture]];

					DebuffFilter_CombineStacks(button);

					if (duration and duration > 0) then
						DebuffFilter_ShowButton(button, i, texture, applications, duration, timeleft, "focus");
					end
				elseif (width < 16) then
					width = width + 1;

					button = _G["DebuffFilter_FBuffButton" .. width];

					if (not button) then
						button = CreateFrame("Button", "DebuffFilter_FBuffButton" .. width, DebuffFilter_FBuffFrame, "DebuffFilter_BuffButtonTemplate");
						button:EnableMouse(not DebuffFilter_PlayerConfig.lock);
						DebuffFilter_SetButtonLayout(DebuffFilter_PlayerConfig.fbuff_layout, "DebuffFilter_FBuffFrame", button, width);
					end

					button.count2:SetText("");
					DebuffFilter_ShowButton(button, i, texture, applications, duration, timeleft, "focus");

					DebuffFilter.Stacks.fbuffs[nametexture] = width;
				end
			end
		end
	end

	for i = width+1, 16 do
		DebuffFilter_HideButton(_G["DebuffFilter_FBuffButton" .. i]);
	end

	if (width == 0) then
		DebuffFilter_FBuffFrameCount:SetText("");
	end

	for k in pairs(DebuffFilter.Stacks.fbuffs) do
		DebuffFilter.Stacks.fbuffs[k] = nil;
	end
end

function DebuffFilter_OnEvent(event)
	if (event == "UNIT_AURA" and arg1 == "target") then
		DebuffFilter_DebuffFrame_Update();
		DebuffFilter_BuffFrame_Update();
	elseif (event == "PLAYER_TARGET_CHANGED") then
		DebuffFilter_DebuffFrame_Update();
		DebuffFilter_BuffFrame_Update();
	elseif (event == "PLAYER_AURAS_CHANGED") then
		DebuffFilter_PDebuffFrame_Update();
		DebuffFilter_PBuffFrame_Update();
	elseif (event == "UNIT_AURA" and arg1 == "focus") then
		DebuffFilter_FDebuffFrame_Update();
		DebuffFilter_FBuffFrame_Update();
	elseif (event == "PLAYER_FOCUS_CHANGED") then
		DebuffFilter_FDebuffFrame_Update();
		DebuffFilter_FBuffFrame_Update();
	elseif (event == "PLAYER_REGEN_DISABLED") then
		this:Show();
	elseif (event == "PLAYER_REGEN_ENABLED") then
		this:Hide();
	elseif (event == "VARIABLES_LOADED") then
		this:UnregisterEvent(event);
		DebuffFilter_Initialize();
	elseif (event == "PLAYER_LOGIN") then
		this:UnregisterEvent(event);
		this:SetScale(DebuffFilter_PlayerConfig.scale);
	end
end

function DebuffFilter_DebuffButton_OnUpdate(elapsed)
	if (not this.duration or this.duration == 0 or DebuffFilter_PlayerConfig.cooldowncount) then
		return;
	end

	this.update = this.update + elapsed;
	if (this.update >= 1) then
		this.update = this.update - 1;

		local _, _, _, _, _, _, timeleft = UnitDebuff(this.target, this.index);

		DebuffFilter_SetTime(this, timeleft);
	end
end

function DebuffFilter_BuffButton_OnUpdate(elapsed)
	if (not this.duration or this.duration == 0 or DebuffFilter_PlayerConfig.cooldowncount) then
		return;
	end

	this.update = this.update + elapsed;
	if (this.update >= 1) then
		this.update = this.update - 1;

		local _, _, _, _, _, timeleft = UnitBuff(this.target, this.index);

		DebuffFilter_SetTime(this, timeleft);
	end
end

function DebuffFilter_PButton_OnUpdate(elapsed)
	if (this.untilcancelled == 1) then
		return;
	end

	this.update = this.update + elapsed;
	if (this.update >= 1) then
		this.update = this.update - 1;

		local timeleft = GetPlayerBuffTimeLeft(this.index);

		if (not DebuffFilter_PlayerConfig.cooldowncount) then
			DebuffFilter_SetTime(this, timeleft);
		else
			if (not this.timer) then
				return;
			end

			local timertext = tonumber(this.timer.text:GetText());

			if (timertext and timertext < timeleft) then
				CooldownFrame_SetTimer(this.cooldown, GetTime(), timeleft, 1);
				this.cooldown:Hide();
			end
		end
	end
end

function DebuffFilter_CombineStacks(button)
	local total = (tonumber(button.count2:GetText()) or 1) + 1;
	button.count2:SetText(total);
end

-- taken from ctmod
function DebuffFilter_SetTime(button, time)
	time = floor(time or 0);

	local min, sec;

	if ( time >= 60 ) then
		min = floor(time/60);
		sec = time - min*60;
	else
		sec = time;
		min = 0;
	end

	if ( sec <= 9 ) then sec = "0" .. sec; end
	if ( min <= 9 ) then min = "0" .. min; end

	if (10 >= time) then
		button.time:SetTextColor(1, 0, 0);
	else
		button.time:SetTextColor(1, 0.82, 0);
	end

	button.time:SetText(min .. ":" .. sec);
end

function DebuffFilter_UpdateLayout(frame)
	local button;
	local name = DebuffFilter.Frames[frame].button;
	local layout_key = DebuffFilter.Frames[frame].layout_key;
	local layout = DebuffFilter_PlayerConfig[layout_key];

	for i = 1, 16 do
		button = _G[name .. i];

		if (not button) then
			break;
		end

		button:ClearAllPoints();
		DebuffFilter_SetButtonLayout(layout, frame, button, i);
	end

	DebuffFilter_SetCountOrientation(layout, frame);
end

function DebuffFilter_SetButtonLayout(layout, frame, button, index)
	local point, relpoint, x, y;
	local grow = layout.grow;
	local per_row = layout.per_row;
	local offset = 14;

	point, relpoint = DebuffFilter.Orientation[grow].point, DebuffFilter.Orientation[grow].relpoint;
	x, y = DebuffFilter.Orientation[grow].x, DebuffFilter.Orientation[grow].y;

	if (per_row == 1 or DebuffFilter_PlayerConfig.cooldowncount) then
		offset = 4;
		DebuffFilter_SetTimeOrientation(layout.time_lr, button);
	else
		DebuffFilter_SetTimeOrientation(layout.time_tb, button);
	end

	if (index > 1) then
		if (mod(index, per_row) == 1 or per_row == 1) then
			if (layout.grow == "rightdown" or layout.grow == "leftdown") then
				button:SetPoint("TOP", DebuffFilter.Frames[frame].button .. (index-per_row), "BOTTOM", 0, -offset);
			else
				button:SetPoint("BOTTOM", DebuffFilter.Frames[frame].button .. (index-per_row), "TOP", 0, offset);
			end
		else
			DebuffFilter_SetTimeOrientation(layout.time_tb, button);
			button:SetPoint(point, DebuffFilter.Frames[frame].button .. (index-1), relpoint, x, y)
		end
	else
		button:SetPoint(point, frame, point, 0, 0);
	end
end

function DebuffFilter_SetTimeOrientation(orientation, button)
	local point, relpoint, x, y;

	point, relpoint = DebuffFilter.Orientation[orientation].point, DebuffFilter.Orientation[orientation].relpoint;
	x, y = DebuffFilter.Orientation[orientation].x, DebuffFilter.Orientation[orientation].y;

	if (button.time) then
		button.time:ClearAllPoints();
		button.time:SetPoint(point, button, relpoint, x, y);
	else
		local time;
		local name = button;

		for i = 1, 16 do
			button = name .. i;
			time = _G[button .. "Duration"];

			if (not time) then
				break;
			end

			time:ClearAllPoints();
			time:SetPoint(point, button, relpoint, x, y);
		end
	end
end

function DebuffFilter_SetCountOrientation(layout, frame)
	local grow = layout.grow;
	local per_row = layout.per_row;

	count = _G[frame .. "Count"];
	count:ClearAllPoints();

	if (per_row > 1) then
		if (grow == "rightdown" or grow == "rightup") then
			count:SetPoint("RIGHT", frame, "LEFT", 0, 0);
		else
			count:SetPoint("LEFT", frame, "RIGHT", 0, 0);
		end
	else
		if (grow == "rightdown" or grow == "leftdown") then
			count:SetPoint("BOTTOM", frame, "TOP", 0, 8);
		else
			count:SetPoint("TOP", frame, "BOTTOM", 0, -8);
		end
	end
end

function DebuffFilter_LockFrames(lock)
	local button;

	for k, v in pairs(DebuffFilter.Frames) do
		_G[k]:EnableMouse(not lock);

		for i = 1, 16 do
			button = _G[v.button .. i];
			
			if (not button) then
				break;
			end

			button:EnableMouse(not lock);
		end
	end
end

function DebuffFilter_Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Debuff Filter|r: " .. msg);
end

function DebuffFilter_Options(opt)
	if (opt == "debuffs" or opt == "buffs" or opt == "pdebuffs" or opt == "pbuffs" or opt == "fdebuffs" or opt == "fbuffs") then
		for k, v in pairs(DebuffFilter.Frames) do
			if (v.option_key == opt) then
				if (DebuffFilter_PlayerConfig[v.option_key]) then
					DebuffFilter_PlayerConfig[v.option_key] = false;
					_G[k]:Hide();
				else
					DebuffFilter_PlayerConfig[v.option_key] = true;
					_G[k .. "_Update"]();
					_G[k]:Show();
				end

				break;
			end
		end
	elseif (opt == "count") then
		if (DebuffFilter_PlayerConfig.count) then
			DebuffFilter_PlayerConfig.count = false;
			for k in pairs(DebuffFilter.Frames) do
				_G[k .. "Count"]:Hide();
			end
		else
			DebuffFilter_PlayerConfig.count = true;
			for k in pairs(DebuffFilter.Frames) do
				_G[k .. "Count"]:Show();
			end
		end
	elseif (opt == "cooldowncount") then
		local button;

		if (DebuffFilter_PlayerConfig.cooldowncount) then
			DebuffFilter_PlayerConfig.cooldowncount = false;
			for k, v in pairs(DebuffFilter.Frames) do
				for i = 1, 16 do
					button = _G[v.button .. i];

					if (not button) then
						break;
					end

					button.cooldown:Hide();

					if (button.timer) then
						button.timer:Hide();
					end
				end

				DebuffFilter_UpdateLayout(k);
				_G[k .. "_Update"]();
			end
		else
			DebuffFilter_PlayerConfig.cooldowncount = true;
			for k, v in pairs(DebuffFilter.Frames) do
				for i = 1, 16 do
					button = _G[v.button .. i];

					if (not button) then
						break;
					end

					button.time:Hide();
				end

				DebuffFilter_UpdateLayout(k);
				_G[k .. "_Update"]();
			end
		end
	elseif (opt == "combat") then
		if (DebuffFilter_PlayerConfig.combat) then
			DebuffFilter_PlayerConfig.combat = false;
			DebuffFilterFrame:UnregisterEvent("PLAYER_REGEN_DISABLED");
			DebuffFilterFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
			DebuffFilterFrame:Show();
		else
			DebuffFilter_PlayerConfig.combat = true;
			DebuffFilterFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
			DebuffFilterFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
			if (not UnitAffectingCombat("player")) then
				DebuffFilterFrame:Hide();
			end
		end
	elseif (opt == "tooltips") then
		if (DebuffFilter_PlayerConfig.tooltips) then
			DebuffFilter_PlayerConfig.tooltips = false;
		else
			DebuffFilter_PlayerConfig.tooltips = true;
		end
	elseif (opt == "lock") then
		if (DebuffFilter_PlayerConfig.lock) then
			DebuffFilter_PlayerConfig.lock = false;
			DebuffFilter_LockFrames(false);
		else
			DebuffFilter_PlayerConfig.lock = true;
			DebuffFilter_LockFrames(true);
		end
	elseif (opt == "backdrop") then
		if (DebuffFilter.backdrop) then
			DebuffFilter.backdrop = false;
			for k in pairs(DebuffFilter.Frames) do
				_G[k .. "Backdrop"]:Hide();
			end
		else
			DebuffFilter.backdrop = true;
			for k in pairs(DebuffFilter.Frames) do
				_G[k .. "Backdrop"]:Show();
			end
		end
	end
end

function DebuffFilter_Command(cmd)
	cmd = string.lower(cmd);

	if (cmd == "allpd" or cmd == "allfd" or cmd == "allfb") then
		for k, v in pairs(DebuffFilter.Frames) do
			if (v.all_cmd == cmd) then
				local all_key = "all_" .. v.option_key;

				if (DebuffFilter_PlayerConfig[all_key]) then
					DebuffFilter_PlayerConfig[all_key] = false;
					_G[k .. "_Update"]();
					DebuffFilter_Print("display all " .. v.name .. "s disabled.");
				else
					DebuffFilter_PlayerConfig[all_key] = true;
					_G[k .. "_Update"]();
					DebuffFilter_Print("display all " .. v.name .. "s enabled.");
				end

				break;
			end
		end
	elseif (cmd == "resetpos") then
		DebuffFilter_DebuffFrame:ClearAllPoints();
		DebuffFilter_DebuffFrame:SetPoint("CENTER", UIParent, "CENTER", -40, 0);
		DebuffFilter_BuffFrame:ClearAllPoints();
		DebuffFilter_BuffFrame:SetPoint("LEFT", DebuffFilter_DebuffFrame, "RIGHT", 70, 0);
		DebuffFilter_PDebuffFrame:ClearAllPoints();
		DebuffFilter_PDebuffFrame:SetPoint("TOP", DebuffFilter_DebuffFrame, "BOTTOM", 0, -30);
		DebuffFilter_PBuffFrame:ClearAllPoints();
		DebuffFilter_PBuffFrame:SetPoint("LEFT", DebuffFilter_PDebuffFrame, "RIGHT", 70, 0);
		DebuffFilter_FDebuffFrame:ClearAllPoints();
		DebuffFilter_FDebuffFrame:SetPoint("TOP", DebuffFilter_PDebuffFrame, "BOTTOM", 0, -30);
		DebuffFilter_FBuffFrame:ClearAllPoints();
		DebuffFilter_FBuffFrame:SetPoint("LEFT", DebuffFilter_FDebuffFrame, "RIGHT", 70, 0);
	elseif (cmd == "status") then
		DebuffFilter_Print("current settings:");
		DebuffFilter_Print("show all player debuffs: |cff00ccff" .. tostring(DebuffFilter_PlayerConfig.all_pdebuffs) .. "|r");
		DebuffFilter_Print("show all focus target debuffs: |cff00ccff" .. tostring(DebuffFilter_PlayerConfig.all_fdebuffs) .. "|r");
		DebuffFilter_Print("show all focus target buffs: |cff00ccff" .. tostring(DebuffFilter_PlayerConfig.all_fbuffs) .. "|r");
	elseif (cmd == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Debuff Filter commands:");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffconfig|r: display the configuration menu.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffallpd|r || |cff00ccffallfd|r || |cff00ccffallfb|r: display all player debuffs or focus target debuffs and buffs.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffresetpos|r: resets frame positions.");
		DEFAULT_CHAT_FRAME:AddMessage("/dfilter |cff00ccffstatus|r: display current command-line settings.");
		DEFAULT_CHAT_FRAME:AddMessage("To move the frames, shift+left click and drag a backdrop or a monitored debuff/buff.");
		DEFAULT_CHAT_FRAME:AddMessage("To change the frame or time orientation, shift+right click or ctrl+right click, respectively.");
	else
		if (not DebuffFilterOptionsFrame:IsVisible()) then
			ShowUIPanel(DebuffFilterOptionsFrame);
		else
			HideUIPanel(DebuffFilterOptionsFrame);
		end
	end
end