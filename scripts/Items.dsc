ancient_chest:
    type: item
    debug: false
    material: chest
    display name: <&3>Древний сундук
    lore:
    - <&3>
    - <&3>Этот сундук хранит в себе
    - <&3>вещи из древнего города
    - <&3>
    flags:
        loot_table: chests/ancient_city

jungle_chest:
    type: item
    debug: false
    material: chest
    display name: <dark_green>Сундук джунглей
    lore:
    - <dark_green>
    - <dark_green>Этот сундук хранит в себе
    - <dark_green>вещи из храма джунглей
    - <dark_green>
    flags:
        loot_table: chests/jungle_temple

earth_painting:
    type: item
    debug: false
    material: painting
    display name: <white>Земля
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После снятия картины
    - <red>она станет обычной
    - <red>
    mechanisms:
        raw_nbt: <map[EntityTag=<map[variant=string:earth]>]>

wind_painting:
    type: item
    debug: false
    material: painting
    display name: <white>Ветер
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После снятия картины
    - <red>она станет обычной
    - <red>
    mechanisms:
        raw_nbt: <map[EntityTag=<map[variant=string:wind]>]>

water_painting:
    type: item
    debug: false
    material: painting
    display name: <white>Вода
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После снятия картины
    - <red>она станет обычной
    - <red>
    mechanisms:
        raw_nbt: <map[EntityTag=<map[variant=string:water]>]>

fire_painting:
    type: item
    debug: false
    material: painting
    display name: <white>Огонь
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После снятия картины
    - <red>она станет обычной
    - <red>
    mechanisms:
        raw_nbt: <map[EntityTag=<map[variant=string:fire]>]>

lit_redstone_lamp:
    type: item
    debug: false
    material: redstone_lamp
    display name: <gold>Зажжённый редстоуновый фонарь
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После обновления близлежащего блока
    - <red>или уничтожения фонаря
    - <red>он станет обычным
    - <red>
    flags:
        switch: true

lit_furnace:
    type: item
    debug: false
    material: furnace
    display name: <gold>Зажжённая печь
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После попытки переплавить предмет
    - <red>или уничтожения блока
    - <red>он станет обычным
    - <red>
    flags:
        switch: true

lit_smoker:
    type: item
    debug: false
    material: smoker
    display name: <gold>Зажжённая коптильня
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После попытки переплавить предмет
    - <red>или уничтожения блока
    - <red>он станет обычным
    - <red>
    flags:
        switch: true

lit_blast_furnace:
    type: item
    debug: false
    material: blast_furnace
    display name: <gold>Зажжённая плавильная печь
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После попытки переплавить предмет
    - <red>или уничтожения блока
    - <red>он станет обычным
    - <red>
    flags:
        switch: true

opened_barrel:
    type: item
    debug: false
    material: barrel
    display name: <&color[#964b00]>Открытая бочка
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После открытия бочки
    - <red>или её уничтожения
    - <red>она станет обычной
    - <red>
    flags:
        switch: true

bloom_catalyst:
    type: item
    debug: false
    material: sculk_catalyst
    display name: <&3>Пульсирующий скалковый катализатор
    lore:
    - <red>
    - <red>ВНИМАНИЕ<&co>
    - <red>После смерти сущности рядом
    - <red>или уничтожения блока
    - <red>он станет обычным
    - <red>
    flags:
        mode: BLOOM

chest_loot:
    type: world
    debug: false
    events:
        on player places chest:
        - if <context.item_in_hand.has_flag[loot_table]>:
            - adjust <context.location> loot_table_id:<context.item_in_hand.flag[loot_table]>

fix_switch:
    type: world
    debug: false
    events:
        after player places furnace|smoker|blast_furnace|barrel|redstone_lamp:
        - if <context.item_in_hand.has_flag[switch]>:
            - modifyblock <context.location> <context.material.with[switched=true]>

fix_mode:
    type: world
    debug: false
    events:
        after player places sculk_catalyst:
        - if <context.item_in_hand.has_flag[mode]>:
            - modifyblock <context.location> <context.material.with[mode=<context.item_in_hand.flag[mode]>]>