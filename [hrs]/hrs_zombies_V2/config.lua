Config = {}

Config.showNoiseWave = true ---- show minimap noise
Config.showNoiseWaveInfo = {color = 1,alpha = 80}

Config.zombiesAudioMemory = 600 -- 60 seconds (the time the zombies will follow you after they fisrt heared you)

Config.poolLimit = 60 --- recommend not changing this

Config.betterHitBox = true --------- makes the zombie attack harder to dodge 

Config.zombieVehicleExternalDamage = true ------------ if the zombie can do exterior damage to the vehicle

Config.ragdollOnZombieAttackProbability = 0 -------- 1% probability of ragdoll when zombie attack you

Config.debug = false -- check location, zombie numbers , pool size

Config.useEntityLockdown = false --- this prevents any kind of client side spawn on your server

Config.zombieApproach = false --- if true zombies will get closer to you with time 

Config.zombieIgnoreFire = true --- zombie will ignore beeing on fire

Config.RedZoneBlips = {
    label = "Red Zone",
    color = 1,
    alpha = 128,
    scale = 1.0,
    sprite = 630,
    shortRange = true      
} ----------- false if you dont want them

Config.nightMult = 25.0 ---- ped spawn mult at night
Config.dayMult = 15.6 ---- ped spawn mult at day

Config.nightMultAnimals = 0.5 ---- animal spawn mult at night 
Config.dayMultAnimals = 1.0 ---- animal spawn mult at day

Config.nightHealthMult = 1.5 ---- health mult at night
Config.nightDamageMult = 1.5 ---- damage mult at night 

Config.redZoneHealthMult = 1.8 ---- health mult at redzone
Config.redZoneDamageMult = 2.8 ---- damage mult at redzone 

Config.canRemoveFromVehicle = false ------ zombies can remove you from the car

Config.maxBossesAroundYou = 50 -- max number of bosses around you

Config.poisonGasRadious = 5.0

Config.eletricRadious = 5.0

Config.fireRadious = 5.0

Config.eletricChargeMissProbability = 65 --- 50% chance of the eletric zombie to miss his attack

Config.fireChargeMissProbability = 65 --- 50% chance of the fire zombie to miss his attack

Config.maxOwnedDeadPeds = 25

Config.deadDeleteTime = 180 --- seconds

Config.deleteZombieOnSafe = true

Config.zombiesUseLadders = false

Config.overwriteNoises = {
    stealth = 0.5,
    walk = 2.5,
    run = 15.0,
    sprint = 30.0
} -- if you don't want this make it Config.overwriteNoises = false, this will overwrite the native GTA V noise, will only overwrite if the values here are bigger than GTA V default noise values, so you can only make the player make more noise not less

Config.visionDistance = 20.0 -- (how distant the zombies can see you) this can be very bad performance wise if you make this value to high

Config.specialZombiesProb = {
    {models = {'s_m_y_fireman_01','u_f_y_corpse_01','u_m_y_corpse_01','mp_f_deadhooker','u_m_y_zombie_01'},probability = 5,probabilityRedzone = 0},
    {models = {"u_f_y_corpse_01","u_m_y_corpse_01"},probability = 0,probabilityRedzone = 2},
--    {models = {"u_m_y_zombie_01"},probability = 0,probabilityRedzone = 2},
--    {models = {'mp_f_deadhooker'},probability = 1,probabilityRedzone = 4},
} ---- this zombies will replace population zombies with this models based on the percentage you choose

Config.zombiesLeaveYouOnceDead = true

