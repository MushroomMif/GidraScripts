players_online:
    type: procedure
    debug: false
    script:
    - define real_online_players <server.online_players>
    - foreach <server.online_players> as:__player:
        - if <player.name.contains_text[Bot]>:
            - define real_online_players:<-:<player>
    - if <[real_online_players].size> == 0:
        - determine **0**
    - else:
        - define name_list <list>
        - foreach <[real_online_players]> as:__player:
            - define name_list:->:<player.name>
        - determine "**<[real_online_players].size> (<[name_list].comma_separated>)**"

next_restart_time:
    type: world
    debug: false
    events:
        on server start:
        # Высчитываем время рестарта
        - define first <util.time_now.start_of_day.add[6h]>
        - define second <util.time_now.start_of_day.add[12h]>
        - define third <util.time_now.start_of_day.add[18h]>
        - define fourth <util.time_now.start_of_day.add[24h]>
        # Проверяем сколько сейчас времени
        - if <util.time_now.format_discord.replace[regex:[<&lt>t:, <&gt>]]> <= <[first].format_discord.replace[regex:[<&lt>t:, <&gt>]]>:
            - define restart_time <[first]>
        - else if <util.time_now.format_discord.replace[regex:[<&lt>t:, <&gt>]]> <= <[second].format_discord.replace[regex:[<&lt>t:, <&gt>]]>:
            - define restart_time <[second]>
        - else if <util.time_now.format_discord.replace[regex:[<&lt>t:, <&gt>]]> <= <[third].format_discord.replace[regex:[<&lt>t:, <&gt>]]>:
            - define restart_time <[third]>
        - else:
            - define restart_time <[fourth]>
        # Ставим нужно время в флаг
        - flag server next_restart_in:<[restart_time].format_discord[R]>

flag_advancements:
    type: world
    debug: false
    events:
        on player receives message:
        - if <context.message.starts_with[advancements:]>:
            - define data <context.message.replace_text[advancements:].split[:]>
            - if <[data].size> < 2:
                - determine cancelled passively
                - stop
            - define player_name <[data].get[1]>
            - define score <[data].get[2]>
            - if !<[score].is_integer>:
                - determine passively cancelled
                - stop
            - flag <server.match_offline_player[<[player_name]>]> bac_score:<[score]>
            - determine cancelled

get_top_players:
    type: task
    debug: false
    script:
    - define real_players <server.players>
    - foreach <server.players> as:__player:
        - if <player.name.contains_text[Bot]>:
            - define real_players:<-:<player>
    - foreach <[real_players]> as:__player:
        - if <server.online_players.is_empty>:
            - foreach stop
        - define random_player <server.online_players.random>
        - execute as_server "tellraw <[random_player].name> {"text":"advancements:<player.name>:","extra":[{"score":{"name":"<player.name>","objective":"bac_advancements"}}]}"
    - wait 1s
    - define advancements_top <map>
    - foreach <[real_players]> as:__player:
        - foreach next if:!<player.has_flag[bac_score]>
        - define advancements_top <[advancements_top].with[<player.name>].as[<player.flag[bac_score]>]>
    - define advancements_top <[advancements_top].sort_by_value[mul[-1]]>
    - if <[advancements_top].size> < 3:
        - define message Ошибка
        - goto stop
    - define first <[advancements_top].keys.get[1]>
    - define second <[advancements_top].keys.get[2]>
    - define third <[advancements_top].keys.get[3]>
    - define message "<element[**].escaped><[first]> (<[advancements_top].get[<[first]>]>), <[second]> (<[advancements_top].get[<[second]>]>), <[third]> (<[advancements_top].get[<[third]>]>)<element[**].escaped>"
    - mark stop
