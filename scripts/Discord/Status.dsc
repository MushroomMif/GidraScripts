embed_builder:
    type: world
    debug: false
    events:
        after server start:
        - ~discordconnect id:bot token:<secret[token]>
        # сообщение 1046809330260918372
        # канал 1045686072811728986
        - define msg <discord_message[bot,1045686072811728986,1046809330260918372]>
        - while true:
            - definemap lines:
                status: "Сервер: <element[**].escaped>🟢Включен<element[**].escaped>"
                players: "Игроки онлайн: <proc[players_online]>"
                next_restart: "Следующий рестарт: <element[**].escaped><static[<server.flag[next_restart_in]>]><element[**].escaped>"
            - define field_content ""
            - foreach <[lines]> as:line:
                - define field_content <[field_content]><n><[line]>
            - ~discordmessage id:bot edit:<[msg]> <discord_embed.with[color].as[<green>].add_field[Статус сервера].value[⁣<n><[field_content]>]>
            - wait 15s

embed_on_shutdown:
    type: world
    debug: false
    events:
        on stop command:
        - determine FULFILLED passively
        - define msg <discord_message[bot,1045686072811728986,1046809330260918372]>
        - ~discordmessage id:bot edit:<[msg]> <discord_embed.with[color].as[<red>].add_field[Статус сервера].value[⁣Сервер: **🔴Отключен**]>
        - adjust server shutdown
        on restart command:
        - determine FULFILLED passively
        - define msg <discord_message[bot,1045686072811728986,1046809330260918372]>
        - ~discordmessage id:bot edit:<[msg]> <discord_embed.with[color].as[<red>].add_field[Статус сервера].value[⁣<n>Сервер: **🔴Отключен**]>
        - adjust server restart