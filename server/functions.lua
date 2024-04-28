-- V1.4.2 Author UnrealMexd0x

local FiveguardAddon = FiveguardAddon or {}

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
        local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.CommandBanInfo, FiveguardAddon.Config.BanCommand)
        print(msg)
        return
    end

    local targetPlayer = tonumber(args[1])
    local violation = table.concat(args, " ", 2)

    FiveguardAddon.Server.BanPlayer(targetPlayer, violation)
    local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.BanMessage, targetPlayer, violation)
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
        local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.CommandUnbanInfo, FiveguardAddon.Config.UnbanCommand)
        print(msg)
        return
    end

    local BanID = args[1]

    FiveguardAddon.Server.UnbanPlayer(BanID)

    if FiveguardAddon.Server.UnbanWert then
        local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.UnbanTrue, BanID)
        print(msg)
        FiveguardAddon.Server.UnbanWert = nil
    else
        local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.UnbanFalse, BanID)
        print(msg)
    end
end

FiveguardAddon.Server.GetBanInfo = function(BanId)
    return exports[FiveguardAddon.Config.FiveguardName]:GetBanInfoId(BanId)
end

FiveguardAddon.Server.PrintTableInfo = function(title, tbl)
    local result = {}

    local titleMsg = title .. ":"
    table.insert(result, titleMsg)

    for key, value in pairs(tbl) do
        if type(value) == "table" then
            local keyMsg = FiveguardAddon.Shared.Find("  %s:", tostring(key))
            table.insert(result, keyMsg)

            for k, v in pairs(value) do
                local valueMsg = FiveguardAddon.Shared.Find("    %s: %s", tostring(k), tostring(v))
                table.insert(result, valueMsg)
            end
        else
            local keyValueMsg = FiveguardAddon.Shared.Find("  %s: %s", tostring(key), tostring(value))
            table.insert(result, keyValueMsg)
        end
    end

    return result
end

FiveguardAddon.Server.PrintBanInfo = function(banInfo)
    local result = {}

    local banInfoMsg = FiveguardAddon.Config.Language.BanInfos
    table.insert(result, banInfoMsg)

    local fields = {"name", "reason", "steam", "license", "xbl", "discord", "ip"}
    for _, field in ipairs(fields) do
        local fieldMsg = FiveguardAddon.Shared.Find("  %s: %s", field, tostring(banInfo[field]))
        table.insert(result, fieldMsg)
    end

    local manualMsg = FiveguardAddon.Shared.Find("Manuell: %s", tostring(banInfo.manual))
    table.insert(result, manualMsg)

    local tokensResult = FiveguardAddon.Server.PrintTableInfo("Tokens", banInfo.tokens)
    for _, v in ipairs(tokensResult) do
        table.insert(result, v)
    end

    local fgTSResult = FiveguardAddon.Server.PrintTableInfo("FG_TS", banInfo.fg_ts)
    for _, v in ipairs(fgTSResult) do
        table.insert(result, v)
    end

    return result
end

FiveguardAddon.Server.BanInfoCommand = function(playerSource, args)
    if not FiveguardAddon.Server.IsPlayerAdmin(playerSource) then
        print(FiveguardAddon.Config.Language.NoPermission)
        return
    end

    if #args < 1 then
        local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.CommandInfoBan, FiveguardAddon.Config.BanInfoCommand)
        print(msg)
        return
    end

    local BanID = args[1]

    local BanInfo = FiveguardAddon.Server.GetBanInfo(BanID)

    if BanInfo then
        local BanInfo = FiveguardAddon.Server.PrintBanInfo(BanInfo)
        for _, v in ipairs(BanInfo) do
            print(v)
        end
    else
        print(FiveguardAddon.Config.Language.NoBanInfo)
    end
end

