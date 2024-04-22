FiveguardAddon.Server = {
    String = {},
    LastData = nil,
    UnbanWert = nil,
    BanInfo = nil,
    TempInfo = nil,
    TempError = nil
}

FiveguardAddon.Server.IsPlayerAdmin = function(playerSource)
    if playerSource ~= 0 then
        return IsPlayerAceAllowed(playerSource, FiveguardAddon.Config.FiveguardAce)
    else
        return true
    end
end

FiveguardAddon.Server.BanPlayer = function(playerSource, violation)
    exports[FiveguardAddon.Config.FiveguardName]:fg_BanPlayer(playerSource, violation, FiveguardAddon.Config.SendToLogs)
end

FiveguardAddon.Server.BanCommand = function(playerSource, args)
    if not FiveguardAddon.Server.IsPlayerAdmin(playerSource) then
        print(FiveguardAddon.Config.Language.NoPermission)
        return
    end

    if #args < 2 then
        local msg = ((FiveguardAddon.Config.Language.CommandBanInfo):format(FiveguardAddon.Config.BanCommand))
        print(msg)
        return
    end

    local targetPlayer = tonumber(args[1])
    local violation = table.concat(args, " ", 2)

    FiveguardAddon.Server.BanPlayer(targetPlayer, violation)
    local msg = ((FiveguardAddon.Config.Language.BanMessage):format(targetPlayer, violation))
    print(msg)
end

FiveguardAddon.Server.UnbanPlayer = function(BanId)
    FiveguardAddon.Server.UnbanWert = exports[FiveguardAddon.Config.FiveguardName]:UnbanId(BanId)
end

FiveguardAddon.Server.UnbanCommand = function(playerSource, args)
    if not FiveguardAddon.Server.IsPlayerAdmin(playerSource) then
        print(FiveguardAddon.Config.Language.NoPermission)
        return
    end

    if #args < 1 then
        local msg = ((FiveguardAddon.Config.Language.CommandUnbanInfo):format(FiveguardAddon.Config.UnbanCommand))
        print(msg)
        return
    end

    local BanID = args[1]

    FiveguardAddon.Server.UnbanPlayer(BanID)

    if FiveguardAddon.Server.UnbanWert then
        local msg = ((FiveguardAddon.Config.Language.UnbanTrue):format(BanID))
        print(msg)
        FiveguardAddon.Server.UnbanWert = nil
    else
        local msg = ((FiveguardAddon.Config.Language.UnbanFalse):format(BanID))
        print(msg)
    end
end

FiveguardAddon.Server.GetBanInfo = function(BanId)
    FiveguardAddon.Server.BanInfo = exports[FiveguardAddon.Config.FiveguardName]:GetBanInfoId(BanId)
end

FiveguardAddon.Server.PrintTableInfo = function(title, tbl)
    print(title .. ":")
    for key, value in pairs(tbl) do
        if type(value) == "table" then
            print(("  %s:"):format(tostring(key)))
            for k, v in pairs(value) do
                print(("    %s: %s"):format(tostring(k), tostring(v)))
            end
        else
            print(("  %s: %s"):format(tostring(key), tostring(value)))
        end
    end
end

FiveguardAddon.Server.PrintBanInfo = function(banInfo)
    print(FiveguardAddon.Config.Language.BanInfos)

    local fields = {"name", "reason", "steam", "license", "xbl", "discord", "ip"}
    for _, field in ipairs(fields) do
        print(("  %s: %s"):format(field, tostring(banInfo[field])))
    end

    print(("Manuell: %s"):format(tostring(banInfo.manual)))

    FiveguardAddon.Server.PrintTableInfo("Tokens", banInfo.tokens)
    FiveguardAddon.Server.PrintTableInfo("FG_TS", banInfo.fg_ts)
end

FiveguardAddon.Server.BanInfoCommand = function(playerSource, args)
    if not FiveguardAddon.Server.IsPlayerAdmin(playerSource) then
        print(FiveguardAddon.Config.Language.NoPermission)
        return
    end

    if #args < 1 then
        local msg = ((FiveguardAddon.Config.Language.CommandInfoBan):format(FiveguardAddon.Config.BanInfoCommand))
        print(msg)
        return
    end

    local BanID = args[1]

    FiveguardAddon.Server.GetBanInfo(BanID)

    if FiveguardAddon.Server.BanInfo then
        if FiveguardAddon.Server.BanInfo then
            FiveguardAddon.Server.PrintBanInfo(FiveguardAddon.Server.BanInfo)
        else
            print(FiveguardAddon.Config.Language.NoBanInfo)
        end

        FiveguardAddon.Server.BanInfo = nil
    else
        print(FiveguardAddon.Config.Language.WrongInfo)
    end
end

