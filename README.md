## **Fiveguard Addon**

This script serves as an addon for FiveM, enhancing the functionality of the Fiveguard Anticheat system.

[🛡️ **A Touch of Security:** With Fiveguard by your side, you can sit back and relax, knowing your players are safe and sound. This anticheat acts like the faithful guardian of your servers, diligently watching every move and bringing a smile to your community's face. Say goodbye to cheating woes and welcome Fiveguard!](https://fiveguard.net)

## Description

Fiveguard Anticheat is a powerful tool for maintaining server integrity and ensuring fair play within the FiveM multiplayer framework. However, even the most robust systems can benefit from additional enhancements. This addon script aims to complement the capabilities of Fiveguard Anticheat by providing extra features.

## Installation

1. Ensure you have Fiveguard Anticheat installed and configured on your FiveM server.
2. Download the latest release of the Fiveguard Addon script from the [GitHub repository](https://github.com/UnrealMexd0x/Fiveguard_Addon).
3. Place the downloaded script into the `resources` directory of your FiveM server.
4. Add `start Fiveguard_Addon` to your `server.cfg` file to ensure the addon script is loaded on server startup.
5. Restart your FiveM server.

## Requirements

#### [Fiveguard](https://fiveguard.net)
#### [ox_lib](https://github.com/overextended/ox_lib)

## Configuration

### Shared Configuration (`sh_config.lua`)

```lua
FiveguardAddon = {
    Config = {
        FiveguardName = "YOUR_ANTICHEATNAME",                                   -- Fiveguard Resource Name
        FiveguardAce = 'command.fiveguard',                                     -- Player Command Ace [https://docs.fivem.net/natives/?_0xDEDAE23]

        Updater = true,                                                         -- Enable the Fiveguard Updater 
        Counter = { "10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0" },   -- Update Counter

        DiscordBot = true,                                                      -- Enable the Fiveguard Discord Bot

        WeaponEvents = true,                                                    -- Blocks Various Cheat used Weapon Events

        HelpCommand = "help",                                                   -- Help Command

        BanInfoCommand = "baninfo",                                             -- Baninfo Command (Bot and Ingame Command)
        BanCommand = "fgban",                                                   -- Ban Command (Bot and Ingame Command)
        UnbanCommand = "fgunban",                                               -- Unban Command (Bot and Ingame Command)
        ScreenshotCommand = "fgscreenshot",                                     -- Screenshot Command (Bot and Ingame Command)
        RecordCommand = "fgrecord",                                             -- Record Command (Bot and Ingame Command)

        SendToLogs = true,                                                      -- Send to Fiveguard Discord Logs
        IgnoreStaticPermission = true,                                          -- Ignore Group Permissions

        Language = {
            -- Your language configuration here
        },
    },
}
```

### Server-side Configuration (`sv_config.lua`)

[Discord Developer Portal](https://discord.com/developers/applications/)

[How to use Discord Developer Portal (Thanks to KlutchxGaming)](https://www.youtube.com/watch?v=zrNloK9b1ro)
```lua
FiveguardAddon.Config.SV.Bot = {
    Color = 8421504,  -- Color for bot messages

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
```

## Usage

Once installed and configured, the addon script seamlessly integrates with Fiveguard Anticheat, enhancing its functionality without requiring any additional user intervention. Simply ensure that both Fiveguard Anticheat and the addon script are running on your FiveM server, and enjoy enhanced protection against cheats and exploits.

## Contributing

Contributions to the development and improvement of the Fiveguard Addon script are welcome! If you have suggestions, bug reports, or feature requests, please feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/UnrealMexd0x/Fiveguard_Addon).

## License

This addon script is released under the [MIT License](LICENSE), allowing for free use, modification, and distribution subject to the terms and conditions outlined in the license.

## Disclaimer

While every effort has been made to ensure the effectiveness and reliability of the addon script, no system can guarantee complete immunity against cheats and exploits. Server administrators are advised to use Fiveguard Addon as part of a comprehensive anticheat strategy, which may include other tools and measures to maximize server integrity and fair play.

### 1.4.1