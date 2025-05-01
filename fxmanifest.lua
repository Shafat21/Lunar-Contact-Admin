-- fxmanifest.lua
lua54 'yes'
fx_version 'cerulean'
game 'gta5'

author 'Shafat'
description 'Lunar Heist Admin Menu'
version '1.1.0'

dependency 'ox_lib'
-- optional_dependency 'qb-core'
-- optional_dependency 'qbox'

shared_script {
    'config.lua',
    '@es_extended/imports.lua', -- disable if using other framework
    '@es_extended/locale.lua' -- disable if using other framework
}

client_scripts {
    '@ox_lib/init.lua',
    'client/admin_heist_menu.lua'
}

server_scripts {
    'server/admin_heist_menu.lua'
}