Config.specialZombiesSpecs = {
    ['s_m_y_blackops_01'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@',
        isNPC = true,
        weapon = `WEAPON_CARBINERIFLE`,
        ammo = 10000,
        accuracy = 25,
    --    fire = true,
    --    fireDamage = 5
    },
    ['s_m_y_marine_02'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@',
        isNPC = true,
        weapon = `WEAPON_CARBINERIFLE`,
        ammo = 10000,
        accuracy = 25,
    --    fire = true,
    --    fireDamage = 5
    },
    ['s_m_y_marine_03'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@',
        isNPC = true,
        weapon = `WEAPON_CARBINERIFLE`,
        ammo = 10000,
        accuracy = 25,
    --    fire = true,
    --    fireDamage = 5
    },
    ['s_m_y_blackops_02'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@',
        isNPC = true,
        weapon = `WEAPON_CARBINERIFLE`,
        ammo = 10000,
        accuracy = 25,
    --    fire = true,
    --    fireDamage = 5
    },
    ['s_m_y_blackops_03'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@',
        isNPC = true,
        weapon = `WEAPON_CARBINERIFLE`,
        ammo = 10000,
        accuracy = 25,
       -- fire = true,
        --fireDamage = 5
    },
    ['s_m_y_marine_01'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@',
        isNPC = true,
        weapon = `WEAPON_CARBINERIFLE`,
        ammo = 10000,
        accuracy = 25,
        --fire = true,
        --fireDamage = 
    },
    ['u_m_y_zombie_01'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        poisonGas = true,
        poisonGasDamage = 1,
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@',
        attackAnimSet = {
            animDict = 'melee@unarmed@streamed_core_fps', 
            animName = 'ground_attack_0_psycho'
        }
    }, 
    ['s_m_y_fireman_01'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@',
        fire = true,
        fireDamage = 5
    },
    ['u_m_y_juggernaut_01'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@',
        eletric = true,
        eletricDamage = 5
    },
    ['u_f_y_corpse_01'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        poisonGas = true,
        poisonGasDamage = 1,
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@'
    },
    ['u_m_y_corpse_01'] = {
        life = 300,
        headShotResistent = false,
        disableRagdoll = true,
        setProofs = {false,true,false,false,true,false,false,false},
        pedDamage = 14,
        carDamage = 0,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        poisonGas = true,
        poisonGasDamage = 1,
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@'
    },
    ['a_m_y_juggalo_01'] = {
        life = 200,
        blip = false,
        isNPC = true,
        weapon = `WEAPON_CARBINERIFLE`,
        ammo = 10000,
        accuracy = 50
    },
    ['mp_f_deadhooker'] = {
        life = 200,
        blip = {
            label = "Special Zombie",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 303,
            shortRange = true
        },
        pedDamage = 14,
        carDamage = 0,
        scream = true,
        screamRadius = 100.0,
        screamTimeBetweenScreams = 14000,
        walkingAnimSet = 'move_m@drunk@verydrunk',
        walkingAnimSetNight = 'move_characters@orleans@core@'
    }
} --- change some zombies features

Config.defaultZombies = {
    life = 125,
    headShotResistent = false,
    disableRagdoll = false,
    setProofs = nil,
    pedDamage = 3,
    carDamage = 0,
    blip = false,
    isBlind = false,
    attackAnimSet = {
        {animDict = 'melee@unarmed@streamed_core_fps', animName = 'ground_attack_0_psycho'}
    },
    walkingAnimSet = 'move_m@drunk@verydrunk',
    walkingAnimSetNight = 'move_m@drunk@verydrunk',

    -- scream = true,
    -- screamRadius = 100.0,
    -- screamTimeBetweenScreams = 14000, --ms 
    -- maxSpeed = 2.0,
    maxSpeedNight = 2.0,
    -- isNPC = true,
    -- weapon = `WEAPON_CARBINERIFLE`,
    -- ammo = 10000,
    -- accuracy = 50,
    -- poisonGas = true,
    -- poisonGasDamage = 1,
    -- eletric = true,
    -- eletricDamage = 5,
    -- fire = true,
    -- fireDamage = 5
}

Config.disableDaySpawnModels = {
    ['mp_f_deadhooker'] = false,
    ['a_m_y_juggalo_01'] = false
} -- models in this list will not spawn during the day

