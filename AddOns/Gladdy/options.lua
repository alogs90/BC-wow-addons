local self = Gladdy
local L = LibStub("AceLocale-3.0"):GetLocale("Gladdy", true)
local LSM = LibStub("LibSharedMedia-3.0")

LSM:Register("statusbar", "Minimalist", "Interface\\Addons\\Gladdy\\statusbar\\Minimalist")

local statusbars = {}
for _, name in pairs(LSM:List(LSM.MediaType.STATUSBAR)) do
	statusbars[name] = name
end

local defaults = {
	profile = {
        x=0,
		y=0,
		frameScale = 1,
		barWidth=150,
		barHeight=25,
		manaBarHeight=15,
		castBarHeight=12,
		padding=5,
		frameColor = {r = 0, g = 0, b = 0, a = .3},
		manaColor = {r = .18, g = .44, b = .75, a = 1},
		energyColor = {r = 1, g = 1, b = 0, a = 1},
		rageColor = {r = 1, g = 0, b = 0, a = 1},
		selectedFrameColor = {r = 1, g = .7, b = 0, a = 1},
		focusBorderColor = {r = 1, g = 0, b = 0, a = 1},
		leaderBorderColor = {r = 0, g = 1, b = 0, a = 1},
		castBarColor = {r = 1, g = 1, b = 0, a = 1},
		manaFontColor = {r = 2.55, g = 2.55, b = 2.55, a = 1},
		healthFontColor = {r = 2.55, g = 2.55, b = 2.55, a = 1},
		castBarFontColor = {r = 2.55, g = 2.55, b = 2.55, a = 1},
		petBarFontColor = {r = 2.55, g = 2.55, b = 2.55, a = 1},
		auraFontColor = {r = 0, g = 1, b = 0, a = 1},
		drFontColor = {r = 0, g = 1, b = 0, a = 1},
		healthColor = {r = 0.20, g = 0.90, b = 0.20, a = 1},
		healthBarColor = {r = 0.95, g = 0.95, b = 0.95, a = 1},
		castBarBgColor = {r = 1, g = 1, b = 1, a = 0.3},
		healthBarClassColor = true,
		healthFontSize = 11,
		manaFontSize = 10,
		castBarFontSize = 9,
		auraFontSize = 16,
		drFontSize = 13,
		barTexture = "Minimalist",
		barBottomMargin = 8,
		highlight = true,
		selectedBorder = true,
		focusBorder = true,
		leaderBorder = true,
		manaDefault = true,
		energyDefault = true,
		rageDefault = true,
		locked=false,
		manaText=true,
		manaPercentage=false,
		manaActual=true,
		manaMax=true,
		healthPercentage=true,
		healthActual=false,
		healthMax=false,
		shortHpMana=true,
		raceText=true,
		specText=true,
		castBar=true,
		powerBar=true,
		trinketStatus=false,
		frameResize=true,
		enemyAnnounce=false,
		specAnnounce=false,
		trinketUpAnnounce=false,
		trinketUsedAnnounce=false,
		lowHealthAnnounce=false,
		lowHealthPercentage=30,
		drinkAnnounce=false,
		resAnnounce=false,
		growUp=false,
		cliqueSupport=false,
		trinketDisplay="bigIcon",
		bigTrinketScale=1,
		announceType="party",
		attributes = {
			{ name = "Target", button = "1", modifier = "", action = "target", spell = ""},
			{ name = "Focus", button = "2", modifier = "", action = "focus", spell = ""},
		},
		auras = {},
		drCooldown = false,
		drCooldownPos = "LEFT",
		drCooldownAnchor = "TOP",
		drMargin = 5,
		drIconSize = 30,
		drIconAdjust = true,
		drNoCooldownCount = false,
		drText = true,
		drList = {},
	}
}

function Gladdy:GetDefaults()
	return defaults
end

