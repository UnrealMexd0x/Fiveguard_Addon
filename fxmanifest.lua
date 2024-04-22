fx_version 'cerulean'
game 'gta5'
name 'Fiveguard_Addon'
description 'Fiveguard Addon by UnrealMexd0x'
author 'UnrealMexd0x'
version '1.3.2'

shared_scripts {
	'config/sh_*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'config/sv_*.lua',
	'server/*.lua'
}

dependencies {
	'ox_lib'
}