Config.redZones = {
    {
        coords = vector3(1073.67, -3109.77, 5.90),
        radious = 350.0,
        label = "Hardcore Zone 1",
        bosses = {
            {models = {"s_m_y_fireman_01"},probability = 15},
            {models = {'u_f_y_corpse_01','u_m_y_corpse_01'},probability = 1},
            {models = {'u_m_y_zombie_01'},probability = 1}
        }
    },

    {
        coords = vector3(500.22, -3164.21, 10.45),
        radious = 150.0,
        label = "Military Zone",
        bosses = {
            {models = {'s_m_y_blackops_01','s_m_y_marine_02','s_m_y_marine_03'},probability = 50},
            {models = {'s_m_y_blackops_02','s_m_y_blackops_03','s_m_y_marine_01'},probability = 50}
        }
    },

    {
        coords = vector3(-2199.55, 3123.57, 32.81),
        radious = 600.0,
        label = "Military Zone 2",
        bosses = {
            {models = {'s_m_y_blackops_01','s_m_y_marine_02','s_m_y_marine_03'},probability = 50},
            {models = {'s_m_y_blackops_02','s_m_y_blackops_03','s_m_y_marine_01'},probability = 50}
        }
    }
}

Config.pedLists = {
    ['test'] = {
        's_m_y_fireman_01'
    },
    ['jail'] = {
        'csb_rashcosvki',
        's_m_y_prismuscl_01',
        's_m_y_prisoner_01',
        'csb_prolsec',
        'ig_rashcosvki',
        's_m_m_prisguard_01',
        's_m_m_security_01'
    },
    ['airp'] = {
        'csb_trafficwarden',
        's_m_m_gardener_01',
        's_m_m_ups_01',
        's_m_y_airworker',
        's_m_m_strpreach_01',
        's_m_m_highsec_01',
        's_m_m_highsec_02'
    },
    ['farm'] = {
        'cs_hunter',
        'cs_josef',
        'cs_old_man1a',
        'cs_old_man2',
        'cs_nervousron',
        'cs_russiandrunk',
        'csb_cletus',
        'csb_maude',
        'g_f_importexport_01',
        'u_m_y_proldriver_01'
    },
    ['city'] = {
        'a_f_m_bevhills_01',
        'a_f_y_bevhills_01',
        'a_f_y_bevhills_03',
        'a_f_y_clubcust_01',
        'a_f_y_genhot_01',
        'a_m_m_soucent_02',
        'a_m_m_stlat_02',
        'a_m_y_business_02',
        'a_m_y_business_03',
        'a_m_y_genstreet_01',
        'cs_joeminuteman',
        'g_m_y_famdnf_01',
        'g_m_y_famca_01'
    },
    ['military'] = {
        'csb_ramp_marine',
        's_m_m_marine_01',
        's_m_y_blackops_01',
        's_m_y_blackops_02',
        's_m_y_blackops_03',
        's_m_y_marine_01',
        's_m_y_marine_02',
        's_m_y_marine_03',
        's_m_y_swat_01',
        's_m_m_marine_02',
        'u_m_o_filmnoir'
    },
    ['workers'] = {
        's_m_m_dockwork_01',
        's_m_m_gaffer_01',
        's_m_m_gardener_01',
        's_m_m_lathandy_01',
        's_m_y_airworker',
        's_m_y_construct_01',
        's_m_y_construct_02',
        's_m_y_dockwork_01',
        's_m_y_garbage'
    },
    ['beach'] = {
        'a_f_m_beach_01',
        'a_f_m_bodybuild_01',
        'a_f_m_fatcult_01',
        'a_f_y_beach_01',
        'a_f_y_juggalo_01',
        'a_f_y_topless_01',
        'a_m_m_beach_02',
        'a_m_m_tranvest_01',
        'a_m_y_jetski_01',
        'a_m_y_musclbeac_01',
        'a_m_y_surfer_01',
        's_f_y_baywatch_01',
        's_m_y_baywatch_01',
        'ig_tylerdix'
    },
    ['animals'] = {
        'a_c_boar',
        'a_c_coyote',
        'a_c_deer',
        'a_c_mtlion',
        'a_c_rabbit_01'
    }, --- animals that will spawn in dirt and grass locations
    ['hospital'] = {
        's_f_y_scrubs_01',
        's_m_m_doctor_01',
        's_m_y_autopsy_01',
        'u_f_y_corpse_02' 
    },
    ['walk'] = {
        'a_f_y_fitness_01',
        'a_f_y_fitness_02',
        'a_f_y_runner_01',
        'a_f_y_tourist_01',
        'a_m_y_breakdance_01',
        'a_m_y_runner_01',
        'a_m_y_runner_02',
        'cs_maryann'
    },
    ['motard'] = {
        'cs_clay',
        'csb_jackhowitzer',
        'g_m_y_lost_01',
        'g_m_y_lost_02',
        'g_m_y_lost_03',
        'g_m_y_mexgang_01'
    },
    ['police'] = {
        'cs_casey',
        'cs_michelle',
        'csb_ramp_marine',
        'mp_m_fibsec_01',
        'mp_s_m_armoured_01',
        's_f_y_cop_01',
        's_m_m_armoured_01',
        's_m_m_armoured_02',
        's_m_m_fibsec_01',
        's_m_y_cop_01',
        'ig_casey'
    },
    ['npc'] = {
        'a_m_y_juggalo_01'
    }
}

