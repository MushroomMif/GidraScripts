embed_builder:
    type: world
    debug: false
    events:
        after server start:
        - ~discordconnect id:bot token:<secret[token]>
        # сообщение 1049317239196762145
        # канал 1049316646164123718
        - define msg <discord_message[bot,1049316646164123718,1049317239196762145]>
        - while true:
            - inject get_top_players
            - definemap lines:
                status: "Сервер: <element[**].escaped>🟢Включен<element[**].escaped>"
                players: "Игроки онлайн: <proc[players_online]>"
                advancements_top: "Топ достижений: <[message]>"
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
        - stop if:!<player.is_op>
        - determine FULFILLED passively
        - define msg <discord_message[bot,1049316646164123718,1049317239196762145]>
        - ~discordmessage id:bot edit:<[msg]> <discord_embed.with[color].as[<red>].add_field[Статус сервера].value[⁣Сервер: **🔴Отключен**]>
        - adjust server shutdown
        on restart command:
        - stop if:!<player.is_op>
        - determine FULFILLED passively
        - define msg <discord_message[bot,1049316646164123718,1049317239196762145]>
        - ~discordmessage id:bot edit:<[msg]> <discord_embed.with[color].as[<red>].add_field[Статус сервера].value[⁣<n>Сервер: **🔴Отключен**]>
        - adjust server restart

# На случай пропажи сообщения
send_status_msg:
    type: command
    name: sendmsg
    usage: /sendmsg
    description: da
    script:
    - stop if:!<player.is_op>
    - ~discordmessage id:bot channel:1049316646164123718 <discord_embed.with[color].as[<light_purple>].with[footer].as[da]>