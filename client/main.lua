-- V1.4.3 Author UnrealMexd0x

local FiveguardAddon = FiveguardAddon or {}

FiveguardAddon.AddEvent("playerSpawned", FiveguardAddon.Client.PLLoaded)

FiveguardAddon.AddEvent("onClientResourceStop", FiveguardAddon.Client.ClientStop)
FiveguardAddon.AddEvent("onResourceStop", FiveguardAddon.Client.Stop)
