--[[ FX Information ]]--
fx_version   'cerulean'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'sc-utils'
author       'Haroki'

--[[ Manifest ]]--
dependencies {
	'/server:5104',
	'/onesync',
}

shared_scripts {
    'shared/main.lua',
}

client_scripts {
    'client/**/*.lua',
}

ui_page 'dist/index.html'
--ui_page 'http://localhost:3000/'

files {
    'dist/assets/index.css',
    'dist/assets/index.js',
    'dist/index.html',
}

server_scripts {
    'server/main.lua',
}

