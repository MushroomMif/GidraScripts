# Спавн кастомных стендов после нажатия соотвествующим предметом
stand_with_arms:
    type: world
    debug: false
    events:
        on player right clicks block with:paper:
        - if <proc[is_oraxen_item].context[<player.item_in_hand>|stand_with_arms]>:
            - if ( <context.location.up[1].material.name> == air ) && ( <context.location.up[2].material.name> == air ):
                - spawn <context.location.up[1].center> armor_stand save:stand
                - adjust <entry[stand].spawned_entity> arms:true
                - look <entry[stand].spawned_entity> <player.eye_location>
                - take iteminhand quantity:1 if:!<player.gamemode.equals[creative]>

statuette:
    type: world
    debug: false
    events:
        on player right clicks block with:paper:
        - if <proc[is_oraxen_item].context[<player.item_in_hand>|statuette]>:
            - if ( <context.location.up[1].material.name> == air ) && ( <context.location.up[2].material.name> == air ):
                - spawn <context.location.up[1].center> armor_stand save:stand
                - adjust <entry[stand].spawned_entity> is_small:true
                - look <entry[stand].spawned_entity> <player.eye_location>
                - take iteminhand quantity:1 if:!<player.gamemode.equals[creative]>

statuette_with_arms:
    type: world
    debug: false
    events:
        on player right clicks block with:paper:
        - if <proc[is_oraxen_item].context[<player.item_in_hand>|statuette_with_arms]>:
            - if ( <context.location.up[1].material.name> == air ) && ( <context.location.up[2].material.name> == air ):
                - spawn <context.location.up[1].center> armor_stand save:stand
                - adjust <entry[stand].spawned_entity> is_small:true
                - adjust <entry[stand].spawned_entity> arms:true
                - look <entry[stand].spawned_entity> <player.eye_location>
                - take iteminhand quantity:1 if:!<player.gamemode.equals[creative]>

# Установка позы стенду
# P.S. Плагины используют другой формат позы стендов, а переводить мне было лень, поэтому тут тупо команды с датапака
pose_stand:
    type: task
    debug: false
    definitions: entity|pose
    script:
    - choose <[pose]>:
        - case 1:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Head:[42f,0f,0f],RightArm:[270f,322f,336f]}" silent
        - case 2:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {LeftArm:[0f,0f,0f],RightArm:[0f,0f,0f]}" silent
        - case 3:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Body:[0f,0f,1f],Head:[18f,0f,0f],LeftArm:[340f,24f,0f],RightArm:[289f,339f,0f]}" silent
        - case 4:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Body:[0f,0f,2f],Head:[353f,0f,4f],LeftLeg:[360f,340f,360f],RightLeg:[4f,18f,0f],LeftArm:[13f,342f,353f],RightArm:[303f,18f,0f]}" silent
        - case 5:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Body:[0f,0f,357f],Head:[348f,0f,356f],LeftLeg:[6f,337f,353f],RightLeg:[1f,16f,4f],LeftArm:[13f,0f,354f],RightArm:[248f,69f,0f]}" silent
        - case 6:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Head:[350f,0f,0f],LeftLeg:[6f,337f,353f],RightLeg:[1f,16f,4f],LeftArm:[255f,41f,0f],RightArm:[253f,317f,0f]}" silent
        - case 7:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Head:[350f,0f,0f],LeftLeg:[6f,337f,353f],RightLeg:[1f,16f,4f],LeftArm:[251f,317f,0f],RightArm:[253f,57f,0f]}" silent
        - case 8:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {LeftLeg:[10f,0f,0f],RightLeg:[359f,0f,0f],LeftArm:[23f,0f,0f],RightArm:[289f,318f,353f]}" silent
        - case 9:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Head:[13f,26f,0f],LeftLeg:[345f,317f,0f],RightLeg:[12f,38f,0f],LeftArm:[166f,0f,46f],RightArm:[265f,323f,0f]}" silent
        - case 10:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Head:[0f,0f,356f],LeftLeg:[9f,0f,0f],RightLeg:[323f,0f,0f],LeftArm:[265f,353f,0f],RightArm:[273f,7f,0f]}" silent
        - case 11:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Body:[0f,21f,0f],Head:[350f,34f,0f],LeftLeg:[241f,51f,0f],RightLeg:[0f,15f,345f],LeftArm:[242f,289f,0f],RightArm:[244f,108f,0f]}" silent
        - case 12:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Body:[0f,346f,0f],Head:[350f,331f,0f],LeftLeg:[0f,29f,9f],RightLeg:[244f,304f,0f],LeftArm:[250f,264f,0f],RightArm:[259f,77f,0f]}" silent
        - case 13:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Body:[0f,7f,0f],Head:[353f,69f,0f],LeftLeg:[6f,35f,0f],RightLeg:[4f,336f,0f],LeftArm:[0f,23f,350f],RightArm:[267f,83f,0f]}" silent
        - case 14:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Head:[44f,0f,0f],LeftLeg:[12f,0f,0f],RightLeg:[354f,0f,0f],LeftArm:[46f,325f,0f],RightArm:[48f,43f,0f]}" silent
        - case 15:
            - execute as_server "data modify entity <[entity].uuid> Pose set value {Body:[2f,0f,0f],Head:[346f,0f,0f],LeftLeg:[345f,0f,0f],RightLeg:[16f,0f,0f],LeftArm:[220f,0f,0f],RightArm:[121f,0f,0f]}" silent
        - default:
            - debug ERROR "Неверная поза для стойки"

