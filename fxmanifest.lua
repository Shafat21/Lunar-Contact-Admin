lua54 'yes' -- ✅ Required for ox_lib

fx_version 'cerulean'
game 'gta5'

author 'Shafat'
description 'Lunar Heist Admin Menu'
version '1.0.0'

-- Dependencies
dependency 'ox_lib'

-- Shared Configs
shared_script {
    'config.lua',
    '@es_extended/imports.lua',
    '@es_extended/locale.lua'
}

-- Client Scripts
client_scripts {
    '@ox_lib/init.lua',
    'client/admin_heist_menu.lua'
}

-- Server Scripts
server_scripts {
    'server/admin_heist_menu.lua'
}
