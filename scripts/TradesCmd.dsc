trades_cmd_unblocker:
    type: item
    debug: false
    material: yellow_dye
    display name: <yellow>Разблокиратор команд
    lore:
    - <red>Нажмите <yellow>ПКМ <red>
    - <red>чтобы разблокирвоать команды
    - <red>
    - <yellow>/atm
    - <yellow>/buyer
    - <yellow>/miner
    - <yellow>/collector
    - <red>
    mechanisms:
        hides: ALL
    enchantments:
        - luck_of_the_sea:1

unblock_trades_cmd:
    type: world
    debug: false
    events:
        on player right clicks block with:trades_cmd_unblocker:
        - if <player.has_permission[gidra.open_trades]>:
            - narrate "ꐮ <red>Вы уже использовали разблокиратор команд"
            - stop
        - execute as_server "lp user <player.name> permission set gidra.open_trades true"
        - take item:trades_cmd_unblocker quantity:1
        - narrate "ꐰ <green>Теперь вы можете использовать команды <yellow>/atm, /buyer, /miner <green>и <yellow>/collector"

buyer_cmd:
    type: command
    debug: false
    name: buyer
    usage: /buyer
    description: Открывает меню Скупщика
    permission: gidra.open_trades
    script:
    - define trades <yaml[trades].read[Скупщик]||null>
    - stop if:<[trades].equals[null]>
    - opentrades <[trades].proc[generate_trades].parsed> title:Скупщик

miner_cmd:
    type: command
    debug: false
    name: miner
    usage: /miner
    description: Открывает меню Шахтёра
    permission: gidra.open_trades
    script:
    - define trades <yaml[trades].read[Шахтёр]||null>
    - stop if:<[trades].equals[null]>
    - opentrades <[trades].proc[generate_trades].parsed> title:Шахтёр

collector_cmd:
    type: command
    debug: false
    name: collector
    usage: /collector
    description: Открывает меню Коллекционера
    permission: gidra.open_trades
    script:
    - define trades <yaml[trades].read[Коллекционер]||null>
    - stop if:<[trades].equals[null]>
    - opentrades <[trades].proc[generate_trades].parsed> title:Коллекционер