fx_version 'adamant'

lua54 'yes'

game 'gta5'

description 'HRS BASES (update 01/01/2025 (January) rain blocking code)'

version '2.0'

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/script.js',
    'html/main.css',
    "html/*.png",
	"html/items/*.png"
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'locales/locales.lua',
	'config.lua',
	'discordLogs/logs.lua',
	'server/main_unlocked.lua',
	'server/main.lua',
	'shared/main_unlocked.lua'
}

client_scripts {
	'locales/locales.lua',
	'config.lua',
	'client/main_unlocked.lua',	
	'client/main.lua',
	'shared/main_unlocked.lua'
}

escrow_ignore {
	'@oxmysql/lib/MySQL.lua',
	'locales/locales.lua',
	'discordLogs/logs.lua',
	'server/main_unlocked.lua',
	'client/main_unlocked.lua',
	'config.lua',
	'shared/main_unlocked.lua'
}

provide 'hrs_base_building'

dependency '/assetpacks'