Config.AnimalModels = {
    ['a_c_boar'] = `WILD_ANIMAL`,
    ['a_c_cat_01'] = `WILD_ANIMAL`,
    ['a_c_chickenhawk'] = `WILD_ANIMAL`,
    ['a_c_chimp'] = `WILD_ANIMAL`,
    ['a_c_chop'] = `GUARD_DOG`,
    ['a_c_cormorant'] = `WILD_ANIMAL`,
    ['a_c_cow'] = `DOMESTIC_ANIMAL`,
    ['a_c_coyote'] = `WILD_ANIMAL`,
    ['a_c_crow'] = `WILD_ANIMAL`,
    ['a_c_deer'] = `DEER`,
    ['a_c_dolphin'] = `WILD_ANIMAL`,
    ['a_c_fish'] = `WILD_ANIMAL`,
    ['a_c_hen'] = `HEN`,
    ['a_c_humpback'] = `WILD_ANIMAL`,
    ['a_c_husky'] = `GUARD_DOG`,
    ['a_c_killerwhale'] = `WILD_ANIMAL`,
    ['a_c_mtlion'] = `COUGAR`,
    ['a_c_pig'] = `DOMESTIC_ANIMAL`,
    ['a_c_pigeon'] = `WILD_ANIMAL`,
    ['a_c_poodle'] = `GUARD_DOG`,
    ['a_c_pug'] = `GUARD_DOG`,
    ['a_c_rabbit_01'] = `WILD_ANIMAL`,
    ['a_c_rat'] = `WILD_ANIMAL`,
    ['a_c_retriever'] = `GUARD_DOG`,
    ['a_c_rhesus'] = `WILD_ANIMAL`,
    ['a_c_rottweiler'] = `GUARD_DOG`,
    ['a_c_seagull'] = `WILD_ANIMAL`,
    ['a_c_sharkhammer'] = `SHARK`,
    ['a_c_sharktiger'] = `SHARK`,
    ['a_c_shepherd'] = `GUARD_DOG`,
    ['a_c_stingray'] = `WILD_ANIMAL`,
    ['a_c_westy'] = `GUARD_DOG`,
    ['a_c_panther'] = `WILD_ANIMAL`
} --- this models will have animal behaviour , in the right you have their relationship group

for k,v in pairs(Config.AnimalModels) do
    Config.AnimalModels[GetHashKey(k)] = v
end