# Установка позы, кода рядом шифтит игрок
pose_on_shift:
    type: world
    debug: false
    events:
        on player starts sneaking:
        - define entities <player.location.find_entities[armor_stand].within[0.5]>
        - if !<[entities].is_empty>:
            - define entity <[entities].first>
        - else:
            - stop
        - stop if:!<[entity].arms>
        - if !<[entity].has_flag[pose]> || ( <[entity].flag[pose]> == 15 ):
            - flag <[entity]> pose:0
        - flag <[entity]> pose:++
        - run pose_stand def:<[entity]>|<[entity].flag[pose]>

# Запуск проверок на блок под стендом
stands_tick_loop:
    type: world
    debug: false
    events:
        after entity spawns:
        - stop if:!<context.entity.entity_type.equals[armor_stand]>
        - wait 1t
        - stop if:!<context.entity.arms>
        - flag <context.entity> pose:0
        - run stand_tick def:<context.entity>
        after chunk loads entities entity_type:armor_stand:
        - foreach <context.entities> as:entity:
            - if ( <[entity].entity_type> == armor_stand ) && <[entity].arms>:
                - run stand_tick def:<[entity]>

# Собственно сами проверки
stand_tick:
    type: task
    debug: false
    definitions: entity
    script:
    #- while <[entity].location.chunk.is_loaded>:
    - while <[entity].is_spawned>:
        # Проверка на редстоун
        - define material <[entity].location.material>
        - if ( <[material].name> == redstone_wire ) && ( <[material].power> >= 1 ):
            - if <[entity].flag[pose]> != <[material].power>:
                - flag <[entity]> pose:<[material].power>
                - run pose_stand def:<[entity]>|<[entity].flag[pose]>
        # Проверка на магнетит
        - define material <[entity].location.add[0,-1,0].material>
        - if <[material].name> == lodestone:
            - define players <[entity].location.find_entities[player].within[8]>
            - if !<[players].is_empty>:
                - look <[entity]> <[players].first.eye_location>
        - wait 2t

# Выпадением предметов, после ломания кастомного стенда
drop_stand:
    type: world
    debug: true
    events:
        on armor_stand dies:
            - if !<context.entity.arms> && !<context.entity.is_small>:
                - stop
            - define drops <context.drops>
            # Убираем обычный арморстенд из дропа
            - foreach <[drops]> as:item:
                - if <[item].material.name.if_null[null]> == armor_stand:
                    - define drops:<-:<[item]>
            - if <context.damager.gamemode.if_null[null]> == CREATIVE:
                - stop
            # И добавляем кастомный
            - if <context.entity.arms> && !<context.entity.is_small>:
                - determine <[drops].include[<server.flag[stand_with_arms]>]>
            - if !<context.entity.arms> && <context.entity.is_small>:
                - determine <[drops].include[<server.flag[statuette]>]>
            - if <context.entity.arms> && <context.entity.is_small>:
                - determine <[drops].include[<server.flag[statuette_with_arms]>]>