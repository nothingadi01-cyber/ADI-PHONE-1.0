fx_version 'cerulean'
game 'gta5'
author 'Adi'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/apps/*.png' -- Icons for your apps
}

client_scripts {
    'config.lua',
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}
