FiveguardAddon.Config.Bot = {
    -- [Discord Developer Portal (https://discord.com/developers/applications/)]
    -- [How to use Discord Developer Portal (Thanks to KlutchxGaming)(https://www.youtube.com/watch?v=zrNloK9b1ro)]

    Color = 8421504,  -- Color for bot messages (Decimal Color Code)

    -- Discord Bot Credentials --
    BotToken = "YOUR_BOT_TOKEN",
    WebHook = "YOUR_CHANNEL_WEBHOOK_FOR_THE_BOT",
    ChannelID = "YOUR_DISCORD_CHANNEL_ID_FOR_THE_BOT",
    ----------------------------

    -- Users Allowed to Interact with the Bot --
    Allowedusers = {
        'YOUR_DISCORD_ID',
    },
    --------------------------------------------

    ReplyUserName = "Fiveguard Addon",  -- Bot's username for replies
    AvatarURL = "https://yt3.googleusercontent.com/AwJhSb3xMJIDmXa3zwJuCxn_WxR3Z6-lW9RXaF5eqz0UT_r9OcB7Ayvf76SJSmIp2IJ2rnzMfQ=s900-c-k-c0x00ffffff-no-rj",  -- Bot's avatar URL
    Prefix = "+",  -- Command prefix for the bot
    WaitEveryTick = 4000  -- Wait time in milliseconds for each bot tick
}

return FiveguardAddon.Config.Bot
