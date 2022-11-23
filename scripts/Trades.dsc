# Подгрузка данных о торгах из yml файла
load_data:
    type: world
    debug: false
    events:
        on scripts loaded:
        - yaml load:/config/trades.yml id:trades

open_trades:
    type: world
    debug: false
    events:
        on player right clicks npc:
        - ratelimit <player> 5t
        - define space <yaml[trades].read[space_replacer]>
        - define trades <yaml[trades].read[<npc.name.replace[ ].with[<[space]>]>]||null>
        - stop if:<[trades].equals[null]>
        - opentrades <[trades].proc[generate_trades].parsed> title:<npc.name>