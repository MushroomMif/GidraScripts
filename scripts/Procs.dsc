# Раскрашиваем тпс для таба
colored_tps:
    type: procedure
    debug: false
    script:
    - define tps <server.recent_tps.first.round_to[2]>
    - if <[tps]> > 20:
        - define tps 20
    - if <[tps]> >= 19.9:
        - determine <green><[tps]>
    - else if <[tps]> >= 17:
        - determine <yellow><[tps]>
    - else:
        - determine <red><[tps]>

# Получаем и раскрашиваем MSPT для таба
colored_mspt:
    type: procedure
    debug: false
    script:
    - define mspt <paper.tick_times.first.in_milliseconds.round_to[1]>
    - if <[mspt]> <= 35:
        - determine <green><[mspt]>
    - else if <[mspt]> <= 50:
        - determine <yellow><[mspt]>
    - else:
        - determine <red><[mspt]>

# Раскрашиваем пинг для таба
colored_ping:
    type: procedure
    debug: false
    script:
    - define ping <player.ping>
    - if <[ping]> <= 100:
        - determine <green><[ping]>
    - else if <[ping]> <= 500:
        - determine <yellow><[ping]>
    - else:
        - determine <red><[ping]>

# Парсим tab.yml
parse_tab_element:
    type: procedure
    debug: false
    definitions: value
    script:
    - define list <yaml[tab].read[<[value]>]>
    - define text ""
    - foreach <[list]> as:value:
        - if <[value].contains_text[%end%]>:
            - define text <[text]><[value].replace_text[%end%].parse_minimessage.parsed>
        - else:
            - define text <[text]><[value].parse_minimessage.parsed><n>
    - determine <[text]>

# Получение айди кастомного предмета (если предмет не кастомный, то null)
get_custom_id:
    type: procedure
    debug: false
    definitions: item
    script:
    - define id <[item].all_raw_nbt.get[nova].get[id].replace_text[string:]||null>
    - define id null if:<[id].equals[null]>
    - determine <[id]>

generate_trades:
    type: procedure
    debug: false
    definitions: trades
    script:
    - define output ""
    - define trade_count 0
    - foreach <[trades]> as:trade:
        - define trade_count:++
        - define input1 <[trade].get[input1]>
        - define input2 <[trade].get[input2]||null>
        - define result <[trade].get[result]>
        - define output <[output]>trade[max_uses=9999;
        - define output <[output]>inputs=<[input1]>
        - define output <[output]>|<[input2]> if:!<[input2].equals[null]>
        - define output <[output]>;result=<[result]>]
        - if <[trades].size> > <[trade_count]>:
            - define output <[output]>|
    - determine <[output]>