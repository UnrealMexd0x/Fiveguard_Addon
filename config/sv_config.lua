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

    WeaponCheatDetectionFunction = function(player, weapon, damage, timing, silenced)
        if weapon == 133987706 and (timing > 200000 and damage > 200) then
            FiveguardAddon.Server.BanPlayer(player, "Skript.gg (Anti Kill) [Fiveguard_Addon]")
            CancelEvent()
        elseif silenced and damage == 0 then
            if weapon == 2725352035 then
                FiveguardAddon.Server.BanPlayer(player, "Skript.gg (Edging) (1) [Fiveguard_Addon]")
            elseif weapon == 3452007600 then
                FiveguardAddon.Server.BanPlayer(player, "Skript.gg (Edging) (2) [Fiveguard_Addon]")
            end
            CancelEvent()
        elseif not silenced and damage == 131071 and weapon == 1834887169 then
            FiveguardAddon.Server.BanPlayer(player, "Skript.gg (Edging) (3) [Fiveguard_Addon]")
            CancelEvent()
        elseif weapon == 133987706 then
            CancelEvent()
        end
    end
}

return FiveguardAddon.Config.SV
