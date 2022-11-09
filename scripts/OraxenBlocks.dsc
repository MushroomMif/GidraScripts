# Когда ставим кастомный блок получаем его айди из предмета и даём ему флаг, для дальнейшего взаимодействия
flag_block:
    type: world
    debug: false
    events:
        after player right clicks block with:paper:
        - if <player.cursor_on.material.name> == note_block:
            - define id <context.item.raw_nbt.get[PublicBukkitValues].get[oraxen:id].replace_text[string:].if_null[null]>
            - flag <player.cursor_on> oraxen_type:<[id]>
        # Убираем флаг, когда блок сломали
        on player breaks note_block:
        - if <context.location.has_flag[oraxen_type]>:
            - flag <context.location> oraxen_type:!
        # Подгружаем данные
        on scripts loaded:
        - ~yaml load:config/blocks.yml id:blocks