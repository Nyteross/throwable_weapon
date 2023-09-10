fx_version 'cerulean'
games {'gta5'}

shared_script '@es_extended/imports.lua'

client_scripts {
    "config.lua",
    "utils/*.lua",
    "client.lua"
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "config.lua",
    "server.lua"
}