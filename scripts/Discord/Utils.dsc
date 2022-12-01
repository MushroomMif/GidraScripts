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