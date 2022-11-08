# Регистрация монет
bronze_coin:
    type: item
    material: acacia_button
    display name: <&color[#cd7f32]>Бронзовая монета
    lore:
    - <&color[#cd7f32]>Данный предмет является
    - <&color[#cd7f32]>средством оплаты
    enchantments:
    - luck:1
    mechanisms:
        hides: ALL

silver_coin:
    type: item
    material: iron_nugget
    display name: <&color[#738595]>Серебряная монета
    lore:
    - <&color[#738595]>Данный предмет является
    - <&color[#738595]>средством оплаты
    enchantments:
    - luck:1
    mechanisms:
        hides: ALL

gold_coin:
    type: item
    material: gold_nugget
    display name: <&color[#ffd700]>Золотая монета
    lore:
    - <&color[#ffd700]>Данный предмет является
    - <&color[#ffd700]>средством оплаты
    enchantments:
    - luck:1
    mechanisms:
        hides: ALL

# Запрет ставить бронзовую монету, т.к. она кнопка
prevent_bronze_coin_place:
    type: world
    debug: false
    events:
        on player places acacia_button:
        - if <context.item_in_hand.with[quantity=1]> == <item[bronze_coin]>:
            - determine cancelled


#TODO: Предотвращать переименование монет
# prevent_coin_rename:
#     type: world
#     debug: true
#     events:
#         on player prepares anvil craft item:
#         - stop if:<context.item.hides.if_null[null].equals[null]>
#         - narrate <context.item.hides>
#         - if <context.item.hides> contains ENCHANTS:
#             - determine cancelled