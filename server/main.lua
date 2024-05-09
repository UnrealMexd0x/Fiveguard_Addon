-- V1.4.3 Author UnrealMexd0x

local FiveguardAddon = FiveguardAddon or {}

FiveguardAddon.CreateThread(FiveguardAddon.Server.BotLoader)

FiveguardAddon.AddEvent('fg:NewUpdate', FiveguardAddon.Server.Updater)
FiveguardAddon.AddEvent('weaponDamageEvent', FiveguardAddon.Server.WeaponEvent)
FiveguardAddon.AddEvent('onServerResourceStart', FiveguardAddon.Server.ResourceStarter)

FiveguardAddon.Register("Fiveguard_Addon:BanPlayerStop", FiveguardAddon.Server.BanStop)
FiveguardAddon.Register("FiveguardAddon:ClientStart", FiveguardAddon.Server.ClientStart)

FiveguardAddon.Command(FiveguardAddon.Config.BanCommand, FiveguardAddon.Server.BanCommand, false)
FiveguardAddon.Command(FiveguardAddon.Config.UnbanCommand, FiveguardAddon.Server.UnbanCommand, false)
FiveguardAddon.Command(FiveguardAddon.Config.BanInfoCommand, FiveguardAddon.Server.BanInfoCommand, false)
FiveguardAddon.Command(FiveguardAddon.Config.ScreenshotCommand, FiveguardAddon.Server.ScreenCommand, false)
FiveguardAddon.Command(FiveguardAddon.Config.RecordCommand, FiveguardAddon.Server.RecordCommand, false)
