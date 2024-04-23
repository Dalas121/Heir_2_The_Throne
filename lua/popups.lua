local _ = wesnoth.textdomain "wesnoth-h2tt"

-- https://wiki.wesnoth.org/LuaAPI/types/widget

-- metatable for GUI tags
local T = wml.tag

-- helpful debug function for printing a table
function tprint (tbl, indent)
	if not indent then indent = 0 end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2 
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if (type(k) == "number") then
			toprint = toprint .. "[" .. k .. "] = "
		elseif (type(k) == "string") then
			toprint = toprint  .. k ..  "= "   
		end
		if (type(v) == "number") then
			toprint = toprint .. v .. ",\r\n"
		elseif (type(v) == "string") then
			toprint = toprint .. "\"" .. v .. "\",\r\n"
		elseif (type(v) == "table") then
			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
		end
	end
	toprint = toprint .. string.rep(" ", indent-2) .. "}"
	return toprint
end





















--###########################################################################################################################################################
--                                                                 SCENARIO PREVIEW
--###########################################################################################################################################################
function display_scenario_preview(cfg)
	--###############################
	-- PREPARE ARGUMENTS
	--###############################
	local title = cfg.title
	local scenario = cfg.scenario -- e.g. "s01"
	local difficulty = "bigmap/difficulty"..cfg.difficulty..".png" -- e.g. "difficulty1.png"
	
	-------------------------
	-- REWARD: RECRUITS
	-------------------------
	local recruit1 = cfg.recruit1 and cfg.recruit1.."~RC(magenta>lightblue)" or "misc/blank-hex.png"
	local recruit2 = cfg.recruit2 and cfg.recruit2.."~RC(magenta>lightblue)" or "misc/blank-hex.png"
	local recruit3 = cfg.recruit3 and cfg.recruit3.."~RC(magenta>lightblue)" or "misc/blank-hex.png"
	local recruit4 = cfg.recruit4 and cfg.recruit4.."~RC(magenta>lightblue)" or "misc/blank-hex.png"
	
	-------------------------
	-- REWARD: COMPANION
	-------------------------
	local companion1 = cfg.companion1 and cfg.companion1.."~RC(magenta>lightblue)~BLIT(misc/loyal-icon.png)" or "misc/blank-hex.png"
	local companion2 = cfg.companion2 and cfg.companion2.."~RC(magenta>lightblue)~BLIT(misc/loyal-icon.png)" or "misc/blank-hex.png"
	
	-------------------------
	-- REWARD: SHOP
	-------------------------
	
	-------------------------
	-- REWARD: OTHER
	-------------------------
	
	-------------------------
	-- REWARD: GOLD
	-------------------------
	local gold = cfg.gold
	if (gold==0) then gold="<span color='#ad6a61'>NO</span>" end
	if (gold==1) then gold="<span color='#a9a150'>LOW</span>" end
	if (gold==2) then gold="<span color='#6ca364'>HIGH</span>" end
	
	--###############################
	-- DEFINE GRID
	--###############################
	local grid = T.grid{
		T.row{ T.column{ T.grid{ T.row{
			T.column{ T.image{
				-------------------------
				-- PREVIEW IMAGE
				-------------------------
				horizontal_alignment="left",
				label="bigmap/preview-"..scenario..".png",
			}},
			T.column{ T.label{ label="   " }}, 
			T.column{ T.grid{
				-------------------------
				-- TITLE AND DIFFICULTY
				-------------------------
				T.row{ T.column{ T.label{  use_markup=true,  label="<span size='5000'> </span>"  }}}, 
				T.row{ T.column{ 
					horizontal_alignment="left",
					T.label{  definition="title",label=title,  }
				}}, 
				T.row{ T.column{ T.label{  use_markup=true,  label="<span size='5000'> </span>"  }}}, 
				T.row{ T.column{
					horizontal_alignment="left",
					T.grid{ T.row{
						T.column{ T.label{  use_markup=true,  label=_"Difficulty: ",  }},
						T.column{ T.image{  label=difficulty,  }},
					}}
				}},
				T.row{ T.column{ T.label{  use_markup=true,  label="<span size='25000'> </span>"  }}}, 
				
				-------------------------
				-- REWARDS
				-------------------------
				T.row{ T.column{ 
					horizontal_alignment="left",
					T.label{  definition="title",  label="Possible Rewards:",  },
				}},
				-- New Recruits
				T.row{ T.column{ 
					horizontal_alignment="left",
					T.grid{ T.row{ 
						T.column{ T.label{  id="recruit0",  use_markup=true,  label="New Recruits:",  }},
						T.column{ T.image{  id="recruit1",  label=recruit1  }},
						T.column{ T.image{  id="recruit2",  label=recruit2  }},
						T.column{ T.image{  id="recruit3",  label=recruit3  }},
						T.column{ T.image{  id="recruit4",  label=recruit4  }},
					}},
				}},
				-- New Companion
				T.row{ T.column{ 
					horizontal_alignment="left", 
					T.grid{ T.row{ 
						T.column{ T.label{  id="companion0",  use_markup=true,  label="New Companion:",  }},
						T.column{ T.image{  id="companion1",  label=companion1  }},
						T.column{ T.image{  id="companion2",  label=companion2  }},
					}},
				}},
				-- Gold Carryover
				T.row{ T.column{ 
					horizontal_alignment="left",
					T.label{  use_markup=true,  label="You will probably exit this scenario with <b>"..gold.."</b> gold carryover",  },
				}},
			}},
		}}}},
		T.row{ T.column{ T.label{  use_markup=true,  label="<span size='5000'> </span>"  }}}, 
		-------------------------
		-- BUTTONS
		-------------------------
		T.row{ T.column{ T.grid{ T.row{
			T.column{ T.grid{ T.row{
				T.column{ T.button{
					return_value=1, use_markup=true,
					label=_"Play",
				}},
				T.column{ T.label{ label="    " }},
				T.column{ T.button{
					return_value=2, use_markup=true,
					label=_"Cancel",
				}},
			}}},
		}}}},
	}
	
	
	--###############################
	-- CREATE DIALOG
	--###############################
	local result = wesnoth.sync.evaluate_single(function()
		local button = gui.show_dialog(
			{-- dialog definition
				T.helptip{ id="tooltip_large" }, -- mandatory field
				T.tooltip{ id="tooltip_large" }, -- mandatory field
				grid, 
			},
			-- preshow
			function(dialog)
				if (not cfg.recruit1) then
					dialog["recruit0"].visible = false
					dialog["recruit1"].visible = false
					dialog["recruit2"].visible = false
					dialog["recruit3"].visible = false
					dialog["recruit4"].visible = false
				end
				if (not cfg.companion1) then
					dialog["companion0"].visible = false
					dialog["companion1"].visible = false
					dialog["companion2"].visible = false
				end
			end
		)
		return { button=button }
	end)
	-- e.g `status_s01 = "in progress"`
	if (result.button==1) then wml.variables["status_"..cfg.scenario]="in_progress" end
