Config = {}

Config.animalLoot = true ------ loot animals

Config.lootRefreshTime = 15 ------ refresh minutes for prop loot

Config.UseProgressBar = true ------ use progress bar

Config.DistanceCheckProtection = 10.0 ----- security reasons

Config.UsePressE = true --- if true you will use press E to loot 

Config.InventoryImagesLocation = 'nui://ox_inventory/web/images/' -- images for the items in the loot menu

Config.ProgressBars = {
    ["animal_interact"] = {
        duration = 100,
        label = "Searching animal",
        animation = {
            animDict = 'amb@prop_human_bum_bin@base',
            anim = 'base'
        }
    },
    ["prop_interact"] = {
        duration = 1000,
        label = "Searching Object",
        animation = {
            animDict = 'amb@prop_human_bum_bin@base',
            anim = 'base'
        }
    },
    ------- Modified Dumpsters Start ------
    ["dumpster_interact"] = {
        duration = 1000,
        label = "Deep Search",
        animation = {
            animDict = 'amb@prop_human_bum_bin@base',
            anim = 'base'
        }
    },
    -----Modified Dumpsters End -------
    ["zombie_interact"] = {
        duration = 1000,
        label = "Searching Zombie",
        animation = {
        --    animDict = 'amb@prop_human_bum_bin@base',
            anim = 'base'
            -- animDict = 'anim@gangops@facility@servers@bodysearch@',
            -- anim = 'player_search',
            -- flags = 16
        }
    },

    ----- extra progress bars example
    ['atm_interact'] = {
        duration = 1000,
        label = "Stealing ATM",
        animation = {
            task = 'WORLD_HUMAN_WELDING'
        }
    },

    ['veh_interact'] = {
        duration = 1000,
        label = "Searching Vehicle",
        animation = {
            task = 'WORLD_HUMAN_WELDING'
        }
    },
}

Config.moneyLabel = "Cash" --- you can edit the accounts on the open source side of the code in the server side of your Framework

---- PLEASE DON'T USE WORD 'DELETE' or 'PROP' when making this loot types