FiveguardAddon.Server.ScreenCommand = function(playerSource, args)
    if not FiveguardAddon.Server.IsPlayerAdmin(playerSource) then
        print(FiveguardAddon.Config.Language.NoPermission)
        return
    end

    if #args < 1 then
        local msg = ((FiveguardAddon.Config.Language.CommandScreenshotInfo):format(FiveguardAddon.Config.ScreenshotCommand))
        print(msg)
        return
    end

    local SpielerID = args[1]

    FiveguardAddon.Server.ScreenPlayer(SpielerID, function(url)
        local msg = ((FiveguardAddon.Config.Language.ScreenshotCreated):format(url))
        print(msg)
    end)
end

FiveguardAddon.Server.RecordCommand = function(playerSource, args)
    if not FiveguardAddon.Server.IsPlayerAdmin(playerSource) then
        print(FiveguardAddon.Config.Language.NoPermission)
        return
    end

    if #args < 2 then
        local msg = ((FiveguardAddon.Config.Language.CommandRecordInfo):format(FiveguardAddon.Config.RecordCommand))
        print(msg)
        return
    end

    local SpielerID = args[1]
    local Time = args[2]

    FiveguardAddon.Server.RecordPlayer(SpielerID, Time, function(url)
        local msg = ((FiveguardAddon.Config.Language.RecordCreated):format(url))
        print(msg)
    end)
end

FiveguardAddon.Server.TempPermission = function(playerSource, category, permission, allow)
    FiveguardAddon.Server.TempInfo, FiveguardAddon.Server.TempError = exports[FiveguardAddon.Config.FiveguardName]:SetTempPermission(playerSource, category, permission, allow, FiveguardAddon.Config.IgnoreStaticPermission)
end

FiveguardAddon.Server.RecordPlayer = function(playerSource, time, handler)
    exports[FiveguardAddon.Config.FiveguardName]:recordPlayerScreen(playerSource, time, handler)
end

FiveguardAddon.Server.ScreenPlayer = function(playerSource, handler)
    exports[FiveguardAddon.Config.FiveguardName]:screenshotPlayer(playerSource, handler)
end

FiveguardAddon.Server.DiscordRequest = function(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/" .. endpoint, function(errorCode, resultData, resultHeaders)
        data = {
            data = resultData,
            code = errorCode,
            headers = resultHeaders
        }
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bot " .. FiveguardAddon.Config.Bot.BotToken
    })
    while data == nil do FiveguardAddon.Wait(0) end
    return data
end

FiveguardAddon.Server.DiscordLog = function(name, message, color)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = { ["text"] = FiveguardAddon.Config.Bot.ReplyUserName }
        }
    }
    PerformHttpRequest(FiveguardAddon.Config.Bot.WebHook, function(err, text, headers) end, 'POST', json.encode({
        username = FiveguardAddon.Config.Bot.ReplyUserName,
        embeds = embed,
        avatar_url = FiveguardAddon.Config.Bot.AvatarURL
    }), { ['Content-Type'] = 'application/json' })
end

