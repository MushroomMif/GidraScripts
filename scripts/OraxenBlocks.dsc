# Когда ставим кастомный блок сверяем его данные со списком блоков из yml файла и даём ему флаг, для дальнейшего взаимодействия
flag_block:
    type: world
    debug: false
    events:
        after player right clicks block with:paper:
        - define material <player.cursor_on.material>
        - if <list[note_block]> contains <[material].name>:
            - foreach <yaml[blocks].read[blocks]>:
                - if ( <[value].get[type]> == <[material].name> ) && ( <[value].get[instrument]> == <[material].instrument> ) && ( <[value].get[note]> == <[material].note> ) && ( <[value].get[powered]> == <[material].switched> ):
                    - flag <player.cursor_on> oraxen_type:<[key]>
        # Убираем флаг, когда блок сломали
        on player breaks note_block:
        - if <context.location.has_flag[oraxen_type]>:
            - flag <context.location> oraxen_type:!
        # Подгружаем данные
        on scripts loaded:
        - ~yaml load:config/blocks.yml id:blocks