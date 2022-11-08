load_bossbar_data:
    type: world
    debug: false
    events:
        on scripts loaded:
        - yaml load:/config/bossbar.yml id:bossbar

show_bossbar:
    type: world
    debug: false
    events:
        on player join:
        - bossbar create <player.name>_infobar players:<player> title:<&sp> progress:1 color:white style:solid
        - while <player.is_online>:
            - define bar_titles <yaml[bossbar].read[info_bar].if_null[<list[&cОшибка]>]>
            - define cooldown <yaml[bossbar].read[info_cooldown].if_null[5s]>
            - foreach <[bar_titles]> as:title:
                - if !<player.is_online>:
                    - foreach stop
                - bossbar update <player.name>_infobar title:<[title].parse_color>
                - wait <[cooldown]>
        on player quit:
        - bossbar remove <player.name>_infobar