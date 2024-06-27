-- V1.4.3 Author UnrealMexd0x

FiveguardAddon.Config.SV = {
    Bot = {
        -- [Discord Developer Portal (https://discord.com/developers/applications/)]
        -- [How to use Discord Developer Portal (Thanks to KlutchxGaming)(https://www.youtube.com/watch?v=zrNloK9b1ro)]

        Color = 8421504,  -- Color for bot messages (Decimal Color Code)

        ---------- Discord Bot Credentials ---------
        BotToken = "YOUR_BOT_TOKEN",
        WebHook = "YOUR_CHANNEL_WEBHOOK_FOR_THE_BOT",
        ChannelID = "YOUR_DISCORD_CHANNEL_ID_FOR_THE_BOT",
        --------------------------------------------

        -- Discord Permission System for Fiveguard uses the Discord Bot
        ServerID = "YOUR_DISCORD_SERVER_ID",
        RolePermissions = {
            ["1111111111111111111"] = {
                AdminMenu = {
                    "AdminMenuAccess",
                    "AnnouncementAccess",
                    "ESPAccess",
                    "ClearEntitiesAccess",
                    "BanAndKickAccess",
                    "GotoAndBringAccess",
                    "VehicleAccess",
                    "MiscAccess",
                    "LogsAccess",
                    "PlayerSelectorAccess",
                    "BanListAndUnbanAccess",
                    "ModelChangerAccess"
                },
                Client = {
                    "BypassSpectate",
                    "BypassGodMode",
                    "BypassInvisible",
                    "BypassStealOutfit",
                    "BypassInfStamina",
                    "BypassNoclip",
                    "BypassSuperJump",
                    "BypassFreecam",
                    "BypassSpeedHack",
                    "BypassTeleport",
                    "BypassNightVision",
                    "BypassThermalVision",
                    "BypassOCR",
                    "BypassNuiDevtools",
                    "BypassBlacklistedTextures",
                    "BlipsBypass",
                    "BypassCbScanner"
                },
                Weapon = {
                    "BypassWeaponDmgModifier",
                    "BypassInfAmmo",
                    "BypassNoReload",
                    "BypassRapidFire"
                },
                Vehicle = {
                    "BypassVehicleFixAndGodMode",
                    "BypassVehicleHandlingEdit",
                    "BypassVehicleModifier",
                    "BypassBulletproofTires"
                },
                Blacklist = {
                    "BypassModelChanger",
                    "BypassWeaponBlacklist"
                },
                Misc = {
                    "FGCommands",
                    "BypassVPN",
                    "BypassExplosion",
                    "BypassClearTasks",
                    "BypassParticle"
                }
            },
            ["DISCORD_ROLE_ID"] = {
                Client = {
                    "BypassNoclip",
                    "BypassThermalVision",
                    "BypassOCR",
                    "BypassNuiDevtools"
                }
            }
        },

        -- Users Allowed to Interact with the Bot --
        Allowedusers = {
            'YOUR_DISCORD_ID',
        },
        --------------------------------------------

        ReplyUserName = "Fiveguard Addon",  -- Bot's username for replies
        AvatarURL = "https://yt3.googleusercontent.com/AwJhSb3xMJIDmXa3zwJuCxn_WxR3Z6-lW9RXaF5eqz0UT_r9OcB7Ayvf76SJSmIp2IJ2rnzMfQ=s900-c-k-c0x00ffffff-no-rj",  -- Bot's avatar URL
        Prefix = "+",  -- Command prefix for the bot
        WaitEveryTick = 4000  -- Wait time in milliseconds for each bot tick
    },

    UpdateNotify = function(msg)
        -- If you prefer not to use ox_lib, remember to remove ox_lib from your fxmanifest.lua under dependencies.

        TriggerClientEvent('ox_lib:notify', -1, {
            title = "",
            icon = "fa-solid fa-shield-halved",
            description = msg,
            position = "top-center"
        })
    end,

    WeaponCheatDetectionFunction = function(player, weapon, damage, timing, silenced)
        -- You can deactivate weapon events by modifying the 'WeaponEvents' variable in sh_config.lua.
        local function banPlayer(version)
            local reason = "(Weapon Event Cheat) [Version: " .. tostring(version) .. "] [Fiveguard_Addon]"
            FiveguardAddon.Server.BanPlayer(player, reason)
        end

        local function checkBanConditions()
            if weapon == 133987706 then
                if timing > 200000 and damage > 200 then
                    banPlayer(1)

                    return true
                end
            elseif silenced and damage == 0 then
                if weapon == 2725352035 or weapon == 3452007600 then
                    banPlayer(2)

                    return true
                end
            elseif weapon == -1569615261 and damage > 200 then
                banPlayer(3)

                return true
            elseif not silenced and damage == 131071 and weapon == 1834887169 then
                banPlayer(4)

                return true
            end

            return false
        end

        if checkBanConditions() then
            CancelEvent()
        end
    end
}

return FiveguardAddon.Config.SV