Config.mapLocations = {
    ['AIRP'] = {
        humansList = 'airp',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10,
    },
    ['ALAMO'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15,
    },
    ['ALTA'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10,
    },
    ['ARMYB'] = {
        humansList = 'military',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['BHAMCA'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['BANNING'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['BEACH'] = {
        humansList = 'beach',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['BHAMCA'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['BRADT'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['BURTON'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['CANNY'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['CCREAK'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['CHAMH'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['CHIL'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['CHU'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['CMSW'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['CYPRE'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['DAVIS'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['DELBE'] = {
        humansList = 'beach',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['DELPE'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['DELSOL'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['DTVINE'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['DESRT'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['EAST_V'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['EBURO'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['ELGORL'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },

    ['ELYSIAN'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['GALFISH'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['GOLF'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['GRAPES'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['GREATC'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['HARMO'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['HAWICK'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['HORS'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['HUMLAB'] = {
        humansList = 'hospital',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['JAIL'] = {
        humansList = 'jail',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['KOREAT'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['LACT'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['LAGO'] = {
        humansList = 'military',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['LDAM'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['LEGSQU'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['LMESA'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['LOSPUER'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['MIRR'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['MORN'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['MOVIE'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['MTCHIL'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['MTGORDO'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['MTJOSE'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['MURRI'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['NCHU'] = {
        humansList = 'motard',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['NOOSE'] = {
        humansList = 'military',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['OCEANA'] = {
        humansList = 'beach',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['PALCOV'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['PALETO'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['PALFOR'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['PALHIGH'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['PALMPOW'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['PBLUFF'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['PBOX'] = {
        humansList = 'hospital',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['PROCOB'] = {
        humansList = 'beach',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['RANCHO'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['RGLEN'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['RICHM'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['ROCKF'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['RTRAK'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['SANAND'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['SANCHIA'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['SANDY'] = {
        humansList = 'farm',
        animalsList = 'animals',
        maxHumans = 15,
        maxAnimals = 15
    },
    ['SKID'] = {
        humansList = 'police',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['SLAB'] = {
        humansList = 'motard',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['STAD'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['STRAW'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['TATAMO'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['TERMINA'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['TEXTI'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['TONGVAH'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['TONGVAV'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['VCANA'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['VESP'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['VINE'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['WINDF'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['WVINE'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['ZANCUDO'] = {
        humansList = 'walk',
        animalsList = 'animals',
        maxHumans = 5,
        maxAnimals = 20
    },
    ['ZP_ORT'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['ZQ_UAR'] = {
        humansList = 'workers',
        animalsList = 'animals',
        maxHumans = 25,
        maxAnimals = 5
    },
    ['PROL'] = {
        humansList = 'city',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
    ['ISHEIST'] = {
        humansList = 'military',
        animalsList = 'animals',
        maxHumans = 35,
        maxAnimals = 10
    },
}



-----------------------------------------------------
------------------ NESTS ----------------------------
-----------------------------------------------------
Config.NestWeaponDamages = {
    [`weapon_molotov`] = 5.0,
   -- [-544306709] = 0.5, ---- GAME FIRE
}

Config.NestTypes = {
    ['npc_nest'] = {
        propModel = `prop_bush_lrg_01c_cr`,
        pedsType = 'npc',
        zChange = 0.0,
        damageRadius = 5.0,
        damagePed = 0,
        drawDistance = 120.0, ---- recommended value
        blip = {
            label = "Enemy Nest",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 378,
            shortRange = true  
        }, -- false will disable it
        maxHealth = 10.00,
        regenTime = 120, --- seconds, if nil the nest will not respawn
        maxZombies = 40,
        ptfx = false,
    },
    ['military_nest'] = {
        propModel = `prop_bush_lrg_01c_cr`,
        pedsType = 'military',
        zChange = -1.0,
        damageRadius = 5.0,
        damagePed = 15,
        drawDistance = 120.0, ---- recommended value
        blip = {
            label = "Zombie Nest",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 378,
            shortRange = true  
        }, -- false will disable it
        maxHealth = 10.00,
        regenTime = 120, --- seconds
        maxZombies = 40,
        ptfx = true
    },
    ['gen_nest'] = {
        propModel = `prop_bush_lrg_01c_cr`,
        --pedsType = 'military',
        zChange = -1.0,
        damageRadius = 5.0,
        damagePed = 15,
        drawDistance = 120.0, ---- recommended value
        blip = {
            label = "Zombie Nest",
            color = 1,
            alpha = 128,
            scale = 1.0,
            sprite = 378,
            shortRange = true  
        }, -- false will disable it
        maxHealth = 10.00,
        regenTime = 120, --- seconds
        maxZombies = 40,
        ptfx = true
    },
}

Config.NestGenerationByZone = {
    {
        coords = vector3(1072.74, -3107.32, 5.90),
        radious = 150.0,
        nestType = 'gen_nest',
        minDistanceBetweenNests = 100.0
    },
    -- {
    --     coords = vector3(0.0, 0.0, 0.0),
    --     radious = 5000.0,
    --     nestType = 'gen_nest',
    --     minDistanceBetweenNests = 500.0
    -- },
}

Config.NestGenerationByLocation = {
    ['ARMYB'] = {
        nestType = 'npc_nest',
        minDistanceBetweenNests = 100.0
    },
    ['ISHEIST'] = {
        nestType = 'military_nest',
        minDistanceBetweenNests = 100.0
    }
}

Config.Nests = {
    --['Boat_Nest_1'] = {
    --    coords = vector3(3061.5498, -4683.6440, 15.2623),
    --    nestType = 'military_nest'
    --},

   -- ['Boat_Nest_2'] = {
    --    coords = vector3(3080.6509, -4760.6401, 6.0772),
    --    nestType = 'military_nest'
    --},

   -- ['Cayo_1'] = {
    --    coords = vector3(5007.4717, -5195.1128, 2.5163),
   --     nestType = 'military_nest'
   -- },

    --['Cayo_2'] = {
    --    coords = vector3(5120.4375, -5145.7007, 2.2519),
    --    nestType = 'military_nest'
    --},

    --['Cayo_3'] = {
    --    coords = vector3(5018.2305, -5092.8184, 6.1626),
    --    nestType = 'military_nest'
    --},

    --['Cayo_4'] = {
    --    coords = vector3(5021.1152, -5231.5542, 9.6508),
    --    nestType = 'military_nest'
    --},

   -- ['extra_1'] = {
    --    coords = vector3(-1038.12,-3216.35,13.944),
   --     nestType = 'military_nest'
    --    -1039.21, -3215.89, 15.20
   -- },

   -- ['extra_16'] = {
   --     coords = vector3(-114.32, -1742.01, 30.3),
   --     nestType = 'military_nest'
   -- },

   -- ['extra_666'] = {
    --    coords = vector3(-115.148, -1736.9, 30.3),
    --    nestType = 'military_nest'
   -- },
}

-------------------------------------------------------------
---------------------------- SAFEZONE RELATED ---------------
-------------------------------------------------------------

Config.safeZoneBlips = {
    label = "Safe Zone",
    color = 2,
    alpha = 128,
    scale = 0.5,
    sprite = 176,
    shortRange = true      
} ----------- false if you dont want them

Config.noSpawnZones = {
    {coords = vector3(697.28, 129.55, 80.96),radious = 100.0,label = "Survivor Zone",hiden = false}
    --{coords = vector3(215.578, -1135.859, 29.29675),radious = 400.0,label = "Safe Zone 1",hiden = true}
} ---- SAFEZONES
 
Config.safeZoneGoThrougthPlayers = false ---- players go throught each other in safe zone (resource expensive)
Config.safeZoneInvincible = true --- You are in GodMode in the SafeZone
Config.safeZonePvE = true --- You can't shoot other players in SafeZone
Config.safeZoneDisableShootOrAttack = true --- You can't shoot in SafeZone at all
Config.safeZoneGhost = false --- Player will be a ghost

Config.safeLeaveSafeZoneTimer = 20 --- Seconds player will keep invincible after leaving safezone

Config.locales = {
    ['in_safe'] = "~g~You Are in SafeZone Now",
    ['leave_safe'] = "~r~You Left the SafeZone",
    ['end_invincible'] = "~r~Your invincible time is over"
}

----- THIS ARE ALL EXAMPLES THEY WILL NOT WORK IF YOU DON'T CONFIG THEM
Config.safezonePedsAndProps = {
    -- ['shop_ped'] = {
    --     type = 'ped',
    --     model = `csb_ramp_marine`,
    --     coords = vector3(-2277.5537, 387.5620, 174.6018),
    --     heading = 90.0,
    --     drawDistance = 160.0,
    --     anim = {
    --         animDict = "amb@world_human_aa_smoke@male@idle_a", 
	-- 	    animName = "idle_a"
    --         --scenario = 
    --     },
    --     targetInfo = { 
    --         options = { 
    --             { 
    --                 num = 1, 
    --                 --type = "client", 
    --                 --event = "Test:Event", 
    --                 icon = 'fa-solid fa-basket-shopping', 
    --                 label = 'Open Shop', 
    --                 action = function(entity) 

    --                     --TriggerEvent('ox_inventory:shopEvent',"Liquor")

    --                     --exports.ox_inventory:openInventory('shop', { type = "GunShop", id = 1})
    --                     --print(entity)
    --                 end,
    --                 canInteract = function(entity, distance, data) 
    --                     return true
    --                 end,
    --             }
    --         },
    --         distance = 2.5,
    --     },
    --     blip = {
    --         label = "Gun Shop",
    --         color = 2,
    --         alpha = 128,
    --         scale = 1.0,
    --         sprite = 150,
    --         shortRange = true 
    --     }
    -- },
    -- ['medic_ped'] = {
    --     type = 'ped',
    --     model = `s_m_m_doctor_01`,
    --     coords = vector3(-2300.4570, 365.6919, 174.6016),
    --     heading = 45.0,
    --     drawDistance = 160.0,
    --     anim = {
    --         animDict = "amb@world_human_aa_smoke@male@idle_a", 
	-- 	    animName = "idle_a"
    --         --scenario = 
    --     },
    --     targetInfo = { 
    --         options = { 
    --             { 
    --                 num = 1, 
    --                 --type = "client", 
    --                 --event = "Test:Event", 
    --                 icon = 'fa-solid fa-basket-shopping', 
    --                 label = 'Open Shop', 
    --                 action = function(entity) 
    --                     --TriggerEvent('ox_inventory:shopEvent',"General")

    --                     exports.ox_inventory:openInventory('shop', {type = "General", id = 1})
    --                     --print(entity)
    --                 end,
    --                 canInteract = function(entity, distance, data) 
    --                     return true
    --                 end,
    --             }
    --         },
    --         distance = 2.5,
    --     },
    --     blip = {
    --         label = "Medic Shop",
    --         color = 2,
    --         alpha = 128,
    --         scale = 1.0,
    --         sprite = 51,
    --         shortRange = true 
    --     }
    -- },
    -- ['veh_shop'] = {
    --     type = 'ped',
    --     model = `csb_reporter`,
    --     coords = vector3(-2323.7,296.47,169.47),
    --     heading = 45.0,
    --     drawDistance = 160.0,
    --     anim = {
    --         animDict = "amb@world_human_aa_smoke@male@idle_a", 
	-- 	    animName = "idle_a"
    --         --scenario = 
    --     },
    --     noTargetInfo = {
    --         label = 'Press ~INPUT_CONTEXT~ to open Vehicle Shop',
    --         distance = 20.0,
    --         TriggerEvent = { 
    --             type = "client",
    --             event = "hrs_vehicles:openShop",
    --             args = {},
    --             entityAsArg = "thisEnt" --- in the arguments, this word will be replaced by the Entity
    --         },
    --     },
    --     blip = {
    --         label = "Vehicle Shop",
    --         color = 2,
    --         alpha = 128,
    --         scale = 1.0,
    --         sprite = 227,
    --         shortRange = true 
    --     }
    -- },
    -- ['storage_1'] = {
    --     type = 'prop',
    --     model = `prop_container_05mb`,
    --     coords = vector3(-2325.03,383.09,174.5),
    --     heading = 90.0,
    --     drawDistance = 160.0,
    --     noTargetInfo = {
    --         label = 'Press ~INPUT_CONTEXT~ to interact',
    --         distance = 5.0,
    --         TriggerEvent = { 
    --             type = "client",
    --             event = "hrs_zombies:exampleEvent",
    --             args = {"thisEnt",10},
    --             entityAsArg = "thisEnt" --- in the arguments, this word will be replaced by the Entity
    --         },
    --     },
    --     blip = {
    --         label = "Safe Storage",
    --         color = 2,
    --         alpha = 128,
    --         scale = 1.0,
    --         sprite = 150,
    --         shortRange = true 
    --     }
    -- }
}







---------------------------- some checks --------------------







Config.UseTargetExport = nil
--------------------------------------
if GetResourceState('ox_target') ~= 'missing' or GetResourceState('qtarget') ~= 'missing' then 
    Config.UseTargetExport = 'qtarget'
elseif GetResourceState('qb-target') ~= 'missing' then 
    Config.UseTargetExport = "qb-target"
else
    --print("[^3WARNING^7] NO TARGET SCRIPT FOUND")
end

Config.Framework = nil

if GetResourceState('es_extended') ~= 'missing' then
    Config.Framework = 'ESX'
elseif GetResourceState('qb-core') ~= 'missing' then
    Config.Framework = 'QB'
end


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



-------------------------------- RELEVANT EXPORTS

-- exports.hrs_zombies_V2:setExtraSmellTime(time,radius) -- your player will have an extra smell that will atract zombies in the defined radius for a defined time (seconds)
-- exports.hrs_zombies_V2:addExtraSmellTime(time)
-- exports.hrs_zombies_V2:getExtraSmellTime()

-- exports.hrs_zombies_V2:setProtectionTime(time) -- zombies will ignore you for a specfic time (seconds)
-- exports.hrs_zombies_V2:addProtectionTime(time)
-- exports.hrs_zombies_V2:getProtectionTime()

-- exports.hrs_zombies_V2:setGasProtectionTime(time) -- you will be protected from poison zombies for a defined time (seconds)
-- exports.hrs_zombies_V2:addGasProtectionTime(time)
-- exports.hrs_zombies_V2:getGasProtectionTime()

-- exports.hrs_zombies_V2:SpawnPed(model,coords,cb) -- client side
-- exports.hrs_zombies_V2:SpawnPed(model,coords,bucket,cb) -- server side

-- exports.hrs_zombies_V2:SpawnPersistentPed(model,coords,cb) -- client side (this ped will not be cleaned up by the security system) [be carefull with this]
-- exports.hrs_zombies_V2:SpawnPersistentPed(model,coords,bucket,cb) -- server side (this ped will not be cleaned up by the security system) [be carefull with this]

-- exports.hrs_zombies_V2:SpawnNest(index,nestType,coords) -- client/server side
-- exports.hrs_zombies_V2:DeleteNest(index) -- client/server side

-- exports.hrs_zombies_V2:startNoiseEvent(index,coords,radius,time) -- client/server side, index (can be nil), time in seconds
-- exports.hrs_zombies_V2:stopNoiseEvent(index) -- client/server side, index (if you gave an index to the noise event you can stop it with this)

-- exports.hrs_zombies_V2:wasPedCreatedByZombiesScript(entity) -- client/server