FiveguardAddon.Server.ScreenCommand = function(playerSource, args)
    if not FiveguardAddon.Server.IsPlayerAdmin(playerSource) then
        print(FiveguardAddon.Config.Language.NoPermission)
        return
    end

    if #args < 1 then
        local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.CommandScreenshotInfo, FiveguardAddon.Config.ScreenshotCommand)
        print(msg)
        return
    end

    local SpielerID = args[1]

    FiveguardAddon.Server.ScreenPlayer(SpielerID, function(url)
        local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.ScreenshotCreated, url)
        print(msg)
    end)
end

FiveguardAddon.Server.RecordCommand = function(playerSource, args)
    if not FiveguardAddon.Server.IsPlayerAdmin(playerSource) then
        print(FiveguardAddon.Config.Language.NoPermission)
        return
    end

    if #args < 2 then
        local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.CommandRecordInfo, FiveguardAddon.Config.RecordCommand)
        print(msg)
        return
    end

    local SpielerID = args[1]
    local Time = args[2]

    FiveguardAddon.Server.RecordPlayer(SpielerID, Time, function(url)
        local msg = FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.RecordCreated, url)
        print(msg)
    end)
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
        ["Authorization"] = "Bot " .. FiveguardAddon.Config.SV.Bot.BotToken
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
            ["footer"] = { ["text"] = FiveguardAddon.Config.SV.Bot.ReplyUserName }
        }
    }
    PerformHttpRequest(FiveguardAddon.Config.SV.Bot.WebHook, function(err, text, headers) end, 'POST', json.encode({
        username = FiveguardAddon.Config.SV.Bot.ReplyUserName,
        embeds = embed,
        avatar_url = FiveguardAddon.Config.SV.Bot.AvatarURL
    }), { ['Content-Type'] = 'application/json' })
end

