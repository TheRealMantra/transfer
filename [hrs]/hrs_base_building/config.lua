Config  = {}

if GetResourceState('es_extended') ~= 'missing' then 
    Config.Framework = "ESX"
elseif GetResourceState('qb-core') ~= 'missing' then 
    Config.Framework = "QB"
elseif GetResourceState('qbx_core') ~= 'missing' then 
    Config.Framework = "QB"
else
    print("[^3WARNING^7] NO COMPATIBLE FRAMEWORK FOUND")
end

if GetResourceState('ox_target') ~= 'missing' or GetResourceState('qtarget') ~= 'missing' then 
    Config.UseTargetExport = 'qtarget'
elseif GetResourceState('qb-target') ~= 'missing' then 
    Config.UseTargetExport = "qb-target"
else
    Config.UseTargetExport = false
    print("[^3WARNING^7] NO TARGET SCRIPT FOUND")
end

if GetResourceState('ox_lib') ~= 'missing' then 
    Config.ContextMenu = 'ox_lib'
elseif GetResourceState('esx_context') ~= 'missing' then 
    Config.ContextMenu = 'esx_context'
elseif GetResourceState('qb-menu') ~= 'missing' then 
    Config.ContextMenu = 'qb-menu'
else
    print("[^3WARNING^7] NO COMPATIBLE MENU SCRIPT FOUND")
end

if GetResourceState('ox_inventory') ~= 'missing' then 
    Config.inventory = 'ox_inventory'
elseif GetResourceState('qb-inventory') ~= 'missing' then 
    Config.inventory = 'qb-inventory'
elseif GetResourceState('inventory') ~= 'missing' then 
    Config.inventory = 'chezza_inventory'
elseif GetResourceState('core_inventory') ~= 'missing' then 
    Config.inventory = 'core_inventory'
elseif GetResourceState('qs-inventory') ~= 'missing' then 
    Config.inventory = 'qs-inventory'
elseif GetResourceState('axfw-inventory') ~= 'missing' then 
    Config.inventory = 'axfw-inventory'
elseif GetResourceState('origen_inventory') ~= 'missing' then 
    Config.inventory = 'origen_inventory'
else
    print("[^3WARNING^7] NO COMPATIBLE INVENTORY SCRIPT FOUND (Storages will not work)")
end

function SetLocales(lang)
    local newLocales = {}
    if languages[lang] then
        for k,v in pairs(languages['en']) do
            if languages[lang][k] then
                newLocales[k] = languages[lang][k]
            else
                newLocales[k] = v.." (translation missing) "..k
            end
        end
        --print(k,newLocales[k])
    else
        newLocales = languages['en']
        print("[^3WARNING^7] LANGUAGE '"..lang.."' NOT FOUND IN locales.lua FILE")
    end
    return newLocales
end

------------------------------------------------------------------------------------
---------------------- CONFIG ------------------------------------------------------
------------------------------------------------------------------------------------
Config.Locales = SetLocales('en')

Config.disableExplosiveOptionOnOwnedProp = true --- if true you will not be able to explode your own props

Config.UseProgressBar = true -- if false progressbar will not be used

Config.showTutorial = true --- show tutorial information when positioning a prop

Config.usingBlackout = false ---- if not using blackout the light will only function at night even if turned on (this can be ingnord if usingOldLightsSystem is set to false)

Config.usingOldLightsSystem = false --- recommended to be false for performance in blackout and to be able to turn lights on during day time if not in blackout (ONLY THE DEFAULT LIGHTS WILL WORK as they were modified)

Config.usingOldInventoryMethod = false --------- set this true if you have storages created on the script versions before the Config.inventory existed, check "OnStorageOpen" function if you want to understand better what changed

Config.useRoutingBuckets = false --- if you want to have routing bucket working
Config.useRoutingBucketsThread = false --- go check the server unlocked part i would recomend using the trigger on the script who changes bucket, if you don't have that option this way works but is not ideal

Config.basesDrawDistance = 300.0 ---- not recomended to edit

Config.needCodeLockItem = "codelock" ---- here you can choose an item to be the code lock item, if you keep this as false code lock item will not be necessary 
Config.doorsLockedByDefault = true ---- when you put a door it will be locked to everyone except you and your friends
Config.storagesLockedByDefault = true ---- when you put a storage it will be locked to everyone except you and your friends

Config.propAlpha = 180

Config.poolSizeProtection = 1200 ------------ this is a protection against building in a massive Ymap, will not let you build in a zone with more than 2000 props around you