Config.types = {
    ["zombie_default"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1} ----- this will always spawn on every loot from this type
        }, -- can be empty
        probabilityLoots = {
            loop = 10,
            items = {
                -- Regular weapons (15%)
                {names = {'weapon_pistol','weapon_combatpistol','weapon_appistol','weapon_pistol50','weapon_snspistol','weapon_heavypistol','weapon_vintagepistol','weapon_ceramicpistol','weapon_gadgetpistol','weapon_machinepistol','weapon_minismg','weapon_smg','weapon_assaultsmg','weapon_combatpdw','weapon_microsmg','weapon_tec9','weapon_bat','weapon_battleaxe','weapon_bottle','weapon_crowbar','weapon_dagger','weapon_golfclub','weapon_hammer','weapon_hatchet','weapon_knife','weapon_machete','weapon_nightstick','weapon_poolcue','weapon_stone_hatchet','weapon_switchblade','weapon_wrench'}, minValue = 1, maxValue = 1, probability = 15},
                -- All ammo types (20%)
                {names = {'ammo-9','ammo-22','ammo-38','ammo-44','ammo-45','ammo-50','ammo-firework','ammo-flare','ammo-grenade','ammo-heavysniper','ammo-laser','ammo-musket','ammo-railgun','ammo-rifle','ammo-rifle2','ammo-rocket','ammo-shotgun','ammo-sniper','ammo-emp'}, minValue = 5, maxValue = 10, probability = 20},
                -- Attachments (5%)
                {names = {'at_suppressor','at_scope_small','at_grip','at_clip_drum','at_scope_medium','at_scope_macro','at_flashlight'}, minValue = 1, maxValue = 1, probability = 5},
                -- Food/meds (15%)
                {names = {'sandwich','tosti','water_bottle','snikkel_candy','twerks_candy','bandage'}, minValue = 1, maxValue = 1, probability = 15},
                -- Misc (10%)
                {names = {'electronickit','radio','cable','nail'}, minValue = 1, maxValue = 1, probability = 10},
                -- Backpacks (1%)
                {names = {'medium_backpack','small_backpack','large_backpack'}, minValue = 1, maxValue = 1, probability = 1},
                -- Money (15%)
                {names = {'money'}, minValue = 10, maxValue = 15, probability = 15},
                -- Smokes (8%)
                {names = {'joint','cigar','cigarette','lighter','vape','vape_battery','vape_flavour_capsule'}, minValue = 1, maxValue = 1, probability = 8},
                -- Misc (11%)
                {names = {'rifle_ammo','smg_ammo','shotgun_ammo','snp_ammo'}, minValue = 5, maxValue = 10, probability = 11},
            }
        },
        lootRefreshTime = 10
    },

    ["pistolCase"] = {
        fixedLoots = {
            --{name = "bandage",count = 1}
        },
        probabilityLoots = {
            loop = 1,
            items = {
                {
                    names = {
                        'weapon_pistol',
                        'weapon_combatpistol',
                        'weapon_appistol',
                        'weapon_pistol50',
                        'weapon_snspistol'
                    },
                    minValue = 1,
                    maxValue = 1,
                    probability = 75,
                    metadata = {
                        ammo = {
                            mathRandom = {min = 100,max = 200}
                        }, -- ammo will be a random number between 100 and 200
                        quality = {
                            probabilityRandom = {
                                {options = {"awesome"} , probability = 0.2},
                                {options = {"good"} , probability = 1.5},
                                {options = {"normal"} , probability = 10.0},
                                {options = {"bad","very bad"} , probability = 88.3},
                            }
                        }, -- quality will be one of the options from probability probabilityRandom table base on its probability
                        specialSerial = 10, -- specialSerial will be an exact value "10"
                        name = {
                            listRandom = {"random gun", "random  name"," something"}
                        } -- name will be a random name from listRandom table
                    } --- if don't understand very well take a look at the function getMetadata() in opensource/server.lua
                }, 
            }
        }
    },

    ["bossZombie"] = {
        fixedLoots = {},
        probabilityLoots = {
            loop = 10,
            items = {
                -- MK2 Weapons (rare, 2%)
                {names = {'weapon_assaultrifle_mk2','weapon_bullpuprifle_mk2','weapon_carbinerifle_mk2','weapon_combatmg_mk2','weapon_heavysniper_mk2','weapon_marksmanrifle_mk2','weapon_pistol_mk2','weapon_pumpshotgun_mk2','weapon_revolver_mk2','weapon_smg_mk2','weapon_snspistol_mk2','weapon_specialcarbine_mk2'}, minValue = 1, maxValue = 1, probability = 2},
                -- Assault Rifles (8%)
                {names = {'weapon_assaultrifle','weapon_bullpuprifle','weapon_carbinerifle','weapon_advancedrifle','weapon_heavyrifle','weapon_militaryrifle','weapon_specialcarbine','weapon_tacticalrifle','weapon_gusenberg'}, minValue = 1, maxValue = 1, probability = 8},
                -- SMGs (5%)
                {names = {'weapon_smg','weapon_assaultsmg','weapon_combatpdw','weapon_microsmg','weapon_minismg'}, minValue = 1, maxValue = 1, probability = 5},
                -- LMGs (2%)
                {names = {'weapon_combatmg'}, minValue = 1, maxValue = 1, probability = 2},
                -- Snipers (2%)
                {names = {'weapon_heavysniper','weapon_marksmanrifle'}, minValue = 1, maxValue = 1, probability = 2},
                -- Shotguns (4%)
                {names = {'weapon_pumpshotgun','weapon_sawnoffshotgun','weapon_bullpupshotgun','weapon_combatshotgun','weapon_autoshotgun','weapon_assaultshotgun'}, minValue = 1, maxValue = 1, probability = 4},
                -- Pistols (8%)
                {names = {'weapon_pistol','weapon_pistol50','weapon_snspistol','weapon_heavypistol','weapon_vintagepistol','weapon_ceramicpistol','weapon_gadgetpistol','weapon_machinepistol','weapon_appistol','weapon_combatpistol'}, minValue = 1, maxValue = 1, probability = 8},
                -- Melee (5%)
                {names = {'weapon_bat','weapon_battleaxe','weapon_bottle','weapon_crowbar','weapon_dagger','weapon_golfclub','weapon_hammer','weapon_hatchet','weapon_knife','weapon_machete','weapon_nightstick','weapon_poolcue','weapon_stone_hatchet','weapon_switchblade','weapon_wrench'}, minValue = 1, maxValue = 1, probability = 5},
                -- All Ammo Types (30%)
                {names = {'ammo-9','ammo-22','ammo-38','ammo-44','ammo-45','ammo-50','ammo-firework','ammo-flare','ammo-grenade','ammo-heavysniper','ammo-laser','ammo-musket','ammo-railgun','ammo-rifle','ammo-rifle2','ammo-rocket','ammo-shotgun','ammo-sniper','ammo-emp'}, minValue = 5, maxValue = 15, probability = 30},
                -- Attachments (8%)
                {names = {'at_suppressor','at_scope_small','at_grip','at_clip_drum','at_scope_medium','at_scope_macro','at_flashlight'}, minValue = 1, maxValue = 1, probability = 8},
                -- Money (15%)
                {names = {'money'}, minValue = 15, maxValue = 25, probability = 15},
                -- Misc (11%)
                {names = {'rifle_ammo','smg_ammo','shotgun_ammo','snp_ammo'}, minValue = 5, maxValue = 10, probability = 11},
            }
        }
    },

    ["animal_default"] = {
        fixedLoots = {
            {name = "bandage",count = 1}
        }, 
        probabilityLoots = {
            loop = 8, 
            items = {
            --    {names = {'bandage','wood'},minValue = 1,maxValue = 2,probability = 20}, 
            --    {names = {'money'},minValue = 5,maxValue = 20,probability = 10}                                                             
            } 
        }
    },

    ["pig_loot"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1}
        }
    },
  
    ["cat_loot"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1}
        }
    },

    ["bird_loot"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1}
        }
    },

    ["dog_loot"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1}
        }
    },

    ["cow_loot"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1}
        }
    },

    ["deer_loot"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1}
        }
    },

    
    ["mtlion_loot"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1}
        }
    },

    ["rabbit_loot"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1}
        }
    },

    ["rat_loot"] = {
        fixedLoots = {
        --    {name = "bandage",count = 1}
        }
    },

    ---------------- weapon cases --------------------------------------------------------



    ["explosivesCase_x1"] = {
        fixedLoots = {
           -- {name = "bandage",count = 1}
        },
        probabilityLoots = {
            loop = 1,
            items = {
                {names = {'weapon_grenade','weapon_pipebomb'},minValue = 1,maxValue = 2,probability = 10},
                {names = {'weapon_bzgas'},minValue = 1,maxValue = 2,probability = 15},
                {names = {'weapon_molotov'},minValue = 1,maxValue = 2,probability = 10},
                {names = {'weapon_stickybomb'},minValue = 1,maxValue = 2,probability = 5},
                {names = {'weapon_smokegrenade'},minValue = 1,maxValue = 2,probability = 40},
            }
        }
    },

    ["explosivesCase_x4"] = {
        fixedLoots = {
           -- {name = "bandage",count = 1}
        },
        probabilityLoots = {
            loop = 4,
            items = {
                {names = {'weapon_grenade','weapon_pipebomb'},minValue = 1,maxValue = 2,probability = 10},
                {names = {'weapon_bzgas'},minValue = 1,maxValue = 2,probability = 15},
                {names = {'weapon_molotov'},minValue = 1,maxValue = 2,probability = 10},
                {names = {'weapon_stickybomb'},minValue = 1,maxValue = 2,probability = 5},
                {names = {'weapon_smokegrenade'},minValue = 1,maxValue = 2,probability = 40},
            }
        }
    },

    ["explosivesCase_x6"] = {
        fixedLoots = {
           -- {name = "bandage",count = 1}
        },
        probabilityLoots = {
            loop = 2,
            items = {
                {names = {'weapon_grenade','weapon_pipebomb'},minValue = 1,maxValue = 2,probability = 10},
                {names = {'weapon_bzgas'},minValue = 1,maxValue = 2,probability = 15},
                {names = {'weapon_molotov'},minValue = 1,maxValue = 2,probability = 10},
                {names = {'weapon_stickybomb'},minValue = 1,maxValue = 2,probability = 5},
                {names = {'weapon_smokegrenade'},minValue = 1,maxValue = 2,probability = 40},
            }
        }
    },

    ------------------ ammo ---------------------------------------------------------------------
    ["pistoAmmolCase"] = {
        fixedLoots = {},
        probabilityLoots = {
            loop = 1,
            items = {
                {names = {'ammo-9','ammo-22','ammo-38','ammo-44','ammo-45','ammo-50'}, minValue = 5, maxValue = 10, probability = 100},
            }
        }
    },
    ["rifleAmmoCase"] = {
        fixedLoots = {},
        probabilityLoots = {
            loop = 1,
            items = {
                {names = {'ammo-rifle','ammo-rifle2'}, minValue = 10, maxValue = 20, probability = 100},
            }
        }
    },
    ["shotgunAmmoCase"] = {
        fixedLoots = {},
        probabilityLoots = {
            loop = 1,
            items = {
                {names = {'ammo-shotgun'}, minValue = 5, maxValue = 10, probability = 100},
            }
        }
    },
    ["sniperAmmoCase"] = {
        fixedLoots = {},
        probabilityLoots = {
            loop = 1,
            items = {
                {names = {'ammo-sniper','ammo-heavysniper'}, minValue = 5, maxValue = 10, probability = 100},
            }
        }
    },
    ["mixedAmmo"] = {
        fixedLoots = {},
        probabilityLoots = {
            loop = 2,
            items = {
                {names = {'ammo-9','ammo-22','ammo-38','ammo-44','ammo-45','ammo-50','ammo-firework','ammo-flare','ammo-grenade','ammo-heavysniper','ammo-laser','ammo-musket','ammo-railgun','ammo-rifle','ammo-rifle2','ammo-rocket','ammo-shotgun','ammo-sniper','ammo-emp'}, minValue = 5, maxValue = 10, probability = 100},
            }
        }
    },
    ["mixedAmmoBig_x1"] = {
        fixedLoots = {},
        probabilityLoots = {
            loop = 4,
            items = {
                {names = {'ammo-9','ammo-22','ammo-38','ammo-44','ammo-45','ammo-50','ammo-firework','ammo-flare','ammo-grenade','ammo-heavysniper','ammo-laser','ammo-musket','ammo-railgun','ammo-rifle','ammo-rifle2','ammo-rocket','ammo-shotgun','ammo-sniper','ammo-emp'}, minValue = 5, maxValue = 10, probability = 100},
            }
        }
    },
    ["mixedAmmoBig_x2"] = {
        fixedLoots = {},
        probabilityLoots = {
            loop = 8,
            items = {
                {names = {'ammo-9','ammo-22','ammo-38','ammo-44','ammo-45','ammo-50','ammo-firework','ammo-flare','ammo-grenade','ammo-heavysniper','ammo-laser','ammo-musket','ammo-railgun','ammo-rifle','ammo-rifle2','ammo-rocket','ammo-shotgun','ammo-sniper','ammo-emp'}, minValue = 5, maxValue = 10, probability = 100},
            }
        }
    },
    -------------------------------------------------------------------------------------

    ------ PROPS ------------------------------------------------------------------------

    ["prop_default"] = {
        fixedLoots = {
        --   {name = "bandage",count = 1}
        },
        probabilityLoots = {
            loop = 5,
            loopIncrease = 1,
            items = {
                -- Regular weapons (10%)
                {names = {'weapon_bat','weapon_battleaxe','weapon_bottle','weapon_crowbar','weapon_dagger','weapon_golfclub','weapon_hammer','weapon_hatchet','weapon_knife','weapon_machete','weapon_nightstick','weapon_poolcue','weapon_stone_hatchet','weapon_switchblade','weapon_wrench'}, minValue = 1, maxValue = 1, probability = 10},
                -- All ammo types (20%)
                {names = {'ammo-9','ammo-22','ammo-38','ammo-44','ammo-45','ammo-50','ammo-firework','ammo-flare','ammo-grenade','ammo-heavysniper','ammo-laser','ammo-musket','ammo-railgun','ammo-rifle','ammo-rifle2','ammo-rocket','ammo-shotgun','ammo-sniper','ammo-emp'}, minValue = 1, maxValue = 5, probability = 20},
                -- Car/repair/utility (30%)
            --    {names = {'wood','water_bottle','electronickit','car_quadtire','car_tire','car_repairkit','car_toolkit','car_bycyclechain','car_bycycletire','metalscrap','iron','weapon_parts','bolt','nail','cable','car_oil','car_bycycletire','gasoline','diesel','kerosine','car_6vbat','car_12vbat','car_24vbat','car_tire','car_bycycletire'}, minValue = 1, maxValue = 15, probability = 30},
                -- Attachments (5%)
                {names = {'at_clip_extended','at_suppressor','at_scope_small','at_grip','at_clip_drum','at_scope_medium','at_scope_macro','at_flashlight'}, minValue = 1, maxValue = 1, probability = 5},
                -- Smokes (5%)
                {names = {'joint','cigar','cigarette','lighter','vape','vape_battery','vape_flavour_capsule','cigarette_pack'}, minValue = 1, maxValue = 1, probability = 5},
                -- Misc (30%)
                {names = {'rifle_ammo','smg_ammo','shotgun_ammo','snp_ammo'}, minValue = 1, maxValue = 5, probability = 30},
            }
        }
    },
    ["trashBig"] = {
        fixedLoots = {
           -- {name = "bandage",count = 1}
        },
        probabilityLoots = {
            loop = 10,
            loopIncrease = 4,
            items = {
                -- Regular weapons (10%)
                {names = {'weapon_bat','weapon_battleaxe','weapon_bottle','weapon_crowbar','weapon_dagger','weapon_golfclub','weapon_hammer','weapon_hatchet','weapon_knife','weapon_machete','weapon_nightstick','weapon_poolcue','weapon_stone_hatchet','weapon_switchblade','weapon_wrench'}, minValue = 1, maxValue = 1, probability = 10},
                -- All ammo types (20%)
                {names = {'ammo-9','ammo-22','ammo-38','ammo-44','ammo-45','ammo-50','ammo-firework','ammo-flare','ammo-grenade','ammo-heavysniper','ammo-laser','ammo-musket','ammo-railgun','ammo-rifle','ammo-rifle2','ammo-rocket','ammo-shotgun','ammo-sniper','ammo-emp'}, minValue = 1, maxValue = 5, probability = 20},
                -- Car/repair/utility (25%)
                {names = {'wood','water_bottle','electronickit','car_quadtire','car_tire','car_repairkit','car_toolkit','car_bycyclechain','car_bycycletire','metalscrap','iron','weapon_parts','bolt','nail','cable','car_oil','car_bycycletire','gasoline','diesel','kerosine','car_6vbat','car_12vbat','car_24vbat','car_tire','car_bycycletire'}, minValue = 1, maxValue = 15, probability = 25},
                -- Attachments (5%)
                {names = {'at_clip_extended','at_suppressor','at_scope_small','at_grip','at_clip_drum','at_scope_medium','at_scope_macro','at_flashlight'}, minValue = 1, maxValue = 1, probability = 5},
                -- Smokes (8%)
                {names = {'joint','cigar','cigarette','lighter','vape','vape_battery','vape_flavour_capsule','cigarette_pack','bong','bong_water','weed_nugget'}, minValue = 1, maxValue = 1, probability = 8},
                -- Misc (32%)
                {names = {'rifle_ammo','smg_ammo','shotgun_ammo','snp_ammo','car_abelt','car_control','car_lampbulb','car_radiator','car_radiatorbig','car_sparkplug'}, minValue = 1, maxValue = 5, probability = 32},
            }
        },
        customProgressbar = 'dumpster_interact' 
    },
  
    ["blowtorch"] = {
        fixedLoots = {
           {name = "bandage",count = 1}
        }
    },

    ["atm_money"] = {
        fixedLoots = {
           
        },
        probabilityLoots = {
            loop = 1,
            loopIncrease = 1, ----- how much loops will be added if you are in a lootIncreaseZone (see below) (overrides the zone increase for this prop)
            items = {
                {names = {'money'},minValue = 500,maxValue = 1000,probability = 100}
            }
        },
        customProgressbar = 'atm_interact'
    },
    
    ["carLoot"] = {
        fixedLoots = {
           
        },
        probabilityLoots = {
            loop = 8,
            loopIncrease = 1,
            items = {
                {names = {'steel','bolt','nail','cable','plastic'}, minValue = 4, maxValue = 10, probability = 40},
                {names = {'metalscrap','aluminum','electronickit','rubber','obsidian'}, minValue = 1, maxValue = 5, probability = 20},
            --    {names = {'car_6vbat','car_12vbat','car_24vbat','car_tire','car_bycycletire','gasoline','diesel','kerosine'}, minValue = 1, maxValue = 1, probability = 20},
            --    {names = {'car_bycyclechain','car_quadtire','car_trucktire','car_abelt','car_control','car_lampbulb','car_radiator','car_radiatorbig','car_sparkplug'}, minValue = 1, maxValue = 1, probability = 5}
            }
        },
        customProgressbar = 'veh_interact'
    }
    }    

