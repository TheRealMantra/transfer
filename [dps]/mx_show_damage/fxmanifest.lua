fx_version 'cerulean'
game 'gta5'

description 'mxShowDamage'
version '1.0'

ui_page 'html/index.html'

server_scripts { 
	'server/*' 
}

client_scripts { 
	'client/*' 
}

shared_scripts { 
	"config.lua" 
}

files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/js/*.map',

	'html/img/*.gif',
}

lua54 'yes'

escrow_ignore {
	'client/*',
	'server/*',
	"config.lua",
}

dependency '/assetpacks'