end



















--###########################################################################################################################################################
--                                                                 SCENARIO PREVIEW
--###########################################################################################################################################################
function display_overworld_tutorial()
	--###############################
	-- DEFINE GRID
	--###############################
	local grid = T.grid{ T.row{ 
		T.column{ T.label{  use_markup=true,  label="<span size='40000'> </span>"  }}, 
		T.column{ T.grid{ 
			-------------------------
			-- INTRO
			-------------------------
			T.row{ T.column{ 
				horizontal_alignment="center",
				T.label{  definition="title",  label=_"Welcome to the Great Continent",  }
			}},
			T.row{ T.column{ T.label{  use_markup=true,  label="<span size='15000'> </span>"  }}}, 
			T.row{ T.column{ 
				horizontal_alignment="left",
				T.label{
					use_markup=true,
					label=_"The wide world of Wesnoth is full of all kinds of\ninteresting people! Unfortunately for Konrad, \nmost of them want to kill him.",
				}
			}},
			T.row{ T.column{ T.label{  use_markup=true,  label="<span size='15000'> </span>"  }}}, 
			-------------------------
			-- IMAGE
			-------------------------
			T.row{ T.column{ T.grid{ T.row{
				T.column{
					T.image{  label="bigmap/overworld-tutorial.png"  }
				},
				T.column{ T.label{  use_markup=true,  label="<span size='40000'> </span>"  }},
				T.column{ 
					horizontal_alignment="left",
					T.label{
						use_markup=true,
						label=_"To leave the overworld and play\na battle scenario, <i><b>move Konrad\nto one of the marked hexes.</b></i>",
					}
				}
			}}}},
			T.row{ T.column{ T.label{  use_markup=true,  label="<span size='15000'> </span>"  }}}, 
			-------------------------
			-- BUTTONS
			-------------------------
			T.row{ T.column{ T.button{
				return_value=1, use_markup=true,
				label=_"Understood",
			}}},
		}},
		T.column{ T.label{  use_markup=true,  label="<span size='40000'> </span>"  }}, 
	}}
	
	--###############################
	-- CREATE DIALOG
	--###############################
	local result = wesnoth.sync.evaluate_single(function()
		local button = gui.show_dialog({
			T.helptip{ id="tooltip_large" }, -- mandatory field
			T.tooltip{ id="tooltip_large" }, -- mandatory field
			grid
		})
		return { button=button }
	end)
end


















--###########################################################################################################################################################
--                                                                      "MAIN"
--###########################################################################################################################################################
-------------------------
-- DEFINE WML TAGS
-------------------------
function wesnoth.wml_actions.display_scenario_preview(cfg)
	display_scenario_preview(cfg)
end
function wesnoth.wml_actions.display_overworld_tutorial()
	display_overworld_tutorial()
end