Config.lootByHashType = {
    ------- PEDS -------------------------
    ['u_m_y_zombie_01'] = 'bossZombie',
    ['s_m_y_fireman_01'] = 'bossZombie',
    ['u_m_y_corpse_01'] = 'bossZombie',
    ['mp_f_deadhooker'] = 'bossZombie',
    ['u_f_y_corpse_01'] = 'bossZombie',
    ['s_m_y_blackops_01'] = 'bossZombie',
    ['s_m_y_blackops_02'] = 'bossZombie',
    ['s_m_y_blackops_03'] = 'bossZombie',
    ['s_m_y_blackops_04'] = 'bossZombie',
    ['s_m_y_blackops_05'] = 'bossZombie',
    ['s_m_y_blackops_06'] = 'bossZombie',
    ['s_m_y_blackops_07'] = 'bossZombie',
    ['s_m_y_blackops_08'] = 'bossZombie',

    ------- ANIMALS ----------------------

    --- pigs ---
    ['a_c_boar'] = 'pig_loot',
    ['a_c_pig'] = 'pig_loot',
    --- cats ---
    ['a_c_cat_01'] = 'cat_loot',
    --- birds ---
    ['a_c_chickenhawk'] = 'bird_loot',
    ['a_c_crow'] = 'bird_loot',
    ['a_c_cormorant'] = 'bird_loot',
    ['a_c_pigeon'] = 'bird_loot',
    ['a_c_hen'] = 'bird_loot',
    ['a_c_seagull'] = 'bird_loot',
    --- dogs ---
    ['a_c_chop'] = 'dog_loot',
    ['a_c_shepherd'] = 'dog_loot',
    ['a_c_coyote'] = 'dog_loot',
    ['a_c_husky'] = 'dog_loot',
    ['a_c_poodle'] = 'dog_loot',
    ['a_c_pug'] = 'dog_loot',
    ['a_c_retriever'] = 'dog_loot',
    ['a_c_westy'] = 'dog_loot',
    ['a_c_rottweiler'] = 'dog_loot',
    --- cow ---
    ['a_c_cow'] = 'cow_loot',
    --- deer ---
    ['a_c_deer'] = 'deer_loot',
    --- mtlion ---
    ['a_c_mtlion'] = 'mtlion_loot',
    --- rabbit ---
    ['a_c_rabbit_01'] = 'rabbit_loot',
    --- rat ---
    ['a_c_rat'] = 'rat_loot',
}

