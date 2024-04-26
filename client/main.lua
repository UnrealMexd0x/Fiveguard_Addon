-- V1.4.1 Author UnrealMexd0x

FiveguardAddon = FiveguardAddon or {}

FiveguardAddon.CreateThread(FiveguardAddon.Client.PLLoaded)

FiveguardAddon.AddEvent("onClientResourceStop", FiveguardAddon.Client.ClientStop)
FiveguardAddon.AddEvent("onResourceStop", FiveguardAddon.Client.Stop)
