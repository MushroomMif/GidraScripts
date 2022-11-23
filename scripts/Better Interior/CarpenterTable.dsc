# Открытие меню стола
on_carpenter_block_click:
    type: world
    debug: false
    events:
        on player right clicks note_block|red_mushroom_block|brown_mushroom_block:
        - if !<player.is_sneaking> && <context.location.has_flag[custom_id]> && ( <context.location.flag[custom_id]> == betterinterior:carpenter_table ):
            #- opentrades trade[result=armor_stand;inputs=smooth_stone_slab|stick[quantity=6];max_uses=9999]|trade[result=<server.flag[statuette]>;inputs=smooth_stone_slab|stick[quantity=3];max_uses=9999]|trade[result=<server.flag[stand_with_arms]>;inputs=armor_stand|redstone_torch[quantity=2];max_uses=9999]|trade[result=<server.flag[statuette_with_arms]>;inputs=<server.flag[statuette]>|redstone_torch;max_uses=9999] "title:Столярный верстак"
            - opentrades <static[<yaml[trades].read[Столярный-Верстак].proc[generate_trades]>]> "title:Столярный верстак"