FiveguardAddon.Server.String.Starts = function(String, Start)
    return string.sub(String, 1, #Start) == Start
end

FiveguardAddon.Server.DiscordBot = function(command)
    local Username = FiveguardAddon.Config.Bot.ReplyUserName
    local Prefix = FiveguardAddon.Config.Bot.Prefix
    local Color = FiveguardAddon.Config.Bot.Color

    local UnbanCommand = Prefix .. FiveguardAddon.Config.UnbanCommand
    local BanCommand = Prefix .. FiveguardAddon.Config.BanCommand
    local ScreenshotCommand = Prefix .. FiveguardAddon.Config.ScreenshotCommand
    local RecordCommand = Prefix .. FiveguardAddon.Config.RecordCommand

    if FiveguardAddon.Server.String.Starts(command, Prefix) then
        if FiveguardAddon.Server.String.Starts(command, Prefix .. FiveguardAddon.Config.HelpCommand) then
            FiveguardAddon.Server.DiscordLog(Username, ((FiveguardAddon.Config.Language.Bot.Info):format(Prefix, UnbanCommand, BanCommand, ScreenshotCommand, RecordCommand)), Color)
        elseif FiveguardAddon.Server.String.Starts(command, BanCommand) then
            local _, _, playerId, reason = string.find(command, BanCommand .. "%s+(%S+)%s+(.+)")
            playerId = tonumber(playerId)

            if playerId and reason then
                FiveguardAddon.Server.BanPlayer(playerId, reason)
                FiveguardAddon.Server.DiscordLog(Username, ((FiveguardAddon.Config.Language.Bot.BanTrue):format(playerId, reason)), Color)
            else
                FiveguardAddon.Server.DiscordLog(Username, ((FiveguardAddon.Config.Language.Bot.BanFalse):format(BanCommand)), Color)
            end
        elseif FiveguardAddon.Server.String.Starts(command, UnbanCommand) then
            local _, _, banId = string.find(command, UnbanCommand .. "%s+(%S+)")
            banId = tonumber(banId)

            if banId then
                FiveguardAddon.Server.UnbanPlayer(banId)
                FiveguardAddon.Server.DiscordLog(Username, ((FiveguardAddon.Config.Language.Bot.UnbanTrue):format(banId)), Color)
            else
                FiveguardAddon.Server.DiscordLog(Username, ((FiveguardAddon.Config.Language.Bot.UnbanFalse):format(UnbanCommand)), Color)
            end
        elseif FiveguardAddon.Server.String.Starts(command, ScreenshotCommand) then
            local _, _, playerId = string.find(command, ScreenshotCommand .. "%s+(%S+)")
            playerId = tonumber(playerId)

            if playerId then
                FiveguardAddon.Server.ScreenPlayer(playerId, function(url)
                    FiveguardAddon.Server.DiscordLog(Username, ((FiveguardAddon.Config.Language.Bot.ScreenshotTrue):format(url)), Color)
                end)
            else
                FiveguardAddon.Server.DiscordLog(Username, ((FiveguardAddon.Config.Language.Bot.ScreenshotFalse):format(ScreenshotCommand)), Color)
            end
        elseif FiveguardAddon.Server.String.Starts(command, RecordCommand) then
            local _, _, playerId, time = string.find(command, RecordCommand .. "%s+(%S+)%s+(%S+)")
            playerId = tonumber(playerId)
            time = tonumber(time)

            if playerId and time then
                FiveguardAddon.Server.RecordPlayer(playerId, time, function(url)
                    FiveguardAddon.Server.DiscordLog(Username, ((FiveguardAddon.Config.Language.Bot.RecordTrue):format(url)), Color)
                end)
            else
                FiveguardAddon.Server.DiscordLog(Username, ((FiveguardAddon.Config.Language.Bot.RecordFalse):format(RecordCommand)), Color)
            end
        else
            FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Config.Language.Bot.CommandNotFound, Color)
        end
    end
end

FiveguardAddon.Server.WeaponEvent = function(playerSource, data)
    if not FiveguardAddon.Config.WeaponEvents then return end

    local weaponType = data.weaponType
    local weaponDamage = data.weaponDamage

    if weaponType == 133987706 and (data.damageTime > 200000 and weaponDamage > 200) then
        FiveguardAddon.Server.BanPlayer(playerSource, "Skript.gg (Anti Kill) [Fiveguard_Addon]")
        CancelEvent()
    elseif data.silenced and weaponDamage == 0 then
        if weaponType == 2725352035 then
            FiveguardAddon.Server.BanPlayer(playerSource, "Skript.gg (Edging) (1) [Fiveguard_Addon]")
        elseif weaponType == 3452007600 then
            FiveguardAddon.Server.BanPlayer(playerSource, "Skript.gg (Edging) (2) [Fiveguard_Addon]")
        end
        CancelEvent()
    elseif not data.silenced and weaponDamage == 131071 and weaponType == 1834887169 then
        FiveguardAddon.Server.BanPlayer(playerSource, "Skript.gg (Edging) (3) [Fiveguard_Addon]")
        CancelEvent()
    elseif weaponType == 133987706 then
        CancelEvent()
    end
end

FiveguardAddon.Server.BotLoader = function()
    if not FiveguardAddon.Config.DiscordBot then return end

    local botConfig = FiveguardAddon.Config.Bot
    local token, webhook, channelID = botConfig.BotToken, botConfig.WebHook, botConfig.ChannelID

    local validateConfig = function(value, message)
        if value == '' or value == nil or value == "YOUR_BOT_TOKEN" or value == "YOUR_CHANNEL_WEBHOOK_FOR_THE_BOT" or value == "YOUR_DISCORD_CHANNEL_ID_FOR_THE_BOT" then
            print((FiveguardAddon.Config.Language.BotLoader):format(message, value))
            return false
        end
        return true
    end

    if not (validateConfig(token, "Your BotToken") or validateConfig(webhook, "Your WebHook") or validateConfig(channelID, "Your ChannelID")) then
        return
    end

    while true do
        local channel = FiveguardAddon.Server.DiscordRequest("GET", "channels/" .. channelID, {})
        if channel.data then
            local data = json.decode(channel.data)
            local list = data.last_message_id
            local lastmessage = FiveguardAddon.Server.DiscordRequest("GET", "channels/" .. channelID .. "/messages/" .. list, {})

            if not lastmessage then FiveguardAddon.Wait(1000) end
            if lastmessage.data then
                local listdata = json.decode(lastmessage.data)
                local playerdisId = listdata.author.id
                if FiveguardAddon.Server.LastData == nil then
                    FiveguardAddon.Server.LastData = listdata.id
                end

                if FiveguardAddon.Server.LastData ~= listdata.id and listdata.author.username ~= botConfig.ReplyUserName then
                    for _, allowedID in ipairs(botConfig.Allowedusers) do
                        if allowedID == playerdisId then
                            FiveguardAddon.Server.DiscordBot(listdata.content)
                            FiveguardAddon.Server.LastData = listdata.id
                        end
                    end
                end
            end
        end

        FiveguardAddon.Wait(botConfig.WaitEveryTick)
    end
