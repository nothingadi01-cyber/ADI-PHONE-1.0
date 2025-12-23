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

fx_version 'cerulean'
game 'gta5'
author 'Adi'
description 'The Complete Digital Ecosystem: HUD, Smartphone, and Government'

-- Global Config for all Adi Scripts
shared_scripts {
    'config/shared.lua',
    'config/translations.lua'
}

client_scripts {
    'client/hud_core.lua',      -- ADRENALINE HUD
    'client/phone_main.lua',    -- ADI-PHONE
    'client/interaction.lua',   -- Airdrop & NFC
    'client/apps/*.lua'         -- All Premium Apps
}

server_scripts {
    'server/economy.lua',       -- Banking & Tax
    'server/government.lua',    -- Mayor & Laws
    'server/darkweb.lua'        -- Hitman & Bounties
}

ui_page 'html/index.html'
files { 'html/**/*', 'assets/**/*' }
fx_version 'cerulean'
game 'gta5'

description 'ADI-PHONE Infinity: The Sovereign OS'
author 'Adi_Dev'
version '4.5.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/assets/**/*'
}

client_scripts {
    'client/main.lua',
    'client/apps/*.lua',
    'client/signal_logic.lua',
    'client/death_logic.lua',
    'client/multitasking.lua'
}

server_scripts {
    'server/main.lua',
    'server/billing_system.lua',
    'server/quantum_db.lua'
}
