fx_version 'adamant'
version '1.0'
game 'gta5'
author 'p0p0'
description 'p0p0 car wash'
lua54 'yes'

dependency 'es_extended'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'client/client.lua'   
}

server_scripts {
    '@es_extended/locale.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}
