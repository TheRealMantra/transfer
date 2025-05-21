
Config = {
    -- Mostra se o jogador morreu
    SHOW_DEAD = true,

    --[[
        1 - Shows the emoji of life and damage 
        2 - Shows only the damage 
        3 - Shows the emoji of armor, life and damage 
        4 - Shows only the armor while the ped has armor, then shows only the life emoji and the damage 
        5 - Shows damage to health and armor
    ]]
    HUD_MESSAGE_TYPE = 2,

    -- Cor da letra
    -- {255,0,0} = RGB color set
    -- false = RGB color
    COLOR = {255,255,255},

    -- Utilizar um gif para mostrar a morte do jogador
    USE_IMG_GIF = false,

    -- 'dead1'
    -- 'dead2'
    GIF = "dead2",

    -- 'HTML' = custom display html
    -- 'GTA' = display padrão gta
    DISPLAY_HUD = 'HTML',

    -- Distancia do custom html
    SIZE = {
        NEAR = 1.0,
        AVERAGE = 1.25,
        FAR = 1.35,
    },
}
