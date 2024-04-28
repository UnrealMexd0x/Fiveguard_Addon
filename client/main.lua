-- V1.4.2 Author UnrealMexd0x

local FiveguardAddon = FiveguardAddon or {}

FiveguardAddon.CreateThread(FiveguardAddon.Client.PLLoaded)

FiveguardAddon.AddEvent("onClientResourceStop", FiveguardAddon.Client.ClientStop)
FiveguardAddon.AddEvent("onResourceStop", FiveguardAddon.Client.Stop)