FiveguardAddon.Server.String.Starts = function(String, Start)
    return string.sub(String, 1, #Start) == Start
end

FiveguardAddon.Server.DiscordBot = function(command)
    local Config = FiveguardAddon.Config.SV.Bot
    local Username = Config.ReplyUserName
    local Prefix = Config.Prefix
    local Color = Config.Color

    local HelpCommand = Prefix .. FiveguardAddon.Config.HelpCommand
    local UnbanCommand = Prefix .. FiveguardAddon.Config.UnbanCommand
    local BanCommand = Prefix .. FiveguardAddon.Config.BanCommand
    local BanInfoCommand = Prefix .. FiveguardAddon.Config.BanInfoCommand
    local ScreenshotCommand = Prefix .. FiveguardAddon.Config.ScreenshotCommand
    local RecordCommand = Prefix .. FiveguardAddon.Config.RecordCommand

    if FiveguardAddon.Server.String.Starts(command, Prefix) then
        if FiveguardAddon.Server.String.Starts(command, Prefix .. FiveguardAddon.Config.HelpCommand) then
            FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.Info, HelpCommand, UnbanCommand, BanInfoCommand, BanCommand, ScreenshotCommand, RecordCommand), Color)
        elseif FiveguardAddon.Server.String.Starts(command, BanCommand) then
            local _, _, playerId, reason = FiveguardAddon.Shared.Search(command, BanCommand .. "%s+(%S+)%s+(.+)")
            playerId = tonumber(playerId)

            if playerId and reason then
                FiveguardAddon.Server.BanPlayer(playerId, reason)
                FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.BanTrue, playerId, reason), Color)
            else
                FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.BanFalse, BanCommand), Color)
            end
        elseif FiveguardAddon.Server.String.Starts(command, BanInfoCommand) then
            local _, _, banId = FiveguardAddon.Shared.Search(command, BanInfoCommand .. "%s+(%S+)")
            banId = tonumber(banId)

            if banId then
                local BanInfo = FiveguardAddon.Server.GetBanInfo(banId)
                if BanInfo then
                    local banInfoText = string.format(
                        "```md\n# " ..
                        FiveguardAddon.Config.Language.BanInfos ..
                        "\n\n" ..
                        "[Name]: %s\n" ..
                        "[Reason]: %s\n" ..
                        "[Steam]: %s\n" ..
                        "[Lizenz]: %s\n" ..
                        "[XBL]: %s\n" ..
                        "[Discord]: %s\n" ..
                        "[IP]: %s\n" ..
                        "[Manuell]: %s\n\n",
                        BanInfo.name,
                        BanInfo.reason,
                        BanInfo.steam,
                        BanInfo.license,
                        BanInfo.xbl,
                        BanInfo.discord,
                        BanInfo.ip,
                        tostring(BanInfo.manual)
                    )

                    if BanInfo.tokens then
                        banInfoText = banInfoText .. "## Tokens\n\n"
                        for k, v in pairs(BanInfo.tokens) do
                            banInfoText = banInfoText .. string.format("[%s]: %s\n", k, v)
                        end
                    end

                    if BanInfo.fg_ts then
                        banInfoText = banInfoText .. "\n## FG TS\n\n"
                        for k, v in pairs(BanInfo.fg_ts) do
                            banInfoText = banInfoText .. string.format("[%s]: %s\n", k, v)
                        end
                    end

                    banInfoText = banInfoText .. "```"
                    FiveguardAddon.Server.DiscordLog(Username, banInfoText, Color)
                else
                    FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Config.Language.NoBanInfo, Color)
                end
                FiveguardAddon.Server.BanInfo = nil
            else
                FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.BanInfo, BanInfoCommand), Color)
            end        
        elseif FiveguardAddon.Server.String.Starts(command, UnbanCommand) then
            local _, _, banId = FiveguardAddon.Shared.Search(command, UnbanCommand .. "%s+(%S+)")
            banId = tonumber(banId)

            if banId then
                FiveguardAddon.Server.UnbanPlayer(banId)
                FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.UnbanTrue, banId), Color)
            else
                FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.UnbanFalse, UnbanCommand), Color)
            end
        elseif FiveguardAddon.Server.String.Starts(command, ScreenshotCommand) then
            local _, _, playerId = FiveguardAddon.Shared.Search(command, ScreenshotCommand .. "%s+(%S+)")
            playerId = tonumber(playerId)

            if playerId then
                FiveguardAddon.Server.ScreenPlayer(playerId, function(url)
                    FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.ScreenshotTrue, url), Color)
                end)
            else
                FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.ScreenshotFalse, ScreenshotCommand), Color)
            end
        elseif FiveguardAddon.Server.String.Starts(command, RecordCommand) then
            local _, _, playerId, time = FiveguardAddon.Shared.Search(command, RecordCommand .. "%s+(%S+)%s+(%S+)")
            playerId = tonumber(playerId)
            time = tonumber(time)

            if playerId and time then
                FiveguardAddon.Server.RecordPlayer(playerId, time, function(url)
                    FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.RecordTrue, url), Color)
                end)
            else
                FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Bot.RecordFalse, RecordCommand), Color)
            end
        else
            FiveguardAddon.Server.DiscordLog(Username, FiveguardAddon.Config.Language.Bot.CommandNotFound, Color)
        end
    end
end

FiveguardAddon.Server.WeaponEvent = function(playerSource, data)
    if not FiveguardAddon.Config.WeaponEvents then return end

    local player = playerSource
    local weaponType = data.weaponType
    local weaponDamage = data.weaponDamage
    local weaponTiming = data.damageTime
    local silenced = data.silenced

    FiveguardAddon.Config.SV.WeaponCheatDetectionFunction(player, weaponType, weaponDamage, weaponTiming, silenced)
end