end

FiveguardAddon.Server.Updater = function(oldVersion, newVersion)
    if not FiveguardAddon.Config.Updater then return end

    local invokingResource = GetInvokingResource()
    if not invokingResource then return end

    print((FiveguardAddon.Config.Language.Updater.NewUpdatConsolePrint):format(newVersion))
    print(FiveguardAddon.Config.Language.Updater.ServerRestartConsolePrint)

    local notifyDelay = 1000
    local countdown = FiveguardAddon.Config.Counter

    for _, time in ipairs(countdown) do
        local unit = FiveguardAddon.Config.Language.Seconds
        if time == "1" then
            unit = FiveguardAddon.Config.Language.Second
        end

        TriggerClientEvent('ox_lib:notify', -1, {
            title = "",
            icon = "fa-solid fa-shield-halved",
            description = (FiveguardAddon.Config.Language.Updater.PlayerNotify):format(time, unit),
            position = "top-center"
        })
        FiveguardAddon.Wait(notifyDelay)
    end

    FiveguardAddon.Server.DiscordLog('Fiveguard Addon', (FiveguardAddon.Config.Language.Updater.DiscordLog):format(newVersion), FiveguardAddon.Config.Bot.Color)

    os.exit()
end

FiveguardAddon.Server.BanStop = function(resource)
    FiveguardAddon.Server.BanPlayer(source, string.format(FiveguardAddon.Config.Language.StopBan, resource))
end

FiveguardAddon.Server.ResourceStarter = function(resourceName)
    local name = GetCurrentResourceName()
    if resourceName ~= name then return end

    local CurrentVersion = GetResourceMetadata(name, "version")
    local resourceName = "^0[^4"..name.."^0]"

    PerformHttpRequest('https://raw.githubusercontent.com/UnrealMexd0x/Fiveguard_Addon/main/fxmanifest.lua', function(errorCode, jsonString, headers)
        if not jsonString then 
            print(resourceName .. '^1Update Check failed! ^3Please Update to the latest Version: ^9Download on Github (https://github.com/UnrealMexd0x/Fiveguard_Addon/releases)^0')
            return
        end

        local remoteVersion = string.match(jsonString, "version%s*['\"]([%d%.]+)['\"]")

        if not remoteVersion then
            print(resourceName .. '^1Failed to parse version from remote manifest.^0')
            return
        end

        if CurrentVersion == remoteVersion then
            print(resourceName .. '^2 ✓ Started Correctly^0 - ^5Current Version: ^2' .. CurrentVersion .. '^0')
        else
            print(resourceName .. '^2 ✓ Started Correctly^0 - ^5Current Version: ^2' .. CurrentVersion .. '^0 - ^5Latest Version: ^2' .. remoteVersion .. '^0')
            print(resourceName .. '^1 ✗ Resource Outdated. Please Update!^0 - ^6Download on Github (https://github.com/UnrealMexd0x/Fiveguard_Addon/releases)^0')
        end
    end)
end

FiveguardAddon.CreateThread(FiveguardAddon.Server.BotLoader)

FiveguardAddon.AddEvent('fg:NewUpdate', FiveguardAddon.Server.Updater)
FiveguardAddon.AddEvent('weaponDamageEvent', FiveguardAddon.Server.WeaponEvent)
FiveguardAddon.AddEvent('onServerResourceStart', FiveguardAddon.Server.ResourceStarter)

FiveguardAddon.Register("Fiveguard_Addon:BanPlayerStop", FiveguardAddon.Server.BanStop)

FiveguardAddon.Command(FiveguardAddon.Config.BanCommand, FiveguardAddon.Server.BanCommand, false)
FiveguardAddon.Command(FiveguardAddon.Config.UnbanCommand, FiveguardAddon.Server.UnbanCommand, false)
FiveguardAddon.Command(FiveguardAddon.Config.BanInfoCommand, FiveguardAddon.Server.BanInfoCommand, false)
FiveguardAddon.Command(FiveguardAddon.Config.ScreenshotCommand, FiveguardAddon.Server.ScreenCommand, false)
FiveguardAddon.Command(FiveguardAddon.Config.RecordCommand, FiveguardAddon.Server.RecordCommand, false)
