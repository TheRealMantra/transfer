-- config.lua
Config = {
    Debug = false, -- Debug modunu aktif/pasif yapmak için

    Framework = "QB", -- use "ESX" or "QB"
    BaseXP = 50, -- Base XP required for the first level
    XPMultiplier = 1.3, -- Multiplier for XP required for each subsequent level
    LevelCap = 50, -- Maximum level a player can reach
    PointsPerLevel = 1, -- Skill points awarded per level

    SkillCosts = {
        ['health'] = { base = 2, multiplier = 1.5, maxLevel = 16 }, -- Cost configuration for health skill
        ['regen'] = { base = 2, multiplier = 1.5, maxLevel = 16 }, -- Cost configuration for regen skill
        ['stamina'] = { base = 2, multiplier = 1.5, maxLevel = 16 }, -- Cost configuration for stamina skill
        ['stamina_regen'] = { base = 2, multiplier = 1.5, maxLevel = 16 }, -- Cost configuration for stamina regen skill
        ['speed'] = { base = 2, multiplier = 1.5, maxLevel = 16 }, -- Cost configuration for speed skill
        ['swim'] = { base = 2, multiplier = 1.5, maxLevel = 16 }, -- Cost configuration for swim skill
        ['car_speed'] = { base = 2, multiplier = 1.5, maxLevel = 16 }, -- Cost configuration for car speed skill
        ['boat_speed'] = { base = 2, multiplier = 1.5, maxLevel = 16 }, -- Cost configuration for boat speed skill
    },

    EnabledSkills = {
        health = true,
        regen = true,
        stamina = true,
        stamina_regen = true,
        speed = true,
        swim = true,
        car_speed = true,
        boat_speed = true
    },

    SkillEffects = {
        health = { max_health_per_level = 10 }, -- +10 HP per level
        regen = { health_regen_per_level = 0.2 }, -- +0.2 HP/s health regeneration per level
        stamina = { max_stamina_per_level = 0.5 }, -- +5% max stamina per level
        stamina_regen = { stamina_regen_per_level = 0.25 }, -- +0.25/s stamina regeneration per level
        speed = { run_speed_per_level = 0.03 }, -- +3% run speed per level
        swim = { swim_speed_per_level = 0.02 }, -- +2% swim speed per level
        car_speed  = { speed_per_level  = 0.03 }, -- +3% car speed per level
        boat_speed  = { speed_per_level  = 0.05 }, -- +5% boat speed per level
    },

    TimeBasedXP = {
        enable = true, -- Enable or disable time-based XP gain
        interval = 5, -- Interval in minutes for time-based XP gain
        amount = 15 -- XP amount given to player at each interval
    },
    
    XPSources = {
        ['drive'] = { xp = 5, cooldown = 30000 }, -- XP for driving with a cooldown of 30 seconds
        ['kill'] = { xp = 10 }, -- XP for killing
        ['mission'] = { xp = 50 } -- XP for completing missions
    },

    Exports = {
        minXP = 1, -- Minimum XP that can be added via exports
        maxXP = 5000, -- Maximum XP that can be added via exports
        minPoints = 1, -- Minimum skill points that can be added via exports
        maxPoints = 100 -- Maximum skill points that can be added via exports
    },

    Commands = {
        AddXP = "givexp", -- Command to add XP
        AddSkillPoints = "addskillpoints", -- Command to add skill points
        ResetSkills = "resetskills" -- Command to reset skills
    },

    -- ONLY FOR ESX --
    adminRanks = { -- change this as your server ranking ( default are : superadmin | admin | moderator )
        'superadmin',
        'admin',
        'moderator',
    },
    
    Locale = {
        InvalidXPAmount = "Invalid XP amount!", -- Message for invalid XP amount
        ResetSkillsCommand = "Reset player skills", -- Command description for resetting skills
        PlayerID = "Player ID", -- Label for player ID
        PlayerNotFound = "Player not found!", -- Message for player not found
        SkillsReset = "All your skills have been reset!", -- Message for skills reset
        PlayerSkillsReset = "Player skills reset: ", -- Message prefix for player skills reset
        DatabaseError = "Database error!", -- Message for database error
        UnauthorizedAccess = "Unauthorized access: ", -- Message for unauthorized access
        XPAddedMessage = "XP added: ", -- Message prefix for XP added
        Player = "Player", -- Label for player
        UsageAddXP = "Usage: /givexp [ID] [Amount]", -- Usage message for add XP command
        NoPermission = "You do not have permission!", -- Message for no permission
        UsageAddSkillPoints = "Usage: /addskillpoints [ID] [Amount]", -- Added translation
        SkillPointsAdded = "Skill points added: ", -- Added translation
        UsageResetSkills = "Usage: /resetskills [ID]", -- Added translation
        SkillsResetSuccess = "Skills reset successful: ", -- Added translation
        NotifyXP = "XP gained: ", -- Added translation
        LevelUpMessage = "Congratulations! You've leveled up to level " -- Added translation
    }
}

--[[ SERVER SIDE EXPORTS ]]
--exports['hate-skill']:AddXP(playerId, 50)
--exports['hate-skill']:AddSkillPoints(playerId, 3)

--[[ CLIENT SIDE EXPORTS ]]
--exports['hate-skill']:AddXP(50)
--exports['hate-skill']:AddSkillPoints(3)
--exports['hate-skill']:GetPlayerLevel()