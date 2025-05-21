fx_version 'cerulean'
game 'gta5'

author 'QM Scripts'
description 'Advanced Guidebook System for QBCore'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

lua54 'yes' 