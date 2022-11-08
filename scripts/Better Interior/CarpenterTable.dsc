# Открытие меню стола
on_carpenter_block_click:
    type: world
    debug: false
    events:
        on player right clicks note_block:
        - if !<player.is_sneaking> && <context.location.has_flag[oraxen_type]> && ( <context.location.flag[oraxen_type]> == carpenter_table ):
            - opentrades trade[result=armor_stand;inputs=smooth_stone_slab|stick[quantity=6];max_uses=9999]|trade[result=<server.flag[statuette]>;inputs=smooth_stone_slab|stick[quantity=3];max_uses=9999]|trade[result=<server.flag[stand_with_arms]>;inputs=armor_stand|redstone_torch[quantity=2];max_uses=9999]|trade[result=<server.flag[statuette_with_arms]>;inputs=<server.flag[statuette]>|redstone_torch;max_uses=9999] "title:Столярный верстак"

# Возможность крафтить стол из шлюбых досок
carpenter_table:
    type: item
    debug: false
    material: paper
    mechanisms:
        raw_nbt: <server.flag[carpenter_table_nbt]>
    recipes:
        1:
            type: shaped
            recipe_id: carpenter_table
            input:
            - material:stick|material:stick
            - material:*_planks|material:*_planks
            - material:*_planks|material:*_planks
    no_id: true