for k, v in pairs(self:GetAuraList()) do
	table.insert(defaults.profile.auras, { name = k, priority = v, deleted = false })
end

for i=3, 10 do
	table.insert(defaults.profile.attributes, {name = string.format(L["Action #%d"], i), modifier = "", button = "", action = "disabled", spell = ""})
end

local function slashHandler(option)
	-- Mayhaps use Ace to handle slash command? It leaves something to be desired, methinks. -kremonted
	option = string.lower(option)

	if option == "ui" or option == "config" or option == "options" then
		self:ShowOptions()
	elseif option == "test1" then
		self:ToggleFrame(1)
	elseif option == "test2" then
		self:ToggleFrame(2)
	elseif option == "test3" then
		self:ToggleFrame(3)
	elseif option == "test4" then
		self:ToggleFrame(4)
	elseif option == "test5" or option == "test" then
		self:ToggleFrame(5)
    elseif option == "trinket" then
        self:TrinketUsed("arena1")
	elseif option == "hide" then
		self:HideFrame()
	else
		self:Print(L["Valid slash commands are:"])
		self:Print("/gladdy ui")
		self:Print("/gladdy test1-5")
        self:Print("/gladdy trinket")
		self:Print("/gladdy hide")
	end
end

local function getOption(info)
  	return (info.arg and self.db.profile[info.arg] or self.db.profile[info[#info]])
end

local function setOption(info, value)
  	local key = info.arg or info[#info]
  	self.db.profile[key] = value
  	self:UpdateFrame()
end

local function getColorOption(info)
  	local key = info.arg or info[#info]
  	return self.db.profile[key].r, self.db.profile[key].g, self.db.profile[key].b, self.db.profile[key].a
end

local function setColorOption(info, r, g, b, a)
  	local key = info.arg or info[#info]
  	self.db.profile[key].r, self.db.profile[key].g, self.db.profile[key].b, self.db.profile[key].a = r, g, b, a
  	self:UpdateFrame()
end

local function setAura(info, value)
	self.db.profile.auras[tonumber(info[#(info) - 1])][info[(#info)]] = value

	if ( info[#(info)] == "name" ) then
		self.options.args.auras.args.list.args[info[#(info) - 1]].name = value
	end

	self:ConvertAuraList()
	self:UpdateFrame()
end

local function getAura(info)
	return self.db.profile.auras[tonumber(info[#(info) - 1])][info[(#info)]]
end

local function setAttribute(info, value)
	self.db.profile.attributes[tonumber(info[#(info) - 1])][info[(#info)]] = value

	if ( info[#(info)] == "name" ) then
		self.options.args.clicks.args[info[#(info) - 1]].name = value
	end

	self:UpdateFrame()
end

local function getAttribute(info)
	return self.db.profile.attributes[tonumber(info[#(info) - 1])][info[(#info)]]
end

local modifiers = {[""] = L["None"], ["ctrl-"] = L["CTRL"], ["shift-"] = L["SHIFT"], ["alt-"] = L["ALT"]}
local buttons = {["1"] = L["Left button"], ["2"] = L["Right button"], ["3"] = L["Middle button"], ["4"] = L["Button 4"], ["5"] = L["Button 5"]}
local clickValues = {["macro"] = MACRO, ["target"] = TARGET, ["focus"] = FOCUS, ["spell"] = L["Cast Spell"], ["disabled"] = ADDON_DISABLED}

local announceValues = {
   ["self"] = L["Self"],
   ["party"] = L["Party"],
   ["say"] = L["Say"],
   ["rw"] = L["Raid Warning"],
   ["sct"] = L["Scrolling Combat Text"],
   ["msbt"] = L["MikScrollingBattleText"],
   ["fct"] = L["Blizzard's Floating Combat Text"],
   ["parrot"] = L["Parrot"],
   ["sa"] = L["SpellAlert"],
}

local function SetupAttributeOption(number)
	local attribute = {
		order = number,
		type = "group",
		name = self.db.profile.attributes[number].name,
		desc = self.db.profile.attributes[number].name,
		get = getAttribute,
		set = setAttribute,
		args = {
			name = {
				type = "input",
				name = L["Name"],
				desc = L["Select the name of the click option"],
				order=1,
			},
			button = {
				type = "select",
				name = L["Button"],
				desc = L["Select which mouse button to use"],
				values=buttons,
				order=2,
			},
			modifier = {
				type = "select",
				name = L["Modifier"],
				desc = L["Select which modifier to use"],
				values = modifiers,
				order=3,
			},
			action = {
				type = "select",
				name = L["Action"],
				desc = L["Select what action this mouse button does"],
				values=clickValues,
				order=4,
			},
			spell = {
				type = "input",
				multiline = true,
				name = L["Spell name / Macro text"],
				desc = L["Spell name / Macro text"],
				order=5,
			},
		},
	}
	
	return attribute
end

local function SetupAuraOption(number)
	local aura = {
		type = "group",
		name = self.db.profile.auras[number].name,
		desc = self.db.profile.auras[number].name,
		get = getAura,
		set = setAura,
		args = {
			name = {
				type = "input",
				name = L["Name"],
				desc = L["Name of the aura"],
				order=1,
			},
			priority = {
				type= "range",
				name = L["Priority"],
				desc = L["Select what priority the aura should have - higher equals more priority"],
				min=0,
				max=5,
				step=1,
				order=2,
			},
			delete = {
				type = "execute",
				name = L["Delete"],
				func = function(info)
				
					local defaultAuras = self:GetAuraList()
					local name = self.db.profile.auras[tonumber(info[#(info) - 1])].name
					self.db.profile.auraAnnounceList[name] = nil
					
					-- check if it's a default aura, thus it can't really get deleted and it'll just set the deleted variable to true instead
					if ( defaultAuras[name] ) then
						self.db.profile.auras[tonumber(info[#(info) - 1])].deleted = true
					else
						table.remove(self.db.profile.auras, tonumber(info[#(info) - 1]))
					end
					
					self.options.args.auras.args.list.args = {}
					for i=#(self.db.profile.auras), 1, -1 do
						if ( not self.db.profile.auras[i].deleted ) then
							self.options.args.auras.args.list.args[tostring(i)] = SetupAuraOption(i)
						end
					end
					
					self:ConvertAuraList()
				end,
			},
		},
	}
	return aura
end

function Gladdy:SetupOptions()
    local newAuraPrio = 3
	local newAuraName = "Aura name"
    
    local trinketValues = {
		["nameText"] = L["Name text"],
		["nameIcon"] = L["Name icon"],
		["bigIcon"] = L["Big icon"],
		["overrideIcon"] = L["Override class/aura icon"],
		["smallIcon"] = L["Small icon"],
		["gridIcon"] = L["Grid-style icon"],
	}
    
    self.options = {
        type = "group",
        name = L["Gladdy"],
        plugins = {},
        get = getOption,
        set = setOption,
        args = {
            general = {
                type = "group",
                name = L["General"],
                desc = L["General settings"],
                order = 1,
                args = {
                    locked = {
                        type = "toggle",
                        name = L["Lock frame"],
                        desc = L["Toggle if frame can be moved"],
                        order = 1,
                    },
                    growUp = {
                        type = "toggle",
                        name = L["Grow frame upwards"],
                        desc = L["If enabled the frame will grow upwards instead of downwards"],
                        order = 2,
                    },
                    frameResize = {
                        type = "toggle",
                        name = L["Frame resize"],
                        desc = L["If enabled the frame will update height depending on current bracket"],
                        order = 3,
                    },
                    frameScale = {
                        type = "range",
                        name = L["Frame scale"],
                        desc = L["Scale of the frame"],
                        order = 4,
                        min = 0.1,
                        max = 2,
                        step = 0.1,
                    },
                    padding = {
                        type = "range",
                        name = L["Frame padding"],
                        desc = L["Padding of the frame"],
                        order = 5,
                        min = 0,
                        max = 20,
                        step = 1,
                    },
                    frameColor = {
                        type = "color",
                        name = L["Frame color"],
                        desc = L["Color of the frame"],
                        order = 6,
                        hasAlpha = true,
                        get = getColorOption,
                        set = setColorOption,
                    },
                    highlight = {
                        type = "toggle",
                        name = L["Highlight target"],
                        desc = L["Toggle if the selected target should be highlighted"],
                        order = 7,
                    },
                    selectedBorder = {
                        type = "toggle",
                        name = L["Show border around target"],
                        desc = L["Toggle if a border should be shown around the selected target"],
                        order  = 8,
                    },
                    focusBorder = {
                        type = "toggle",
                        name = L["Show border around focus"],
                        desc = L["Toggle of a border should be shown around the current focus"],
                        order = 9,
                    },
                    leaderBorder = {
                        type = "toggle",
                        name = L["Show border around raid leader"],
                        desc = L["Toggle if a border should be shown around the raid leader"],
                        order = 10,
                    },
                    cliqueSupport = {
						type = "toggle",
						name = L["Clique support"],
						desc = L["Toggles the Clique support, requires UI reload to take effect"],					
						order = 11,
					},
                    announcements = {
                        type = "group",
                        name = L["Announcements"],
                        desc = L["Set options for different announcements"],
                        order = 12,
                        args = {
                            announceType = {
                                type = "select",
                                name = L["Announce type"],
                                desc = L["How should we announce"],
                                order = 1,
                                values = announceValues,
                            },
                            enemyAnnounce = {
                                type = "toggle",
                                name = L["New enemies"],
                                desc = L["Announce new enemies found"],
                                order = 2,
                            },
                            specAnnounce = {
								type = "toggle",
								name = L["Talent spec detection"],
								desc = L["Announce when an enemy's talent spec is discovered"],
								order = 3,
							},
							drinkAnnounce = {
								type = "toggle",
								name = L["Drinking"],
								desc = L["Announces enemies that start to drink"],
								order = 4,
							},
							resAnnounce = {
								type = "toggle",
								name = L["Resurrections"],
								desc = L["Announces enemies who starts to cast a resurrection spell"],
								order = 5,
							},
							trinketUsedAnnounce = {
								type = "toggle",
								name = L["Trinket used"],
								desc = L["Announce when an enemy's trinket is used"],
								order = 6,
							},
							trinketUpAnnounce = {
								type = "toggle",
								name = L["Trinket ready"],
								desc = L["Announce when an enemy's trinket is ready again"],
								order = 7,
							},
							lowHealthAnnounce = {
								type = "toggle",
								name = L["Enemies on low health"],
								desc = L["Announce enemies that go below a certain percentage of health"],
								order = 8,
							},
							lowHealthPercentage = {
								type = "range",
								name = L["Low health percentage"],
								desc = L["The percentage when enemies are counted as having low health"],
                                order = 9,
								min = 1,
								max = 100,
								step = 1,
								disabled = function() return not self.db.profile.lowHealthAnnounce end,						
							},	
                        },
                    },
                    trinket = {
                        type = "group",
                        name = L["Trinket display"],
						desc = L["Set options for the trinket status display"],
                        order = 13,
                        args = {
                            trinketStatus = {
								type="toggle",
								name = L["Show PvP trinket status"],
								desc = L["Show PvP trinket status to the right of the enemy name"],
								order = 1,
							},
							trinketDisplay = {
								type = "select",
								name = L["Trinket display"],
								desc = L["Choose how to display the trinket status"],
								values = trinketValues,
								disabled = function() return not self.db.profile.trinketStatus end,
								order = 2,
							},
							bigTrinketScale = {
								type = "range",
								name = L["Big icon scale"],
								desc = L["The scale of the big trinket icon"],
								min = 0.1,
								max = 2,
								step = 0.1,
								disabled = function() return not self.db.profile.trinketStatus or self.db.profile.trinketDisplay ~= "bigIcon" end,						
								order=3,
							},
                        },
                    },
                },
            },
            bars = {
                type = "group",
                name = L["Bars"],
                desc = L["Bars settings"],
                order = 2,
                args = {
                    castBar = {
                        type="toggle",
						name = L["Show cast bars"],
						desc = L["Show cast bars"],
						order = 1,
					},
					powerBar = {
						type = "toggle",
						name = L["Show power bars"],
						desc = L["Show power bars"],
						order = 2,
					},
                    barsizes = {
                        type = "group",
                        name = L["Size and margin"],
						desc = L["Size and margin settings"],
                        order = 3,
                        args = {
                            barWidth = {
                                type = "range",
                                name = L["Bar width"],
                                desc = L["Width of the health/power bars"],
                                order = 1,
                                min = 20,
                                max = 500,
                                step = 5,
                            },
                            barHeight = {
                                type = "range",
                                name = L["Bar height"],
                                desc = L["Width of the health bar"],
                                order = 2,
                                min = 5,
                                max = 50,
                                step = 1,
                            },
                            manaBarHeight = {
                                type = "range",
                                name = L["Power bar height"],
                                desc = L["Height of the power bar"],
                                order = 3,
                                min = 5,
                                max = 20,
                                step = 1,
                                disabled = function() return not self.db.profile.powerBar end,
                            },
                            castBarHeight = {
                                type = "range",
                                name = L["Cast bar height"],
                                desc = L["Height of the cast bar"],
                                order = 4,
                                min = 5,
                                max = 50,
                                step = 1,
                                disabled = function() return not self.db.profile.castBar end,
                            },
                            barBottomMargin = {
								type = "range",
								name = L["Bar bottom margin"],
								desc = L["Margin to the next bar"],
                                order = 7,
								min = 0,
								max = 30,
								step = 1,
							},
                        },
                    },
                    barcolors = {
                        type = "group",
                        name = L["Colors"],
                        desc = L["Color settings"],
                        order = 4,
                        args = {
                            healthBarClassColor = {
								type = "toggle",
								name = L["Color by class"],
								desc = L["Color the health bar by class"],
								order = 1,
							},
                            healthBarColor = {
								type = "color",
								name = L["Health bar color"],
								desc = L["Color of the health bar"],
								order = 2,
                                hasAlpha=true,
								get = getColorOption,
								set = setColorOption,
                                disabled = function() return self.db.profile.healthBarClassColor end,
							},
							barTexture = {
								type = "select",
								name = L["Bar texture"],
                                desc = L["Texture of health/cast bars"],
                                order = 3,
								dialogControl = "LSM30_Statusbar",
								values = AceGUIWidgetLSMlists.statusbar,
								get=function(info)
									return self.db.profile.barTexture
								end,
								set=function(info, v)
									self.db.profile.barTexture = v
									self:UpdateFrame()
								end,
							},
                            selectedFrameColor = {
                                type = "color",
                                name = "Selected border color",
                                desc = "Color of the selected targets border",
                                order = 4,
                                hasAlpha = true,
                                get = getColorOption,
                                set = setColorOption,
                            },
                            focusBorderColor = {
                                type = "color",
                                name = "Focus border color",
                                desc = "Color of the focus border",
                                order = 5,
                                hasAlpha = true,
                                get = getColorOption,
                                set = setColorOption,
                            },
                            leaderBorderColor = {
                                type = "color",
                                name = "Raid leader border color",
                                desc = "Color of the raid leader border",
                                order = 6,
                                hasAlpha = true,
                                get = getColorOption,
                                set = setColorOption,
                            },
                            manaColor = {
								type = "color",
								name = L["Mana color"],
								desc = L["Color of the mana bar"],
								order = 7,
                                hasAlpha = true,
								get = getColorOption,
								set = setColorOption,
                                disabled = function() return not self.db.profile.powerBar or self.db.profile.manaDefault end,
							},
							manaDefault = {
								type = "toggle",
								name = L["Game default"],
								desc = L["Use game default mana color"],
								order = 8,
							},
                            energyColor = {
                                type = "color",
                                name = L["Energy color"],
                                desc = L["Color of the energy bar"],
                                order = 9,
                                hasAlpha = true,
								get = getColorOption,
								set = setColorOption,
                                disabled = function() return not self.db.profile.powerBar or self.db.profile.energyDefault end,
                            },
                            energyDefault = {
                                type = "toggle",
                                name = L["Game default"],
                                desc = L["Use game default energy color"],
                                order = 10,
                            },
                            rageColor = {
                                type = "color",
                                name = L["Rage color"],
                                desc = L["Color of the rage bar"],
                                order = 11,
                                hasAlpha = true,
								get = getColorOption,
								set = setColorOption,
                                disabled = function() return not self.db.profile.powerBar or self.db.profile.rageDefault end,
                            },
                            rageDefault = {
                                type = "toggle",
                                name = L["Game default"],
                                desc = L["Use game default rage color"],
                                order = 12,
                            },
                            castBarColor = {
								type = "color",
								name = L["Cast bar color"],
								desc = L["Color of the cast bar"],
								order = 13,
                                hasAlpha=true,
								get = getColorOption,
								set = setColorOption,
								disabled = function() return not self.db.profile.castBar end,
							},
							castBarBgColor = {
								type = "color",
								name = L["Cast bar background color"],
								desc = L["Color of the cast bar background"],
                                order = 14,
                                hasAlpha = true,								
								get = getColorOption,
								set = setColorOption,
                                disabled = function() return not self.db.profile.castBar end,
							},
                        },
                    },
                },
            },
            text = {
                type = "group",
                name = L["Text"],
                desc = L["Text settings"],
                order = 3,
                args = {
                    shortHpMana = {
						type = "toggle",
						name = L["Shorten Health/Power text"],
						desc = L["Shorten the formatting of the health and power text to e.g. 20.0/25.3 when the amount is over 9999"],
						order = 1,
					},
					healthPercentage = {
						type = "toggle",
						name = L["Show health percentage"],
						desc = L["Show health percentage on the health bar"],
						order = 2,
					},
					healthActual = {
						type="toggle",
						name = L["Show the actual health"],
						desc = L["Show the actual health on the health bar"],
						order = 3,
					},
					healthMax = {
						type = "toggle",
						name = L["Show max health"],
						desc = L["Show maximum health on the health bar"],
						order = 4,
					},					
					manaText = {
						type = "toggle",
						name = L["Show power text"],
						desc = L["Show mana/energy/rage text on the power bar"],
						disabled = function() return not self.db.profile.powerBar end,
						order = 5,
					},
					manaPercentage = {
						type = "toggle",
						name = L["Show power percentage"],
						desc = L["Show mana/energy/rage percentage on the power bar"],
						disabled = function() return not self.db.profile.powerBar or not self.db.profile.manaText end,
						order = 6,
					},
					manaActual = {
						type = "toggle",
						name = L["Show the actual power"],
						desc = L["Show the actual mana/energy/rage on the power bar"],
						disabled = function() return not self.db.profile.powerBar or not self.db.profile.manaText end,
						order = 7,
					},
					manaMax = {
						type = "toggle",
						name = L["Show max power"],
						desc = L["Show maximum mana/energy/rage on the power bar"],
						disabled = function() return not self.db.profile.powerBar or not self.db.profile.manaText end,
						order = 8,
					},
					raceText = {
						type = "toggle",
						name = L["Show race text"],
						desc = L["Show race text on the power bar"],
						disabled = function() return not self.db.profile.powerBar end,
						order = 9,
					},
					specText = {
						type = "toggle",
						name = L["Show spec text"],
						desc = L["Show spec text on the power bar"],
						disabled = function() return not self.db.profile.powerBar end,
						order = 10,
					},
					drText = {
						type = "toggle",
						name = L["Show DR text"],
						desc = L["Show DR text on the icons"],
						disabled = function() return not self.db.profile.drCooldown end,
						order = 11,
					},
                    textsizes = {
                        type = "group",
                        name = "Sizes",
                        desc = "Size settings",
                        order = 12,
                        args = {
                            healthFontSize = {
								type = "range",
								name = L["Health text size"],
								desc = L["Size of the health bar text"],
                                order = 1,
								min = 1,
								max = 20,
								step = 1,								
							},
							manaFontSize = {
								type = "range",
								name = L["Mana text size"],
								desc = L["Size of the mana bar text"],
								disabled = function() return not self.db.profile.powerBar end,
                                order = 2,
								min = 1,
								max = 20,
								step = 1,
							},						
							castBarFontSize = {
								type = "range",
								name = L["Cast bar text size"],
								desc = L["Size of the cast bar text"],
								disabled = function() return not self.db.profile.castBar end,
                                order = 3,
								min = 1,
								max = 20,
								step = 1,
							},
							auraFontSize = {
								type = "range",
								name = L["Aura text size"],
								desc = L["Size of the aura text"],
								disabled = function() return not self.db.profile.auras end,
                                order = 4,
								min = 1,
								max = 20,
								step = 1,
							},
							drFontSize = {
								type = "range",
								name = L["DR text size"],
								desc = L["Size of the DR text"],
                                disabled = function() return not self.db.profile.drCooldown end,
                                order = 5,
								min=  1,
								max = 20,
								step = 1,
							},
                        },
                    },
                    colors = {
                        type = "group",
                        name = L["Colors"],
                        desc = L["Color settings"],
                        order = 13,
                        args = {
                            healthFontColor = {
								type = "color",
								name = L["Health text color"],
								desc = L["Color of the health bar text"],
                                order = 1,
                                hasAlpha = true,
								get = getColorOption,
								set = setColorOption,
							},
							manaFontColor = {
								type = "color",
								name = L["Mana text color"],
								desc = L["Color of the mana bar text"],
                                order = 2,
                                hasAlpha = true,
								get = getColorOption,
								set = setColorOption,
								disabled = function() return not self.db.profile.powerBar end,
							},
							castBarFontColor = {
								type = "color",
								name = L["Cast bar text color"],
								desc = L["Color of the cast bar text"],
                                order = 3,
                                hasAlpha = true,
								get = getColorOption,
								set = setColorOption,
								disabled = function() return not self.db.profile.castBar end,
							},
							auraFontColor = {
								type = "color",
								name = L["Aura text color"],
								desc = L["Color of the aura text"],
                                order = 4,
                                hasAlpha = true,
								get = getColorOption,
								set = setColorOption,
								disabled = function() return not self.db.profile.auras end,
							},
							drFontColor = {
								type = "color",
								name = L["DR text color"],
								desc = L["Color of the DR text"],
								order = 5,
                                hasAlpha = true,
								get = getColorOption,
								set = setColorOption,
                                disabled = function() return not self.db.profile.drCooldown end,
							},
                        },
                    },
                },
            },
            drtracker = {
                type = "group",
                name = L["DR tracker"],
                desc = L["DR settings"],
                order = 4,
                args =  {
                    drCooldown = {
                        type = "toggle",
                        name = L["Show icons"],
                        desc = L["Show DR cooldown icons"],
                        order = 1,
                    },
                    drCooldownPos = {
                        type = "select",
                        name = "DR cooldown position",
                        desc = "Position of the DR icons",
                        order = 2,
                        values = {
                            ["LEFT"] = L["Left"],
                            ["RIGHT"] = L["Right"],
                        },
                    },
                    drIconAdjust = {
                        type = "toggle",
                        name = "Adjust Icon Size",
                        desc = "Adjust Icon Size on the Unit's Height",
                        order = 3,
                    },
                    drIconSize = {
                        type = "range",
                        name = L["Icon Size"],
                        desc = L["Size of the DR Icons"],
                        order = 4,
                        min = 5,
                        max = 100,
                        step = 1,
                        disabled = function() return self.db.profile.drIconAdjust end,
                    },
                    drCooldownAnchor = {
                        type = "select",
                        name = L["DR Cooldown anchor"],
                        desc = L["Anchor of the cooldown icons"],
                        order = 5,
                        values = {
                            ["TOP"] = L["Top"],
                            ["CENTER"] = L["Center"],
                            ["BOTTOM"] = L["Bottom"],
                        },
                        disabled = function() return self.db.profile.drIconAdjust end,
                    },
                },
            },
            auras = {
                type = "group",
                name = L["Auras"],
                desc = L["Aura settings"],
                order = 5,
                args = {
                    new = {
                        type = "group",
                        name = L["Add new aura"],
                        desc = L["Add new aura"],
                        order = 1,
                        args = {
                            name = {
                                type = "input",
                                name = L["Name"],
                                desc = L["Name of the aura"],
                                order = 1,
                                get = function() return newAuraName end,
                                set = function(info, value) newAuraName = value end,
                            },
                            priority = {
                                type= "range",
                                name = L["Priority"],
                                desc = L["Select what priority the aura should have - higher equals more priority"],
                                order = 2,
                                min=1,
                                max=5,
                                step=1,
                                get = function() return newAuraPrio end,
                                set = function(info, value) newAuraPrio = value end,
                            },
                            Add = {
                                type = "execute",
                                name = L["Add"],
                                desc = L["Add an aura"],
                                order = 3,
                                func = function()
                                    if ( newAuraName ~= "") then
                                        table.insert(self.db.profile.auras, { name = newAuraName, priority = newAuraPrio })
                                        self.db.profile.auraAnnounceList[newAuraName] = newAuraAnnounce
                                        newAuraName = ""
                                        self.options.args.auras.args.list.args = {}
                                        for i=#(self.db.profile.auras), 1, -1 do
                                            if ( not self.db.profile.auras[i].deleted ) then
                                                self.options.args.auras.args.list.args[tostring(i)] = SetupAuraOption(i)
                                            end
                                        end
                                        self:ConvertAuraList()
                                    end
                                end,
                            },
                        },
                    },
                    list = {
                        type = "group",
                        name = L["Aura list"],
                        desc = L["List of enabled auras"],
                        order = 2,
                        args = {},
                    },
                },
            },
        },
    }
    
    if ( type(self.db.profile.auras) == "boolean" ) then
		self.db.profile.displayAuras = self.db.profile.auras
		self.db.profile.auras = defaults.profile.auras
	end
	
	for i=#(self.db.profile.auras), 1, -1 do
		if ( not self.db.profile.auras[i].deleted ) then
			self.options.args.auras.args.list.args[tostring(i)] = SetupAuraOption(i)
		end
	end
	
	self:ConvertAuraList()
    
    self.options.args.clicks = {
		type = "group",
		order = 6,
		name = L["Clicks"],
        desc = L["Click settings"],
		args = {},
	}
	
	for i=1, 10 do
		self.options.args.clicks.args[tostring(i)] = SetupAttributeOption(i)
	end
    
    self.options.plugins.profiles = { profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db) }
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Gladdy", self.options)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Gladdy", "Gladdy")
	self:RegisterChatCommand("gladdy", slashHandler)
end

function Gladdy:ShowOptions()
    InterfaceOptionsFrame_OpenToFrame("Gladdy")
end