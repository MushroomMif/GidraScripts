# Когда ставим кастомный блок получаем его айди из предмета и даём ему флаг, для дальнейшего взаимодействия
flag_block:
    type: world
    debug: false
    events:
        after player right clicks block with:shulker_shell ignorecancelled:true bukkit_priority:HIGHEST:
        - if <player.cursor_on.material.name> in <list[note_block|red_mushroom_block|brown_mushroom_block]>:
            - define id <context.item.all_raw_nbt.get[nova].get[id].replace_text[string:]||null>
            - stop if:<[id].equals[null]>
            - flag <player.cursor_on> custom_id:<[id]>
        # Убираем флаг, когда блок сломали
        on player breaks note_block|red_mushroom_block|brown_mushroom_block ignorecancelled:true bukkit_priority:HIGHEST:
        - if <context.location.has_flag[custom_id]>:
            - flag <context.location> custom_id:!