Config.maxCrewMembers = 10 -------- limit of members per Crew (false if you don't want this limit)

Config.maxPropsPerIdentifier = 1000 ---- limit of props per identifier (false if you don't want this limit)

Config.propLimitPerType = {
    ['beds'] = 1,
    ['light'] = 50, -- if you are using lights on blackout mode they are extremly resource heavy so limits are recomended
    ['buildFlag'] = 1
}

Config.lightDrawDistance = 100 -- used to make sure you only draw lights in this radius around you

Config.wrongCodesPerRestart = 10 ---- each player can only set the code wrong on doors and storages 10 times per server restart

Config.crewBypassCodeLock = false --- the crew members will need to set the code like everyone else

Config.keepBuilding = true --- if true after you build an object the script will put you in building mode again

Config.hourUpkeepCheck = false --- (if false is recommended atleast one server restart per day) if true every hour the script will check if any players props need fixing and repair the base with the upkeep prop materials, if false the checks will only happen when server starts

Config.upkeepRadius = 150.0 -- default upkeep radius for the base upkeep props

Config.usePlayerFrameworkName = true --- if the crews player names should be the framework name or just normal steam/rockstar name

--Config.propWaitTime = 0 -- irrelevant

Config.ProgressBars = { 
    ["prop_upgrade"] = {
        duration = 5000,
        label = Config.Locales['prog_prop_upgrade'],
        animation = {
            task  = 'WORLD_HUMAN_HAMMERING'
        }
    },
    ["prop_repair"] = {
        duration = 5000,
        label = Config.Locales['prog_prop_repair'],
        animation = {
            task  = 'WORLD_HUMAN_HAMMERING'
        }
    },
    ["plant_c4"] = {
        duration = 7000,
        label = Config.Locales['prog_plant_c4'],
        animation = {
            animDict = 'anim@heists@ornate_bank@thermal_charge',
            anim = 'thermal_charge'
        }
    },
    ["health_regen_bed"] = {
        duration = 20000,
        label = Config.Locales['prog_health_regen_bed'],
        animation = {
            flag = 0,
            animDict = 'anim@mp_bedmid@left_var_02',
            anim = 'f_sleep_l_loop_bighouse'
        }
    },
    ["health_regen_sofa"] = {
        duration = 30000,
        label = Config.Locales['prog_health_regen_sofa'],
        animation = {
            animDict = 'anim@amb@business@cfid@cfid_desk_no_work_bgen_chair_no_work@',
            anim = 'noddingoff_sleep_lazyworker'
        }
    },
    ["prop_remove"] = {
        duration = 8000,
        label = Config.Locales['prog_prop_remove'],
        animation = {
            task  = "WORLD_HUMAN_HAMMERING"
        }
    },
    ["add_fuel"] = {
        duration = 8000,
        label = Config.Locales['prog_add_fuel'],
        animation = {
            animDict = 'amb@prop_human_bum_bin@base',
            anim = 'base'
        }
    },
    ["prop_build"] = {
        duration = 2000,
        label = Config.Locales['prog_prop_build'],
        animation = {
            task  = "WORLD_HUMAN_HAMMERING"
        }
    },
    ["add_ammo"] = {
        duration = 8000,
        label = "Add Ammo",
        animation = {
            animDict = 'amb@prop_human_bum_bin@base',
            anim = 'base'
        }
    },
}

Config.explosionItems = {
    ["weapon_stickybomb"] = {
        damage = 7500.0, -- damage to the prop
        delay = 5 -- time to explode (seconds)
    },
    ["weapon_grenade"] = {
        damage = 4000.0,
        delay = 5
    },
} -- if you want to use items for raiding 

Config.weaponsDamage = {
    [`weapon_rpg`] = 20000.0,
    [`weapon_stickybomb`] = 20000.0
} -- if you want to use weapons for raiding you can use this, to choose the damage they give to props

Config.fuelItem = "gasoline" -- for the generator (general)

Config.saveOnStopScriptOnly = false  ------ only saves props health on restart (i used the txadmin event to force save, but you can do it in other ways is all in the opensource server) 

--Config.disableBuildingBlips = {
--    label = "No build Zones",
--    color = 1,
--    alpha = 128,
--    scale = 1.0,
--    sprite = 364,
--    shortRange = true      
--} ----------- if you don't want blips just do (Config.disableBuildingBlips = false)

--Config.disableBuilding = {
--    {coords = vector3(215.578, -1135.859, 29.29675),radius = 400.0}
--} ----------- zones to disable building

Config.refreshTime = 300000 ------ ms (300000ms = 5min)
Config.refreshTimeLifeRemove = 2.5 ------ life removed every Config.refreshTime ms (FLOAT VALUE)
Config.refreshTimeFuelRemove = 0.5 ------ fuel removed every Config.refreshTime ms (if ON) (INT VALUE)

Config.upkeepMult = 1.0 ------ upkeep cost will be 100% of building cost 

Config.claimPropType = {
    ["foundations"] = {radius = 9.0},
    ["bigwall"] = {radius = 9.0},
    ["ceiling"] = {radius = 9.0},
    ["upkeep"] = {radius = 9.0},
    ["buildFlag"] = {radius = 60.0},
} ----- props that claim an area

Config.deadStorage = GetHashKey("prop_money_bag_01") ------- if you change this you have to add it in the Config.Models

Config.disableOfflineRaiding = true --- this Config will prevent Offline Raiding
Config.offlineRaidingDisconnectTime = 15 --- raiding will be possible for 15 minutes after the last owner of the base disconnected
Config.offlineRaidingRaidingTime = 45 --- after the raid started even if the owners of the base disconnect raiding will be possible for the next 45 minutes
Config.disableCrewManagementDuringRaidingTime = true --- this will prevent people from editing their crew while beeing raided to prevent exploits of the offline raiding mechanics (ONLY FOR OFFLINE RAIDING)

Config.raidNotification = false --- when your base suffers damage you get a notification (In Game)
Config.raidNotificationDiscord = false -- when your base suffers damage you get a notification in a dicord channel with @ (You need to be in a crew for this to work, player solo will need to create a solo crew)
Config.raidNotificationDiscordDm = false -- this will need you to add a bot token to your logs file (will dm the player beeing raided)
Config.raidNotificationTimer = 25 -- After receiving a raid notification, no additional notifications for base damage will be sent for the next 25 minutes

Config.raidSchedule = {
    ["Sunday"] = {
        {start = "00:00", finish = "01:00"},
        {start = "09:00", finish = "23:00"}
    },
    ["Monday"] = {
        {start = "00:00", finish = "01:00"},
        {start = "09:00", finish = "23:00"}
    },
    ["Tuesday"] = {
        {start = "00:00", finish = "02:00"},
        {start = "09:00", finish = "24:00"}
    },
    ["Wednesday"] = {
        {start = "00:00", finish = "02:00"},
    },
    -- ["Thrusday"] = {},
    -- ["Friday"] = {},
    ["Saturday"] = {
        {start = "00:00", finish = "01:00"},
        {start = "09:00", finish = "23:00"}
    },
} -- if you don't want to define raiding schedules you can set this Config to false, Config.raidSchedule = false, or just comment this config section

Config.crewPermissions = {
    {ident = "canBuild", label = "Can Build in Crew Base"},
    {ident = "canOpenDoors", label = "Can Open Crew Doors"},
    {ident = "canOpenStorages", label = "Can Open Crew Storages"},
    {ident = "canOpenUpkeep", label = "Can Open Crew Stocks"},
    {ident = "canRemoveProps", label = "Can remove crew props"},
    {ident = "canUpgradeProps", label = "Can upgrade crew props"},
    {ident = "canInteract", label = "Can interact with Crew Objects"},
    {ident = "canAdvancedInteract", label = "Can advanced interact with Crew Objects"},
    {ident = "canChangeCode", label = "Can change code from Crew Objects"},
    {ident = "canDriveVehicles", label = "Can Drive Crew Vehicles"},
    {ident = "canManageMembers", label = "Can manage members"},
    {ident = "canInviteMembers", label = "Can Invite Crew members"},
    {ident = "canRemoveMembers", label = "Can Remove Crew members"},
}

Config.windEfficiency = {
    [1] = 0, --%
    [2] = 0,
    [3] = 5,
    [4] = 10,
    [5] = 15,
    [6] = 25,
    [7] = 35,
    [8] = 50,
    [9] = 65,
    [10] = 80,
    [11] = 90,
    [12] = 100,
    [13] = 95,
    [14] = 90,
    [15] = 85,
    [16] = 80,
    [17] = 70,
    [18] = 60,
    [19] = 50,
    [20] = 40,
    [21] = 30,
    [22] = 20,
    [23] = 10,
    [24] = 5,
    [25] = 0
} -- wind efficiency for wind Turbines per m/s wind speed increase

Config.solarEfficiencyByHour = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 5,
    [6] = 15,
    [7] = 35,
    [8] = 60,
    [9] = 80,
    [10] = 90,
    [11] = 100,
    [12] = 100,
    [13] = 100,
    [14] = 90,
    [15] = 75,
    [16] = 50,
    [17] = 30,
    [18] = 15,
    [19] = 5,
    [20] = 0,
    [21] = 0,
    [22] = 0,
    [23] = 0,
    [24] = 0
} -- this is the efficency of solar pannels in % for each hour of the day (LA Summer)

Config.solarEfficiencyByWeather = {
    ['EXTRASUNNY'] = 100,
    ['CLEAR'] = 95,
    ['NEUTRAL'] = 85,
    ['SMOG'] = 60,
    ['FOGGY'] = 40, 
    ['OVERCAST'] = 45,
    ['CLOUDS'] = 60,
    ['CLEARING'] = 70,
    ['RAIN'] = 25, 
    ['THUNDER'] = 15,
    ['SNOW'] = 30, 
    ['BLIZZARD'] = 15, 
    ['SNOWLIGHT'] = 50,
    ['XMAS'] = 50, 
    ['HALLOWEEN'] = 40
} -- this is the efficency of solar pannels in % for each weather

Config.ElectricCableItem = "cable" -- if nil electric connections will be FREE 1 cable = 1m 

Config.CircuitLimits = {
    maxGenerators = 8, -- max 8 generators in a circuit
    maxPowerUsers = 50, -- max 50 props that use power per circuit
    maxPowerDistributors = 50, -- max 25 props that distribute power per circuit
    maxBatteries = 6, -- max 6 batteries per circuit
    maxPowerCableDistance = 20, -- max lenght of electric cable  
    maxCircuitSize = 100 -- the max distance between the two more distant props in the circuit
}

Config.baseRainBlock = true -- this option will prevent raining inside the bases (experimental feature)

-- Config.disableZChange = true -- if this is true the up and down arrows will not work and the object z value will be changed by your mouse (better to use in first person) (in DEV)

Config.buildFlag = false -- [IN DEV]

Config.Models = {
    --- doors
    ["model_door_wood"] = {
        item = "model_door_wood",
        life = 10000.0,
        type = "doors",
        subtype = "zrotate",
        upgrade = GetHashKey("model_door_stone"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_door_stone"] = {
        item = "model_door_stone",
        life = 15000.0,
        type = "doors",
        subtype = "zrotate",
        upgrade = GetHashKey("model_door_metal"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_door_metal"] = {
        item = "model_door_metal",
        life = 20000.0,
        type = "doors",
        subtype = "zrotate",
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    --- windows
    ["model_window_wood"] = {
        item = "model_window_wood",
        life = 10000.0,
        type = "windows",
        subtype = "zrotate",
        upgrade = GetHashKey("model_window_stone"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_window_stone"] = {
        item = "model_window_stone",
        life = 15000.0,
        type = "windows",
        subtype = "zrotate",
        upgrade = GetHashKey("model_window_metal"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_window_metal"] = {
        item = "model_window_metal",
        life = 20000.0,
        type = "windows",
        subtype = "zrotate",
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    --- stairs
    ["model_stairs_wood"] = {
        item = "model_stairs_wood",
        life = 10000.0,
        type = "walls",
        subtype = 'stairs',
        --upgrade = GetHashKey("model_windowway_stone"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_stairs_stone"] = {
        item = "model_stairs_stone",
        life = 15000.0,
        type = "walls",
        subtype = 'stairs',
        --upgrade = GetHashKey("model_windowway_stone"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_stairs_metal"] = {
        item = "model_stairs_metal",
        life = 20000.0,
        type = "walls",
        subtype = 'stairs',
        --upgrade = GetHashKey("model_windowway_stone"),
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    --- walls
    ["model_windowway_wood"] = {
        item = "model_windowway_wood",
        life = 10000.0,
        type = "walls",
        workAsPillar = true,
        subtype = "windowway",
        upgrade = GetHashKey("model_windowway_stone"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_windowway_stone"] = {
        item = "model_windowway_stone",
        life = 15000.0,
        type = "walls",
        workAsPillar = true,
        upgrade = GetHashKey("model_windowway_metal"),
        subtype = "windowway",
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_windowway_metal"] = {
        item = "model_windowway_metal",
        life = 20000.0,
        type = "walls",
        workAsPillar = true,
        subtype = "windowway",
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    ["model_wall_wood"] = {
        item = "model_wall_wood",
        life = 10000.0,
        type = "walls",
        workAsPillar = true,
        upgrade = GetHashKey("model_wall_stone"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_wall_stone"] = {
        item = "model_wall_stone",
        life = 15000.0,
        type = "walls",
        workAsPillar = true,
        upgrade = GetHashKey("model_wall_metal"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_wall_metal"] = {
        item = "model_wall_metal",
        life = 20000.0,
        type = "walls",
        workAsPillar = true,
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    --- small walls
    
    ["model_wall_wood_small"] = {
        item = "model_wall_wood_small",
        life = 10000.0,
        type = "walls",
        upgrade = GetHashKey("model_wall_stone_small"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_wall_stone_small"] = {
        item = "model_wall_stone_small",
        life = 15000.0,
        type = "walls",
        upgrade = GetHashKey("model_wall_metal_small"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_wall_metal_small"] = {
        item = "model_wall_metal_small",
        life = 20000.0,
        type = "walls",
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    --- roofs

    ["model_wall_wood_roof_triangle"] = {
        item = "model_wall_wood_roof_triangle",
        life = 10000.0,
        type = "walls",
        subtype = "roof",
        disableRainBlock = `model_ceiling_block_triangle_roof`,
        disableRainBlockHeading = 90.0,
        disableRainBlockZChange = 0.05,
        upgrade = GetHashKey("model_wall_stone_roof_triangle"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_wall_stone_roof_triangle"] = {
        item = "model_wall_stone_roof_triangle",
        life = 15000.0,
        type = "walls",
        subtype = "roof",
        disableRainBlock = `model_ceiling_block_triangle_roof`,
        disableRainBlockHeading = 90.0,
        disableRainBlockZChange = 0.05,
        upgrade = GetHashKey("model_wall_metal_roof_triangle"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_wall_metal_roof_triangle"] = {
        item = "model_wall_metal_roof_triangle",
        life = 20000.0,
        type = "walls",
        subtype = "roof",
        disableRainBlock = `model_ceiling_block_triangle_roof`,
        disableRainBlockHeading = 90.0,
        disableRainBlockZChange = 0.05,
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    ["model_wall_wood_roof"] = {
        item = "model_wall_wood_roof",
        life = 10000.0,
        type = "walls",
        subtype = "roof",
        disableRainBlock = `model_ceiling_block_roof`, 
        disableRainBlockHeading = 90.0,
        disableRainBlockZChange = 0.05,
        upgrade = GetHashKey("model_wall_stone_roof"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_wall_stone_roof"] = {
        item = "model_wall_stone_roof",
        life = 15000.0,
        type = "walls",
        subtype = "roof",
        disableRainBlock = `model_ceiling_block_roof`,
        disableRainBlockHeading = 90.0,
        disableRainBlockZChange = 0.05,
        upgrade = GetHashKey("model_wall_metal_roof"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_wall_metal_roof"] = {
        item = "model_wall_metal_roof",
        life = 20000.0,
        type = "walls",
        subtype = "roof",
        disableRainBlock = `model_ceiling_block_roof`,
        disableRainBlockHeading = 90.0,
        disableRainBlockZChange = 0.05,
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    --- triangle walls

    ["model_wall_wood_triangle"] = {
        item = "model_wall_wood_triangle",
        life = 10000.0,
        type = "walls",
        upgrade = GetHashKey("model_wall_stone_triangle"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_wall_stone_triangle"] = {
        item = "model_wall_stone_triangle",
        life = 15000.0,
        type = "walls",
        upgrade = GetHashKey("model_wall_metal_triangle"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_wall_metal_triangle"] = {
        item = "model_wall_metal_triangle",
        life = 20000.0,
        type = "walls",
        upgrade = GetHashKey("model_wall_metal"),
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    --- doorway

    ["model_doorway_wood"] = {
        item = "model_doorway_wood",
        life = 10000.0,
        type = "walls",
        subtype = "doorway",
        workAsPillar = true,
        upgrade = GetHashKey("model_doorway_stone"),
        crafting = {
            {name = "wood",count = 20}
        }  
    },

    ["model_doorway_stone"] = {
        item = "model_doorway_stone",
        life = 15000.0,
        type = "walls",
        subtype = "doorway",
        workAsPillar = true,
        upgrade = GetHashKey("model_doorway_metal"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_doorway_metal"] = {
        item = "model_doorway_metal",
        life = 20000.0,
        type = "walls",
        workAsPillar = true,
        subtype = "doorway",
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    --- gate frame

    ["model_gateway_wood"] = {
        item = "model_gateway_wood",
        life = 10000.0,
        type = "walls",
        workAsPillar = true,
        subtype = "gateway",
        upgrade = GetHashKey("model_gateway_stone"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_gateway_stone"] = {
        item = "model_gateway_stone",
        life = 15000.0,
        type = "walls",
        workAsPillar = true,
        subtype = "gateway",
        upgrade = GetHashKey("model_gateway_metal"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_gateway_metal"] = {
        item = "model_gateway_metal",
        life = 20000.0,
        type = "walls",
        workAsPillar = true,
        subtype = "gateway",
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },
    
    -------- Base
    ["model_base_wood"] = {
        item = "model_base_wood",
        life = 10000.0,
        type = "foundations",
        subtype = "floor",
        geometry = 'square',
        upgrade = GetHashKey("model_base_stone"),
        crafting = {
            {name = "wood",count = 20}
        },
        disableIteract = true
    },

    ["model_base_stone"] = {
        item = "model_base_stone",
        life = 15000.0,
        type = "foundations",
        subtype = "floor",
        geometry = 'square',
        upgrade = GetHashKey("model_base_metal"),
        crafting = {
            {name = "stone",count = 20}
        },
        disableIteract = true
    },

    ["model_base_metal"] = {
        item = "model_base_metal",
        life = 20000.0,
        type = "foundations",
        subtype = "floor",
        geometry = 'square',
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ["model_base_wood_triangle"] = {
        item = "model_base_wood_triangle",
        life = 10000.0,
        type = "foundations",
        subtype = "floor",
        geometry = 'triangle',
        upgrade = GetHashKey("model_base_stone_triangle"),
        crafting = {
            {name = "wood",count = 20}
        },
        disableIteract = true
    },

    ["model_base_stone_triangle"] = {
        item = "model_base_stone_triangle",
        life = 15000.0,
        type = "foundations",
        subtype = "floor",
        geometry = 'triangle',
        upgrade = GetHashKey("model_base_metal_triangle"),
        crafting = {
            {name = "stone",count = 20}
        },
        disableIteract = true
    },

    ["model_base_metal_triangle"] = {
        item = "model_base_metal_triangle",
        life = 20000.0,
        type = "foundations",
        subtype = "floor",
        geometry = 'triangle',
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ------ Ceiling

    ["model_ceiling_wood"] = {
        item = "model_ceiling_wood",
        life = 10000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'square',
        disableRainBlock = `model_ceiling_block`,
        upgrade = GetHashKey("model_ceiling_stone"),
        crafting = {
            {name = "wood",count = 20}
        },
        disableIteract = true
    },

    ["model_ceiling_stone"] = {
        item = "model_ceiling_stone",
        life = 10000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'square',
        disableRainBlock = `model_ceiling_block`,
        upgrade = GetHashKey("model_ceiling_metal"),
        crafting = {
            {name = "stone",count = 20}
        },
        disableIteract = true
    },

    ["model_ceiling_metal"] = {
        item = "model_ceiling_metal",
        life = 20000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'square',
        disableRainBlock = `model_ceiling_block`,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ["model_ceiling_wood_triangle"] = {
        item = "model_ceiling_wood_triangle",
        life = 10000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'triangle',
        disableRainBlock = `model_ceiling_block_triangle`,
        disableRainBlockHeading = 90.0,
        upgrade = GetHashKey("model_ceiling_stone_triangle"),
        crafting = {
            {name = "wood",count = 20}
        },
        disableIteract = true
    },

    ["model_ceiling_stone_triangle"] = {
        item = "model_ceiling_stone_triangle",
        life = 15000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'triangle',
        disableRainBlock = `model_ceiling_block_triangle`,
        disableRainBlockHeading = 90.0,
        upgrade = GetHashKey("model_ceiling_metal_triangle"),
        crafting = {
            {name = "stone",count = 20}
        },
        disableIteract = true
    },

    ["model_ceiling_metal_triangle"] = {
        item = "model_ceiling_metal_triangle",
        life = 20000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'triangle',
        disableRainBlock = `model_ceiling_block_triangle`,
        disableRainBlockHeading = 90.0,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    --- Stairs

    ["model_ceilingstairs_wood"] = {
        item = "model_ceilingstairs_wood",
        life = 10000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'square',
        upgrade = GetHashKey("model_ceilingstairs_stone"),
        crafting = {
            {name = "wood",count = 20}
        },
        disableIteract = true
    },

    ["model_ceilingstairs_stone"] = {
        item = "model_ceilingstairs_stone",
        life = 15000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'square',
        upgrade = GetHashKey("model_ceilingstairs_metal"),
        crafting = {
            {name = "stone",count = 20}
        },
        disableIteract = true
    },

    ["model_ceilingstairs_metal"] = {
        item = "model_ceilingstairs_metal",
        life = 20000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'square',
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ----- ladder
    ["model_ceilingladder_wood_triangle"] = {
        item = "model_ceilingladder_wood_triangle",
        life = 10000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'triangle',
        upgrade = GetHashKey("model_ceilingladder_stone_triangle"),
        crafting = {
            {name = "wood",count = 20}
        },
        disableIteract = true
    },

    ["model_ceilingladder_stone_triangle"] = {
        item = "model_ceilingladder_stone_triangle",
        life = 15000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'triangle',
        upgrade = GetHashKey("model_ceilingladder_metal_triangle"),
        crafting = {
            {name = "stone",count = 20}
        },
        disableIteract = true
    },

    ["model_ceilingladder_metal_triangle"] = {
        item = "model_ceilingladder_metal_triangle",
        life = 10000.0,
        type = "ceiling",
        subtype = "floor",
        geometry = 'triangle',
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ----- pillar 

    ["model_pillar_wood"] = {
        item = "model_pillar_wood",
        life = 10000.0,
        type = "pillar",
        upgrade = GetHashKey("model_pillar_stone"),
        crafting = {
            {name = "wood",count = 20}
        },
        disableIteract = true
    },

    ["model_pillar_stone"] = {
        item = "model_pillar_stone",
        life = 15000.0,
        type = "pillar",
        upgrade = GetHashKey("model_pillar_metal"),
        crafting = {
            {name = "stone",count = 20}
        },
        disableIteract = true
    },

    ["model_pillar_metal"] = {
        item = "model_pillar_metal",
        life = 20000.0,
        type = "pillar",
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ----- gate

    ["model_gate_wood"] = {
        item = "model_gate_wood",
        life = 10000.0,
        type = "gate",
        upgrade = GetHashKey("model_gate_stone"),
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["model_gate_stone"] = {
        item = "model_gate_stone",
        life = 15000.0,
        type = "gate",
        upgrade = GetHashKey("model_gate_metal"),
        crafting = {
            {name = "stone",count = 20}
        }
    },

    ["model_gate_metal"] = {
        item = "model_gate_metal",
        life = 20000.0,
        type = "gate",
        crafting = {
            {name = "metalscrap",label = "Scrap Metal",count = 20}
        }
    },

    ------ bed

    ["bkr_prop_biker_campbed_01"] = {
        item = "bkr_prop_biker_campbed_01",
        life = 10000.0,
        type = "beds",
        subtype = "findGroud",
        TriggerEvent = { 
            type = "client",
            event = "hrs_base_building:Regen",
            args = {"hrs_base_entity","bed",'health_regen_bed',90},
            entityAsArg = "hrs_base_entity" --- in the arguments, this word will be replaced by the Entity
        },
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ------- sofa

    ["v_tre_sofa_mess_b_s"] = {
        item = "v_tre_sofa_mess_b_s",
        life = 10000.0,
        type = "beds",
        subtype = "findGroud",
        TriggerEvent = {
            type = "client",
            event = "hrs_base_building:Regen",
            --args = {"hrs_base_entity","bed",'health_regen_bed',90},
            args = {"hrs_base_entity","sofa",'health_regen_sofa',180},
            entityAsArg = "hrs_base_entity" --- in the arguments, this word will be replaced by the Entity
        },
        crafting = {
            {name = "wood",count = 20}
        },
    },

    ----- crafting tables

    ["prop_tool_bench02_ld"] = {
        item = "prop_tool_bench02_ld",
        life = 10000.0,
        type = "crafting",
        subtype = "findGroud",
        noFoundationNeed = true,
        TriggerEvent = {
            type = "client",
            event = "open:workbench",
            args = {1}, --normal crafting table
            entityAsArg = "hrs_base_entity" --- in the arguments, this word will be replaced by the Entity
        },
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["bkr_prop_meth_table01a"] = {
        item = "bkr_prop_meth_table01a",
        life = 20000.0,
        type = "crafting",
        subtype = "findGroud",
        TriggerEvent = {
            type = "client",
            event = "ox_inventory:craftingEvent",
            args = {2}, --- agrs in order
        },
        crafting = {
            {name = "wood",count = 20},
            {name = "metalscrap",count = 20}
        }
    },

    ["gr_prop_gr_bench_02a"] = {
        item = "gr_prop_gr_bench_02a",
        life = 20000.0,
        type = "crafting",
        subtype = "findGroud",
        noFoundationNeed = true,
        TriggerEvent = {
            type = "client",
            event = "open:workbench",
            args = {3}, -- weapon crafting table
            entityAsArg = "hrs_base_entity" --- in the arguments, this word will be replaced by the Entity
        },
        crafting = {
            {name = "wood",count = 20},
            {name = "metalscrap",count = 20}
        }
    },


    -------- test



    -------- generator

    ["model_generator_small"] = {
        item = "model_generator_small",
        life = 20000.0,
        fuelTank = 10.0,
        type = "generator",
        subtype = "findGroud",
        noFoundationNeed = true,
        generatorPower = 2500, -- 2500W
        crafting = {
            {name = "metalscrap",count = 20}
        },
        onPtfx = {
            asset = 'core',
            name = 'ent_amb_generator_smoke',
            scale = 1.0,
            offset = vector3(-0.25,-0.32,0.30),
            rgba = {r = 0.0,g = 0.0,b = 0.0,a = 1.0},
        },
        disableIteract = true
    },

    ["model_generator_big"] = {
        item = "model_generator_big",
        life = 20000.0,
        fuelTank = 100.0,
        fuelItem = "diesel",
        refreshTimeFuelRemove = 1.0,
        refreshTimeLifeRemove = 2.5,
        generatorPower = 15000,
        type = "generator",
        subtype = "findGroud",
        noFoundationNeed = true,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        onPtfx = {
            asset = 'core',
            name = 'ent_amb_generator_smoke',
            scale = 1.0,
            offset = vector3(-0.40,-0.76,2.2),
            rgba = {r = 0.0,g = 0.0,b = 0.0,a = 1.0},
        },
        disableIteract = true
    },

    ["model_generator_medium"] = {
        item = "model_generator_medium",
        life = 20000.0,
        fuelTank = 40.0,
        fuelItem = "diesel",
        refreshTimeFuelRemove = 1.0,
        refreshTimeLifeRemove = 2.5,
        generatorPower = 7000,
        type = "generator",
        subtype = "findGroud",
        noFoundationNeed = true,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        onPtfx = {
            asset = 'core',
            name = 'ent_amb_generator_smoke',
            scale = 1.0,
            offset = vector3(0.22,0.56,1.45),
            rgba = {r = 0.0,g = 0.0,b = 0.0,a = 1.0},
        },
        disableIteract = true
    },

    ["model_battery_pack_6"] = {
        item = "model_battery_pack_6",
        life = 20000.0,
        energyCapacity = 7800, --- 7800Wh
        maxChargingPower = 1000, --- 1000W
        type = "battery",
        subtype = "findGroud",
        electricConnectionOffset = vector3(0.0,0.0,0.15),
        noFoundationNeed = true,
        zDist = -0.025,
        connectToEachOther = {
            ['left'] = 0.0,
            ['right'] = 0.0,
            ['top'] = 0.0,
        },
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ["prop_solarpanel_03"] = {
        item = "prop_solarpanel_03",
        life = 20000.0,
        generatorPower = 1500,
        type = "solarPanel",
        subtype = "findGroud",
        connectToEachOther = {
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        electricConnectionOffset = vector3(1.0,0.5,0.0),
        zDist = -0.15,
        noFoundationNeed = true,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ["prop_solarpanel_02"] = {
        item = "prop_solarpanel_02",
        life = 20000.0,
        generatorPower = 2500,
        type = "solarPanel",
        subtype = "findGroud",
        connectToEachOther = {
            ['left'] = 0.0,
            ['right'] = 0.0
        },
        noFoundationNeed = true,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ["prop_rural_windmill"] = {
        item = "prop_rural_windmill",
        life = 20000.0,
        generatorPower = 1500,
        type = "windTurbine",
        subtype = "findGroud",
        zDist = -0.2,
        electricConnectionOffset = vector3(0.0,0.0,0.2),
        noFoundationNeed = true,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    -- power distributors --

    ["prop_telegraph_06a"] = {
        item = "prop_telegraph_06a",
        life = 20000.0,
        type = "powerDist",
        subtype = "findGroud",
        noFoundationNeed = true,
        electricConnectionOffset = vector3(0.0,0.0,6.3),
        maxConnections = 10,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ["model_powerdist1_wall"] = {
        item = "model_powerdist1_wall",
        life = 20000.0,
        type = "powerDist",
        maxConnections = 5,
        subtype = "findWall",
        noFoundationNeed = true,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        --fDist = -0.2,
        electricConnectionOffset = vector3(0.0,0.0,0.1),
        disableIteract = true,
        ignoreCollision = true
    },

    ["model_powerdist1_switch_wall"] = {
        item = "model_powerdist1_switch_wall",
        life = 20000.0,
        type = "powerDist",
        maxConnections = 5,
        subtype = "findWall",
        noFoundationNeed = true,
        crafting = {
            {name = "metalscrap",count = 20}
        },
        isSwitch = true,
        --fDist = -0.2,
        electricConnectionOffset = vector3(0.0,0.0,0.1),
        disableIteract = true,
        ignoreCollision = true
    },

    -- Power Combiners --

    ["model_powercomb1_wall"] = {
        item = "model_powercomb1_wall",
        life = 20000.0,
        type = "powerComb",
        subtype = "findWall",
        noFoundationNeed = true,
        electricConnectionOffset = vector3(0.0,0.0,0.5),
        crafting = {
            {name = "metalscrap",count = 20}
        },
        disableIteract = true
    },

    ----- storages 

    ["prop_box_wood01a"] = {
        weight = 50000,
        item = "prop_box_wood01a",
        life = 10000.0,
        type = "storages",
        connectToEachOther = {
            ['front'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0,
            ['back'] = 0.0,
            ['top'] = 0.0,
        },
        subtype = "findGroud",
        slots = 50,
        coreStashName = "stash", ---stash type on core_inventory
        crafting = {
            {name = "wood",count = 20}
        }
    },

    ["prop_money_bag_01"] = {
        item = "prop_money_bag_01",
        type = "storages",
        subtype = "deadStorage",
        toDeleteOnRestart = true,
        life = 100.0,
        notUseable = true,
    }, ------- (DO NOT REMOVE THIS PROP)

    ["gr_prop_gr_gunlocker_01a"] = {
        weight = 150000,
        item = "gr_prop_gr_gunlocker_01a",
        life = 20000.0,
        type = "storages",
        connectToEachOther = {
            ['front'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0,
            ['back'] = 0.0,
            ['top'] = 0.0,
        },
        subtype = "findGroud",
        slots = 75,
        coreStashName = "small_storage", ---stash type on core_inventory
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },

    ["p_v_43_safe_s"] = {
        weight = 300000,
        item = "p_v_43_safe_s",
        life = 40000.0,
        type = "storages",
        connectToEachOther = {
            ['front'] = 0.0,
            ['left'] = 0.0,
            ['right'] = 0.0,
            ['back'] = 0.0,
            ['top'] = 0.0,
        },
        subtype = "findGroud",
        slots = 100,
        coreStashName = "big_storage", ---stash type on core_inventory
        crafting = {
            {name = "metalscrap",count = 40}
        }
    },

    --------- Recycle machine

    ["prop_planer_01"] = {
        item = "prop_planer_01",
        life = 20000.0,
        type = "recycle",
        subtype = "findGroud",
        TriggerEvent = {
            type = "client",
            event = "hrs_base_building:recycleItem",
            args = {},
            entityAsArg = "hrs_base_entity"
        },
        power = 250,
        crafting = {
            {name = "metalscrap",count = 20}
        }
    },
    
    -----  campfire 

    ["gr_prop_gr_hobo_stove_01"] = {
        item = "gr_prop_gr_hobo_stove_01",
        life = 5000.0,
        type = "cook",
        subtype = "findGroud",
        TriggerEvent = {
            type = "client",
            event = "example:event",
            args = {}
        },
        noPermission = true, ------ 
        mapProp = true, ----- you can interact with Ymap props 
        crafting = {
            {name = "metalscrap",count = 5}
        }
    },

    ------- garage

    ["prop_container_03b"] = {
        item = "prop_container_03b",
        life = 5000.0,
        type = "garage",
        subtype = "findGroud",
        noFoundationNeed = true,
        TriggerEvent = {
            type = "client",
            event = "hrs_vehicles:openGarageEvent",
            args = {}
        },
        crafting = {
            {name = "metalscrap",count = 5}
        }
    },

    ----- lamps 

    ["model_worklight_2"] = {
        item = "model_worklight_2",
        life = 20000.0,
        type = "light",
        subtype = "findGroud",
        zDist = -0.1,
        noFoundationNeed = true,
        power = 150, -- 150W
        zChange = 0.40,
        fChange = -0.03,
        crafting = {
            {name = "metalscrap",count = 5}
        },
        disableIteract = true
    },
   
    ["model_oldlight_ext"] = {
        item = "model_oldlight_ext",
        life = 20000.0,
        type = "light",
        subtype = "findGroud",
        noFoundationNeed = true,
        power = 150, -- 150W
        --zChange = 3.8,
        --fChange = 0.45,
        lightOffset = vector3(0.45,0.0,3.65),
        lightData = {
            color = {r = 255, g = 230, b = 210},
            intensity = 5.0,
            roundness = 0.0,
            falloff = 7.0,
            distance = 7.0,
            radius = 80.0
        },
        zDist = -0.10,
        electricConnectionOffset = vector3(0.0,0.0,4.25),
        pointGround = true,
        crafting = {
            {name = "metalscrap",count = 5}
        },
        disableIteract = true
    },

    ["model_worklight_1"] = {
        item = "model_worklight_1",
        life = 20000.0,
        type = "light",
        subtype = "findGroud",
        noFoundationNeed = true,
        power = 150, -- 150W
        zChange = 1.80,
        fChange = 0.10,
        crafting = {
            {name = "metalscrap",count = 5}
        },
        disableIteract = true
    },

    ["model_biglight_1"] = {
        item = "model_biglight_1",
        life = 20000.0,
        type = "light",
        subtype = "findGroud",
        noFoundationNeed = true,
        power = 1000, -- 1000W
        zDist = -0.2,
        -- zChange = 0.20,
        -- fChange = 0.10,
        crafting = {
            {name = "metalscrap",count = 5}
        },
        disableIteract = true
    },

    ["model_walllight_1"] = {
        item = "model_walllight_1",
        life = 20000.0,
        type = "light",
        subtype = "findWall",
        noFoundationNeed = true,
        power = 150, -- 150W
        -- zChange = 0.20,
        -- fChange = 0.10,
        crafting = {
            {name = "metalscrap",count = 5}
        },
        disableIteract = true
    },
    
    ["model_ceilinglight_1"] = {
        item = "model_ceilinglight_1",
        life = 20000.0,
        type = "light",
        subtype = "findCeiling",
        noFoundationNeed = true,
        power = 150, -- 150W
        zChange = -0.2,
        fChange = 0.0,
        pointGround = true,
        crafting = {
            {name = "metalscrap",count = 5}
        },
        disableIteract = true
    },

    -------- Big walls stuff 

    ["model_bigwall_wood"] = {
        item = "model_bigwall_wood",
        life = 30000.0,
        type = "bigwall",
        noFoundationSearch = true,
        crafting = {
            {name = "wood",count = 40}
        },
        disableIteract = true
    },

    ["model_biggateway_wood"] = {
        item = "model_biggateway_wood",
        life = 30000.0,
        type = "bigwall",
        subtype = "biggateway",
        noFoundationSearch = true,
        crafting = {
            {name = "wood",count = 40}
        }
    },

    ["model_biggate_wood"] = {
        item = "model_biggate_wood",
        life = 30000.0,
        type = "biggate",
        noFoundationSearch = true,
        crafting = {
            {name = "wood",count = 40}
        }
    },  

    -- ------ test ----
    ["xm3_prop_xm3_whshelf_03a"] = {
        item = "xm3_prop_xm3_whshelf_03a",
        life = 30000.0,
        type = "upkeep",
        upkeepRadius = 150.0,
        subtype = "findGroud",
        disableIteract = true,
        itemStock = {
            ['wood'] = 20000,
            ['metalscrap'] = 20000,
            ['stone'] = 20000,
        },
        noFoundationNeed = true,
        crafting = {
            {name = "wood",count = 40}
        }
    }, 

    -- ["v_ind_cfcovercrate"] = {
    --     item = "v_ind_cfcovercrate",
    --     life = 30000.0,
    --     type = "upkeep",
    --     subtype = "findGroud",
    --     disableIteract = true,
    --     itemStock = {
    --         ['wood'] = 2000,
    --         ['metalscrap'] = 2000,
    --         ['stone'] = 2000,
    --     },
    --     noFoundationNeed = true,
    --     crafting = {
    --         {name = "wood",count = 40}
    --     }
    -- },

    --- decoration 




    --- defense

     ["model_mg_stand"] = {
         item = "model_mg_stand",
         life = 30000.0,
         type = "weapon_stand",
         subtype = "findGroud",
         standHeight = 1.15,
         accepetedWeapon = {
             [`model_mg`] = true,
             [`model_fire_turret`] = true,
             [`model_grenadelauncher`] = true,
             [`model_rpg`] = true,
         },
         noFoundationNeed = true,
         crafting = {
             {name = "wood",count = 40}
         },
         disableIteract = true
     }, 
    
     ["model_fire_turret"] = {
         item = "model_fire_turret",
         life = 30000.0,
         type = "need_stand_weapon",
         bulletInfo = `weapon_molotov`, -- some weapons will not work
         bulletDamage = 0,
         bulletItem = 'weapon_molotov',  -- make sure you add your ammo item image into base building html folder
         maxAmmo = 100,
         range = 50.0,
         power = 250,

         crafting = {
             {name = "wood",count = 40}
         },
         disableIteract = true
     }, 

     ["model_grenadelauncher"] = {
         item = "model_grenadelauncher",
         life = 30000.0,
         type = "need_stand_weapon",
         bulletInfo = `weapon_grenadelauncher`, -- some weapons will not work
         bulletDamage = 0,
         bulletItem = 'weapon_grenade',  -- make sure you add your ammo item image into base building html folder
         maxAmmo = 100,
         range = 50.0,
         power = 250,

         crafting = {
             {name = "wood",count = 40}
         },
         disableIteract = true
     }, 

     ["model_rpg"] = {
         item = "model_rpg",
         life = 30000.0,
         type = "need_stand_weapon",
         bulletInfo = `weapon_rpg`, -- some weapons will not work
         bulletDamage = 100,
         bulletItem = 'ammo-rocket',  -- make sure you add your ammo item image into base building html folder
         maxAmmo = 100,
         range = 50.0,
         power = 250,
         crafting = {
             {name = "wood",count = 40}
         },
         disableIteract = true
     }, 

     ["model_mg"] = {
         item = "model_mg",
         life = 30000.0,
         type = "need_stand_weapon",
         bulletInfo = `weapon_mg`, -- some weapons will not work
         bulletDamage = 50,
         bulletItem = 'mg_ammo',  -- make sure you add your ammo item image into base building html folder
         maxAmmo = 1000,
         range = 50.0,
         power = 250,
         crafting = {
             {name = "wood",count = 40}
         },
         disableIteract = true
     }, 

     ["model_spikeswall_wood"] = {
         item = "model_spikeswall_wood",
         life = 30000.0,
         type = "defence",
         subtype = "findGroud",
         noFoundationSearch = true,
         noFoundationNeed = true,
         crafting = {
             {name = "wood",count = 40}
         },
        damageOnCollision = {
             damage = 10,
             ptfx = {
                 asset = 'core',
                 name = 'bang_blood_car',
                 scale = 1.0
             }
         },
         disableIteract = true
     },

     ["model_electricfence"] = {
         item = "model_electricfence",
         life = 30000.0,
         type = "defence",
         noFoundationSearch = true,
         noFoundationNeed = true,
         power = 250,
         electricConnectionOffset = vector3(0.0,0.0,3.5),
         crafting = {
             {name = "wood",count = 40}
         },
         subtype = "findGroud",
         damageOnCollision = {
             damage = 10,
             ptfx = {
                 asset = 'core',
                 name = 'ent_dst_elec_crackle',
                 scale = 1.0
             }
         },
         disableIteract = true
     },

     ["totem_model"] = {
         item = "totem_model",
         life = 30000.0,
         type = "buildFlag",
         noFoundationSearch = true,
         noFoundationNeed = true,
         crafting = {
             {name = "wood",count = 40}
         },
         subtype = "findGroud",
         disableIteract = true
     },

}

------- ONLY IF YOU ARE NOT USING QB-CORE OR OX-INVENTORY OR IF THE PROP OR ITEM DOES NOT REALLY EXIST ---------------
Config.itemLabels = {
    
	-- WOOD BUILDING
	['model_door_wood'] = 'Wood Door', --- example 
	['model_window_wood'] = 'Wood Window', 
	['model_windowway_wood'] = 'Wood Window Frame', 
	['model_wall_wood'] = 'Wood Wall', 
	['model_doorway_wood'] = 'Wood Door Frame', 
	['model_gateway_wood'] = 'Wood Gate Frame', 
	['model_base_wood'] = 'Wood Foundation', 
	['model_ceiling_wood'] = 'Wood Ceiling', 
	['model_ceilingstairs_wood'] = 'Wood Ceiling Stairs', 	
	['model_pillar_wood'] = 'Wood Pillar', 
	['model_gate_wood'] = 'Wood Gate', 
	['model_bigwall_wood'] = 'Big Wall Wood', 
    ['model_biggateway_wood'] = 'Big Gate Frame Wood', 
    ['model_biggate_wood'] = 'Big Gate Wood', 
	['model_base_wood_triangle'] =  'Wood Triangle Foundation',
	['model_ceiling_wood_triangle'] =  'Wood Triangle Foundation',
	['model_wall_wood_roof'] =  'Wood Roof',
	['model_wall_wood_roof_triangle'] =  'Wood Triangle Roof',
	['model_wall_wood_small'] =  'Wood Small Wall',
	['model_wall_wood_triangle'] =  'Wood Triangle Wall',
	["model_ceilingladder_wood_triangle"] = "Wood Triangle Ceiling Ladder",
    ["model_stairs_wood"] 	   = "Wood stairs",
	
	-- STONE BUILDING
	["model_door_stone"] 			   = "Stone Door",
    ["model_window_stone"] 			   = "Stone Window", 
    ["model_windowway_stone"] 		   = "Stone Window Frame", 
    ["model_wall_stone"] 			   = "Stone Wall", 					
    ["model_doorway_stone"] 			   = "Stone Door Frame", 				
    ["model_gateway_stone"] 			   ="Stone Gate Frame", 				
    ["model_base_stone"] 			   = "Stone Foundation", 				
    ["model_ceiling_stone"] 			   ="Stone Ceiling", 				
    ["model_ceilingstairs_stone"] 	   = "Stone Stairs", 					
    ["model_pillar_stone"] 			   = "Stone Pillar", 					
    ["model_gate_stone"] 			   ="Stone Gate", 					
    ["model_base_stone_triangle"] 	   = "Stone Triangle Foundation",
	["model_ceiling_stone_triangle"]    = "Stone Triangle Ceiling", 					
    ["model_wall_stone_roof"] 		    = "Stone Roof", 			 		
    ["model_wall_stone_roof_triangle"]  = "Stone Triangle Roof", 						
    ["model_wall_stone_small"] 		   = "Stone Small Wall", 					
    ["model_wall_stone_triangle"] 	   = "Stone Triangle Wall", 				
    ["model_ceilingladder_stone_triangle"] 	   = "Stone Triangle Ceiling Ladder", 				
    ["model_stairs_stone"] 	   = "Stone stairs",
	
	-- METAL BUILDING
	['model_door_metal'] = 'Metal Door', 
	['model_window_metal'] = 'Metal Window', 
	['model_windowway_metal'] = 'Metal Window', 
	['model_wall_metal'] = 'Metal Wall', 
	['model_doorway_metal'] = 'Metal Door Frame', 
	['model_gateway_metal'] = 'Metal Gate Frame', 
	['model_base_metal'] = 'Metal Foundation', 
	['model_ceiling_metal'] = 'Metal Ceiling', 
	['model_ceilingstairs_metal'] = 'Metal Ceiling Stairs', 
	['model_pillar_metal'] = 'Metal Pillar', 
	['model_gate_metal'] = 'Metal Gate', 
	['model_base_metal_triangle'] =  'Metal Triangle Foundation',
	['model_ceiling_metal_triangle'] =  'Metal Triangle Ceiling',
	['model_wall_metal_roof'] =  'Metal Roof',
	['model_wall_metal_roof_triangle'] =  'Metal Triangle Roof',
	['model_wall_metal_small'] =  'Metal Small Wall',
	['model_wall_metal_triangle'] =  'Metal Triangle Wall',
	["model_ceiling_metal_triangle"]   = "Metal Triangle Ceiling", 	
	["model_ceilingladder_metal_triangle"] 	   = "Metal Triangle Ceiling Ladder", 
	["model_stairs_metal"] 	   = "Metal stairs",
		
    -- FURNITURE
	['bkr_prop_biker_campbed_01'] = 'Wood Bed', 
    ['v_tre_sofa_mess_b_s'] = 'Wood Sofa', 
	['prop_box_wood01a'] = 'Wood Storage', 
    ['gr_prop_gr_gunlocker_01a'] = 'Metal Storage', 
    ['p_v_43_safe_s'] = 'Metal Storage Lv2',  
    
	-- CRAFTING TABLES
	['prop_tool_bench02_ld'] = 'Wood Crafting Table', 
    ['bkr_prop_meth_table01a'] = 'Medical Table', 
    ['gr_prop_gr_bench_02a'] = 'Weapons Table', 
	['prop_planer_01'] = 'Recycle Machine', 
    
    -- RESOURCES
    ['wood'] = 'wood', 
    ['metalscrap'] = 'Scrap Metal', 

    -- NOT USEABLE
    ['prop_money_bag_01'] = 'Bag', 
    
    -- UKPEEP 
    ['xm3_prop_xm3_whshelf_03a'] = "Big Upkeep Box",

    -- LIGHTS 
    ['model_worklight_2'] = 'WorkLight Small',
	['model_oldlight_ext'] = 'Old Exterior Light',
	['model_worklight_1'] = 'WorkLight Big',
	['model_biglight_1'] = 'Big Light',
	['model_walllight_1'] = 'Wall Light',
	['model_ceilinglight_1'] = 'Ceiling Light',

    -- GENERATORS 
	["model_generator_small"] = "Small Generator",
	["model_generator_big"] = "Big Generator",
	["model_generator_medium"] = "Medium Size Generator",
	['prop_solarpanel_02'] = 'Big Solar Panel',
    ['prop_solarpanel_03'] = 'Solar Panel',
    ['prop_rural_windmill'] = 'Wind Turbine',
    
    -- EXTRA ENERGY PROPS
    ["model_powerdist1_wall"] = "Power Distributor",
	["model_powercomb1_wall"] = "Power Combiner",
    ["model_powerdist1_switch_wall"] = "Power Distributor [ON/OFF]",
    ["prop_telegraph_06a"] = "Power Line",

    -- BATTERIES
    ['model_battery_pack_6'] = "Battery Pack",
}




----------------------------------------- SOME CONFIG MODS [IGNORE] --------------------
function convertTextTimeToValue(text)
    local hours, minutes = text:match("(%d+):(%d+)")
    local value = tonumber(hours) * 60 + minutes
    return value
end

if Config.raidSchedule then
    for k,v in pairs(Config.raidSchedule) do
        for k2,v2 in ipairs(v) do
            Config.raidSchedule[k][k2].startTime = convertTextTimeToValue(v2.start)
            Config.raidSchedule[k][k2].finishTime = convertTextTimeToValue(v2.finish)
        end
    end
end

local backupTab = {}
for k,v in pairs(Config.Models) do
    backupTab[GetHashKey(k)] = v
    backupTab[GetHashKey(k)].modelName = k  
end

Config.Models = backupTab

Config.crewPermissionsById = {} 
for k,v in ipairs(Config.crewPermissions) do
    Config.crewPermissionsById[v.ident] = k
end
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

Config.EnableDebug = false
function debug(...)
    if not Config.EnableDebug then return end
    local printResult = "[^3DEBUG^7] "
    
    local arg = {...}

    for i=1, #arg do
        local v = arg[i]
        if type(v) == "table" then
            printResult = printResult .. tostring(json.encode(v)) .. "\t"
        else
            printResult = printResult .. tostring(v) .. "\t"
        end 
    end
    print(printResult)
end


  







