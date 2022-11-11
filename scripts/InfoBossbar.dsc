# Подгрузка данных из yml файла
load_bossbar_data:
    type: world
    debug: false
    events:
        on scripts loaded:
        - yaml load:/config/bossbar.yml id:bossbar

# Добавление/удаление боссбара при входе и выходе, если он включен
infobar_on_login:
    type: world
    debug: false
    events:
        on player join:
        - run show_infobar if:!<player.has_flag[no_infobar]>
        on player quit:
        - bossbar remove <player.name>_infobar if:!<player.has_flag[no_infobar]>

# Показ боссбара на основе данных
show_infobar:
    type: task
    debug: false
    script:
    - bossbar create <player.name>_infobar players:<player> title:<&sp> progress:1 color:white style:solid
    - while <player.is_online> && !<player.has_flag[no_infobar]>:
        - define bar_titles <yaml[bossbar].read[info_bar].if_null[<list[<red>Ошибка]>]>
        - define cooldown <yaml[bossbar].read[info_cooldown].if_null[5s]>
        - foreach <[bar_titles]> as:title:
            - if !<player.is_online> || <player.has_flag[no_infobar]>:
                - stop
            - bossbar update <player.name>_infobar title:<[title].parse_minimessage>
            - wait <[cooldown]>

# Команда для включения/выключение информационного боссбара
infobar_cmd:
    type: command
    debug: false
    name: infobar
    usage: /infobar
    description: Включить/выключить информационный боссбар
    script:
    - if <player.has_flag[no_infobar]>:
        - flag <player> no_infobar:!
        - run show_infobar
        - narrate "<&r>Теперь вы <green>видите <&r>информационный боссбар."
    - else:
        - flag <player> no_infobar:true
        - bossbar remove <player.name>_infobar
        - narrate "<&r>Теперь вы <red>не видите <&r>информационный боссбар."