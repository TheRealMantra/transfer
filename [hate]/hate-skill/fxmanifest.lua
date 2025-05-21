fx_version 'cerulean'
game 'gta5'

author 'hate-skill'
description 'Skill and XP System'
version '1.0.0'
lua54 'yes'
server_scripts {
    'server/server.lua',
    'server/frameworks.lua',
    '@oxmysql/lib/MySQL.lua',
}

client_scripts {
    'client/client.lua',
}

escrow_ignore {'config.lua', 'server/frameworks.lua'}
shared_script 'config.lua'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
}

dependency '/assetpacks'