fx_version "cerulean"
version "0.1.0"
game "gta5"
lua54 "yes"
author "discord.gg/zykeresources"

ui_page "nui/index.html"
-- ui_page "nui_source/hot_reload.html"

files {
    "nui/**/*",
    -- "nui_source/hot_reload.html",
    "locales/*.lua",
}

shared_scripts {
    "@zyke_lib/imports.lua",
    "shared/unlocked/config.lua",
    "shared/unlocked/bones.lua",
    "shared/unlocked/items.lua",

    "shared/unlocked/functions.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/unlocked/database.lua",
    "server/locked/functions.lua",
    "server/locked/main.lua",
    "server/locked/events.lua",
    "server/unlocked/functions.lua",
    "server/unlocked/events.lua",
    "server/unlocked/main.lua",
    "server/unlocked/on_consumption.lua",
}

client_scripts {
    "client/unlocked/functions.lua",
    "client/locked/main.lua",
    "client/locked/functions.lua",
    "client/locked/events.lua",
    "client/locked/consuming.lua",
    "client/unlocked/main.lua",
    "client/unlocked/events.lua",
    "client/unlocked/place_item.lua",

    "client/unlocked/threads/world_item_interaction.lua",
    -- "client/unlocked/threads/trash_can.lua",

    "client/unlocked/keybinds.lua",
}

dependencies {
    "zyke_lib",
    "zyke_sounds",
    "zyke_status",
    "zyke_propaligner",
}

escrow_ignore {
    "locales/*",
    "client/unlocked/**/*",
    "server/unlocked/**/*",
    "shared/unlocked/**/*",
    "extras/**/*",
}
dependency '/assetpacks'