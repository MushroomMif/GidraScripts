teleport_item:
    type: item
    debug: false
    material: purple_dye
    display name: <dark_purple><bold>Телепортер
    enchantments:
    - luck_of_the_sea:1
    mechanisms:
        hides: ALL
    allow in material recipes: false
    recipes:
        1:
            type: shaped
            recipe_id: teleporter
            input:
            - material:crying_obsidian|material:ender_pearl|material:crying_obsidian
            - material:crying_obsidian|material:amethyst_shard|material:crying_obsidian
            - material:crying_obsidian|material:crying_obsidian|material:crying_obsidian

teleport_gui:
    type: inventory
    inventory: chest
    size: 27
    gui: true
    title: Телепорт

teleport_logic:
    type: world
    debug: false
    events:
        # on server prestart:
        # - flag server teleport_requests:<map>
        on player join:
        - flag <player> tp_ruqests:<list>
        # Открытие меню
        on player right clicks block with:teleport_item:
        # Если у игрока есть кулдаун
        - if <player.has_flag[cant_tp]>:
            - if <player.has_flag[used_pearl]>:
                - narrate "<red>Вы сможете воспользоваться телепортером через <yellow><player.flag[cant_tp]> <red>секунд."
            - else:
                - clickable for:<player> until:300s save:use_pearl:
                    - stop if:<player.has_flag[used_pearl]>
                    - playsound <player> sound:UI_BUTTON_CLICK
                    - if <player.inventory.contains_item[ender_pearl]>:
                        - take item:ender_pearl quantity:1 from:<player.inventory>
                        - narrate "ꐰ <green>Успешно"
                        - playsound <player> sound:ENTITY_ENDER_EYE_LAUNCH
                        - flag <player> cant_tp:-:240
                        - flag <player> used_pearl:true
                    - else:
                        - narrate "ꐮ <red>Недостаточно предметов."
                - narrate "<red>Вы сможете воспользоваться телепортером через <yellow><player.flag[cant_tp]> <red>секунд. <element[<dark_purple><&lb>ИСПОЛЬЗОВАТЬ ЖЕМЧУГ ЭНДЕРА<&rb>].on_click[<entry[use_pearl].command>].on_hover[<element[Нажмите, чтобы потратить жемчуг эндера<n>и уменьшить кулдаун на <yellow>240 <&r>секунд]>]>"
            - stop
        # Если нет
        - inventory open d:teleport_gui
        - foreach <server.online_players> as:target:
            - if <[target].inventory.contains_item[teleport_item]>:
                - give <item[player_head].with[skull_skin=<[target].name>;display=<red><[target].name>;lore=<list[<dark_gray>Нажми <green>ЛКМ<dark_gray>, чтобы|<dark_gray>телепортироваться к <red><[target].name>]>].with_flag[target:<[target]>]> to:<player.open_inventory>
        # Запрос на телепорт к кому-то
        on player left clicks player_head in teleport_gui:
        - if <context.raw_slot> > 27:
            - stop
        - define target <context.item.flag[target]>
        - playsound <player> sound:UI_BUTTON_CLICK
        - if <server.online_players> contains <[target]>:
            - define sender <player>
            - if <[sender].has_flag[cant_send_to_<[target].name>]>:
                - narrate "ꐮ <red>Вы не можете отправлять запросы так часто"
                - stop
            # Когда приняли тп
            - clickable usages:1 for:<[target]> until:60s save:accept:
                - if !<[sender].is_online>:
                    - narrate "ꐮ <red>Игрок оффлайн" targets:<[target]>
                    - stop
                - inventory close player:<[sender]>
                - flag <[sender]> cant_tp:300
                # Отменить все другие запросы
                - foreach <[sender].flag[tp_requests]> as:id:
                    - clickable cancel:<[id]>
                - flag <[sender]> tp_requests:<list>
                # — — — — — — — — — — — — — —
                - narrate "ꐰ <green>Вы приняли запрос на телепортацию, <red><[sender].name> <green>будет телепортирован к вам через <red>3 <green>секунды." targets:<[target]>
                - playsound <[target]> sound:UI_BUTTON_CLICK
                - narrate "ꐰ <red><[target].name> <green>принял запрос на телепортацию, вы будете телепортированы к нему через <red>3 <green>секунды." targets:<[sender]>
                - playsound <[sender]> sound:entity_arrow_hit_player
                - wait 3s
                - if !<[target].is_online>:
                    - narrate "ꐮ <red>Игрок оффлайн" targets:<[sender]>
                    - flag <[sender]> cant_tp:!
                    - stop
                - if !<[sender].is_online>:
                    - narrate "ꐮ <red>Игрок оффлайн" targets:<[target]>
                    - stop
                - playsound <[sender].location> sound:ENTITY_ENDERMAN_TELEPORT
                - playeffect at:<[sender].eye_location> effect:PORTAL quantity:50 offset:0.15
                - teleport <[sender]> <[target].location>
                - playsound <[target].location> sound:ENTITY_ENDERMAN_TELEPORT
                - playeffect at:<[target].eye_location> effect:PORTAL quantity:50 offset:0.15
                # Кулдаун телепорта
                - while <[sender].flag[cant_tp]> > 0:
                    - flag <[sender]> cant_tp:--
                    - wait 1s
                - flag <[sender]> cant_tp:!
                - flag <[sender]> used_pearl:! if:<[sender].has_flag[used_pearl]>
            # Когда отправили запрос
            - flag <[sender]> cant_send_to_<[target].name> expire:60s
            - narrate "ꐯ <red><[sender].name> <gold>отправил вам запрос на телепортацию. <green><element[<&lb>ПРИНЯТЬ<&rb>].on_click[<entry[accept].command>].on_hover[<element[Нажмите, чтобы принять запрос]>]>" targets:<[target]>
            - playsound <[target]> sound:UI_TOAST_IN
            - flag <[sender]> tp_requests:->:<entry[accept].id>
        - else:
            - narrate "ꐮ <red>Игрок оффлайн"