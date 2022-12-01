players_online:
    type: procedure
    debug: false
    script:
    - if <server.online_players.size> == 0:
        - determine **0**
    - else:
        - define player_list <list>
        - foreach <server.online_players> as:__player:
            - define player_list:->:<player.name>
        - determine "**<server.online_players.size> (<[player_list].comma_separated>)**"

next_restart_time:
    type: world
    debug: false
    events:
        on server start:
        - flag server next_restart_in:<util.time_now.add[6h].format_discord[R]>

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
    - foreach <server.players> as:__player:
        - foreach next if:!<player.has_flag[bac_score]>
        - define advancements_top <[advancements_top].with[<player.name>].as[<player.flag[bac_score]>]>
    - define advancements_top <[advancements_top].sort_by_value[mul[-1]]>
    - define first <[advancements_top].keys.get[1]>
    - define second <[advancements_top].keys.get[2]>
    - define third <[advancements_top].keys.get[3]>
    - define message "<element[**].escaped><[first]> (<[advancements_top].get[<[first]>]>), <[second]> (<[advancements_top].get[<[second]>]>), <[third]> (<[advancements_top].get[<[third]>]>)<element[**].escaped>"