FiveguardAddon.Server.BotLoader = function()
    if not FiveguardAddon.Config.DiscordBot then return end

    local botConfig = FiveguardAddon.Config.SV.Bot
    local token, webhook, channelID = botConfig.BotToken, botConfig.WebHook, botConfig.ChannelID

    local validateConfig = function(value, message)
        if value == '' or value == nil or value == "YOUR_BOT_TOKEN" or value == "YOUR_CHANNEL_WEBHOOK_FOR_THE_BOT" or value == "YOUR_DISCORD_CHANNEL_ID_FOR_THE_BOT" then
            print(FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.BotLoader, message, value))

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
            local lastmessage

            if not list then
                FiveguardAddon.Server.DiscordLog('Fiveguard Addon', 'Welcome to the Fiveguard_Addon Discord Bot', FiveguardAddon.Config.SV.Bot.Color)
            else
                lastmessage = FiveguardAddon.Server.DiscordRequest("GET", "channels/" .. channelID .. "/messages/" .. list, {})
            end

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

    print(FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Updater.NewUpdatConsolePrint, newVersion))
    print(FiveguardAddon.Config.Language.Updater.ServerRestartConsolePrint)

    local notifyDelay = 1000
    local countdown = FiveguardAddon.Config.Counter

    for _, time in ipairs(countdown) do
        local unit = FiveguardAddon.Config.Language.Seconds
        if time == "1" then
            unit = FiveguardAddon.Config.Language.Second
        end

        FiveguardAddon.Config.SV.UpdateNotify(FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Updater.PlayerNotify, time, unit))
        FiveguardAddon.Wait(notifyDelay)
    end

    FiveguardAddon.Server.DiscordLog('Fiveguard Addon', FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.Updater.DiscordLog, newVersion), FiveguardAddon.Config.SV.Bot.Color)

    os.exit()
end

FiveguardAddon.Server.BanStop = function(resource)
    FiveguardAddon.Server.BanPlayer(source, FiveguardAddon.Shared.Find(FiveguardAddon.Config.Language.StopBan, resource))
end

FiveguardAddon.Server.ResourceStarter = function(resourceName)
    local name = GetCurrentResourceName()

    if resourceName ~= name then return end

    local CurrentVersion = GetResourceMetadata(name, "version")
    local ResourceName = '^0[^4Fiveguard_Addon^0]'

    if string.find(name, 'Fiveguard') then
        print(ResourceName .. " ^1Please consider changing the resource name to something less obvious, like esx_RANDOMSCRIPTNAME^0.")
    end

    if not CurrentVersion then return end
    if not FiveguardAddon.Config.AddonUpdateInfo then return end

    local VersionAccepted = FiveguardAddon.Shared.Find('%s^2 ✓ Started Correctly^0 - ^5Current Version: ^2%s ^0- ^6(Github (https://github.com/UnrealMexd0x/))^0', ResourceName, CurrentVersion)
    local VersionDenied = FiveguardAddon.Shared.Find('%s^1 ✗ Resource may not Work. Please Contact UnrealMexd0x !^0 - ^6(Github (https://github.com/UnrealMexd0x/)) - ^2(Discord (UnrealMexd0x))^0', ResourceName)
    local VersionOutdated = FiveguardAddon.Shared.Find('%s^1 ✗ Resource Outdated. Please Update!^0 - ^6Download on Github (https://github.com/UnrealMexd0x/Fiveguard_Addon/releases)^0', ResourceName)

    local RequestVersion = function(callback)
        PerformHttpRequest('https://raw.githubusercontent.com/UnrealMexd0x/Fiveguard_Addon/main/fxmanifest.lua', function(errorCode, jsonString, headers)
            if not jsonString or errorCode == 404 then
                callback('error')
                return
            end
            local remoteVersion = string.match(jsonString, "version%s*['\"]([%d%.]+)['\"]")
            callback(remoteVersion)
        end)
    end

    RequestVersion(function(remoteVersion)
        if not FiveguardAddon or next(FiveguardAddon) == nil or remoteVersion == 'error' then
            print(VersionDenied)
        elseif CurrentVersion ~= remoteVersion then
            print(VersionOutdated)
        else
            print(VersionAccepted)
        end
    end)
end

return FiveguardAddon.Server