Config.lootTypeItemNeeded = {
   -- ['trashBig'] = {items = {"bandage"},label = "You need a bandage to interact",remove = true}, ----- example
    ['atm_money'] = {items = {"weapon_crowbar"},label = "You need a crowbar to interact",remove = false, removeChance = 20}, ----- example
} -------- you have to have one of this items in your inventory to interact with this loot type

Config.lootTypeWeaponNeeded = {
    ['animal_default'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"},
    ['pig_loot'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"},
    ['cat_loot'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"},
    ['bird_loot'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"},
    ['dog_loot'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"},
    ['cow_loot'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"},
    ['deer_loot'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"},
    ['mtlion_loot'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"},
    ['rabbit_loot'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"},
    ['rat_loot'] = {weapons = {"WEAPON_KNIFE","weapon_dagger","weapon_hatchet","weapon_machete","weapon_switchblade","weapon_battleaxe","weapon_stone_hatchet"},label = "You need a cutting weapon"}
} -------- you have to have one of this weapons on your hand to interact with this loot type

Config.lootByHashTypeProps = {
    ---- gun cases -----------------------
    ['prop_box_guncase_02a'] = "pistolCase",
    ['prop_box_guncase_01a'] = "pistolCase",
    ['prop_box_guncase_03a'] = "pistolCase",
    ['prop_mb_cargo_03a'] = "pistolCase",
    ---- ammo ----------------------------
    ['prop_ld_ammo_pack_01'] = "pistoAmmolCase",
    ['prop_ld_ammo_pack_03'] = "rifleAmmoCase",
    ['prop_ld_ammo_pack_02'] = "shotgunAmmoCase",
    ['v_ret_gc_ammo3'] = "shotgunAmmoCase",
    ['prop_box_ammo07b'] = "sniperAmmoCase",
    ['prop_box_ammo07a'] = "sniperAmmoCase",
    ['prop_box_ammo01a'] = "mixedAmmo",
    ['prop_box_ammo04a'] = "mixedAmmo",
    ['prop_box_ammo02a'] = "mixedAmmo",
    ['prop_box_ammo06a'] = "mixedAmmoBig_x1",
    ['hei_prop_hei_ammo_single'] = "mixedAmmoBig_x1",
    ['hei_prop_hei_ammo_pile'] = "mixedAmmoBig_x2",
    ['hei_prop_hei_ammo_pile_02'] = "mixedAmmoBig_x2",
    ['prop_box_ammo03a'] = "explosivesCase_x1",
    ['prop_box_ammo03a_set2'] = "explosivesCase_x4",
    ['prop_box_ammo03a_set'] = "explosivesCase_x6",

-----------------------------------------------
    ['prop_dumpster_3a'] = "trashBig",
    ['prop_skip_05a'] = "trashBig",
    ['prop_dumpster_4b'] = "trashBig",
    ['prop_bin_14a'] = "trashBig",
    ['prop_dumpster_4a'] = "trashBig",
    ['prop_dumpster_01a'] = "trashBig",
    ['prop_dumpster_02a'] = "trashBig",
    ['prop_dumpster_02b'] = "trashBig",
    ['prop_dumpster_02b'] = "trashBig",
    ['prop_battery_01'] = "blowtorch",
    ['prop_battery_02'] = "blowtorch",
    ['prop_car_battery_01'] = "blowtorch",
    ['prop_tool_blowtorch'] = "blowtorch",

    -- trash bags
    ['prop_rub_binbag_sd_01'] = "trashBig",
    ['prop_ld_rub_binbag_01'] = "trashBig",
    ['prop_rub_binbag_sd_02'] = "trashBig",
    ['prop_ld_binbag_01'] = "trashBig",
    ['prop_cs_rub_binbag_01'] = "trashBig",
    ['prop_cs_street_binbag_01'] = "trashBig",
    ['prop_rub_binbag_03b'] = "trashBig",
    ['prop_rub_binbag_04'] = "trashBig",
    ['prop_rub_binbag_01'] = "trashBig",
    ['prop_rub_binbag_08'] = "trashBig",
    ['prop_rub_binbag_05'] = "trashBig",
    ['p_rub_binbag_test'] = "trashBig",
    ['prop_rub_binbag_06'] = "trashBig",
    ['prop_rub_binbag_03'] = "trashBig",
    ['prop_rub_binbag_01b'] = "trashBig",
    ['hei_prop_heist_binbag'] = "trashBig",
    ['ng_proc_binbag_01a'] = "trashBig",
    ['p_binbag_01_s'] = "trashBig",

    -- cash registers
    ['prop_atm_01'] = "atm_money",
    ['prop_atm_02'] = "atm_money",
    ['prop_fleeca_atm'] = "atm_money",

    -- broken vehicles
    ['prop_rub_carwreck_1'] = "carLoot",
    ['prop_rub_carwreck_2'] = "carLoot",
    ['prop_rub_carwreck_3'] = "carLoot",
    ['prop_rub_carwreck_5'] = "carLoot",
    ['prop_rub_carwreck_6'] = "carLoot",
    ['prop_rub_carwreck_7'] = "carLoot",
    ['prop_rub_carwreck_8'] = "carLoot",
    ['prop_rub_carwreck_9'] = "carLoot",
    ['prop_rub_carwreck_10'] = "carLoot",
    ['prop_rub_carwreck_11'] = "carLoot",
    ['prop_rub_carwreck_12'] = "carLoot",
    ['prop_rub_carwreck_13'] = "carLoot",
    ['prop_rub_carwreck_14'] = "carLoot",
    ['prop_rub_carwreck_15'] = "carLoot",
    ['prop_rub_carwreck_16'] = "carLoot",
    ['prop_rub_carwreck_17'] = "carLoot",
    ['prop_rub_carwreck_18'] = "carLoot",
    ['prop_rub_carwreck_19'] = "carLoot",
    ['prop_rub_carwreck_20'] = "carLoot",
    
}

Config.propDeleteOnloot = {
    ['prop_tool_blowtorch'] = true,
    ['prop_battery_02'] = true,
    ['prop_battery_01'] = true,
    ['prop_car_battery_01'] = true,
    ['prop_rub_binbag_sd_01'] = true,
    ['prop_ld_rub_binbag_01'] = true,
    ['prop_rub_binbag_sd_02'] = true,
    ['prop_ld_binbag_01'] = true,
    ['prop_cs_rub_binbag_01'] = true,
    ['prop_cs_street_binbag_01'] = true,
    ['prop_rub_binbag_03b'] = true,
    ['prop_rub_binbag_04'] = true,
    ['prop_rub_binbag_01'] = true,
    ['prop_rub_binbag_08'] = true,
    ['prop_rub_binbag_05'] = true,
    ['p_rub_binbag_test'] = true,
    ['prop_rub_binbag_06'] = true,
    ['prop_rub_binbag_03'] = true,
    ['prop_rub_binbag_01b'] = true,
    ['hei_prop_heist_binbag'] = true,
    ['ng_proc_binbag_01a'] = true,
    ['p_binbag_01_s'] = true,
    ['prop_box_guncase_02a'] = true,
    ['prop_box_guncase_01a'] = true,
    ['prop_box_guncase_03a'] = true,
    ['prop_ld_ammo_pack_01'] = true,
    ['prop_ld_ammo_pack_03'] = true,
    ['prop_ld_ammo_pack_02'] = true,
    ['prop_box_ammo07b'] = true,
    ['prop_box_ammo07a'] = true,
    ['prop_box_ammo01a'] = true,
    ['prop_box_ammo04a'] = true,
    ['prop_box_ammo02a'] = true,
    ['v_ret_gc_ammo3'] = true,
}

Config.lootIncreaseZones = {
    {coords = vector3(215.578, -1135.859, 29.29675),radius = 400.0,loopIncrease = 2} --- default loopIncrease if the specific loop increase for the prop not defined
} ---- places where the loot will be increased

Config.disableLootZones = {
    --{coords = vector3(215.578, -1135.859, 29.29675),radius = 400.0},
    --{coords = vector3(215.578, -1135.859, 29.29675),radius = 400.0}
} ---- places where loot will be disabled

Config.propsDrawDistance = 300.0

Config.forcedPropLocations = {
    {
        model = `ex_prop_crate_jewels_bc`, 
        coords = vector3(-852.0,231.0,73.0), 
        heading = 90.0, 
        forceOnGroundProperly = true
    },
    {
        model = `ex_prop_crate_jewels_bc`, 
        coords = vector3(-1448.0,5071.0,62.0), 
        heading = 90.0, 
        forceOnGroundProperly = true
    },

} ---- this is kind of a way of making a Ymap from your Config

Config.Locales = {
    ["click_get_item"] = "Click to get this items",
    ["click_get_items"] = "Click to get all items",
    ["nothing_here"] = "There is nothing here",
    ["get_all"] = "Get all items",
    ["search"] = "Search",
    ["search_animal"] = "Search Animal",
    ["need_cut_weapon"] = "You need a cutting weapon",
    ["search_dumpster"] = "Deep Search"
}









Config.Framework = nil
Config.UseTargetExport = nil
Config.inventory = nil
--------------------------------------
if GetResourceState('es_extended') ~= 'missing' then 
    Config.Framework = "ESX"
elseif GetResourceState('qb-core') ~= 'missing' then 
    Config.Framework = "QB"
elseif GetResourceState('qbox') ~= 'missing' then 
    Config.Framework = "QB"
else
    print("[^3WARNING^7] NO COMPATIBLE FRAMEWORK FOUND")
end

if GetResourceState('ox_target') ~= 'missing' or GetResourceState('qtarget') ~= 'missing' then 
    Config.UseTargetExport = 'qtarget'
elseif GetResourceState('qb-target') ~= 'missing' then 
    Config.UseTargetExport = "qb-target"
else
    print("[^3WARNING^7] NO TARGET SCRIPT FOUND")
end

if GetResourceState('ox_inventory') ~= 'missing' then 
    Config.inventory = 'ox_inventory'
elseif GetResourceState('qb-inventory') ~= 'missing' then 
    Config.inventory = 'qb-inventory'
else

end --- this is just to find your images folder to add the inventory images to the loot menu, you can check the open souce of your framework to check where this variable is used



local errorTypes = nil
for k,v in pairs(Config.types) do
    if v.probabilityLoots and v.probabilityLoots.items then
        local count = 0
        for k2,v2 in ipairs(v.probabilityLoots.items) do
            count = count + v2.probability
        end
        if count > 100 then
            if not errorTypes then
                errorTypes = '[^3LIST^7] '..k
            else
                errorTypes = errorTypes..","..k
            end
        end
    end
end

if errorTypes then
    print("[^3WARNING^7] THE SUM OF YOUR PROBABILITY IS BIGGER THAN 100% IN THIS LOOT TYPES: \n"..errorTypes)
end



