return {
    ['testburger'] = {
        label = 'Test Burger',
        weight = 220,
        degrade = 60,
        client = {
            image = 'burger_chicken.png',
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            export = 'ox_inventory_examples.testburger'
        },
        server = {
            export = 'ox_inventory_examples.testburger',
            test = 'what an amazingly delicious burger, amirite?'
        },
        buttons = {
            {
                label = 'Lick it',
                action = function(slot)
                    print('You licked the burger')
                end
            },
            {
                label = 'Squeeze it',
                action = function(slot)
                    print('You squeezed the burger :(')
                end
            },
            {
                label = 'What do you call a vegan burger?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('A misteak.')
                end
            },
            {
                label = 'What do frogs like to eat with their hamburgers?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('French flies.')
                end
            },
            {
                label = 'Why were the burger and fries running?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('Because they\'re fast food.')
                end
            }
        },
        consume = 0.3
    },

    ['bandage'] = {
        label = 'Bandage',
        weight = 115,
    },

    ['burger'] = {
        label = 'Burger',
        weight = 220,
        client = {
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            notification = 'You ate a delicious burger'
        },
    },

    ['sprunk'] = {
        label = 'Sprunk',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You quenched your thirst with a sprunk'
        }
    },

    ['parachute'] = {
        label = 'Parachute',
        weight = 8000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 1500
        }
    },

    ['garbage'] = {
        label = 'Garbage',
    },

    ['paperbag'] = {
        label = 'Paper Bag',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },

    ['panties'] = {
        label = 'Knickers',
        weight = 10,
        consume = 0,
        client = {
            status = { thirst = -100000, stress = -25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
            usetime = 2500,
        }
    },

    ['lockpick'] = {
        label = 'Lockpick',
        weight = 160,
    },

    ['phone'] = {
        label = 'Phone',
        weight = 190,
        stack = false,
        consume = 0,
        client = {
            add = function(total)
                if total > 0 then
                    pcall(function() return exports.npwd:setPhoneDisabled(false) end)
                end
            end,

            remove = function(total)
                if total < 1 then
                    pcall(function() return exports.npwd:setPhoneDisabled(true) end)
                end
            end
        }
    },

    ['mustard'] = {
        label = 'Mustard',
        weight = 500,
        client = {
            status = { hunger = 25000, thirst = 25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
            usetime = 2500,
            notification = 'You... drank mustard'
        }
    },

    ['water'] = {
        label = 'Water',
        weight = 500,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            usetime = 2500,
            cancel = true,
            notification = 'You drank some refreshing water'
        }
    },

    ['armour'] = {
        label = 'Bulletproof Vest',
        weight = 3000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
        }
    },

    ['clothing'] = {
        label = 'Clothing',
        consume = 0,
    },

    ['money'] = {
        label = 'Money',
    },

    ['black_money'] = {
        label = 'Dirty Money',
    },

    ['id_card'] = {
        label = 'Identification Card',
    },

    ['driver_license'] = {
        label = 'Drivers License',
    },

    ['weaponlicense'] = {
        label = 'Weapon License',
    },

    ['lawyerpass'] = {
        label = 'Lawyer Pass',
    },

    ['radio'] = {
        label = 'Radio',
        weight = 1000,
        allowArmed = true,
        consume = 0,
        client = {
            event = 'mm_radio:client:use'
        }
    },

    ['jammer'] = {
        label = 'Radio Jammer',
        weight = 10000,
        allowArmed = true,
        client = {
            event = 'mm_radio:client:usejammer'
        }
    },

    ['radiocell'] = {
        label = 'AAA Cells',
        weight = 1000,
        stack = true,
        allowArmed = true,
        client = {
            event = 'mm_radio:client:recharge'
        }
    },

    ['advancedlockpick'] = {
        label = 'Advanced Lockpick',
        weight = 500,
    },

    ['screwdriverset'] = {
        label = 'Screwdriver Set',
        weight = 500,
    },

    ['electronickit'] = {
        label = 'Electronic Kit',
        weight = 500,
    },

    ['cleaningkit'] = {
        label = 'Cleaning Kit',
        weight = 500,
    },

    ['repairkit'] = {
        label = 'Repair Kit',
        weight = 2500,
    },

    ['advancedrepairkit'] = {
        label = 'Advanced Repair Kit',
        weight = 4000,
    },

    ['diamond_ring'] = {
        label = 'Diamond',
        weight = 1500,
    },

    ['rolex'] = {
        label = 'Golden Watch',
        weight = 1500,
    },

    ['goldbar'] = {
        label = 'Gold Bar',
        weight = 1500,
    },

    ['goldchain'] = {
        label = 'Golden Chain',
        weight = 1500,
    },

    ['crack_baggy'] = {
        label = 'Crack Baggy',
        weight = 100,
    },

    ['cokebaggy'] = {
        label = 'Bag of Coke',
        weight = 100,
    },

    ['coke_brick'] = {
        label = 'Coke Brick',
        weight = 2000,
    },

    ['coke_small_brick'] = {
        label = 'Coke Package',
        weight = 1000,
    },

    ['xtcbaggy'] = {
        label = 'Bag of Ecstasy',
        weight = 100,
    },

    ['meth'] = {
        label = 'Methamphetamine',
        weight = 100,
    },

    ['oxy'] = {
        label = 'Oxycodone',
        weight = 100,
    },

    ['weed_ak47'] = {
        label = 'AK47 2g',
        weight = 200,
    },

    ['weed_ak47_seed'] = {
        label = 'AK47 Seed',
        weight = 1,
    },

    ['weed_skunk'] = {
        label = 'Skunk 2g',
        weight = 200,
    },

    ['weed_skunk_seed'] = {
        label = 'Skunk Seed',
        weight = 1,
    },

    ['weed_amnesia'] = {
        label = 'Amnesia 2g',
        weight = 200,
    },

    ['weed_amnesia_seed'] = {
        label = 'Amnesia Seed',
        weight = 1,
    },

    ['weed_og-kush'] = {
        label = 'OGKush 2g',
        weight = 200,
    },

    ['weed_og-kush_seed'] = {
        label = 'OGKush Seed',
        weight = 1,
    },

    ['weed_white-widow'] = {
        label = 'OGKush 2g',
        weight = 200,
    },

    ['weed_white-widow_seed'] = {
        label = 'White Widow Seed',
        weight = 1,
    },

    ['weed_purple-haze'] = {
        label = 'Purple Haze 2g',
        weight = 200,
    },

    ['weed_purple-haze_seed'] = {
        label = 'Purple Haze Seed',
        weight = 1,
    },

    ['weed_brick'] = {
        label = 'Weed Brick',
        weight = 2000,
    },

    ['weed_nutrition'] = {
        label = 'Plant Fertilizer',
        weight = 2000,
    },

    ['joint'] = {
        label = 'Joint',
        weight = 200,
    },

    ['rolling_paper'] = {
        label = 'Rolling Paper',
        weight = 0,
    },

    ['empty_weed_bag'] = {
        label = 'Empty Weed Bag',
        weight = 0,
    },

    ['firstaid'] = {
        label = 'First Aid',
        weight = 2500,
    },

    ['ifaks'] = {
        label = 'Individual First Aid Kit',
        weight = 2500,
    },

    ['painkillers'] = {
        label = 'Painkillers',
        weight = 400,
    },

    ['firework1'] = {
        label = '2Brothers',
        weight = 1000,
    },

    ['firework2'] = {
        label = 'Poppelers',
        weight = 1000,
    },

    ['firework3'] = {
        label = 'WipeOut',
        weight = 1000,
    },

    ['firework4'] = {
        label = 'Weeping Willow',
        weight = 1000,
    },

    ['steel'] = {
        label = 'Steel',
        weight = 100,
    },

    ['rubber'] = {
        label = 'Rubber',
        weight = 100,
    },

    ['metalscrap'] = {
        label = 'Metal Scrap',
        weight = 100,
    },

    ['iron'] = {
        label = 'Iron',
        weight = 100,
    },

    ['copper'] = {
        label = 'Copper',
        weight = 100,
    },

    ['aluminium'] = {
        label = 'Aluminium',
        weight = 100,
    },

    ['plastic'] = {
        label = 'Plastic',
        weight = 100,
    },

    ['glass'] = {
        label = 'Glass',
        weight = 100,
    },

    ['gatecrack'] = {
        label = 'Gatecrack',
        weight = 1000,
    },

    ['cryptostick'] = {
        label = 'Crypto Stick',
        weight = 100,
    },

    ['trojan_usb'] = {
        label = 'Trojan USB',
        weight = 100,
    },

    ['toaster'] = {
        label = 'Toaster',
        weight = 5000,
    },

    ['small_tv'] = {
        label = 'Small TV',
        weight = 100,
    },

    ['security_card_01'] = {
        label = 'Security Card A',
        weight = 100,
    },

    ['security_card_02'] = {
        label = 'Security Card B',
        weight = 100,
    },

    ['drill'] = {
        label = 'Drill',
        weight = 5000,
    },

    ['thermite'] = {
        label = 'Thermite',
        weight = 1000,
    },

    ['diving_gear'] = {
        label = 'Diving Gear',
        weight = 30000,
    },

    ['diving_fill'] = {
        label = 'Diving Tube',
        weight = 3000,
    },

    ['antipatharia_coral'] = {
        label = 'Antipatharia',
        weight = 1000,
    },

    ['dendrogyra_coral'] = {
        label = 'Dendrogyra',
        weight = 1000,
    },

    ['jerry_can'] = {
        label = 'Jerrycan',
        weight = 3000,
    },

    ['nitrous'] = {
        label = 'Nitrous',
        weight = 1000,
    },

    ['wine'] = {
        label = 'Wine',
        weight = 500,
    },

    ['grape'] = {
        label = 'Grape',
        weight = 10,
    },

    ['grapejuice'] = {
        label = 'Grape Juice',
        weight = 200,
    },

    ['coffee'] = {
        label = 'Coffee',
        weight = 200,
    },

    ['vodka'] = {
        label = 'Vodka',
        weight = 500,
    },

    ['whiskey'] = {
        label = 'Whiskey',
        weight = 200,
    },

    ['beer'] = {
        label = 'beer',
        weight = 200,
    },

    ['sandwich'] = {
        label = 'beer',
        weight = 200,
    },

    ['walking_stick'] = {
        label = 'Walking Stick',
        weight = 1000,
    },

    ['lighter'] = {
        label = 'Lighter',
        weight = 200,
    },

    ['binoculars'] = {
        label = 'Binoculars',
        weight = 800,
    },

    ['stickynote'] = {
        label = 'Sticky Note',
        weight = 0,
    },

    ['empty_evidence_bag'] = {
        label = 'Empty Evidence Bag',
        weight = 200,
    },

    ['filled_evidence_bag'] = {
        label = 'Filled Evidence Bag',
        weight = 200,
    },

    ['harness'] = {
        label = 'Harness',
        weight = 200,
    },

    ['handcuffs'] = {
        label = 'Handcuffs',
        weight = 200,
    },
    ["joint"] = {
        label = "Joint",
        weight = 50,
        stack = true,
        close = true
    },
    ["cigar"] = {
        label = "Cigar",
        weight = 50,
        stack = true,
        close = true
    },
    ["cigarette"] = {
        label = "Cigarette",
        weight = 30,
        stack = true,
        close = true
    },
    ["lighter"] = {
        label = "Lighter",
        weight = 50,
        stack = false,
        close = true
    },
    ["bong"] = {
        label = "Bong",
        weight = 250,
        stack = false,
        close = true
    },
    ["vape"] = {
        label = "Vape",
        weight = 150,
        stack = false,
        close = true
    },
    ["vape_battery"] = {
        label = "Vape Battery",
        weight = 100,
        stack = true,
        close = true
    },
    ["vape_flavour_capsule"] = {
        label = "Vape Flavour Capsule",
        weight = 20,
        stack = true,
        close = true
    },
    ["weed_nugget"] = {
        label = "Weed Nugget",
        weight = 1,
        stack = true,
        close = true,
    },
    ["cigarette_pack"] = {
        label = "Cigarette Pack",
        weight = 200,
        stack = false,
        close = true
    },
    ["bong_water"] = {
        label = "Bong Water",
        weight = 250,
        stack = true,
        close = true
    },

    ["model_door_wood"] 			   = {["name"] = "model_door_wood", 			 	  		["label"] = "Wood Door", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_door_wood.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_door_metal"] 			   = {["name"] = "model_door_metal", 			 	  		["label"] = "Metal Door", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_door_metal.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_window_wood"] 			   = {["name"] = "model_window_wood", 			 	  	["label"] = "Wood Window", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_window_wood.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_window_metal"] 			   = {["name"] = "model_window_metal", 			 	  	["label"] = "Metal Window", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_window_metal.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_windowway_wood"] 		   = {["name"] = "model_windowway_wood", 			 	  	["label"] = "Wood Window Frame", 			["weight"] = 200, 		["type"] = "item", 			["image"] = "model_windowway_wood.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_windowway_metal"] 		   = {["name"] = "model_windowway_metal", 			 	["label"] = "Metal Window Frame", 			["weight"] = 200, 		["type"] = "item", 			["image"] = "model_windowway_metal.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_wood"] 			   = {["name"] = "model_wall_wood", 			 	  		["label"] = "Wood Wall", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_wood.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_metal"] 			   = {["name"] = "model_wall_metal", 			 	  		["label"] = "Metal Wall", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_metal.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_doorway_wood"] 			   = {["name"] = "model_doorway_wood", 			 	  	["label"] = "Wood Door Frame", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_doorway_wood.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_doorway_metal"] 		   = {["name"] = "model_doorway_metal", 			 	  	["label"] = "Metal Door Frame", 			["weight"] = 200, 		["type"] = "item", 			["image"] = "model_doorway_metal.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_gateway_wood"] 			   = {["name"] = "model_gateway_wood", 			 	  	["label"] = "Wood Gate Frame", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_gateway_wood.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_gateway_metal"] 		   = {["name"] = "model_gateway_metal", 			 	  	["label"] = "Metal Gate Frame", 			["weight"] = 200, 		["type"] = "item", 			["image"] = "model_gateway_metal.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_base_wood"] 			   = {["name"] = "model_base_wood", 			 	  		["label"] = "Wood Foundation", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_base_wood.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_base_metal"] 			   = {["name"] = "model_base_metal", 			 	  		["label"] = "Metal Foundation", 			["weight"] = 200, 		["type"] = "item", 			["image"] = "model_base_metal.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceiling_wood"] 			   = {["name"] = "model_ceiling_wood", 			 	  	["label"] = "Wood Ceiling", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceiling_wood.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceiling_metal"] 		   = {["name"] = "model_ceiling_metal", 			 	  	["label"] = "Metal Ceiling", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceiling_metal.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceilingstairs_wood"] 	   = {["name"] = "model_ceilingstairs_wood", 			 	["label"] = "Wood Stairs", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceilingstairs_wood.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceilingstairs_metal"] 	   = {["name"] = "model_ceilingstairs_metal", 			["label"] = "Metal Stairs", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceilingstairs_metal.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_pillar_wood"] 			   = {["name"] = "model_pillar_wood", 			 	  	["label"] = "Wood Pillar", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_pillar_wood.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_pillar_metal"] 			   = {["name"] = "model_pillar_metal", 			 		["label"] = "Metal Pillar", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_pillar_metal.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_gate_wood"] 			   = {["name"] = "model_gate_wood", 			 	  		["label"] = "Wood Gate", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_gate_wood.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_gate_metal"] 			   = {["name"] = "model_gate_metal", 			 	  		["label"] = "Metal Gate", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_gate_metal.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["bkr_prop_biker_campbed_01"] 	   = {["name"] = "bkr_prop_biker_campbed_01", 			["label"] = "Bed", 							["weight"] = 200, 		["type"] = "item", 			["image"] = "bkr_prop_biker_campbed_01.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["v_tre_sofa_mess_b_s"] 		   = {["name"] = "v_tre_sofa_mess_b_s", 			 	  	["label"] = "Sofa", 						["weight"] = 200, 		["type"] = "item", 			["image"] = "v_tre_sofa_mess_b_s.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["prop_tool_bench02_ld"] 		   = {["name"] = "prop_tool_bench02_ld", 			 	  	["label"] = "Crafting Table", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "prop_tool_bench02_ld.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["gr_prop_gr_bench_02a"] 		   = {["name"] = "gr_prop_gr_bench_02a", 			 	  	["label"] = "Weapons Table", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "gr_prop_gr_bench_02a.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["bkr_prop_meth_table01a"] 		   = {["name"] = "bkr_prop_meth_table01a", 			 	["label"] = "Medical Table", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "bkr_prop_meth_table01a.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["prop_generator_01a"] 			   = {["name"] = "prop_generator_01a", 			 	  	["label"] = "Generator", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "prop_generator_01a.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["prop_box_wood01a"] 			   = {["name"] = "prop_box_wood01a", 			 	 		["label"] = "Wood Storage", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "prop_box_wood01a.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["gr_prop_gr_gunlocker_01a"] 	   = {["name"] = "gr_prop_gr_gunlocker_01a", 			 	["label"] = "Metal Storage", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "gr_prop_gr_gunlocker_01a.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["p_v_43_safe_s"] 			 	   = {["name"] = "p_v_43_safe_s", 			 	  		["label"] = "Metal Storage 2", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "p_v_43_safe_s.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["prop_planer_01"] 			 	   = {["name"] = "prop_planer_01", 			 	  		["label"] = "Recycling Machine", 			["weight"] = 200, 		["type"] = "item", 			["image"] = "prop_planer_01.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["prop_worklight_02a"] 			   = {["name"] = "prop_worklight_02a", 			 	  	["label"] = "Lamp", 						["weight"] = 200, 		["type"] = "item", 			["image"] = "prop_worklight_02a.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_bigwall_wood"] 			   = {["name"] = "model_bigwall_wood", 			 	  	["label"] = "Large Wood Wall", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_bigwall_wood.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_biggateway_wood"] 		   = {["name"] = "model_biggateway_wood", 			 	["label"] = "Large Wood Gateway", 			["weight"] = 200, 		["type"] = "item", 			["image"] = "model_biggateway_wood.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_biggate_wood"] 			   = {["name"] = "model_biggate_wood", 			 	  	["label"] = "Large Wood Gate", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_biggate_wood.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["prop_worklight_04c"] 			   = {["name"] = "prop_worklight_04c", 			 	  	["label"] = "Lamp 2", 						["weight"] = 200, 		["type"] = "item", 			["image"] = "prop_worklight_04c.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["wood"] 			 			   = {["name"] = "wood", 			 	  					["label"] = "Wood", 						["weight"] = 200, 		["type"] = "item", 			["image"] = "wood.png", 							["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
['gr_prop_gr_hobo_stove_01'] 	   = {['name'] = 'gr_prop_gr_hobo_stove_01', 			    ['label'] = 'CampFire', 					['weight'] = 200, 		['type'] = 'item', 			['image'] = 'prop_hobo_stove.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Campfire for cooking food'},
['prop_worklight_01a'] 			   = {['name'] = 'prop_worklight_01a', 			    	['label'] = 'Lamp 3', 					    ['weight'] = 200, 		['type'] = 'item', 			['image'] = 'prop_worklight_04c.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Campfire for cooking food'},

["model_base_metal_triangle"] 	   = {["name"] = "model_base_metal_triangle", 			 	  		["label"] = "Metal Triangle Foundation", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_base_metal_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_base_wood_triangle"] 	   = {["name"] = "model_base_wood_triangle", 			 	  		["label"] = "Wood Triangle Foundation", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_base_wood_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceiling_metal_triangle"]   = {["name"] = "model_ceiling_metal_triangle", 			 	  		["label"] = "Metal Triangle Ceiling", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceiling_metal_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceiling_wood_triangle"]    = {["name"] = "model_ceiling_wood_triangle", 			 	  		["label"] = "Wood Triangle Ceiling", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceiling_wood_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_metal_roof"] 		   = {["name"] = "model_wall_metal_roof", 			 	  		["label"] = "Metal Roof", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_metal_roof.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_metal_roof_triangle"] = {["name"] = "model_wall_metal_roof_triangle", 			 	  		["label"] = "Metal Triangle Roof", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_metal_roof_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_metal_small"] 		   = {["name"] = "model_wall_metal_small", 			 	  		["label"] = "Metal Small Wall", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_metal_small.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_metal_triangle"] 	   = {["name"] = "model_wall_metal_triangle", 			 	  		["label"] = "Metal Triangle Wall", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_metal_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_wood_roof"] 		   = {["name"] = "model_wall_wood_roof", 			 	  		["label"] = "Wood Roof", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_wood_roof.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_wood_roof_triangle"]  = {["name"] = "model_wall_wood_roof_triangle", 			 	  		["label"] = "Wood Triangle Roof", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_wood_roof_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_wood_small"] 		   = {["name"] = "model_wall_wood_small", 			 	  		["label"] = "Wood Small Wall", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_wood_small.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_wood_triangle"] 	   = {["name"] = "model_wall_wood_triangle", 			 	  		["label"] = "Wood Triangle Wall", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_wood_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},



["model_door_stone"] 			   = {["name"] = "model_door_stone", 			 	  		["label"] = "stone Door", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_door_stone.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_window_stone"] 			   = {["name"] = "model_window_stone", 			 	  	["label"] = "stone Window", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_window_stone.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_windowway_stone"] 		   = {["name"] = "model_windowway_stone", 			 	  	["label"] = "stone Window Frame", 			["weight"] = 200, 		["type"] = "item", 			["image"] = "model_windowway_stone.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_stone"] 			   = {["name"] = "model_wall_stone", 			 	  		["label"] = "stone Wall", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_stone.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_doorway_stone"] 			   = {["name"] = "model_doorway_stone", 			 	  	["label"] = "stone Door Frame", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_doorway_stone.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_gateway_stone"] 			   = {["name"] = "model_gateway_stone", 			 	  	["label"] = "stone Gate Frame", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_gateway_stone.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_base_stone"] 			   = {["name"] = "model_base_stone", 			 	  		["label"] = "stone Foundation", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_base_stone.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceiling_stone"] 			   = {["name"] = "model_ceiling_stone", 			 	  	["label"] = "stone Ceiling", 				["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceiling_stone.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceilingstairs_stone"] 	   = {["name"] = "model_ceilingstairs_stone", 			 	["label"] = "stone Stairs", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceilingstairs_stone.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_pillar_stone"] 			   = {["name"] = "model_pillar_stone", 			 	  	["label"] = "stone Pillar", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_pillar_stone.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_gate_stone"] 			   = {["name"] = "model_gate_stone", 			 	  		["label"] = "stone Gate", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_gate_stone.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_base_stone_triangle"] 	   = {["name"] = "model_base_stone_triangle", 			 	  		["label"] = "stone Triangle Foundation", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_base_stone_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceiling_stone_triangle"]    = {["name"] = "model_ceiling_stone_triangle", 			 	  		["label"] = "stone Triangle Ceiling", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceiling_stone_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_stone_roof"] 		   = {["name"] = "model_wall_stone_roof", 			 	  		["label"] = "stone Roof", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_stone_roof.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_stone_roof_triangle"]  = {["name"] = "model_wall_stone_roof_triangle", 			 	  		["label"] = "stone Triangle Roof", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_stone_roof_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_stone_small"] 		   = {["name"] = "model_wall_stone_small", 			 	  		["label"] = "stone Small Wall", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_stone_small.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_wall_stone_triangle"] 	   = {["name"] = "model_wall_stone_triangle", 			 	  		["label"] = "stone Triangle Wall", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_wall_stone_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceilingladder_stone_triangle"] 	   = {["name"] = "model_ceilingladder_stone_triangle", 			 	  		["label"] = "stone Triangle Ceiling Ladder", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceilingladder_stone_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceilingladder_wood_triangle"] 	   = {["name"] = "model_ceilingladder_wood_triangle", 			 	  		["label"] = "wood Triangle Ceiling Ladder", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceilingladder_wood_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_ceilingladder_metal_triangle"] 	   = {["name"] = "model_ceilingladder_metal_triangle", 			 	  		["label"] = "metal Triangle Ceiling Ladder", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_ceilingladder_metal_triangle.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_stairs_stone"] 	   = {["name"] = "model_stairs_stone", 			 	  		["label"] = "stone stairs", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_stairs_stone.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_stairs_wood"] 	   = {["name"] = "model_stairs_wood", 			 	  		["label"] = "wood stairs", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_stairs_wood.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},
["model_stairs_metal"] 	   = {["name"] = "model_stairs_metal", 			 	  		["label"] = "metal stairs", 					["weight"] = 200, 		["type"] = "item", 			["image"] = "model_stairs_metal.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Used for base building"},

["water_50cl"] = {
	label = "Water 50cl",
	weight = 500,
	stack = false,
	close = true
},

["base_food"] = {
	label = "Base Food",
	weight = 0,
	stack = false,
	close = true
},

["base_drink"] = {
	label = "Base Drink",
	weight = 0,
	stack = false,
	close = true
},

["base_one_hit"] = {
	label = "Base One Hit",
	weight = 0,
	stack = false,
	close = true
},

["beer_50cl"] = {
	label = "Beer 50cl",
	weight = 550,
	stack = false,
	close = true
},

["burger"] = {
	label = 'Burger',
	weight = 220,
	stack = false,
	close = true
},

["kira_kira_currye"] = {
	label = "Curry",
	weight = 300,
	stack = false,
	close = true
},

["hotdog"] = {
	label = "Hotdog",
	weight = 160,
	stack = false,
	close = true
},

["nicotine_pouch"] = {
	label = "Nicotine Pouch",
	weught = 5.0,
	stack = false,
	close = true
},

-- Consumables Ingredients
["burger_buns"] = {
	label = "Burger Buns",
	weight = 30.0,
	stack = false,
},

["burger_patty"] = {
	label = "Burger Patty",
	weight = 75.0,
	stack = false,
},

["mustard"] = {
	label = "Mustard",
	description = "A splat of mustard to put on your burger.",
	weight = 5.0,
	stack = false,
},

["ketchup"] = {
	label = "Ketchup",
	description = "A splat of ketchup to put on your burger.",
	weight = 5.0,
	stack = false,
},

["secret_sauce"] = {
	label = "Secret Sauce",
	description = "A splat of secret sauce to put on your burger.",
	weight = 5.0,
	stack = false,
},

["pickles"] = {
	label = "Pickles",
	description = "A few pickles to put on your burger.",
	weight = 25.0,
	stack = false,
},

["cheese"] = {
	label = "Cheese",
	description = "A slice of cheese to put on your burger.",
	weight = 25.0,
	stack = false,
},

["lettuce"] = {
	label = "Lettuce",
	description = "A few leaves of lettuce to put on your burger.",
	weight = 25.0,
	stack = false,
},


}