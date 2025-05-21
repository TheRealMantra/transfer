Config = {}

Config.UseTarget = false

Config.ImgURL = "nui://core_inventory/html/img/"  -- Imgs folder link for item images
-- Config.ImgURL = "imgs/"                         -- Or use this if you want to put item images in this script


Config.ImgFileExt = ".png"                          -- File extension of item images (.png, .jpg, ...)

Config.PriceUpdateTime = 60 -- 60 mins

Config.CheckPriceCommand = 'checkprice' 

Config.LogWebhook = 'https://discord.com/api/webhooks/'

Config.SellAllBlacklist = {
    ["phone"] = true,
    ["water"] = true,
}

Config.MoneyFormat = "$%s"

-----------------------LOCALES-----------------------
Config.ServerName = 'ServerName'
Config.OpenMenuText = 'Open menu'
Config.NotEnoughItemsNotify = 'You don\'t have enough x%s %s to sell.'
Config.DontHaveItemNotify = 'You don\'t have %s in your inventory.'
Config.PriceUpdateNotify = 'Market prices have been updated, use /checkprice to check prices.'
Config.SellNotify = 'You sold:%s and received $%s.'
Config.HaveNothing = 'You have nothing to sell'
Config.ShowHelpNotification = 'Press [E] to open menu'
-----------------------LOCALES-----------------------
Config.Category = {
 
    [2] = {
        CategoryLabel = "Loot Items",
        Blip = true,
        Ped = {
            model = 'g_m_m_chiboss_01',
            location = vector3(-214.28, -1332.73, 30.00),
            heading = 356.50,
            interactionRange = 5.0,
        },
        MoneyType = 'cash',
        Products = {
            [1] = {
                Productname = "sandwich",
                Productlabel = "Sandwich",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [2] = {
                Productname = "tosti",
                Productlabel = "Tosti",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [3] = {
                Productname = "kurkakola",
                Productlabel = "Kurkakola",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [4] = {
                Productname = "coffee",
                Productlabel = "Coffee",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [5] = {
                Productname = "water_bottle",
                Productlabel = "Water Bottle",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [6] = {
                Productname = "snikkel_candy",
                Productlabel = "Snikkel Candy",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [7] = {
                Productname = "twerks_candy",
                Productlabel = "Twerks Candy",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [8] = {
                Productname = "bandage",
                Productlabel = "Bandage",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [9] = {
                Productname = "electronickit",
                Productlabel = "Electronic Kit",
                Productminprice = "15",
                Productmaxprice = "25",
            },
            [10] = {
                Productname = "radio",
                Productlabel = "Radio",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [11] = {
                Productname = "cable",
                Productlabel = "Cable",
                Productminprice = "3",
                Productmaxprice = "7",
            },
            [12] = {
                Productname = "nail",
                Productlabel = "Nail",
                Productminprice = "1",
                Productmaxprice = "3",
            },
            [13] = {
                Productname = "cigarette_pack",
                Productlabel = "Cigarette Pack",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [14] = {
                Productname = "bong_water",
                Productlabel = "Bong Water",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [15] = {
                Productname = "weed_nugget",
                Productlabel = "Weed Nugget",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [16] = {
                Productname = "vape_flavour_capsule",
                Productlabel = "Vape Flavour Capsule",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [17] = {
                Productname = "vape_battery",
                Productlabel = "Vape Battery",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [18] = {
                Productname = "lighter",
                Productlabel = "Lighter",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [19] = {
                Productname = "cigarette",
                Productlabel = "Cigarette",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [20] = {
                Productname = "vape",
                Productlabel = "Vape",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [21] = {
                Productname = "bong",
                Productlabel = "Bong",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [22] = {
                Productname = "cigar",
                Productlabel = "Cigar",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [23] = {
                Productname = "joint",
                Productlabel = "Joint",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [24] = {
                Productname = "at_suppressor",
                Productlabel = "AT Suppressor",
                Productminprice = "25",
                Productmaxprice = "35",
            },
            [25] = {
                Productname = "medium_backpack",
                Productlabel = "Medium Backpack",
                Productminprice = "15",
                Productmaxprice = "25",
            },
            [26] = {
                Productname = "small_backpack",
                Productlabel = "Small Backpack",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [27] = {
                Productname = "pistol_ammo",
                Productlabel = "Pistol Ammo",
                Productminprice = "3",
                Productmaxprice = "7",
            },
            [28] = {
                Productname = "weapon_grenade",
                Productlabel = "Grenade",
                Productminprice = "25",
                Productmaxprice = "35",
            },
            [29] = {
                Productname = "weapon_pipebomb",
                Productlabel = "Pipe Bomb",
                Productminprice = "25",
                Productmaxprice = "35",
            },
            [30] = {
                Productname = "weapon_bzgas",
                Productlabel = "BZ Gas",
                Productminprice = "15",
                Productmaxprice = "25",
            },
            [31] = {
                Productname = "weapon_molotov",
                Productlabel = "Molotov",
                Productminprice = "20",
                Productmaxprice = "30",
            },
            [32] = {
                Productname = "weapon_stickybomb",
                Productlabel = "Sticky Bomb",
                Productminprice = "30",
                Productmaxprice = "40",
            },
            [33] = {
                Productname = "weapon_smokegrenade",
                Productlabel = "Smoke Grenade",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [34] = {
                Productname = "quad_tire",
                Productlabel = "Quad Tire",
                Productminprice = "15",
                Productmaxprice = "25",
            },
            [35] = {
                Productname = "car_tire",
                Productlabel = "Car Tire",
                Productminprice = "20",
                Productmaxprice = "30",
            },
            [36] = {
                Productname = "repairkit",
                Productlabel = "Repair Kit",
                Productminprice = "25",
                Productmaxprice = "35",
            },
            [37] = {
                Productname = "toolbox",
                Productlabel = "Toolbox",
                Productminprice = "20",
                Productmaxprice = "30",
            },
            [38] = {
                Productname = "wood",
                Productlabel = "Wood",
                Productminprice = "3",
                Productmaxprice = "7",
            },
            [39] = {
                Productname = "chain",
                Productlabel = "Chain",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [40] = {
                Productname = "vehicle_parts",
                Productlabel = "Vehicle Parts",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [41] = {
                Productname = "bicycle_tire",
                Productlabel = "Bicycle Tire",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [42] = {
                Productname = "metalscrap",
                Productlabel = "Metal Scrap",
                Productminprice = "3",
                Productmaxprice = "7",
            },
            [43] = {
                Productname = "weapon_garbagebag",
                Productlabel = "Garbage Bag",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [44] = {
                Productname = "iron",
                Productlabel = "Iron",
                Productminprice = "3",
                Productmaxprice = "7",
            },
            [45] = {
                Productname = "weapon_parts",
                Productlabel = "Weapon Parts",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [46] = {
                Productname = "bolt",
                Productlabel = "Bolt",
                Productminprice = "1",
                Productmaxprice = "3",
            },
            [47] = {
                Productname = "engine_oil",
                Productlabel = "Engine Oil",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [48] = {
                Productname = "bike_tire",
                Productlabel = "Bike Tire",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [49] = {
                Productname = "24v_battery",
                Productlabel = "24V Battery",
                Productminprice = "20",
                Productmaxprice = "30",
            },
            [50] = {
                Productname = "12v_battery",
                Productlabel = "12V Battery",
                Productminprice = "15",
                Productmaxprice = "25",
            },
            [51] = {
                Productname = "6v_battery",
                Productlabel = "6V Battery",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [52] = {
                Productname = "weapon_poolcue",
                Productlabel = "Pool Cue",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [53] = {
                Productname = "weapon_bat",
                Productlabel = "Baseball Bat",
                Productminprice = "15",
                Productmaxprice = "25",
            },
            [54] = {
                Productname = "weapon_crowbar",
                Productlabel = "Crowbar",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [55] = {
                Productname = "weapon_hatchet",
                Productlabel = "Hatchet",
                Productminprice = "15",
                Productmaxprice = "25",
            },
            [56] = {
                Productname = "weapon_flashlight",
                Productlabel = "Flashlight",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [57] = {
                Productname = "weapon_bottle",
                Productlabel = "Broken Bottle",
                Productminprice = "2",
                Productmaxprice = "5",
            },
            [58] = {
                Productname = "large_backpack",
                Productlabel = "Large Backpack",
                Productminprice = "20",
                Productmaxprice = "30",
            },
            [59] = {
                Productname = "steel",
                Productlabel = "Steel",
                Productminprice = "5",
                Productmaxprice = "10",
            },
            [60] = {
                Productname = "aluminum",
                Productlabel = "Aluminum",
                Productminprice = "3",
                Productmaxprice = "7",
            },
            [61] = {
                Productname = "rubber",
                Productlabel = "Rubber",
                Productminprice = "3",
                Productmaxprice = "7",
            },
            [62] = {
                Productname = "obsidian",
                Productlabel = "Obsidian",
                Productminprice = "10",
                Productmaxprice = "15",
            },
            [63] = {
                Productname = "weapon_petrolcan",
                Productlabel = "Petrol Can",
                Productminprice = "10",
                Productmaxprice = "15",
            }
        }
    }
}
