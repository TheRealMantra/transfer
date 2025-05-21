Config = {}

Config.RentalLocations = {
    {
        coords = vector4(740.87, 139.88, 79.76, 229.73), -- Legion Square
        ped = {
            model = "a_m_y_business_03",
            heading = 229.73,
            scenario = "WORLD_HUMAN_CLIPBOARD"
        },
        blip = {
            sprite = 226,
            color = 2,
            scale = 0.7,
            label = "Bike Rental"
        },
        vehicles = {
            {
                model = "cruiser",
                label = "Cruiser Bike",
                price = 50,
                time = 180 -- 3 hours
            },
            {
                model = "bmx",
                label = "BMX",
                price = 75,
                time = 180
            },
            {
                model = "faggio",
                label = "Faggio Moped",
                price = 100,
                time = 180
            },
            {
                model = "faggio2",
                label = "Faggio Sport",
                price = 125,
                time = 180
            },
            {
                model = "sanchez",
                label = "Dirt Bike",
                price = 150,
                time = 180
            }
        }
    },
    {
        coords = vector4(-1033.44, -2732.79, 19.17,324.32), -- Airport
        ped = {
            model = "a_m_y_business_03",
            heading =  324.32,
            scenario = "WORLD_HUMAN_CLIPBOARD"
        },
        blip = {
            sprite = 226,
            color = 2,
            scale = 0.7,
            label = "Bike Rental"
        },
        vehicles = {
            {
                model = "cruiser",
                label = "Cruiser Bike",
                price = 50,
                time = 180
            },
            {
                model = "bmx",
                label = "BMX",
                price = 75,
                time = 180
            },
            {
                model = "faggio",
                label = "Faggio Moped",
                price = 100,
                time = 180
            },
            {
                model = "faggio2",
                label = "Faggio Sport",
                price = 125,
                time = 180
            },
            {
                model = "sanchez",
                label = "Dirt Bike",
                price = 150,
                time = 180
            }
        }
    }
}

Config.Messages = {
    error = {
        already_rented = "You already have a rental vehicle!",
        no_money = "You don't have enough money!",
        blocked_spawn = "There is a vehicle blocking the spawn point!",
        no_vehicle = "You don't have a rental vehicle!",
        missing_vehicle = "Your rental vehicle is missing!",
        not_in_vehicle = "You must be in the rental vehicle to return it!"
    },
    success = {
        vehicle_rented = "Vehicle rented! You have %s minutes.",
        vehicle_returned = "Vehicle returned! Refund: $%s"
    }
}