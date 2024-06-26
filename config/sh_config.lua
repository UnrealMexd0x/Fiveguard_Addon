-- V1.4.5 Author UnrealMexd0x

FiveguardAddon = {
    Config = {
        FiveguardName = "YOUR_ANTICHEATNAME",                                   -- Fiveguard Resource Name
        FiveguardAce = 'command.fiveguard',                                     -- Player Command Ace [https://docs.fivem.net/natives/?_0xDEDAE23D]

        AddonUpdateInfo = true,                                                 -- Enable the Update Info for this script

        Updater = true,                                                         -- Enable the Fiveguard Updater 
        Counter = { "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0" },   -- Update Counter

        WeaponEvents = true,                                                    -- Blocks Various Cheat used Weapon Events

        DiscordBot = true,                                                      -- Enable the Fiveguard Discord Bot
        DiscordPermissionSystem = true,                                         -- Discord Permission System only Works with the Bot

        HelpCommand = "help",                                                   -- Help Command

        BanInfoCommand = "baninfo",                                             -- Baninfo Command      (Bot, Ingame and Console Command)
        BanCommand = "fgban",                                                   -- Ban Command          (Bot, Ingame and Console Command)
        UnbanCommand = "fgunban",                                               -- Unban Command        (Bot, Ingame and Console Command)
        ScreenshotCommand = "fgscreenshot",                                     -- Screenshot Command   (Bot, Ingame and Console Command)
        RecordCommand = "fgrecord",                                             -- Record Command       (Bot, Ingame and Console Command)

        SendToLogs = true,                                                      -- Send to Fiveguard Discord Logs
        IgnoreStaticPermission = true,                                          -- Ignore Static Permissions

        Language = {
            Second = "second",
            Seconds = "seconds",

            CommandBanInfo = "Usage: /%s [Player-ID] [Violation]",
            BanInfos = "Ban Information:",
            BanMessage = "Player with ID %s has been banned for %s.",

            CommandUnbanInfo = "Usage: /%s [BanID]",
            UnbanTrue = "Player with Ban ID %s has been successfully unbanned.",
            UnbanFalse = "Failed to unban player with Ban ID %s.",

            CommandInfoBan = "Usage: /%s [BanID]",
            NoBanInfo = "No ban information found.",
            WrongInfo = "This BanID does not exist.",

            CommandScreenshotInfo = "Usage: /%s [Player-ID]",
            ScreenshotCreated = "Screenshot has been created: %s",

            CommandRecordInfo = "Usage: /%s [Player-ID] [Time]",
            RecordCreated = "Recording has been created: %s",

            NoPermission = "You do not have permission to execute this command.",
            StopBan =  "Script Stop found (Script: %s)",
            BotLoader = "^0[Fiveguard Addon] ^8Please add %s, current value: %s^0",

            Bot = {
                CommandNotFound = "Command not found. Please make sure you enter a valid command.",
                Info = "Available commands:\n" ..
                "%s - Displays this help.\n" ..
                "%s [BanID] - Unbans a player.\n" ..
                "%s [BanId] - Get Ban Info from ID\n" ..
                "%s [Player-ID] [Reason] - Bans a player with the specified ID and reason.\n" ..
                "%s [Player-ID] - Takes a screenshot of a player.\n" ..
                "%s [Player-ID] [Time] - Records a video of a player.",

                BanInfo =  "Usage: %s [BanID]",

                BanTrue = "Player with ID %s has been banned. Reason: %s",
                BanFalse = "Invalid use of command. Usage: %s [Player-ID] [Reason]",

                UnbanTrue = "Ban ID %s has been unbanned.",
                UnbanFalse = "Invalid use of command. Usage: %s [BanID]",

                ScreenshotTrue = "Screenshot has been created: %s",
                ScreenshotFalse = "Invalid use of command. Usage: %s [Player-ID]",

                RecordTrue = "Recording has been created: %s",
                RecordFalse = "Invalid use of command. Usage: %s [Player-ID] [Time until 5 Sec]",
            },

            Updater = {
                NewUpdatConsolePrint = "^0[Fiveguard Addon] A new update for Fiveguard has been found. Version: ^1%s^0",
                ServerRestartConsolePrint = "^0[Fiveguard Addon] ^1Server is restarting...^0",
                PlayerNotify = "[Anticheat Update] Server will restart in %s %s!",
                DiscordLog = "A new update for Fiveguard has been found. Version: %s"
            }
        },
    },

    ----------------------------------------------- Don't change it if you don't know what you're doing ---------------------------------------------
    Wait = Citizen.Wait, Command = RegisterCommand, AddEvent = AddEventHandler, CreateThread = Citizen.CreateThread, Register = RegisterNetEvent
    -------------------------------------------------------------------------------------------------------------------------------------------------
}

return FiveguardAddon
