light_block:
    type: item
    material: light
    recipes:
        1:
            type: shaped
            recipe_id: light
            output_quantity: 4
            input:
            - *_pane|redstone_lamp|*_pane
            - soul_lantern|iron_nugget|lantern
            - *_pane|jack_o_lantern|*_pane

light_gui:
    type: inventory
    debug: false
    inventory: chest
    title: Настройка света
    size: 45
    gui: true
    slots:
    - [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane]
    - [white_stained_glass_pane] [] [] [] [] [] [] [] [white_stained_glass_pane]
    - [white_stained_glass_pane] [] [] [] [] [] [] [] [white_stained_glass_pane]
    - [white_stained_glass_pane] [] [] [] [] [] [] [] [white_stained_glass_pane]
    - [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane] [white_stained_glass_pane]

light_icon:
    type: item
    debug: false
    material: light
    display name: <red>Уровень света
    lore:
    - <yellow>Нажмите, чтобы выбрать уровень света

light_menu:
    type: world
    debug: false
    events:
        on player right clicks air with:light:
        - inventory open d:light_gui
        - repeat 16 from:0 as:level:
            - give <item[light_icon].with[block_material=<material[light[level=<[level]>]]>]> to:<player.open_inventory>
        on player clicks light_icon in light_gui:
        - define quantity <player.item_in_hand.quantity>
        - take iteminhand quantity:<player.item_in_hand.quantity>
        - give light[block_material=light[level=<context.item.block_material.level>;waterlogged=false]] slot:<player.held_item_slot> quantity:<[quantity]>
        - narrate "ꐰ <green>Уровень света успешно изменён"