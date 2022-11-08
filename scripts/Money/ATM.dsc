atm_gui:
    type: inventory
    inventory: chest
    title: Банкомат
    size: 27
    gui: true
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [bronze_coin_icon] [] [silver_coin_icon] [] [gold_coin_icon] [] []
    - [] [] [] [] [] [] [] [] []

bronze_coin_icon:
    type: item
    material: acacia_button
    display name: <&color[#cd7f32]>Бронзовая монета
    lore:
    - <dark_gray>Нажмите <green>ЛКМ<dark_gray>,
    - <dark_gray>чтобы получить <red>64<dark_gray> <&color[#cd7f32]>бронзовых монет
    - <dark_gray>в обмен на 1 серебряную
    enchantments:
    - luck:1
    mechanisms:
        hides: ALL

silver_coin_icon:
    type: item
    material: iron_nugget
    display name: <&color[#738595]>Серебряная монета
    lore:
    - <dark_gray>Нажмите <green>ЛКМ<dark_gray>,
    - <dark_gray>чтобы получить <red>64<dark_gray> <&color[#738595]>серебряных монет
    - <dark_gray>в обмен на 1 золотую
    - <dark_gray>
    - <dark_gray>Нажмите <green>ПКМ<dark_gray>,
    - <dark_gray>чтобы получить <red>1<dark_gray> <&color[#738595]>серебряную монету
    - <dark_gray>в обмен на 64 бронзовых
    - <dark_gray>
    - <dark_gray>Нажмите <green>ШИФТ+ПКМ<dark_gray>,
    - <dark_gray>чтобы получить <red>1<dark_gray> <&color[#738595]>серебряную монету
    - <dark_gray>в обмен на 1 алмаз
    enchantments:
    - luck:1
    mechanisms:
        hides: ALL

gold_coin_icon:
    type: item
    material: gold_nugget
    display name: <&color[#ffd700]>Золотая монета
    lore:
    - <dark_gray>Нажмите <green>ПКМ<dark_gray>,
    - <dark_gray>чтобы получить <red>1<dark_gray> <&color[#ffd700]>золотую монету
    - <dark_gray>в обмен на 64 серебрянных
    enchantments:
    - luck:1
    mechanisms:
        hides: ALL

atm_cmd:
    type: command
    name: atm
    usage: /atm
    description: Открывает банкомат
    script:
    - stop if:!<player.is_op>
    - inventory open d:atm_gui

atm_gui_click:
    type: world
    debug: false
    events:
        on player clicks bronze_coin_icon in atm_gui:
        # Бронзовые в обмен на серебро
        - if <context.click> == LEFT:
            - if <player.inventory.contains_item[silver_coin]>:
                - if <player.inventory.can_fit[bronze_coin].quantity[64]>:
                    - take item:silver_coin quantity:1
                    - give bronze_coin quantity:64
                    - narrate "<green>Обмен проведён успшено"
                - else:
                    - narrate "<red>В вашем инвентаре недостаточно места"
            - else:
                - narrate "<red>Недостаточно предметов"
        on player clicks silver_coin_icon in atm_gui:
        # Серебряные в обмен на золото
        - if <context.click> == LEFT:
            - if <player.inventory.contains_item[gold_coin]>:
                - if <player.inventory.can_fit[silver_coin].quantity[64]>:
                    - take item:gold_coin quantity:1
                    - give silver_coin quantity:64
                    - narrate "<green>Обмен проведён успшено"
                - else:
                    - narrate "<red>В вашем инвентаре недостаточно места"
            - else:
                - narrate "<red>Недостаточно предметов"
        # Серебряные в обмен на бронзу
        - else if <context.click> == RIGHT :
            - if <player.inventory.contains_item[bronze_coin].quantity[64]>:
                - if <player.inventory.can_fit[silver_coin].quantity[1]>:
                    - take item:bronze_coin quantity:64
                    - give silver_coin quantity:1
                    - narrate "<green>Обмен проведён успшено"
                - else:
                    - narrate "<red>В вашем инвентаре недостаточно места"
            - else:
                - narrate "<red>Недостаточно предметов"
        # Серебряные в обмен на алмаз
        - else if <context.click> == SHIFT_RIGHT:
            - if <player.inventory.contains_item[diamond].quantity[1]>:
                - if <player.inventory.can_fit[silver_coin].quantity[1]>:
                    - take item:diamond quantity:1
                    - give silver_coin quantity:1
                    - narrate "<green>Обмен проведён успшено"
                - else:
                    - narrate "<red>В вашем инвентаре недостаточно места"
            - else:
                - narrate "<red>Недостаточно предметов"
        on player clicks gold_coin_icon in atm_gui:
        # Золотые в обмен на серебро
        - if <context.click> == RIGHT:
            - if <player.inventory.contains_item[silver_coin].quantity[64]>:
                - if <player.inventory.can_fit[gold_coin].quantity[1]>:
                    - take item:silver_coin quantity:64
                    - give gold_coin quantity:1
                    - narrate "<green>Обмен проведён успшено"
                - else:
                    - narrate "<red>В вашем инвентаре недостаточно места"
            - else:
                - narrate "<red>Недостаточно предметов"

atm_gui_open:
    type: world
    debug: false
    events:
        on player right clicks npc:
        - if <npc.name> == Банкир:
            - inventory open d:atm_gui