Config = {}

Config.refreshTime = 20 ---minutes ---------- this is the time you will need to wait before you can get wood or stone from a certain Rock or Tree

Config.UseProgressBar = true

Config.OnlyGatherLastAttack = false

Config.ProgressBars = {
    ["get_water"] = {
        duration = 2000,
        label = "getting water...",
        animation = {
            animDict = 'amb@prop_human_bum_bin@base',
            anim = 'base'
        }
    },
}

Config.types = {
    ["stone_1"] = {
        fixedLoots = {
            {name = "stone",count = 15} ----- You will always get this item for each attack on a material that has this loot type
        }, -- can be empty
        probabilityLoots = {
            loop = 1, ----- each loop an item from the list bellow will be chosen
            items = {
                {names = {'iron','steel'},minValue = 1,maxValue = 2,probability = 20}, ------ there is 20% chance of getting 1 or 2 iron or 1 or 2 scrap
                {names = {'copperore'},minValue = 5,maxValue = 20,probability = 50} -------- there is 50% chance of getting a number from 5 to 20 of copper and there is 100 - 50 - 20 = 30% -- 30% chance of getting nothing                                                              
            } ---- the sum of all the probabilities on this list can't be bigger than 100% ---- 20 + 50 = 70% => 70% < 100% so is all good
        } -- is optional
    },
    ["stone_2"] = {
        fixedLoots = {
            {name = "stone",count = 15} ----- You will always get this item for each attack on a material that has this loot type
        }, -- can be empty
        probabilityLoots = {
            loop = 1, ----- each loop an item from the list bellow will be chosen
            items = {
                {names = {'iron','aluminum'},minValue = 8,maxValue = 12,probability = 20}, ------ there is 20% chance of getting 1 or 2 iron or 1 or 2 scrap
                {names = {'copperore'},minValue = 5,maxValue = 20,probability = 50} -------- there is 50% chance of getting a number from 5 to 20 of copper and there is 100 - 50 - 20 = 30% -- 30% chance of getting nothing                                                              
            } ---- the sum of all the probabilities on this list can't be bigger than 100% ---- 20 + 50 = 70% => 70% < 100% so is all good
        } -- is optional
    },
    ["wood_1"] = {
        fixedLoots = {
            {name = "wood",count = 10} 
        }
    },
    ["scrap_1"] = {
        fixedLoots = {
            {name = 'metalscrap',count = 1} 
        }
    },
}

Config.tools = {
    [GetHashKey("WEAPON_POOLCUE")] = {
        [127813971] = {
            lootType = "stone_1",
            maxAttacks = 5
        }, -- this Key can be material hash or object model hash
        [-840216541] = {
            lootType = "stone_1",
            maxAttacks = 5
        },
    },
    [GetHashKey("WEAPON_HATCHET")] = {
        [-1915425863] = {
            lootType = "wood_1",
            maxAttacks = 5
        }
    },
    [GetHashKey("WEAPON_BATTLEAXE")] = {
        [-1915425863] = {
            lootType = "wood_1",
            maxAttacks = 5
        }
    },
    [GetHashKey("WEAPON_STONE_HATCHET")] = {
        [-1915425863] = {
            lootType = "wood_1",
            maxAttacks = 5
        } 
    },
    [GetHashKey("WEAPON_JACKHAMMER")] = {
        [127813971] = {
            lootType = "stone_2",
            maxAttacks = 50,
            gatherDelay = 5, --- how much time x 100 in miliseconds between gathering events ( values lower than 100ms will be 100ms) (500ms)
        }, -- this Key can be material hash or object model hash
        [-840216541] = {
            lootType = "stone_2",
            maxAttacks = 50,
            gatherDelay = 5, --- how much time x 100 in miliseconds between gathering events ( values lower than 100ms will be 100ms) (500ms)
        },
    },
    [GetHashKey("WEAPON_CONSAW")] = {
        [-93061983] = {
            lootType = "scrap_1",
            maxAttacks = 50,
            gatherDelay = 5, --- how much time x 100 in miliseconds between gathering events ( values lower than 100ms will be 100ms) (500ms)
        },
    },
    [GetHashKey("WEAPON_CHAINSAW")] = {
        [-1915425863] = {
            lootType = "wood_1",
            maxAttacks = 50,
            gatherDelay = 5, --- how much time x 100 in miliseconds between gathering events ( values lower than 100ms will be 100ms) (500ms)
        } 
    }
}

Config.treeMaterials = {
    [-1915425863] = true,
} -- this will help with the trees hitbox

------------- Water related

Config.empty = {
    ['empty_bottle'] = 'full_bottle'
}

Config.debug = false

Config.customWeapons = {
    [`WEAPON_CHAINSAW`] = {
        damagePed = 10, 
        damagePlayer = 5,
        damageEffect = {
            dict = 'core',
            name = 'blood_wheel',
            scale = 1.0
        }, 
        ammoUseDelay = 5, --- how much time x 100 in miliseconds between ammo is used (500ms)
        engineEffect = {
            dict = 'core',
            name = 'ent_amb_generator_smoke',
            scale = 0.2
        }
    },
    [`WEAPON_JACKHAMMER`] = {
        damagePed = 10, 
        damagePlayer = 5, 
        damageEffect = {
            dict = 'core',
            name = 'blood_stab',
            scale = 1.0
        }, 
        ammoUseDelay = 5, --- how much time x 100 in miliseconds between ammo is used (500ms)
        engineEffect = {
            dict = 'core',
            name = 'ent_amb_generator_smoke',
            scale = 0.2
        }
    },
    [`WEAPON_CONSAW`] = {
        damagePed = 10, 
        damagePlayer = 5,
        damageEffect = {
            dict = 'core',
            name = 'blood_wheel',
            scale = 1.0
        }, 
        ammoUseDelay = 5, --- how much time x 100 in miliseconds between ammo is used (500ms)
        engineEffect = {
            dict = 'core',
            name = 'ent_amb_generator_smoke',
            scale = 0.2
        }
    }
}

Config.materialPtfx = {
    [127813971] = {
        dict = 'core',
        name = 'ent_dst_concrete_large',
        scale = 0.5,
    },
    [-840216541] = {
        dict = 'core',
        name = 'ent_dst_concrete_large',
        scale = 0.5,
    },
    [-1915425863] = {
        dict = 'core',
        name = 'ent_brk_tree_trunk_bark',
        scale = 1.0,
    },
    [-93061983] = {
        dict = 'core',
        name = 'ent_dst_metal_frag',
        scale = 0.5,
    }
} -- this is for the custom weapons

Config.Framework = nil
--------------------------------------
if GetResourceState('es_extended') ~= 'missing' then 
    Config.Framework = "ESX"
elseif GetResourceState('qb-core') ~= 'missing' then 
    Config.Framework = "QB"
else
    print("[^3WARNING^7] NO COMPATIBLE FRAMEWORK FOUND")
end

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


