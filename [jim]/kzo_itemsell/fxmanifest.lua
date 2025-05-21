fx_version 'cerulean'

game 'gta5'

author 'KzO Exclusives'

shared_script 'config.lua'

client_scripts {'client/*.lua'}

server_scripts {'server/*.lua'}

ui_page {'html/index.html'}

files {'html/index.html', 'html/style.css', 'html/app.js', 'html/imgs/*.png', 'html/imgs/*.svg', 'html/button.wav', 'html/button2.wav'}

escrow_ignore {'client/editable.lua', 'server/editable.lua', 'config.lua'}

lua54 'yes'
dependency '/assetpacks'