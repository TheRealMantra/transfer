Config = Config or {}

-- All item amounts are in grams & milliliters

Config.Settings = {
    debug = true,
    authorizeThreshold = 10, -- Seconds
    pickupDistance = 1.0,
    placeDistance = 1.0,
    -- With infinite items, you can create any item based on it's type
    -- This functionality is only available in modern inventories
    -- Note that managing these items outside of our resources may be challenging unless you are experienced
    -- Enabling this does not restrict the finite items from being created or used
    infiniteItems = {
        enabled = false, -- You can enable if using ox_inventory
        baseItemPrefix = "base_%s", -- %s = item type, ex. "base_drink"
        defaultImage = "https://r2.fivemanage.com/mS9apQyi6ahmBBRtVnQAv/image/question_mark.png", -- In case no image exists, default to this
    },
    keys = {
        -- Default keybinds, once loaded once on your client, you have to change it in your FiveM keybinds menu
        ["use"] = "E",
        ["unequip"] = "X",
        ["placeItem"] = "DOWN", -- Arrow down
    },
    itemTypes = {
        -- An item type decides consumption speed/multiplier/type
        -- For example, a drink shuld have different consumption speed compared to a food
        -- For example, a drink should have a different consumption style compared to a pill
        -- Each item time has it's own consumption function (DEV: SHOULD THEY? At this point they're all the same either way)
        ["drink"] = {
            label = "Drink",
            -- This multiplies how fast you consume a category
            -- The base values are rather realistic and slow, you can speed them up if you want to, this only affects how fast you consume it
            consumptionSpeed = 50.0,
        },
        ["food"] = {
            label = "Food",
            consumptionSpeed = 20.0,
        },
        ["one_hit"] = {
            -- To be renamed from pill?
            -- Pills/nicotine pocuhes/gum etc
            -- Speed is irrelivent, since it is a set amount per use, have x a mount in the total amount, and use 1.0 each time
            -- Don't insert into list, just make sure animation plays until it should use it
            label = "One Hit",
            consumptionSpeed = -1 -- -1 consumption amount means that it is just used once and will use 1.0 amount exactly, ignoring all multipliers
        },
    },
    consumptionTick = 250, -- In milliseconds, how often it processes your eating, the lower the more performance it will use, but it will display your status better, too high and it ill feel sluggish, 500-1000 recommended, doesn't affect functionality
    interactActivationButton = "LEFTALT",
    creatorMenu = {
        command = {"consum:creator", "consum:ic"},
        permissions = {
            useMenu = "command", -- Lock to staffs
            createItem = "command", -- Lock to staffs
            editItem = "command", -- Lock to trusted people
            deleteItem = "command", -- Lock to trusted people
        },
        itemsPerPage = 24, -- Probably don't touch
    },
    ingredientMenu = {
        command = {"consum:ingredient"},
        permission = {
            useMenu = "command", -- Lock to staffs
            createIngredient = "command", -- Lock to staffs
            editIngredient = "command", -- Lock to trusted people
            deleteIngredient = "command", -- Lock to trusted people
        },
        itemsPerPage = 24, -- Probably don't touch
    },
    allowedJobs = {
        -- NOT IN USE YET
        -- Jobs allowed to make usable items
        {label = "Police", name = "police", minGrade = 1},
        {label = "Ambulance", name = "ambulance", minGrade = 1},
    },
}